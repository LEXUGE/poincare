#import "@preview/physica:0.9.2": *
#import "@preview/gentle-clues:0.4.0": *
#import "@lexuge/templates:0.1.0": *
#import shorthands: *
#import pf3: *

#show: simple.with(
  title: "Mathematical Methods",
  authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
)

#let unproven = text(red)[This is not proven yet.]
#let unfinished = text(red)[This is not finished yet.]

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

== Dual Space
<sec-dual-space>
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

=== Metric Dual
#def(
  "Metric Dual",
)[
  If $V$ has an non-degenerate Hermitian form, then we can define an _anti-linear_ mapping $L: V to V'$ by
  $ tilde(vb(v))(vb(w) in V) equiv (L vb(v))(vb(w)) = H(vb(v), vb(w)) $
]<metric-dual>

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
]<metric-dual-is-dual-basis>
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

=== Double Dual
We now have canonical identification of another space with $V$.

#thm[$V''$ is canonically isomorphic to $V$ if $V$ is finite-dimensional][
  We define the map $L: V to V''$#footnote[The $L$ here has nothing to do with the $L$ defined for metric dual] by
  $ L(vb(v))(phi) := phi(vb(v)) $
  Prove this is bijective if $V$ is finite-dimensional.
]<double-dual-isomorphism>
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

#pagebreak()

= Tensors
There are two main concepts:
- Tensor
- Tensor Product $tp$
The idea is that any (multi-)linear object is a tensor. And tensor product is an
operation that helps us to build multi-linear object out of linear objects (e.g.
vector spaces).

#info[
  Without otherwise stated, in this section, all operator of the form $V_1 times V_2 times dots.c times V_n to W$ are
  (multi-)linear.
]<conv-all-multi-linear>

== Tensors

#def(
  "Tensor",
)[
  Let $V_1, V_2, dots V_n$ be finite dimensional vector spaces over the same field $FF$.
  A tensor is a multi-linear functional
  $ tau: V_1 times V_2 times dots.c times V_n to FF $
  If in particular,
  $ V_1 times V_2 times dots.c times V_n = overbrace(V times V times dots.c times V, r "times") times underbrace(V' times V' times dots.c times V', s "times") $
  where $r+s = n$ of course, then we call $tau$ a *type $(r,s)$ tensor on vector
  space $V$*.
]<def-tensor>

#thm(
  "Tensors of the same signature form a vector space",
)[
  This means,
  $ cal(L)(V_1, V_2, dots.c, V_n) := \{ tau| tau: V_1 times V_2 times dots.c times V_n to FF \} $
  is a vector space (with addition and scalar multiplication properly defined). We
  call such space tensor space.

  In particular, tensors of the type $(r,s)$ over the same vector space $V$ forms
  a space. We denote such space as
  $ tau^r_s (V) $
  as we use such space a lot.
]<tensors-form-space>
#proof[
  We define the $+, cdot$ operator as usually defined for functions. It's
  straightforward to verify multi-linearity is preserved under these operations
  and all axioms are satisfied.
]

== Tensor Products
Now, much of the ink will be devoted to define the tensor product $tp$ and how
this operator gives a unified way to construct tensor spaces.
#def[Tensor product of two vectors][
  Given $vb(v) in V, vb(w) in W$, define
  $ vb(v) tp vb(w): V' times W' &to FF\
  (h, g)                      &sendto vb(v)(h) vb(w)(g) equiv h(vb(v)) g(vb(w)) $
  where $vb(v)(h) vb(w)(g) equiv h(vb(v)) g(vb(w))$ is due to
  @double-dual-isomorphism.
]<tp-vectors>

By @def-tensor, $vb(v) tp vb(w)$ is a tensor. And indeed it lives in the tensor
space $cal(L)(V', W')$.

We now are set to explore the dimension and basis for $cal(L)(V', W')$.

