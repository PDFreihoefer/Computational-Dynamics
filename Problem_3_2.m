%%Problem 3.2
clear all
close all
clc

%%Part 2: SVD

X = floor(randn(5,5)*10);

%Computing the SVD
[U,S,V] = svd(X);

%Now showing that the psuedoinverse of X is equal to the other portion
xPI = inv(X'*X)*X';
RHS = V*inv(S'*S)*S'*U';

%Checking if they are the same

check = xPI - RHS;
tol = 0.00000001;

if check < tol
    fprintf('The statement is true and equation 3.14 is accurate.\n \n')
    fprintf('                The Psuedoinverse of X\n')
    disp(xPI)
    fprintf('             The Right Hand Side of 3.14\n')
    disp(RHS)
else
    fprintf('The statement is false and equation 3.14 is not necessarily true\n')
end

%%Part 3-5: Functions

%Creating some noise for x, couldn't get awgn to work because I did not
%have the Communication Toolbox
x = randn(1,100)*5;
x = sort(x);

y = x.^3-24.*x.^2+10.*x-5;

X = buildX(x, @f, 4);
a = myCurveFit(X,y');

%Part 6
[dataSix] = xlsread('Data_3_2_6');

XTreloar = buildX(dataSix(:,1), @fTreloar, 5);
aTreloar = myCurveFit(XTreloar,dataSix(:,2));

xTreloar = 1:0.1:7;

fTreCheck = 2*(xTreloar-xTreloar.^(-2)).*(aTreloar(1)+aTreloar(2).*xTreloar.^(-1)+2*aTreloar(3).*(xTreloar.^2+2.*xTreloar.^(-1)-3)+2*aTreloar(4).*(2.*xTreloar+xTreloar.^(-2)-3)+3*aTreloar(5).*(xTreloar-1-xTreloar.^(-1)+xTreloar.^(-2)));
coeffT = polyfit(dataSix(:,1),dataSix(:,2), 4);
polyT = coeffT(1)*xTreloar.^4+coeffT(2)*xTreloar.^3+coeffT(3)*xTreloar.^2+coeffT(4)*xTreloar+coeffT(5);

figure
hold on
plot(xTreloar, fTreCheck, 'linewidth', 2)
plot(xTreloar, polyT,'r','linewidth', 2)
grid on 
xlabel('Strain')
ylabel('Stress [kg/cm^2]')
title('Stress vs. Strain of a Rubber-like Material')
legend('Psuedoinverse Shenanigans', 'Polyfit Line', 'location','northwest')

%From the graph it looks like there are some similarities to the figure but
%the values and curve is not exactly the same. This exposes some of the
%issues that come with our method of solving the coefficients. However,
%when comparing it to the built in polyfit command there is a closer curve
%from our method. If we had more data then we would be able to get a closer
%curve to what we would actually expect. 