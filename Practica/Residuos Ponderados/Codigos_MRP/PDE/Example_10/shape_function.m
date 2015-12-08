function [N,L_N] = shape_function(x,mm)
%
%  get N_m(x,y) and L(N_m) 
%
%  with L : linear differential operator
%
%  [N,L_N] = shape_function(x,y,mm)
%


% trial function
N  = x.^(mm).*(1-x);
% first derivative of trial function
L_N  = (mm)*x.^(mm-1)-(mm+1)*x.^mm;
