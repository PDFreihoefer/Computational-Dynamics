function [X] = buildX(x,f,n)
%This function will create an array in a form that we can fit the curve of
%any function given for any number of inputs.

%Inputs:
%x - Known values of x
%f - Function f(x)
%n - Number of functions/size of polynomial

%Preparing for our loop
%X is a square array
p = length(x);

for i = 1:p
    for j = 1:n
        a = zeros(n,1);
        a(j) = 1;
        X(i,j) = f(x(i),a);
    end
end

end

