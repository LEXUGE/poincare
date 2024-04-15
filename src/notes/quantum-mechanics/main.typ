#import "@preview/physica:0.9.2": *
#import "@preview/gentle-clues:0.4.0": *
#import "@preview/ctheorems:1.1.0": *
#import "@lexuge/templates:0.1.0": *
#import shorthands: *
#import pf3: *

#show: simple.with(
  title: "Quantum Mechanics",
  authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
)
#show: super-plus-as-dagger

#let op(body) = $hat(body)$
#let conj(body) = $overline(body)$
#let vecop(body) = $underline(hat(body))$
#let ft(body, out) = $cal(F)[body](out)$
#let invft(body, out) = $cal(F)^(-1)[body](out)$
#let iff = $<==>$
#let implies = $=>$

#pagebreak()

= Preface
== Rigor
Quantum Mechanics has somewhat deep mathematics#footnote[In fact even electrodynamics do.] if
you are willing to dig into (even Hilbert space theory alone is not enough). I
admit I don't have enough familiarity on these mathematical details. *And I will
not pretend I do in order _not_ to create an illusion.*

What I hope to achieve is to have a somewhat logical formulation of the theory
and point out _some_ mathematical subtleties that I have been told or seen.
Specifically, my criterion for rigor is:
1. Statements and theorems should be proven in finite-dimensional vector spaces.
2. We neglect some analytical problems like Dirac delta "function", provided we
  have intuition and analogue developed from finite-dimensional counterparts.
3. However, any algebraic picture should be made as much clear as possible. We
  should clearly define the algebraic structure and objects that we are
  manipulating#footnote[However, we have to use intuition when necessary for, e.g. vector operator due
    to lack of representation theory.].

However, I shall come back later to fill out mathematical details in the long
run (hope I do).

/*
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
*/
#pagebreak()

= Postulates and Basic Frameworks
The mathematics of tensors and linear algebras as well as Dirac notation are
covered in my mathematical methods notes.

We all know quantum mechanics is set upon Hilbert space, and tensor product is
involved in the formalism. This section is primarily set to address two
problems:
1. What Hilbert space are we using? How to determine the Hilbert space? (This is
  mainly due to @littlejohn[Notes 3])
2. Why does tensor product come into our formalism? When do we divide our spaces
  into subspaces tensored together?

But before answering these questions, we should first lay out the postulates of
Quantum Mechanics.

== Postulates
#def[Postulates of the Quantum Mechanics][
  We postulates:
  1. The states of the quantum system is described by some Hilbert space $cal(H)$.
    The state of the system is given by a ray
  $ span { ket(phi) in cal(H) } $
  2. Any physical observable $A$ is represented by some Hermitian operator $op(A): cal(H) to cal(H)$ on $cal(H)$#footnote[As said in the preface, we neglect the issue about the domain of such operator
      (see @bowers[Sec 2.3.3] on why we don't want to care), and the distinction
      between Hermitian and self-adjoint that math books may care] The possible
    measurement outcomes are the (real) eigenvalues ${A_i}$ of $op(A)$.
  3. The probability of measuring eigenvalue $A_i$ of $op(A)$ upon state $ket(phi)$ is
  $ PP(A_i) equiv PP(A = A_i) = (||op(P)_A_i ket(phi)||^2) / (||ket(phi)||^2) $
  where $op(P)_A_i$ is the projection operator that projects onto the eigenspace
  corresponding to the eigenvalue $A_i$. It's easy to see that by linearity of $op(P)_A_i$ that
  any vector in the ray will yield the same probability $PP(A_i)$
  4. Upon the measurement, the system collapses into the state (ray)
  $ span { op(P)_A_i ket(phi) } $
  Again, any $ket(phi)$ in the original state (ray) will give the same ray after
  collapse.
]<postulates>

In practice, we often work with unit vectors only. Still, two unit vectors
differed by a phase factor are in the same ray, and thus the same physical
state.

From the postulates, it's evident that the order of measurement does matter, so
we need to have notation to distinguish between these cases. We thus write
things in ordered pair to distinguish the order:
$ PP(A = A_i, B= B_j) $
means the probability of measuring $op(A)$ first and $op(B)$ second while
obtaining $A_i, B_j$.
$ PP(A = A_i, A= A_j) $
means the probability of measuring $op(A)$ twice while obtaining $A_i, A_j$ consecutively.
Note this has probability $0$ by our postulates. When we have different state,
we will use subscript to emphasize which state our probability of measurement is
referring to
$ PP_ket(phi)(cdot), PP_ket(psi)(cdot) $

Immediately upon the postulates, we are encountered with the question: _What Hilbert space?_ This
is what we try to answer in the next section.

