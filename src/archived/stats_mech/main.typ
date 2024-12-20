#import "/templates/main.typ": simple, preamble, thm_vanilla
#import preamble: *
#import thm_vanilla: *

#show: simple.with(
  title: "Statistical Mechanics, Thermodynamics, and Kinetic Theory", authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
)
#show: setup
#show: thm_setup
#set page(margin: (y: 1cm))

#let op(body) = $hat(body)$
#let adia = sym.prec

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
#postl[Maximum Entropy Principle][For an _isolated_ thermal system under equilibrium, the entropy is maximized
  such that
  - $op(rho)$ corresponding to the maximum $S(op(rho))$ satisfies $[op(rho), op(H)] = 0$.
  - _all_ constraints of expectation value of conserved quantities (i.e. the
    operators $[op(O), op(H)] = 0$) are satisfied]<mep>

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

#warning[
  Isolated thermal system is required for @mep to apply. The simple reason is
  non-isolated system implies energy is not conserved. However, we must have $[op(H), op(H)] = 0$ and
  should thus conserve the energy while maximization if we follow the @mep. Thus
  it's self-contradictory.

  The actual physical reason is non-isolated system implies interaction and our
  Hamiltonian doesn't model that#footnote[In fact, to model interaction we need the total space of the other system that
    we are _interacting with_.]. Thus nonphysical result is expected.

  One way as we later see is to apply @mep to the compound system comprising both
  parties of interaction. And the compound system is isolated. The interaction
  Hamiltonian can be ignored provided it's weak.
]

To use @mep, there are mainly two ways:
- Lagrange Multiplier
- State Counting
They are essentially from the same principle. The second one can be exactly
derived from the first one. The first one could also be derived from the second,
but requires _several little fudges_.

=== Labeling Eigenstates<label-eigenstates>
Before we start, let's fix some notation which we shall use throughout the note.

We would need to label energy eigenstates. Let ${op(O)_i}$ be some (finite
number of) mutually commuting operators that also commute with Hamiltonian. Let ${B_j}$ be
some classical variables (e.g. volume for gas), so they are constant and
deterministic for all states. Then in the simultaneous eigenbasis of all those
operators, each eigenstate $ket(E)$ can be labeled using a tuple
$ alpha = (E, O_1, O_2, dots, B_1, B_2, dots) $
where $O_i$ are eigenvalues of $op(O)_i$ for state $ket(E)$.

When we write $sum_alpha$ it means to permute over all values of $O_i$, so
$ sum_alpha equiv sum_O_1 sum_O_2 dots.c $
where we don't vary over ${B_j}$ because they are fixed values and don't need to
be permuted over.

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
$ G_"Gibbs" = -k_B sum_alpha p_alpha ln p_alpha + k_B lambda (1 - sum_alpha p_alpha) + k_B beta (U - sum_alpha p _alpha E_alpha ) $<canonical-ensemble-multiplier>

And differentiate with respect to $p_alpha, lambda, beta$ and set to zero to get
critical point.

This gives eventually

$ p_alpha = exp(- beta E_alpha) / Z(beta) $
where $ Z(beta, {B_j}) = sum_alpha exp(- beta E_alpha ({B_j})) $
is the *partition function* for canonical ensemble. Notice $E_alpha$ still
depends on ${B_j}$ after being summed over. We may later suppress this
dependency when understood.

It turns out the Lagrange multiplier $beta$ is equivalent to temperature.
#def[Temperature][
  Define temperature in Kelvin as
  $ T := 1 / (k_B beta) $
  where $k_B$ is Boltzmann constant.

  From now on we may use $beta, T$ interchangeably. They are understood as if they
  are the same variable.
]<temperature>

==== Generalized Gibbs Ensemble
Having more Lagrange multiplier essentially introduces more free parameters. If
we have another parameter $X$ (so some observable $op(X)$ whose mean value is $X$),
then the auxiliary function becomes
$ G = G_"Gibbs" - k_B beta f (X - sum_alpha p_alpha X_alpha) $
where $G_"Gibbs"$ is from @canonical-ensemble-multiplier and we introduced the
Lagrange multiplier $f$.

This gives
$ p_alpha         &= exp(- beta (E_alpha - f X_alpha)) / Z(beta) \
cal(Z)(beta, f) &= sum_alpha exp(- beta (E_alpha - f X_alpha)) $

where $cal(Z)$ is also called generalized partition function.

$
  pdv(ln(cal(Z)), f)      &= beta X \
  - pdv(ln(cal(Z)), beta) &= U - f X
$

A common example of generalized Gibbs ensemble is *grand canonical ensemble*
when $X = N$, the total number of particle, and $f = mu$, the chemical
potential.

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

#warning[
  These two approaches will not give the exact same number for $S$. However, for
  large enough system, the value will be approximately. This actually highlights
  that "mean" or "expectation" doesn't really play a big difference compared to
  exact constraints.
]

There will be some examples later illustrate how these two approaches works and
give the same result.

Another interesting fact is that different "ensembles" are naturally linked to
different thermodynamic potentials. For example,
- micro-canonical ensemble relates to $S$ (entropy)
- canonical ensemble relates to $F$ (free energy)
- grand canonical ensemble relates to $Phi$ ("grand potential")
- pressure ensemble relates to $G$ (Gibbs free energy)

These will be detailed later.

