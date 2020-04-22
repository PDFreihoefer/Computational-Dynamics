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
λ = -1 #Let's define some value to start
x0 = 1 #Initial guess
h = 0.01 #Time step
tf = 5 #Final time

##Plotting the exact equation
x_exact(t) = exp.(λ*t)*x0

plot( x_exact, 0, tf, label="Exact Solution")
##Plotting the trap rule equation
tRuleX, tRuleT = tRule(f, tf, h, x0)

plot!( tRuleT, tRuleX, label="Trapezoidal Rule")
##Plotting the runge kutta equation
#First we want to establish the different alphas
α1 = 1/4
α2 = 1/2
α3 = 2/3

#Now we find the x values for each and plot against our exact equation and our trap rule equation
rKuttaX1, rKuttaT = rKutta(f,tf,h,x0,α1)
rKuttaX2, rKuttaT = rKutta(f,tf,h,x0,α2)
rKuttaX3, rKuttaT = rKutta(f,tf,h,x0,α3)

plot!(rKuttaT, rKuttaX1, label="Runge Kutta α=1/4")
plot!(rKuttaT, rKuttaX2, label="Runge Kutta α=1/2")
plot!(rKuttaT, rKuttaX3, label="Runge Kutta α=2/3"
        xlabel="Time t [s]", ylabel="x(t)", title="Approximation Methods vs. Exact Solution")
