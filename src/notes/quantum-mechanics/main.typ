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
#let vecop(body) = $underline(hat(body))$
#let ft(body, out) = $cal(F)[body](out)$
#let invft(body, out) = $cal(F)^(-1)[body](out)$
#let inv(body) = $body^(-1)$
#let iff = $<==>$
#let implies = $=>$
#let spinup = $arrow.t$
#let spindown = $arrow.b$

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
  #pfstep(
    finished: true,
  )[$[op(P), op(Q)] = [op(p), op(q)]$][
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
  Written clearly, we actually have $D_x$ defined as $mel(x, D_x, phi) = pdv(braket(x, phi), x)$.
  And to find $(D_x ket(phi))^dagger in cal(H)'$, we act it on arbitrary $ket(psi)$,
  that is
  $ (D_x ket(phi))^dagger ket(psi) = mel(phi, D_x^dagger, psi) $
  And $ mel(phi, D_x^dagger, psi) &= integral_RR dd(x) mel(phi, D_x^dagger, x) braket(x, psi) \
                            &= integral_RR dd(x) overline(mel(x, D_x, phi)) psi(x) \
                            &= integral_RR dd(x) pdv(overline(phi(x)), x) psi(x) \
                            &= cancel(eval(phi(x)psi(x))_(-oo)^(oo)) - integral_RR dd(x) overline(phi(x)) pdv(psi(x), x) $
  So the correct adjoint has no simple form but $-integral_RR compose overline(phi) compose pdv(, x)$.
  - The Hilbert Space $cal(H)$ is not defined to include $t$#footnote[Otherwise we are implying state to vanish at distant past and future.].
    Scalar product is always taken at fixed $t$. So it *makes no sense* to write
  $ (pdv(, t))^+ $
  And adjoint on $cal(H)$ commutes with $pdv(, t)$ as basically $t$ has nothing to
  do with $cal(H)$. Thus,
  $ (pdv(ket(phi(t)), t))^+ = pdv(bra(phi(t)), t) $
]<time-derivative-remark>

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

#pagebreak()
= Transformation and Symmetry
When we think of transformation, they actually form a group. That means there
exists a set of transformation $G$ and $compose: G times G to G$ that applies
one transformation after another. And they satisfy
1. $G$ is closed under $compose$.
2. $compose$ is associative.
3. There exists a transformation $e in G$ that does nothing: $e compose g = g$ for
  all $g in G$.
4. For every $g in G$, there exists $inv(g) in G$ such that $inv(g) compose g = e$.

These axioms are quite naturally required when we talk about any transformation
(e.g. rotation, reflection) for some physical system. And this chapter is to
basically find "representation" of these group elements $g$ as operators on the
Hilbert $cal(H)$. We denote the representation of $g$ as $op(U)(g): cal(H) to cal(H)$.

After some transformation, the probability for any measurement should remain the
same. This is particularly evident for coordinate transformation: any physics
should not be changed when we change coordinates. That is,
$ |braket(phi, psi)| = |mel(phi, op(U)^+(g) op(U)(g), psi)| $

Wigner's theorem says
#thm[Wigner's theorem][
  Any operator $op(U)$ such that
  $ |braket(phi, psi)| = |mel(phi, op(U)^+ op(U), psi)| $
  is either
  - Linear and unitary:
  $ op(U)(a ket(phi) + b ket(psi)) &= a op(U) ket(phi) + b op(U) ket(psi) \
  mel(phi, op(U)^+ op(U), psi)   &= braket(phi, psi) $
  or
  - Anti-linear and anti-unitary:
    $ op(U)(a ket(phi) + b ket(psi)) &= conj(a) op(U) ket(phi) + conj(b) op(U) ket(psi) \
    mel(phi, op(U)^+ op(U), psi)   &= braket(psi, phi) $
]

We will not prove Wigner's theorem. And we will consider our representation as
unitary and linear (i.e. ignore the other possibility).

Now, naturally we should have
$ op(U)(g_1 compose g_2) equiv op(U)(g_1) op(U)(g_2) $
So these two operators differ by a phase when acting on different states. That
is
$ op(U)(g_1 compose g_2) ket(phi) = exp(ii theta(g_1, g_2, ket(phi))) op(U)(g_1) op(U)(g_2) ket(phi) $

It can be proven @babis[Pg. 120] that this phase doesn't depend on $ket(phi)$,
and we can do some trick to get rid of the phase, that is to get representation
such that
$ op(U)(g_1 compose g_2) = op(U)(g_1) op(U)(g_2) $

== Schro\u{308}dinger and Heisenberg Pictures
When we transform states $ket(phi) to op(U) ket(phi) = ket(phi')$, it is said we
are using Schro\u{308}dinger picture. Transformation can also alternatively be
viewed as acting on the operators. That is for all $ket(phi)$,
$ expval(op(Q), phi') = expval(op(U)^+ op(Q) op(U), phi) $

So we can define $ op(Q)' := op(U)^+ op(Q) op(U) $ and transform operators
instead of states. This is the Heisenberg Picture.

== Continuous Transformation
Some transformation (e.g. rotation, displacement) can have uncountable elements,
parameterized by some parameter $theta_a, a = 1, 2, 3, dots, N$.

When $theta_a = 0$ for all $a$, we set $g(theta_a) = e$. This also naturally
gives $op(U)(g(0)) = II$.

We assume#footnote[This should be able to made rigorous, but that involves quite amount of math.
  Better just take a leap of faith.] that their representation is differentiable
with respect of parameters. That is, if the group is parameterized by a single
continuous parameter $a$, then

$ eval(dv(op(U)(g(a)), a))_(a=0) =: -ii op(T) op(U)(g(0)) = -ii op(T) $

Here $-ii$ is taken by convention. $op(T)$ is called the generator.

#def[Generator][
  Let $g(theta_a)$ be parameterized by $theta_a, a = 1,2,3,dots, N$. Then define
  generator $op(T)_a$ as
  $ eval(pdv(op(U)(g(theta_a)), theta_a))_(theta_a = 0, forall a) =: -ii op(T)_a $
]

