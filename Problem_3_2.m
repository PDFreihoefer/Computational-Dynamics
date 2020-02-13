%%Problem 3.2

%Part 2: SVD

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

%Part 3: Functions