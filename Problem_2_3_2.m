%%Problem 2.3.2 Matrix Multiplication

%Clearing the workspace
clear all
close all
clc

%Establishing some variables and our inputs

A = [];
B = [];
C = [];
calcTime = [];
sumProd = 0;


for i = 1:3
   %This will create some random arrays for us to work with
   A = rand(2*i, 3*i);
   B = rand(3*i, 2*i);
   [rA,cA] = size(A);
   [rB,cB] = size(B);
   %Checking for arrays that we can't multiply in the beginning
   if cA ~= rB
       error('You cannot multiply these matrices')
   end

%Now we make the loop that multiplys
tic
for j = 1:1000
    for k = 1:rA
        for l = 1:cB
            sumProd = 0;
            for w = 1:cA
            sumProd = sumProd + A(k,w)*B(w,l);
            end
            C(k,l) = sumProd;
        end
    end
    calcTime(j) = toc;
end

tic
for q = 1:1000
   builtIn = A*B;
   bInTime(q) = toc;
end

%It's hard to easily display all of these arrays, so we can cheat a little
%and show that the subtraction of the two are = 0;
check = sum(max(C - builtIn)); %Checking for any error
%Displaying the results
fprintf('Multiplication of A: %d x %d and B: %d x %d \n', rA,cA,rB,cB);
fprintf('Error between our loop and the built-in command: %e \n', check)
fprintf('Time for loop: %es Time for build-in command: %es \n \n', mean(calcTime), mean(bInTime))

end

