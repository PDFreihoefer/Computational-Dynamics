module RungeKutta2

using LinearAlgebra
export rKutta

#This function will be based on the runge kutta method for different α's
function rKutta(f,tf,h,x0, α)
    time = 0:h:tf #In this case we will denote the time step with "h"
    n = length(time)
    p = length(x0) #Allows us to consider multiple initial conditions
    x = zeros(n,p) #In case we are working with matrices we want to establish x before our for loop

    #Initial Condition
    x[1,:] .= x0

    #For the runge kutta method we are given a butcher table with some different alphas
    #x[i+1,:] = x[i,:] + h*(b₁*k₁+b₂*k₂)
    #We can define the unknowns (b₁,k₁,b₂,k₂) as follows:
    #b₁=1-1/(2*α)
    #b₂=1/(2*α)
    #k₁=f(tₙ,xₙ)
    #k₂=f(tₙ+c₂*h,xₙ+h*a₂₁*k₁)
    #c₂&a₂₁ both come from the butcher table and are both equal to α

    #Unlike the trapezoidal method the runge kutta method is explicit to start, so we don't have to make other steps to solves for any unknowns.
    #Instead we can go straight to the equaition to solve for our next x value

    #First we should establish some of these values before they enter the for loop to save time
    a21 = α
    c2 = α
    b1 = 1-1/(2*α)
    b2 = 1/(2*α)

    for i = 1:n-1
        k1 = f(x[i,:],time[i,:])
        x2 = x[i,:]+h*a21*k1
        t2 = time[i,:]+c2*h
        k2 = f(x2,t2)

        #Here is the runge kutta step
        x[i+1,:] = x[i,:] + h*(b1*k1+b2*k2)

        #Reassigning y with the new value we calculated in the last step
        y = x[i+1,:]

    end

    return x, time
end




end
