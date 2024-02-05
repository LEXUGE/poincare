#import "@preview/physica:0.9.0": *
#import "@preview/gentle-clues:0.4.0": *
#import "@lexuge/templates:0.1.0": *

#show: simple.with(
  title: "Mathematical Methods",
  authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
)

#let unproven = text(red)[This is not proven yet.]
#let unfinished = text(red)[This is not finished yet.]

#let L1 = $cal(L)^1$
#let L2 = $cal(L)^2$
#let Lp = $cal(L)^p$
#let tp = sym.times.circle

#pagebreak()

= Vector Space and Hilbert Space
== Vector Spaces
We omit the general definition of a general vector space. This can be found in
@abdel[Definition 1.1] or @nadir[Page 12]. Unless otherwise stated,
- we understand that $V$ means a vector space.
- we use $FF$ to denote the underlying field of $V$.
- $cal(L)(V, W)$ means the vector space of linear map between vector space $V$ and $W$.
  It has _nothing to do_ with $Lp$ spaces we define later.

We also omit the definition of *linear dependence*, this can be found in
@abdel[Definition 1.3]. Remember linear dependence on infinite set is defined
using linear combination of any finite subsets, because infinite sum requires
the notion of convergence and we don't even have norm on such a general setting.

We give the definition of the span of some set.
#def(
  "Span",
)[
  Let $cal(X) subset.eq V$, $vb(v) in span cal(X)$ if $vb(v)$ can be expressed as
  a linear combination of $cal(X)$. Recall linear combination is finite, so in
  particular,
  $ vb(v) = sum_(i=1)^N c_i vb(u)_i, vb(u)_i in cal(X) $
]

#thm(
  "Span gives a subspace",
)[
  For any $emptyset eq.not cal(X) subset.eq V$, $span cal(X)$ is a subspace of $V$.
]
#proof[
  #pfstep[$vb(0)$ is in $span cal(X)$][
    #pfstep[There exists an vector $vb(v)$ in $cal(X)$][$cal(X)$ is not empty.]
    #pfstep[$vb(0) = 0 cdot vb(v) in span cal(X)$][$0 cdot vb(v)$ is a linear combination $cal(X)$ and by definition of span it's
      included in $span cal(X)$.]
  ]
  #pfstep[Addition is closed in $span cal(X)$][
    #pflet[$vb(v), vb(w) in span cal(X)$.] By definition of span, $vb(v), vb(w)$ can
    be expressed as linear combinations.
    $ vb(v) &= sum_(i=1)^N c_i vb(a)_i, vb(a)_i in cal(X) \
    vb(w) &= sum_(i=1)^M d_i vb(b)_i, vb(b)_i in cal(X) $
    Thus
    $ vb(v) + vb(w) = sum_(i=1)^N c_i vb(a)_i + sum_(i=1)^M d_i vb(b)_i $
    is still a linear combination of ${vb(a)_i, vb(b)_i} subset.eq cal(X)$. Thus $vb(v) + vb(w) in span cal(X)$.
  ]
  #pfstep(
    finished: true,
  )[Scalar multiplication is closed in $span cal(X)$][
    #pflet[$vb(v) in cal(X); vb(v) = sum_(i=1)^N c_i vb(a)_i, vb(a)_i in cal(X)$]
    Thus $lambda vb(v) = sum_(i=1)^N (lambda c_i) vb(a)_i$ is still a linear
    combination of $cal(X)$. Thus $lambda vb(v) in span cal(X)$.
  ]
]

#def(
  "Basis and Dimension",
)[
  If there exists $cal(X) subset.eq V$ such that $span cal(X) = V$ then $cal(X)$ is
  a basis of $V$.

  If there exists a finite set basis $cal(B)$, then $V$ is finite dimensional,
  otherwise $V$ is infinite dimensional.
]

#thm(
  "Finite-dimensional space has a well-defined dimension",
)[
  Let $cal(B)_1, cal(B)_2$ be two basis of some finite-dimensional $V$, then the
  number of elements in $cal(B)_1$ is the same as that of $cal(B)_2$.

  And $V$ has no infinite basis.

  Thus we may define unambiguously the dimension of $V$ as the number of elements
  in any basis of $V$, denoted also as $dim V =: n$.

  #unproven
]

