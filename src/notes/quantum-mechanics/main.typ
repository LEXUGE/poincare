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

#let op(body) = $hat(body)$
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
  manipulating.

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
Quantum Mechanics.== Postulates
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
is what we try to answer in the next section.== Complete Set of Commutative
Operators The idea is simple. We can show that two commutative operators, say $op(A), op(B)$,
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
  falsely prove $op(S)_x$ commutes with $op(S)_z$ in Stern-Gerlach experiments. //Specifically, let initial state be $ket(+)$ (eigenvector of $op(S)_z$), then the
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
  #pfstep[$op(C) op(P)_A_i V_B_j subset op(P)_A_i V_B_j$][
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

#thm[Eigenspace is degenerate #iff There exists non-identity Commuting Operator][]

== Separation of Variable and Tensor Product
The short answer is, in many cases, the Hamiltonian can be written in simpler
form (i.e. solvable with separation of variable) if we use some isomorphism to
transform it into several subspaces tensored together. This is why we write it
out like so.

An example we could but we didn't is $L2(RR^3) caniso L2(RR) tp L2(RR) tp L2(RR)$ This
is because we don't need to exploit the structure to solve
$ laplacian equiv op(p)_x^2 tp II tp II + II tp op(p)_y^2 tp II + II tp II tp op(p)_z^2 $

And often times we have different "factorization" scheme available, depending on
the specific Hamiltonian we are considering.

For example,
$ L2(RR^3) caniso L2([0, oo)) tp L2(S_2) $
is useful for central potential problems.

= Theories
== Uncertainty Principle
== Schro\u{308}dinger and Heisenberg Pictures
== Probability Current
== Continuous and Discrete Transformation, Symmetry
== Angular Momentum

= Simple Problems and Famous Examples
== 1D Potential Problems
== 1D Harmonic Oscillators
== Central Potential Problem
== Hydrogen-like Atoms

= Extra Frameworks
== Perturbation Theory

#pagebreak()

#bibliography("./bib.yaml", style: "ieee")
