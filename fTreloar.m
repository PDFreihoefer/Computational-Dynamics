function y = fTreloar(x,a)
%The 5-term polynomial used to describe the stress in materials like rubber
y = 2*(x-x^(-2))*(a(1)+a(2)*x^(-1)+2*a(3)*(x^2+2*x^(-1)-3)+2*a(4)*(2*x+x^(-2)-3)+3*a(5)*(x-1-x^(-1)+x^(-2)));
end

