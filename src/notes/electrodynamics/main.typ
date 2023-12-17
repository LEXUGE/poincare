#import "@lexuge/templates:0.1.0": *
#import "@lexuge/dirac:0.1.0": *
#import "@preview/physica:0.9.0": *

#show: simple.with(
  title: "Classical Electrodynamics",
  authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
)

#dirac_implicit_defns

#register()

// Override the vb in physica
#let vb(body) = $bold(upright(body))$

= Notations
We use #defn($vb(E)$), #defn($vb(B)$) as electric and magnetic fields. #defn($vb(D)$), #defn($vb(H)$) are
only auxiliary fields.

= Some General Words
I feel that classical electrodynamics is a particularly rich subject, for that
it has some nontrivial mathematics for rigorous formulation, good amount of
physical structure, and various non-trivial applications.

== Some Overview of the Physics
For electrostatics or magnetostatics, the main physics are how macroscopic
fields (_not_ auxiliary fields $vb(D)$ or $vb(H)$!) and macroscopic charge and
current distributions emerge, and how auxiliary fields emerge.

== Mathematics
Unfortunately, I don't have enough mathematical background to formulate this
notes in any rigorous way. The correct mathematical setting (I believe) should
be calculus on distributions on $RR^3$.

The reason I believed so is due to two issues that long plagued me:
- *Why does $div vb(B) = 0 => vb(B) = curl vb(A)$ for some #defn($vb(A)$)?* This
  is only sufficient#footnote[Using Poincare's lemma] in some good topology#footnote[For example, domain of $vb(B)$ should be simply connected].
  Similarly books _often invoke_ $curl vb(E) = vb(0) => vb(E) = - grad phi$ for
  some #defn($phi$). However, if we work with

#bibliography("./bib.yml", style: "american-physics-society")