== Compound System
Remember von Neumann entropy is subadditive. That is, for subsystems $A, B$,
$ S(hat(rho)_(A B)) lt.eq S(hat(rho)_A) + S(hat(rho)_B) $

This is equal if and only if $hat(rho)_(A B) = hat(rho)_A tp hat(rho)_B$. For
certain cases $hat(rho)_(A B) eq.not hat(rho)_A tp hat(rho)_B$, for example the
collective density matrix of two identical ideal gas particle due to
symmetrization would be different from $hat(rho)_A tp hat(rho)_B$. And
subadditivity is the solution to Gibb's paradox!

However, in most times, for weakly interacting systems, *we can ignore the
interaction*, so
$ op(H)_(A B):= op(H)_A + op(H)_B + op(H)_"int" approx op(H)_A + op(H)_B $

Thus the eigenstates of the compound system is just the tensor products of
individual eigenstates of $A, B$.

This gives an important result on weakly-interacting compound isolated system
under equilibrium.
#thm[Weakly-interacting equilibrium has separable density operator][
  For an isolated compound system described Hilbert space $cal(H)_A tp cal(H)_B$ with
  Hamiltonian
  $ op(H)_(A B):= op(H)_A + op(H)_B + op(H)_"int" approx op(H)_A + op(H)_B $
  and $[op(H)_A, op(H)_"int"] eq.not 0, [op(H)_B, op(H)_"int"] eq.not 0$, then
  @mep with canonical ensemble implies
  - Equilibrium density operator $op(rho)_(A B) = op(rho)_A tp op(rho)_B$ for some $op(rho)_A, op(rho)_B$
  - $op(rho)_A, op(rho)_B$ are equilibrium operators for system $A, B$ respectively
    with the same $beta$
  - Entropy is additive.
]<weak-coupling-is-separable>
#proof[
  #pfstep[
    $alpha_(A B) = (alpha_A, alpha_B), E_(A B) = E_A + E_B$
  ][
    Under approximation $op(H)_(A B) approx op(H)_A + op(H)_B $, the eigenstates are
    separable, and thus the labeling and eigenvalues are also separable.

    Thus $alpha_(A B) = (alpha_A, alpha_B), E_(A B) = E_A + E_B$.
  ]

  #pfstep(
    finished: true,
  )[
    The only constraint we should consider is the constraint on energy $U$ for the
    compound system.
  ][
    We assume $[op(H)_A, op(H)_"int"] eq.not 0, [op(H)_B, op(H)_"int"] eq.not 0$, so
    it implies we should#footnote[This is somewhat arbitrary consider we are assuming $op(H)_"int"$ negligible.
      However, not assuming this would make our model identical to individually
      isolated subsystem $A, B$.] not consider individual $op(H)_A, op(H)_B$ as
    conserved (and thus not constraints).
  ]

  And if we extremizes the total system's entropy#footnote[Notice if we extremize collectively, then we naturally must only have one
    parameter $beta$ for the total system.] under
  $ 0 = U - sum_alpha p_alpha E_alpha $
  we get
  $ Z_(A B)(beta) &= sum_alpha exp(- beta E_alpha_A - beta E_alpha_B) \
                &= sum_alpha_A exp(-beta E_alpha_A) sum_alpha_B exp(-beta E_alpha_B) \
                &= Z_A (beta) Z_B (beta) $<Z-product>
  And
  $ p_alpha = exp(-beta E_alpha_A - beta E_alpha_B) / (Z_A Z_B) = p_alpha_A p_alpha_B $<compound-system-prob>

  where
  $ p_alpha_A = exp(-beta E_alpha_A) / Z_A, p_alpha_B = exp(-beta E_alpha_B) / Z_B $
  Note this is the same as canonical ensemble distribution if we individually
  maximizes entropy for subsystem $A, B$ (but _with the same $beta$_).

  From @compound-system-prob we get also
  $ S_(A B) &= -k_B sum_alpha p_alpha_A p_alpha_B (ln p_alpha_A + ln p_alpha_B) \
          &= -k_B sum_alpha_A p_alpha_A ln p_alpha_A - -k_B sum_alpha_B p_alpha_B ln p_alpha_B \
          &= S_A + S_B $
  After we use $sum_alpha_i p_alpha_i = 1, sum_alpha = sum_alpha_A sum_alpha_B$.
]
#remark[
  This can be generalized to other ensembles to allow particle exchange or volume
  exchange. But the problem with volume is we cannot quantize it easily.
]

The same density matrix (or ${p_alpha_A}, {p_alpha_B}$) could also be reached if
we find the equilibrium for each system under constraints $U_A, U_B$ for each
system to get $S_A, S_B$ and extremizes $S = S_A + S_B$ under the constraint $U_A + U_B = U$.
This is proven in @weak-coupling-second-maximization as we need to know more
about variable dependence.

= Thermal Relations
In this part we study the calculus of different thermodynamic variables. We will
see these variable describe equilibrium states on a state manifold.

== Variable Dependence
We need to know first what are the variables in thermodynamics. In previous
sections, we see the partition function is of the form
$ Z("Lagrange Multipliers", "Classical Parameters") $
where Lagrange Multipliers $beta, f$ etc. are from the expectation values of
quantum observables.

