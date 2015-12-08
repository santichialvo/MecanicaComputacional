function [N,Lx_N,Ly_N] = shape_function(x,y,mm)
%
%  get N_m(x,y) and L(N_m) 
%
%  with L : linear differential operator
%
%  [N,Lx_N,Ly_N] = shape_function(x,y,mm)
%
%  Lx_N : dN/dx
%  Ly_N : dN/dy
%

Nxs =strvcat('1','(x.^2)','(y.^2)','(x.^2.*y.^2)','(x.^4)');

dNxsdx =strvcat('0','(2*x)','0','(2*x.*y.^2)','(4*x.^3)');

dNxsdy =strvcat('0','0','(2*y)','(2*y.*x.^2)','0');

Nx = Nxs(mm,:);
dNxdx = dNxsdx(mm,:);
dNxdy = dNxsdy(mm,:);

eval(['N = (1-y.^2).*' Nx ';']);

eval(['Lx_N = (1-y.^2).*' dNxdx ';']);
eval(['Ly_N = (1-y.^2).*' dNxdy '-' Nx '.*(2*y)' ';']);