== Complete Set of Commutative Operators
<csco-procedure>
The idea is simple. We can show that two commutative operators, say $op(A), op(B)$,
has a set of simultaneous eigenspaces. And
1. if we measure $op(A)$ on $ket(phi)$ first, then we will obtain a measurement
  outcome $A_i$, with state afterwards $ket(phi') = op(P)_A_i ket(phi)$.
2. if we then measure $op(B)$ on $ket(phi')$, by the mathematical property of
  commutative operator, the state afterwards will still be in eigenspace $cal(H)_A_i$.
  And if we happen to measure two different outcomes using $op(B)$ on $ket(phi')$ then
  we are assured that we have degeneracy in this subspace $cal(H)_A_i$.
3. if we found degeneracy using $op(B)$, we add it to our set of commutative
  operators.
4. we can continue this process until we cannot find a new operator (measurement)
  that both commutes with the existing set of commutative operators and reveals
  degeneracy. In that case, we declare all mutual eigenspaces are non-degenerate,
  and we had a *complete set of commutative operator (CSCO)*. And the mutual
  eigenbasis (since we assume there is no degeneracy, we call it an eigenbasis)
  spans the Hilbert space for our quantum system.

This process is at least in principle experimentally doable. The key is that we
can infer commutativity of measurement from commutativity of the probability.

Now, we fill in all the necessary gaps and theorems for the above procedure to
work.
#thm[Commutative Operators #iff shared Eigenspaces][
  Let $op(A), op(B): V to V$ be two diagonalizable linear operators on
  finite-dimensional vector space $V$. $[op(A), op(B)] = 0$ if and only if there
  exists a complete set of subspaces ${V_i}_(i=1)^r$ that are eigenspaces to both $op(A)$ and $op(B)$.
]<commutative-sim-eigenspaces>
#proof[
  #pfstep[Shared Eigenspaces $implies [op(A), op(B)] = 0$][
    #pfstep[Every vector admits an unique decomposition: $vb(v) = sum_(i=1)^r vb(v_i) in V_i $][Subspace ${V_i}$ are linearly independent and spanning $V$ by assumption]
    #pfstep[$[op(A), op(B)] = 0$][
      Since $vb(v_i)$ are all in eigenspaces of $op(A), op(B)$. Let ${A_i}, {B_i}$ be
      eigenvalues of $op(A), op(B)$ on ${V_i}$.
      $
        (op(A)op(B) - op(B)op(A)) vb(v) &= (op(A)op(B) - op(B)op(A)) sum_(i=1)^r vb(v_i) \
                                        &= sum_(i=1)^r B_i op(A) vb(v_i) - A_i op(B) vb(v_i) \
                                        &= sum_(i=1)^r B_i A_i vb(v_i) - A_i B_i vb(v_i) = vb(0)
      $
      Thus $[op(A), op(B)] = 0$
    ]
  ]
  #pfstep(
    finished: true,
  )[$[op(A), op(B)] = 0 implies$ Shared Eigenspaces][
    Let ${A_i}$ be eigenvalues of $op(A)$, $V_A_i$ be corresponding eignespaces.
    #pfstep[$op(B) V_A_i subset V_A_i$][
      Let $vb(v) in V_A_i$, by commutation relation,
      $ op(A) op(B) vb(v) - op(B) op(A) vb(v) &= op(A) op(B) vb(v) - A_i op(B) vb(v) \
                                            &= (op(A) - A_i II) op(B) vb(v) = vb(0) $
      Thus $op(B) vb(v) in V_A_i$.
    ]
    #pfstep[The restriction of $op(B)$ on $V_A_i$ is still diagonalizable][
      #pfstep[Components of eigenvectors of $op(B)$ remains an eigenvector][
        Let $vb(v)$ be an eigenvector of $op(B)$ with eigenvalue $lambda$. We can
        decompose $vb(v)$ into
        $ vb(v) = sum_(i=1)^r vb(v)_i in V_A_i $
        And
        $ sum_(i=1)^r op(B) vb(v)_i in V_A_i = sum_(i=1)^r lambda vb(v)_i in V_A_i $
        By linear independence of subspaces ${V_A_i}$, we know
        $ op(B) vb(v)_i = lambda vb(v)_i $
        for all $vb(v)_i$.
      ]

      Let ${B_j}_(j=1)^s$ be eigenvalues of $op(B)$ with ${V_B_j}$ as their
      corresponding eigenspaces. Let $op(P)_A_i$ be the projection operator that
      projects some vector $vb(v)$ onto its component in $V_A_i$. Fix $i$ for now.
      #pfstep[${op(P)_A_i V_B_j}$ are linearly independent][
        By previous step, we know for any $vb(v) in V_B_j$, $op(P)_A_i vb(v) in V_B_j$ still.
        Thus let any $vb(w)_j in op(P)_A_i V_B_j subset V_B_j$ such that
        $ sum_(j=1)^s vb(w)_j in V_B_j = vb(0) $
        By linear independence of $V_B_j$ we have $vb(w)_j = vb(0)$ for all $j$. Thus ${op(P)_A_i V_B_j}$ are
        linearly independent.
      ]
      #pfstep[$plus.circle_(j=1)^s {op(P)_A_i V_B_j} = V_A_i$. So ${op(P)_A_i V_B_j}$ spans $V_A_i$.][
        Let $vb(v) in V_A_i$, decompose it into $V_B_j$,
        $ vb(v) = sum_(j=1)^s vb(v)_j in V_B_j $
        Then
        $ vb(v) = op(P)_A_i vb(v) = sum_(j=1)^s op(P)_A_i vb(v)_j in op(P)_A_i V_B_j $
      ]
      These means eigenspaces ${op(P)_A_i V_B_j}$ clearly "factors" $V_A_i$.
    ]
    Now make $i$ arbitrary,
    #pfstep[${op(P)_A_i V_B_j}_(i,j=1)^(i=r,j=s)$ is linearly independent][
      Let ${vb(v)_(i,j) in op(P)_A_i V_B_j}$ such that
      $ sum_(i,j) vb(v)_(i,j) = vb(0) $
      We can regroup the sum,
      $ sum_(i) underbrace(sum_j vb(v)_(i,j), in V_A_i) = vb(0) $
      By linear independence of $V_A_i$, we know for all $i$
      $ sum_j vb(v)_(i,j) = vb(0) $
      Now by linear independence of $V_B_j$, we know _also_ for all $j$,
      $ vb(v)_(i,j) = vb(0) $
    ]
    #pfstep[${op(P)_A_i V_B_j}_(i,j=1)^(i=r,j=s)$ spans $V$][
      This is evident as ${op(P)_A_i V_B_j}_(j=1)^s$ spans $V_A_i$ and ${V_A_i}$ spans
      the $V$.
    ]
    Thus ${op(P)_A_i V_B_j}$ is the shared eigenspaces that we are after.
  ]
]
#remark[
  There is no statement from this theorem on whether the shared eigenspaces are
  gonna be unique. In fact, let $op(A) = II$, we have any set of eigenspaces of $op(B)$ being
  shared.
]