#warning[
  Micro-canonical ensemble will not fit in this description because in there we
  are assigning fixed value to quantum observables. In that case,
  $ Z("Known Observable Eigenvalues", "Classical Parameters") $
  would be the form.

  Notice we used "known", which means we could (and should) left out unknown
  observable eigenvalues, over which states are summed over to give a bigger
  entropy.

  Classical Parameters should usually be _all_ known because they could take real
  (uncountable) value and give uncountable number of compatible states, which give
  infinite $W$ if summed over.
]

We define the "degree of freedom" or "dimension" of a thermodynamic system as
#def[Dimension of Thermal System][
  For a given thermal system described by (generalized) canonical ensemble,
  dimension $D$ is defined by
  $ D = "Number of Lagrange Multipliers" + "Classical Parameters" $
  If described by micro-canonical ensemble, dimension $D$ is defined by
  $ D = "Number of Known Observable Eigenvalues" + "Classical Parameters" $
]<dimension>
#info[
  Upon the first look, the dimension seems to be specific to the ensemble. For
  example, for ideal gas we could have an ensemble that has no observable
  constraints and thus zero Lagrange multiplier, then the system only has $D=2$ with
  variables $V, N$, which is less then the canonical ensemble $D=3$ and $beta, V, N$.

  However, most cases any _meaningful_ ensemble describing the system will give
  the same dimension. For ideal gas, the grand canonical ensemble has $D=3$ with $beta, mu, V$,
  transforming classical $N$ into Lagrange multiplier $mu$. And the
  micro-canonical ensemble also has $D=3$ with $U, V, N$ where $U$ is exact
  energy.
]

Partition function is enough to give the full thermodynamics. For example, for
canonical ensemble (only $beta$ as a lagrange multiplier) with classical
parameter $V,N$,
$ U &= - eval(pdv(ln Z, beta))_(V,N) \
S &= k_B ln Z + k_B beta U $<var-equations>
where the second equation is given by plugging in $p_alpha$ to $S = - k_B sum_alpha p_alpha ln p_alpha$.

Notice @var-equations _doesn't_ constrain the variables $beta, V, N$ as given in
the dependence of $Z$. Instead, it relates $beta, V, N$ to "new" variables $U, S$.

In fact it turns out, here $beta, V, N$ actually constitutes the minimal degree
of freedom of this thermodynamic system. The reason is simple, all together we
have $beta, V, N, S, U$ total of five variables and @var-equations gives two
constraints between these five variables.

Implicit function theorem allows us to select three variables _with suitable condition_ to
form a set of independent variables.

#info[
  Luckily, for ideal gas these condition are satisfied for any choice of
  independent variable (neglecting the possibility of singularity of partial
  derivative).

  For ideal gas, the partition function as we later discover is
  $ Z_1^N / N!, Z_1 = V / (lambda_"th" (beta)) $<ideal-partition-func>

  And if we write out the derivative linear map for our constraint functions
  $ f_1(U, S, beta, V, N) &= U + eval(pdv(ln Z, beta))_(V,N) \
  f_2(U, S, beta, V, N) &= S - k_B ln Z - k_B beta U $
  we get
  $ pdv((f_1,f_2), (U, S, beta, V, N)) = overbrace(
    mat(
      1, 0, pdv(ln Z, beta^2), pdv(ln Z, V, beta), pdv(ln Z, N, beta);-k_B beta, 1, cancel(k_B U -k_B U), - k_B pdv(ln Z, N), - k_B pdv(ln Z, V)
    ), (U, S, beta, V, N),

  ) $

  Implicit function theorem requires us to choose _dependent_ variable such that
  the submatrix corresponding to them is invertible. The only _possible_ non-invertible
  part is on $V, N$ (equivalent to $beta, S, U$ being independent variable).

  Specifically,
  $ mat(
    pdv(ln Z, V, beta), pdv(ln Z, N, beta);- k_B pdv(ln Z, V), - k_B pdv(ln Z, N)
  ) $<N-V-mat>

  However, if we differentiate @ideal-partition-func we find two rows are not
  proportional to each other. This is because of $N$ features as an exponential in $Z = Z_1^N$.

  In fact, later as we calculate the entropy, we should explicitly see how $U, S, beta$ gives
  the other variables.
]

For ideal gas, $U, S, beta, V, N$ are unfortunately not the full list of most
used (independent) variables. We also have
#def[Pressure][
  Pressure is defined as
  $ P = - eval(pdv(U, V))_(S, N) $
  where we used the $S, V, N$ as independent variables.
]<pressure>

Again, luckily, for ideal gas, we can choose any three variables among the six $U, S, P, beta, V, N$ as
independent variables to generate other three.

However, things get slightly different when we consider
#def[Chemical Potential][
  Chemical potential is defined as
  $ mu = eval(pdv(U, N))_(S, V) $
  where we used the $S, V, N$ as independent variables.
]<chemical-potential>

