%%Clearing the Workspace
clear all; close all; clc

%%Establishing our cases
A1 = [0 1; -1 0];
A2 = [0 1 0; 0 0 1; -23 -304 -732];

%%Finding the eigenvalues
eig1 = eig(A1);
eig2= eig(A2);

%%Plotting our region of stability for the 2-Stage Adam Basthforth Method
theta = linspace(0,2*pi(),100);
zx = ((3/2*cos(theta)-1/2).*(cos(2.*theta)-cos(theta))+3/2*sin(2*theta).*sin(theta)-3/2*sin(theta).^2)./((3/2*cos(theta)-1/2).^2+9/4*sin(theta).^2);
zy = (sin(2*theta)-3/2*zx.*sin(theta)-sin(theta))./(3/2*cos(theta)-1/2);

fig = figure();
ax = axes('Parent', fig);
hold(ax,'on');
ax.DataAspectRatio = [1,1,1];
ax.Color = [153, 210, 255]/255;
patch(ax, zx, zy, 'w', ...
    'EdgeColor', [101, 169, 123]/255, 'LineWidth',1 );
xlabel(ax, 'Re(\lambda h)');
ylabel(ax, 'Im(\lambda h)');

%%Minimums and Maximums for AB2
zxEx = [min(zx),max(zx)];
zyEx = [min(zy)*i,max(zy)*i];

%%Case 1: AB2
%Our Eigenvalues are -i & i but the min and max on the imaginary axis are
%the same (-0.8045i, 0.8045i). This means that either eigenvalue can be
%used to calculate the max step size. We will choose the positive
%eigenvalue and solve for the max h possible if z = h*lambda(the
%eigenvalue).

hAB1 = zyEx(2)/eig1(1);

%%Case 2: AB2
%The eigenvalues here are all different but rather than testing each
%individual one we can tell which will limit our h value the most. If the
%eigenvalue is small than h can be large but if the eigenvalue is large
%than h must be small to stay within the region of stability. This means
%that we only need to consider the largest eigenvalue of -731.58 to
%calculate the max h possible for the system to stay stable.
hAB2 = zxEx(1)/eig2(1)


%%Plotting the implicit midpoint method stablity region
NumPoints =100;
x = linspace(-5,5,NumPoints);
y = linspace(-5,5,NumPoints);
[X,Y] = meshgrid(x,y);
Za = zeros(NumPoints,NumPoints./2); %Builds half of Z
Z = [ones(NumPoints,NumPoints./2),Za];
fig = figure();
contourf(X,Y,Z,[1 1]) %Shades the left half

%%Case 1: IM
%Turns out the implicit midpoint method is the same as the trapezoidal rule
%in terms of the region of stability. For case 1 this is a case where the
%eigenvalues are only complex and the real part is equal to zero. The
%method is only stable for real values of h*lambda less than zero so there
%is no time step where this case is stable using this method.
hIM1 = 0;

%%Case 2: IM
%Each eigen value is negative which means for any time step greater than
%zero the method will be stable. This means the max time step is
%essentially infinite. You could choose any time step and the method will
%be stable.
hIM2 = inf;

%%Displaying the results for both methods
fprintf('2-Stage Adam Basthforth Method\n')
fprintf('For Case 1 the max step size h is: %0.4fs\n', hAB1)
fprintf('For Case 2 the max step size h is : %0.4fs\n', hAB2)

fprintf('\nImplicit Midpoint Method\n')
fprintf('For Case 1 there is no max step size because any step size will not be stable.\n')
fprintf('For Case 2 any step size can be chosen and the system will remain stable. In other words the max step size could be infinite (although this is impractical).\n')






