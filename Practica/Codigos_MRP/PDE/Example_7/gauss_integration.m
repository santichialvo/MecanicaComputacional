function fI= gauss_integration(fun,ndim,a,b,c,d)
%
%                   Gaussian quadrature integration method
%
%   in two dimension over a rectangular domain (a,b)x(c,d)
% 
%   fI = gauss_integration(fun,a,b,c,d)
%


if ndim==1
    npg  = 2;
    Np = 20;
    gauss_integration_1D;    
elseif ndim==2
    npg  = 4;
    Np = 20;
    gauss_integration_2D;
else
    error(' *** dim out of range *** ')
end