#thm[Generator is Hermitian]<generator-is-hermitian>
#proof[
  Since $op(U)$ is unitary, $ eval(pdv(op(U)^+ op(U), theta_a))_(theta_a = 0, forall a) = eval(pdv(II, theta_a))_(theta_a = 0, forall a) = 0 $ <eqn-generator-hermitian>
  Just like differentiating state with respect to time (see
  @time-derivative-remark), this differentiation on operator commutes with $dagger$,
  we have
  $ eval(pdv(op(U)^+, theta_a))_(theta_a = 0, forall a) =: ii op(T)_a^+ $
  By product rule, @eqn-generator-hermitian gives (ommiting evaluation for
  simplicity)
  $ pdv(op(U)^+, theta_a) op(U) + op(U)^+ pdv(op(U), theta_a) = - ii op(T)_a + ii op(T)_a^+ = 0 $
  thus $ op(T)_a = op(T)_a^+ $
]
#remark[
  It follows
  $ eval(pdv(op(U)^+, theta_a))_(theta_a = 0, forall a) =: ii op(T)_a $
]

If we assume $op(U)$ is nice, we can also "integrate" to get $op(U)(g(theta_a)) = exp(-i theta_a op(T)_a)$ where
we used Einstein convention so $theta_a op(T)_a equiv sum_a theta_a op(T)_a$.

=== Translation
As an easy example, consider the translation transformation. This group would be
parameterized naturally by some vector $vb(a) in RR^N$. For simplicity, we write
$ op(U)(vb(a)) := op(U)(g(vb(a))) $

*For any vector operator, we expect them to transform like an vector in
components*. Since translation in ordinary vector space would mean $v_i to v_i + a_i$,
in Heisenberg picture, we expect
$ (op(x)_i)':= op(U)^+(vb(a)) op(x)_i op(U)(vb(a)) = op(x)_i + a_i $

Let the generator of $U(vb(a))$ be $op(Gamma)_i$, we can differentiate the above
equation with respect to $a_j$ and evaluate at $vb(a) = vb(0)$ to get
$ ii op(Gamma)_j op(x)_i - ii op(x)_i op(Gamma)_j &= delta_(i,j) \
-ii [op(x)_i, op(Gamma)_j]                      &= delta_(i,j) \
[op(x)_i, op(Gamma)_j]                          &= ii delta_(i,j) $

And we may#footnote[I am skeptical that this commutator relation would completely define $op(Gamma)_j$] identify
$ op(Gamma)_j = op(p)_j / hbar $
And
$ op(U)(vb(a)) = exp(-ii a_j op(p)_j/hbar) equiv exp(-ii vb(a)/hbar cdot vecop(p)) $

At this stage, we have two "definition" of $op(p)_i$. Set $ket(phi) = U(vb(a)) ket(phi_0)$ where $ket(phi_0)$ is
a constant initial state.
$ ii hbar pdv(ket(phi), a_i)           &= ii hbar (-i op(p)_i / hbar) ket(phi) = op(p)_i ket(phi) \
ii hbar pdv(braket(vb(x), phi), a_i) &= mel(vb(x), op(p)_i, phi) $<alt-momentum-def>
And
$ -ii hbar pdv(braket(vb(x), phi), x_i) = mel(vb(x), op(p)_i, phi) $

To reconcile this, notice,
$ expval(vecop(x), op(U)(vb(a)) vb(x)) = expval(op(U)^+(vb(a))vecop(x) op(U)(vb(a)), vb(x)) = expval(vecop(x) + vb(a) II, vb(x)) = vb(x) + vb(a) $
So $ op(U) (vb(a)) = ket(vb(x)+vb(a)) $
And $ mel(vb(x), op(U)(vb(a)), phi_0) = braket(op(U)^+(vb(a)) vb(x), phi_0) = braket(op(U)(-vb(a)) vb(x), phi_0) = braket(vb(x) - vb(a), phi_0) $

So @alt-momentum-def becomes
$ ii hbar pdv(braket(vb(x)-vb(a), phi_0), a_i) &= mel(vb(x), op(p)_i, phi) \
                                             &= -ii hbar pdv(braket(vb(x)-vb(a), phi_0), x_i) \
                                             &= -ii hbar pdv(braket(vb(x), phi), x_i) $

And these two formulation are thus equivalent.

=== Rotation Transformation
We parameterize rotation by the rotation axis vector $vb(alpha) in RR^3$. And
for any vector operator component $op(v)_i$, we _expect_
$ op(U)^+(vb(alpha)) op(v)_i op(U)(vb(alpha)) = R_(i,j) op(v)_j $<rotation-vector-op>
where $R_(i,j)$ is the rotation matrix corresponding to the axis vector $vb(alpha)$.

Remember the orthogonal matrix $R$ can be changed into a special basis
$ R = O^TT A O $
where $O$ is an orthogonal matrix that transforms $x$-axis to $hat(vb(alpha))$.
So under that basis,
$ A = mat(1, 0, 0;0, cos(alpha), -sin(alpha);0, sin(alpha), cos(alpha)) $
where $alpha = |vb(alpha)|$.

And we can differentiate $R$ with respect to $alpha$ and evaluate at $alpha = 0$,
$ dv(R, alpha) = O^TT mat(0, 0, 0;0, 0, -1;0, 1, 0) O $

And notice $ op(U)(vb(alpha)) = exp(-ii alpha hat(vb(alpha)) cdot vecop(J)) $ where $vecop(J)$ is
the generator which we will expect to be a vector operator#footnote[It turns out to be proportional to angular momentum, so it's a expected to be a
  vector.].

