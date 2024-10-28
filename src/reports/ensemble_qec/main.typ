#import "/templates/main.typ": simple, preamble, thm_typzk
#import preamble: *
#import thm_typzk: *

#show: simple.with(
  title: "Ensemble QEC Report", authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
  disp_content: false
)
#show: setup
#show: thm_setup

= Summary
The phenomenological Hamiltonian for ISRE (Identical Spin Rotation Effect)
$ op(H)_"ISRE" = - J vecop(S) cdot vecop(S) $<isre>
1. corrects magnetic trapping dephasing as predicted by @deutsch_spin_2010. (@sec:rephasing)
2. doesn't protect "spin coherent state" against spin-boson coupling or its derivations.
3. doesn't correct initial state with phase-error/bit-flip with or without a spin-boson coupling environment.

In fact, the "relaxing to ground state to improve fidelity" is theoretically impossible due to Kraus' theorem and linearity.


= Self-Rephasing in Magnetic Trap <sec:rephasing>
== Setup
In this setup, we take ensemble initially being in a spin coherent state
$ ket(psi_+) = underbrace(ket(+) tp dots.c tp ket(+), "N particles") $
where
$ ket(+) = 1/sqrt(2) (ket(0) + ket(1)) $

And each particle undergoes Rabi oscillation with Hamiltonian
$ op(H)_"Rabi" = sum_(i=1)^N omega_(i) /2 sigma_(i, z) $
where $omega_i$ are slightly different due to difference in magnetic field in magnetic trapping.

The $op(S)_x$ is measured to observe Rabi oscillation.

== Result
Agreeing with the simulation, when @isre is applied (i.e. $op(H)_"tot" = op(H)_"Rabi" + op(H)_"ISRE"$), the coherence time improves greatly.

#figure(
  grid(columns: 2, image("figure/mag_trap_no_isre.svg"), image("figure/mag_trap_isre.svg")),
  caption: [Left: $expval(op(S_x))$ without $op(H)_"ISRE"$; Right: $expval(op(S_x))$ with $op(H)_"ISRE"$ and $J=0.1$. Both $N=10$.]
)

The mechanism of how $op(H)_"ISRE"$ helps increasing coherence time of Rabi oscillation is described by @deutsch_spin_2010[Figure 1].

== Comment
The source of error is the differences in $omega_i$, _not_ coupling from the environment.

= Spontaneous Error Correction
We model the environment as bosonic modes (physically electromagnetic fields). And the total Hamiltonian of system (ensemble) + environment is

$ op(H)_"tot" &= overbrace(- J vecop(S) cdot vecop(S), op(H)_"ISRE") + sum_(k=0) Omega_k op(b)_k^+ op(b)_k + overbrace(sum_(i = 1)^"all particles" sum_(alpha in {x, y, z}) sum_(k=0) lambda_(k, alpha) 1/2 op(sigma)_(i, alpha) tp (op(b)^+_k + op(b)_k), "Spin-boson coupling over all particles in all directions") \
  &= - J vecop(S) cdot vecop(S) + sum_(k=0) Omega_k op(b)^+_k op(b)_k + sum_(alpha in {x, y, z}) sum_(k=0) lambda_(k, alpha) op(S)_(alpha) tp (op(b)^+_k + op(b)_k) \
  &= - J vecop(S) cdot vecop(S) + sum_(k=0) Omega_k op(b)_k^+ op(b)_k + sum_(k=0) (lambda_(k, x) op(S)_(x) + lambda_(k, y) op(S)_(y) + lambda_(k, z) op(S)_(z)) tp (op(b)^+_k + op(b)_k)
$

For simplicity, we take $lambda$ independent of $alpha$ so $lambda_(alpha,k) -> lambda_k$.

By following @landi_quantum_nodate[Section 4.6], _without approximation_ other than the usual Lindbladian Master Equation derivation, we have the following master equation derived (in Schroedinger picture):

$ dv(rho_S, t) = -i[op(H)_"ISRE", rho_S] + lambda (op(L) rho_S op(L)^+ - 1/2 {rho_S, op(L) op(L)^+}) $

