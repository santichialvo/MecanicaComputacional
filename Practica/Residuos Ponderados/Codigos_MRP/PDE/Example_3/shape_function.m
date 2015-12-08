function [N,L_N] = shape_function(x,mm)
%
%  get N_m(x,y) and L(N_m) 
%
%  with L : linear differential operator
%
%  [N,L_N] = shape_function(x,y,mm)
%

N  = x.^(mm-1);

L_N  = (mm-1)*(mm-2)*x.^(mm-3);
