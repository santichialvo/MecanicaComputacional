function fI = ffun_Ej_2_7_rhs_f2(x)
%
%
%

global X Y ll mm coef

ybou = 2;
[N] = shape_function(x,ybou,ll);

fI = -0.5*(ybou^2+x.^2).*N;
