#import "@preview/ctheorems:1.1.0": *

#let simple(title: "", authors: (), disp_content: true, body) = {
  // Set document metadata
  set document(author: authors.map(x => x.name), title: title)
  show: thmrules
  // Number the headings
  set heading(numbering: "1.1.")
  // Break the word at the end of each line
  set par(justify: true)

  // Make some vertical spacing for headings
  show heading: it => [
    #v(1em)
    #it
  ]

  // Start title and author section
  align(
    center,
  )[
    #block(text(weight: 700, 1.75em, title))
    #v(2em)

    // Display authors
    #let count = authors.len()
    #let ncols = calc.min(count, 3)
    #grid(columns: (1fr,) * ncols, row-gutter: 24pt, ..authors.map(author => [
      #author.name \
      #link("mailto:" + author.email)
    ]))
  ]

  if disp_content { outline(fill: none, indent: true) }

  set math.equation(numbering: "(1.1)")

  body
}
