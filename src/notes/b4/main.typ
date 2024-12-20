#import "/templates/main.typ": simple, preamble, thm_typzk
#import preamble: *
#import thm_typzk: *

#show: simple.with(
  title: "B4 Lecture Notes", authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
)
#show: setup
#show: thm_setup

#pagebreak()

= Scattering Theory
== Classical Scattering
All classical scattering will be deterministic. The gist of the classical scattering is:
1. Find how the differential of particle $dd(N) = j_A r dd(r) dd(theta_1)$ is mapped to some region of solid angle $n(theta, psi) sin(theta) dd(theta) dd(psi)$
2. and then we can read off the $n(theta, psi)$.

== Quantum Scattering
#task[Be sure to mention the $j/V$ mistake! It's just $j = (hbar vb(k)) / m  rho$ with $rho = 1/V$!]

#task[Be sure to mention the trick of changing the variable of density of states from $k$ to $E$: just use chain rule.]

#task[Be sure to mention the problem of $4pi$ on eqn 21 in Gehauser]

#task[The thing about Breit-Wigner distribution is that we are now consider a particle, initially in the nucleus, decaying. This is different from perturbing a "plane-wave" particle with a potential due to the nucleus.
  The two particles in the spin statistics term $ g = (2 J + 1) / ((2 J_a + 1 )(2 J_b + 1)) $ are the incoming particle and the nuclei.

  But in the process like $n + A -> B+ gamma$, why we only write $Gamma_gamma, Gamma_n$? doesn't the fact that the other half is $A$ or $B$ matter? They are not the same after interaction.
]

Validity of first order perturbation:
1. Forward direction & small angle breaks the first order limit first.
2. Resonant scattering will also break the FGR.
= Nuclear Physics
== Basics
#context gen_section_graph()
#def("def_nucleus", links: ("def_nuclide", "def_isotopes_and_more"))[Nucleus][

  *Atoms* consist of electrons and protons and neutrons. And *Nucleus* refers to the massive and tiny part of the atom at the center, made of protons and neutrons.

  A *nucleus* (plural: *nuclei*) will contain some $Z$#footnote[Also referred as *atomic number* or *charge number*] protons and $N$ neutrons. Its *mass number* is then defined as $A = Z + N$.

  A *nucleon* is just a name for protons and neutrons.
]
#remark(base: "definition")[Basically nucleus is just a concept of some region of an atom.]

#def("def_nuclide", links: ("def_binding_energy",))[Nuclide][

  A *nuclide* refers to a nucleus with specific configuration of $Z$ and $N$.
]

#eg[$isotope("He", a: 4, z: 2)$ is a nuclide. Refering those nucleus with $Z = 2, N = 2$.]

#def("def_isotopes_and_more")[Isotopes and More][
  - *Isotopes*: (family of) nucleus with equal $Z$ but different $N$.
  - *Isobars*: (family of) nucleus with equal $A$ but different $Z$.
  - *Isotones*: (family of) nucleus with equal $N$ but different $Z$.
]

#def("def_binding_energy")[Binding Energy][
  For a nuclide, let $m(Z, A)$ be its actual rest mass. So its energy is $E = m(Z, A)c^2$ (assume we are in rest frame).

  But this energy can also be written in terms of constituents (i.e. protons and neutrons) energy and their interacting "potential energy":

  $ m(Z, A) c^2 = Z m_p c^2 + N m_n c^2 + underbrace(-B, #[Potential]) $

  Here $B > 0$ is defined as *Binding Energy*. The energy scale of $B$ is around $qty("8", "MeV")$.
]
#remark(base: "definition")[
  In fact, as we later see in @sec:semf, binding energy could really just be understood as the _energy difference_ between when individual nucleons are apart and put together.
]
#figure(image("./figures/Binding_energy_curve_-_common_isotopes.svg"), caption: [The measured binding energy for various nuclei. From Wikipedia.]) <fig:binding_energy>
#question(title: "Why rest mass?")[
Review the special relativity and collision. Why are we using rest masses here? Does it matter if we have motion of protons and neutrons in nucleus?
]