#def(
  "Commonly used infinite-dimensional spaces",
)[
  Just to fix the notation, we define
  $
    cal(P)_n (I) &:= { text("polynomials of order ") lt.eq n text("with domain " I subset.eq RR) } \
    cal(P)(I)    &:= { text("polynomials of any order with domain " I subset.eq RR) }\
    C^(n) (I)    &:= { text("functions with ") n text("-th derivative defined and continuous on " I) }
  $
  And $ C^infinity (I) := union.big_(i=0)^infinity C^(n) (I) $
]

== Non-degenerate Forms and Inner Product
We want to keep the discussion general. So we will adopt the approach in
@nadir[Section 2.6] which doesn't assume the positive-definiteness for a metric.

#def(
  "Non-degenerate Hermitian Form",
)[
  A Hermition Form is a function $H: V times V to CC$ such that
  1. *Sesquilinear* $H$ is anti-linear#footnote[So $H(lambda vb(v), cdot) = macron(lambda) H(vb(v), cdot)$. Anti-linear in first
      argument is _natural_ for adoption in Dirac notation.] in the first argument,
    and linear in the second argument.
  2. *Skew-symmetric* $H(vb(v), vb(w)) = overline(H(vb(w), vb(v)))$
  3. *Non-degenerate* For all $vb(0) eq.not vb(v) in V$, there exists $vb(w) in V$ such
    that $H(vb(v), vb(w)) eq.not 0$
]<non-deg-hermitian>

#def(
  "Metric",
)[
  Let $H$ be a non-degenerate Hermitian Form as defined above. If $H$ is indeed
  symmetric (i.e. $H: V times V to RR$)#footnote[which also implies underlying field is $RR$, as $RR in.rev H(vb(v), i vb(w)) = i H(vb(v), vb(w)) in CC$ wouldn't
    work.]. Then we say $H$ is also a metric.
]

#info[
  The reason we require "realness" for metric is more like a convention, and
  related to how later we lower and raise indices. In the language of Einstein
  notation, the "metric dual" $vb(tilde(v))$ of $vb(v)$ is given by
  $ tensor(tilde(v), -nu) = tensor(H, -mu, -nu) tensor(v, +mu) $
  And if $H$ is not symmetric (underlying space is not real), then we have to
  write
  $ tensor(tilde(v), -nu) = tensor(H, -mu, -nu) overline(tensor(v, +mu)) $
  instead. This is due to the anti-linear nature of the first argument of $H$. #text(
    red,
  )[This is actually gonna be complicated if not real. How will we think of $f(vb(v))$ in
    Einstein notation if $f$ is _anti-linear_ functional? Apparently $tensor(f, -mu) overline(tensor(v, +mu)) eq.not overline(tensor(f, -mu)) tensor(v, +mu)$.
    How do we explain such asymmetry?]

  The whole point is: we are calling $H$ the metric tensor, and by definition, a
  tensor must be multi-linear instead of sesquilinear.
]

#def(
  "Inner Product",
)[
  An inner product $braket(cdot, cdot): V times V to CC$ is a Non-degenerate
  Hermition Form that is
  - *positive definite* $braket(vb(v), vb(v)) > 0$ for all $vb(v) eq.not vb(0)$
]<inner-product>

#info[
  Later when we introduce more Dirac notation, we will see $braket(vb(v), vb(w))$ is
  best not to be thought as a result of inner product but rather as dual vector $bra(vb(v))$ acting
  on vector $ket(vb(w))$. However, the definition of $bra(vb(v))$ depends on the
  canonical identification of $V^*$ with $V$, which depends on the inner product#footnote[Actually positive-definiteness is not required, non-degeneracy is enough. And
    this is indeed the case for special relativity, where we have the canonical
    duality but not the inner product. And we can use metric to "raise/lower the
    indices".]. Therefore, to be non-cyclic, we should for now think of $braket(vb(v), vb(w))$ as
  one piece: the inner product, rather than composition $bra(vb(v))(ket(vb(w)))$ with
  lines and bracket removed.
]

/*#warning[
    Notation: we used $H$ to denote non-degenerate Hermitian form (@non-deg-hermitian) and $braket(cdot, cdot)$ for inner product @inner-product. However, we _will_ mix them together, so $braket(cdot, cdot)$ will not necessarily be
]*/

#thm(
  "Cauchy-Schwartz inequality",
)[
  For all $vb(v), vb(w) in V$ (where $V$ has inner product), we have
  $ |braket(vb(v), vb(w))|^2 lt.eq braket(vb(v), vb(v)) braket(vb(w), vb(w)) $
  #unproven
]

