##Problem 5_6_1 Overview
#Plan: We need to construct three different methods to integrate the following
#equations:
#pDot = -sin(q), f'(t,q) = f(t,q) Another way to imagine these equations
#qDot = p, f'(t,p) = f(t,p)
#Using any of these first order integrators will give us solutions to our
#pendulum's motion. It's also important to remember that q represents the angle
#of the pendulum at any given moment and p is the non-dimensionalized momentum.
##Establishing our packages
using Pkg
Pkg.activate(".")
#Pkg.add("BenchmarkTools")

using Plots
using LinearAlgebra
using BenchmarkTools
##Loading our various functions
include("C:/Users/paulf/Documents/GitHub/Computational-Dynamics/BackwardEuler.jl")
using .BackwardEuler

include("C:/Users/paulf/Documents/GitHub/Computational-Dynamics/AdamsBashforth2.jl")
using .AdamsBashforth2

include("C:/Users/paulf/Documents/GitHub/Computational-Dynamics/ImplicitRungeKutta.jl")
using .ImplicitRungeKutta
##Setting up the Problem
f(x,t) = [x[2],-sin(x[1])]
x0 = [1,0.01] #Initial guess
h = 0.2 #Time step
tf = 100 #Final time
##Gathering our solutions from each method
#Backwards Euler
xBE, tBE = BEuler(f,tf,h,x0)
#Adams Bashforth 2-Stage Method
xAB2, tAB2 = AB2(f,tf,h,x0)
#Implicit Runge Kutta
xIRK, tIRK = IRK(f,tf,h,x0)
##Comparing the solutions to q
plot(tBE, xBE[:,1], label="Backwards Euler", xlabel = "Time [s]", ylabel = "Q(t)", title="Q(t) over time")
plot!(tAB2, xAB2[:,1], label = "Adams Bashforth 2-Stage Method")
plot!(tIRK,xIRK[:,1], label = "Implicit Runge Kutta")

##Comparing the solutions to p
plot(tBE, xBE[:,2], label="Backwards Euler", xlabel = "Time [s]", ylabel = "P(t)", title="P(t) over time")
plot!(tAB2, xAB2[:,2], label = "Adams Bashforth 2-Stage Method")
plot!(tIRK,xIRK[:,2], label = "Implicit Runge Kutta")

##Hamiltonian
#h = 0.2, tf = 1000s
nHBE = (xBE[:,2].^2/2 - cos.(xBE[:,1]).+1)/(x0[2]^2/2-cos(x0[1])+1)
#h = 0.2, tf = 1000s
nHAB2 = (xAB2[:,2].^2 ./2-cos.(xAB2[:,1]).+1)./(x0[2]^2/2-cos(x0[1])+1)
#h = 2, tf = 10000s
nHIRK = (xIRK[:,2].^2 ./2-cos.(xIRK[:,1]).+1)./(x0[2]^2/2-cos(x0[1])+1)

plot(nHBE, label="Backwards Euler", xlabel = "Step Number", ylabel = "Normalized Hamiltonian", xscale = :log)
plot!(nHAB2, label = "Adams Bashforth 2-Stage Method")
plot!(nHIRK, label = "Implicit Runge Kutta")
##Answering Part A if part 3:
#From the energy plot we derive we can see that over a long period of
#time the backwards euler method starts to fall apart and is completely
#off the path. Our Adams Bashforth 2-Stage method also eventually starts
#to break away but not as quickly as the BEuler method does. Finally,
#and the most interesting thing to note is that our IRK method stays
#within a stable energy range even when put under intense conditions
#(high step size and large final time). The method oscillates and stays
#within the correct range of energy for a lot of steps. Obviously this
#method just kicks way more ass than the other two. It's like going to
#Whole foods over Cash and Carry.
##Benchmarking Each Method
#Backwards Euler (evaluated for P with tf = 100s)
#Mean time = 7.400 ms
#AB2
#Mean Time = 4.263 ms
#IRk
#Mean Time = 18.998 ms
#At tf = 25s
#BEuler: 1.785 ms
#AB2: 1.059 ms
#IRK: 4.701 ms
#At tf = 10s
#BEuler: 721.662 μs
#AB2: 422.611 μs
#IRK: 1.906 ms
##Answering Part B of 5.6.1.3:
#At varying final times we can see how each method does compared to one
#another. Our most complex method (IRK) is clearly the most expensive and
#always takes considerably longer than the other two. However, we see
#that Adam Bashforths 2-Stage Method is very quick for how complex it is.
#Although we do need to consider the fact that our Backwards Euler uses
#a while loop to make sure that the first estimate converges. This
#probably adds onto the time and means that our AB2 and BEuler method are
#probably quite similar in length. In general it is probably safe to say
#that as long as you are not adapting the time step for a problem less
#complex methods will take less time to compute compared to more complex
#methods over the same range of times. If we are considering an adaptive
#time step then we might see "slower" methods that are complex become
#quite fast because they are more accurate with less iterations.
##Answering Part C:
#As discussed in Part A we can see that the length in time or number of
#step sizes does not cause the IRK method to break away from our
#Hamiltonian. In fact, the method stays well behaved even under extreme
#conditions. The real downside though is the computing cost for an IRK
#method. It is incredibly expensive to run which makes it very hard to
#justify compared to Euler's Methods with small step sizes. Which can be
#just as accurate as IRK but cost a fraction of the computing power.
