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

#let adia = sym.lt.curly

= Primitives and Basics
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
  equilibrium. Define adiabatic accessibility and quasi-static process.
- Acknowledge the second law of thermodynamic ("entropy change of an adiabatic
  process is non-negative") and derive the equivalent formulation in classical
  thermodynamics (i.e. Clausius and Kelvin's statement). This also gives the
  reversibility criterion#footnote[It should be emphasized (and later again) that reversibility is only defined for
    adiabatic process. Thus in most textbook cases, we can only say something is
    reversible if we also speak of the environment.] for adiabatic process.
- Derive various stability argument, different thermodynamic potential and their
  interpretation.

Later, we will develop different models (i.e. calculate entropy/partition
function) for various real-life examples.

It should be stressed again, statistical mechanics only characterizes
thermodynamic systems, it is silent on how multiple thermodynamic system
interact (or interact with non-thermal system). For that, you are essentially
using thermodynamics.

Kinetic Theory is an alternative (and more classical) approach to understanding
how a specific type of thermodynamic system -- _gas_ (or fluid probably, which
we will not cover) can be understood by purely classical mechanical means.

== Entropy, Thermodynamic System, Equilibrium, and Adiabatic Accessibility
=== Entropy, Thermodynamic System, and Equilibrium
Assume we are happy about quantum mechanics (including density matrix and von
Neumann equation for evolution). Then we define the von Neumann entropy

#def[(von Neumann) entropy][
  For a quantum system of Hamiltonian $hat(H)$ and density matrix $hat(rho)$, its
  entropy is defined as
  $ S = k_B Tr(hat(rho) ln(hat(rho))) $
  This is a very general definition and doesn't cite anything about
  thermodynamics.
]

Density matrix arises by entanglement essentially.

#eg[Entropy evolution of composite spin-1/2 system under Heisenberg interaction][TODO. This should give us a periodic time-dependent entropy. Remember to do a
  partial trace, so we are talking about the entropy of the single particle.
  Otherwise it always gives you zero entropy as we are in the pure state of the
  composite system]#label("heisenberg-non-thermal")

Now, for certain system the entropy will settle as it evolves given the time.
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

#info[I want to talk more about equilibrium. A quantum system can have many different
  density matrices that all satisfies the same constraints. In the example of
  ideal gas, this means different density matrices can satisfy the same
  constraints on $U, V, N$.

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
propose our world can be separated into things that are thermal and things that
are not.

Notice also under our framework, _we cannot prove whether a system is thermal._ But
our intuition tells we know what thermal system means. For example, a glass of
water is thermal, no matter how you stir it first#footnote[ignore the heating due to vicious flow when you stir it so the water doesn't
  heat up.], it comes back still with the same macroscopic properties.

=== Maximum Entropy Principle and Basic Properties of Entropy
#text(red)[Fill in max entropy principle]

Remember von Neumann entropy is subadditive (better if we derive it). That is
$ S(hat(rho)_(A B)) lt.eq S(hat(rho)_A) + S(hat(rho)_B) $
This is equal if and only if $hat(rho)_(A B) = hat(rho)_A tp hat(rho)_B$. #text(
  red,
)[(This is speculation) for certain cases $hat(rho)_(A B) eq.not hat(rho)_A tp hat(rho)_B$,
  for example two ideal gas particle would suffer from Pauli exclusion principle
  (which is equivalent to being indistinguishable). And subadditivity is the
  solution to Gibb's paradox!]

=== Adiabatic Accessibility and Quasi-static Process
Now back to thermodynamics. #text(red)[You should define heat first, then second law]

#def[Adiabatic Accessibility][
  For a thermal system, let $X,Y$ be two equilibrium state of it. $Y$ is
  adiabatically accessible from $X$ (denoted as $X adia Y$) if there exists a
  device which transforms $X$ to $Y$ such that the device returns to the same
  state (or may return to) except possibly a change in gravitational potential of
  some weight.

  See @thess[Section 2.3] for detailed explanation.

  We write $X ~ Y$ if $X adia Y$ and $Y adia X$. We write $X adia adia Y$ if $X adia Y$ but $Y adia.not X$.
]

As we shall see adiabatic accessibility is essentially an order relation for
entropy (i.e. $X adia Y equiv S(X) lt.eq S(Y)$). Since in our construction we
already had entropy, what adiabatic accessibility provides us is an
interpretation for what higher or lower entropy state means.

#pagebreak()

#bibliography("./bib.yml", style: "ieee")