#thm[Basis of tensor space][
  Let $n = dim V, m = dim W$, ${vb(a)_i}_(i=1)^n$ be a basis of $V$, ${vb(b)_j}_(j=1)^m$ be
  a basis of $W$, the set
  $ { vb(a)_i tp vb(b)_j in cal(L)(V', W')} $
  is a basis of the vector space $cal(L)(V', W')$
]<basis-of-tensor-space>
#proof[
  Let ${vb(a)^i}, {vb(b)^j}$ be the dual basis (@dual-basis) of ${vb(a)_i}, {vb(b)_j}$.
  #pfstep[${ vb(a)_i tp vb(b)_j}$ is linearly independent][
    Let $sum_(i,j) c_(i,j) vb(a)_i tp vb(b)_j = 0$.
    #pfstep[$c_(i,j) = 0$ for all $i,j$][
      $
        0 = (sum_(i,j) c_(i,j) vb(a)_i tp vb(b)_j) (vb(a)^k, vb(b)^l) &= sum_(i,j) c_(i,j) vb(a)_i tp vb(b)_j (vb(a)^k, vb(b)^l) \
                                                                      &= sum_(i,j) c_(i,j) vb(a)^k (vb(a)_i) vb(b)^l (vb(b)_j) \
                                                                      &= c_(k,l)
      $
    ]
    By definition of linear independence, ${ vb(a)_i tp vb(b)_j}$ is linearly
    independent.
  ]

  #pfstep(
    finished: true,
  )[${ vb(a)_i tp vb(b)_j}$ spans $cal(L)(V', W')$][
    Let $tau in cal(L)(V', W')$.
    #pfstep[$tau = sum_(i,j) tau(vb(a)^i, vb(b)^j) vb(a)_i tp vb(b)_j$ ][
      For all $h = sum_i h_i vb(a)^i, g = sum_j g_j vb(b)^j$, we have
      $ (sum_(i,j) tau(vb(a)^i, vb(b)^j) vb(a)_i tp vb(b)_j) (h,g) &= sum_(i,j) tau(vb(a)^i, vb(b)^j) vb(a)_i tp vb(b)_j (h,g) \
                                                                 &= sum_(i,j) tau(vb(a)^i, vb(b)^j) vb(a)_i (h) vb(b)_j (g) \
                                                                 &= sum_(i,j) tau(vb(a)^i, vb(b)^j) h_i g_j \
                                                                 &= tau(sum_i h_i vb(a)^i, sum_j g_j vb(b)^j) = tau(h, g) $
    ]
    where we used @dual-basis-give-coordinate in the third line.
  ]
]

#remark[This proves that $dim cal(L)(V', W') = dim V' dim W' = dim V dim W$ for
  finite-dimensional $V, W$.]

#remark[By switching $V'$ and $V$ and etc., we have also got $dim cal(L)(V, W) = dim V dim W$.]

Now, we define the tensor product for two vector spaces.

#def[Tensor Product for Two Vector Spaces][
  Define
  $ V tp W := span { vb(v) tp vb(w) | vb(v) in V, vb(w) in W } $
]<tp-spaces>

And indeed

#thm[$V tp W = cal(L)(V', W')$]<tp-gives-tensor-space>
#proof[
  #pfstep[$V tp W subset.eq cal(L)(V', W')$][
    $vb(v) tp vb(w) in cal(L)(V', W')$ and $cal(L)(V', W')$ is a vector space, thus
    linear combinations of $vb(v) tp vb(w)$ still lives in $cal(L)(V', W')$.
  ]
  #pfstep(
    finished: true,
  )[$cal(L)(V', W') subset.eq V tp W$][
    Clearly, ${ vb(a)_i tp vb(b)_j } subset V tp W$ where $vb(a)_i, vb(b)_j$ are
    defined as in @basis-of-tensor-space. By @basis-of-tensor-space, we know
    $ cal(L)(V', W') = span { vb(a)_i tp vb(b)_j } subset.eq span { vb(v) tp vb(w) | vb(v) in V, vb(w) in W } equiv V tp W $
  ]
]

#remark[Similarly,
  $ V' tp W' = cal(L)(V, W) $
]

This means, at least in the bilinear case, all tensors can be completely
reconstructed from tensor product operation!

Now, as it would later prove to be useful, we want to:
- Define the dual of the tensor space.
- Use tensor product to construct $cal(L)(V, W, Z)$.
- For $tau^r_s (V)$ and $V$ with non-degenerate Hermitian Form $H$ (or inner
  product), we want to define inner product on $tau^r_s (V)$

