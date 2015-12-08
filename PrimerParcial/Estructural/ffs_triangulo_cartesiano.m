function [N,A] = ffs_triangulo_cartesiano(x_v,y_v)

syms x y;

A = 1/2 * (x_v(1)*(y_v(2)-y_v(3)) + x_v(2)*(y_v(3) - y_v(1)) + x_v(3)*(y_v(1) - y_v(2)));
for e=1:3
    i=e;
    j=mod(i+1,4);
    if (j == 0) j=j+1; end %fucking base 1
    k=mod(j+1,4);
    if (k == 0) k=k+1; end
    
    a = (x_v(j)*y_v(k) - x_v(k)*y_v(j))/(2*A);
    b = (y_v(j) - y_v(k))/(2*A);
    c = (x_v(k) - x_v(j))/(2*A);
    
    N(e) = a + b*x + c*y;
end


end

