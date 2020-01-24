%%Problem 1.3.2: Sin(x)
%Clearing the workspace
clear
close
clc

%%Taylor Series Expansion Loop
%The rules are that we can only use simple arithmetic, +, -, /, & *

mIter = 300; 
tol = 0.00000001; %If a term is this small then it will not affect our
                  %final result enough to include it
range = [-4000,-5,0,3,10,4000];

for i = 1:length(range)
%x = rem(abs(range(i)),pi); %This is slower than the line below!
x = (ceil(abs(range(i))/pi)-abs(range(i))/pi)*pi; %Consistently faster where 'rem' was not, \
                              %like values <3 and small negative numbers.
                              %Probably has something to do with the fact
                              %that it is essentially all simple arithmetic
y = x;
%Establishing variables for the while loop
tSeries = 0;
sign = 1;
j = 2;

for l = 1:1000
tic
while y > tol
    tSeries = tSeries + sign*y;
    y = y*x*x/(j+1)/(j);
    sign = -1*sign;
    j = j + 2;
end
arithTime(l) = toc; %Timing our Taylor Series Expansion
end

%%Comparison
for k = 1:1000
tic
sinResult = sin(x);
builtInTime(k) = toc; %Timing the command
end

fprintf('\n Input value: %.2f \n', range(i))
fprintf('The value from our Taylor Series is: %.6f and it took %.3d seconds to compute \n', tSeries, mean(arithTime))
fprintf('The value from the Sin command is: %.6f and it took %.3d seconds to compute \n', sinResult, mean(builtInTime))
end


