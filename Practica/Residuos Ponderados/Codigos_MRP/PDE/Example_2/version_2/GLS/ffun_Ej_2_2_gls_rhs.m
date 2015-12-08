function fI = ffun_Ej_2_2_gls_rhs(x,y)
%
%
%

global X Y ll mm coef

[N,L_N] = shape_function(x,y,ll);

fI = -(coef.p)*L_N;