== Universal Property
Universal Property will be a promising tool that allows us to show
$ (V tp W)' caniso V' tp W' $
in @dual-is-commutative-with-tp and
$ (V tp W) tp Z caniso V tp (W tp Z) caniso cal(L)(V', W', Z') $
where $caniso$ means canonically isomorphic.

#thm[Universal Property][
  1. Let $tau in cal(L)(V, W)$, there exists a unique function $hat(tau) in (V tp W)'$ such
    that
  $ hat(tau)(vb(v) tp vb(w)) = tau(vb(v), vb(w)) $
  for all $vb(v),vb(w)$.

  2. Let $hat(tau) in (V tp W)'$, there exists a unique $tau in cal(L)(V, W)$ such
    that
  $ tau(vb(v), vb(w)) = hat(tau)(vb(v) tp vb(w)) $
  for all $vb(v),vb(w)$.
]<univ-prop-1>
#proof[See @ladr[Theorem 9.79, page 375], though the actual proof is neither hard nor
  long.]

This is immediately yields

#thm[$(V tp W)' caniso V' tp W'$]<dual-is-commutative-with-tp>
#proof[
  We are basically showing that @univ-prop-1 gives us a canonical isomorphism
  between $cal(L)(V, W)$ and $(V tp W)'$.
  #pfstep[$dim cal(L)(V, W) = dim (V tp W)'$][
    By @tp-gives-tensor-space, we have
    $ dim cal(L)(V, W) = dim V tp W $
    Since it's finite-dimensional, we have $dim (V tp W)' = dim V tp W$ as well.
  ]
  Now universal property allows us to define a mapping $L_1: cal(L)(V, W) to (V tp W)'$.
  Define
  $ L_1 tau = hat(tau) $
  where $tau, hat(tau)$ are given in @univ-prop-1 part 1. This is well-defined as
  part 1 asserts that for any $tau$, such $hat(tau)$ is unique.

  #pfstep[$L_1$ is injective][
    If $L_1 tau = vb(0)$, then by definition of @univ-prop-1,
    $ tau(vb(v), vb(w)) = vb(0)(vb(v) tp vb(w)) = 0 $ for all $vb(v), vb(w)$ This
    means $tau = vb(0)$. Thus $ker L_1 = {vb(0) in cal(L)(V, W)}$.
  ]

  Since dimension match and $L_1$ is injective, we can use the same technique as
  in @metric-dual-is-surjective to prove $L_1$ is surjective as well.

  #pfstep(finished: true)[$(V tp W)' caniso V' tp W'$][
    By @tp-gives-tensor-space, $V' tp W' = cal(L)(V, W)$, thus we have
    $ V' tp W' = cal(L)(V, W) caniso (V tp W)' $
  ]
]

#remark[This isomorphism is indeed very explicit. We know $vb(a)^i tp vb(b)^j in cal(L)(V, W)$.
  By definition of @univ-prop-1,
  $ (L_1 vb(a)^i tp vb(b)^j)( vb(a)_k tp vb(b)_l) &= vb(a)^i tp vb(b)^j (vb(a)_k, vb(b)_l) \
                                                &= vb(a)^i (vb(a)_k) vb(b)^j (vb(b)_l) = tensor(delta, -k, +i) tensor(delta, -l, +j) $]<explicit-dual-basis>

#idea[Therefore, _under isomorphism_, ${vb(a)^i tp vb(b)^j}$ is equivalent to the dual
  basis of ${vb(a)_i tp vb(b)_j}$! This is not a direct result and we derived it!]

#info[
  This is not just mathematical nit picking. This is indeed the mechanism that
  powers the following rule in Dirac notation:
  $ (ketbra(psi, phi))^dagger = ketbra(phi, psi) $
]

