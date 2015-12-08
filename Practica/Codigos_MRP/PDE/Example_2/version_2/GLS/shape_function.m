function [N,L_N] = shape_function(x,y,mm)
%
%  get N_m(x,y) and L(N_m) 
%
%  with L : linear differential operator
%
%  [N,L_N] = shape_function(x,y,mm)
%

alpha_x = [1,3,1];
alpha_y = [1,1,3];

N  = cos(alpha_x(mm)*pi*x/6).*cos(alpha_y(mm)*pi*y/4);

L_N  = -((alpha_x(mm)*pi/6)^2+(alpha_y(mm)*pi/4)^2)*cos(alpha_x(mm)*pi*x/6).*cos(alpha_y(mm)*pi*y/4);
