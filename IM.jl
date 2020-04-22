module ImplicitMidpoint

using LinearAlgebra

export IM

function IM(f,tf,h,x0; tol = 1e-4, iterMax = 200)

    #Implicit Midpoint Equation:
    #x(i+1) = x(i) + h*f(1/2*(x(i)+x(i+1)),t+h/2)

    time = 0:h:tf
    n = length(time)
    p = length(x0)
    x = zeros(n,p)

    #Initial Condition
    x[1,:] .= x0

    for i = 1:n-1
        #Because this is an implicit method we need to use an explicit method to
        #acquire an estimate for the first i+1 term. We will use a fixed point
        #iteration method to solve this: "Forward Euler".
        #x(i+1) = x(i) + h*f(x(i),t(i))

        #This gives us our first x(i+1)
        y = x[i,:] + h*f(x[i,:],time[i,:])

        flag = 0
        iter = 0
        while flag == 0
            iter += 1
            y = x[i,:] + h*f(1/2*(x[i,:]+y), time[i]+h/2)

            #Calculating the residual so we know when it "converges"
            resid = norm(y - x[i,:] - h*f(1/2*(x[i,:]+y), time[i]+h/2))

            if resid <= tol
                flag = 1
            elseif iterMax <= iter
                flag = -1
                error("Error: Method failed to converge")
            end

        x[i+1,:] = y
        end

    end

        return x, time
end

end
