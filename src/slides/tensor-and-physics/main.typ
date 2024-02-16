// Get Polylux from the official package repository
#import "@preview/polylux:0.3.1": *
#import "@preview/physica:0.9.2": *
#import "@preview/gentle-clues:0.4.0": *
#import "@lexuge/templates:0.1.0": *
#import shorthands: *
#import pf3: *

// Make the paper dimensions fit for a presentation and the text larger
#set page(paper: "presentation-16-9", margin: (y: 6pt))
#set text(size: 20pt)

// FIXME: Title being funny
#show: simple.with(
  title: [#v(1em) Tensor and Quantum Information],
  authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
  disp_content: false,
)

#set heading(numbering: none)
#set math.equation(numbering: none)

#let caniso = sym.tilde.equiv
#let becomes = sym.arrow.r.double

#pagebreak()

// Use #polylux-slide to create a slide and style it using your favourite Typst functions
#polylux-slide[
  = What this talk is about?
  We try to discuss and answer:
  #one-by-one[- $V tp W$? $vb(v) tp vb(w)$?][- $V tp (W tp Z)? (V tp W) tp Z? V tp W tp Z?$][- Why $(ketbra(psi, phi))^dagger = ketbra(phi, psi)$?][- Why can $dagger$ in Dirac notation act on complex numbers, operators, and (dual)
    vectors? What exactly is $dagger$?][*Can we find a unified way to understand all? Can we hear the music?*\ ][And
    - Quantum Steering and How tensor is used in proving No-Signaling Theorem.]
]

#polylux-slide[
  = Recaps from Linear Algebra
  #only(
    1,
  )[#def(
      "Dual Space",
    )[
      The dual space of vector space $V$ is defined as $V' equiv cal(L)(V,FF) equiv cal(L)(V)$.

      Vectors $f in V'$ are called dual vectors or linear functionals. The additive
      identity is the $0(vb(v)):= vb(0) in V$.
    ]]#only(
    2,
  )[#def(
      "Dual Basis",
    )[
      Given a basis ${ vb(v)_i }_(i=1)^N$ of $V$, its dual basis ${ vb(v)^i }_(i=1)^N$ are
      defined by
      $ vb(v)^i (vb(v)_j) = cases(0 "if" i eq.not j, 1 "if" i = j) $
    ]]

  #only(
    3,
  )[
    #def(
      "Metric Dual",
    )[
      If $V$ has an inner product, then we can define an _anti-linear_ mapping $L: V to V'$ by
      $ tilde(vb(v))(vb(w) in V) equiv (L vb(v))(vb(w)) = H(vb(v), vb(w)) $
      where we call $tilde(vb(v))$ the metric dual of $vb(v)$.
    ]
    Can be proven: this $L$ is bijective if $V$ is finite-dimensional.
  ]

  #only(
    4,
  )[#thm[$V''$ is canonically isomorphic to $V$ if $V$ is finite-dimensional][
      We define the map $L: V to V''$#footnote[The $L$ here has nothing to do with the $L$ defined for metric dual] by
      $ L(vb(v))(phi) := phi(vb(v)) $
      $L$ is bijective if $V$ is finite-dimensional.
    ]
    In finite-dimensional case (I will assume this henceforth),
    $ V caniso V' caniso V'' $
  ]
]

#polylux-slide[
  = The settings of the game
  #only(
    1,
  )[#def(
      "Tensor",
    )[
      Let $V_1, V_2, dots V_n$ be finite dimensional vector spaces over the same field $FF$.
      A tensor is a multi-linear functional
      $ tau: V_1 times V_2 times dots.c times V_n to FF $
      They form a vector space $cal(L)(V_1, dots.c, V_n)$.
    ] #def[Tensor product of two vectors][
      Given $vb(v) in V, vb(w) in W$, define
      $ vb(v) tp vb(w): V' times W' &to FF\
      (h, g)                      &sendto vb(v)(h) vb(w)(g) equiv h(vb(v)) g(vb(w)) $
    ]
  ]

  #only(2)[#def[Tensor Product for Two Vector Spaces][
      Define
      $ V tp W := span { vb(v) tp vb(w) | vb(v) in V, vb(w) in W } $
      i.e. linear combination of the "simple tensor product".
    ]
    $ vb(v) tp vb(w) in V tp W subset.eq cal(L)(V', W') $
    *Indeed*, can be proven (use the "standard" basis of $V tp W$)
    $ vb(v) tp vb(w) in V tp W = cal(L)(V', W') $
  ]
]

