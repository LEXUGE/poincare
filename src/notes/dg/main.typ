#import "/templates/main.typ": simple, preamble, thm_typzk
#import preamble: *
#import thm_typzk: *

#show: simple.with(
  title: "Differential Geometry", authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
)
#show: setup.with(dagger: true)
#show: thm_setup
#set quote(block: true)

#let exc(num, body) = ex[@lovettDifferentialGeometryManifolds[Ex #num]][#mitext(body)]
#let SO(n) = $"SO"(#n)$

#pagebreak()

= Intro
This notes follows strictly @lovettDifferentialGeometryManifolds. Since each section corresponds to a 60 min lecture, the plan is to do 1 section every time (with exercises).

The main focus would be on exercises. Any skipped or unfinished exercises would be labeled.

The order of the sections below roughly follows the order of chapters in @lovettDifferentialGeometryManifolds, but with some appendix interlaced.
= Analysis of Multivariable Functions
There is no new material in section 1.1.

#task[Build up the differentiation definitions. And prove propositions which links partial derivative and linear map together.]


== Exercises
=== Section 1.1
#ex[@lovettDifferentialGeometryManifolds[Ex 1.1.1]][
	#mitex(`\text{Consider the function }F\text{ in Example }1.1.4.\text{ Prove algebraically that if the domain}\\\text{is restricted to }\mathbb{R}\times(0,+\infty),\text{ it is injective. What is the image of }F\text{ in this case?}`)
]
#sol[
	$F$ is defined on $RR^2$. We already know from @lovettDifferentialGeometryManifolds[Example 1.1.4] the image of $F(RR^2)$ is
	#mitex(`F(\mathbb{R}^2)=\mathbb{S}^2-\{(x,y,z)\in\mathbb{S}^2| x=-\sqrt{1-z^2}\text{ with }z<1\}.`)
	Thus we need to show for every $(x,y,z) in F(RR^2)$, there exists an unique $(u,v) in RR times (0, oo)$ such that $F(u,v) = (x,y,z)$.
	Still from @lovettDifferentialGeometryManifolds[Example 1.1.4], we know
	$ z = (1-v^2)/(1+v^2) => v = pm sqrt((1-z)/(1+z)) $
	But since $v in (0, oo)$, this uniquely fixes the $pm$ sign to $+$. Thus $v$ is unique given $z$. Moreover, since $v in (0, oo)$, $z in (-1, 1)$.

	Similarly, we have
	#mitex(`$$\begin{aligned}x=\frac{1-u^2}{1+u^2}\sqrt{1-z^2}\quad&\text{ and }\quad&y=\frac{2u}{1+u^2}\sqrt{1-z^2}.\end{aligned}$$`)
	And first half gives
	$ u = pm sqrt( (1- x / sqrt(1-z^2)) / (1 + x / sqrt(1-z^2))) $
	And put in the second half gives
	$ y / sqrt(1-z^2) = pm (|y|) / sqrt(1 - z^2) $
	which determines the $pm$ sign by the sign of $y$. Thus $u$ is also uniquely fixed given $(x,y,z)$. In other words
	$ u = "sign"(y) sqrt( (1- x / sqrt(1-z^2)) / (1 + x / sqrt(1-z^2))) $

	The image of $F$ under this domain is
	#mitex(`\mathbb{S}^2-\{(x,y,z)\in\mathbb{S}^2| z=\pm 1 \text{ or } x=-\sqrt{1-z^2}\text{ with }z<1\}.`)
]
#task[Add a figure for $F$.]
#exc[1.1.2][`Let $F:\mathbb{R}^2\to\mathbb{R}^2$ be the function defined by $F(s,t)=(s^2-t^2,2st)$, and let $G:\mathbb{R}^2\to\mathbb{R}^2$ be the function defined by $G(u,v)=(2u^2-3v,uv+v^3).$ Calculate the component functions of $F\circ G$ and of $G\circ F.$`]
#sol[
	Skipped, direct calculation would suffice.
]
#exc[1.1.3][`Show that the function $\vec{X}:[0,2\pi]\times[0,\pi]\to\mathbb{R}^{3}$,with
$$\vec{X}(x_1,x_2)=(\cos x_1\sin x_2,\sin x_1\sin x_2,\cos x_2),$$
defines a mapping onto the unit sphere in $\mathbb{R}^3.$ Which points on the unit sphere
have more than one preimage?`]
#sol[
	This is the usual polar coordinate with $r = 1$ and $theta = x_2, phi = x_1$. The points $(0, 0 , pm 1)$ have more than one preimage. In fact, their preimages correspond to $x_2 = 0, x_1 in [0, 2pi]$ and $x_2 = pi, x_1 in [0, 2pi]$.
]
#exc[1.1.4][`Consider the function $F$ from $\mathbb{R}^3$ to itself defined by
$$F(x_1,x_2,x_3)=(x_1+2x_2+3x_3,4x_1+5x_2+6x_3,7x_1+8x_2+9x_3).$$
Prove that this is a linear function. Find the matrix associated to $F$ (with respect to the standard basis). Find the rank of $F$, and if the rank is less than 3, find equations for the image of $F.$`]
#sol[
	Trivially, the matrix associated with $F$ is (in standard basis)
	$ A = mat(1, 2, 3; 4,5,6; 7, 8, 9) $
	and unfortunately $det(A) = 0$. So it's rank is $<3$. Obviously the first two column should be linearly independent. Thus $rank(F) = 2$. And the image will just be the set of all linear combination of any two columns.
]

#exc[1.1.5][`Consider a line $L$ in $\mathbb{R}^n$ traced out by the parametric equation $\vec{x}(t)=t\vec{a}+\vec{b}.$ Prove that for any linear function $F:\mathbb{R}^n\to\mathbb{R}^m$, the image $F(L)$ is either a line or a point.`]<ex:1.1.5>
#sol[
	By linearity of $F$,
	$ F(t vb(a) + vb(b)) = t F(vb(a)) + vb(b) $
	If $vb(a) in ker F$, then $F(Im vb(x)(t)) = vb(b)$ i.e. a point. Otherwise it's a line.
]
#exc[1.1.6][`Let $F:\mathbb{R}^n\to\mathbb{R}^m$ be a linear function, and let $L_1$ and $L_2$ be parallel lines in $\mathbb{R}^n.$ Prove that $F(L_1)$ and $F(L_2)$ are either both points or both lines in $\mathbb{R}^m.$ If $F(L_1)$ and $F(L_2)$ are both lines, prove that they are parallel.`]
#sol[
	Parallel line means
	$ vb(x)_1(t) = t vb(a) + vb(b)_1 \
	vb(x)_2(t) = t vb(a) + vb(b)_2 $
	And thus the image of $F$ under $L_1, L_2$ is

	$ F(L_1) = t F(vb(a)) + vb(b)_1 \
	F(L_2) = t F(vb(a)) + vb(b)_2 $

	If $vb(a) in ker F$, then both are points, otherwise both are line. Moreover they are parallel because both are moving along using $F(vb(a))$.
]
#exc[1.1.7][`Let $F:\mathbb{R}^n\to\mathbb{R}^m$ be a linear function represented by a matrix $A$ with respect to a basis $\mathcal{B}$ on $\mathbb{R}^n$ and a basis $\mathcal{B}^\prime$ on $\mathbb{R}^m.$ Prove that $F$ maps every pair of perpendicular lines in $\mathbb{R}^n$ to another pair of perpendicular lines in $\mathbb{R}^m$ if and only if $A^TA=\lambda I_n$ for some nonzero real number $\lambda.$`]
#sol[
	#text(red)[This is only true when inner products are defined such that $cal(B), cal(B)'$ are orthonormal.]

	We want to show
	$ al F vb(v), F vb(w) ar_(RR^m) = 0 <==> al vb(v), vb(w) ar_(RR^n) = 0 $
	And we know
	$ al F vb(v), F vb(w) ar_(RR^m) = al F^+ F vb(v), vb(w) ar_(RR^n) $ where $F^+$ is the adjoint.

	Now take $vb(v) = vb(e)^i, vb(w) = vb(e)^j$ where $i eq.not j$, then we must have
	$ al vb(e)^i, vb(e)^j ar_(RR^n) = al F^+ F vb(e)^i, vb(e)^j ar_(RR^n) = 0 $
	If $cal(B)$ is orthonormal, then $al F^+ F vb(e)^i, vb(e)^j ar_(RR^n)$ are matrix elements. In other words,
	$ [F^+ F]_cal(B)^cal(B)$ is diagonal.
	Moreover, $ al vb(e)^i + vb(e)^j, vb(e)^i - vb(e)^j ar_(RR^n) &= al F^+ F vb(e)^i, vb(e)^i ar - al F^+ F vb(e)^j, vb(e)^j ar \
		&= 0 $
	for all $i eq.not j$. Thus diagonal terms of $ [F^+ F]_cal(B)^cal(B) $ are all equal.
	Thus $ [F^+ F]_cal(B)^cal(B) = lambda II_n $ for some $lambda$.

	If $cal(B)'$ is orthornormal, then $[F^+]_cal(B)'^cal(B)$ is given by
	$ ([F]^T)^* = A^T $
	since we are dealing with real number. Thus $[F^+ F] = lambda II_n$ is equivalent to $A^T A = lambda II_n$.

]
#remark(base: "exercise")[This result is actually relevant in setting up special relativity. In special relativity, we no longer have a positive-definite inner product, but rather a non-degenerate bilinear form (Minkowski metric). But the result is similar: if coordinate transformation (i.e. Lorentz transformation) $F$ is linear and it maps lightlike events to lightlike events, then we should have $ A^T g A = lambda g $ where $g$ is the Minkowski metric.]
#exc[1.1.8][`Let $\vec{\omega}$ be a nonzero vector in $\mathbb{R}^n.$ Define the function $F:\mathbb{R}^n\to\mathbb{R}$ as

