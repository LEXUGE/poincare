#import "/templates/main.typ": simple, preamble, thm_typzk
#import preamble: *
#import thm_typzk: *
#show: simple.with(
  title: "Memo", authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
)
#show: setup
#show: thm_setup

#pagebreak()

= Statement of Purpose
Some observations:
1. Mention specific problems to tackle.
2. Mention what's the plan after graduation.
Example of the above two:
1. #link("https://docs.google.com/document/d/1r89b0JjerpDVmnKTBUOOMcZULh9JAO8F807pM1tNCEk/edit?tab=t.0")[Tony Wang Cornell Info Sci]

Questions:
1. How much "Oxford study" should I include in the SOP? i.e. mentioning specifics that I study.

Faculty members to ask:
#link("https://sites.lsa.umich.edu/mcaim/people/faculty/")[Faculty at Center of AIM]
1. #link("https://sites.google.com/site/asafcohentau/home")[Asaf Cohen]. Though his students doesn't seem to have "great" outlook?
  Keywords: MFG, Stats and Prob
2. #link("https://dept.math.lsa.umich.edu/~abloch/")[Anthony Bloch] Classical Mechanics and ODE
3. #link("https://sites.lsa.umich.edu/baik/")[Jinho Baik] This seems to be the most interesting one to me.
    His PhD descendent #link( "https://www.linkedin.com/in/hao-wu-3021aa128/" )[Hao Wu]
4. #link("https://dept.math.lsa.umich.edu/~millerpd/")[Peter Miller]

Other PhD/postdocs
1. #link("https://sjhaque14.github.io/")[Sabina Haque] Complex system, biomathematics.
2. #link("https://sites.google.com/umich.edu/nellisa/home")[April Neils], Cohen's student

Others:
1. Checkout #link("https://www.pdmi.ras.ru/~dchelkak/Notes/Math710_WN23.pdf")[Umich Math 710] and EPFL's Lattice Model notes to know what topics to talk about in the SOP.

= Derivation of Lorentz Transformation
Linearity of Lorentz transformation is actually very hard to derive.

Assume:
1. Coordinate Transformation is linear <as:lorentz-linear>
2. Law of physics is the same in all coordinates
3. Speed of light is invariant in all inertial frames <as:speed-of-light>


Let $g$ be the usual Minkowski metric matrix. $vb(v) in RR^4$ be any event (with time coordinate written in $c t$). $L: RR^4 to RR^4$ is the coordinate transformation, then
$ al vb(v), g vb(v) ar => al L vb(v), g L vb(v) ar $
because of #link(label("as:speed-of-light"))[(3)].

By #link( label( "as:lorentz-linear" ) )[(1)], $ al L cdot, g L cdot ar $ is a bilinear symmetric form. Then using #link("https://en.wikipedia.org/wiki/Derivations_of_the_Lorentz_transformations#Rigorous_Statement_and_Proof_of_Proportionality_of_ds2_and_ds%E2%80%B22")[Wikipedia argument], we have
$ al vb(v), g vb(v) ar  = alpha al L vb(v), g L vb(v) ar $
for all $vb(v)$ for some constant $alpha$.

This $alpha$ could depend on the velocity $vb(v)_0$ of the inertial frame and how coordinate axis are setup in that "moving" inertial frame.

Consider two inertial frames $M, M'$ both having the same axes orientations, but $M'$ moving along $x$ with respect to $M$. Now $alpha(vb(v)_0, "orientation")$ should be the same as $alpha(-vb(v)_0, "orientation")$ by isotropy of the space.

We then have
$ al vb(v), g vb(v) ar  = alpha(vb(v)_0) al L vb(v), g L vb(v) ar $
$ alpha(-vb(v)_0) al vb(v), g vb(v) ar  =  al L vb(v), g L vb(v) ar $
and
$ alpha(-vb(v)_0) alpha(vb(v)_0) = 1 $