Next another useful conclusion
#thm[$[op(A), op(B)] = 0$ #iff $[op(P)_A_i, op(P)_B_j] = 0$ for all $i,j$]<commute-equiv-prj-commute>
#proof[
  #pfstep[$[op(A), op(B)] = 0$ #implies $[op(P)_A_i, op(P)_B_j] = 0$ for all $i,j$][
    Let $vb(v)$ be arbitrary, fix $i$.
    #pfstep[$op(P)_A_i op(P)_B_j vb(v)$ is the component of $op(P)_A_i vb(v)$ in $V_B_j$][
      By @commutative-sim-eigenspaces, $op(P)_A_i op(P)_B_j vb(v) in V_B_j$ and
      $ sum_(j=1)^s op(P)_A_i op(P)_B_j vb(v) = op(P)_A_i vb(v) $
      By linear independence of $V_B_j$, we know $op(P)_A_i op(P)_B_j vb(v)$ is _the_ component
      of $op(P)_A_i vb(v)$ in $V_B_j$.
    ]
    By definition, $op(P)_B_j op(P)_A_i vb(v) in A_i$ is the component of $op(P)_A_i vb(v)$ in $V_B_j$.
    Since such component is unique, we have
    $ op(P)_A_i op(P)_B_j vb(v) - op(P)_B_j op(P)_A_i vb(v) = vb(0) $
  ]

  #pfstep(
    finished: true,
  )[$[op(P)_A_i, op(P)_B_j] = 0$ for all $i,j$ #implies $[op(A), op(B)] = 0$][
    By definition, we have
    $ op(A) = sum_i A_i op(P)_A_i, op(A) = sum_j B_j op(P)_B_j $
    And since $[op(P)_A_i, op(P)_B_j] = 0$ for all $i,j$,
    $ op(A)op(B) &= sum_(i,j) A_i B_j op(P)_A_i op(P)_B_j \
               &= sum_(i,j) A_i B_j op(P)_B_j op(P)_A_i \
               &= op(B)op(A) $
  ]
]
#remark[
  The projection operator here are not doing orthogonal projection! They are
  defined using a set of subspaces. In general, orthogonal projection always
  commute, while subspace projection doesn't always commute.
]

We have for projection (either subspace or orthogonal), that
$ op(P)^2 equiv op(P) compose op(P) = op(P) $
And orthogonal projections are Hermitian. Note that for Hermitian operators,
their subspace projection is also orthogonal (and thus also Hermitian)!

#thm[Commutative Measurements #iff Commutative Probability][
  $[op(A), op(B)]=0$ if and only if for any eigenvalue $A_i, B_j$ of $op(A), op(B)$ and
  any state $ket(phi)$,
  $ PP_ket(phi)(A_i, B_j) = PP_ket(phi)(B_j, A_i) $
]
#proof[
  By @postulates, we have
  $ PP_ket(phi)(A_i, B_j) &= PP_(op(P)_B_j ket(phi))(A_i) PP_ket(phi) (B_j) \
                        &= (braket(phi, op(P)_A_i op(P)_B_j op(P)_A_i, phi)) / (braket(phi, op(P)^2_B_j, phi)) (braket(phi, op(P)^2_B_j, phi)) / (braket(phi, phi)) \
                        &= (braket(phi, op(P)_A_i op(P)_B_j op(P)_A_i, phi)) / (braket(phi, phi)) $<eq-prob-A-B>
  Similarly,
  $ PP_ket(phi)(A_i, B_j) = (braket(phi, op(P)_B_j op(P)_A_i op(P)_B_j, phi)) / (braket(phi, phi)) $<eq-prob-B-A>

  #pfstep[For any $ket(phi), A_i, B_j$, $PP_ket(phi)(A_i, B_j) = PP_ket(phi)(B_j, A_i)$ #implies $[op(A), op(B)]=0$][
    Since these are equal for all $ket(phi)$, we have
    $ op(P)_B_j op(P)_A_i op(P)_B_j = op(P)_A_i op(P)_B_j op(P)_A_i $<eq-origin>
    Multiply both sides from left by $op(P)_A_i$ and use $op(P)^2_A_i = op(P)_A_i$,
    we have
    $ op(P)_A_i op(P)_B_j = (op(P)_A_i op(P)_B_j)^2 = op(P)_A_i op(P)_B_j op(P)_A_i $
    Similarly, we can obtain from @eq-origin
    $ op(P)_B_j op(P)_A_i =op(P)_B_j op(P)_A_i op(P)_B_j $
    Now, by @eq-origin again,
    $ op(P)_B_j op(P)_A_i = op(P)_A_i op(P)_B_j $
    Since this is true for all $i,j$, by @commute-equiv-prj-commute we have $[op(A), op(B)] = 0$.
  ]

  #pfstep(
    finished: true,
  )[$[op(A), op(B)]=0$ #implies for any $ket(phi), A_i, B_j$, $PP_ket(phi)(A_i, B_j) = PP_ket(phi)(B_j, A_i)$][
    By @commute-equiv-prj-commute, we have $[op(P)_A_i, op(P)_B_j] = 0$ for all $i,j$,
    this means
    $ op(P)_B_j op(P)_A_i op(P)_B_j = op(P)_A_i op(P)_B_j op(P)_A_i $
    As we can commute all projection operators around, and use $op(P)^2 = op(P)$.

    Thus @eq-prob-A-B and @eq-prob-B-A are equal for all $i,j, ket(phi)$.
  ]
]
#remark[
  This is experimentally testable if we repeat the experiments with the same state
  to collect the statistics, and survey all possible states.
]