Now, differentiate @rotation-vector-op with respect to $alpha$ and evaluate at $alpha = 0$,
$ ii [hat(vb(alpha)) cdot vecop(J), op(v)_i] = (dv(R, alpha))_(i,j) op(v)_j $

Now, set $hat(vb(alpha)) = hat(vb(x)), hat(vb(y)), hat(vb(z))$ one at a time
gives the commutation relation (just plug in and verify)

$ [op(J)_i, op(v)_j] = ii epsilon_(i,j,k) op(v)_k $

#info[
  The outline of a logical derivation for angular momentum is actually:
  1. Parameterize rotation group $G$ by orthogonal matrix $R(vb(alpha))$ where $vb(alpha)$ is
    the rotational axis with magnitude.
  2. Write
  $ inv(op(U))(R(vb(beta))) op(U)(R(vb(alpha))) op(U)(R(vb(beta))) = op(U)(inv(R)(vb(beta) R(vb(alpha)) R(vb(beta)))) $
  and differentiate the expression with respect to parameters $alpha_k$ to get
  $ inv(op(U))(R(vb(beta))) op(J)_k op(U)(R(vb(beta))) = R(vb(beta))_(k,l) op(J)_l $<transforms-like-vector>
  where $op(J)_k$ are generator corresponding to $alpha_k$. These $op(J)_k$ as we
  see later is components of a vector operator $vecop(J)$.
  3. Now differentiate with respect to $beta_j$ and set certain $vb(beta)$ to get the
    commutation relation for $op(J)_k$.
  $ [op(J)_i, op(J)_j] = ii epsilon_(i,j,k) op(J)_k $
  4. @transforms-like-vector has a nice explanation due to Heisenberg picture, it's
    essentially that components $op(J)_k$ of $vecop(J)$ transforms like a vector
    under rotation. And we use that equation as the criterion for any tuple of
    operator to be called a vector operator.

  However, going to @transforms-like-vector is not really trivial#footnote[See @babis[Pg. 128, Eqn. 10.65] for a proper derivation],
  we will argue physically to arrive there#footnote[Follows the route of @binney[Chapter 4]]. _However, that inverts the proper logic._
]

== Adding Electromagnetic Fields, Gauge Invariance
= Angular Momentum
== Common Commutation Relations and Spectrum
== Spin and Orbital Angular Momentum
== Spherical Harmonics

= Composite Systems and Identical Particles
To model system of particles, we need the following postulate.
#postl[Hilbert Space of Composite System][
  Let quantum systems $A, B$ have Hilbert space $cal(H)_A, cal(H)_B$ respectively,
  their collective state lives in the tensor product space
  $ cal(H)_A tp cal(H)_B $
]
The idea for this postulate is rather simple: linear combination of state is
important to quantum mechanics. And if $ket(phi_1), ket(phi_2) in cal(H)_A, ket(psi_1), ket(psi_2) in cal(H)_B$,
and if systems are such that without interaction, then we should have collective
state represented $ket(phi_1) tp ket(psi_2), ket(phi_2) tp ket(psi_1)$ etc.
However, for linear combination of them to also be in the collective Hilbert
space, we will be writing
$ alpha ket(phi_1) tp ket(psi_2)+ beta ket(phi_2) tp ket(psi_1) $
which is exactly what tensor product structure allows us to do.

By the theory of tensor product, if ${ket(alpha_i)}, {ket(beta_j)}$ are basis of $cal(H)_A, cal(H)_B$ respectively, ${ket(alpha_i) tp ket(beta_j)}$ is
a basis of $cal(H)_A tp cal(H)_B$. However, it should be noticed that _eigenbasis of individual systems tensored together doesn't necessarily give an
eigenbasis of collective system's Hamiltonian_ if there are interaction betweeen
systems.

If we have three particles, we can go on and regard first two particles as a
single quantum _system_, and apply the postulate again and arrive at
$ (cal(H)_A tp cal(H)_B) tp cal(H)_C caniso cal(H)_A tp cal(H)_B tp cal(H)_C $

Since we have got Hilbert space, Schro\u{308}dinger equation and measurement
postulate generalizes.
#caution[
  With Symmetrization Postulate introduced later, we cannot use the same Hermitian
  operators for individual system to represent the measurement on part of the
  system (e.g. on one particle of the two particle system), we have to use the
  symmetrization-preserving version of them.
]

Operators that act only on part of the system like $op(S)_z^(A): cal(H)_A to cal(H)_A$ are
strictly speaking written as $op(S)_z^(A) tp II: cal(H)_A tp cal(H)_B to cal(H)_A tp cal(H)_B$.
However, for simplicity, we omit this writing.

For simplicity, we will also write product state without tensor product, that is
$ ket(phi) tp ket(psi) equiv ket(phi) ket(psi) $

== Identical and Indistinguishable Particles#footnote[Much of this section is inspired by @littlejohn[Notes 29]. I added
  symmetrization of operator though.]
Sometimes, the two quantum system we consider are *identical*#footnote[We will have different meaning for "indistinguishable" and "identical".],
that is $cal(H)_A = cal(H)_B = cal(H)$.

#def[Identical System][
  Two quantum systems $A,B$ are identical if $cal(H)_A = cal(H)_B$.
]<identical-system>

Now, we introduce an exchange operator $op(Pi)$.
#def[Exchange Operator][
  Given two identical quantum system $A, B$, let ${ket(alpha_i)}$ be a basis for $cal(H)$ (remember $cal(H)_A =cal(H)_B$).

  Define the exchange operator $op(Pi): cal(H) tp cal(H) to cal(H) tp cal(H)$ such
  that
  $ op(Pi) ket(alpha_i) tp ket(alpha_j) = ket(alpha_j) tp ket(alpha_i) $
  for all $i,j$ and use linearity.
]

