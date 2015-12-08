function fI = ffun_Ej_2_9_rhs(y)
%
%
%

global X Y ll mm coef

E = coef.young;
nu = coef.poisson;

xbou = 1;
[N1,N2,Lx_N1,Ly_N1,Lx_N2,Ly_N2] = shape_function(xbou,y,ll);

if 0
    fI(:,1) = 6*(1-y.^2).*N1;
    fI(:,2) = 0*fI(:,1);    
else
    fI(:,1) = E/(1+nu)*(1-y.^2).*N1;
    fI(:,2) = 0*fI(:,1);
end