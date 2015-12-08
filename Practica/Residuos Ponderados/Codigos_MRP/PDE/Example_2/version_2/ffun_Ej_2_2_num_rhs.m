function fI = ffun_Ej_2_2_num_rhs(x,y)
%
%
%

global X Y ll mm coef

[N,bas] = shape_function(x,y,ll);

fI = -(coef.p)*N;
