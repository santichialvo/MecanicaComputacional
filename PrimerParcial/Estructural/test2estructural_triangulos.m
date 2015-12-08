%
% Material Properties
%
 pstrs  = 1;
 young  = 200.0;
 poiss  = 0.3;
 thick  = 0.1;
%
% Coordinates
%
global coordinates
coordinates = [
  0.00 , 0.00;
  0.20 , 0.00;
  0.40 , 0.00;
  0.60 , 0.00;
  0.80 , 0.00;
  0.00 , 0.14;
  0.20 , 0.14;
  0.40 , 0.14;
  0.60 , 0.14;
  0.80 , 0.14;
  0.00 , 0.28;
  0.20 , 0.28;
  0.40 , 0.28;
  0.60 , 0.28;
  0.80 , 0.28 ];
%
% Elements
%
global elements
elements = [
    1,   2,  7; 
	1,	7,	6;
	6,	7,	12;
	6,	12,	11;
	2,	3,	8;
	2,	8,	7;
	7,	8,	13;
	7,	13,	12;
	3,	4,	9;
	3,	9,	8;
	8,	9,	14;
	8,	14,	13;
	4,	5,	10;
	4,	10,	9;
	9,	10,	15;
	9,	15,	14 ];

%
% densidad por elemento
%
global denss
denss = [
	7850 ;
	7850 ;
	7850 ;
	7850 ;
	7850 ;
	7850 ;
	7850 ;
	7850 ;
	7850 ;
	7850 ;
	7850 ;
	7850 ;
	7850 ;
	7850 ;
	7850 ;
	7850 ];

global fuerzaspuntuales
fuerzaspuntuales = [
	9	,	15	,	14	,	0.6,	0.28,	1 , 3.5 ;
	9	,	15	,	14	,	0.6,	0.28,	2 , 6.062 ];

%
% Fixed Nodes
%
fixnodes = [
	    1, 1, 0.0 ;
	    1, 2, 0.0 ;
	    5, 2, 0.0 ];
%
% Point loads
%
pointload = [];
%
% Side loads
%
sideload = [];