#thm[Chemical Potential in terms of canonical ensemble partition function][
  $ mu = - 1/ beta eval(pdv(ln Z, N))_(beta, V) $
]<chemical-potential-partition-function>
#proof[
  By chain rule,
  $ eval(pdv(U, N))_(S, V) &= eval(pdv(U, N))_(beta, V) + eval(pdv(U, beta))_(N, V) eval(pdv(beta, N))_(S, V) $

  And by @cyclic-relation,
  $ eval(pdv(beta, N))_(S, V) = - eval(pdv(S, N))_(beta, V) / eval(pdv(S, beta))_(N, V) $

  By @pdv-S-beta, $ eval(pdv(S, beta))_(N, V) = k_B beta eval(pdv(U, beta))_(N, V) $

  And differentiating @var-equations gives
  $ eval(pdv(S, N))_(beta, V) = k_B eval(pdv(ln Z, N))_(beta, V) + k_B beta eval(pdv(U, N))_(beta, V) $

  Thus

  $ eval(pdv(U, beta))_(N, V) eval(pdv(beta, N))_(S, V) &= - cancel(eval(pdv(U, beta))_(N, V)) (k_B eval(pdv(ln Z, N))_(beta, V) + k_B beta eval(pdv(U, N))_(beta, V)) / (k_B beta cancel(eval(pdv(U, beta))_(N, V))) \
                                                      &= - 1/ beta (eval(pdv(ln Z, N))_(beta, V) + beta eval(pdv(U, N))_(beta, V)) $

  So together
  $ eval(pdv(U, N))_(S, V) &= eval(pdv(U, N))_(beta, V) - 1/ beta (eval(pdv(ln Z, N))_(beta, V) + beta eval(pdv(U, N))_(beta, V)) \
                         &= -1 /beta eval(pdv(ln Z, N))_(beta, V) $
]

#thm[Pressure in terms of canonical ensemble partition function][
  $ P = 1/beta eval(pdv(ln Z, V))_(beta, N) $
]<pressure-partition-function>
#proof[Exactly analogous to @chemical-potential-partition-function. Notice the sign
  difference as @pressure is defined with a minus sign. ]

And we cannot use $mu, T, P$ or $mu, beta, P$ as independent variables for the
system.

#thm[Purely intensive variables set are non-independent][
  For ideal gas, $mu, beta, P$ cannot serve as a set of independent variable to
  obtain $U, S, V, N$.
]
#proof[
  The relevant constraints are, by @chemical-potential-partition-function,
  @pressure-partition-function,
  $ f_1 &= mu+ 1/ beta eval(pdv(ln Z, N))_(beta, V) \
  f_2 &= P - 1/beta eval(pdv(ln Z, V))_(beta, N) $
  So the derivative is
  $ pdv((f_1, f_2), (beta, mu, P, V, N)) $

  And we need to look at the $V, N$ part of the derivative, which is
  $ 1/beta mat(pdv(ln Z, N, V), pdv(ln Z, N, 2);- pdv(ln Z, V, 2), - pdv(ln Z, V, N)) $<det-mat>

  And plug in the partition function
  $ Z = (V/ lambda_"th"^3)^N / (N!) $

  Take $ln$,
  $ ln Z approx N (ln V - 3 ln lambda_"th" (beta) ) - N ln N + N $

  Since all derivatives are second-derivative and $lambda$ depends on $beta$ only,
  we can safely neglect $lambda$,

  And calculation yieds,

  $ pdv(ln Z, N, V) &= 1 / V \
  pdv(ln Z, N, 2) &= - 1/ N \
  pdv(ln Z, V, 2) &= N / V^2 $
  And this makes @det-mat singular. Thus $beta, P, mu$ cannot be used as a set of
  independent variable.
]
#remark[
  This is a rather "head-on" proof. This can alternatively been seen using
  @gibbs-duhem, or by the simple physical argument that these parameters stays the
  same as system scales, therefore cannot determine $V, N$ as the system with $2V, 2N, beta$ gives
  the same $beta, P, mu$.
]

And we may _assume_ from now on
#postl[Equivalence of Variables][For most thermodynamic systems, any choice of variables with the correct
  dimension (@dimension) constitutes a set of independent variable, *as long as
  not all variables chosen are intensive*.]<equivalence-of-var>

In reality we almost never find/use the explicit form of implicit function. This
is because we often use the derivative and convert independent variables of
derivative often.

And another point of view is also important to understand the logic of the
theory correctly
#def[State Manifold][
  Let $Sigma$ be the set of all equilibrium states of the system,
  $ Sigma:= {("Lagrange Multipliers", "Classical Parameters")} $
  We assert#footnote[Don't take this assertion too literally, expect some mathematical subtleties,
    just like @equivalence-of-var.] $Sigma$ as a $D$-dimensional manifold.
]<state-manifold>
#eg[
  Think of idea gas, we can characterize it using
  $ Sigma:= {(U, S, P, beta, V, N)} $
  And we know it only has $D=3$ due to @var-equations, @pressure. So all
  equilibrium states form a 3-manifold embedded in $RR^6$.
]

=== Chain Rule and Differentials
The main tool for transforming derivatives will be chain rule (the general
version). Its use is best illustrated by example.

#eg[For ideal gas, we know#footnote[Remember @temperature.] $U, V, N$ and $T,P,N$ can
  both be independent variables. And in practice we want to find the derivatives
  of $S(T, P, N)$ given $S(U, V, N)$. More specifically, we want to find $eval(pdv(S, T))_(P, N)$.

  By chain rule, we know (under suitable condition),

  $ pdv(S, (T, P, N)) = pdv(S, (U, V, N)) compose pdv((U, V, N), (T, P, N)) $<chain-rule-eg-abstract>

  where we used the notation
  $ pdv(S, (T, P, N)):= jmat(S;T, P, N) $

  So @chain-rule-eg-abstract means
  $ jmat(S;T, P, N) = jmat(S;U, V, N) jmat(U, V, N;T, P, N) $
]<ideal-gas-chain-rule-eg>

