function [N1,N2,L_N1,L_N2] = shape_function(x,mm);
%

% trial function
N1  = x.^(mm-1).*(1-x);
N2  = x.^(mm);
% first derivative of trial function
L_N1  = (mm-1)*x.^(mm-2)-mm*x.^(mm-1);
L_N2  = mm*x.^(mm-1);
