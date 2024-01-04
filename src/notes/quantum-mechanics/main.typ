#import "@preview/physica:0.9.0": *
#import "@preview/gentle-clues:0.4.0": *
#import "@preview/ctheorems:1.1.0": *
#import "@lexuge/templates:0.1.0": *

#show: simple.with(
  title: "Quantum Mechanics",
  authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
)

#set math.equation(numbering: "(1.1)")

#let def = thmbox("definition", "Definition", stroke: purple + 1pt)

#let thm = thmbox("theorem", "Theorem", fill: color.lighten(orange, 70%))

#let proof = thmplain(
  "proof",
  "Proof",
  base: "theorem",
  titlefmt: smallcaps,
  bodyfmt: body => [
    #body #h(1fr) $square$ // float a QED symbol to the right
  ],
).with(numbering: none)

// Override the vb in physica
#let vb(body) = $bold(upright(body))$
#let ii = sym.dotless.i
#let al = sym.angle.l
#let ar = sym.angle.r
#let cdot = sym.dot.c
#let to = sym.arrow.r

#pagebreak()

= Preface
== Rigor
Quantum Mechanics has somewhat deep mathematics#footnote[In fact even electrodynamics do.] if
you are willing to dig into (even Hilbert space theory alone is not enough). I
admit I don't have enough familiarity on these mathematical details. *And I will
not pretend I do in order _not_ to create an illusion.*

What I hope to achieve is to have a somewhat logical formulation of the theory
and point out _some_ mathematical subtleties that I have been told or seen. So
the notes is like _"caution! but we don't have tool to meaningfully deal with so we will proceed
nevertheless"_ style.

However, I shall come back later to fill out mathematical details in the long
run (hope I do).

= Mathematical Formulation & Postulates
There are few main goals on mathematics:
- Define the symbol $dagger$ on different objects#footnote[This is a heavily "overriden" operator and sadly not a lot of books talk about
    this in details]. And prove various properties in finite-dimensional Hilbert
  space (i.e. finite-dimensional complex vector spaces).
- Understand how and _why_ to use Dirac notation (i.e. why is it useful).
- State various spectral theorems and understand (at least partially) what goes
  wrong in infinite dimensions.

Then we will state the postulates for quantum mechanics.

This part follows fairly closely to @littlejohn's notes 1,2,3,4 as I found no
book explaining more satisfactory than he does. I will also reference to @isham
and @binney later on.

== Hilbert Space and Dirac Notation
For our purpose, we will think of Hilbert space _very roughly_ as:
#def(
  "Hilbert Space",
)[
  We think of Hilbert space as a complex vector space $V$ with an inner product $angle.l dot.c , dot.c angle.r$ and
  a countable orthonormal basis. This means (for our purpose) there exists a
  vector sequence ${vb(v)_i}$ such that for all $vb(v) in V$, there exists a
  unique sequence ${c_i in CC}$ such that#footnote[We neglect convergence details]
  $ vb(v) = sum_(i=1)^infinity c_i vb(v)_i $
]

#info[Mathematically a vanilla Hilbert space will not satisfy our "definition" above.
  We need further assumptions like "separable". However, the Hilbert space we deal
  with (or construct) are indeed mostly separable. And adding this extra notion
  will not help us understand more as we don't have enough mathematics to
  appreciate it anyway.]

And we basically treat Hilbert space as if it is finite dimensional until we
reach spectral theorems where we give a few complication examples (as they are
the complication that will come into our "calculation").

Therefore, we will construct our theory mostly in a finite-dimensional complex
vector space setting, and just "generalize" (with hope) to infinite-dimensional
Hilbert space.

Our first task is to setup dual space as this is where Dirac notation comes
alive.

#def(
  "Dual Space",
)[
  Define the dual space $V^*$ of a vector space $V$ as the space of all linear
  functionals:
  $ V^* := { f: V arrow.r CC } $
]

If $V$ is finite dimensional, from well known results in finite dimensional
linear algebra, we know $dim V = dim V^*$, and $V$ is naturally isomorphic to $V^(**)$ with
the "application mapping" $i: V arrow.r V^(**)$:
$ underbracket(i(vb(v)), V^(**))(f in V^*) = f(vb(v)) $

If we have an inner product structure on $V$, then we further have an
*antilinear* natural identification $dotless.i: V arrow.r V^*$ defined by
$ underbracket(ii(vb(v)), V^*)(vb(u)) = angle.l vb(v), vb(u) angle.r $

Note this is antilinear:
$ ii(c vb(v)) = angle.l c vb(v), dot.c angle.r = c^* al vb(v), dot.c ar = c^* ii(vb(v))$.

#warning[
  We will denote different operators like $ii_V: V to V^*$ and $ii_W: W to W^*$ with
  the same symbol $ii$. It should be understood in context.
]

Now, we define transpose of a linear mapping. Even though we will be dealing
with mappings that maps into itself, we shall define transpose for a general
mapping across different space just for slightly better clarity.

