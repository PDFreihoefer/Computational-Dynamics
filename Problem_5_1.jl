using Pkg
Pkg.activate(".")

using Plots
using LinearAlgebra
##Loading our Trapezoidal Rule:
include("C:/Users/paulf/Documents/GitHub/Computational-Dynamics/TrapRule.jl")
using .TrapRule
##Loading our Runge Kutta Methods:
include("C:/Users/paulf/Documents/GitHub/Computational-Dynamics/RungeKutta2.jl")
using .RungeKutta2
##Prelimnary Work
#We want to write out the Trapezoidal Rule to solve the differential equation
#ẋ = λx is our differential equation

#The Trapezoidal Rule is: x_(n+1) = xn + h/2 *(f(tn,xn)+f(tn+1,xn+1))

#We can consider some initial condition x0 and the resulting pattern of our rule
#x1 = x0+h/2*(λx0+λx1)
#x1(1-hλ/2)=x0(1+hλ/2)
#xn = (1+hλ/2)/(1-hλ/2)*x0

#To check the stability we need to consider: |(1+hλ/2)/(1-hλ/2)|<1
#hλ<0 to be stable which means that λ must be negative and h can be anything for this method to stay stable
##Setting up the Problem
f(x,t) = λ*x #The function we are working with
λ = -731 #Let's define some value to start
x0 = 1 #Initial guess
#h = 1 Failed to converge
#h = 0.01 Failed to converge
h1 = 0.0001
h2 = 0.00001
h3 = 0.000001
tf = 5 #Final time

##Plotting the exact equation
x_exact(t) = exp.(λ*t)*x0

plot( x_exact, 0, tf, label="Exact Solution")
##Plotting the trap rule equation
tRuleX, tRuleT = tRule(f, tf, h1, x0)

plot!( tRuleT, tRuleX, label="h = .0001")

tRuleX, tRuleT = tRule(f, tf, h2, x0)

plot!( tRuleT, tRuleX, label="h = 0.00001")
tRuleX, tRuleT = tRule(f, tf, h3, x0)

plot!( tRuleT, tRuleX, label="h=0.000001",
        xlabel="Time t [s]", ylabel="x(t)", title="Implicit Midpoint Method vs. Exact Solution")

##Conclusion
#AB2:
#

#IM:
#The system will never converge at some eigenvalues if you actually use the max time step and max out the
#iterations at some value. We could increase the max iterations but it will become more and more expensive
#to run the method and we will need to increase the range of time we are looking at as well. It makes more sense
#to decrease the final time and decrease the step size to lower the overall cost of running the equation. It
#should also be noted that with using a very large step size the equation the method isn't as good at approximating
#the exact solution. We can see in this plot that the