#thm[$op(Pi)$ is well defined][
  The definition of $op(Pi)$ doesn't depend on basis ${ket(alpha_i)}$.
]
#proof[
  Let ${ket(beta_j)}$ be another basis of $cal(H)$. Let $a_(j,i)$ be such that
  $ ket(beta_j) = sum_i a_(j,i) ket(alpha_i) $

  #pfstep(
    finished: true,
  )[$op(Pi) ket(beta_k) tp ket(beta_l) = ket(beta_l) tp ket(beta_k)$][
    $ op(Pi) ket(beta_k) tp ket(beta_l) &= op(Pi) (sum_i a_(k,i) ket(alpha_i)) tp (sum_j a_(l,j) ket(alpha_j)) \
                                      &= sum_i sum_j a_(k,i) a_(l,j) op(Pi) ket(alpha_i) tp ket(alpha_j) \
                                      &= sum_i sum_j a_(k,i) a_(l,j) ket(alpha_j) tp ket(alpha_i) \
                                      &= (sum_j a_(l,j) ket(alpha_j)) tp (sum_i a_(k,i) ket(alpha_i)) \
                                      &= ket(beta_k) tp ket(beta_l) $
  ]
  Since $op(Pi)$ is linear, definition of $op(Pi)$ using ${ket(alpha_i)}$ is
  equivalent to definition using ${ket(beta_j)}$.
]

#thm[$op(Pi)^2 = II$]
#proof[By direct verification]

#thm[$op(Pi)$ is unitary]
#proof[
  #pfstep(
    finished: true,
  )[$op(Pi)^dagger op(Pi) = II$][
    We have $ (ket(alpha_j) tp ket(alpha_i))^+ = (op(Pi) ket(alpha_i) tp ket(alpha_j))^+ = bra(alpha_i) tp bra(alpha_j) op(Pi)^dagger $
    And $ (bra(alpha_k) tp bra(alpha_l)) op(Pi)^dagger op(Pi) (ket(alpha_i) tp ket(alpha_j)) &= (op(Pi) ket(alpha_k) tp ket(alpha_l))^+ op(Pi) (ket(alpha_i) tp ket(alpha_j)) \
                                                                                       &= bra(alpha_l) tp bra(alpha_k) (ket(alpha_j) tp ket(alpha_i)) \
                                                                                       &= delta_(l,j) delta_(k,i) $
    which means $op(Pi)^dagger op(Pi) = II$.
  ]
]

#def[Indistinguishable System][
  Two systems are indistinguishable if they are identical _and_ their Hamiltonian
  commutes with $op(Pi)$. That is
  $ [op(H), op(Pi)] = 0 $
]<indistinguishable-system>

#eg[
  Consider two electrons, and their Hamiltonian being
  $ op(H) = vecop(p_1)^2 / (2m) + vecop(p_2)^2 / (2m) + V(|vecop(x_1) - vecop(x_2)|) $
  This is indistinguishable as the Hamiltonian commutes with $op(Pi)$.

  Specifically, for any product state $ket(phi_1) tp ket(phi_2)$,
  $ bra(vb(a)) tp bra(vb(b)) V(|vecop(x_1) - vecop(x_2)|) op(Pi) ket(phi_1) tp ket(phi_2) &= bra(vb(a)) tp bra(vb(b)) V(|vecop(x_1) - vecop(x_2)|) ket(phi_2) tp ket(phi_1) \
                                                                                        &= V(|vb(a) - vb(b)|) bra(vb(a)) tp bra(vb(b)) (ket(phi_2) tp ket(phi_1)) \
                                                                                        &= V(|vb(a) - vb(b)|) phi_2(vb(a)) phi_1(vb(b)) $
  $ bra(vb(a)) tp bra(vb(b)) op(Pi) V(|vecop(x_1) - vecop(x_2)|) ket(phi_1) tp ket(phi_2) &= bra(vb(a)) tp bra(vb(b)) op(Pi)^+ V(|vecop(x_1) - vecop(x_2)|) ket(phi_1) tp ket(phi_2) \
                                                                                        &= bra(vb(b)) tp bra(vb(a)) V(|vecop(x_1) - vecop(x_2)|) ket(phi_1) tp ket(phi_2) \
                                                                                        &= V(|vb(b) - vb(a)|) bra(vb(b)) tp bra(vb(a)) (ket(phi_1) tp ket(phi_2)) \
                                                                                        &= V(|vb(a) - vb(b)|) phi_2(vb(a)) phi_1(vb(b)) $
  Thus the potential part commutes for basis elements in particular (use the
  product basis constructed out of basis of individual system). And the kinetic
  part also commutes for similar reason.
]

#eg[
  Consider two electrons with Hamiltonian
  $ op(H) = vecop(p_1)^2 / (2m) + vecop(p_2)^2 / (2m) + V(vecop(x_1)) + 2V(vecop(x_2)) $
  This is *not* indistinguishable _despite two systems are identical (@identical-system)_ for
  their individual Hilbert space.
]<identical-but-distinguishable-eg>

#eg[
  Consider one spin-1 boson and one spin-$1/2$ fermion with Hamiltonian
  $ op(H) = vecop(p_1)^2 / (2m) + vecop(p_2)^2 / (2m) $
  This is *not* indistinguishable and Hamiltonian doesn't commute actually (*even
  if it looks like so!*).

  This is because bosons have integer spin while fermions have half integer spin,
  and if we write out, for boson
  $ cal(H)_1 = L^2(RR^3) tp CC^3 $
  and for fermion
  $ cal(H)_2 = L^2(RR^3) tp CC^2 $

  And if we define exchange operators as before, $op(Pi): cal(H)_1 tp cal(H)_2 to cal(H)_2 tp cal(H)_1$,
  And $op(H): cal(H)_1 tp cal(H)_2 to cal(H)_1 tp cal(H)_2$. So $[op(Pi), op(H)]$ doesn't
  even make sense in terms of type.
]

