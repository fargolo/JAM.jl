using Distributions, DataFrames, CSV

x_o = collect(-5:.1:5) .+ rand(Normal(0,1),101)
x_positive = collect(0:.05:5) .+ rand(Normal(1,.5),101)

# Polynomials
y_1 = 2*x_o .+ .5 .+ rand(Normal(0,1),101)
y_2 = x_o.^2 .+ .3*x_o .+ .5 .+ rand(Normal(0,1),101)
y_3 = .5*x_o.^3 .+ 2*x_o.^2 .- .5*x_o .+ rand(Normal(0,1),101)

y_exp = exp.(x_o) .+ rand(Normal(0,1),101)
y_log = log.(x_positive) .+ rand(Normal(0,1),101)
y_sqrt = sqrt.(x_positive) .+ rand(Normal(0,1),101)

df = DataFrame(x = x_o, x_positive = x_positive,
		y_linear = y_1, y_quadratic = y_2, y_cubic = y_3,
		y_exp = y_exp, y_log = y_log, y_sqrt = y_sqrt)

CSV.write("tmp/df_example.csv",df)

df = CSV.read("tmp/df_example.csv", copycols = true)

# using Plots
# xlims!(-5,5)
# scatter(df[:x,],df[:y_linear],lab="linear")
# scatter!(df[:x,],df[:y_quadratic],lab="quadratic")
# scatter!(df[:x,],df[:y_cubic],lab="cubic")
# scatter!(df[:x,],df[:y_exp],lab="exp")
# scatter!(df[:x,],df[:y_log],lab="log")
# scatter!(df[:x,],df[:y_sqrt],lab="sqrt")
# ylims!(-5,15)
