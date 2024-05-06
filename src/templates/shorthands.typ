#import "@preview/ctheorems:1.1.0": *

#let axiom = thmbox("axiom", "Axiom", stroke: red + 1pt)

#let postl = thmbox("postulate", "Postulate", stroke: red + 1pt)

#let def = thmbox("definition", "Definition", stroke: purple + 1pt)

#let thm = thmbox("theorem", "Theorem", fill: color.lighten(orange, 70%))

#let eg = thmbox("example", "Example", fill: color.lighten(green, 85%), breakable: true)

#let remark = thmplain("remark", "Remark", base: "theorem")

#let proof = thmplain(
  "proof", "Proof", base: "theorem", titlefmt: smallcaps, bodyfmt: body => [
    #body #h(1fr) $square$ // float a QED symbol to the right
  ],
).with(numbering: none)

// Override the vb in physica
#let vb(body) = $bold(upright(body))$
#let ii = sym.dotless.i
#let al = sym.angle.l
#let ar = sym.angle.r
#let cdot = sym.dot.c
#let to = sym.arrow.r
#let span = text("span")
#let img = text("Im")
#let ker = text("Ker")
#let tp = sym.times.circle
#let sendto = sym.arrow.r.bar
#let L1 = $cal(L)^1$
#let L2 = $cal(L)^2$
#let Lp = $cal(L)^p$
#let caniso = sym.tilde.equiv
#let conj(body) = $overline(body)$
#let inv(body) = $body^(-1)$
