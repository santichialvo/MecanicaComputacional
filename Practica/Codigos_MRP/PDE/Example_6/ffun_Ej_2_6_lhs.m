function fI = ffun_Ej_2_6_lhs(x,y)
%
%
%

global X Y ll mm coef

[Nl,Lx_Nl,Ly_Nl] = shape_function(x,y,ll);
[Nm,Lx_Nm,Ly_Nm] = shape_function(x,y,mm);

fI = Lx_Nl.*Lx_Nm + Ly_Nl.*Ly_Nm;
