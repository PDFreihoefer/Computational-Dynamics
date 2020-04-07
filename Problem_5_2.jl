using Pkg
Pkg.activate(".")

using Plots
using LinearAlgebra
##Loading our Trapezoidal Rule:
include("C:/Users/paulf/Documents/GitHub/Computational-Dynamics/TrapRule.jl")
using .TrapRule
##Loading our Runge Kutta Methods:
include("C:/Users/paulf/Documents/GitHub/Computational-Dynamics/AB2.jl")
using .AB2
##Setting up the Problem
f(x,t) = λ*x #The function we are working with
λ = -731 #Let's define some value to start
x0 = 0.5 #Initial guess
#h = 1 Failed to converge
#h = 0.01 Failed to converge
h1 = 0.0014
h2 = 0.0000014
h3 = 0.00000014
tf = 5 #Final time

##Plotting the exact equation
x_exact(t) = exp.(λ*t)*x0

plot( x_exact, 0, tf, label="Exact Solution")
##Plotting the Implicit Midpoint Method Results
#tRuleX, tRuleT = tRule(f, tf, h1, x0)

#plot!( tRuleT, tRuleX, label="h = .0001")

#tRuleX, tRuleT = tRule(f, tf, h2, x0)

#plot!( tRuleT, tRuleX, label="h = 0.00001")

#tRuleX, tRuleT = tRule(f, tf, h3, x0)

#plot!( tRuleT, tRuleX, label="h=0.000001",
        #xlabel="Time t [s]", ylabel="x(t)", title="Implicit Midpoint Method vs. Exact Solution")
##Plotting AB2 Results
AB2X, AB2T = ab2(f, tf, h1, x0)

plot!( AB2T, AB2X, label="h = .0014")

AB2X, AB2T = ab2(f, tf, h2, x0)

plot!( AB2T, AB2X, label="h = 0.0000014")

AB2X, AB2T = ab2(f, tf, h3, x0)

plot!( AB2T, AB2X, label="h=0.00000014",
        xlabel="Time t [s]", ylabel="x(t)", title="2-Stage Adam Basthforth Method vs. Exact Solution")
##Conclusion
#AB2:
#In this case the max step size shows that the system converges but eventually becomes unstable and explodes as
#time goes on. This is a good example showing that the smaller the step size the more accurate the method is and
#that using something close to the max step size is not optimal for accuracy but potentially optimal for cost in
#this case.

#IM:
#The system will never converge at some eigenvalues if you actually use the max time step and max out the
#iterations at some value. We could increase the max iterations but it will become more and more expensive
#to run the method and we will need to increase the range of time we are looking at as well. It makes more sense
#to decrease the final time and decrease the step size to lower the overall cost of running the equation. It
#should also be noted that with using a very large step size the equation the method isn't as good at approximating
#the exact solution. We can see in this plot that the
