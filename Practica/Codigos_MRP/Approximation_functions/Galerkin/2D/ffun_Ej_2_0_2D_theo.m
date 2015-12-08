function fI = ffun_Ej_2_0_2D_theo(x,y)
%
%
%

global X Y Z ll mm ll2 mm2

z = 4*interp2(X,Y,Z,x,y);
%z = ffun_Ej_2_0_2D(x,y);

shapef = shape_function(x,y,ll,mm);

fI = z.*shapef;
