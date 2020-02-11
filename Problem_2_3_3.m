%%Problem 2.3.3

%Clearing the workspace
clear all
close all
clc

%Establishing some variables
%Let's start by creating a 6x6 matrix assuming that the first row is
%alternating with 1 & -1 (we can cheat a little and assume that we want to
%use the co-factor expansion method to our advantage.

A = [];
sign = -1;

%We want to consider the number of possibilities of a 5x6 matrix of
%alternating 1s and -1s. That means each space can be one of two values and
%30 spaces can alternate. 

nPoss = 2^22; %Number of possibilities
validVal = setdiff(-1:1, 0);
diffDetA = single([0;0]);

loopTime = tic;
for i = 1:nPoss
    iterTime = tic;
    A = validVal(randi(length(validVal),6,6));
    A(1,:) = [1 -1 1 -1 1 -1];
    detA = single(abs(det(A)));
    
    if detA < 1
        detA = floor(detA);
    else
        detA = ceil(detA);
    end
    
    %Let's count how many times a det is found
    if any(diffDetA(1,:) == floor(detA))
        [r,c] = find(diffDetA == detA);
        diffDetA(2,c) = diffDetA(2,c)+1;
    else
       diffDetA(1,end+1) = detA;
       diffDetA(2, end) = 1;
    end
    time(i) = toc(iterTime);
end

%Now let's take the determinant
maxDet = max(diffDetA(1,:));

%Average Time per iteration
avgTime = mean(time);
%Total Time for the entire loop
totalTime = toc(loopTime);

%Det(A) = 160;
%A = [1 1 1 -1 1 -1; -1 1 1 1 -1 1; -1 -1 1 1 1 -1; 1 -1 1 1 1 1; -1 1 -1 -1 1 1; -1 -1 1 -1 -1 1];