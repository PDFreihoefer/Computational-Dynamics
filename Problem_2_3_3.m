%%Problem 2.3.3

%Clearing the workspace
clear all
close all
clc

%Establishing some variables
A = [];
sign = -1;
%Let's start by creating a 6x6 matrix
for i = 1:6
   for j = 1:6
      sign = sign*-1;
      A(i,j) = sign*1; 
   end
   sign = sign*-1;
end

%Now let's take the determinant

detA = det(A)

%Det(A) = 160;
A = [1 1 1 -1 1 -1; -1 1 1 1 -1 1; -1 -1 1 1 1 -1; 1 -1 1 1 1 1; -1 1 -1 -1 1 1; -1 -1 1 -1 -1 1];