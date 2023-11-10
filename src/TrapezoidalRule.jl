module TrapezoidalRule

export approx_integral

function approx_integral(a, b, f, N)
    x = range(start=a, length=N+1, stop=b)
    sum = 0
    for k in 1:N
        sum += (f(x[k]) + f(x[k+1]))/2
    end
    return sum*(b-a)/N
end

end # module TrapezoidalRule
