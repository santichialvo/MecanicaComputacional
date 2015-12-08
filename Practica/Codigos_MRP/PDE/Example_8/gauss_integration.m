function fI= gauss_integration(fun,a,b)
%
%                   Gaussian quadrature integration method
%
%   in one dimension over a domain (a,b)
% 
%   fI = gauss_integration(fun,a,b)
%

global X ll mm coef

npg = coef.npg;
Np  = coef.number_integ_points;
ndf = coef.ndf;
ncol= coef.ncol;

%npg  = 4;
%Np = 20;
gauss_integration_1D;