There is another, _independent_ notion of norm for vector space.
#def(
  "Norm",
)[
  A norm $norm(cdot): V to RR$ is a function such that
  1. *Scaling* $norm(lambda vb(a)) = |lambda| norm(vb(a))$.
  2. *Positive-definiteness* $norm(vb(a)) gt.eq 0$ and takes $0$ when $vb(a) = vb(0)$.
  3. *Triangular inequality* $norm(vb(a) + vb(b)) lt.eq norm(vb(a)) + norm(vb(b))$.
]<norm-axioms>

If a space has an inner product $braket(cdot, cdot)$, we can define a *induced
norm* $norm(cdot)$ simply by
$ norm(vb(v)) = sqrt(braket(vb(v), vb(v))) $
#thm(
  "Inner Product indeed induces norm",
)[
  Norm defined by $ norm(vb(v)) = sqrt(braket(vb(v), vb(v))) $ satisfies the
  @norm-axioms.
  #unproven
]

Again, there exists many interesting norms like $p$-norm, but they are not
useful for our theory and applications.

From inner product and there induced norm, we have a very important notion of
orthonormal basis.
#def(
  "Orthonormal and orthogonal basis",
)[
  Let $V$ be equipped with a non-degenerate Hermitian form $H$. A basis $cal(B)$ is
  orthogonal if for any $vb(v), vb(w) in cal(B)$#footnote[We are formulating in such a weird way to contain the case where $cal(B)$ is
    uncountable. However, such case would not occur in this notes, and not useful in
    physics to my knowledge.],
  $ H(vb(v), vb(w)) eq.not 0 text("if and only if") vb(v) = vb(w) $

  A basis is orthonormal if it's orthogonal and for any $vb(v) in cal(B)$, $H(vb(v), vb(v)) = plus.minus 1 $
]<orthonormal-basis>

#info[
  Notice we defined orthonormal with $H(vb(v), vb(v)) = plus.minus 1$. This is to
  include the useful physical examples like special relativity. Note also that
  @orthonormal-basis doesn't depends on inner product! non-degenerate Hermitian
  form is enough!
]

We have a very beautiful (yet advanced to prove) result.
#thm(
  "Every space has orthonormal basis",
)[
  Given any basis $cal(B)$, we can construct an orthonormal basis $cal(B')$. #text(
    red,
  )[we actually also have claim on number of positive and negative norm!]
  #unproven
]

== $cal(L)^1, cal(L)^2$ Space
Much of our problem and solution are set in the $cal(L)^1, cal(L)^2$ spaces. A
lot of mathematical constructs is needed to arrive at a rigorous theory. We thus
will only pay attention to properties and subtleties important to our use.

Specifically, integrals in this notes should be Lebsegue integral in order for
things to work. However, since we will not care about pedagogical cases and
every Riemann integral gives the same results as Lebsegue integral, we will just
think of Riemann integral (with some additional properties) anyway.

#def(
  [$Lp$ spaces],
)[
  Let $I$ be some interval (possibly infinite) on $RR$, $f: RR to CC$ is in $Lp(I)$ if
  $ integral_I |f(x)|^p differential(x) < oo $
]

Till now, $L1, L2$ are just sets. We need to show that they are actually vector
spaces. Moreover, $L2$ will actually be an inner product (and thus also normed)
space.

Unfortunately, we cannot give a rigorous proof on integrability. However, we
will do our best to give some insights on why it's a vector space.
#thm([$L1$ spaces are vector spaces.])<L1-is-a-vector-space>
#proof[
  The "hard" part is to prove if $f,g in L1$, then $f+g in L1$.
  #pfstep[$|f(x) + g(x)| lt.eq |f(x)| + |g(x)|$][Triangular inequality in $RR$.]
  #pfstep(
    finished: true,
  )[if $|f(x) + g(x)|$ is integrable, then it's integral is finite.][For Riemann integral (and integrable $f,g$), if $f lt.eq g$, $integral_I f lt.eq integral_I g$.
    Thus $integral_I |f(x) + g(x)| lt.eq integral_I |f(x)| + |g(x)| < oo$ if $|f(x) + g(x)|$ is
    integrable.]
]