#def(
  "Transpose",
)[
  Let $hat(A): V arrow.r W$ be a linear mapping between vector spaces $V,W$. We
  define transpose $hat(A)^t: W^* to V^*$ as#footnote[$hat(A)^t$ here is not a standard mathematics notation]
  $ underbracket(hat(A)^t (f in W^*), V^*) = f compose hat(A) $
]

#info[We are adding $hat$ to denote operators/mapping in order to be consistent with
  later notations. Later we will find ourselves writing "quantum-number",
  eigenvector, and operator all with the same alphabet. So having accent to
  distinguish is necessary. But when not useful, we will also suppress it to
  reduce notation clutter.]

#thm("Transpose of Transpose is Itself")[
  We have $(A^t)^t = A$.
]

#proof[
  By definition $(A^t)^t vb(v) = vb(v) compose A^t$. And we basically want to
  prove $vb(v) compose A^t = A vb(v)$ under canonical identification. For all $f in V^*$,
  $ (A vb(v))(f) = f(A vb(v)) = (f compose A)(vb(v)) $
  while
  $ (vb(v) compose A^t) (f) &= vb(v) (A^t f) \
                          &= vb(v) (f compose A) = (f compose A)(vb(v)) $
]
And we also have adjoint of an operator defined in the usual way using inner
product.
#def(
  "Adjoint",
)[
  The adjoint of $A: V to W$, denoted as $A^dagger: W to V$ is defined using "matrix
  elements" as
  $ al A^dagger vb(w), vb(v) ar_V = al vb(w), A vb(v)ar_W $
  for any $vb(w) in W, vb(v) in V$
  Alternatively, this could be written as
  $ (ii compose A^dagger)(vb(w))(vb(v)) &= ii(vb(w))(A(vb(v))) \
                                      &= (ii(vb(w)) compose A)(vb(v)) \
                                      &= (A^t compose ii)(vb(w))(vb(v)) $
  So $ii_V compose A^dagger = A^t compose ii_W$ to be more accurate. And with
  canonical identification between $V, V^(**)$, we can further write
  $ II compose A^dagger = ii_(V^*) compose ii_V compose A^dagger= ii_(V^*) compose A^t compose ii_W $
] <defn-adjoint>

#warning[
  Matrix of $A^dagger$ is conjugate transpose of matrix of $A$ only under
  orthonormal basis. This is because only then would $al vb(v)_i, cdot ar$ give
  you the coordinate under basis ${vb(v)_i}$.
]

You may already find notation cluttering. And this is where Dirac notation
becomes helpful.

#def(
  "Dirac Notation",
)[The rules are followings
  - We use $ket(cdot)$ to denote a vector and $bra(cdot)$ to denote a linear
    functional. The content in the middle can be anything that we use to identify
    the vector#footnote[This is especially useful to solve alphabet shortage e.g. we could write $ket(+)$ to
      denote a vector without causing confusion with the actual $+$ operator.].
    - If the content inside is the same, we understood they are related by $ii$. e.g. $bra(p) = ii(ket(p))$.
  - We shorten the notation $bra(a) (ket(b))$ into $braket(a, b)$. So $braket(a, b)$ should
    be understood as the application of linear functional $bra(a)$ on $ket(b)$. And
    because of identification, this is also $ii(ket(a))(ket(b)) = al ket(a), ket(b) ar$.#footnote[This is why people often think $braket(a, b)$ is just a notation for inner
      product. *But it's better not to think like this.*]
  - We create a linear mapping by $ketbra(a, b): V to V$, this is understood as the
    mapping defined by
    $ underbracket(ketbra(a, b), V to V) underbracket(ket(phi), V) = ket(a) underbracket(braket(b, phi), CC) $
]

An important remark to make is on the last point. It seems natural to also
define $ketbra(a, b)$ as $V^* to V^*$ by "applying it from the right":
$ ketbra(a, b) (bra(phi)) := braket(phi, a) bra(b) $
So how should we understand this? The answer is to use the concept of transpose.

#def(
  "Operators act according to their types",
)[Because of the definition of the transpose, for $A: V to V$,
  $ bra(psi) (hat(A) ket(phi)) = underbracket((hat(A)^t bra(psi)), V^*) ket(phi) $<transpose-dirac>

  So if we invent the fifth rule: *operators act according to their type*, then
  transpose should apply to the "bra" on the left which are linear functionals.
  Thus we can write:
  $ bra(psi) hat(A) ket(phi) = bra(psi) hat(A)^t ket(phi) $
  which should be understood as @transpose-dirac.]

Now, the transpose of $ketbra(a, b)$ is given by
$ ketbra(a, b)^t (bra(psi)) (ket(phi)) &= bra(psi) (ketbra(a, b) ket(phi)) "By definition of transpose" \
                                     &= braket(b, phi) bra(psi) (ket(a)) \
                                     &= braket(b, phi) braket(psi, a) $

So fix $bra(psi)$ and vary $ket(phi)$. Since this is true for all $ket(phi)$, by
positive-definiteness of inner product,
$ ketbra(a, b)^t (bra(psi)) = braket(psi, a) bra(b) $

