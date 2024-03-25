#import "@preview/physica:0.9.2": *
#import "@preview/gentle-clues:0.4.0": *
#import "@lexuge/templates:0.1.0": *
#import shorthands: *
#import pf3: *

#show: simple.with(
  title: "Electromagnetism and Optics",
  authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
)
#set page(margin: (y: 1cm))

#let hl = highlight

#pagebreak()

= Overview
This notes focus currently on non-relativistic electromagnetism without
classical field theory content.

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
  And it also serves as a starting point for topics like diffraction and
  polarization
3. *Models and Applications* This includes models like transmission line, wave
  guide, and circuits.

Note nothing from classical field theory and/or relativistic treatment is
inside.

Another note to make is: unlike Newtonian mechanics, the solvability (and
uniqueness) of the Maxwell's equation is not evident. And over the course of the
derivation there could be places causing significant of mathematical subtleties.
To not obscure the physics too much, we should content with an informal
discussion on those issue.

== Mathematics Needed
For electromagnetism
- 3D vector calculus (though a proper $RR^n$ treatment is recommended)
- Basic Theory on Linear ODE and simple PDE (Laplace and wave equation)
- Strum-Liouville Theory (so Fourier Series and orthogonal polynomials)
- Ideas on distribution theory (though we will not use them extensively)

For optics
- Fourier Transform and Convolution

#pagebreak()

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

== Boundary Conditions
The boundary condition for electromagnetic field for surface charge/current
density is derived in most books.

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

  #figure(
    image("figs/boundary-condition-perpendicular.png", width: 80%),
    caption: [The setup perpendicular boundary condition for field],
  )<fig-bc-perp>

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
  the textbook: we draw thin loop and integrate and use Green's Theorem.

  #figure(
    image("figs/boundary-condition-parallel-loop1.png", width: 80%),
    caption: [The loop 1 of setup for parallel boundary condition for field],
  )<fig-bc-para-loop1>

  Assuming the surface current density $vb(K)$ and field $vb(B)_(1,2)$ are uniform
  in their regions.

  For the first loop, we take the normal of the loop area parallel to $vb(K)$ (see
  @fig-bc-para-loop1) at the point of our interest. By integrating $curl vb(B) = mu_0 vb(J) + mu_0 epsilon_0 pdv(vb(E), t)$ and
  use green's theorem along the loop
  $ vb(hat(K)) cdot mu_0 l vb(K) &= l vb(B)_1 cdot (hat(vb(K)) times vb(hat(n))_1) + l vb(B)_2 cdot (hat(vb(K)) times vb(hat(n))_2) \
                               &= l hat(vb(K)) cdot (vb(hat(n))_1 times vb(B)_1 + vb(hat(n))_2 times vb(B)_2) $

  where we have assumed that as the loop gets squashed onto the surface, $pdv(vb(E), t)$ is
  not "localized" and is bounded so it vanishes under limit. Equivalently, we have
  $ vb(hat(K)) cdot mu_0 vb(K) &= hat(vb(K)) cdot (vb(hat(n))_1 times vb(B)_1 + vb(hat(n))_2 times vb(B)_2) $

  #figure(
    image("figs/boundary-condition-parallel-loop2.png", width: 80%),
    caption: [The loop 2 of setup for parallel boundary condition for field],
  )<fig-bc-para-loop2>
  If we choose another loop (see @fig-bc-para-loop2) and integrate on that, we get
  $ 0 &= vb(hat(K)_perp) cdot mu_0 vb(K) \
    &= l vb(B)_1 cdot (vb(hat(K))_perp times vb(hat(n))_1) + l vb(B)_2 cdot (vb(hat(K))_perp times vb(hat(n))_2) \
    &= vb(hat(K))_perp cdot (vb(hat(n))_1 times vb(B)_1 + vb(hat(n))_2 times vb(B)_2) $

  So we got the components of $vb(hat(n))_1 times vb(B)_1 + vb(hat(n))_2 times vb(B)_2$ in
  the tangent plane:

  $ vb(hat(K))      &: mu_0 vb(K) \
  vb(hat(K))_perp &: 0 $
  So we have
  $ vb(hat(n))_1 times vb(B)_1 + vb(hat(n))_2 times vb(B)_2 = mu_0 vb(K) $

  For $vb(E)$ the analysis is similar, however, it is _assumed_ that $pdv(vb(B), t)$ is
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
  Or symmetrically,
  $ vb(B)_2 - vb(B)_1 = mu_0 vb(K) times vb(hat(n))_2 $
]