#polylux-slide[
  = Universal Properties and Canonical Isomorphism
  Universal property is what we needed to understand why
  $ (V tp W)' "and" V' tp W' "are the same" $
  Now, $V' tp W' = cal(L)(V, W)$ by previous slide and $V'' = V$. So what we are
  really heading to is
  #align(
    center,
  )[*Linear mappings that eats $V tp W$ are uniquely matched with bilinear mappings
    that eats in $V times W$.*]
]

#polylux-slide[
  == Universal Property - Statement
  #thm[Universal Property][
    1. Let $tau in cal(L)(V, W)$, there exists a unique function $hat(tau) in (V tp W)'$ such
      that
    $ hat(tau)(vb(v) tp vb(w)) = tau(vb(v), vb(w)) $
    for all $vb(v),vb(w)$.

    2. Let $hat(tau) in (V tp W)'$, there exists a unique $tau in cal(L)(V, W)$ such
      that
    $ tau(vb(v), vb(w)) = hat(tau)(vb(v) tp vb(w)) $
    for all $vb(v),vb(w)$.
  ]
  #uncover(
    2,
  )[_However_, tensors are sort of more powerful than multilinear mappings, despite
    the fact these two spaces have the same dimension.]
]

#polylux-slide[
  == So what?
  This isomorphism is indeed very explicit. We know $vb(a)^i tp vb(b)^j in cal(L)(V, W)$.
  By definition of universal property,
  $ ( L_1 overbrace(vb(a)^i tp vb(b)^j, V' tp V') )( underbrace(vb(a)_k tp vb(b)_l, V tp V)) &= vb(a)^i tp vb(b)^j (vb(a)_k, vb(b)_l) \
                                                                                           &= vb(a)^i (vb(a)_k) vb(b)^j (vb(b)_l) = tensor(delta, -k, +i) tensor(delta, -l, +j) $
  where $L_1$ just outputs the unique mapping dictated by the universal property.
  This actually shows us why
  $ underbrace((ket(psi) tp ket(phi)), V tp V)^dagger caniso underbrace(bra(psi) tp bra(phi), V' tp V') "and" (ket(psi) tp bra(phi))^dagger caniso ket(phi) tp bra(psi) $
  And we may just replace $caniso$ with $=$. _Why bother with $L_1$ if you know what to evaluate?_
]

#polylux-slide[
  = Some Thoughts
  #one-by-one[Canonical Isomorphism is Nice!\ ][Some cheap canonical isomorphism out there $ V tp W caniso W tp V $ *Commutativity!!!*\ ][Some not so cheap ones $ (V' tp W') tp Z' caniso V' tp (W' tp Z') caniso cal(L)(V, W, Z) $ To
    prove this one, we need an extended#footnote[Not an official name] universal
    property]
]

#polylux-slide[
  == Extended Universal Property
  #thm[Universal Property - Extended][
    1. Let $Gamma in cal(L)(V, W, Z)$, there exists a unique function $hat(Gamma) in cal(L)(V, W tp Z)$ such
      that
    $ hat(Gamma)(vb(v), vb(w) tp vb(z)) = Gamma(vb(v), vb(w), vb(z)) $
    for all $vb(v),vb(w), vb(z)$.

    2. Let $hat(Gamma) in cal(L)(V, W tp Z)$, there exists a unique $Gamma in cal(L)(V, W, Z)$ such
      that
    $ Gamma(vb(v), vb(w), vb(z)) = hat(Gamma)(vb(v),vb(w) tp vb(z)) $
    for all $vb(v),vb(w), vb(z)$.
  ]
  But
  $ cal(L)(V, W tp Z) = V' tp (W tp Z)' $
]

#polylux-slide[
  == Our Good Friends
  1. Commutativity
  $ V tp W caniso W tp V $
  2. Commutativity with dual.
  $ V' tp W' caniso (V tp W)' $
  3. Associativity
  $ (V tp W) tp Z caniso V tp (W tp Z) caniso cal(L)(V', W', Z') $
]