#caution[
  The condition "for any state $ket(phi)$" is necessary. Otherwise we could
  falsely prove $op(S)_x$ commutes with $op(S)_z$ in Stern-Gerlach experiments.
  Specifically, let initial state be $ket(y+)$ (eigenvector of $op(S)_y$), then
  measure $op(S)_x, op(S)_z$ in both order, we have all outcomes having the same
  probability $1/4$.
]

And an extension to @commutative-sim-eigenspaces is
#thm[Pairwise Commutative Operators #iff shared Eigenspace][
  Let ${ op(O)_i: V to V }$ be a set of operators. They are pairwise commutative
  if and only if they share a complete set of eigenspaces.
]
#proof[
  If they share complete set of eigenspaces, then they are evidently commutative.

  For the other direction, let $op(A), op(B), op(C)$ be pairwise commutative. Then ${ op(P)_A_i V_B_j }$ is
  a shared set of eigenspaces for $op(A), op(B)$. We have
  #pfstep(
    finished: true,
  )[$op(C) op(P)_A_i V_B_j subset op(P)_A_i V_B_j$][
    We have $op(P)_A_i V_B_j subset V_A_i$, thus for all $vb(v) in op(P)_A_i V_B_j$, $[op(A), op(C)] = 0$ gives
    $ (op(A) op(C) - op(C) op(A)) vb(v) = (op(A) - A_i II) op(C) vb(v) $
    And similarly, $op(P)_A_i V_B_j subset V_B_j$, and for all $vb(v) in op(P)_A_i V_B_j$ with $[op(B), op(C)] = 0$ gives
    $ (op(B) op(C) - op(C) op(B)) vb(v) = (op(A) - B_j II) op(C) vb(v) $
    But $op(P)_A_i V_B_j$ is the only eigenspace with eigenvalue $A_i, B_j$, thus $op(C) vb(v) in op(P)_A_i V_B_j$.
  ]
  Then the rest of the steps are similar to @commutative-sim-eigenspaces: prove ${op(P)_C_k op(P)_A_i B_j}$ are
  linearly independent and spans $V$.

  This argument genenralizes to finite number of observables.
]

== Tensor Product
Some operators are nicer than others. For certain operators ${op(A), op(B), op(C)}$,
it's possible that any of their individual eigenstates tensored together will
give a set of mutual eigenstates for all operators. This is true for e.g. ${op(x), op(y), op(z)}$ and ${op(x), op(y), op(z), op(S)_z}$.

Apparently, the necessary condition for such thing to happen is that they should
all be pairwise commutative. _However, this is not sufficient for such tensor product structure to happen._ For
example, the spin magnitude operator $[op(S^2), op(S)_z] = 0$, but they don't
exhibit such structure. Their mutual eigenstates are labeled collectively by $ket((s, m))$ with
condition $-s lt.eq m lt.eq s$#footnote[More condition applies to what values $s,m$ can take.].

#info[Hypothesis: if it happens that the individual eigenvalues used to label a (or
  for all?) mutual eigenbasis are uncorrelated. Then such a basis is separable.]

Sometimes a mutual eigenbasis exhibit _some_ tensor product structure. For
example, for hydrogen atom gross structure or 3D harmonic oscillator model, we
have mutual eigenbasis labeled as $ket((E, l, m))$#footnote[As later shown, $E$ is the eigenvalue for Hamiltonian (energy), $l,m$ are used
  to label eigenvalues for $op(L^2), op(L)_z$.] where $E,m$ are only related
through $l$. So we may re-identify our space and write such basis as $ket((E,l)) tp ket((l,m))$,
but this basis is not the same as "${ket((E,l))} tp {ket((l,m))}$".

= Basic Dynamics
== Position Operator
Quantum theory is not building everything from ground up. The @postulates we
have is more about mathematical framework of the theory but tells nothing about
the _physics_ of quantum mechanics.

As for physics, we don't forgo the classical description of space-time. In fact
we will be working with non-relativistic space-time in this note. That means, we "postulate"
(this is in principle experimentally verifiable).