Often it's easier to consider effect of exchange operator on other operators.

Consider $vecop(x)_1 tp II$. We have for any product state $ket(phi_1) ket(phi_2)$ and $vb(a), vb(b)$,
$ bra(vb(a)) bra(vb(b)) (vecop(x_1) tp II) compose op(Pi) (ket(phi_1) ket(phi_2)) &= bra(vb(a)) bra(vb(b)) (vecop(x_1) tp II) ket(phi_2) ket(phi_1)\
                                                                                &= vb(a) phi_2(vb(a)) phi_1(vb(b)) \
                                                                                &= bra(vb(a)) bra(vb(b)) op(Pi) compose (II tp vecop(x_2)) (ket(phi_1) ket(phi_2)) $

So $vecop(x_1) compose op(Pi) = op(Pi) compose vecop(x_2)$.

For a similar calculation (actually redundant),
$ bra(vb(a)) bra(vb(b)) op(Pi) compose (vecop(x_1) tp II) (ket(phi_1) ket(phi_2)) &= bra(vb(b)) bra(vb(a)) (vecop(x_1) tp II) ket(phi_1) ket(phi_2)\
                                                                                &= vb(b) phi_2(vb(a)) phi_1(vb(b)) \
                                                                                &= bra(vb(a)) bra(vb(b)) (II tp vecop(x_2)) compose op(Pi) (ket(phi_1) ket(phi_2)) $

So $op(Pi) compose vecop(x_1) = vecop(x_2) compose op(Pi) $.

And by $op(Pi)^2 = II$ and $op(Pi)^+ = op(Pi)$, we have
$ vecop(x_1) compose op(Pi) = op(Pi) compose vecop(x_2) implies vecop(x_1) = op(Pi)^+ compose vecop(x_2) compose op(Pi) $

That is, $vecop(x_2)$ transforms $vecop(x_1)$ under symmetrization, as expected.

Following the same argument, we have $vecop(p_1) = op(Pi)^+ compose vecop(p_2) compose op(Pi)$

Moreover, $ op(Pi)^+ vecop(p_1)_x compose vecop(p_1)_x compose op(Pi) &= vecop(p_2)_x compose op(Pi) compose op(Pi) compose vecop(p_2)_x \
                                                          &= vecop(p_2)_x compose II compose vecop(p_2)_x = vecop(p_2)_x^2 $

This means $ op(Pi)^+ vecop(p_1)^2 op(Pi) = vecop(p_2)^2 $ as we would expect.

As a rule of thumb, $op(Pi)^+ op(O) op(Pi)$ swaps the label $1,2$ in $op(O)$.

== Symmetrization Postulate
We are at the position to state the postulate
#postl[Symmetrization Postulate][
  Let the total system consists of $N$ (non-composite#footnote[Saying protons or nucleus being "non-composite" is sort of wrong as they consist
    of quarks. But they are fundamental enough for us. In fact _it matters little_ as
    we later discuss fermionic/bosonic property of composite particles.])
  particles. #underline[Any] physically realizable state of the system must be
  - symmetric under exchange operator of _any indistinguishable_ pair of bosons
  - anti-symmetric under exchange operator of _any indistinguishable_ pair of
    fermions

  And any physically realizable operators must be invariant under the $cal(H)_"phys"$,
  subspace of states with correct symmetry. That is, any physical operators cannot
  map physical state into unphysical state.
]<symmetrization-postulate>
#info[
  This postulate is used _in reverse_ to _define_ the fermionic or bosonic
  property of two indistinguishable #underline[composite] particles. More on this
  later.
]

#caution[
  It should be clear about what this postulate actually applies to:
  indistinguishable particles.

  Consider the Hamiltonian in @identical-but-distinguishable-eg, the two electrons
  are distinguishable and the symmetrization postulate is empty: it says nothing
  about symmetry of physical states.
]

@symmetrization-postulate makes the physical Hilbert space a subspace $cal(H)_("phys")$ of
the $cal(H)_1 tp dots.c tp cal(H)_N = cal(H)_"tot"$, and you can construct that
subspace by taking eigenstates of individual particle and tensor them up while
keeping in mind the symmetry (see also Slater determinant).

One caveats is that the postulate cannot guarantee#footnote[Simultaneous diagonalization doesn't work if we have say $N=3$ indistinguishable
  particles as $[op(Pi)_12, op(Pi)_23] eq.not 0$] (at least from what literally
displayed) the existence of eigenstates of the total system with required
symmetry.

Nevertheless, it would be quite unphysical if we cannot. The reason is
Hamiltonian as a physical operator should map physical state to physical state,
which means it must be invariant under subspace $cal(H)_"phys"$, so we can write
the restriction:
$ op(H): cal(H)_"phys" subset.eq cal(H)_"tot" to cal(H)_"phys" $

Now since $op(H)$ is Hermitian in the total space, it's Hermitian in the
subspace as well, so it can be diagonalized in the subspace $cal(H)_"phys"$ and
thus admit eigenstates of correct symmetry.

We can now consider consequence of @symmetrization-postulate. For simplicity, we
will mainly discuss $N=2$ case.

== Pauli Exclusion Principle
Consider two identical and indistinguishable fermions (say electrons) under
Hamiltonian
$ op(H) = op(H)_1 + op(H)_2 $
where $op(H)_1, op(H)_2$ are actually the same except that they are acting on
different space (one for each electron). Let ${ket(phi_i)}$ be the eigenstates
of $op(H)_1, op(H)_2$, then Pauli exclusion principle is a consequence of
@symmetrization-postulate, saying

