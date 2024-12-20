#import "@typzk/zkgraph:0.1.0": *
#import "./thm_base.typ": *

#let mkThmNode(fn) = return (identity, desc, body, ..args) => node(identity, desc: desc, prefix: "", ..args, [#fn(desc, body)])

#let axiom = mkThmNode(__axiom)
#let postl = mkThmNode(__postl)
#let def = mkThmNode(__def)
#let thm = mkThmNode(__thm)
#let eg = __eg
#let ex = __ex

#let sol = __sol
#let remark = __remark
#let proof = __proof

#let gen_section_graph(s: 100%) = figure(scale(render_graph(path: heading_to_path()), s), caption: [#link(label(heading_to_label()))[Section] Subgraph])

#let thm_setup(body) = {
  show: thmrules
  show heading: args => [
    // Seems like applying show rule to heading will override previous one. So we add it here to make sure we have vertial element back.
    #v(1em)
    #heading_subgraph(args) #if args.numbering != none { counter(heading).display(args.numbering) } #args.body #label(heading_to_label()) \
  ]
  body
}
