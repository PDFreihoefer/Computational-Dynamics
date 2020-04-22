module ForwardEuler

using LinearAlgebra
export FEuler

function FEuler(f,tf,h,x0)

    #FEuler Equation:
    #x(i+1) = x(i) + h*f(i)

    time = 0:h:tf
    n = length(time)
    p = length(x0)
    x = zeros(n,p)

    #Initial Condition
    x[1,:] .= x0

    for i = 1:n-1
            x[i+1,:] = x[i,:] + h*f(x[i,:], time[i])
    end

    return x, time

end
end
