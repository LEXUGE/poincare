#import "@preview/physica:0.9.2": *
#import "@preview/gentle-clues:0.4.0": *
#import "@lexuge/templates:0.1.0": *
#import shorthands: *
#import pf3: *

#show: simple.with(
  title: "Statistical Mechanics, Thermodynamics, and Kinetic Theory",
  authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
)
#set page(margin: (y: 1cm))

#let op(body) = $hat(body)$
#let adia = sym.lt.curly

= Introduction
As a word of caution, my personal take is that the theory of statistical
thermodynamics is not complete. The theory is at least partially
phenomenological so it would inevitably contain some "leap of faith" and "arguments
over proofs".

And a second observation is statistical mechanics is not a complete replacement
of thermodynamics. The most prominent contribution is actually to connect
thermodynamics paradigm with microscopic theory (i.e. quantum theory) to give
entropy (and thus all thermodynamics). It actually doesn't justify the second
law#footnote[However, wikipedia's page on quantum $H$-theorem seems to say the otherwise.
  Check back later!] nor does it answer why "maximizing entropy under
constraint" works. Thus, in order for statistical mechanics work, we still need
to have a firm understanding of thermodynamics.

Our construction of theory will be:
- Acknowledge the existence of entropy for thermodynamic systems using statistical
  mechanics.
- Declare that some systems are thermodynamic and their ability to come to
  equilibrium. Define first law, second law, and quasi-static process.
- Derive various stability argument, different thermodynamic potential and their
  interpretation.

It should be stressed again, statistical mechanics only characterizes
thermodynamic systems, it is silent on how multiple thermodynamic system
interact (or interact with non-thermal system). For that, you are essentially
using thermodynamics.

Kinetic Theory is an alternative (and more classical) approach to understanding
how a specific type of thermodynamic system -- _gas_ (or fluid probably, which
we will not cover) can be understood by purely classical mechanical means.

= Entropy and Equilibrium
Assume we are happy about quantum mechanics (including density matrix and von
Neumann equation for evolution). Then we define the von Neumann entropy

#def[(von Neumann) entropy][
  For a quantum system of Hamiltonian $hat(H)$ and density matrix $hat(rho)$, its
  entropy is defined as
  $ S = - k_B Tr(hat(rho) ln(hat(rho))) $
  This is a very general definition and doesn't cite anything about
  thermodynamics.
]

(Non-pure) density matrix arises by entanglement essentially.

#eg[Entropy evolution of spin-1/2 system under a magnetic field][
  Consider a localized (i.e. no spatial degree of freedom) spin-$1/2$ electron
  under some magnetic field. Let the resultant Hamiltonian be
  $ op(H) = op(S_z) + op(S_x) $

  By von-Neumann equation,
  $ ii hbar pdv(op(rho), t) = [op(H), op(rho)] $

  Use $op(S_z)$ eigenbasis, and set the matrix representation $op(rho)$ under this
  basis as
  $ [op(rho)] = mat(a, conj(c);c, 1-a) $

  The Hamiltonian's matrix representation is
  $ [op(H)] = hbar / 2 mat(1, 1;1, -1) $
  And the von-Neumann equation is
  $ dv(, t) mat(a, conj(c);c, b) = -ii mat(c - conj(c), 2conj(c) -2a + 1;2a - 2c - 1, conj(c) - c) $

  Let $c = m + ii n, m, n in RR$. From here we have
  $ dv(a, t) &= n \
  dv(c, t) &= - ii (a - c) + 1/2 ii $
  Differentiate the second equation we get
  $ dv(c, t, 2) &= - ii ( dv(a, t) - dv(c, t)) \
  dv(c, t, 2) &= - ii ( n - dv(m, t) - ii dv(n, t)) $
  Take the imaginary and real part of this equation separately,
  $ dv(m, t, 2) &= - dv(n, t) \
  dv(n, t, 2) &= -n + dv(m, t) $
  Since we only care about some special solution, let's take $dv(m, t) = - n$ and
  then
  $ dv(n, t, 2) &= -2 n $
  Again take the special solution $n = cos(2 t) $, so $m = -1/2 sin(2t)$
  Then we get
  $ c &= m + ii n = -1/2 sin(2t) + ii cos(2t) \
  a &= 1/2 sin(2t) $
  This means $b = 1 - 1/2 sin(2t)$ and
  $ p_1 p_2 = lambda_1 lambda_2 = a b = 1/2 sin(2t) - 1/4 sin^2(2t) $
  which implies time-dependent $p_1, p_2$ and a time dependent (also periodic
  indeed) von-Neumann entropy.
]<heisenberg-non-thermal>

Of course in the reality the precession of spin would lead to radiation and less
energy and finally alignment of spin with the field which gives zero entropy at
the end.

The purpose of @heisenberg-non-thermal is to give a simplified (or idealized)
model which doesn't "thermalize" over time.

