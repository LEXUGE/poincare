#import "@preview/ctheorems:1.1.3": *

#let __axiom = thmbox("axiom", "Axiom", stroke: red + 1pt)
#let __postl = thmbox("postulate", "Postulate", stroke: red + 1pt)
#let __def = thmbox("definition", "Definition", stroke: purple + 1pt)
#let __thm = thmbox("theorem", "Theorem", fill: color.lighten(orange, 70%))
#let __eg = thmbox("example", "Example", fill: color.lighten(green, 85%), breakable: true)
#let __ex = thmbox("exercise", "Exercise", fill: color.lighten(gray, 85%), breakable: true)

  // Can also change base to be used with example
#let __sol = thmplain(
  "solution", "Solution", base: "exercise", titlefmt: smallcaps, bodyfmt: body => [
    #body #h(1fr) $square$ // float a QED symbol to the right
  ],
).with(numbering: none)

// When necessary, the base can be overriden using
// #remark(base: "lemma") for example.
#let __remark = thmplain("remark", "Remark", base: "theorem")

#let __proof = thmplain(
  "proof", "Proof", base: "theorem", titlefmt: smallcaps, bodyfmt: body => [
    #body #h(1fr) $square$ // float a QED symbol to the right
  ],
).with(numbering: none)