And use the *transpose act to the left rule*, we can then write
$ bra(psi) (ketbra(a, b))^t = braket(psi, a) bra(b) $

Moreover, due to definition of transpose (the operators in the following
equation should act on left/right according to previous rules),
$ underbracket(bra(psi) (ketbra(a, b))^t, "act first") ket(phi) = bra(psi) underbracket((ketbra(a, b)) ket(phi), "act first") $

_And we may actually drop the transpose even_, whenever we encounter an
expression,

$ bra(psi) hat(A) ket(phi) $

It is understood as:
- $hat(A)$ acts on the side according to its type.
- We may change the side by taking transpose of $hat(A)$ and then act on the other
  side first. The result will be the same by definition of transpose.

#info[
  And this is why when people writing Dirac notation, they just take together "bra"
  and "ket" eagerly without thinking about the syntax, because they can. In
  particular, when people see

  $ bra(psi) ketbra(a, b) $

  they will automatically write $braket(psi, a) bra(b)$. But what they really did
  is implicitly take the transpose of $ketbra(a, b)$ and act on $bra(psi)$. And
  everything works because $ketbra(a, b)^t bra(psi) = braket(psi, a) bra(b)$.

  This is also why this notation is powerful: most things you feel natural is
  indeed correct.
]

#warning[
  However, when you see $bra(psi) hat(A)$ where $A: V to V$, you should not act on
  the left because the type doesn't even match!

  This is why you feel operators only can apply to the right.
]

Up till now, you shall see how the identification of $V, V^*$ is built-in into
the Dirac notation. And sort of we could pair-up the neighboring term and move
scalar around.

We have one notion not yet integrated to the Dirac notation: adjoint.

Again, even if we deal with only one single space in real life, it's easier to
illustrate the concept if we have generic $A: V to W$.

By definition, we know from @defn-adjoint that
$ al A^dagger vb(w), vb(v) ar_V = al vb(w), A vb(v)ar_W $

use the $ii$ and translate into Dirac notation, we have equivalently the
definition
$ bra(vb(v)) A^dagger ket(vb(w))^* = bra(vb(w)) A ket(vb(v)) $ <adjoint-in-dirac>

Notice in the Dirac notation, it's _literally impossible_ to have $A^dagger$ act
on the left to write something like
$ bra(vb(w)) A^dagger ket(vb(v)) "This is wrong" $ <wrong-adjoint>

Because:
- $A^dagger: W to V$ cannot act on left which is in $W^*$.
- $A^dagger: W to V$ cannot act on the right which is in $V$.#footnote[This is why I want to illustrate in different spaces.]

So @wrong-adjoint is basically meaningless.

#info[
  And this is *why you should not interpret braket as another name for inner
  product*. Cause if it's inner product then you can indeed think of
  $ bra(vb(w)) A^dagger ket(vb(v)) = al A^dagger vb(w), vb(v) ar $
  And you don't know what to write for
  $ al vb(w), A vb(v) ar =^? bra(vb(w)) A ket(vb(v)) $
  unless you remember some unnatural "which-side-to-act" convention.
]

And finally, we do an operator overloading. Define $dagger$:
- $z^dagger = z^*$ for $z in CC$.
- $ket(phi)^dagger = ii(ket(phi))$.
- adjoint for operators.

Using these definitions, we write @adjoint-in-dirac as
$ bra(vb(v)) A^dagger ket(vb(w))^dagger = bra(vb(w)) A ket(vb(v)) $
which is what people always do: _apply $dagger$ to each constituent according to the rules above and inverse
their order_.

In particular,
$ (ketbra(a, b))^dagger = ketbra(b, a) $
This can be formally seem by appealing to
$ ketbra(a, b)^dagger = ii compose ketbra(a, b)^t compose ii $
So for all $ket(phi)$,
$ ketbra(a, b)^dagger &= ii compose ketbra(a, b)^t (bra(phi)) \
                    &= ii (braket(phi, a) bra(b)) \
                    &= ket(b) braket(a, phi)\
                    &= ketbra(b, a) (ket(phi)) $

Thus $ketbra(a, b)^dagger = ketbra(b, a)$.

With these preparations, you should no longer be feeling like Dirac notation
being just a weird replacement for inner product with some ad-hoc rules.

And things like
$ (hat(H) ket(phi))^dagger = bra(phi) hat(H)^dagger = (hat(H)^dagger)^t bra(phi) $
should feel meaningful.

#info[
  Dirac notation from another perspective can also be viewed as some type $(1,1), (0,1), (1,0)$ tensors.
  And it works well for such low rank tensors as:
  - things can be written in oneliner.
  - tensor contraction can only come from left and right. And how to contract is
    very natural with these angle brackets (_You won't want to contract $ketbra(a,
    b)$ don't you?_).
  - We can use "dumb rule" like take "adjoint on each and reverse order" to operate.
]

#pagebreak()

#bibliography("./bib.yaml", style: "ieee")
