function fI = ffun_Ej_2_2_num_lhs(x,y)
%
%
%

global X Y ll mm coef

[f1,bas] = shape_function(x,y,ll);
[bas,f2] = shape_function(x,y,mm);

fI = f1.*f2;
