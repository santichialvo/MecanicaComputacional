function fI = ffun_Ej_2_6_rhs(y)
%
%
%

global X Y ll mm coef

xbou = 1;
[N,bas] = shape_function(xbou,y,ll);

fI = cos(pi*y/2).*N;
