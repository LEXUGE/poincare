#import "/templates/main.typ": simple, preamble, thm_typzk
#import preamble: *
#import thm_typzk: *

#show: simple.with(
  title: "Probability", authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
)
#show: setup
#show: thm_setup
#set quote(block: true)

#let bern(p) = $"Bern"(#p)$
#let bin(p) = $"Bin"(#p)$
#let unif(x) = $"Unif"(#x)$
#let dunif(x) = $"DUnif"(#x)$

#pagebreak()

= Random Variable
This basically corresponds to @blitzsteinIntroductionProbabilitySecond[Chapter 3-5].
== Basics and Notions
#context gen_section_graph(s: 70%)
#def("def_rv")[Random Variable @blitzsteinIntroductionProbabilitySecond[Def 3.1.1]][
Let $Omega$ be the sample space, and $PP: 2^Omega -> [0, 1]$ be our probability.

A random variable $X: Omega -> RR$ maps every samples to a real number.
]
#remark(base: "definition")[Here we are taking the event space to be $2^Omega$, i.e. all possible subsets of $Omega$. Other texts may have advanced notions of event space allowing more freedom on calling what "event", but we don't bother with this freedom as for most cases $2^Omega$ is a good choice of event space.]
#remark(base: "definition")[Obviously $X: 2^Omega -> RR$ wouldn't be a sensible definition cause otherwise we would have PMF/PDF not summing to 1, per later definition of PMF/PDF]

#def("def_discrete_rv", back_links: ("def_rv", ))[Discrete Random Variable @blitzsteinIntroductionProbabilitySecond[Def 3.2.1]][
	A random variable $X$ is discrete if the set $A = {x | PP(X) > 0}$ is countable and
	$ sum_(x in A) PP(X = x) = 1 $

	and the set $A$ is called the *support* of $X$.
]
#warning[We will see the definition of a continuous R.V. after we define CDF. And we will see some R.V. are neither discrete nor continuous. So it's _not right_ to say "if not discrete, then continuous". But in any case, in real probability questions, we don't bother.]

Next we will define what's distribution and PMF/PDF/CDF. And how they are different from each other conceptually.

#def("def_pmf", back_links: ("def_discrete_rv", ))[Probability Mass Function @blitzsteinIntroductionProbabilitySecond[Def 3.2.2]][
	For a _discrete_ R.V. $X$, define the PMF of it as $P_X: RR -> [0, 1]$ given by
	$ P_X (x) = PP(X = x) $
	where $X = x$ is an event in $2^Omega$.

	By definition of support of $X$ (@def_discrete_rv), the support of $P_X$ is the support of $X$.
]
#warning[Two R.V.s can have the same distribution but still being different! Classical case is where we have fair coin $Omega = {H, T}$, $X$ being the indicator for $H$, $Y$ being the indicator for $T$, then $P_X = P_Y$ but $X eq.not Y$.

Because $X(H) = 1 eq.not Y(H) = 0$ while $P_X (0) = P_Y (0) = P_X (1) = P_Y (1) = 1/2$. ]

Apparently,
$ sum_(x in A_X) P_X (x) = 1 $
and this is @blitzsteinIntroductionProbabilitySecond[Thm 3.2.7].


#def("def_cdf", back_links: ("def_rv",))[Cumulative Distribution Function @blitzsteinIntroductionProbabilitySecond[Def 3.6.1]][
	The Cumulative Distribution Function of a R.V. $X$ is $F_X: RR -> [0,1]$ given by
	$ F_X (x) = PP(X <= x) $
	where $X <= x$ is an event. This is defined regardless whether the R.V. is discrete.
]
See also @blitzsteinIntroductionProbabilitySecond[Thm 3.6.3] on the usual expected properties of a CDF.

#def("def_continuous_rv", back_links: ("def_cdf", ))[Continuous Random Variable @blitzsteinIntroductionProbabilitySecond[Def 5.1.1]][
	$X$ is continuous if its CDF $F_X$ is continuous on $RR$ and differentiable except at finite number of points on $RR$.
]
#remark(base:"definition")[Note it's CDF required to be continuous and differentiable (except at finite number of points), _not_ PDF! A simple counterexample is $unif([0,1])$ whose PDF is discontinuous at $0, 1$.]

#def("def_pdf", back_links: ("def_cdf", ))[Probability Density Function @blitzsteinIntroductionProbabilitySecond[Def 5.1.2]][
	The PDF of a continuous R.V. $X$ is
	$ f = F_X ' $
]
#remark(base: "definition")[Since CDF of a discrete $X$ is not continuous everywhere, we see "discrete R.V. are not continuous".]
The usual expected properties of CDF and PDF are summarized in @blitzsteinIntroductionProbabilitySecond[Pg 214].