This can often be done easier using "differentials" as it allows us to omit
irrelevant matrix entries.

#eg[
  Continuing @ideal-gas-chain-rule-eg, but using differentials. We can write

  $ dd(S)= pdv(S, U) dd(U) + pdv(S, V) dd(V) + pdv(S, N) dd(N) $

  And $ dd(U) &= pdv(U, T) dd(T) + pdv(U, P) dd(P) + pdv(U, N) dd(N) \
  dd(V) &= pdv(V, T) dd(T) + dots.c \
  dd(N) &= pdv(N, T) dd(T) + dots.c $
  And "substituting back gives the $pdv(S, T)$.

  Mathematically, this is just a shorthand for @ideal-gas-chain-rule-eg. But it's
  more economic and convenient.
]

=== Useful Derivative Formulae

The first "rule" is the reciprocity rule, which is really just a special case of
chain rule.

#thm[Reciprocity Relation][
  Let $X, Y, Z$ be variables related by some constraints. If $(X, Z), (Y, Z)$ can
  both act as set of independent variable,
  $ eval(pdv(X, Y))_Z = inv(eval(pdv(Y, X))_Z) $
]<reciprocity-relation>
#proof[
  $ eval(pdv(X, Y))_Z &= det(pdv((X, Z), (Y, Z))) \
                    &= det(inv(pdv((Y, Z), (X, Z)))) \
                    &= inv(det(pdv((Y, Z), (X, Z)))) \
                    &= inv(eval(pdv(Y, X))_Z) $
]
#remark[
  This can be easily extended to multiple variable with $Z_1, Z_2, dots$.
]

Consider the following example,
#eg[Reciprocity Relation][
  $ pdv(S, (U, V, N)) = pdv(S, (T, V, N)) compose pdv((T, V, N), (U, V, N)) $

  So
  $ eval(pdv(S, U))_(V, N) = eval(pdv(S, T))_(V, N) eval(pdv(T, U))_(V, N) $

  By @reciprocity-relation, $ eval(pdv(T, U))_(V, N) = inv(eval(pdv(U, T))_(V, N)) $
  Thus
  $ eval(pdv(S, U))_(V, N) = eval(pdv(S, T))_(V, N) / eval(pdv(U, T))_(V, N) $
]<reciprocity-relation-eg>

We also have
#thm[Cyclic Relation][
  Given $X, Y, Z$ with constraints such that any two variables of the three
  constitute a set of independent variables. Then
  $ eval(pdv(X, Y))_Z eval(pdv(Y, Z))_X eval(pdv(Z, X))_Y = -1 $
]<cyclic-relation>
#proof[
  Notice $ det(pdv((X, Z), (Y, Z))) = eval(pdv(X, Y))_Z $
  And $ det(pdv((X, Z), (Z, Y))) = det(pdv((Z, X), (Y, Z))) = - det(pdv((X, Z), (Y, Z))) $ as
  determinant inverts sign as we permute rows/columns.

  This means we can write the relation as
  $ det(pdv((X, Z), (Y, Z))) det(pdv((Y, X), (Z, X))) & det(pdv((Z, Y), (X, Y))) \
                                                    &= det(pdv((X, Z), (Y, Z))) overbrace(
    det(pdv((Z, Y), (X, Y))) det(pdv((Y, X), (Z, X))), "shifting these two",

  ) \
                                                    &= det(
    pdv((X, Z), (Y, Z)) compose pdv((Z, Y), (X, Y)) compose pdv((Y, X), (Z, X))
  ) $

  Now, $ pdv((X, Z), (Y, Z)) compose pdv((Z, Y), (X, Y)) compose & pdv((Y, X), (Z, X)) \
                                                          &= - pdv((X, Z), (Z, Y)) compose - pdv((Z, Y), (Y, X)) compose - pdv((Y, X), (X, Z)) \
                                                          &= - pdv((X, Z), (Y, X)) compose pdv((Y, X), (X, Z)) = - II $
  By $det(-II) = -1$ we get the required relation.
]
#remark[This can be easily extended to more than three variables.]

Later we also have Maxwell's relation. But for that we need to first establish
the first law and some thermodynamic potentials.

== First Law of Thermodynamics
Given @var-equations, we want to find the derivative of $U(S, {X_i})$.

#thm[
  Let $Z(beta, X_1, X_2, dots.c)$ where $beta$ is the Lagrange multiplier of $U$,
  and ${X_i}$ are used to represent other Lagrange multiplier and classical
  parameters. We have
  $ eval(pdv(U, S))_({X_i}) = T $
  where we used $(S, {X_i})$ as independent variables.
]<heat-expr>
#proof[
  By @reciprocity-relation, we have
  $ eval(pdv(U, S))_({X_i}) = eval(pdv(U, beta))_({X_i}) / eval(pdv(S, beta))_({X_i}) $

  And differentiate $S = k_B beta U + k_B ln Z$ with respect to $beta$,
  $ eval(pdv(S, beta))_({X_i}) &= k_B beta eval(pdv(U, beta))_({X_i}) + k_B U + k_B overbrace(eval(pdv(ln Z, beta))_({X_i}), -U) \
                             &= k_B beta eval(pdv(U, beta))_({X_i}) $<pdv-S-beta>

  Thus
  $ eval(pdv(U, S))_({X_i}) = eval(pdv(U, beta))_({X_i}) / eval(pdv(S, beta))_({X_i}) = 1/ (k_B beta) = T $
  by @temperature.
]

