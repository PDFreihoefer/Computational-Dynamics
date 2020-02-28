%%Clearing the workspace
clear all
close all
clc

%%Part 4.1.2

%Let's establish the known values
m1 = 1; %kg
m2 = 1; %kg
k1 = 20; %N/m
k2 = 10; %N/m
c1 = 0.4; %Ns/m
c2 = 0.2;  %Ns/m

%Our input is f2 and output is x2
%Let's set up our equation from 4.1 into MATLAB

%tFN = m1*s^2-c1*s-k1
%tFD = m2m1*s^4+(c2m1-m2c1)s^3+(k2m1-c1c2-m2k1)*s^2+(-k1c2-k2c1)*s-k1k2

%%Controls Toolbox

G = tf([m1,-c1,k1],[m2*m1, c2*m1-m2*c1, k2*m1-c1*c2-m2*k1, -k1*c2-k2*c1, -k1*k2])

%%Part 1: Establishing our State-Space Representation
%After establishing these matrices by hand we can add them to MATLAB
A = [0 1 0 0; -k1/m1-k2/m1 -c1/m1-c2/m1 k2/m1 c2/m1; 0 0 0 1; k2/m2 c2/m2 -k2/m2 -c2/m2];
B = [0;0;0;0;1/m2];
C = [0,0,1,0];
D = 0;

%%Part 2: Observability and Controllability 

%Controllability Matrix
eM = [B A*B A^2*B A^3*B];

%Observability Matrix
oM = [C; C*A; C*A^2; C*A^3];


