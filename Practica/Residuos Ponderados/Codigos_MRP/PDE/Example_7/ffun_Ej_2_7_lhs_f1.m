function fI = ffun_Ej_2_7_lhs_f1(y)
%
%
%

global X Y ll mm coef

xbou = 3;
[Nl] = shape_function(xbou,y,ll);
[Nm] = shape_function(xbou,y,mm);

fI = Nl.*Nm;
