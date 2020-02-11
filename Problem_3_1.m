%%Clearing the workspace
clear all
close all
clc

%%3.1.1

%Part 1 
%Creating the array and solving
T = [4 -1 0 -1 0 0 0 0 0; -1 4 -1 0 -1 0 0 0 0; 0 -1 4 0 0 -1 0 0 0 ; -1 0 0 4 -1 0 -1 0 0; 0 -1 0 -1 4 -1 0 -1 0; 0 0 -1 0 -1 4 0 0 -1; 0 0 0 -1 0 0 4 -1 0; 0 0 0 0 -1 0 -1 4 -1; 0 0 0 0 0 -1 0 -1 4];
b = [75; 0 ; 50; 75; 0 ; 50; 175; 100; 150];
tempSol = T\b;

%Part 2
%Singular values
sigMax = max(sqrt(eig(T*T)));
sigMin = min(sqrt(eig(T*T)));
kSig = sigMax/sigMin;
kBI = cond(T);

%Comparing
diffK = (kBI-kSig);
fprintf('The difference between the built-in command and our equation is: %e',diffK)

%Part 3
tol = 0.00001;
[xBiCGSTAB, iter, time, flag, resid] = BiCGSTAB(T,b,tol);

%Contour Plots Setup
boundT = size(T);
sizeMat = sqrt(boundT(1))+2;
tempBounds = [0, 50, 75, 100];
contMat = [];

%Creating the new square matrix and adding our boundary conditions
for i = 1:sizeMat
    contMat(i,1) = tempBounds(3);
    contMat(1,i) = tempBounds(4);
    contMat(i,sizeMat) = tempBounds(2);
    contMat(sizeMat,i) = tempBounds(1);
end

%Changing the edges slightly
contMat(1,1) = mean([75,100]);
contMat(5,1) = mean([75,0]);
contMat(1,5) = mean([100,50]);
contMat(5,5) = mean([0,50]);

%Adding the given values
count = 1; %This allows us to index each value of the tempSol vector no matter the size
for j = 1:sizeMat-2
    for k = 1:sizeMat-2
    contMat(sizeMat-j,k+1) = tempSol(count);
    count = count + 1;
    end
end
        
%Creating the Contour Plot
figure ()
contour(contMat)

%Showing the convergence
trueValue(1:iter+1) = tempSol(1);
figure()
plot([0:iter], resid(1,:), [0:iter], trueValue)
grid on
xlabel('Iteration Number')
ylabel('Temperature (F)')
legend('BiCGSTAB', 'Actual Value', 'location','southeast')
title('Convergence of Solvers')

%%3.1.2

%Part 1: SOR Method
%Given the matrices already we plug everything into our SOR function
[xSOR, iterSOR, flag, resid] = SOR(T, b, tol);
tolMat(1,1:length([0:iterSOR])) = tol;

%Plotting Convergence
figure()
plot([0:iterSOR], [1,resid], [0:iterSOR], tolMat)
grid on
xlabel('Iteration Number')
ylabel('Residual')
legend('SOR', 'Tolerance', 'location','southeast')
title('Convergence of Solvers')