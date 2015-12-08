function fI = ffun_Ej_2_5_rhs(x)
%
%
%

global X ll mm coef

[Nl_x1,bas] = shape_function(1,ll);

fI = (coef.q)*Nl_x1;
