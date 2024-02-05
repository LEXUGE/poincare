#import "@preview/physica:0.9.0": *
#import "@preview/gentle-clues:0.4.0": *
#import "@preview/ctheorems:1.1.0": *
#import "@lexuge/templates:0.1.0": *

#show: simple.with(
  title: "Electrodynamics",
  authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
)

#let def = thmbox("definition", "Definition", stroke: purple + 1pt)

#let thm = thmbox("theorem", "Theorem", fill: color.lighten(orange, 70%))

#let proof = thmplain(
  "proof",
  "Proof",
  base: "theorem",
  titlefmt: smallcaps,
  bodyfmt: body => [
    #body #h(1fr) $square$ // float a QED symbol to the right
  ],
).with(numbering: none)

#let remark = thmplain("remark", "Remark", base: "heading")

// Override the vb in physica
#let vb(body) = $bold(upright(body))$
#let ii = sym.dotless.i
#let al = sym.angle.l
#let ar = sym.angle.r
#let cdot = sym.dot.c
#let to = sym.arrow.r
#let hl = highlight

#pagebreak()

= Overview
This notes focus currently on non-relativistic electrodynamics without advanced
topics like radiation energy.

From my understanding, content mainly consists of three parts:
1. *Microscopic Theory* This includes Maxwell's equation in vacuum, boundary
  conditions of Maxwell's equation, solving Maxwell's equation in static cases
  (gauge and Poisson equation), and the interpretation of electromagnetic fields
  as having energy and momentum. The wave solution#footnote[Though it's more interesting when we study it in matters] of
  Maxwell's equation and a relativistic treatment should also fit in here.
2. *Macroscopic Theory* This includes auxiliary fields like $vb(D), vb(H)$ and wave
  solution to Maxwell's equation in linear dielectrics, ohmnic conductors, and
  (collisionless cold) plasma. It gradually shifts to more interesting
  applications to optics including Fresnel's equation and Brewster angle#footnote[needed to understand your CPL lens on your camera].
3. *Models and Applications* This includes models like transmission line, wave
  guide, and circuits.

Of course, a lot of topics are missing from above, one important example is the
electromagnetic radiation.

Another note to make is: unlike Newtonian mechanics, the solvability (and
uniqueness) of the Maxwell's equation is not evident. I have not got enough
mathematical expertise to really confidently deal with these issues. However, I
believe this is not an excuse to not address them, even if I cannot really
tackle them completely. In the notes, I will try my best to raise and reason
these issues (though of course my answers can be wrong). And I believe an
eventual careful and rigorous treatment is a must.

== Mathematics Needed
- 3D vector calculus (though a proper $RR^n$ treatment is recommended)
- Basic Theory on Linear ODE and simple PDE (Laplace and wave equation)
- Strum-Liouville Theory (so Fourier Series and orthogonal polynomials)
- Ideas on distribution theory (though we will not use them extensively)

= Microscopic Theory
#def(
  "Microscopic Maxwell's equation",
)[
  In vacuum,
  $ div vb(E)  &= rho/epsilon_0 \
  div vb(B)  &= 0 \
  curl vb(E) &= -pdv(vb(B), t) \
  curl vb(B) &= mu_0 vb(J) + mu_0 epsilon_0 pdv(vb(E), t) $
  Charge density $rho$ and current density $vb(J)$ are called source terms.
  Electrodynamics is a field theory, source term "creates" field and field governs
  sources' dynamics. $vb(E), vb(B), rho, vb(J)$ should all be thought as
  distributions.
]

#info[_Strictly speaking, Maxwell's equation needs to be solved self-consistently_ (i.e.
  source and fields have to satisfy Maxwell's equation at the same time). However,
  in most time, we make approximations and idealized assumptions (e.g. when
  solving "long" solenoids) which are good enough to yield physical insight but
  strictly speaking violating Maxwell's equations.]

#question[*Notes to myself:* is there some boundary condition needed for Maxwell's
  equation in general? Like in infinite free space? Where does the usual "decaying"
  boundary condition come from?

  I think no. Maxwell's equation itself doesn't imply any boundary condition. And
  we get decaying property because it's physical to have locality (?), and we
  require so to derive the Green's function for infinite space Poisson equation.

  And sometimes we indeed drop this decaying property for example in studying
  plane wave solution, though clearly such solution is not physical. So I would
  peer to think Maxwell's equation doesn't have boundary condition on its own in
  general in gen.]

One reason that we should really think of fields and sources as distributions is
we later will invoke Poincare's lemma to deduce potentials. If they are not
defined as distributions, then even for point charge we will have
non-simply-connected domain for $vb(E)$ which violates the condition for
Poincare's lemma. This would be very unsatisfying.

