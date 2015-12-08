function fI = ffun_Ej_2_10_rhs(x)
%
%
%

global X ll mm coef

filename = coef.Q_function;
eval(['Q=' filename '(x);' ])

[N,bas] = shape_function(x,ll);

fI = Q.*N;