Both should be 1 since otherwise we could try measure $alpha$ to determine a "preferred" direction. In fact this is well plausible because we can indeed calculate both sides.

The same is true for orientations of coordinate axes (changing coordinate axes orientation while keep $vb(v)_0 = vb(0)$. Then the general $alpha(vb(v)_0, "orientation")$ can be argued by using "composition of boost and rotation is equivalent to the general case".

#info[
  Actually I think the argument for $alpha$ should really be: it's measured to be so. And it aligns with symmetry argument. We cannot rigorously derive it.
]

Then we established
$ al vb(v), g vb(v) ar  =  al L vb(v), g L vb(v) ar $

or

$ L^T g L  = g $

from here we can use Lie algebra to find 6 generators (3 for boost, 3 for rotation).

The key is to reduce the Lie algebra first order calculation to

$ (g X)^T + g X = 0 $

where $L = II + X $.

Then $g X$ must be anti-symmetric, which in $4$ dimensional has 6 generators. Inverse $g$ then gives $X$.

== Linearity
Probably proving linearity is more plausible.

First prove additive linearity,
$ L(vb(u) + vb(v)) - L(vb(u)) =  L(vb(v)) $

We can shift the origin of our coordinates to $vb(u)$, this shouldn't affect our transformation (our transformation shouldn't be origin dependent! Spacetime is homogeneous!).

This means

$ L(vb(u) + vb(v)) - L(vb(u)) = L(vb(0) + vb(v)) - L(vb(0)) = L(vb(v)) $ as $L(vb(0))$ is mapped to $vb(0)$ by choice.

And then we can use this to prove coefficient linearity for all rational $lambda$.

Then we want continuity to prove it for real.

So we basically replace linearity with "homogeneity of spacetime" and "continuity of transformation"

In any case this is not really useful! *Deductive relativity is meaningless*. If you want to have solid mathematical fundation: choose spacetime invariance as your postulate.

If you want to deductively start from "invariance of spacetime interval", then use #link("https://physics.stackexchange.com/a/466444/359085"). As Lie Algebra assumes linearity so it is necessary to show linearity from "invariance".

== That Wikipedia proof
That proof is not entirely clear. A clear strategy is:
1. Show $g(vb(v), vb(w)) = 0$ for $vb(v) in V^-, vb(w) in V^+$.
2. For $vb(v)_1, vb(v)_2 in V^-$ such that $h(vb(v)_1, vb(v)_1) = h(vb(v)_2, vb(v)_2)$, we have $g(vb(v)_1, vb(v)_1) = g(vb(v)_2, vb(v)_2)$.
3. Same for $V^+$.
4. Take orthonormal basis ${vb(v)_i}$ of $V^-$ (orthogonal according to $h$). Since $h = 0 => g = 0$, this basis is also orthogonal for $g$. Now we only need to show $ C h(vb(v)_i, vb(v)_i) = g(vb(v)_i, vb(v)_i)$ for all $i$ for some $C$.
This is done by noting $g(vb(v)_i, vb(v)_i) = g(vb(v)_j, vb(v)_j)$ for $i, j$ by (2). So since we have proportionality on matrix elements,
So $ g = C^- h $ on $V^-$.

5. Same for $V^+$: $ g = C^+ h $ on $V^+$
6. Now for $vb(u) in V, vb(u) = vb(v) in V^- + vb(w) in V^+$, we have
$ g(vb(v) + vb(w), vb(v) + vb(w)) = g(vb(v), vb(v)) + g(vb(w), vb(w)) = C^- h(vb(v), vb(v)) + C^+ h(vb(w), vb(w)) $
Take $vb(u) eq.not vb(0)$ such that $h(vb(u), vb(u)) = 0$, then $h(vb(u), vb(u)) = h(vb(v), vb(v)) + h(vb(w), vb(w)) + cancel(2 h(vb(v), vb(w))) = 0$. But also $g(vb(u), vb(u)) = 0$. So $C^- = C^+$.