#def[Coordinate (Position) Operators][
  There exists operators $op(x), op(y), op(z)$ on $L^2(RR^3)$#footnote[This is of course mathematically wrong. "$delta$-function" don't live in $L^2(RR^3)$.
    But we will forgive this notation as we don't care about these issues in this
    note.]. Defined as
  $ (op(x) f)(x, y, z) = x f(x,y,z) $
  And similarly for the others. From definition, they are mutually commutative.

  The eigenvalues of these operators are continuous, and eigenvectors are $ket(x_0) = delta(x - x_0)$.
  This is exemplified as for any test function $f$,
  $ al f, x delta(x - x_0) ar = x_0 f(x_0) = x_0 al f, delta(x-x_0) ar $
  Thus we identify $op(x) delta(x - x_0) = x delta(x-x_0) = x_0 delta(x-x_0)$.

  By mutual commutativity, they have a mutual eigenbasis defined as $ket(vb(x_0)) = delta(vb(x) - vb(x)_0)$.
  Or equivalently $delta(x - x_0) delta(y - y_0) delta(z - z_0)$ which sort of
  shows the separable nature of their mutual eigenbasis.

  As a convention, $ket(vb(x_0))$ where $vb(x_0)$ is a real vector, means a
  position eigenstate with eigenvalue $vb(x_0)$.
]

#caution[
  As you might already know, these eigenvectors are not square-integratable. That
  is to say using integral, we cannot get $braket(x_0, x_0) = 1$. As
  $ braket(x_0, x_1) = integral_(RR^3) delta(x - x_0) delta(x - x_1) $
  is not well-defined.

  The only thing we can "say" is to understand $braket(x_0, x_1) = delta(x_0 - x_1)$.
]

In the above, we think of vectors are functions in $L^2(RR^3)$ but
alternatively, we can also think vector $ket(phi)$ lives in some other space.
And $phi(vb(x)_0)$ as the "coordinate" for $ket(phi)$ obtained using $braket(vb(x_0), phi)$.
In this way, $braket(vb(x_0), vb(x_1)) = delta(vb(x_0) - vb(x_1))$ then gives
the coordinate for eigenvectors $ket(vb(x_1))$.

Position operators are the easiest example of a vector operator.

#def[Vector Operator][
  Given three#footnote[Of course you may go to higher dimension. Generalization will require us to
    think about 4D angular momentum and rotation.] operators $op(v)_1, op(v)_2, op(v)_3$,
  we can apply them together on some state $ket(phi)$ and get a triplet of vector:
  $ (op(v)_1 ket(phi), op(v)_2 ket(phi), op(v)_3 ket(phi)) in cal(H)^3 $

  Or written succinctly as
  $ vecop(v) ket(phi):= (op(v)_1 ket(phi), op(v)_2 ket(phi), op(v)_3 ket(phi)) $

  *Criterion*: We call $vecop(v)$ or the triplet $(op(v)_1, op(v)_2, op(v)_3)$ as
  vector operator if we expect physically their measurements are component of some
  vector. This implies they must change collectively under rotation, inversion
  etc. And more is discussed on this later.
]<vecop>

#def[Notation Shorthands for Vector Operators][
  - *Dot Product*: Vector operator can be defined to take "dot product", which is
    just defined as
    $ vecop(v) cdot vecop(v) := op(v)_1 compose op(v)_1 + op(v)_2 compose op(v)_2 + op(v)_3 compose op(v)_3 $
  - *Eigenvalue*: _If_ the operators of each component (i.e. $op(v)_i$) of $vecop(v)$ are
    mutually commutative, we have simultaneous eigenspaces for all components. And
    thus we could write a vector eigenvalue:
    $ vecop(v) ket(vb(a)) = vb(a) ket(vb(a)) := (a_1 ket(vb(a)), a_2 ket(vb(a)), a_3 ket(vb(a))) $
  - *Rotation*: Let $R: RR^3 to RR^3$ be a 3D rotational matrix, we could define $R vecop(v)$,
    the vector operator after rotation as
    $ (R vecop(v))_i = sum_j R_(i,j) vecop(v)_j $
]<shorthands-vecop>

#warning[
  Despite the fact that the components of $vecop(x)$ (and as we see later $vecop(p)$)
  are mutually commutative, it's not true in general that a vector operator has
  commutative components. An important example is angular momentum where it's
  components satisfy
  $ [op(J)_i, op(J)_j ] = ii epsilon_(i,j,k) op(J)_k $
  where we used Einstein summation (and we will for the rest of note).

  And a particular consequence of this is it's illegal to write $ket(vb(J))$, an
  angular momentum eigenket with well-defined components for all three directions.
]

Since we expect position operators $op(x), op(y), op(z)$ to physically mean the
components of a vector, they form a vector operator. And we write it as $vecop(x)$ or $vecop(r)$.

We can define new operators using some $f: RR^3 to RR$.
#def[Function of Position Operator][
  Given suitable $f: RR^3 to RR$, we define $f(vecop(x)): L^2(RR^3) to L^2(RR^3)$ as
  $ (f(vecop(x)) phi)(vb(x)) := f(vb(x)) phi(vb(x)) $

  Of course $f$ has to be suitable in order for the resultant vector to still be
  square-integrable.
]
#eg[Electrostatic Potential][
  Electrostatic potential classically is defined as $V(vb(r)) = 1/(4 pi epsilon_0) Q/(|vb(r)|)$.
  Quantum mechanically, we _guess_ the corresponding operator to be $V(vecop(x))$.

  Notice it's hard to define what $sqrt(op(x)^2 + op(y)^2 + op(z)^2)$ as $sqrt(1+x^2)$'s
  Taylor series would only converge over a finite domain of convergence.
]

== Momentum Operator
#tip[$hbar$ is in unit of angular momentum. And it's a natural unit of angular
  momentum eigenvalue.]