#thm([$L2$ spaces are vector spaces.])<L2-is-a-vector-space>
#proof[
  Again, the hard part is to prove if $f,g in L2$, then $f+g in L2$.
  #pfstep(
    finished: true,
  )[$|f(x) + g(x)|^2 lt.eq 2(|f(x)|^2 + |g(x)|^2)$][
    #pfstep[For any $a,b in CC$, $2|a||b| lt.eq |a|^2 + |b|^2$][
      $ 0 &lt.eq (|a| - |b|)^2 \
        &= |a|^2 + |b|^2 - 2|a||b| $
      Thus $2|a||b| lt.eq |a|^2 + |b|^2$.
    ]
    #pfstep[For any $a in CC$, $|a| gt.eq Re(a)$][
      $ |a|^2 gt.eq |a|^2 - Im(a)^2 = Re(a)^2 $
    ]
    And $ |f(x) + g(x)|^2 &= |f(x)|^2 + |g(x)|^2 + overline(f(x)) g(x) + f(x) overline(g(x)) \
                    &= |f(x)|^2 + |g(x)|^2 + 2 Re(f(x) g(x)) \
                    &lt.eq |f(x)|^2 + |g(x)|^2 + 2 |f(x)g(x)| \
                    &= |f(x)|^2 + |g(x)|^2 + 2 |f(x)||g(x)| \
      &lt.eq |f(x)|^2 + |g(x)|^2 + |f(x)|^2 + |g(x)|^2 = 2(|f(x)|^2 + |g(x)|^2) $
  ]

  Then we can just follow the reasoning in @L1-is-a-vector-space
]

One further step is needed, we need to identify $f,g$ by
$ f tilde g arrow.l.r.double integral_I |f - g|^p = 0 $

This equivalence relation gives equivalence classes $[f]$.

So $f = g$ means $[f] = [g]$ which is equivalent to saying $f tilde g$. #text(
  red,
)[Actually much is left out: how do we know integral will be well-defined for
  equivalence classes?]

Under this identification, with Minkowski's inequality#footnote[For $L1$, our proof in @L1-is-a-vector-space is enough for proving triangular
  inequality in @norm-axioms. However, for $L2$, our loose bound in
  @L2-is-a-vector-space $|f(x) + g(x)|^2 lt.eq 2(|f(x)|^2 + |g(x)|^2)$ is not
  enough.], we have actually $Lp$ as normed spaces, with norm
$ norm(f) := (integral_I |f|^p)^(1/p) $

Now, we want to make $L2$ (which we use mainly) an inner product space. This is
done by defining inner product
$ braket(f, g) := integral_I overline(f) g $

#thm[$L2$ is an inner product space][
  $ braket(f, g) := integral_I overline(f) g $ satisfies the @inner-product
]
#proof[
  #pfstep[$braket(f, g)$ is sesquilinear][
    By linearity of the integral
  ]
  #pfstep[$braket(f, g)$ is skew-symmetric][
    We have by definition of complex integral on real line that,
    $ integral_I f = integral_I Re(f) + i integral_I Im(f) $
    Thus $ overline(braket(f, g)) = overline(integral_I overline(f)g) = integral_I f overline(g) = braket(g, f) $ by
    simple algebra.
  ]
  #pfstep(
    finished: true,
  )[$braket(f, f) gt.eq 0$ and takes equality only when $f=0$][
    For Riemann integral, $f gt.eq 0$ implies $integral_I f gt.eq 0$. Thus $|f|^2 gt.eq 0$ means $braket(f, f) gt.eq 0$.

    By our identification, we know $braket(f, f) =0 arrow.r.double f tilde 0 arrow.r.double f = 0 $ by
    definition.
  ]
]

#info[Riemann integral has integrability issues. In particular, we could have $f^2, g^2$ integrable
  while $f g$ don't, which makes inner product ill-defined. See @abdel[Exercise
  1.21] for a simple example based on indicator function of $QQ$.

  But such subtleties don't affect the general applications.]

=== Relation between $L1, L2$

=== Sequences and limits in $L2$

=== Orthonormal basis in $L2$

= Strum-Liouville Problem

= Fourier Transform

= Dirac Notation
Dirac notation is an effective convention for writing linear algebra for quantum
mechanics, relying on the following properties of the underlying space $V$:
- The space is an inner product space ($V$ is a Hilbert space, which is a complete
  complex inner product space)
- The dual space $V'$ is canonically isomorphic to the $V$ through inner product