#remark[As exemplified in @fig-bc-para-loop1, *this is a vector difference* across the
  boundary.]

#caution[
  There are two intricacies/deficiencies for @micro-boundary-condition-perp and
  @micro-boundary-condition-para:
  1. We are assuming the field and current/charge density are uniform. This means the
    field should be at least continuous in the 3D region of consideration. And the
    current/charge density should be continuous within the 2D sheet.
  2. We are assuming the time derivatives are bounded so we could throw out some
    integral terms under limit.
]

#idea[
  @micro-boundary-condition-para and @micro-boundary-condition-perp are quite
  general. As long as the surface is not moving and time-derivative of fields are
  bounded, the proof is valid. *This means it also applies to wave boundary
  condition* (as long as the field is not creating "localized" time-derivative).
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
  2. from $curl vb(A) = vb(B)$ and if we assume $vb(B)$ is not "localized" (i.e. not
    like dirac delta), then we get parallel component being continuous (using
    similar reasoning as @micro-boundary-condition-para).
]

== Field Energy, Momentum, and Pressure
#hl[usual derivation omitted for now.]

== (Plane) Wave Solution
_The usual derivation for plane wave solution for Maxwell equation is omitted._

One thing in particular to notice is how derivatives are translated into simple
algebraic equations. If we write the solution in complex form,
$ vb(E) = vb(E)_0 exp(i(vb(k) cdot vb(r) - omega t)) $
where $vb(E)_0, vb(k)$ can be complex vectors, then we can just identify $nabla$ as $i vb(k)$.
So $div vb(E) = i vb(k) cdot vb(E)$, and $curl vb(E) = i vb(k) times vb(E)$.#footnote[Although this looks like one of the Fourier Transform's identity but this is
  just a coincidence as $vb(E)$ stays as $vb(E)$ not Fourier transform of $vb(E)$.]

/*#remark[I don't think we will usually complexify $omega$ cause that makes wave
  disappear/blow up as time goes on, which is not we are looking for? *What are we
  looking for exactly?*]*/

#warning[
  Complex solution is just a sufficient form that works nicely with derivatives
  and cancellation (as phase shifts are incorporated as multiplication). However,
  sufficiency is not equivalence. For reflection and refraction problem, we need
  to keep the sign of $omega t$ for both left and right traveling wave the same
  (so we could extract out the common $exp(i omega t)$). So you should either use
  $ exp(i(vb(k) cdot vb(r) - omega t)), exp(-i(vb(k) cdot vb(r) + omega t)) $
  or
  $ exp(i(omega t -vb(k) cdot vb(r))), exp(i(omega t + vb(k) cdot vb(r))) $
  The first one is preferable. #hl[Why?]
]

== Multipole Expansion, Electric and Magnetic Dipole
A flipped way of looking at this issue is to think multiple expansion being
general (e.g. having a charge distribution/current density distribution, we can
always do multipole expansion). And dipoles are just the _dipole term_ of limit
of certain object. And we idealize them as being real object.

#hl[Omitted for now]

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
- Instead, we model each atom (Lorentz model. See also
  @dielectric-basic-atomic-model) as a dipole (thus neglecting higher order
  expansions). This local approach of model turns out to be adequate in our cases.

The same reasoning could be used for magnetic material. Except this time the
classical model that gives rise to these local magnetic dipole moment doesn't
seem to be obvious (but that's fine, classical electromagnetism is not supposed
to give accurate explanation of microscopic strucuture). #hl[We may think of spin?]

#hl[Omitted for now]

The macroscopic Maxwell equation is
$
  div vb(D)  & = rho_f \
  div vb(B)  &= 0 \
  curl vb(E) &= - pdv(vb(B), t)\
  curl vb(H) &= vb(J)_f + pdv(vb(D), t)
$
with constitutive equation
$ vb(D) &= epsilon_0 vb(E) + vb(P) \
vb(B) &= mu_0 (vb(H) + vb(M)) $

== Dielectrics
== Plasma

= Optics
Before we dive into specific applications like== Fresnel Equation

#pagebreak()

#bibliography("./bib.yml", style: "ieee")
