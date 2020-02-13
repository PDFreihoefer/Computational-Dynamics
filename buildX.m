function [X] = buildX(x,f,n)
%This function will create an array in a form that we can fit the curve of
%any function given for any number of inputs.

%Inputs:
%x - Known values of x
%f - Function f(x)
%n - Number of functions/size of polynomial

%Preparing for our loop
%X is a square array of size (n+1,n+1) 

for i = 1:n+1
    fPull = f{i};
    for j = 1:n+1
        if j == 1
            X(i,j) = 1;
        else
            X(i,j) = fPull(i);
        end
    end
end

end

