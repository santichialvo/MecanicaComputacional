function fI = ffun_Ej_2_0_1D_rhs(x)
%
%
%

global X Y Z ll ll2

% discrete evaluation of the integral kernel 
z = interp1(X,Z,x);
% a continuous function for the integral kernel
z = ffun_Ej_2_0_1D(x);

N = shape_function(x,ll);

fI = z.*N;
