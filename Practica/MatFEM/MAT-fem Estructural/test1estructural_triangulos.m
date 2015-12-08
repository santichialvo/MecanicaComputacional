%
% Material Properties
%
 pstrs  = 1;
 young  = 1000.0;
 poiss  = 0.2;
 thick  = 0.1;
%
% Coordinates
%
global coordinates
coordinates = [
  0.00 , 0.00;
  1.00 , 0.00;
  0.00 , 1.00 ];
%
% Elements
%
global elements
elements = [
    1,   2,   3 ];

%
% densidad por elemento
%
global denss
denss = [
	1.0 ];

%
% Fixed Nodes
%
fixnodes = [];
%
% Point loads
%
pointload = [];
%
% Side loads
%
sideload = [];
