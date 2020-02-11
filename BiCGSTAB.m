%Unpreconditioned BiCGSTAB

function [xF, iter, time, flag, resid] = BiCGSTAB(A, b, tol)

%Capping and preparing for our loops
iter = 0;
iterMax = 1000000;
flag = 0;


%We will start with an initial guess of 1 for each value but this value
%doesn't considerably affect the time or number of iterations
x0(1:length(A),1) = 1;
resid(:,1) = x0;
r0 = b-A*x0;
rHat = r0;
rhoPrev = 1;
a = 1;
w = 1;
v = 0;
p = 0;

%This while loop will stop when we meet the BiCGSTAB requirements to exit
%the loop
tic
while flag == 0
    rho = dot(r0,rHat);
    beta = (rho/rhoPrev)*(a/w);
    rhoPrev = rho;
    p = r0+beta*(p-w*v);
    v = A*p;
    a = rho/dot(rHat,v);
    h = x0 + a*p;
    
    %First Check
    if h - x0 < tol
        xF = h;
        flag = 1;
    end
    s = r0 - a*v;
    t = A*s;
    w = dot(t,s)/dot(t,t);
    x = h+w*s;
    
    %Second Check
    if x - x0 < tol
        xF = x;
        flag = 2;
    end
    r0 = s-w*t;
    x0 = x;
    
    %Counting the number of iterations
    iter = iter+1;
    if iter == iterMax
        flag = -1;
    end
    resid(:,iter+1) = x;
end
time = toc;
