function [grad_N] = dshape_function(x,y,mm)
%
%  get grad N_m(x,y)
%
%  [grad_N] = dshape_function(x,y,mm)
%

N=ndims(x);
for k=1:N
    Nk(k)=size(x,k);
end

alpha_x = [1,3,1];
alpha_y = [1,1,3];

grad_N_x  = -(alpha_x(mm)*pi/6)*sin(alpha_x(mm)*pi*x/6).*cos(alpha_y(mm)*pi*y/4);
grad_N_y  = -(alpha_y(mm)*pi/4)*cos(alpha_x(mm)*pi*x/6).*sin(alpha_y(mm)*pi*y/4);

grad_N = zeros([size(x),2]);

Nks = [];
for k=1:N
    Nks = [Nks , ':,'];
end

eval(['grad_N(' Nks '1)=grad_N_x;']);
eval(['grad_N(' Nks '2)=grad_N_y;']);
