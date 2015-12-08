function fI= gauss_integration(fun,a,b,c,d)
%
%                   Gaussian quadrature integration method
%
%   in two dimension over a rectangular domain (a,b)x(c,d)
% 
%   fI = gauss_integration(fun,a,b,c,d)
%

is2D = 1;
npg  = 4;
if nargin < 4
    is2D = 0;
    npg  = 2;
end

if is2D
    Np = 20;
    gauss_integration_2D;
else
    Np = 100;
    gauss_integration_1D;
end