We can extend the universal property a bit and prove the associativity as well!
#thm[Universal Property - Extended][
  1. Let $Gamma in cal(L)(V, W, Z)$, there exists a unique function $hat(Gamma) in cal(L)(V, W tp Z)$ such
    that
  $ hat(Gamma)(vb(v), vb(w) tp vb(z)) = Gamma(vb(v), vb(w), vb(z)) $
  for all $vb(v),vb(w), vb(z)$.

  2. Let $hat(Gamma) in cal(L)(V, W tp Z)$, there exists a unique $Gamma in cal(L)(V, W, Z)$ such
    that
  $ Gamma(vb(v), vb(w), vb(z)) = hat(Gamma)(vb(v),vb(w) tp vb(z)) $
  for all $vb(v),vb(w), vb(z)$.
]<univ-prop-2>
#proof[
  #pfstep[Part 1 is correct][
    Fix $vb(v)$ first, then $Gamma (vb(v), cdot, cdot) in cal(L)(W, Z)$. By
    @univ-prop-1 we can define an unique $hat(tau)_vb(v) in (W tp Z)'$ such that
    $ hat(tau)_vb(v) (vb(w) tp vb(z)) := Gamma (vb(v), vb(w), vb(z)) $
    for all $vb(w), vb(z)$. And we define $ hat(Gamma)(vb(v), vb(w) tp vb(z)) := hat(tau)_vb(v) (vb(w) tp vb(z)) $

    We remain to prove that $hat(Gamma)$ is bilinear. Linearity in the second
    argument (i.e. $W tp Z$ space) is easy as we know $hat(tau)_vb(v)$ is linear
    provided by @univ-prop-1.

    And for the second argument,
    $ hat(Gamma)(vb(v)_1 + c vb(v)_2, vb(w) tp vb(z)) &:= hat(tau)_(vb(v)_1 + c vb(v)_2) (vb(w) tp vb(z)) \
                                                    &= Gamma (vb(v)_1 + c vb(v)_2, vb(w), vb(z)) \
                                                    &= Gamma (vb(v)_1, vb(w), vb(z)) + c Gamma(vb(v)_2, vb(w), vb(z)) \
                                                    &= hat(tau)_(vb(v)_1) (vb(w) tp vb(z)) + c hat(tau)_(vb(v)_2) (vb(w) tp vb(z)) \
                                                    &= hat(Gamma)(vb(v)_1, vb(w) tp vb(z)) + c hat(Gamma)(vb(v)_2, vb(w) tp vb(z)) $
  ]

  #pfstep(
    finished: true,
  )[Part 2 is correct][
    We do the same construction as did in the above. Fix $vb(v)$ for the moment,
    then $hat(Gamma) (vb(v), cdot) in (W tp Z)'$. By @univ-prop-1 we can define the
    unique bilinear functional
    $ tau_vb(v)(vb(w), vb(z)) := hat(Gamma) (vb(v), vb(w) tp vb(v)) $

    And define $ Gamma (vb(v), vb(w), vb(z)) := tau_vb(v)(vb(w), vb(z)) $ This is
    well defined as for each $vb(v)$, $tau_vb(v)$ is unique.

    Now, to prove the trilinearity. The bilinearity in $W, Z$ argument is easy as $tau_vb(v)$ is
    bilinear as provided by @univ-prop-1. The linearity in the first argument is
    given by
    $ Gamma (vb(v)_1 + c vb(v)_2, vb(w), vb(z)) &= tau_(vb(v)_1+ c vb(v)_2) (vb(w), vb(z)) \
                                              &= hat(Gamma) (vb(v)_1 + c vb(v)_2, vb(w) tp vb(v)) \
                                              &= hat(Gamma) (vb(v)_1, vb(w) tp vb(v)) + c hat(Gamma) (vb(v)_2, vb(w) tp vb(v)) \
                                              &= tau_(vb(v)_1) (vb(w), vb(z)) + c tau_(vb(v)_2) (vb(w), vb(z)) \
                                              &= Gamma (vb(v)_1, vb(w), vb(z)) + c Gamma (vb(v)_2, vb(w), vb(z)) $
  ]
]
#remark[
  The proof can be easily adapted into proving the statement $hat(Gamma) (V tp W, Z) dots$.
  So where we tensor stuff together doesn't matter for this proof.
]<univ-prop-2-remark>

We have an easy result

#thm[$dim cal(L)(V, W, Z) = dim V dim W dim Z$]<trilinear-dimension>
#proof[See @ladr[Theorem 9.87, page 378]]

And this gives

