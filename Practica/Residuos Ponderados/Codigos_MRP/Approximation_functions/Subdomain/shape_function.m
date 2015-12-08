function N=shape_function(x,x1,x2)
%
%
%

N = (x>x1).*(x<=x2);
