function fI = ffun_Ej_2_0_2D_lhs(x,y)
%
%
%

global X Y Z ll mm ll2 mm2

%z = interp2(X,Y,Z,x,y);

%f1 = sin(ll*pi*x).*sin(mm*pi*y);
%f2 = sin(ll2*pi*x).*sin(mm2*pi*y);

f1 = shape_function(x,y,ll,mm);
f2 = shape_function(x,y,ll2,mm2);

fI = f1.*f2;