For this reason, _though I have not enough rigorous experience with distributions and PDEs_,
I believe if we think of them as distributions then their domains#footnote[Though then they will be functionals living in different spaces than ordinary
  functions] will become "nice" and somewhat advanced Poincare's lemma could
apply. And our later analysis (which uses Poincare's lemma anyway) is then
roughly sound.

For a more detailed discussion on distribution as solution for Maxwell's
equation, see @poincare-lemma-and-distribution.

Though noted this issue, I will take a physics approach here cause I don't have
the machinery of PDE in functional space now. And it's good enough for our use
indeed.

== Boundary Conditions
The boundary condition for electromagnetic field for surface charge/current
density is derived in most books. I shall not reproduce them.

#hl[However, two aspects render them unsatisfying:
  1. They are based on analysis on "infinite charge/current sheet" instead of
    directly attacking some general (but nice enough) surface.
  2. Each derivation assumes fields are bounded when we have such 2D sources
    (otherwise certain parts of the surface/contour integral will not vanish under
    limit). However, no insightful general reason has been provided.#footnote[One incomplete argument is that if $vb(E)$ is very bad (dirac delta), then the
      charge distribution will be akin to derivative of dirac delta which is
      unphysical (e.g. when integrated with bump function we get 0 total charge). _However_,
      this still doesn't explain why $vb(E)$, or flux, would be bounded.]
]

These conceptually hard issue aside, here is the usual boundary condition for
charge/current sheet.
#hl[What is really the condition for electrostatics? Clearly having stationary $rho$ is
  inadequate: plane wave equation has $rho=0$ everywhere and clearly is not "static".]
#thm(
  "Boundary Condition Perpendicular",
)[
  At a surface, let $vb(hat(n))_1, vb(hat(n))_2$ be outward surface normal on
  different sides, let $vb(E)_1, vb(E)_2$ be fields on different sides then
  $
    vb(hat(n))_1 cdot vb(E)_1 + vb(hat(n))_2 cdot vb(E)_2 = sigma/epsilon_0
  $
  or equivalently,
  $ vb(hat(n))_1 cdot (vb(E)_1 - vb(E)_2) = sigma/epsilon_0 \
  vb(hat(n))_2 cdot (vb(E)_2 - vb(E)_1) = sigma/epsilon_0 $

  For the magnetic field, we have
  $ vb(hat(n))_1 cdot vb(B)_1 + vb(hat(n))_2 cdot vb(B)_2 = 0 $
]<micro-boundary-condition-perp>
#proof[This is the usual "pill-box" argument.]

#thm(
  "Boundary Condition Parallel",
)[
  At a surface, let $vb(hat(n))_1, vb(hat(n))_2$ be outward surface normal on
  different sides, let $vb(E)_1, vb(E)_2, vb(B)_1, vb(B)_2$ be fields on different
  sides then
  $ vb(hat(n))_1 times vb(E)_1 + vb(hat(n))_2 times vb(E)_2 = 0 $
  and
  $ vb(hat(n))_1 times vb(B)_1 + vb(hat(n))_2 times vb(B)_2 = mu_0 vb(K) $
  where $vb(K)$ is the surface current density.
]<micro-boundary-condition-para>
#proof[
  The method of "proof" is similar for both fields. The core idea is the same as
  the textbook: we draw thin loop and integrate and use Green's Theorem. *Figures
  will be ideal*.

  For the first loop, we take the normal of the loop area parallel to $vb(K)$ at
  the point of our interest. This gives
  $ vb(hat(K)) cdot mu_0 vb(K) &= vb(B)_1 cdot (vb(K) times vb(hat(n))_1) + vb(B)_2 cdot (vb(K) times vb(hat(n))_2) \
                             &= vb(K) cdot (vb(hat(n))_1 times vb(B)_1 + vb(hat(n))_2 times vb(B)_2) $
  And we also have (if we rotate the integration loop 90 degree)
  $ 0 &= vb(hat(K)_perp) cdot mu_0 vb(K) \
    &= vb(B)_1 cdot (vb(K)_perp times vb(hat(n))_1) + vb(B)_2 cdot (vb(K)_perp times vb(hat(n))_2) \
    &= vb(K)_perp cdot (vb(hat(n))_1 times vb(B)_1 + vb(hat(n))_2 times vb(B)_2) $

  So we got the component of $vb(hat(n))_1 times vb(B)_1 + vb(hat(n))_2 times vb(B)_2$ in
  the tangent plane. Evidently,
  $ vb(hat(n))_1 times vb(B)_1 + vb(hat(n))_2 times vb(B)_2 = mu_0 vb(K) $

  For $vb(E)$ the analysis is similar, however, it is _assumed_ #footnote[again, as before, I have no good justification] that $pdv(vb(B), t)$ is
  bounded and thus it's surface integral, unlike $vb(K)$ which is a dirac delta,
  will vanish#footnote[Indeed, the displacement term $pdv(vb(E), t)$ doesn't appear in the magnetic
    boundary condition for the same reason] as we decrease the integration loop.
  Thus $vb(hat(n))_1 times vb(E)_1 + vb(hat(n))_2 times vb(E)_2 = 0$.
]

