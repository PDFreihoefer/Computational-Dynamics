%% Problem 1.3.3: POW
clear
close
clc


%%Establishing some inputs and Variables
x = 20;
y = 0.25;

tol = 0.000000000001;

tic
for k = 1:1000

%Calling our function to calculate ln(x)
lnX = tSeriesLN(x);

%Now we will find a new n and z
y2 = y*lnX;
n2 = floor(y2);
z2 = y2 - n2;
tSeriesE = 1;

%Using n we can find the easy part of e^(y*ln(x))
intE = 1;
for l = 1:n2
   intE = intE*exp(1); 
end

nTerm2 = z2;
nIter2 = 0;
mIter = 1000000;
i = 1;

while nTerm2 > tol && mIter > nIter2
    i = i+1;
    
    %Taylor series expansion of e^(y*ln(x))
    tSeriesE = tSeriesE + nTerm2;
    nTerm2 = nTerm2*z2/i;
    
    nIter2 = nIter2 + 1;
end
finalValue = intE*tSeriesE;
calcTime(k) = toc;
end

%Using the built in function
tic
for k = 1:1000
bInValue = x^y;
bInTime(k) = toc;
end

%Reporting Solutions and comparing
fprintf('Using simple arithmetic the value is %.6f and the time to complete is %d  \n', finalValue, mean(calcTime))

fprintf('Using built-in command the value is %.6f and the time to complete is %d \n', bInValue, mean(bInTime))


