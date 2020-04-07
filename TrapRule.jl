module TrapRule

using LinearAlgebra
export tRule

#This function is based off of the Trapezoidal Rule
function tRule(f,tf,h,x0; tol = 0.001, iterMax = 200)
    time = 0:h:tf #In this case we will denote the time step with "h"
    n = length(time)
    p = length(x0) #Allows us to consider multiple initial conditions
    x = zeros(n,p) #In case we are working with matrices we want to establish x before our for loop

    #Initial Condition
    x[1,:] .= x0

    #First off we need to turn our equation from implicit to explicit (x(i+1) appears twice in the equation)
    #x[i+1,:] = x[i,:] + h/2*(f(x[i,:],time[i,:])+f(x[i+1,:],time[i+1,:]))

    #Euler Step
    fn = f(x[1,:],time[1])
    y = x[1,:]+h*fn

    #B-Euler for 1 Step to get x[i+1,:]
    flag = 0
    iter = 0
    while flag == 0
           iter += 1
           y = x[1,:] + h*f(y, time[2])

           residual = norm( y - x[1,:] - h*f(y, time[2]) )

           if residual <= tol
               flag = 1
           elseif iter >= iterMax
               flag = -1
               error("Error: failed to converge")
           end
    end

    #We now have y = x[2,:] so we will plug it into the trapezoidal rule equation to make the equation explicit

    for i = 1:n-1
        #for j = 1:p, We would want this in case the initial condition has multiple values and we would change the equation below
        x[i+1,:] = x[i,:] + h/2*(f(x[i,:],time[i,:])+f(y,time[i+1,:]))
        #end
        #Reassigning y with the new value we calculated in the last step
        y = x[i+1,:]

    end

    return x, time

end

end
