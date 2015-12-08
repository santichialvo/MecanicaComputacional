function fI= gauss_integration(fun,ndim,a,b,c,d)
%
%                   Gaussian quadrature integration method
%
%   in two dimension over a rectangular domain (a,b)x(c,d)
% 
%   fI = gauss_integration(fun,a,b,c,d)
%

global X Y ll mm coef

npg = coef.npg;
Np  = coef.number_integ_points;
ndf = coef.ndf;
ncol= coef.ncol;

if ndim==1
    gauss_integration_1D;    
elseif ndim==2
    gauss_integration_2D;
else
    error(' *** dim out of range *** ')
end
