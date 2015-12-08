function fI = ffun_Ej_2_8_rhs(x)
%
%
%

global X ll mm coef

filename = coef.p_function;
eval(['Q=' filename '(x);' ])

[N1,N2,L_N1,L_N2] = shape_function(x,ll);

fI(:,2) = Q.*N2;