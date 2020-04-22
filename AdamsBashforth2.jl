module AdamsBashforth2

using LinearAlgebra
export AB2

function AB2(f,tf, h, x0)

    #AB2 Method (Which is adapted to match where i starts):
    #AB2: x[i+1,:] = x[i,:] + h/2*(3*f(x[i,:],time[i]) - f(x[i-1,:],time[i-1]))

    time = 0:h:tf
    n = length(time)
    p = length(x0)
    x = zeros(n,p)

    #Initial Condition
    x[1,:] .= x0

    #The Adams Bashforth method requires that we know x(i+1) and then we can
    #continue the method without having an implicit equations. We can use the
    #forward euler method to estimate this value and then proceed with the AB2
    #equation.

    #Forward Euler
    fn = f(x[1,:],time[1])
    x[2,:] = x[1,:] + h*fn

    for i = 2:n-1
        fn_m1 = f(x[i-1,:], time[i-1]) #Just rewriting the above for
        fn = f(x[i,:],time[i-1])
        x[i+1,:] = x[i,:] + h/2*(3*fn-fn_m1)
    end

    return x, time
end
end
