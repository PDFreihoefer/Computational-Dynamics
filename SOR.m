%Successive Over-Relaxation Function
function [xSOR, iter, flag, resid] = SOR(A, b, tol)

%Preparing some variables for our loops
iterMAX = 10000;
n = length(A);
flag = 0;
xSOR(1:n) = 1;
iter = 0;
resid = [];

%Optimal Relaxation Equation
cJac = eye(n)-inv(diag(diag(A)))*A;
nu = eigs(cJac, 1, 'lm');
w = 1+(nu/(1+sqrt(1-nu^2)))^2;

while flag == 0
    
    %SOR Iteration Process, Source: Wikipedia
    for i = 1:n
        x = 0;
        for j = 1:n
            if j ~= i
                x = x + A(i,j)*xSOR(j);
            end
        end
        xSORPrev = xSOR;
        xSOR(i) = xSOR(i)+w*((b(i)-x)/A(i,i)-xSOR(i));
    end
    
 
    %Counting Iterations
    iter = iter + 1; 
    %Residual Tracking
    resid(iter) = xSOR(1)-xSORPrev(1);
    %Checking for convergence or if max iterations are reached
    if xSOR - xSORPrev < tol
        flag = 1;
    elseif iter == iterMAX
        flag = -1;
    end
end