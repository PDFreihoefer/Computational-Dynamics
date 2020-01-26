function [lnX, nIter1, nIter2, z] = tSeriesLN(x)

%Processing X
%If the value of x is greater than 2 we result in a NaN
mIter = 1000000; %We will establish the max iterations to preserve speed on any given run
nIter1 = 0;
n = floor(x/exp(1));
E = 1;
tol = 1*10^-26;

for l = 1:n
   E = E*exp(1); 
end

z = x/E;



if n == 0
    z = x/2;
end

%Establishing knowns and variables
j = 1; %We "manually" input the first term of the Taylor series so we will
%be using j to help with each subsequent iteration
nIter2 = 0;
tSeriesLN = 0;
tSeriesLN2 = 0;
nTerm = 1;
sign = -1;
k = 1;
%%The LOOPs

%ln(2)
if n == 0
while abs(nTerm) > tol && nIter1 < mIter
    
    tSeriesLN2 = tSeriesLN2 + nTerm;
    k = k+1;
    nTerm = sign*nTerm*(k-1)/k; 
    nIter1 = nIter1 + 1; %Counting the number of iterations
    
end
end

%ln(z)
nTerm = z-1;
sign = -1;
while abs(nTerm) > tol && nIter2 < mIter
    
    tSeriesLN = tSeriesLN + nTerm;
    j = j+1;
    nTerm = sign*nTerm*(z-1)*(j-1)/j; 
    nIter2 = nIter2 + 1; %Counting the number of iterations
    
end
lnXZ = tSeriesLN + tSeriesLN2;

lnX = n + lnXZ;

end