#info[
  @heisenberg-non-thermal has another detail worth pointing out. The physical
  situation is that we have a constant magnetic field along the bisector of $x$ and $z$ axis.

  This example wouldn't work if we let field point along $z$ and use eigenbasis of $op(S_z)$ to
  represent operators. Because any pure state's evolution would be rotation of
  spin vector around the $z$ axis (spin precession) which keeps the projection of
  the spin onto $z$-axis constant. Therefore, any classical superposition (what
  density matrix essentially is) would also remain the same.

  In general this happens always if we choose basis direction the same as field.
]

For certain other systems, the entropy will settle as it evolves given the time.
Such behavior is thermal.

What we are essentially going to do is to postulate that there are certain
systems that behave "thermodynamically". The exact reason why certain systems
emerge such thermodynamic behavior is beyond our scope#footnote[Despite ergodicity and a lot of alternative theories (including Jayne's entropy
  maximization), I am not convinced that we have a definite answer.].

#def[Thermodynamic System and Equilibrium][
  We can only speak of equilibrium for thermodynamic system.

  Equilibrium is when the entropy of the system becomes constant under some
  constraints#footnote[Later we will have a precise formulation of what are valid constraints. Valid
    constraints must be the expectation value of some observable $hat(O)$ such that $[hat(O), hat(H)] = 0$.].

  A thermodynamic system (or equivalently, a thermal system) is a system always
  comes to equilibrium after sufficient time irrespective of initial conditions
  but under some constraints.
]<thermal-system-and-equilibrium>

#info[A quantum system can have many different density matrices that all satisfies the
  same constraints. In the example of ideal gas, this means different density
  matrices can satisfy the same constraints on $U, V, N$.

  As the system evolves, by definition of thermal system, $S$ settles. So for the
  given constraints (e.g. $U, V, N$), we have an equilibrium entropy $S$. And all
  other macroscopic variables (e.g. temperature and pressure) are actually defined
  by this $S(V, U, N)$ correspondence.

  If we only care about macroscopic properties of the thermal system at
  equilibrium, then for any equilibrium state $X$, we can label it with $U_X, V_X, N_X$ so
  we have the entropy through $S(U_X,V_X,N_X)$ and all other macroscopic
  properties.]

Not everything is a thermodynamic system! The @heisenberg-non-thermal is an
example of a quantum system with a periodic varying von Neumann entropy. It
never settles under evolution. As defined by @thermal-system-and-equilibrium, we
propose#footnote[Should thermodynamics really have a quantum/microscopic origin, we should not
  actually expect a sharp criterion on what's thermal and what's not.] our world
can be separated into things that are thermal and things that are not.

Notice also under our framework, _we cannot prove whether a system is thermal._ But
our intuition tells we know what thermal system means. For example, a glass of
water is thermal, no matter how you stir it first#footnote[ignore the heating due to vicious flow when you stir it so the water doesn't
  heat up.], it comes back still with the same macroscopic properties.

== Maximum Entropy Principle

To find entropy, we adopt the following postulate
#postl[Maximum Entropy Principle][For a thermal system under equilibrium, the entropy is maximized such that
  - $op(rho)$ corresponding to the maximum $S(op(rho))$ satisfies $[op(rho), op(H)] = 0$.
  - constraints of expectation value of conserved quantities (i.e. the operators $[op(O), op(H)] = 0$)
    are satisfied]<mep>

#info[
  The first requirement seems unnatural. A usual motivation is such commuting $op(rho)$ doesn't
  evolve under von-Neumann equation. Thus it gives a sufficient condition for a
  constant entropy.

  If we want it to be a necessary condition, consider the following sketch of a
  possible argument. Notice although it's possible for multiple $op(rho)$ to give
  the same $S$, if we are in some _nice_ local maximum/minimum that has a
  neighborhood free of other local extremums, then we expect $op(rho)$ cannot
  evolve continuously to other local extrmums while keeping $S$ extremized.

  In other words, _we expect_ if local extremums are isolated then evolving
  density matrix should be prohibited. Thus under _good simple cases_, a commuting $op(rho)$ should
  be required.
]

To use @mep, there are mainly two ways:
- Lagrange Multiplier
- State Counting
They are essentially from the same principle. The second one can be exactly
derived from the first one. The first one could also be derived from the second,
but requires _several little fudges_.

Before we start, let's fix some notation which we shall use throughout the note.

We would need to label energy eigenstates. Let ${op(O)_i}$ be some (finite
number of) mutually commuting operators that also commute with Hamiltonian. Then
in the simultaneous eigenbasis of all those operators, each eigenstate $ket(E)$ can
be labeled using a tuple
$ alpha = (E, O_1, O_2, dots) $
where $O_i$ are eigenvalues of $op(O)_i$ for state $ket(E)$.

When we write $sum_alpha$ it means to permute over all values of $O_i$, so
$ sum_alpha equiv sum_O_1 sum_O_2 dots.c $

Let $p_alpha$ be the eigenvalue of $op(rho)$ corresponding to the eigenstate
(labeled by) $alpha$, then we have entropy

$ S = -k_B sum_alpha p_alpha ln p_alpha $

And $ expval(op(O)_i) = sum_alpha p_alpha O_i $
is also a valid notation if we expand out $sum_alpha$.