$ ket(phi_i) tp ket(phi_i) $
is not a physical state because this state is symmetric under exchange operator
of two indistinguishable _fermions_.

One natural question is then what the eigenspaces of $op(H)$ under $cal(H)_"phys"$ restriction
are. For this, let's construct the $cal(H)_"phys"$ explicitly first.

#thm[Symmetric and Anti-symmetric subspace][
  Given $cal(H) tp cal(H)$ and ${ket(alpha_i)}$ being basis fo $cal(H)$, the space $cal(H) tp cal(H)$ can
  be decomposed into dirac sum of two subspaces
  $ epsilon_"even" := span { cases(
    ket(alpha_i) tp ket(alpha_j) "if" i=j,
    1/sqrt(2) (ket(alpha_i) tp ket(alpha_j) + ket(alpha_j) tp ket(alpha_i)) "if" i eq.not j,

  ) } $
  and
  $ epsilon_"odd" := span {
  1/sqrt(2) (ket(alpha_i) tp ket(alpha_j) - ket(alpha_j) tp ket(alpha_i)), i eq.not j
  } $
]<construction-of-symmetry-subspace>
#proof[
  We can directly verify that $epsilon_"even"$ is exchange symmetric and $epsilon_"odd"$ is
  anti-symmetric.

  For the proof of being a basis, notice for any $i eq.not j$,
  $ ket(alpha_i) tp ket(alpha_j) = 1/sqrt(2) (1/sqrt(2) (ket(alpha_i) tp ket(alpha_j) - ket(alpha_j) tp ket(alpha_i)) + 1/sqrt(2) (ket(alpha_i) tp ket(alpha_j) + ket(alpha_j) tp ket(alpha_i))) $

  So these two spaces are generating, and their dimensions add up to the total
  dimension.
]

With @construction-of-symmetry-subspace, we can just use the eigenstates of $op(H)_1$ as $ket(alpha_i)$.
And since we are dealing with electron (fermion), we take the $epsilon_"odd"$ as $cal(H)_"phys"$.

If the Hamiltonian commutes#footnote[Actually, on the ground of angular momentum conservation of the total system,
  this must be the case.] with $op(J^2)^"tot", op(J_z)^"tot"$, then we can have
a Hamiltonian eigenbasis:
- of right symmetry
- with well defined total angular momentum magnitude and $z$ component

As $op(J^2)^"tot", op(J_z)^"tot"$ commutes with $op(Pi)$. In fact, the usual
addition of angular momentum result for spin-1/2 particles (i.e. the "triplet" "singlet")
are automatically having well-defined symmetry.

To obtain such basis, just use the textbook-style "matching spatial symmetric
with spin anti-symmetric" and "spatial anti-symmetric with spin symmetric". To
prove we indeed have a basis, observe we have the right number of linearly
independent vector.

It should be stressed that *usually system are not in states with so much
well-defined observables*. For example, consider an empty Hamiltonian and two
electrons, then

$ 1/sqrt(2) (underbrace((ket(vb(a)) tp ket(spinup)), "\"first\" electron") tp underbrace((ket(vb(b)) tp ket(spindown)), "\"second\" electron") - underbrace((ket(vb(b)) tp ket(spindown)), "\"first\" electron") tp underbrace((ket(vb(a)) tp ket(spinup)), "\"second\" electron")) $<non-entangled-state>

is a state satisfying the symmetrization postulate. I have added "first" "second"
in quote to emphasize the notion of first or second is nominal and physical
state space has symmetry between first and second.

=== Entanglement or Not? Operator Symmetrization
This state (@non-entangled-state) _seems to be_ a non-product space: we cannot
write it into the form
$ ket(phi) tp ket(psi), ket(phi) in cal(H) $

But in fact it's not an entangled state _with respect to our usual measurement_.
This again means our naive space $cal(H) tp cal(H)$ isn't really a very
favorable one as it doesn't describe our physics obviously.

The physical meaning of @non-entangled-state is quite simple: an#footnote[Notice saying _an_ electron instead of _first_ or _the_ electron is a
  non-redundant description of the total system.] electron with $hbar/2$ in spin $z$ direction
at position $vb(a)$ and another electron with spin $-hbar/2$ in spin $z$ direction
at position $vb(b)$.

We _expect_, because of such simple physical interpretation, that we should be
able to measure the spin-$z$ of particle at $vb(a)$ and get a definite answer,
irrespective of how particle at $vb(b)$ behaves -- after all their physical
description look quite unentangled.

So how to measure the spin-$z$ of the particle at $vb(a)$?

For an operator to be physical, we demand it must be invariant under $cal(H)_"phys"$ by
@symmetrization-postulate. A _sufficient_ condition for this to hold is
#thm[$op(O)$ is physical if $[op(O), op(Pi)] = 0$]
#proof[
  #pfstep[$op(O)$ is physical $iff$ $op(Pi) op(O) ket(phi) = lambda op(O) ket(phi)$ for
    all $ket(phi) in cal(H)_"phys"$ where $lambda = plus.minus 1$ depending $cal(H)_"phys"$.][
    A state $ket(phi) in cal(H)_"phys"$ if and only if
    $ op(Pi) ket(phi) = plus.minus ket(phi) $
    where $plus.minus$ depends on whether symmetrical or anti-symmetrical state are
    physical (c.f. @symmetrization-postulate).

    So for $op(O) ket(phi) in cal(H)_"phys"$,
    $ op(Pi) op(O) ket(phi) = plus.minus op(O) ket(phi) $
  ]
  #pfstep(
    finished: true,
  )[$[op(O), op(Pi)] = 0 implies op(Pi) op(O) ket(phi) = lambda op(O) ket(phi)$ for
    all eigenvector $ket(phi)$ of $op(O)$][
    $ op(Pi) op(O) ket(phi) &= op(O) op(Pi) ket(phi) \
                          &= lambda op(O) ket(phi) $
    for any eigenvector $ket(phi)$ of $op(Pi)$.
  ]
]
#remark[If multiple exchange symmetry is required by @symmetrization-postulate, just
  make $op(O)$ commutes with all of them.]

