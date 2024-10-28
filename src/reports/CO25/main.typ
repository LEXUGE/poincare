#import "/templates/main.typ": simple, preamble, thm_vanilla
#import preamble: *
#import thm_vanilla: *

#show: simple.with(
  title: "CO25: Laplace Equations",
  authors: ((name: "Kanyang Ying", email: "worc6206@worc.ox.ac.uk"),),
  disp_content: false,
)
#show: setup
#show: thm_setup

= Abstract
Solving Laplace and Poisson's equations is of paramount importance in various
scientific and engineering domains, from electrostatics to heat conduction and
fluid dynamics. This report presents an introductory investigation into the
numerical solution of Laplace and Poisson's equations using the Successive
Over-Relaxation method. In particular, we implement the successive
over-relaxation methods to solve simple Laplace equations and Poisson equations
with known solutions, and use the same method to solve the flow of
incompressible irrotational fluids.

= Introduction
The Laplace equation represents a special case of the Poisson equation, both of
which are elliptic partial differential equations (PDEs) governing the
distribution of scalar fields in space. Applications of these equations range
from determining electrostatic potentials and temperature distributions to
understanding fluid flows.

Analytical solutions to Laplace and Poisson's equations are often limited to
simple geometries and boundary conditions. Therefore, numerical methods play a
crucial role in obtaining solutions for more complex and practical scenarios. We
present the algorithm of SOR in the @sec-methods, along with the implementation
of the method in the Julia language. We then present some comments on the scheme
we use above in @sec-analysis.

= Methods and Implementation
<sec-methods>
In the report, we are always trying to seek a numerical solution to the
following 2D PDE
$ laplace psi(vb(x)) equiv pdv(psi, x, 2) + pdv(psi, y, 2) = f(vb(x)) $<eq-laplace>
where when $f = 0$ we recover the Laplace equation, and when $f eq.not 0$ we get
Poisson equation.

== Laplace Equation
To seek a numerical solution, we try to adopt a scheme to replace the partial
derivatives @eq-laplace by finite differences. We can make various choices for
approximations, including center difference, forward difference, and back
difference, and this is commented in @sec-analysis.

For the sake of argument, let's work in the domain $[x_0, x_n] times [y_0, y_m]$ and
use the grid size
$ Delta_x = (x_n - x_0) / n, Delta_y = (y_m - y_0) / m $
In this report, we adopt uniform spacing, so
$ h equiv Delta_x = Delta_y $
Now, we define
$ x_i = x_0 + i Delta_x, y_j = y_0 + j Delta_y $
so we now can talk about $x_i, y_j$. For short hand, we will also write
$ psi_(i,j) := psi(x_i, y_j) $
Now, assuming our function to be smooth, by Taylor's theorem, we have that
$
  psi_(i+1) &= psi_i + psi'_i h + 1/2 psi''_i h^2 + 1/6 psi'''_i h^3 + cal(O)(h^4) \
  psi_(i-1) &= psi_i - psi'_i h + 1/2 psi''_i h^2 - 1/6 psi'''_i h^3 + cal(O)(h^4) \
$
where we omitted $j$ for clarity. Sum two together gives us
$ psi''_i h^2 = psi_(i+1) + psi_(i-1) - 2 psi_i + cal(O)(h^4) $
And we have a second order approximation
$ psi''_i h^2 = (psi_(i+1) + psi_(i-1)) / h^2 - 2 psi_i + cal(O)(h^2) $
as $f h^2 in cal(O)(h^4), forall f in cal(O)(h^2)$.

And we thus have a linear system for $f=0$ case:
$ psi_(i,j) = 1/4 (psi_(i+1, j) + psi_(i-1,j) + psi_(i, j+1), psi_(i, j-1)) $<eq-linear-system>

To solve this linear system, we can use the iterative approach, Jacobian's
method, which basically solves for an auxiliary equation
$ pdv(psi, tau) = laplace psi(vb(x)) - f(vb(x)) $
This is like a diffusion equation. And as the solution diffuses, we will have $pdv(psi, tau) to 0$ as $tau to oo$.
In that limit, we recover the solution to @eq-laplace. And use the same
approach, we can discretize $tau$ and convert $pdv(psi, tau)$ into $(psi^(k+1)_(i,j) - psi^(k)_(i,j)) / (Delta tau)$.