Because of this, we thus first talk about dual space and its canonical
identification.== Dual Space
#def(
  "Dual Space",
)[
  The dual space of vector space $V$ is defined as $V' equiv cal(L)(V, FF)$.

  Vectors $f in V'$ are called dual vectors or linear functionals. The additive
  identity is the $0(vb(v)):= vb(0) in V$.
]

#def(
  "Dual Basis",
)[
  Given a basis ${ vb(v)_i }_(i=1)^N$ of $V$, its dual basis ${ vb(v)^i }_(i=1)^N$ are
  defined by
  $ vb(v)^i (vb(v)_j) = cases(0 "if" i eq.not j, 1 "if" i = j) $
]<dual-basis>

#info[
  This $vb(v)^i (vb(v)_j)$ _is_ indeed the coordinate representation of the $(1,1)$ identity
  tensor
  $ II(vb(v), f) := f(vb(v)) $
  under basis ${ vb(v)^j tp vb(v)_i }$. So in fact from the perspective of tensor
  component we can also write
  $ overbrace(
    vb(v)_j tp vb(v)^i (II) = II(vb(v)_j tp vb(v)^i),
    "think " II "as double dual",

  ) = II(vb(v)_j, vb(v)^i) = vb(v)^i (vb(v)_j) = tensor(delta, -j, +i) $
  where $delta equiv II$, and $tensor(delta, -j, +i)$ is its component.
  #text(yellow)[Actually this is where the universal property kicks in?]
]

An important property
#thm("Dual Basis gives coordinates")[
  For any $vb(w) = sum_(i=1)^N w^i vb(v)_i $,
  $ w^i = vb(v)^i (vb(w)) $
]<dual-basis-give-coordinate>
#proof[
  Plug in the expansion of $vb(w)$ to the right-hand side and evaluate $vb(v)^i (vb(w))$ by
  @dual-basis.
]

#thm[Dual Basis is a Basis of $V'$ when $V$ is finite-dimensional]<dual-basis-is-a-basis>
#proof[
  #pfstep[Dual Basis is linearly independent][
    Consider the linear combination $sum_(i=1)^N a_i vb(v)^i = 0 in V'$, apply it to $vb(v)_k$ one
    by one
    $ 0 = sum_(i=1)^N a_i vb(v)^i (vb(v)_k) = sum_(i=1)^N a_i tensor(delta, +i, -k) = a_k =0 $
    Thus $a_k = 0$ for all $k$.
  ]
  #pfstep[It spans $V'$][
    #pfstep[For any $f in V'$, $f = sum_(i=1)^N f(vb(v)_i) vb(v)^i $][
      (This is actually one example of the tensor contraction.) We verify by plugging
      in. Expand an arbitrary $vb(w) equiv sum_(i=1)^N w^i vb(v)_i in V$. Then $ f(vb(w)) &= f(sum_(i=1)^N w^i vb(v)_i) \
               &= sum_(i=1)^N w^i f(vb(v)_i) \
               &= sum_(i=1)^N f(vb(v)_i) vb(v)^i (vb(w)) \
               &= (sum_(i=1)^N f(vb(v)_i) vb(v)^i ) (vb(w)) $
      where the second last line is by @dual-basis-give-coordinate.
    ]
  ]
]

== Metric Dual
#def(
  "Metric Dual",
)[
  If $V$ has an non-degenerate Hermitian form, then we can define an _anti-linear_ mapping $L: V to V'$ by
  $ tilde(vb(v))(vb(w) in V) equiv (L vb(v))(vb(w)) = H(vb(v), vb(w)) $
]

Now $L$ has some important properties to make it work
#thm[$L$ is injective]
#proof[
  We need to show $L(vb(v)) = L(vb(w)) arrow.double vb(v) = vb(w)$
  #pfstep[$tilde(vb(v)) = tilde(vb(w)) arrow.double H(vb(v) - vb(w), vb(a)) = 0$ for all $vb(a)$][
    #pfstep[For all $vb(a)$, $tilde(vb(v))(vb(a)) = tilde(vb(w))(vb(a))$][By definition of $tilde(vb(v)) = tilde(vb(w))$]
    #pfstep[$H(vb(v) - vb(w), vb(a)) = 0$][
      Expand $tilde(vb(v)) = tilde(vb(w))$ by definition and use anti-linearity in the
      first argument of $H$
    ]
  ]
  #pfstep(
    finished: true,
  )[$vb(v) = vb(w)$][
    By non-degeneracy of $H$ (see @non-deg-hermitian), if $vb(v) - vb(w) eq.not vb(0)$,
    then there exists $vb(a)$ such that $H(vb(v) - vb(w), vb(a))$. However, this is
    not the vase by Claim 1. Thus contradictory.
  ]
]