Put together @pressure, for ideal gas we thus have
$ dd(U) = T dd(S) - p dd(V) + pdv(U, N) dd(N) $

In fact, this $pdv(U, N)$ will be the same as $mu$ as introduced by canonical
ensemble. That is
$ mu equiv pdv(U, N) $
though these two here have different definition technically: one is from
Lagrange multiplier and constraint by partition, another is a partial
derivative.

#def[First Law of Thermodynamics][
  First Law of Thermodynamics is essentially the derivative of $U$. For $(S, V, N)$ thermal
  system,
  $ dd(U) = T dd(S) - p dd(V) + pdv(U, N) dd(N) $
]<1st-law>

#warning[
  Often times first law is written as
  $ dd(U) = var(Q) + var(W) $
  where $var(Q)$ is the differential form for heat.

  This statement alone is not useful as it doesn't give an expression for $var(Q), var(W)$.
  In fact, integration of $var(Q), var(W)$ are path-dependent in the sense that it
  depends on the path on the _product state manifold of both system and environment_.
  More on this later with second law.

  In contrast, variables like $U, P, T, S, V, N$ are path independent and doesn't
  dependent on environment as well.
]

#warning[
  Up till now, we have introduced nothing about _dynamics_. All derivatives and
  stuff are due to dependence between variables of the system.

  The _no-time_ view in the box is important to understand why theory works for
  non-quasistatic case (e.g. Joule expansion of ideal gas). Essentially, as long
  as the beginning and end state of the system are in equilibrium, they are two
  points in state manifold $Sigma$ (@state-manifold), and the change of any
  thermal variable is a closed form (e.g. $dd(S)$) and we can integrate it along _any_ path
  on $Sigma$ to get $difference(S)$.

  Those path we used for integration by no mean corresponds to the true _process_ taken
  by the system over time. In fact, the system may not be in equilibrium in
  between (Joule expansion clearly is the case), and thus cannot be represented by
  point on $Sigma$.
]

We can now find an alternative route to derive the equilibrium for isolated
weakly-interacting compound system.
#thm[Weakly-interacting isolated compound system equilibrium by second maximization][
  Let $S_A (U_A, V_A, N_A), S_B (U_B, V_B, N_B)$ be the entropy of system
  subsystem $A, B$.

  The maximization of compound system entropy $S = S_A + S_B$ under $U_A + U_B = U$ constraint
  with $V_A, V_B, N_A, N_B$ fixed implies
  - $beta_A = beta_B = beta$
  - $beta$ is the same as obtained in @weak-coupling-is-separable.
]<weak-coupling-second-maximization>
#proof[
  Use Lagrange Multiplier, we can write,
  $ G = S_A (U_A) + S_B (U_B) + lambda (U - U_A -U_B) $
  Differentiation gives
  $ k_B beta_A = eval(pdv(S_A, U_A))_(V_A, N_A) = -lambda = eval(pdv(S_B, U_B))_(V_B, N_B) = k_B beta_B $
  by @heat-expr and @reciprocity-relation.

  And we also need to satisfy the constraints
  $ U_A + U_B = - pdv(ln Z_A, beta) - pdv(ln Z_B, beta) = U $
  But
  $ - pdv(ln Z_A, beta) - pdv(ln Z_B, beta) = - pdv(, beta) (ln Z_A (beta) Z_B (beta)) $
  and $Z_A (beta) Z_B (beta)$ is the same as the partition function $Z_(A B) (beta)$ in
  @weak-coupling-is-separable. Thus we recover the same constraint for $beta$, and
  thus the same value for $beta$.
]

== Thermodynamic Potential
We define a few new variables which are useful when considering equilibrium
under constraints and in some sense naturally related to our partition
functions.

Some of these variables are specific to system with parameters like $V, N$.

#def[Thermodynamic Potential (Ideal gas)][
  For ideal gas, the thermodynamic potential is defined as
  $
    F(T, V, N)    &:= U - T S        && "Free Energy"\
    H(S, P, N)    &:= U + P V        && "Helmholtz Energy"\
    G(T, P, N)    &:= U - T S + P V  && "Gibbs Free Energy" \
    Phi(T, V, mu) &:= U - T S - mu N && "Grand Potential"
  $
]<thermo-potential>
For other non-gas system, we may define potentials analogously.

Their "natural" variables are indicated, by natural we mean the potential has
simple (or _canonical_) partial derivatives against these variables. For
example,

$ pdv(F, (T, V, N)) = pdv(F, (U, T, S)) compose pdv((U, T, S), (T, V, N)) $

In matrix form this is

$ mat(1, -S, -T) mat(
  pdv(U, T), pdv(U, V), pdv(U, N);1, 0, 0;pdv(S, T), pdv(S, V), pdv(S, N)
) $

And we know by chain rule,
$ eval(pdv(U, V))_(T, N) = eval(pdv(U, V))_(S, N) + overbrace(eval(pdv(U, S))_(V, N), "T") eval(pdv(S, V))_(T, N) + eval(pdv(U, N))_(S, V) cancel(pdv(N, V)_(T, N)) $

