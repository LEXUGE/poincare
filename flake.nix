{
  description = "Project Poincaré";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    typst2nix = {
      url = "github:LEXUGE/typst2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    typzk = {
      url = "github:LEXUGE/typzk";
      inputs.typst2nix.follows = "typst2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, utils, typst2nix, typzk, pre-commit-hooks }:
    with utils.lib;
    with nixpkgs.lib;
    with typst2nix.helpers;
    with builtins;
    eachSystem defaultSystems
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              typst2nix.overlays.default
              typst2nix.overlays.utils
              typzk.overlays.default
              self.overlays.default
            ];
          };

          pathToName = path: (replaceStrings [ "/" ] [ "+" ] path);
          pathToRelative = level: path:
            strings.concatStrings (strings.intersperse "/"
              (lists.drop level (splitString "/" (toString path))));

          listTypstRecursive = dir:
            let
              filtered = listToAttrs (filter ({ name, value }: value == "directory") (attrsToList (readDir dir)));
            in
            (flatten (mapAttrsToList
              (name: type:
                let
                  path = dir + "/${name}";
                in
                if pathExists (path + "/main.typ") then
                  [ (nameValuePair (pathToName (pathToRelative 5 path)) path) ]
                else
                  listTypstRecursive path)
              filtered));
        in
        rec {
          # nix develop
          devShells.default = pkgs.mkShell {
            inherit (self.checks.${system}.pre-commit-check) shellHook;
            nativeBuildInputs = [ (mkWrappedTypst pkgs ./src) ];
          };

          checks = {
            pre-commit-check = pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                nixpkgs-fmt.enable = true;

                shellcheck.enable = true;
                shfmt.enable = true;

                # typstfmt = mkForce {
                #   enable = true;
                #   name = "Typst Format";
                #   entry = "${pkgs.typstfmt}/bin/typstfmt";
                #   files = "\\.(typ)$";
                #   excludes = [ "CO25/main.typ" ];
                # };
              };
            };
          } // packages;

          packages = attrsets.mapAttrs
            (n: p: (buildTypstDoc rec {
              inherit pkgs;
              # project root
              src = p;
              path = "main.typ";
              version = "git";
              pname = n;
            }))
            (listToAttrs ((listTypstRecursive ./src/notes) ++ (listTypstRecursive ./src/reports) ++ (listTypstRecursive ./src/slides)));
        }) // {
      overlays.default = (final: prev: {
        typst2nix.registery = recursiveUpdate (prev.typst2nix.registery or { }) {
          lexuge.templates."0.1.0" = bundleTypstPkg
            {
              pkgs = final;
              path = ./src/templates;
              namespace = "lexuge";
            };
        };
      }
      );
    };
}
