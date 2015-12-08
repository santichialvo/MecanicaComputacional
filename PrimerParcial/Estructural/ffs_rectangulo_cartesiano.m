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

detN = det([1 1 1 1; x_v(1) x_v(2) x_v(3) x_v(4); y_v(1) y_v(2) y_v(3) y_v(4); x_v(1)*y_v(1) x_v(2)*y_v(2) x_v(3)*y_v(3) x_v(4)*y_v(4)]);
detN1 = det([1 1 1 1; x x_v(2) x_v(3) x_v(4); y y_v(2) y_v(3) y_v(4); x*y x_v(2)*y_v(2) x_v(3)*y_v(3) x_v(4)*y_v(4)]);
detN2 = det([1 1 1 1; x_v(1) x x_v(3) x_v(4); y_v(1) y y_v(3) y_v(4); x_v(1)*y_v(1) x*y x_v(3)*y_v(3) x_v(4)*y_v(4)]);
detN3 = det([1 1 1 1; x_v(1) x_v(2) x x_v(4); y_v(1) y_v(2) y y_v(4); x_v(1)*y_v(1) x_v(2)*y_v(2) x*y x_v(4)*y_v(4)]);
detN4 = det([1 1 1 1; x_v(1) x_v(2) x_v(3) x; y_v(1) y_v(2) y_v(3) y; x_v(1)*y_v(1) x_v(2)*y_v(2) x_v(3)*y_v(3) x*y]);

N(1) = detN1/detN;
N(2) = detN2/detN;
N(3) = detN3/detN;
N(4) = detN4/detN;

%N(1) = (1/(a*b)) * (a*b - b*x - a*y + x*y);
%N(2) = (1/(a*b)) * (b*x - x*y);
%N(3) = (1/(a*b)) * (x*y);
%N(4) = (1/(a*b)) * (a*y - x*y);

end