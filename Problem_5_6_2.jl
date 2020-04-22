##Establishing the Pkg
using Pkg
Pkg.activate(".")

using Plots
using LinearAlgebra
##Loading our various functions
include("C:/Users/paulf/Documents/GitHub/Computational-Dynamics/ForwardEuler.jl")
using .ForwardEuler

include("C:/Users/paulf/Documents/GitHub/Computational-Dynamics/IM.jl")
using .ImplicitMidpoint

include("C:/Users/paulf/Documents/GitHub/Computational-Dynamics/ImplicitRungeKutta.jl")
using .ImplicitRungeKutta


##We are now considering a new hamiltonian and with new ODEs
#We are given the following:
i1 = 2
i2 = 1
i3 = 2/3
y0 = [cos(1.1),0,sin(1.1)]

#We know these are the following ODEs
#y1Dot = a1*y2*y3
#y2Dot = a2*y3*y1
#y3Dot = a3*y1*y2
a1 = (i2-i3)/(i2*i3)
a2 = (i3-i1)/(i3*i1)
a3 = (i1-i2)/(i1*i2)

#Now for our function
f(y,t) = [a1*y[2]*y[3],a2*y[3]*y[1],a3*y[1]*y[2]]
h = 0.01 #Time step
tf = 10 #Final time
##Gathering our solutions from each method
#Forward Euler
xFE, tFE = FEuler(f,tf,0.1,y0)
#Implicit Midpoint Method
xIM, tIM = IM(f,tf,h,y0)
#Implicit Runge Kutta
xIRK, tIRK = IRK(f,tf,4,y0)
##Hamiltonian
hFE = 1/2 .*(xFE[:,1].^2 ./i1 + xFE[:,2].^2 ./i2 + xFE[:,3].^2 ./i3)
hIM = 1/2 .*(xIM[:,1].^2 ./i1 + xIM[:,2].^2 ./i2 + xIM[:,3].^2 ./i3)
hIRK = 1/2 .*(xIRK[:,1].^2 ./i1 + xIRK[:,2].^2 ./i2 + xIRK[:,3].^2 ./i3)
##Plotting Hamiltonians
plot(tFE, hFE, label = "Forward Euler h = 0.1", xlabel = "Step Number", ylabel = "Hamiltonian", title = "Comparing the Hamiltonian to other Methods")
plot!(tIM, hIM, label = "Implicit Midpoint Method h = 0.01", legend =:topleft)
plot!(tIRK, hIRK, label = "Implicit Runge Kutta, h = 4")
#It looks like the Forward Euler method doesn't remain on H and start to grow
#over time. In the 3D representation it looks like it matches the correct
#trajectory but is obviously inaccurate enough to start to diverge from H.
#Regardless of how much we alter the conditions of IRK it stays incredibly
#accurate and well-behaved. Making it an incredibly reliable method at high step
#sizes and long time intervals. Just a very costly one.

##Plotting our Solutions
plot(xFE[:,1],xFE[:,2],xFE[:,3], label = "Forward Euler", legend=:bottomleft, xlabel="y1", ylabel = "y2", zlabel = "y3", title="3D Plot of y1 vs. y2 vs. y3")
plot!(xIM[:,1],xIM[:,2],xIM[:,3], label = "Implicit Midpoint Method")
plot!(xIRK[:,1],xIRK[:,2],xIRK[:,3], label = "Implicit Runge Kutta")
