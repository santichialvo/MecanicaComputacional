function fI = ffun_Ej_2_5_lhs(x)
%
%
%

global X ll mm coef

[Nl,L_Nl] = shape_function(x,ll);
[Nm,L_Nm] = shape_function(x,mm);

fI = L_Nl.*L_Nm + Nl.*Nm ;