#warning[Some R.V. are neither discrete nor continuous. For example, let $Omega = {0,1} times [0,1]$ and with the probability defined as:
	if we throw a fair coin and get $0$, then the value of the $[0,1]$ part will be uniformly distributed, otherwise, the value of $[0,1]$ will be discrete uniform on ${0.5, 1}$.

	Define $X$ as
	$ X(s in Omega) = cases(
	x "if" s = (0, x) \
	2 "if" s = (0, 0.5) \
	3 "if" s = (0, 1) \
	0 "otherwise"
	) $

	Then $PP(X = x|(0, dot)) = unif([0,1])$ and $PP(X = x|(1, dot)) = dunif({2, 3})$ where $(0, dot) = {(0,x)|x in [1,3]}, (1, dot) = {(1,x)|x in [1,3]}$ represents events.

	And by @def_pmf, $P_X$ doesn't exists because $PP(X in A) = 1/2$, and by @def_cdf, $F_X$ doesn't exists because $PP(X <= x)$ is not continuous at both $x = 2, 3$.

	But in any case, such examples are not important.
]

#def("def_distribution", back_links: ("def_pmf", "def_pdf"))[Distributions][
	If a discrete R.V. $X$ has PMF $f$ (i.e. $P_X = f$), then we say $X$ is "distributed as" $f$, and write as
	$ X ~ f $
	and $f$ is also called distribution.

	Similarly, if a continuous R.V. $X$ has PDF $g$ (i.e. $F_X ' = g$), then we write
	$ X ~ g $
	and $g$ is also called distribution.
]

== Independence
#context gen_section_graph(s: 80%)
Two R.V.s are independent if knowing the value of one doesn't give information about the value of the other.
#def("def_rv_indep")[Independence of R.V. @blitzsteinIntroductionProbabilitySecond[Def 3.8.1]][
Given $X, Y$, they are independent if
	$ PP(X <= x, Y <= y) = PP(X <= x) PP(Y <= y) $ <eq:rv_indep>
	for all $x,y in RR $.
]
For multiple R.V.s, the definition is analogous, see @blitzsteinIntroductionProbabilitySecond[Def 3.8.2].

#def("def_iid", back_links: ("def_rv_indep", "def_distribution"))[Independent and Identically Distributed R.V.][
	$X_1, X_2, X_3, dots$ are called i.i.d if they are all independent and have the same distribution.
]

For discrete random variable, we have
#thm("def_discrete_rv_indep", back_links: ("def_rv_indep",))[Discrete R.V. Independence][
	If $X, Y$ are discrete, then @def_rv_indep is equivalent to
	$ PP(X = x, Y = y) = PP(X = x) PP(Y = y) $
	for all $x in A_X, y in A_Y $.
]
#proof[
	The idea is to take "partial derivative" w.r.t. $x$ and then $y$ on both sides of @eq:rv_indep.
]

#def("def_cond_indep", back_links: ("def_rv_indep",))[Conditional Independence][
	Given $X, Y$, and a discrete $Z$, then $X, Y$ are conditionally independent if
	$ PP(X <= x, Y<=y | Z= z) = PP(X <= x|Z = z) PP(Y <= y | Z = z) $
]

=== Function of R.V.
This notion should be quite clear for me, see @blitzsteinIntroductionProbabilitySecond[Sec 3.7] if not clear.
== Expectation, Covariance, Variance, and Correlation
Just remember variance is scalar product.
=== Properties of Expectation and Variance
Expectation are linear, variance are not. They will later also be related to covariance.
== Usual Distributions and How They are connected
=== Poisson Paradigm and Poisson Process
#task[A simple example on nuclear decay, branching probability, and Poisson process.]
#task[Classical Photon coincidence rate and Poisson Paradigm]
== Strategies on Solving Problems
== Paradox

= Joint Random Variable
== Continuous Bayes and LOTP
== Two Random Vectors

= Large Numbers
== Inequalities
#tip[
	Mnemonic to recover the direction of Jensen Inequality. Just remember:
	$ EE(|X|) >= |EE(X)| $
	And $|x|$ is a convex (concave up) function.
]
== Law of Large Number
#quote(attribution: [@blitzsteinIntroductionProbabilitySecond[Pg 468]])[Every time we use the average value in the replications of some quantity to approximate its theoretical average, we are implicitly appealing to the LLN.]

== Central Limit Theorem
#task[Volatile Stock @blitzsteinIntroductionProbabilitySecond[Ex 10.3.7] is an interesting example]

= Regression

#pagebreak()

// Needed to disable the auto typzk generation
#show heading: it => it.body
#bibliography("./ref.bib", style: "ieee")
