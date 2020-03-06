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


%%Part 1: Establishing our State-Space Representation
%After establishing these matrices by hand we can add them to MATLAB
A = [0 1 0 0; -k1/m1-k2/m1 -c1/m1-c2/m1 k2/m1 c2/m1; 0 0 0 1; k2/m2 c2/m2 -k2/m2 -c2/m2];
B = [0;0;0;1/m2];
C = [0,0,1,0];
D = 0;

%%Part 2: Observability and Controllability 

%Controllability Matrix
eM = [B A*B A^2*B A^3*B];

%Observability Matrix
oM = [C; C*A; C*A^2; C*A^3];

%Checking the rank of each
%Controllability
detC = det(eM); %If the determinant is zero then the matrix can't be full rank
[UC,SC,VC] = svd(eM); %If one of these is zero than the matrix isn't full rank
eigC = eig(eM); %Any zero eigenvalues mean the rank isn't full
rankC = rank(eM); %The rank should be 4 for the matrix to be full rank

%Observability
detO = det(oM);
[UO,SO,VO] = svd(oM);
eigO = eig(oM);
rankO = rank(oM);

%Rank Check
fprintf('The rank of the Controllability Matrix is: %i \n', rankC)
fprintf('The rank of the Observability Matrix is: %i \n', rankO)

%%Part 3: Picking Poles

%We must have a settling time of 2s
OS = 10/100; %We will pick an overshoot because we only care about TS
TS = 2; %[sec]

%Choosing our Poles
zeta = sqrt(log(OS)^2/(pi^2+log(OS)^2));
wn = 4/zeta/TS;

sx1 = -zeta*wn + 1j*wn*sqrt(1-zeta^2);
sx2 = conj(sx1);
sx3 = 5*real(sx1);
sx4 = 10*real(sx1);



%%Part 4: Designing a Controller

%Let's set up our equation from 4.1 into MATLAB

%tFN = m1*s^2-c1*s-k1, the numerator of our transfer function
%tFD = m2m1*s^4+(c2m1-m2c1)s^3+(k2m1-c1c2-m2k1)*s^2+(-k1c2-k2c1)*s-k1k2, the
%denominator of our transfer function
G = tf([m1,-c1,k1],[m2*m1, c2*m1-m2*c1, k2*m1-c1*c2-m2*k1, -k1*c2-k2*c1, -k1*k2]);


%Building K
d = flip( poly([sx1,sx2,sx3,sx4]) );
a = [200,8,10.08,0.2];
k = d(1:end-1) - a;

%% Check results
T = ss( A-B*k, B, C, D );
step(T)
stepinfo(T)

%%Part 5: 