=== Lagrange Multiplier
We use Lagrange multiplier to extremize the entropy. We won't do the general
case to avoid notation clutter. Instead, we do the case where energy expectation $U$ is
given (i.e. canonical ensemble).

Define auxiliary function
$ G = -k_B sum_alpha p_alpha ln p_alpha + k_B lambda (1 - sum_alpha p_alpha) + k_B beta (U - sum_alpha p _alpha E_alpha ) $

And differentiate with respect to $p_alpha, lambda, beta$ and set to zero to get
critical point.

This gives eventually

$ p_alpha = exp(- beta E_alpha) / Z(beta) $
where $ Z(beta) = sum_alpha exp(- beta E_alpha) $
is the *partition function* for canonical ensemble. Having more Lagrange
multiplier essentially introduces for free parameters.

=== State Counting (Micro-canonical Ensemble)
Again use energy as an simple example.

If we have _fixed and exact_ information on energy (say it is $U$), then we
should set all incompatible state ($E_alpha eq.not U$) to $0$. And these are our
constraints. Then we again use Lagrange multiplier

$ G = -k_B sum_(alpha) p_alpha ln p_alpha + k_B lambda (1 - sum_alpha p_alpha) + sum_(alpha in.not text("compatible")) lambda_alpha (p_alpha) $

where $sum_(alpha in.not text("compatible")) lambda_alpha (p_alpha)$ essentially
sets all $p_alpha = 0$ for incompatible $alpha$.

Lagrange multiplier will then give $p_alpha$ being the same for all compatible $alpha$.

Thus let $W$ be the total number of compatible eigenstate under the constraint,
we get $p_alpha = 1/W$, plug in

$ S = -k_B ln W $

#caution[
  These two approaches will not give the exact same number for $S$. However, for
  large enough system, the value will be approximately. This actually highlights
  that "mean" or "expectation" doesn't really play a big difference compared to
  exact constraints.
]

There will be some examples later illustrate how these two approaches works and
give the same result.

Another interesting fact is that different "ensembles" are naturally linked to
different thermodynamic potentials. For example,
- canonical ensemble relates to $F$ (free energy)
- grand canonical ensemble relates to $Phi$ ("grand potential")
- pressure ensemble relates to $G$ (Gibbs free energy)

These will be detailed later.

== Basic Properties of Entropy
Remember von Neumann entropy is subadditive. That is
$ S(hat(rho)_(A B)) lt.eq S(hat(rho)_A) + S(hat(rho)_B) $
This is equal if and only if $hat(rho)_(A B) = hat(rho)_A tp hat(rho)_B$. For
certain cases $hat(rho)_(A B) eq.not hat(rho)_A tp hat(rho)_B$, for example the
collective density matrix of two identical ideal gas particle due to
symmetrization would be different from $hat(rho)_A tp hat(rho)_B$. And
subadditivity is the solution to Gibb's paradox!

However, in most times, for weakly interacting systems, we assume $op(rho)_A tp op(rho)_B$ is
the collective density matrix. This assumption leads to
$ alpha_(A B) = (alpha_A, alpha_B), E_(A B) = E_A + E_B $
And if we extremizes the total system's entropy#footnote[Notice if we extremize collectively, then we naturally must only have one
  parameter $beta$ for the total system.], we get
$ Z_(A B)(beta) &= sum_alpha exp(- beta E_alpha_A - beta E_alpha_B) \
              &= sum_alpha_A exp(-beta E_alpha_A) sum_alpha_B exp(-beta E_alpha_B) \
              &= Z_A (beta) Z_B (beta) $<Z-product>
And
$ p_alpha = exp(-beta E_alpha_A - beta E_alpha_B) / (Z_A Z_B) = p_alpha_A p_alpha_B $

From which we get also
$ S_(A B) &= -k_B sum_alpha p_alpha_A p_alpha_B (ln p_alpha_A + ln p_alpha_B) \
        &= -k_B sum_alpha_A p_alpha_A ln p_alpha_A - -k_B sum_alpha_B p_alpha_B ln p_alpha_B \
        &= S_A + S_B $
After we use $sum_alpha_i p_alpha_i = 1, sum_alpha = sum_alpha_A sum_alpha_B$.

So for non-coupled (or "product") system, extremizing the collective entropy is
the same as extremizing individual subsystem entropy (with the same $beta$) and
add together.

= Thermodynamics
== Quasistatic System
== First Law and Second Law
=== Reversible Process
== Thermodynamic Potential

= Simple Systems
== Localized Harmonic Oscillator (Einstein Model of Solid)
== Classical Ideal Gas (Maxwellian-Boltzmann Statistics)
== Diatomic Gas
=== Vibrational Freedom

= Quantum Ideal Gas
== Fermion Ideal Gas (Fermi-Dirac Statistics)
== Boson Ideal Gas (Bose-Einstein Statistics)
== Photon Gas
=== Radiation

= Phase Change and Real Gas

#pagebreak()

#bibliography("./bib.yml", style: "ieee")