where $op(L) = op(S)_x + op(S)_y + op(S)_z$ and $lambda$ is some constant.

From simulation, we see it neither protects $ket(psi_+)$ from dephasing nor corrects $ket(psi_+)$ if any phase-error or bit-flip is introduced. Fidelity in both cases drop monotonically.

#figure(
  image("figure/spontaneous_qec.svg", width: 70%),
  caption: [Fidelity with respect to $ket(psi_+)$ of evolved states. $N=7, J=1, delta_phi = 0.7, delta_theta=0.7$]
)

== Comment
Physically, the above coupling reduces the off diagonal terms between different eigenspaces of $op(L)$ over time to 0 and leaving diagonal terms unchanged (see @landi_quantum_nodate[Section 4.6.2] for detailed discussion on a simple case).

In other words, *the coupling protects the eigenspaces of $op(L)$*.

In this case, $op(L) = op(S)_x + op(S)_y + op(S)_z$ is not really a good choice as its eigenspaces are just unmotivated and unhelpful to protect. In fact, *it's not even rotationally symmetric under coordinate transformation*. Thus it introduces certain preference on direction, and hence not helpful on correcting general states.

In fact, $op(L) = vecop(S)^2$ would be a much better choice, though it wouldn't work as well as we see in the next section.

== Another Failed Coupling
Taking the coupling Hamiltonian to be
$ sum_(k=0) lambda_k vecop(S)^2 tp (op(b)^+_k + op(b)_k) $

the steady state of the density operator under evolution (see @landi_quantum_nodate[Section 4.6.2] for detailed discussion on a simple case) will be
$ rho^*_S = sum_(i=0) p_i ketbra(e_i, e_i) equiv sum_(i=0) P_i rho_(S,0) P_i $
where $P_i$ is the projection operator onto $i$-th eigenspace ($P_0$ projects to the ground state) and $rho_(S,0)$ is the initial (containing error) density matrix of the system.

Again, this process eliminates the cross "terms" and make $rho^*_S$ a diagonal block matrix. However, eliminating cross terms are not helpful:
1. when errored state is close from original ground state, the cross terms are small and eliminating them doesn't help improving fidelity.
   In particular, think initial state
   $ ket("initial") = alpha ket("ground") + beta ket("error"), |alpha|^2 lt.approx 1 $
   then the cross term $conj(alpha) beta$ in $ketbra("initial", "initial")$ will be quite small.
2. If the cross terms are large, then $p_i$s will be quite uniform and thus the steady state itself is of low fidelity.

== General No-Go for the "Naive Mechanism"
As illustrated in @tessler_approximate_nodate, the following mechanism will improve fidelity

#figure(
  image("figure/concept.png"),
  caption: [Concept of error correction in @tessler_approximate_nodate ]
)

This will indeed improve fidelity as one could readily verify. However, this mechanism is unlikely to be feasible for two reasons:
1. Unlike ladder operator $op(a)^+, op(a)$ and $sigma_plus.minus$, there isn't an operator to go between different eigenspaces of $vecop(S)^2$.
2. The naive version of this mechanism, namely
   $ epsilon[rho] = (P_0 rho P_0) / Tr(P_0 rho P_0) $<naive>
   is not a quantum operation (linear completely-positive trace-preserving map). In fact, such map is not linear obviously.

One might argue linearity is not important. However, this linearity requirement is inherited from the Schroedinger equation of System + Environment when deriving Lindblad Master Equation. In other words, *any process derived from total Hamiltonian and Lindblad master equation will be linear*. So one has to ditch Lindblad master equation in order to arrive at @naive. *Otherwise, linearity is here to stay*.

In the end, for this mechanism to work, only two options remain:
1. Have a non-naive $epsilon$ that achieves similar result (i.e. projecting onto the ground eigenspace of $-vecop(S)^2$).
2. Make modification to Lindblad master equation itself or even Schroedinger equation of the total system.

#pagebreak()

#bibliography("./isre.bib", style: "ieee")