This gives us
$ psi^(k+1)_(i,j) = psi^k_(i,j) + (Delta tau) / h^2 (psi^k_(i+1, j) + psi^k_(i-1,j) + psi^k_(i, j+1), psi^k_(i, j-1) - 4psi^k_(i,j)) $

And theorems regarding convergence (see also Oxford's numerical methods course
Lecture 8) for diffusion equation requires us that $(Delta tau) / h^2 lt.eq 1/4 $.
Taking $(Delta tau) / h^2 = 1/4$ gives us an iterative version of
@eq-linear-system
$ psi^(k+1)_(i,j) = 1/4 (psi^k_(i+1, j) + psi^k_(i-1,j) + psi^k_(i, j+1), psi^k_(i, j-1)) $ <eq-jacobi>

A few things to notice:
- We are free to choose iteration order. Within each $k$, $psi_(i,j)$s wouldn't
  interfere.
- This doesn't have good convergence speed.

So an alternative is to do Gauss-Siedel:
$ psi^(k+1)_(i,j) = 1/4 (psi_(i+1, j) + psi_(i-1,j) + psi_(i, j+1), psi_(i, j-1)) $
where right-hand side is understood as using the latest (i.e. largest $k$)
available value at the given location. So if the neighboring grid $i,j-1$ has an
updated value at $k+1$, our evaluation of $psi^(k+1)_(i,j)$ will take $psi^(k+1)_(i, j-1)$ instead
of $psi^k_(i, j-1)$.

And because of the mixing of $k$ and $k+1$ in our evaluation, *the calculation
of each iteration is no longer independent*, and we have to do a sweeping.

*This is still not fast enough*.

It's discovered we can use Successive Over-Relaxation. That is, instead of
calculating $psi^(k+1)_(i,j)$ from scratch from neighbors, we also base it on
the old $psi^k_(i,j)$, so we use a weighted sum of $1/4 (psi_(i+1, j) + psi_(i-1,j) + psi_(i, j+1), psi_(i, j-1))$ and $psi^k_(i,j)$.
This is controlled by parameter $alpha$:

$ psi^(k+1)_(i,j) = alpha 1/4 (psi_(i+1, j) + psi_(i-1,j) + psi_(i, j+1), psi_(i, j-1)) + (1-alpha) psi^k_(i,j) $

Now rearrange our equation into the form $psi^(k+1)_(i,j) = psi^(k)_(i,j) + dots$ as
we want to find the residual between successive iteration.

This rearranges our equation into
$ psi^(k+1)_(i,j) = psi^(k)_(i,j) + alpha / 4 R_(i,j) $
and
$ R_(i,j) = psi_(i+1, j) + psi_(i-1,j) + psi_(i, j+1), psi_(i, j-1) - 4psi^k_(i,j) $
where again no-superscript means using the latest available value.

And we implemented it in Julia as @code-laplace.

We implemented also a helper function that creates the boundary value given the
analytical solution $psi$
#figure(
  ```julia
       # Create a init_ψ based on some function f
       # This initialize the boundary value
       function sample(f, x0, y0, x_len, y_len, delta)
         [(x-delta < x0) || (y-delta < y0) || (y+delta > y_len) || (x+delta > x_len) ? f(x, y) : 0 for y in y0:delta:y_len,  x in x0:delta:x_len]
       end
      ```,
  caption: [A helper function for initializing boundary condition],
)

Define the known-solution $psi (x,y)=sin(x)sinh(y)$, ```julia
f(x,y)=sin(x)sinh(y)
``` we then can find the numerical solution ```julia
sol, hist_val, R_max = solve_laplace(sample(f, 0, 0, 1, 1, 0.1), 1.35, 100)
``` The contour plots of the solution and the analytical solution are
#figure(grid(
  columns: 2,
  image("contour_plot_laplace.svg"),
  image("ground_truth_laplace.svg"),
))
And we have the residual plot and history of representative points:
#figure(grid(columns: 2, image("residual.svg"), image("history.svg")))

