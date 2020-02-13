function [a] = myCurveFit(X,y)
%Function will compute the curve fit of the functions used

%Using 3.14 we can solve for a
a = inv(X'*X)*X'*y;

end