== Semi-Empirical Mass Formula <sec:semf>
This formula is basically a phenomenological model for binding energy and @fig:binding_energy.

Eventually we are getting to
$ B(Z, A) = underbrace(a_V A, "volume") underbrace(- a_S A^(2/3), "surface") underbrace(- a_c Z^2/A^(1/3), "coulomb") underbrace(- a_A (A-2Z)^2 / A, "asymmetry") + underbrace(delta(Z, A), "pairing") $<eq:semf>

#def("def_observed_nuclear_radius")[Observed Nuclear Radius][
  Nucleus has almost constant density (so much like a solid sphere) with
  $ r = r_0 A^(1/3) $
  where $r_0 = qty("1.2", "fm")$ and $qty("1","fm") = qty("1e-15", "m")$. For reference, atomic radius is of order #qty("1e-10", "m").
]
#remark(base: "definition")[The sole dependence of $r$ on $A$ implies the neutrons and protons play the same role and have about the same size inside the nucleus.]
#eg[For He, $r = qty("1.9", "fm")$]

#task[
  Insert the graph of scattering measurement of different elements' nucleus radius here.
]

=== Volume and Surface Terms
As a convention, all theorems and proofs in this notes are not necessarily mathematical theorems or proofs.
#task[Incorporate the "nature of nuclear force" into this definition here.]
#question[This is the only place in SEMF related to strong force right?]
#postl("postl_strong_force")[Strong Force Phenomenological Description][
We assume that, for strong force, each nucleon (i.e. protons or neutrons) only interact with its nearest neighbor effectively.

Moreover, the strong force doesn't depend on charge (so neutron-neutron, neutron-proton, and proton-proton interaction are of similar magnitude).
]
#remark(base: "postulate")[In reality the logic is actually the _reverse_: we found this volume term as an evidence that the strong force is short-range.]
#thm("thm_semf_strong_force")[Strong Force Contribution][
  We propose strong force contributes to the binding energy by
  $ a_V A - a_S A^(2/3) $
]
#proof[
  #pfstep[binding energy due to strong force is proportional to sum of neighbors for all nucleons][
    #pfstep[binding energy with each of the neighbor should be approximately the same.][
      #pfstep[distance with each of the neighbors are approximately the same.][
        The density of the nucleus is approximately constant.
      ]
      Since the strong force doesn't depend on specific types of nucleon (@postl_strong_force) and distances are the same across neighbors, we have binding energy between each of the neighbor the same.
    ]
    We just count number of neighbors for each nucleon and sum them up together.
  ]
  #pfstep[as an estimate, the binding energy due to strong force is proportional to volume][
    each interior nucleon has the same number of neighbors, so for big enough nucleus
    $ "binding energy due to strong force" prop A $
    But @def_observed_nuclear_radius basically says volume is also $prop A$, thus binding energy is approximately $prop A$.
  ]
  And finally we correct for overcounting at surface: for each surface nucleon, we overcounted neighbors by approximately the same amount. So deduct a term
  $ "surface correction" prop 4pi r^2 prop A^(2/3) $
  as $r prop A^(1/3)$ by @def_observed_nuclear_radius.
]


=== Coulomb Term <sec:coulomb>


=== Asymmetry Term

=== Pairing Term

== Nature of the Nuclear Interactions (Off-syllabus)

== Nuclear Decays

=== Introduction

=== $alpha$ decay: the Quantum Tunneling Model

=== $beta$ decay: Fermi Model


= Particle Physics
Baryon: Heavy weight
Meson: Middle weight (examples are pion (Yukawa's meson))
Lepton: Light weight (e.g. muon, electron, two types of neutrino)

Baryon and Meson are collectively known as hadrons

Dirac's negative energy state of electron and "hole" is precisely what seen in condensed matter physics the "hole" for semi conductor. They are of the same physics!

In fact, this is universal to the QFT

We use overbar to denote the anti-particle.

With this pair particle formalism, pair annilation ($e^- + e^+$) is the same process as compton scattering $e^- + gamma$! #text(red)[But in what sense are they really the same?]

There are two models of neutrino: Dirac and Majorana
