function N=shape_function(x,m)
%
%
%

% potential function
N = x.^m.*(1-x);

% Fourier
N = sin(m*pi*x);