#thm[$V' tp (W tp Z)' caniso cal(L)(V, W, Z)$]<trilinear-caniso>
#proof[
  Let $Gamma in cal(L)(V, W, Z)$, define $L_2: cal(L)(V, W, Z) to V' tp (W tp Z)'$ by
  $ L_2 Gamma = hat(Gamma) $
  where $hat(Gamma)$ is given by @univ-prop-2.
  #pfstep[$L_2$ is injective][
    By exact analogue to @dual-is-commutative-with-tp Claim 2.
  ]
  #pfstep(finished: true)[$dim cal(L)(V, W, Z) = dim V' tp (W tp Z)'$][
    By @trilinear-dimension, we have
    $ dim cal(L)(V, W, Z) &= dim V dim W dim Z \
                        &= dim V dim (W tp Z) \
                        &= dim V' tp (W tp Z)' $
  ]
  Since dimension match and $L_2$ is injective, we can use the same technique as
  in @metric-dual-is-surjective to prove $L_2$ is surjective as well.
]

#remark[By @univ-prop-2-remark, we can also prove that indeed
  $ (V tp W)' tp Z' caniso cal(L)(V, W, Z) $
]<trilinear-caniso-remark-pre>

Now, we can post-compose $L_2$ with $L_1$ to get another canonical isomorphism:
#thm[For all $tau in cal(L)(V, W, Z)$, we have the canonical isomorphism
  $ L_1 L_2: cal(L)(V, W, Z) &to (V tp (W tp Z))' \
  tau                      &sendto hat(tau) $
  where $L_1, L_2$ are defined in @dual-is-commutative-with-tp, @trilinear-caniso
  respectively, such that
  $ hat(tau)(vb(v) tp (vb(w) tp vb(z))) = tau(vb(v), vb(w), vb(z)) $ for all $vb(v) in V, vb(w) in W, vb(z) in Z$.
]<explicit-trilinear-caniso>
#remark[Similar to @trilinear-caniso-remark-pre, we can also prove that indeed
  $ ((V tp W) tp Z)' caniso cal(L)(V, W, Z) $
]<trilinear-caniso-remark>
#remark[
  This theorem gives us an explicit candidate for dual basis of ${vb(a)_i tp (vb(b)_j tp vb(c)_k)}$ where ${vb(a)_i}, {vb(b)_j}, {vb(c)_k}$ are
  basis of $V, W, Z$.

  If we define
  $ vb(a)^i tp vb(b)^j tp vb(c)^k (cdot, cdot, cdot) := vb(a)^i (cdot) vb(b)^j (cdot) vb(c)^k (cdot) $

  Then you can verify ${ L_1 L_2 vb(a)^i tp vb(b)^j tp vb(c)^k }$ is a dual basis
  for ${vb(a)_i tp (vb(b)_j tp vb(c)_k)}$

  To see why:
  $ (L_1 L_2 vb(a)^i tp vb(b)^j tp vb(c)^k) (vb(a)_l tp (vb(b)_m tp vb(c)_n)) &= (L_2 vb(a)^i tp vb(b)^j tp vb(c)^k) (vb(a)_l, (vb(b)_m tp vb(c)_n)) \
                                                                            &= vb(a)^i tp vb(b)^j tp vb(c)^k (vb(a)_l, (vb(b)_m, vb(c)_n))\
                                                                            &= tensor(delta, +i, -l) tensor(delta, +j, -m) tensor(delta, +k, -n) $
  Alternatively, ${ L_1 vb(a)^i tp (L_1 vb(b)^j tp vb(c)^k) }$ is also the dual
  basis of ${vb(a)_i tp (vb(b)_j tp vb(c)_k)}$:
  $ overbrace(
    L_1 underbrace(
      vb(a)^i tp overbrace((L_1 underbrace(vb(b)^j tp vb(c)^k, W' tp Z')), (W tp Z)'),
      V' tp (W tp Z)' = cal(L)(V, W tp Z),

    ), (V tp (W tp Z))',

  ) (vb(a)_l tp (vb(b)_m tp vb(c)_n)) &= vb(a)^i tp (L_1 vb(b)^j tp vb(c)^k) (vb(a)_l, vb(b)_m tp vb(c)_n)\
                                                                                                                                                                                                                          &= vb(a)^i (vb(a)_l) (L_1 vb(b)^j tp vb(c)^k)(vb(b)_m tp vb(c)_n) \
                                                                                                                                                                                                                          &= tensor(delta, +i, -l) vb(b)^j tp vb(c)^k(vb(b)_m, vb(c)_n) \
                                                                                                                                                                                                                          &= tensor(delta, +i, -l) tensor(delta, +j, -m) tensor(delta, +k, -n) $
]<explicit-construction-of-trilinear-dual>