#remark[Note the unit of above expressions don't match. And these expressions are valid
  as long as the surface don't move. In particular, they are valid even when we
  are not dealing with electrostatics/magnetostatics.]

#remark[Since $vb(hat(n))_1 times (vb(hat(n))_1 times vb(v)) = -vb(v)$, we can also
  write
  $ vb(B)_1 - vb(B)_2 = mu_0 vb(K) times vb(hat(n))_1 $
]

== Potential and Gauge Transformation

#hl[Usual derivation omitted for now]

=== Boundary Condition for Potentials
Potentials are even more regular than fields. Indeed, I _suspect_ such a "regularity
hierarchy":
$ phi, vb(A) gt.curly vb(E), vb(B) gt.curly rho, vb(J) $
where $gt.curly$ means "more regular than". The reason being "derivative" of
potential gives rise to fields whose derivative gives rise to sources. And
integration "smoothes" things out (think of fundamental theorem of calculus).

And they are continuous across surface boundary.

#info[An easy reasoning for the particular case of Coulomb gauge ($div vb(A) = 0$) is:
  1. from $div vb(A) = 0$ we get the perpendicular component is continuous (using
    similar reasoning as @micro-boundary-condition-perp)
  2. from $curl vb(A) = vb(B)$ and if we assume $vb(B)$ is not "singular" (i.e. not
    like dirac delta), then we get parallel component being continuous (using
    similar reasoning as @micro-boundary-condition-para).
]

== Field Energy and Momentum
#hl[usual derivation omitted for now.]

== (Plane) Wave Solution
#hl[standard material omitted for now.]

One thing in particular to notice is how derivatives are translated into simple
algebraic equations. If we write the solution in complex form,
$ vb(E) = vb(E)_0 exp(i(vb(k) cdot vb(r) - omega t)) $
where $vb(E)_0, vb(k)$ can be complex vectors, then we can just identify $nabla$ as $i vb(k)$.
So $div vb(E) = i vb(k) cdot vb(E)$, and $curl vb(E) = i vb(k) times vb(E)$.#footnote[This could be better explained by Fourier transform?]

#remark[I don't think we will usually complexify $omega$ cause that makes wave
  disappear/blow up as time goes on, which is not we are looking for? *What are we
  looking for exactly?*]

#warning[
  Complex solution is just a sufficient form that works nicely with derivatives
  and cancellation (as phase shifts are incorporated as multiplication). However,
  sufficiency is not equivalence. For reflection and refraction problem, we need
  to keep the sign of $omega t$ for both left and right traveling wave the same.
  So you should either use
  $ exp(i(vb(k) cdot vb(r) - omega t)), exp(-i(vb(k) cdot vb(r) + omega t)) $
  or
  $ exp(i(omega t -vb(k) cdot vb(r))), exp(i(omega t + vb(k) cdot vb(r))) $
  The first one is preferable because for a positive phase difference $phi$, to
  hold the phase $phi - omega t' = -omega t$, we would have a bigger $t'$. And
  this means the usual convention that "bigger phase, more advance in time" will
  be maintained. The second convention will have everything the other way around.
]

== Multipole Expansion

= Macroscopic Theory
We model the macroscopic matters like dielectrics with dipoles. I think this is
at least a reasonable model because:
- The dielectrics doesn't carry net charge. And dipole moment will give
  first-order correction.
- Modeling entire matter using a single dipole moment would be a bad choice. I
  suspect this is because such _global_ first-order correction will give huge
  error bound, and it also doesn't allow us to discuss meaningfully the spatial
  variation of $vb(E), vb(B)$ inside the material. Latter is what we want to
  indeed, as we do in poking dielectrics with plane wave solutions.
- Instead, we model each atom (#hl[really? is it really atom?] yes, at least in
  Lorentz model. See also @dielectric-basic-atomic-model) as a dipole (thus
  neglecting higher order expansions). This local approach of model turns out to
  be adequate in our cases.

The same reasoning could be used for magnetic material. #hl[Except this time the classical model that gives rise to these local magnetic
  dipole moment doesn't seem to be obvious? The best classical model we could use
  is probably the motion of electron in atomic orbit.]

#pagebreak()

#bibliography("./bib.yml", style: "ieee")
