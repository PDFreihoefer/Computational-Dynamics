module ImplicitRungeKutta

using LinearAlgebra
export IRK

function IRK(f,tf,h,x0; tol =1e-4, iterMax = 200)

    #Implicit Runge Kutta Equation:
    #Derived from the butcher table and these conditions
    #x(i+1) = x(i) + h*∑bᵢkᵢ, b is a value from the butcher table and k is:
    #kᵢ = f(x(i)+h*∑aᵢⱼkᵢ,tₙ+c₁*h)
    #Oof... Let's get into that butcher table given in problem 5.6, fig (5.10)

    #From the butcher table
    c1 = 1/2-sqrt(3)/6
    c2 = 1/2+sqrt(3)/6
    a11 = 1/4
    a12 = 1/4-sqrt(3)/6
    a21 = 1/4+sqrt(3)/6
    a22 = 1/4
    b1 = 1/2
    b2 = 1/2

    #Now we can write out k1 and k2
    #k1 = f(x(i)+h*(a11*k1+a12*k2),time(i)+c1*h)
    #k2 = f(x(i)+h*(a21*k1+a22*k2),time(i)+c2*h)

    #Finally our IRK Equation looks like the following:
    #x(i+1) = x(i) + h*(b1*k1+b2*k2), looks so nice in this form...

    time = 0:h:tf
    n = length(time)
    p = length(x0)
    x = zeros(n,p)

    #Initial Condition
    x[1,:] .= x0

    #We need to make a guess for k1/k2 and we have to simaltaneously find them
    #because they are present in both of their respective equations. The easiest
    #way to do this (as in the way I understand how to do this) is using fixed
    #point iteration and getting the two values to converge.

    #We start with a guess for k1 & k2
    k1 = zeros(p)
    k2 = zeros(p)
    k1N = zeros(p)
    k2N = zeros(p)

    for i = 1:n-1
        iter = 0
        flag = 0
        while flag == 0
            iter += 1
            k1N[:] = f(x[i,:]+h*(a11*k1+a12*k2),time[i]+c1*h)
            k2N[:] = f(x[i,:]+h*(a21*k1+a22*k2),time[i]+c1*h)

            #We need to evaluate two different residuals
            residk1 = norm(k1-k1N)
            residk2 = norm(k2-k2N)
            k1[:] = k1N
            k2[:] = k2N

            if residk1 <= tol && residk2 <= tol
                flag = 1
            elseif iterMax <= iter
                flag = -1
                error("Error: System failed to converge")
            end
        end

        #Now we have values for k1 and k2 that converged at this x(i) we will
        #use these estimates for each consequetive iteration in the hopes that
        #k1 and k2 will converge faster.

        x[i+1,:] = x[i,:] + h*(b1*k1+b2*k2)
    end

    return x, time

end
end