#thm[$V' tp (W' tp Z') caniso (V' tp W') tp Z' caniso cal(L)(V, W, Z)$]
#proof[
  #pfstep[$V' tp (W' tp Z') caniso (V tp (W tp Z))'$][
    By @dual-is-commutative-with-tp, $V' tp (W' tp Z') caniso V' tp (W tp Z)'$.
    Apply again we get the desired result.
  ]
  #pfstep(finished: true)[$(V tp (W tp Z))' caniso cal(L)(V, W, Z)$][
    By @trilinear-caniso
  ]
  Therefore, we have
  $ V' tp (W' tp Z') caniso (V tp (W tp Z))' caniso cal(L)(V, W, Z) $

  By @trilinear-caniso-remark, we have the same result for $(V' tp W') tp Z'$.
  Thus,
  $ V' tp (W' tp Z') caniso (V' tp W') tp Z' caniso cal(L)(V, W, Z) $
]

#remark[
  Equivalently, we have
  $ V tp (W tp Z) caniso (V tp W) tp Z caniso cal(L)(V', W', Z') $
]

#idea[
  Thus tensor product between vector spaces is indeed associative! We may write $V tp W tp Z$ which
  is not ambiguous *up to a canonical isomorphism*. And they are all equivalent to $cal(L)(V', W', Z')$ under
  this canonical isomorphism.
]

After having associativity, we can extend these results to "fourth order"
$ ((V tp W) tp Y) tp Z caniso (V tp W) tp (Y tp Z) caniso V tp (W tp (Y tp Z)) $<eq-fourth-order-tp>

And by analogue to @univ-prop-2, we could indeed show
$ cal(L)(V' tp W', Y', Z') caniso cal(L)(V', W', Y', Z') $
and by @univ-prop-2, $ cal(L)(V' tp W', Y', Z') caniso cal(L)(V' tp W', Y' tp Z')$
and by @univ-prop-1, $ cal(L)(V' tp W', Y' tp Z') caniso ((V' tp W') tp (Y' tp Z'))' $
where by applying @dual-is-commutative-with-tp repeatedly,
$ ((V' tp W') tp (Y' tp Z'))' caniso (V tp W) tp (Y tp Z) $
So all of the tensor product spaces in @eq-fourth-order-tp is indeed canonically
isomorphic to $cal(L)(V', W', Y', Z')$

#conclusion[
  So how to think about and _use these_ all of these after all?

  A few take-aways:
  - Canonical Isomorphism here are all powered by universal properties @univ-prop-1,
    @univ-prop-2 which gives @dual-is-commutative-with-tp, @trilinear-caniso
    respectively.
  - Canonical isomorphism basically gives us a natural, unambiguous way to specify
    items. *At the end of the day, you can just ignore the parenthesis and commute
    dual and
    the tensor product, and plug in the things as you expect them to.*

  It's not useful to write out all the canonical identification that makes e.g. ${vb(a)^i tp (vb(b)^j tp vb(c)^k)}$ a
  dual basis as in @explicit-construction-of-trilinear-dual. And this is the
  reason why people even just define $V_1 tp dots.c tp V_n$ as $cal(L)(V_1, dots.c, V_n)$.
  However, our treatment is arguably better:
  - We only defined tensor product once (@tp-vectors and @tp-spaces) and built up
    all the later laws henceforth.
  - We explicitly demonstrated that associativity of tensor product and
    commutativity with dual works.
]

== Inner Product for Tensors
We want to define inner product for tensor product spaces (because we want to do
quantum mechanics for composite systems!)

#thm[The Natural Non-degenerate Hermitian Form for Tensor Product Spaces][
  There exists an unique non-degenerate Hermitian form (@non-deg-hermitian) $H_(V tp W)$ on $V tp W$ such
  that
  $ H_(V tp W) (vb(v)_1 tp vb(w)_1, vb(v)_2 tp vb(w)_2) = H_V (vb(v)_1, vb(v)_2) H_W (vb(w)_1, vb(w)_2) $
  where $H_V, H_W$ are the forms defined for $V, W$.

  We call this $H_(V tp W)$ *the natural form*.
]<natural-form-on-tp>
#proof[See @ladr[Theorem 9.80, page 376]]
#remark[This of course also works for inner product as inner product is just a special
  case for Hermitian form]
