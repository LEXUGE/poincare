// This is a preamble that should be used alongside the `simple` template. It imports commonly used packages and defines shorthands.
#import "@preview/physica:0.9.3": *
#import "@preview/gentle-clues:1.0.0": *
#import "./shorthands.typ": *
#import "./pf3.typ": *

// NOTE: Body is already evaluated at the moment we call this function. So importing stuff within setup function will not work.
#let setup(body) = {
  show: gentle-clues.with(breakable: true)
  // From the `physica` pacakge
  show: super-plus-as-dagger

  body
}
