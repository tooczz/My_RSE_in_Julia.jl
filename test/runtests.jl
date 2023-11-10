using Test, TrapezoidalRule

f(x) = x*x

@test isapprox(approx_integral(0, 2, f, 1000), 8/3)