Up till now, we cannot give a motivation for momentum operator other than just
simply define it. We will have some more understanding once we introduced
transformation.
#def[Momentum Operator][
  Momentum is also a vector operator as we expect the measurement outcome to be
  components of some "momentum vector".

  Denote the triplet as $op(p)_i: L^2(RR^3) to L^2(RR^3)$ where $i = x,y,z$ which
  means measurement of $x,y,z$ component of momentum. They are defined for as for $phi in L^2(RR^3)$
  $ (op(p)_i phi)(vb(x)) = - ii hbar pdv(phi, x_i) $

  As partial derivative commutes, $op(p)_i$ are mutually commutative.

  Note in the "other perspective" where $phi(vb(x))$ are seen as coordinate
  instead of state itself, $(op(p)_i phi)(vb(x)) = bra(vb(x)) op(p)_i ket(phi)$.
  We will use both perspective as we go on. Written in that perspective, $op(p)_i$ is
  defined by
  $ bra(vb(x)) op(p)_i ket(phi) = - ii hbar pdv(braket(vb(x), phi), x_i) $
]

It can be verified directly that
$ [op(p)_i, op(x)_j] = -ii hbar delta_(i,j) $

Up till now, we see#footnote[By in principle carrying out the procedure in @csco-procedure.] a
possible CSCO (if we only work on spinless dynamics) is the position operator
triplet. And the Hilbert space we work with is $L^2(RR^3)$.

The eigenvector of $op(p)_i$ can be found by solving the definition equation.
Because $op(p)_i$ are mutually commutative, we may actually find an eigenvector
for the collective $vecop(p)$.

Let $ket(vb(p))$ be the eigenvector of $vecop(p)$ with eigenvalue $vb(p)$ (see
@shorthands-vecop), we then have

$ bra(vb(x)) op(p)_i ket(vb(p)) = - ii hbar pdv(braket(vb(x), vb(p)), x_i) = vb(p)_i braket(vb(x), vb(p)) $

for all $i=x,y,z$.

And $ braket(vb(x), vb(p)) = exp(ii vb(p) cdot vb(x) /hbar) $