Clearly
$ (ketbra(vb(a), vb(a)) tp op(S_z)) tp overbrace(II, "on" cal(H)) $
doesn't work because it's not of correct symmetry. We can verify that
$ op(Pi)^+ (ketbra(vb(a), vb(a)) tp op(S_z)) tp II op(Pi) = II tp (ketbra(vb(a), vb(a)) tp op(S_z)) $

However, the operator
$ op(S_z^vb(a)) := (ketbra(vb(a), vb(a)) tp op(S_z)) tp II + II tp (ketbra(vb(a), vb(a)) tp op(S_z)) $ is
exchange symmetric. And apply it on @non-entangled-state. Part by part:
$ op(S_z^vb(a)) 1/sqrt(2) (ket(vb(a)) tp ket(spinup)) tp (ket(vb(b)) tp ket(spindown)) &= 1/sqrt(2) ((underbrace(braket(vb(a), vb(a)), 1) ket(vb(a)) tp hbar/2 ket(spinup)) tp (ket(vb(b)) tp ket(spindown)) \
  & - cancel(
  (ket(vb(a)) tp ket(spinup)) tp (underbrace(braket(vb(a), vb(b)), 0) ket(vb(a)) tp -hbar / 2ket(spindown))
)) \
                                                                                     &= hbar /2 1/sqrt(2) (ket(vb(a)) tp ket(spinup)) tp (ket(vb(b)) tp ket(spindown)) $

Similar to the other half,
$ op(S_z^vb(a)) 1/sqrt(2) (ket(vb(b)) tp ket(spindown)) tp (ket(vb(a)) tp ket(spinup)) = hbar/2 1/sqrt(2) (ket(vb(b)) tp ket(spindown)) tp (ket(vb(a)) tp ket(spinup)) $

So together @non-entangled-state is an eigenstate of $op(S_z^vb(a))$ with
eigenvalue $hbar /2$.

Notice our operator works however $vb(b)$ changes (as long as $vb(a) eq.not vb(b)$)
and the spin state of the other electron changes.

#info[
  This is why electron spin measurement at lab isn't influenced by
  anti-symmetrization with some other random electron light years away. Despite
  @non-entangled-state looks entangled.
]

To really have some entanglement, consider the following state (also an
eigenstate of total angular momentum magnitude and component):
$ ket(Psi):= 1/2 overbrace(
  (underbrace(ket(vb(a)), "1st") underbrace(ket(vb(b)), "2nd") + ket(vb(b)) ket(vb(a))),
  "spatial parts of two electrons",

) tp (ket(spinup) tp ket(spindown) - ket(spindown) tp ket(spinup)) $

Here I shifted position of different vectors when they get tensored together, so
product state is now in the format
$ ket("spatial of 1st") tp ket("spatial of 2nd") tp ket("spin of 1st") tp ket("spin of 2nd") $
instead of
$ ket("spatial of 1st") tp ket("spin of 1st") tp ket("spatial of 2nd") tp ket("spin of 2nd") $

If we apply $op(S_z^vb(a))$ to this state, we find at the end
$ 1/2 hbar /2 ket(vb(a)) ket(vb(b)) tp (ket(spinup) tp ket(spindown) + ket(spindown) tp ket(spinup)) &- 1/2 hbar /2 ket(vb(b)) ket(vb(a)) tp (ket(spinup) tp ket(spindown) + ket(spindown) tp ket(spinup)) \
                                                                                                   &= 1/2 hbar /2 (ket(vb(a)) ket(vb(b)) - ket(vb(b)) ket(vb(a))) tp (ket(spinup) tp ket(spindown) + ket(spindown) tp ket(spinup)) $

So it's not an eigenstate of $op(S_z^vb(a))$.

The probability of measuring $spinup$ for the electron at $vb(a)$ is usually
given by projecting to the subspace. However, here it's not really convenient to
do this, we'd better proceed by using density operator.

We know that $ expval(op(S_z^(a))) = Tr(op(rho) op(S_z^vb(a))) $

#text(
  red,
)[It's getting actually not easy at this point. Partial tracing $op(rho)$ with "first"/"second"
  subspace doesn't seem to be physically meaningful to me. Partial tracing out the
  position subspace of the total system doesn't give very useful information about "spin
  of particle at specific location" either. Can we get to an elegant solution?]

#idea[
  At the end of the day, all these formalism about identical particle basically
  says our $cal(H)_1 tp dots.c tp cal(H)_N$ is too large. There should be a more
  natural space to work with, and it's related to Fock's space and relativistic
  quantum field theory.
]

== Composite Particle and Exchange Symmetry
Consider two identical and indistinguishable composite system, say two hydrogen
but _mutually not interacting_. Each hydrogen consists of one proton and one
electron where within each hydrogen the proton and electron are apparently
neither identical nor indistinguishable.

The total Hilbert space of this case is $ underbrace((cal(H)^1_e tp cal(H)^1_p), "space of hydrogen 1") tp (cal(H)^2_e tp cal(H)^2_p) $

Again "$1,2$" labeling here are nominal but not physical.

And Hamiltonian for each Hydrogen is
$ op(H)_"hydrogen" = (vecop(p)_p)^2 / (2m_p) + (vecop(p)_e)^2 / (2m_e) - 1/(4pi epsilon_0) e^2 /( |vecop(x)_p - vecop(x)_e|) $
The total Hamiltonian is two copy of $op(H)_"hydrogen"$. Clearly it's commuting
with:
- exchanging electron of hydrogen 1 with electron of hydrogen 2, denote as $op(Pi)_e$
- exchanging proton of hydrogen 1 with proton of hydrogen 2, denote as $op(Pi)_p$

