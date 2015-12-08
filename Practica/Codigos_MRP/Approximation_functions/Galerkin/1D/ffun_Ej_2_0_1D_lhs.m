function fI = ffun_Ej_2_0_1D_lhs(x)
%
%
%

global X Y Z ll ll2

f1 = shape_function(x,ll);
f2 = shape_function(x,ll2);

fI = f1.*f2;