#remark[Do see the remark after @ladr[Theorem 9.80, page 376] on why you cannot just
  define the value of $H_(V tp W) (cdot, cdot)$ on separable tensors and use
  linearity from there]

This theorems shows us that we can meaningfully talk about _the_ Hermitian form $H_(V tp W)$ such
that
$ H_(V tp W) (vb(v)_1 tp vb(w)_1, vb(v)_2 tp vb(w)_2) = H_V (vb(v)_1, vb(v)_2) H_W (vb(w)_1, vb(w)_2) $

And to do any practical calculation, we just expand the vector into separable
tensor and use the sesquilinearity of the form.

Now, using @natural-form-on-tp, we have the natural form on $V tp (W tp Z)$ satisfying #footnote[We drop subscript on $H$ to avoid cluttering.]:
$ H (vb(v)_1 tp (vb(w)_1 tp vb(z)_1), vb(v)_2 tp (vb(w)_2 tp vb(z)_2)) &= H (vb(v)_1, vb(v)_2) H (vb(w)_1 tp vb(z)_1, vb(w)_2 tp vb(z)_2) \
                                                                     &= H (vb(v)_1, vb(v)_2) H (vb(w)_1, vb(w)_2) H (vb(z)_1, vb(z)_2) $

And actually for the natural form on $(V tp W) tp Z$, we have
$ H ((vb(v)_1 tp vb(w)_1) tp vb(z)_1, (vb(v)_2 tp (vb(w)_2) tp vb(z)_2) = H (vb(v)_1, vb(v)_2) H (vb(w)_1, vb(w)_2) H (vb(z)_1, vb(z)_2) $
So indeed from the point of view of the natural form, $(V tp W) tp Z$ and $V tp (W tp Z)$ are
the same space.

And indeed ${ vb(a)_i tp vb(b)_j }$ is orthonormal in $V tp W$ if and only if ${vb(a)_i}, {vb(b)_j}$ are
orthonormal in $V,W$.

=== Metric Dual for Tensors
Since we have Hermitian form, we can define a canonical isomorphism between $V tp W$ and $(V tp W)'$ much
like @metric-dual.

#thm[Metric dual of $vb(a) tp vb(b)$][
  Let $vb(a) in V, vb(b) in W$, then $L vb(a) tp vb(b) in (V tp W)'$ is equivalent
  to $tilde(vb(a)) tp tilde(vb(b))$, where $L$ has the meaning in @metric-dual.
]
#proof[
  By @metric-dual, we have
  $
    H_(V tp W)(vb(a) tp vb(b), vb(v) tp vb(w)) &= H(vb(a), vb(v)) H(vb(b), vb(w)) \
                                               &= tilde(vb(a))(vb(v)) tilde(vb(b))(vb(w)) \
                                               &= (L_1 tilde(vb(a)) tp tilde(vb(b))) (vb(v) tp vb(w))
  $
  for any $vb(v) in V, vb(w) in W$, where $L_1$ is defined in @univ-prop-1. That
  is
  $ (L vb(a) tp vb(b))(vb(v) tp vb(w)) = (L_1 tilde(vb(a)) tp tilde(vb(b))) (vb(v) tp vb(w)) $
  Therefore, by taking linear combination of basis tensor of $V tp W$, any tensor $tau$ in $V tp W$ has
  $ (L vb(a) tp vb(b))(tau) = (L_1 tilde(vb(a)) tp tilde(vb(b))) (tau) $
]
#remark[
  The proof is evaluating instead of _defining_ value of $L vb(a) tp vb(b)$ on
  separable tensors. So we don't suffer from the issue discussed in remark after
  @ladr[Theorem 9.80, page 376].
]
#remark[
  Since in Dirac notation, $dagger$ means taking metric dual of some tensor, we
  see naturally
  $ (ketbra(phi, psi))^dagger = ketbra(psi, phi) $
]

There is not much else to discuss here actually, everything works similarly as $V tp W$ is
a vector space. However, one thing to point out is: as
@metric-dual-is-dual-basis dictates, the metric duals of ${vb(a)_i tp vb(b)_j}$ is
its dual basis. As pointed out in @explicit-dual-basis, this is equivalent to ${vb(a)^i tp vb(b)^j}$.