Since both proton and electron are fermion, by @symmetrization-postulate, we
must have anti-symmetry on each of the above two exchanges.

*The important thing* is we can define a composite exchange that exchange two
hydrogen by performing $op(Pi)_e, op(Pi)_p$ at once. That is
$ op(Pi)_H := op(Pi)_e compose op(Pi)_p $
Clearly total Hamiltonian commutes with $op(Pi)_H$. So Hydrogen as a composite
subsystem of the total system is identical and indistinguishable according to
@indistinguishable-system.

And since any physical state $ket(phi)$ must be anti-symmetric about $op(Pi)_e, op(Pi)_p$ separately,
if we apply both, $ket(phi)$ will behave indeed symmetrically. And this means
any physical state is symmetric under $op(Pi)_H$.

By _reversing_ the @symmetrization-postulate, we _define_ Hydrogen to be a
bosonic composite particle as it behaves like a boson upon $op(Pi)_H$.

#conclusion[In general, for a composite system, we can just count the number of fermion $f$ in
  the system and the particle has symmetry $(-1)^f$ and is bosonic if $f$ is even
  and fermionic if $f$ is odd.]
#eg[Helium-3 is a fermionic particle][
  Helium-3 has 2 protons, 1 neutron, 2 electrons, which are all fermions. So it
  has fermionic exchange symmetry.
]

== Applications to Statistical Mechanics
Counting eigenstate correctly is important for statistical mechanics. We will
work through a few common examples about how exchange symmetry affect how we
count states. And in the framework of statistical mechanics, Gibbs paradox is
inherently quantum#footnote[If chambers are filled with identical particles, then the direct reason entropy
  doesn't increase is increased anti-symmetry of the final eigenstates (we can
  swap particles between chamber as they are indistinguishable in the final
  Hamiltonian).].

=== Fermionic Harmonic Oscillator For the sake of simplicity,
Consider $N=2$ case. We are considering two spin-$1/2$ particles each
independently in a Harmonic potential. So individually the Hamiltonian is
$ op(H)_"each" = vecop(p)^2 / (2m) + 1/2 m omega^2 |vecop(x) - vb(a)|^2 $
where $vb(a)$ will be different for these two fermions as they are spatially
localized.

And we have two copy of this:
$ op(H) = op(H)_1 + op(H)_2 $

One important consequence of $vb(a)$ is that *two fermions are by definition
distinguishable!* Hamiltonian doesn't commute with exchange operator because $vb(a)$ will
be different for the two.

And in this case, we have no Pauli-exclusion whatsoever at all as
@symmetrization-postulate is empty. The whole space $cal(H)_1 tp cal(H)_2$ is
all physical.

Pauli-exclusion will take effect if two particles are in the _same_ potential
well.

=== Diatomic Gas#footnote[This example is partially studied in @littlejohn[Notes 29] as well.]
Consider a "gas" consisting of two non-interacting "molecules" each consists of
two identical spin-$1/2$ fermion. The Hilbert space of this problem is

$ underbrace((cal(H) tp cal(H)), "of a molecule") tp cal(H) tp cal(H) $

We will see despite in this problem all particles are identical, not all pairs
of particles are indistinguishable.

Each molecule has a Hamiltonian

$ op(H)_"molecule" = vecop(p_1)^2 / (2m) + vecop(p_2)^2 / (2m) + V(|vecop(x_1) -vecop(x_2)|) $

And total Hamiltonian is two copies of each molecule. Notice Hamiltonian
commutes with:
- exchanging two particles in molecule 1, denote as $op(Pi)_1$
- exchanging two particles in molecule 2, denote as $op(Pi)_2$
- exchanging two molecules, denote as $op(Pi)_m$

Commuting with $op(Pi)_m$ is ubiquitous in any ideal gas problem (this is the
origin of $N!$ in derivation of classical ideal gas partition function).

We could temporarily assume the exchange symmetry $op(Pi)_m$ doesn't exist, then
all we need to consider is eigenstates situation of each individual molecule and
multiply them together (essentially squared as they are the same). And apply
then the $N!$ approximation at the outcast.

The essential idea is we could deal with each level of symmetry individually.

Within the molecule, the symmetry is explained in more detail in
@littlejohn[Notes 29]. The result is different $l$ will give different
multiplicity#footnote[See also "spin isomer" of Hydrogen, and different multiplicity gives so-called "parahydrogen"
  or "orthohydrogen".], odd $l$ state will have an additional degeneracy of $3$ and
even $l$ only has $1$. This wouldn't be the case if two particles in the
molecule are non-identical (thus distinguishable) or distinguishable in
Hamiltonian.

This affects the thermodynamic property of the molecule gas, for detail, #link(
  "https://en.wikipedia.org/wiki/Spin_isomers_of_hydrogen",
)[see this Wikipedia page].

Just one thing to notice, $2l+1$ degeneracy we usually write is due to the
molecule rotation or due to $m$, whereas the degeneracy difference from exchange
symmetry is due to the spin triplet/singlet. So they are completely different,
despite all depends on $l$.

=== Gibbs Paradox
= Simple Problems and Famous Examples
== 1D Potential Problems
== 1D Harmonic Oscillators
== Central Potential Problem, 3D Harmonic Oscillator
== Hydrogen-like Atoms

= Perturbation Theory
== Time-independent Perturbation Theory
== Variation Approximation
== Sudden Limits
== Adiabatic Theorem
== Time-dependent Perturbation Theory
=== Selection Rule

#pagebreak()

#bibliography("./bib.yaml", style: "ieee")