So
$ eval(pdv(F, V))_(T, N) &= eval(pdv(U, V))_(T, N) - T eval(pdv(S, V))_(T, N) \
                       &= eval(pdv(U, V))_(S, N) = -P $

Similar for other derivatives.

Using differential form is simplifies this process significantly. This is
because it allows us to write out more-than-independent variables in the middle
and eliminate/change them at the end.

$ dd(F) &= dd(U) - T dd(S) - S dd(T) \
      &= T dd(S) - P dd(V) + pdv(U, N) dd(N) - T dd(S) - S dd(T) \
      &= -S dd(T) -P dd(V) + pdv(U, N) dd(N) $

#info[So it's like pretending $F$ is a function of $T, S, V, N$ and later introduce
  the constraints between them. Differentials _automates_ this process. And
  luckily in this case the derivative $ eval(pdv(F, S))_(T, V, N) = 0 $]

This is similar for other potentials.

=== Gibbs-Duhem Relation
Another important relation is Gibbs-Duhem relation, which is specific to $(S, V, N)$ system
(e.g. gas or fluids). To derive it we need a few definition and theorem.
#def[Homogeneous Function][
  Let $f: RR^N to R$ be a homogeneous function of degree/homogeneity $k$, then
  $ f(lambda vb(x)) = lambda^k f(vb(x)) $
  for all $lambda in RR$.
]<homo-fn>

#thm[Euler Homogeneous Function Theorem][
  Assume $f: RR^N to R$ is homogeneous of degree $k$ and differentiable,
  $ vb(x) dot.c grad f = k f(vb(x)) $
]<euler-homo>
#proof[
  Since $f$ is homogeneous, we have
  $ f(lambda vb(x)) = lambda^k f(vb(x)) $
  Differentiate both side by $lambda$,
  $ vb(x) dot.c eval(grad f)_(lambda vb(x)) = k lambda^(k-1) f(vb(x)) $
  Sub in $lambda = 1$ gives the desired expression
]

Physically, certain quantities are intensive, certain quantities are extensive.
This means when we double the system size (again, this concept is most
meaningful#footnote[It's hard to argue if $B$ field will be intensive or not, yet it presents
  naturally in $U$ for paramagnet.] for $(S, V, N)$ system). Specifically, $U(S, V, N)$ is
a homogeneous function of degree 1. This is because scaling $S, V, N$ can be
understood as scaling system thus scaling energy.

Thus by @euler-homo, we have
#thm[Gibbs-Duhem Relation][
  $ T S - p V + mu N = U(S, V, N) $
]<gibbs-duhem>
#proof[See above.]
#warning[
  Gibbs-Duhem relation is quite specific to $(S, V, N)$ systems as it depends on
  the homogeneity of $U(S, V, N)$. For paramagnet or Einstein model solids we no
  longer have such easy homogeneity.
]

By @thermo-potential and @gibbs-duhem,
$ G = U - T S + p V = mu N $
Thinking of this as an expression with variable $T, S, P, V, mu, N$ all
independent#footnote[Cancellation with $dd(U)$ in terms of $S, V, N$ leaves us luckily with only
  three independent variables so we don't need to do any extra chain rule.], we
may write
$ dd(U) - S dd(T) - T dd(S) + p dd(V) + V dd(p) = mu dd(N) + N dd(mu) $
Plug in the differential form $dd(U)$ gives

$ -S dd(T) + V dd(P) - N dd(mu) = 0 $

#text(
  blue,
)[This implies there is a function $f(T, P, mu)$ that stays constant as we "travel"
  through the equilibrium state manifold.] In fact, this should be the *equation
of state*, though we usually represent it in terms of $T, P, N, V$.

Indeed, the function is quite evident, define $f(T, S, P, V, mu, N)$ as
$ U - T S + P V - mu N $
we know it's constant zero by @gibbs-duhem, so equation of the state is
basically
$ U - T S + P V - mu N = 0 $
Rewrite in terms of $Phi$, we get
#def[Equation of state for $(S, V, N)$ system][
  $ Phi = - P V $
]<eqn-of-state>

=== Maxwell Relation
=== Relation to partition functions
Curiously, there is a correspondence between different partition functions of
different ensembles and thermodynamic potentials.

#pagebreak()
= Thermodynamics
Up until now we have done nothing with "process" or time. Dynamics is inherently _not_ in
equilibrium and different thermal systems may interact with one another.

#text(
  blue,
)[In order to say anything meaningful about the process, we _must_ have entropy at
  least sensible defined at the beginning and the end of the process.] Entropy
may or may not get defined in the middle of the process.

Notice the only tool we have on finding entropy is @mep. We can extend the
definition of entropy a little by defining entropy for "pseudo-equilibrium"
states of compound system.

#def[Extended entropy for weakly-interacting compound system][
  For two weakly-interacting thermal system with entropy defined $S_A, S_B$, we
  define their compound system entropy as
  $ S:= S_A + S_B $
  Note this agrees in particular with @weak-coupling-is-separable when compound
  system is isolated and in equilibrium.
]<extended-entropy>

#eg[
  Consider a bottle of water in a gas. Gas and water are initial isolated and each
  in equilibrium with $S_"gas", S_"water"$. At the moment we relieve the
  isolation, we define the total system entropy as $S_"gas" + S_"water"$.

  The total system without isolation is not in equilibrium by @mep unless
  temperature of gas and water agree.
]

