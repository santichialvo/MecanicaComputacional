function fI = ffun_Ej_2_0_2D_rhs(x,y)
%
%
%

global X Y Z ll mm ll2 mm2

z = interp2(X,Y,Z,x,y);
z = ffun_Ej_2_0_2D(x,y);

shapef = shape_function(x,y,ll,mm);

fI = z.*shapef;
