#import "/templates/main.typ": simple, preamble, thm_typzk
#import preamble: *
#import thm_typzk: *

#show: simple.with(
  title: "B6 Lecture Notes", authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
)
#show: setup
#show: thm_setup

#pagebreak()

= Simple Material Structure and Properties
== Chemical Bonds
=== Ionic Bond
#context gen_section_graph()
Summary: ionic bond is formed by electron transfer and then electrostatic attraction.

#def("def_ionization_energy")[Ionization Energy][
	Let $E_A$ be the energy of atom $A$. $E_(A^+)$ be the energy of ion $A^+$, $E_e = 0$ be the energy of a free electron with no kinetic energy (and thus no energy).

	Ionization energy is the energy difference between the end state (ion + electron) and start state (one atom):
	$ ("Ionization")_A &= E_(A^+) + E_e - E_A  \
	&= E_(A^+) - E_A
	$
	In other words, "the energy required to remove the outermost valence electron."
]
#def("def_electron_affinity")[Electron Affinity][
	Let $E_A$ be the energy of atom $A$. $E_(A^-)$ be the energy of ion $A^-$, $E_e = 0$ be the energy of a free electron with no kinetic energy (and thus no energy).

	Ionization energy is the energy difference between the end state (ion) and start state (atom + electron):
	$ ("Ionization")_A &= E_(A^-) - E_A - E_e \
	&= E_(A^-) - E_A
	$
]
#def("def_cohesive_energy")[Cohesive Energy][
	defined as #text(red)[negative] of the energy difference between end state (AB attracted together due to electrostatic potential) and start state (ions $A^+$ and $B^-$):
	$ - E_"coh" = E_(A B) - E_(A^+) - E_(B^-) $
]

#remark(base: "definition")[
	The end (bound) state has less energy than the original two far apart ions. So binding releases energy.

	I don't know why Steve Simon @simonOxfordSolidState2017 would call this a "energy gain" when forming ionic bound. Because this is not an energy gain for $A B$ themselves
]
#def("def_ionic_bond", back_links: ("def_electron_affinity", "def_ionization_energy", "def_cohesive_energy"))[Ionic Bond][
	Take two atoms A and B. If it's energetically favourable#footnote[Meaning the resulting state has less energy] to:
	1. Transfer electrons from A to B (or B to A). This involves @def_ionization_energy, @def_electron_affinity.
	$ A, B -> A^+, B^- $
	2. And attract together by Coulomb potential. This involves @def_cohesive_energy.
	$ A^+ + B^- -> A B $
	then they form ionic bond.

	Quantitatively, the energy difference is:
	$ Delta E &= E_(A B) - E_(A) - E_(B) \
		&= underbrace(E_(A B) - E_(A^+) - E_(B^-), - E_"coh") + underbrace( E_(A^+) - E_A, ("Ionization Energy")_A) + underbrace( E_(B^-) - E_B, ("Electron Affinity")_B) $
]
#remark(base: "definition")[
	(mainly from @simonOxfordSolidState2017)
	1. Coulomb potential is quite strong and thus hard to break. This means ionic bond forms solid typically with high melting point.
	2. Water is highly polarized. Thus they could (because energetically favorable?) reform the bond and thus dissolve e.g. $"NaCl"$.
]

=== Covalent Bond
#context gen_section_graph()
Summary: covalent bond is formed by two identical atoms when electrons are shared between two atoms (_again, energetically favourable_).
==== Simple Picture

==== Tight Binding Theory
The variational method used here (also known as LCAO#footnote[Linear Combination of Atomic Orbitals]) turns out to be important and used later in "1D electron periodic potential model" as well.

#def("A")[][]


#pagebreak()

= Scattering Theory
#task[
	I don't really yet appreciate the connection between the "optical" or "diffraction" interpretation of scattering and the Laure condition.
	And why is it $2theta$ in powder scattering experiment?
]

Discarding the preceding factor, we have
$ S_(h k l) = S_"lattice" times S_"basis" $
The above formula comes from convolution theorem because Fermi Golden Rule gives a Fourier Transform
$S_"lattice" eq.not 0$ as long as we ensure that $vb(G)$ gives a reciprocal lattice vector (by definition of reciprocal lattice vector $vb(G)$). And this will not be the case if we don't use orthonormal basis for FCC and BCC.
$S_"basis"$ can still give $0$ even if $S_"lattice"$ is not.

Some times, definition of basis and lattice are flexible. A crystal can be both interpreted as having a FCC lattice or a simple cubic lattice with a different (and bigger) basis.

Regarding multiplicity. For simplicity, consider there are only a finite number (say $N$ in total) of orientations possible. And each small constituent in the powder of the crystal has equal probability in being in any orientations. If given the laser wavelength, there are $3$ different orientations all diffracting to the same resulting angle, while another angle will only have $2$ orientations causing diffraction onto that, then there will be a ratio of $3/2$ in the relative intensity of those two angles.

#question[But how can there be multiple RLV diffracting to the same resulting angle? Actually it's evident as different orientations are gonna be "equivalent" if they can transform into each other by rotation. in other word The distance between their crystal plane is the same.]

Moreover, the crystal itself has a rotational symmetry, so it's actually just wrong to separate those RLVs in the same rotational equivalent class into different RLV. Multiplicity basically recovers this fact.

= Semiconductor and Band Structure
== Free Electron Theory
#task[
	How is this even related to scattering theory?
]
#task[Again, why are we requiring at the bottom of parabolic? Does effective mass has any thing to do with stability?#link("zotero://open-pdf/library/items/7NSL47J3?page=182&annotation=7BXLHILZ") Hint: this is probably explained in chapter 17]
#task[We should really contrast the free electron theory with the tight binding model. What are the assumptions that we made that makes one "free" and another "tight bound"?]

#task[This is violating the assumption of perturbation theory where we are supposed to do perturbation for states in the same energy eigentstates.#link("zotero://open-pdf/library/items/7NSL47J3?page=182&annotation=YLN3PCMC")]

#task[Why does having potential change the shape of Fermi surface? Does it change the density of states? @simonOxfordSolidState2017[Pg 176]]

// Needed to disable the auto typzk generation
#show heading: it => it.body
#bibliography("./ref.bib", style: "ieee")
