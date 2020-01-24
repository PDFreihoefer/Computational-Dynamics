%%Problem 1.2: Moody Diagram
%Clearing the workspace
clear all
close all
clc

%%Establishing our knowns
Re = [4000:1000:(10^8)]; %Array of the desired Reynolds Number range
rR = [0.05,0.01,0.002,2*10^(-4),5*10^(-6)]; %Some relative roughness values 
                                            %used on the Moody Diagram

%%Fixed Point Iteration of the Colebrook Equation
%We will do this by using multiple for loops and a while loop for the
%iteration

%Defining the tolerance and max iterations
mIter = 10000;
tol = 0.00001;

%Creating the loop
for i = 1:length(rR)
    for j = 1:length(Re)
        nIter = 0; %Counts iterations
        diff = 1; %Establishing a difference greater than the tolerance to 
                  %prevent the while loop from immediately ending
        x0 = 10; %Initial guess to use in our fixed point iteration
        while (diff > tol) && (nIter < mIter)
            xN = -2*log10(rR(i)/3.7+2.51/Re(j)*x0);
            diff = abs(xN - x0);
            x0 = xN;
            nIter = nIter + 1;
        end
        x(j,i) = (1/x0)^2;
    end
end

%%Plotting the Results
loglog(Re, x(:,1)',Re, x(:,2)',Re, x(:,3)',Re, x(:,4)',Re, x(:,5)' )
title('Problem 1.2: Moody Diagram')
xlabel('Reynolds Number')
ylabel('Friction Factor')
leg = legend('0.05','0.01','0.002','2*10^-4','5*10^-6','Location','southwest')
title(leg, 'Relative Roughness')
axis ([4000 10^8 0 0.1])
yticks([0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1])
grid on
            
            