function [N1,N2,Lx_N1,Ly_N1,Lx_N2,Ly_N2] = shape_function(x,y,mm)
%
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

Nxs =strvcat('(x)','(x.^3)','(x.*y.^2)');
dNxsdx =strvcat('1','(3*x.^2)','(y.^2)');
dNxsdy =strvcat('0','0','(2*y.*x)');

Nys =strvcat('(y)','(y.*x.^2)','(y.^3)');
dNysdx =strvcat('0','(2*y.*x)','0');
dNysdy =strvcat('1','(x.^2)','(3*y.^2)');

Nx = Nxs(mm,:);
dNxdx = dNxsdx(mm,:);
dNxdy = dNxsdy(mm,:);

Ny = Nys(mm,:);
dNydx = dNysdx(mm,:);
dNydy = dNysdy(mm,:);

eval(['N1 = (1-y.^2).*' Nx ';']);
eval(['N2 = (1-y.^2).*' Ny ';']);
eval(['Lx_N1 = (1-y.^2).*' dNxdx ';']);
eval(['Ly_N1 = (1-y.^2).*' dNxdy '-' Nx '.*(2*y)' ';']);
eval(['Lx_N2 = (1-y.^2).*' dNydx ';']);
eval(['Ly_N2 = (1-y.^2).*' dNydy '-' Ny '.*(2*y)' ';']);
