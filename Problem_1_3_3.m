%% Problem 1.3.3: POW
clear
close
clc


%%Establishing some inputs and Variables
x = [1, 2.5, 5, 22.2314, 40];
y = [0.25, 0.5, 2, 4, 10];
tol = 1*10^-26;
for q = 1:length(x)
    for w = 1:length(y)
tic
for k = 1:1000

%Calling our function to calculate ln(x)
if x(q) > 0 && x ~= 1
    lnX = tSeriesLN(x(q));
elseif x(q) == 1
    lnX = 0;
elseif x(q) == 0 | x(q) < 0
    error('You cannot use this method to process a negative number')
end

%Now we will find a new n and z
y2 = y(w)*lnX;
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
bInValue = x(q)^y(w);
bInTime(k) = toc;
end

%Reporting Solutions and comparing
fprintf('For the value of x = %.3f and y = %.3f we get the following results \n', x(q), y(w))
fprintf('Using simple arithmetic the value is %.6f and the time to complete is %ds  \n', finalValue, mean(calcTime))
fprintf('Using built-in command the value is %.6f and the time to complete is %ds \n', bInValue, mean(bInTime))
    end
end