$$F(\vec x)=\vec{\omega}\cdot\vec{x}.$$

Prove that $F$ is a linear function. Find the matrix associated to $F$ (with respect
to the standard basis).`]
#sol[This is trivial, the matrix is just $vb(omega)^T$.]
#exc[1.1.9][`\begin{aligned}&\mathrm{Let~}\vec{\omega}\text{ be a nonzero vector in }\mathbb{R}^3.\text{ Define the function }F:\mathbb{R}^3\to\mathbb{R}^3\text{ as}\\&F(\vec{x})=\vec{\omega}\times\vec{x}.\\&\text{Prove that }F\text{ is a linear function. Find the matrix associated to }F\text{ (with respect}\\&\text{to the standard basis). Prove that rank }F=2.\end{aligned}`]
#sol[This is again trivial.
	$ A = mat(0, -omega_z, omega_y; omega_z, 0, -omega_x; -omega_y, omega_x, 0) $
	You should notice this is the space of antisymmetric matrix (a vector space of dimension 3). This is because there are three generators of $SO(3)$ which are exactly the basis of antisymmetric matrix subspace of $"GL"(3)$.
	$rank F = 2$ because the line parallel to $vb(omega)$ is the kernel.]
= Variable Frames
= Point Set Topology
= Differentiable Manifolds
= Multilinear Algebra
= Analysis on Manifolds
= Introduction to Riemannian Geometry

#pagebreak()

// Needed to disable the auto typzk generation
#show heading: it => it.body
#bibliography("./ref.bib", style: "ieee")
