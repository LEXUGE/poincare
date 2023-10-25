{
  description = "Project Poincaré";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    fltex = {
      url = "github:flibrary/FLTeX";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils.url = "github:numtide/flake-utils";
    texutils.url = "github:Ninlives/texutils.nix";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, utils, texutils, fltex, pre-commit-hooks }:
    with utils.lib;
    with nixpkgs.lib;
    with builtins;
    eachSystem defaultSystems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        mkTexEnv = path:
          texutils.lib.callTex2Nix {
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ fltex.overlays.default ];
            };
            srcs = builtins.filter
              (p:
                hasSuffix ".tex" p || hasSuffix ".cls" p || hasSuffix ".sty" p)
              (nixpkgs.lib.filesystem.listFilesRecursive ./${
                path});
            # In case some dependencies fails to be detected
            extraTexPackages = { inherit (texlive) ctex latex-bin latexmk collection-fontsrecommended tikzfill chinese-jfm; };
          };

        pathToName = path: (replaceStrings [ "/" ] [ "+" ] path);
        pathToRelative = level: path:
          strings.concatStrings (strings.intersperse "/"
            (lists.drop level (splitString "/" (toString path))));

        listTexRecursive = dir:
          (flatten (mapAttrsToList
            (name: type:
              let path = dir + "/${name}";
              in
              if type == "directory" then
                if pathExists (path + "/main.tex") then
                  [
                    (nameValuePair (pathToName (pathToRelative 5 path))
                      (pathToRelative 4 path))
                  ]
                else
                  listTexRecursive path
              else
                [ ])
            (readDir dir)));

        mkTexPkg = path:
          pkgs.stdenvNoCC.mkDerivation rec {
            name = (pathToName (pathToRelative 1 path));
            src = self;
            # We need to make TeX env for both the doc and resources
            buildInputs = [ pkgs.coreutils (mkTexEnv path) ];
            phases = [ "unpackPhase" "buildPhase" "installPhase" ];
            buildPhase = ''
              export PATH="${makeBinPath buildInputs}";
              mkdir -p .cache/texmf-var
              cd ${path}
              env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
                SOURCE_DATE_EPOCH=${toString self.lastModified} \
                latexmk -bibtex -interaction=nonstopmode -pdf -lualatex \
                main.tex
            '';
            installPhase = ''
              mkdir -p $out
              cp main.pdf $out/${name}.pdf
            '';
          };
      in
      rec {
        # nix develop
        devShells.default = pkgs.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          # Got to workaround the problem with ./. when it comes to /${path}
          nativeBuildInputs = [ pkgs.coreutils (mkTexEnv "") ];
        };

        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixpkgs-fmt.enable = true;
              shellcheck.enable = true;
              shfmt.enable = true;
            };
          };
        };

        packages = attrsets.mapAttrs (name: path: (mkTexPkg path))
          (listToAttrs (listTexRecursive ./src));
      });
}
