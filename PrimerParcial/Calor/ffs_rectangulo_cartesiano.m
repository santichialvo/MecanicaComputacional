function [N,A] = ffs_rectangulo_cartesiano(x_v,y_v)

syms x y;

a = x_v(2) - x_v(1);
b = y_v(3) - y_v(2);
A = a*b;
%N = sym(ones(1,4));
% for e=4:-1:1
%     i=e;
%     j=mod(i+1,5);
%     if (j == 0) j=j+1; end %fucking base 1
%     
%     N(e) = N(e) * ((x-x_v(j))/(x_v(i)-x_v(j))) * ((y-y_v(j))/(y_v(i)-y_v(j)));
%     
% end

N(1) = (1/A) * (a*b - b*x - a*y + x*y);
N(2) = (1/A) * (b*x - x*y);
N(3) = (1/A) * (x*y);
N(4) = (1/A) * (a*y - x*y);

end