== Change of Coordinates

=== Some "coordinates" are not the coordinates of a tensor

== Contraction
Contraction is probably the most important concept in this formalism that has
practical use. Whenever we are manipulating tensors, we are manipulating
multilinear functionals by applying / composing different them together.

For the sake of discussion, we will stay in the special case $tau^r_s (V)$ where
things are formulated most easily. However, this concept of contraction can
easily be generalized.

#def[Self-Contraction][
  Given a tensor $Gamma in tau^r_s(V)$, define the contraction
  $ cal(C)_(i,j): tau^r_s (V) &to tau^(r-1)_(s-1) (V) \
  Gamma                     &sendto sum_k Gamma(
    dots, underbrace(vb(a)_k, i"-th slot"),
    dots, underbrace(vb(a)^k, j"-th slot"),
    dots,

  ) $
  where ${vb(a)_k}$ is a (not necessarily orthonormal) basis of $V$ and $i$-th
  slot accepts vector while $j$-th slot accepts dual vector.
]<self-contraction>

#thm[@self-contraction is well-defined][
  The definition doesn't depend on our choice of basis ${vb(a)_k}$.
]
#proof[
  Let ${vb(b)_l}$ be another basis, then we have some number ${A^l_k}, {A^k'_l'}$ for
  conversion between these two basis such that
  $ vb(a)_k = sum_l A^l_k vb(b)_l $
  And $ vb(b)_l' = sum_k' A^k'_l' vb(b)_k' $

  By multi-linearity,
  $ Gamma(dots, vb(a)_k, dots, vb(a)^k, j, dots) &= Gamma(dots, sum_l A^l_k vb(b)_l, dots, sum_m A^k_m vb(b)^m, j, dots) $
]

Contraction can be understood as composition and/or partial composition.
Specifically,

== Metric Tensor and Rising/Lowering Indices

== Examples from Physics

= Dirac Notation
Dirac notation is an effective convention for writing linear algebra for quantum
mechanics, relying on the following properties of the underlying space $V$:
- The space is an inner product space ($V$ is a Hilbert space, which is a complete
  complex inner product space)
- The dual space $V'$ is canonically isomorphic to the $V$ through inner product

These points are discussed in @sec-dual-space.

#def(
  "Dirac notation - Basics",
)[
  Given a finite dimensional vector space $V$ with a non-degenerate Hermitian form $H$ (@non-deg-hermitian),
  we write:
  - $ket("something")$ to represent a vector in $V$,
  - $bra("something")$ to represent the metric dual (@metric-dual) of the vector $ket("something")$.
    In other words,
  $ bra("something")(cdot) = H(ket("something"), cdot) $
]

Main advantages of Dirac notation compared to the usual $vb(v)$ notation
includes:
- Naming of the vector is very easy, and we can write $ket((n,l,m))$ to clearly
  label the eigenstate of some particle, instead of resorting to $vb(e)_(n,l,m)$.
- We don't need to write out the metric dual conversion mapping $L: V to V'$ explicitly
  every time.

In the light of this definition, we can translate
$ bra(psi) (ket(phi)) &equiv L(ket(psi)) (ket(phi)) \
                    &equiv H(ket(psi), ket(phi)) $
and
$ bra(psi) (A ket(phi)) &equiv L(ket(psi)) (A ket(phi)) \
                      &equiv H(ket(psi), A ket(phi)) $
where $A: V to V$ is any operator. And for brevity we introduce the shorthand:
$ bra(psi) (ket(phi))   &to braket(psi, phi) \
bra(psi) (A ket(phi)) &to braket(psi, A, phi) $

And also short hand like
$ ket(0) + ket(1) to ket(0+1) $

However, you will also see use like $ ketbra(psi, phi), ket(psi) ket(phi) $
This is actually understood as a tensor product
$ ketbra(psi, phi) equiv ket(psi) tp bra(phi), ket(psi) ket(phi) equiv ket(psi) tp ket(phi) $
which we will introduce now.

#pagebreak()

= Groups

= Strum-Liouville Problem

= Fourier Transform

#pagebreak()

#bibliography("./bib.yaml", style: "ieee")