Notice the convergence is non-oscillatory. As for the convergence rate,
#figure(
  table(
    columns: 5,
    [$alpha$],
    [1.1],
    [1.25],
    [1.45],
    [2.1],
    [$k$],
    [83],
    [61],
    [37],
    [Not Converge],
  ),
  caption: [Iteration taken for maximum residual to be within $0.00001$],
)
For $alpha = 2.1$ it doesn't converge, and the plots become oscillatory.==
Poisson's Equation For Poisson Equation, @eq-linear-system becomes
$ psi_(i,j) = 1/4 (psi_(i+1, j) + psi_(i-1,j) + psi_(i, j+1), psi_(i, j-1) - h^2 f_(i,j)) $
And apply the same methods again we have an additional term in $R$:
$ R_(i,j) = psi_(i+1, j) + psi_(i-1,j) + psi_(i, j+1), psi_(i, j-1) - 4psi^k_(i,j) - h^2 f_(i,j) $

There is one subtlety here, $h^2 f_(i,j) in cal(O)(h^2)$ is of the same order of
the error terms if we write out explicitly. And this would render the source
term negligible under our approximation. There are two ways to potentially fix
it:
- Modify the approximation to make the error of order $cal(O)(h^3)$ or higher.
- Scale source term by $1/h^2$ and scale back the solution after we finish the
  calculation.
- Adopt some other regularization scheme.

We choose the second option.

The line charge has potential governed by
$ -laplace psi = lambda delta(vb(x) - vb(x_0)) $

We implemented the code in @code-poisson. And created the source and plot using
@code-earthed and @code-dipole, we then obtain:
#figure(grid(columns: 2, image("dipole.svg"), image("potential_earthed.svg")))

== Irrotational Incompressible Flow
For flow, it's useful to note that the direction of the flow $vb(s) = (u,v)$ given
by
$ u = pdv(psi, y), v = -pdv(psi, x) $
is perpendicular to $grad psi$, thus parallel to the contour of $psi$. Since the
fluid is incompressible,
$ div vb(s) = 0 $
we then have $ vb(hat(n)) cdot vb(s) = 0$ on the surface. Thus the obstacle must
be a contour line for the stream function. This involves some "guessing" on
setting the right boundary condition.

For rectangle and cylinder, we infer by symmetry that the boundary value should
be 0 as potential (stream function) should not cross, otherwise the flow is
undefined. Setting it to any other value would result in some streams from left "gravitates"
towards the obstacle, thus unphysics.// This is basically appealing to it looks weird, which is totally nonsense.

For reduced outflow, the boundary value on the width should be the same as the
value on the upper and lower boundary, as fluid flowing on the very top/bottom
must be parallel to the surface. And on the right of the reduced outflow
section, we should also have the boundary condition corresponding to straight
flow.

There consideration are reflected in our implementation. And we obtain using the
code in @code-flow, we obtain the contour plot (equivalent to the flow of the
fluid) in @fig-flow.
#figure(grid(
  columns: 2,
  image("rect_stream.svg"),
  image("cylindrical_stream.svg"),
  image("reduced_outflow.svg"),
), caption: [Plot of the contour plot of the stream function])<fig-flow>

= Analysis and Comments
<sec-analysis>
There are several schemes of approximating derivatives by finite difference. The
main idea is to use Taylor's theorem which gives a tighter remainder (error
bound) for smooth-enough functions.

The main schemes are forward/backward difference, centered difference for first
order derivatives. For forward difference, we have
$
  psi_(i+1) &= psi_i + psi'_i h + cal(O)(h^2) \
  psi'_i    &= (psi_(i+1) - psi_i) / h + cal(O)(h)
$
The backward difference case is similar. So this is a first order approximation.

