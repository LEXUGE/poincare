#import "@preview/physica:0.9.2": *
#import "@preview/gentle-clues:0.4.0": *
#import "@lexuge/templates:0.1.0": *
#import shorthands: *
#import pf3: *

#show: simple.with(
  title: "Essential Mathematics", authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
)

#let unproven = text(red)[This is not proven yet.]
#let unfinished = text(red)[This is not finished yet.]

#pagebreak()

= Differential Form and Manifolds
We follow the development of @form: start from open subset in $RR^n$ and then extend to manifold.

== Differential Forms on $RR^n$.
Elements in $RR^n$ can be either seen as points or vectors. And we can assign to each element $p in RR^n$ (when $RR^n$ is seen as a collection of points) a _tangent vector space_ $T_p RR^n$.

Unless otherwise stated, we think $T_p RR^n$ and $T_q RR^n$, where $p eq.not  q in RR^n$ are different points, as two different vector spaces, and vectors in them may not be added together.

We will write indices as $x_1, x_2, x_3, ...$. And in the case of $RR^(n lt.eq 3)$, we use $x,y,z$ and $x_1, x_2, x_3$ interchangeably. Often times, we label a multi-index use a sequence of index or an ordered set.
#def[Ordered Set][
	An ordered set $I$ is a sequence whose elements are unique. For example, $I=(1,2,1)$ will not be an ordered set. But $I = {1,3,2} eq.not {1,2,3}$ is an ordered set.
]<def-ordered-set>
The difference being that indices in a sequence can be repeating#footnote[For example, sequence $I=(1,2,1)$ represents $x_I equiv x_1, x_2, x_1$], whereas an ordered set would have unique indices.

#def[Smooth Function][
	Given an open $cal(R) subset.eq RR^n$, $f: cal(R) to RR$ is smooth if partial derivatives of all order exists at any point in $cal(R)$. We denote $f in C^oo (cal(R))$.
]
<def-smooth-fn>

The outline of the basic theory is:
1. Define $k$-form on $cal(R)$ as alternating multi-linear functional on $underbrace(T_p RR^n times dots.c times T_p RR^n, k text("times"))$
2. Find a elementary "basis"#footnote[They are not really a basis as we cannot use functions as fields for vector spaces.] for these $k$-forms.
3. Define Exterior Product. Those formal definition will just appear as concatenating elementary forms together. And they are linear and distributive, but _anti-commutative_. So doing product with elementary basis is intuitive.
4. Define Exterior Derivative.

#pagebreak()

#bibliography("./bib.yml", style: "ieee")