Again, it's not normalizable. However, we could demand a normalization similar
to $braket(vb(x), vb(x'))$, so we want

$ braket(vb(p), vb(p')) = delta(vb(p) - vb(p')) $

But $ integral_(RR^3) exp(-ii vb(p) cdot vb(x) /hbar) exp(ii vb(p') cdot vb(x) /hbar) dd(vb(x), 3) &= hbar^3 integral_(RR^3) exp(-ii vb(p) cdot vb(x) /hbar) exp(ii vb(p') cdot vb(x) /hbar) dd(vb(x)/hbar, 3) \
                                                                                             &= hbar^3 ft(exp(ii vb(p') cdot vb(u)), vb(p)) $
where $vb(u) = vb(x) / hbar$. Notice
$ integral_RR^3 exp(ii vb(p) cdot vb(u)) delta(vb(p) - vb(p')) dd(vb(p), 3) &= exp(ii vb(p') cdot vb(u)) \
                                                                          &= (2pi)^3 invft(delta(vb(p)- vb(p')), vb(u)) $
So
$ hbar^3 ft(exp(ii vb(p') cdot vb(u)), vb(p)) &= (2pi hbar)^3 ft(invft(delta(vb(p)- vb(p')), vb(u)), vb(p)) \
                                            &= (h)^3 delta(vb(p)- vb(p')) $

As $hbar:= h / (2pi)$. Therefore, we have could normalize
$ ket(vb(p)) := h^(-3/2) exp(ii vb(p) cdot vb(x) / hbar) $

== Uncertainty Principle
For two non-commutative operators, we have a nice inequality
#thm[(Heisenberg) Uncertainty Principle][
  Let $op(P), op(Q)$ be two general Hermitian operator. Define $op(p) = op(P) - a, op(q) = op(Q) - b$ where $a,b in RR$.
  Then, for a state $ket(phi)$,
  $ sqrt(expval(op(p)^2) expval(op(q)^2)) gt.eq 1/2 |expval([op(P),op(Q)])| $

  In particular, if $a = expval(op(p)), b = expval(op(Q))$ then $expval(op(p)^2) = expval(op(P)^2)- expval(op(P))^2$ is
  the variance $(Delta P)^2$ of $op(P)$. Similar for $expval(op(q)^2)$. This then
  means
  $ (Delta P) (Delta Q) gt.eq 1/2 |expval([op(P), op(Q)])| $
  And further, for $op(P) = op(p)_i, op(Q) = op(x)_j$,
  $ (Delta p_i) (Delta x_j) gt.eq 1/2 delta_(i,j) hbar $
]<heisenberg-inequality>
#proof[
  #pfstep[$op(p), op(q)$ are Hermitian as well.][
    Since $a,b in RR$, $ op(p)^dagger = op(P)^dagger - a = op(P) - a = op(p) $
    Similar for $op(q)$.
  ]
  #pfstep[$[op(P), op(Q)] = [op(p), op(q)]$][
    $ [op(p), op(q)] = [op(P) - a, op(Q) - b] &= [op(P), op(Q)-b] - underbrace([a, op(Q) - b], "trivially 0") \
                                            &= [op(P), op(Q) ] - underbrace([op(P), b], "trivially 0") \
                                            &= [op(P), op(Q) ] $
  ]
  Now, since $op(p), op(q)$ are Hermitian,
  $ expval(op(p)^2)expval(op(q)^2) &= expval(op(p)^dagger op(p)) expval(op(q)^dagger op(q)) \
                                 &= norm(op(p) ket(phi))^2 norm(op(q) ket(phi))^2 $
  And by Cauchy-Schwartz
  $ norm(op(p) ket(phi)) norm(op(q) ket(phi)) gt.eq |expval(op(p)op(q), phi)| $ <c-s-uncertainty-1>
  And
  $ norm(op(p) ket(phi)) norm(op(q) ket(phi)) gt.eq |expval(op(q)op(p), phi)| $ <c-s-uncertainty-2>
  Adding @c-s-uncertainty-1 and @c-s-uncertainty-2, and use triangular inequality
  $ 2 norm(op(p) ket(phi)) norm(op(q) ket(phi)) &gt.eq |expval(op(q)op(p), phi)| + |expval(-op(q)op(p), phi)| \
                                              &gt.eq |expval([op(p), op(q)], phi)| = |expval([op(P), op(Q)], phi)| $

  Thus $ norm(op(p) ket(phi)) norm(op(q) ket(phi)) gt.eq 1/2 |expval([op(p), op(q)], phi)| $
]

The specialization of @heisenberg-inequality applied to $op(x), op(p)$ is
actually also interpreted as inequality on Fourier Transform.

Specifically, when we work in 1D, let $op(p)$ represent momentum operator again
(but without $hbar$),
$ braket(p, phi) = integral_RR exp(ii p x) phi(x) dd(x) = ft(phi(x), p) $
And $ expval((op(p) - a)^2, phi) &= integral_RR mel(phi, (op(p)- a)^2, p) braket(p, phi) dd(p) \
                           &= integral_RR (p- a)^2 braket(phi, p) braket(p, phi) dd(p) \
                           &= integral_RR (p- a)^2 |ft(phi(x), p)|^2 dd(p) $
So the @heisenberg-inequality is then about the variance of $phi(x)$ and its
Fourier transform.

== Time Evolution and Some Theorems
#def[Schrödinger Equation][
  Let $ket(phi(t)): RR to cal(H)$ describes the trajectory of some system with
  Hamiltonian $op(H)$, then
  $ ii hbar pdv(ket(phi(t)), t) = op(H) ket(phi(t)) $
]<schroedinger-eqn>
#remark[
  It's sometimes confusing when we deal with derivative. A few points to make
  - Since $ket(phi(t))$ is _only_ a function of $t$, it can only be differentiated
    with respect to $t$. The _partial_ derivative appear more because of a
    conventional reason. That is, we often work with position representation $phi(vb(x), t) := braket(vb(x), phi(t))$.
    So a partial derivative is necessary.
  - It can be verified that $(pdv(, x))^+ = - pdv(, x)$ _in Cartesian coordinate_#footnote[It's also *wrong* to naively assume this anti-Hermitian property holds in other
      coordinate system (e.g. spherical coordinates). See @binney[Exercise 7.14] for
      an example.]. However, it's *wrong* to write
  $ (pdv(phi(vb(x), t), x_i))^+ = -phi(vb(x), t) pdv(, x_i) $
  This is because $pdv(phi(vb(x), t), x_i)$ is not equivalent to $pdv(, x_i) compose phi(vb(x), t)$ as
  the latter acts on some $f$ like
  $ pdv(phi(vb(x), t) f(vb(x)), x_i) $
  while the former is $ pdv(phi(vb(x), t), x_i) f(vb(x)) $
  - The Hilbert Space $cal(H)$ is not defined to include $t$#footnote[Otherwise we are implying state to vanish at distant past and future.].
    Scalar product is always taken at fixed $t$. So it *makes no sense* to write
  $ (pdv(, t))^+ $
  And adjoint on $cal(H)$ commutes with $pdv(, t)$ as basically $t$ has nothing to
  do with $cal(H)$. Thus,
  $ (pdv(ket(phi(t)), t))^+ = pdv(bra(phi(t)), t) $
]

#thm[Time-evolution of energy eigenstate][
  Let $ket(phi_0)$ be an eigenstate of $op(H)$ with eigenvalue $E$. Let $ket(phi(0)) = ket(phi_0)$,
  we have
  $ ket(phi(t)) = exp(-ii E t/hbar) ket(phi(0)) $
]<time-evolution-of-energy-eigenstate>
#proof[
  Plug in @schroedinger-eqn, we have
  $ pdv(ket(phi(t)), t) &= -ii / hbar E ket(phi(t)) \
  ket(phi(t))         &= exp(- ii E t /hbar) ket(phi(0)) $
  assuming we have defined norms etc in $cal(H)$ so differentiating $ket(phi(t)): RR to cal(H)$ is
  valid.
]
#remark[This means the eigenvector of $op(H)$ changes only phases over time. *And it
  stays as an eigenvector of $op(H)$!*]

#thm[Ehrenfest Theorem][
  Ehrenfest Theorem states the time evolution of _expectation value_ of some
  operator under certain Hamiltonian. For time-independent operator $op(Q)$,
  $ ii hbar dv(expval(op(Q), phi(t)), t) = expval([op(Q), op(H)]) $
]<ehrenfest-theorem>
#proof[
  By taking adjoint on @schroedinger-eqn, we have
  $ -ii hbar pdv(bra(phi(t)), t) = bra(phi(t)) op(H) $
  And $ ii hbar dv(expval(op(Q), phi(t)), t) &= (ii hbar pdv(bra(phi(t)), t)) op(Q) ket(phi) + bra(phi) op(Q) (ii hbar pdv(ket(phi(t)), t)) \
                                       &= - expval(op(H)op(Q), phi) + expval(op(Q)op(H), phi) = expval([op(Q), op(H)]) $
  where we assumed $op(Q)$ is time-independent.
]
#remark[Heisenberg's picture would give a similar statement.]