And we can also use centered difference
$
  psi_(i+1) &= psi_i + psi'_i h + 1/2 psi''_i h^2 + cal(O)(h^3) \
  psi_(i-1) &= psi_i - psi'_i h + 1/2 psi''_i h^2 + cal(O)(h^3) \
$
Subtracting gives
$
  psi'_i = (psi_(i+1) - psi_(i-1)) / (2h) + cal(O)(h^2)
$
However, doing centered difference twice for obtaining second derivative is not
optimal. We have
$
  psi''_i = (psi'_(i+1) - psi'_(i-1)) / (2h) + cal(O)(h^2)
$
and
$
  psi'_(i+1) &= (psi_(i+2) - psi_i) / 2h + cal(O)(h^2)\
  psi'_(i-1) &= (psi_i - psi_(i-2)) / 2h + cal(O)(h^2)
$
Putting back in we get a first order approximation, instead of the second order
one we used. Moreover, it requires a larger size of "grid dependency".

So our choice of approximating derivative in this way is within these choices
optimal. For more details, see @num-diff.

= Conclusion
In summary, the report introduced basic iterative methods: Jacobi, Gauss-Siedel,
and Successive Over-Relaxation (SOR), along with their implementation. It
validates the SOR method's effectiveness in solving simple Laplace and Poisson's
equations over arbitrary shape of domains, demonstrating its applicability from
electrostatics to incompressible flow simulations.

#pagebreak()

#bibliography("./bib.yaml", style: "ieee")

#pagebreak()

= Appendix
Julia implementation of the methods and related codes in producing plots.==
Laplace Equation
#figure(```julia
function solve_laplace(init_ψ::Matrix{<:Real}, α::Real, N_iter::Integer)
	# Output:
	# - ψ: 2D matrix of the value of init_psi after N_iter iterations
	# - hist_values: (N_iter, 3) matrix that contains the historical values
	# - R_max: Maximum of residual in each iteration

	# Copying init_psi is necessary in order to avoid storing the reference of the init_psi
	ψ::Matrix = copy(init_ψ)
	R::Matrix = copy(init_ψ)
	R_max::Vector = zeros(N_iter)
	hist::Vector{Vector} = Vector()

	for m in 1:N_iter
		local within_criterion = true
		for (indices, _) in pairs(ψ)
			(i, j) = Tuple(indices)
			if checkbounds(Bool, ψ, i-1, j-1) && checkbounds(Bool, ψ, i+1, j+1)
				# Generate our R in m-th interation. Since R and psi has the same dimension, we may reuse the i,j to index
				R[i,j] = ψ[i,j+1] + ψ[i,j-1] + ψ[i-1, j] + ψ[i+1,j] - 4ψ[i,j]
				if abs(R[i,j]) >= criterion
					within_criterion = false
				end

				ψ[i,j] = ψ[i,j] + α / 4 * R[i,j]
			end
		end

		dims = size(init_ψ)
		# Store history for three points
		push!(hist, [
			ψ[round(Int, dims[1] / 4), round(Int, dims[2] / 2)],
			ψ[round(Int, dims[1] / 2), round(Int, dims[2] / 2)],
			ψ[round(Int, dims[1] / 4 * 3), round(Int, dims[2] / 2)],
		])

		R_max[m] = maximum(R)
		if within_criterion
			println("Finishing iteration early, m = ", m)
			break
		end
	end

	# stack(hist, dims = 1) converts the Vector{Vector} to a matrix
	return (ψ, stack(hist, dims = 1), R_max)