#polylux-slide[
  = Contraction
  #eg[
    Consider the tensor $tau in V' tp V' = cal(L)(V, V)$, we can define a new tensor $f in V'$ through
    $ f(cdot):= sum_k tau(vb(a)_k, cdot) vb(v)(vb(a)^k) $
    (This is indeed well-defined) It's evident that this is equivalent to
    $ f(cdot):= tau(vb(v), cdot) $
  ]
  This "annihilates" one set of spaces dual to each other (here $V, V'$). Thus the
  name "contraction".
]

#polylux-slide[
  = Self-contraction
  We could define something less obvious to ask a tensor to contract with itself.
]

#polylux-slide[
  = A detour on $dagger$
  #only(1)[
    $dagger$ seems to acts on all sorts of things:
    - Complex numbers: $(i)^dagger = -i$
    - Operators: $A^dagger$
    - Vectors and dual vectors: $ket(phi)^dagger = bra(phi)$
    *What exactly is this then?*
  ]
  #only(
    2,
  )[$dagger$ is just taking *metric dual* of tensors!
    - $CC$ is a vector space over $CC$, and vector space is a tensor space. The inner
      product is just $a^* b$ and the metric dual mapping is just taking $i$ to $i^*$!
      Alternatively, think of $i$ as $i II$.
    - And for operators,
    $ A = sum_(k,l) tensor(A, +k, -l) vb(e)_k tp vb(e)^l $
    And
    $ A^dagger = sum_(k,l) tensor(A, +k, -l)^* vb(e)^k tp vb(e)_l $
    *Note: The dual basis is equal to the metric dual of a basis iff. the basis is
    orthonormal.*

    So indeed $tensor(A^dagger, -k, +l) = tensor(A, +k, -l)^*$. And taking dual of
    an operator gives us the Hermitian!
    - Vector: this is trivial.]
]

#polylux-slide[
  = Writing Tensors Explicitly out in Quantum
  #one-by-one[$ bra(phi), ket(psi) $][$ ketbra(psi, phi) becomes ket(psi) tp bra(phi) $][$ "contraction" braket(phi, psi) $][$ hat(H)_A tp hat(H)_B in cal(H)_A tp cal(H)_A ' tp cal(H)_B tp cal(H)_B ' caniso (cal(H)_A tp cal(H)_A ') tp (cal(H)_B tp cal(H)_B ') $]
]

#polylux-slide[
  = Entanglement to Communicate?
  #eg[Alice and Bob shares some entangled state $ket(chi)$. Alice can measure the
    particle on her half in different basis. Can Bob detects (through measurement on
    his half) which basis Alice measured against, or does Alice even measure?]
]

#polylux-slide[
  = No-Signaling Theorem
  #proof[
    #pfstep[Marginal probability of Bob measuring some basis vector doesn't depends on
      Alice's measurement.][
      $ PP(ket(beta_n)) &= sum_m PP(ket(beta_n) and ket(alpha_m)) = sum_m |(bra(beta_n) tp bra(alpha_m)) ket(chi)|^2 \
                      &= sum_m bra(chi) (ket(beta_n) tp ket(alpha_m)) tp (bra(beta_n) tp bra(alpha_m)) ket(chi) \
                      &= bra(chi) (ket(beta_n) tp bra(beta_n)) tp (sum_m ket(alpha_m) tp bra(alpha_m)) ket(chi) \
                      &= bra(chi) (ket(beta_n) tp bra(beta_n) tp II) ket(chi) \ $
    ]
  ]
]

#polylux-slide[
  == What I left out
  - Not all tuples of numbers are tensors. (_"Tensors transform like a tensor"_)
  - Symmetric and Asymmetric Tensors
  - Inner Product of the Tensor
  - Metric Tensor, Indices Lowering / Raising
  - Einstein Convention, Penrose's Abstract Indices Convention

  == What Tensor can lead to
  - Antisymmetric Tensors $becomes$ Differential Forms $becomes$ Calculus in $RR^n$
  - Tensor Fields, Tensor Calculus, Classical Differential Geometry
]

#pagebreak()

#bibliography("bib.yaml", full: true, style: "american-physics-society")
