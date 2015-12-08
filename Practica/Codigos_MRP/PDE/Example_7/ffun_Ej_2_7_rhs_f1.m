function fI = ffun_Ej_2_7_rhs_f1(y)
%
%
%

global X Y ll mm coef

xbou = 3;
[N] = shape_function(xbou,y,ll);

fI = -0.5*(xbou^2+y.^2).*N;