end
   ```,
  caption: [Laplace Equation Solution],
)<code-laplace>

== Poisson Equation
#figure(```julia
function solve_poisson(init_ψ::Matrix, fixed_ψ::Matrix, source::Matrix, N_iter = 300)

	q,p = size(init_ψ)
	# Determine α_opt
	α = 2 / (1 + sqrt(1 - ((cos(pi / p) + cos(pi/ q))/2)^2))
	println("α_opt determined:", α)

	# Copying init_psi is necessary in order to avoid storing the reference of the init_psi
	ψ::Matrix = copy(init_ψ)
	R::Matrix = copy(init_ψ)

	for m in 1:N_iter
		local within_criterion = true
		for (indices, _) in pairs(ψ)
			(i, j) = Tuple(indices)
			if checkbounds(Bool, ψ, i-1, j-1) && checkbounds(Bool, ψ, i+1, j+1) && fixed_ψ[i,j] == 0
				# Generate our R in m-th interation. Since R and psi has the same dimension, we may reuse the i,j to index
				R[i,j] = ψ[i,j+1] + ψ[i,j-1] + ψ[i-1, j] + ψ[i+1,j] - source[i, j] * δ^2 - 4ψ[i,j]
				if abs(R[i,j]) >= criterion
					within_criterion = false
				end

				ψ[i,j] = ψ[i,j] + α / 4 * R[i,j]
			end
		end

		if within_criterion
			println("Finishing iteration early, m = ", m)
			break
		end
	end

	return (ψ)
end
```,
  caption: [Poisson Equation Solver],
)<code-poisson>

== Electrostatics
#figure(
  ```julia
begin
	source_dipole = zeros(40,40)
	source_dipole[20,20-distance] = -λ / δ^2
	source_dipole[20,20+distance] = λ / δ^2
	dipole_sol = solve_poisson(zeros(40,40), zeros(40,40), source_dipole)
	contour(dipole_sol, levels=30, title = "Potential of dipole in earthed container", fill = false, aspect_ratio=1, size=[500,500])
end
```,
  caption: [Creating source for dipole line charge potential],
)<code-dipole>

#figure(
  ```julia
# Here providing an ansatz and specify the boundary condition is very important: the ψ is not gonna decay to zero at infinity
begin
	source = zeros(25,25)
	# IMPORTANT: We are creating a δ-"function" source, and we need to perform regularization
	source[5,5] = -λ / δ^2
	earthed_sol = solve_poisson(zeros(25, 25), zeros(25,25), source)
	contour(earthed_sol, levels=30, title = "Potential of line charge in earthed container", fill = false, aspect_ratio=1, size=[500,500])
end
```,
  caption: [Creating source for line charge potential],
)<code-earthed>

== Fluids
#figure(
    ```julia
# Masks that fix the boundary condition
begin
	rect_mask = zeros(40,60)
	rect_mask[10:30,20] .= 1
	rect_mask[10:30,40] .= 1
	rect_mask[10,20:40] .= 1
	rect_mask[30,20:40] .= 1

	reduced_mask = zeros(40,60)
	reduced_mask[1:20-width,40:60] .=1
	reduced_mask[20+width:40,40:60] .=1

	cylinder_mask = zeros(40,60)
	for x in -radius:radius
		cylinder_mask[round(Int, 20 + sqrt(radius^2 - x^2)), 30+x] = 1
		cylinder_mask[round(Int, 20 - sqrt(radius^2 - x^2)), 30+x] = 1
	end
end

begin
	init_stream_rect = zeros(40,60)
	init_stream_rect[1,:] .= 2
	init_stream_rect[40,:] .= -2
	init_stream_rect[:,1] = [0.1*(20-y) for y in 1:40]
	init_stream_rect[:,60] = [0.1*(20-y) for y in 1:40]

	init_stream_width = copy(init_stream_rect)
	init_stream_width[1:20-width,40:60] .=2
	init_stream_width[20+width:40,40:60] .=-2
	init_stream_width[20-width:20+width,60] = [(2/width)*(-y) for y in -width:width]
end

contour(solve_poisson(init_stream_rect, rect_mask, zeros(40,60)), title = "Stream Fn - Rectangular Obstable", levels=60, fill = false, aspect_ratio = 1, size=(600,400))

contour(solve_poisson(init_stream_rect, cylinder_mask, zeros(40,60)), title = "Stream Fn - Cylindrical Obstable", levels=60, fill = false, aspect_ratio = 1, size=(600,400))

contour(solve_poisson(init_stream_width, reduced_mask, zeros(40,60)), title = "Stream Fn - Reduced Width outflow", levels = 31, fill = false)
```,
  caption: [Creating flow for different obstacles],
)<code-flow>
