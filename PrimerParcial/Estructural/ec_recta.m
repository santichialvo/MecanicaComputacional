function y = ec_recta(x1,y1,x2,y2)
syms x;

m = (y2-y1)/(x2-x1);

y = m*(x-x1) + y1;


end

