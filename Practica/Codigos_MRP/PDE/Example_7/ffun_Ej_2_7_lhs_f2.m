function fI = ffun_Ej_2_7_lhs_f2(x)
%
%
%

global X Y ll mm coef

ybou = 2;
[Nl] = shape_function(x,ybou,ll);
[Nm] = shape_function(x,ybou,mm);

fI = Nl.*Nm;