#thm[Metric Dual of a basis is its dual basis if and only if orthonormal][
  Let $cal(B) = {vb(v)_i}$ be a basis, then its dual basis $cal(B)'$ is equal to
  applying metric dual to each of its basis vector if and only if $cal(B)$ is
  orthonormal.
]
#proof[
  #pfstep[Orthonormal $arrow.double$ metric dual is dual basis][
    We have#footnote[Only under such specific basis would the coordinate representation of $H$ be
      evaluated according to Kronecker delta. In fact, there is no good definition of
      (2,0) identity tensor, so $tensor(delta, -i, -j)$ should not be think of as a
      coordinate representation of some tensor.]#footnote[We are _not_ raising the indices of $vb(v)$ to $tilde(vb(v))^i$ because this $i$ is
      not the component of $vb(v)$, instead, it's a indices for basis.]
    $ tilde(vb(v))_i (vb(v)_j) := H(vb(v)_i, vb(v)_j) = tensor(delta, -i, -j) $
    Thus by definition of @dual-basis we know $tilde(vb(v))_i = vb(v)^i$.
  ]
  #pfstep(
    finished: true,
  )[Metric dual is dual basis $arrow.double$ orthonormal][
    Metric dual is dual basis means#footnote[Again, as in previous footnotes, the indices positions etc doesn't match isn't
      an issue as the underlying tensors ($H$ and $II$) are not of the same type and
      are not equal.]
    $ tilde(vb(v))_i (vb(v)_j) := H(vb(v)_i, vb(v)_j) = vb(v)^i (vb(v)_j) = tensor(delta, -j, +i) $
    Thus $cal(B)$ is orthonormal.
  ]
]

#thm[$L$ is surjective if $V$ is finite-dimensional]<metric-dual-is-surjective>
#proof[
  #pfstep[$dim V' = dim V$][
    By @dual-basis-is-a-basis, the basis of $V'$ has the same number of elements as
    basis of $V$.
  ]
  #pfstep(
    finished: true,
  )[$dim img L = dim V$][$dim img L = dim V - dim ker L = dim V = dim V'$]
]

Thus, if $V$ is finite-dimensional, then
#thm[$V$ and $V'$ are canonically isomorphic if $V$ is finite-dimensional]
#proof[
  They are canonically isomorphic through the bijective map $L: V to V'$. Notice
  how the definition of $L$ doesn't depends on choice of basis.
]

== Double Dual
We now have canonical identification of another space with $V$.

#thm[$V''$ is canonically isomorphic to $V$ if $V$ is finite-dimensional][
  We define the map $L: V to V''$#footnote[The $L$ here has nothing to do with the $L$ defined for metric dual] by
  $ L(vb(v))(phi) := phi(vb(v)) $
  Prove this is bijective if $V$ is finite-dimensional.
]
#proof[
  #pfstep[$L$ is injective#footnote[The proof that we give actually applies even if $V$ is infinite dimensional. See
      also @inf-dim-dual-vector-kernel]][This is equivalent to proving $L(vb(v)) = 0$ if and only if $vb(v) = vb(0)$. The
    if part is evident, the only if part is as follows.
    #pfstep[If $phi(vb(v)) = 0$ for all $phi in V'$, then $vb(v) = vb(0)$][
      If $vb(v)$ is non-zero, then we can extend a basis $cal(B)$ of $V$ from it,
      construct the dual basis of $cal(B)$. Then $vb(v)'(vb(v)) = 1 eq.not 0$
      Thus $vb(v) = 0$
    ]
  ]

  #pfstep[$L$ is surjective][
    #pfstep[$dim V = dim V' = dim V''$ in finite-dimensional case][
      By @dual-basis-is-a-basis, $dim V = dim V'$. Since $V'$ is also finite
      dimensional, we have $dim V' = dim V''$ as $V''$ is just the dual of $V'$.
    ]
    by the same argument as @metric-dual-is-surjective, we have $L$ being surjective
    as well.
  ]
]

== Introducing Dirac Notation
Now with these preparatory works, we can introduce Dirac notation.

#def("Dirac notation")[

]

= Tensors

= Groups

#pagebreak()

#bibliography("./bib.yaml", style: "ieee")