This can definition naturally include the case of three subsystems but consider
any two as another compound system.

Note the entropy by @extended-entropy will in general *not* agree with that
given by @mep because the compound system may not be in equilibrium.

== Quasistatic Process
We first define the notion of "pseudo-equilibrium".

#def[Pseudo Equilibrium][
  Consider a compound system consisting of $n$ subsystems, if each subsystem $i$ is
  in equilibrium (i.e. on a point of their state manifold $Sigma_i$), then we say
  the total system is in pseudo equilibrium. The state of such compound system is
  described by product space $Sigma_1 times dots.c times Sigma_n$.
]
#eg[
  Given a cold water and hot ambient, the water is insulated from the environment.
  Right after removal of insulation, the water and ambient hot air are in pseudo
  equilibrium.
]

The process of interaction/dynamics could be out of equilibrium or near (pseudo)
equilibrium approximately at any time $t$.

Define quasistatic process as
#def[Quasistatic Process][
  A process is quasistatic if at any time $t$ the system is approximated by some
  pseudo equilibrium state.

  The relative structure of subsystems should not change. This means we can always
  identify the same constituent subsystems.
]

We are now able to state the second law.

== Second Law of Thermodynamics
Second law requires the notion of an "adiabatic" process. We define "adiabatic"
process as a process with no exchange of heat#footnote[We take heat as primitive, as we have to characterize heat using Clausius
  inequality which is based on second law.].

#postl[Second Law of Thermodynamics][
  For any adiabatic process (i.e. process with no heat exchange with outside),
  $ difference(S) gt.eq 0 $
  Note here entropy only needs to be defined for the start and end of the process,
  and they are allowed to be defined using @extended-entropy.
]<second-law>

#info[
  Second law is applicable as long as we can define the initial and final entropy,
  and process is _adiabatic_. The process doesn't have to be quasistatic.

  An example is Joule expansion, the process is adiabatic and the initial and
  final entropy is well-defined, yet the process is not quasistatic.
]

We define a device, called "heat source".

#def[Heat Source (Heat Reservoir)][
  A thermal system with all coordinates other than $S$ fixed is a heat source.

  Sometimes it's approximated to take $T$ as a constant.
]<heat-source>

We now have Clausius inequality which characterizes the heat for a quasistatic
process.

#thm[Clausius Inequality][
  Consider a system $cal(S)$ with heat provided solely by a heat source $cal(H)$ (@heat-source).

  Assume the process is quasistatic for the compound $(cal(S), cal(H))$, then
  $ var(Q) lt.eq T_"src" dd(S) $
  where $T_"src"$ is the temperature of the heat source#footnote[Heat source is a single non-compound thermal system, so pseudo equilibrium for $(cal(S), cal(H))$ implies
    the equilibrium of $cal(H)$ and thus well-defined temperature for $cal(H)$.].
]<clausius-inequality>

#proof[
  Since the compound system $(cal(S), cal(H))$ together can be understood as an
  adiabatic system, we can apply the second law
  $ dd(S)_"src" + dd(S) gt.eq 0 $
  along the process on the product manifold $Sigma_cal(S) times Sigma_cal(H)$ #footnote[$Sigma_cal(S)$ can indeed be another product manifold, as we don't assume
    anything on the system other than it's in pseudo equilibrium.].

  Thus
  $ T_"src" dd(S)_"src" + T_"src" dd(S) &gt.eq 0 \
  T_"src" dd(S)                       &gt.eq - T_"src" dd(S)_"src" = - dd(U)_"src" $
  as temperature is positive.

  Since the only energy transfer between heat source and the system is heat, $dd(U)_"src" = var(Q)_"src" = - var(Q) $.
  And
  $ T_"src" dd(S) &gt.eq var(Q) $
]

#info[
  For quasistatic process, we could ascribe a time-dependent entropy $S(t)$ to the
  system (or $S_i (t)$ for each subsystem) as entropy is well-defined for
  thermal-system in equilibrium. The same thing might be done for any expectation
  value for observables (e.g. $U(t), N(t)$ for grand canonical ensemble).

  Therefore, under quasistatic approximation, differentials can be understood as "rate
  of ...". For example, the formula for @clausius-inequality

  $ var(Q) lt.eq T_"src" dd(S) $

  can be understood as

  $ H(t) lt.eq T_"src" (t) S'(t) $
  where $H(t)$ is the rate of heat input on the system. So integrating both side
  with respect to $t$ gives
  $ Q lt.eq integral_(t_i)^(t_f) T_"src" (t) S'(t) dd(t) $

  In fact, this is implicitly used when we are integrating $var(Q)$. Because the
  value of $var(Q)$ is actually dependent on the path taken by compound system
  (i.e. system and heat source), so it's not a differential form on $Sigma_cal(S)$ but
  on $Sigma_cal(S) times Sigma_cal(H)$.

  This is also evident as $T_"src" dd(S)$ is a differential from on $Sigma_cal(S) times Sigma_cal(H)$ as $T_"src"$ is
  on space $Sigma_cal(H)$.
]

#warning[
  It's incorrect to claim from @clausius-inequality without further assumption
  that
]

== Extrmization of Thermodynamic Potentials
#thm[Enthalpy Minimization]
#proof[

]

== Maximized Entropy Principle as a Stability Guarantee

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