We haven't said anything about how to construct Hamiltonian. The answer, at
least at our stages, is to "guess" based on classical mechanics. So we think of
Hamiltonian as "energy" and for example write kinetic energy as $vecop(p)^2/(2m)$ where $vecop(p)^2 equiv vecop(p) cdot vecop(p)$.

#thm[Energy Eigenstates give stationary value for all operators][
  Given an arbitrary energy eigenstate $ket(E)$, we get $expval(op(Q), E)$ stationary
  over time for all $op(Q)$.
]
#proof[
  By @time-evolution-of-energy-eigenstate, energy eigenstate only evolves their
  phases.#footnote[$ket(E(t))$ means the evolution of $ket(E)$, not meaning the eigenvalue $E$ is
    changing over time.]
  $ ket(E(t)) = exp(-ii E t/hbar) ket(E(0)) $
  So $ expval(op(Q), E(t)) = exp(-ii(E-E) t/hbar) expval(op(Q), E(0)) = expval(op(Q), E(0)) $
  Alternatively, we can use @ehrenfest-theorem by plugging in $expval([op(Q), op(H)], E(t))$
]

#thm[Virial Theorem][See Binney]

== Probability Current
Consider now the special case when we are studying position and momentum so $cal(H) = L^2(RR^3)$.

We have actually been implicitly assuming the interpretation that amplitude
squared, $|phi(vb(x), t)|^2$, serves as the probability (density) function. And
it's then natural to ask how probability shifts over time. This is also
important for us to study 1D scattering problems (e.g. potential well problems)
by giving interpretation about transmission and reflection.

We further assume our Hamiltonian is simply#footnote[More complicated Hamiltonian will admit different probability current. For
  example, Hamiltonian with a classical electromagnetic field will have a
  probability current that transforms under gauge transformation correctly.]
$ op(H) = vecop(p)^2 / (2m) + V(vecop(x)) $

#thm[Probability Current For Simple System][
  Let $ket(phi(t)) = |phi(vb(x), t)| exp(ii theta(vb(x), t))$ be a state, define $rho(vb(x), t) = |phi(vb(x), t)|^2$.
  We have
  $ pdv(rho, t) = - div vb(J) $
  where $vb(J) = hbar / m rho grad theta $.
]
#proof[
  By definition, $rho = braket(phi, vb(x)) braket(vb(x), phi)$. And by
  @schroedinger-eqn,
  $ ii hbar pdv(braket(vb(x), phi), t)   &= mel(vb(x), op(H), phi) \
  - ii hbar pdv(braket(phi, vb(x)), t) &= mel(phi, op(H), vb(x)) $
  By product rule,
  $ ii hbar pdv(rho, t) &= ii hbar pdv(braket(vb(x), phi), t) braket(phi, vb(x)) + ii hbar pdv(braket(phi, vb(x)), t) braket(vb(x), phi) \
                      &= mel(vb(x), op(H), phi) braket(phi, vb(x)) - mel(phi, op(H), vb(x)) braket(vb(x), phi) \
                      &= 2ii Im mel(vb(x), op(H), phi) braket(phi, vb(x)) $
  And $ mel(vb(x), op(H), phi) braket(phi, vb(x)) = - hbar^2 / (2m) (laplacian phi) conj(phi) + V(vb(x)) rho $
  Since the second term is real,
  $ ii hbar pdv(rho, t) = - hbar^2 / (m) ii Im (laplacian phi) conj(phi) \
  pdv(rho, t) = - hbar / m Im (laplacian phi) conj(phi) $
  Notice, $(laplacian phi) conj(phi) = (div grad phi) conj(phi)$, and $div (psi vb(F)) = vb(F) cdot grad(psi) + psi div vb(F)$.
  Set $vb(F) = grad phi, psi = conj(phi)$, we have
  $ Im (laplacian phi) conj(phi) = div(Im conj(phi) grad phi) - underbrace(grad phi cdot grad conj(phi), in RR) $
  So we could identify $ vb(J) = hbar / m Im conj(phi) grad phi $
  And let $phi = |phi| exp(i theta)$,
  $ Im conj(phi) grad phi &= Im |phi| exp(-i theta) ((grad |phi|) exp(i theta) + |phi| i (grad theta ) exp(i theta)) \
                        &= Im underbrace(|phi| grad |phi|, in RR) + i |phi|^2 grad theta \
                        &= rho grad theta $
  Thus $vb(J) = hbar / m rho grad theta$
]
#remark[
  Since the particle has to be found somewhere in $RR^3$, surface integral with $vb(J)$ allows
  us to work out how fast a particle moves out/in a particular region.

  This is useful in analyzing 1D potential barrier problems. As for those problems
  we have unnormalizable eigenstates, so we have to work with the rate of
  particle's movement.
]

= Continuous and Discrete Transformation, Symmetry
== How to make sense of $ii$
== Schro\u{308}dinger and Heisenberg Pictures
== Adding Electromagnetic Fields, Gauge Invariance
= Angular Momentum
== Common Commutation Relations and Spectrum
== Spin and Orbital Angular Momentum

= Simple Problems and Famous Examples
== 1D Potential Problems
== 1D Harmonic Oscillators
== Central Potential Problem, 3D Harmonic Oscillator
== Hydrogen-like Atoms

= Further Frameworks
== Perturbation Theory

#pagebreak()

#bibliography("./bib.yaml", style: "ieee")
