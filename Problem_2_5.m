%%Problem 2.5 Some Mechanics :O

%Clearing the workspace
clear all
close all
clc

%Material: 6061-T6 Aluminum
%Stress on the body in matrix form

a = [2 5 3; 5 1 4; 3 4 3];
A = 10*a; %MPa

%Eigenvalues are the principal stresses and the directions are the
%eigenvectors

[eigVec, eigVal] = eig(A);

%Part 1

prinStress1 = eigVal(1);
prinStress2 = eigVal(5);
prinStress3 = eigVal(9);

fprintf('The Principle Stresses are: %.3f MPa, %.3f MPa, & %.3f MPa\n', prinStress1, prinStress2, prinStress3)

%Part 2

fprintf('The directions of the principal stresses are the eigenvectors and are shown below\n')
display(eigVec)

%Part 3

%Max shear stress is just half the range of the max and min stresses
tMax = (prinStress3-prinStress2)/2;
fprintf('The max shear stress is %.3f MPa\n', tMax)

%Part 4

%Sub-Part A

facSafeA = sqrt(1/2*((A(1)-A(5))^2+(A(5)-A(9))^2+(A(9)-A(1))^2+6*(A(4)^2+A(8)^2+A(3)^2)));

%Sub-Part B

facSafeB = sqrt(1/2*((prinStress1-prinStress2)^2+(prinStress2-prinStress3)^2+(prinStress3-prinStress1)^2));

%Sub-Part C

sigDev = A-1/3*trace(A);
j2 = 1/2*trace(sigDev^2);
facSafeC = sqrt(3*j2);

%Comparing the three solutions
fprintf('The factor of safety from method A: %.3f\n', facSafeA)
fprintf('The factor of safety from method B: %.3f\n', facSafeB)
fprintf('The factor of safety from method C: %.3f\n', facSafeC)
