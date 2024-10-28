#import "@typzk/zkgraph:0.1.0": *
#import "./thm_base.typ": *

#let mkThmNode(fn) = return (identity, desc, body, ..args) => node(identity, desc: desc, prefix: "", ..args, [#fn(desc, body)])

#let axiom = mkThmNode(__axiom)
#let postl = mkThmNode(__postl)
#let def = mkThmNode(__def)
#let thm = mkThmNode(__thm)
#let eg = mkThmNode(__eg)
#let ex = mkThmNode(__ex)
#let sol = mkThmNode(__sol)
#let remark = mkThmNode(__remark)
#let proof = mkThmNode(__proof)

#let gen_section_graph() = figure(render_graph(path: heading_to_path()), caption: [#link(label(heading_to_label()))[Section] Subgraph])

#let thm_setup(body) = {
  show: thmrules
  show heading: args => [
    // Seems like applying show rule to heading will override previous one. So we add it here to make sure we have vertial element back.
    #v(1em)
    #heading_subgraph(args) #if args.numbering != none { counter(heading).display(args.numbering) } #args.body #label(heading_to_label()) \
  ]
  body
}
