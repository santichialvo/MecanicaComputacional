function fI = ffun_Ej_2_3_rhs(x)
%
%
%

global X Y ll mm coef

[Nl,bas] = shape_function(x,ll);
[Nl_x1,bas] = shape_function(1,ll);

fI = -(coef.p)*Nl - Nl_x1;
