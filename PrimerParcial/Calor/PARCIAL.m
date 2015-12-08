%=======================================================================
% MAT-femcCal 1.0  - MAT-femCal is a learning tool for undestanding 
%                    the Finite Element Method with MATLAB and GiD
%=======================================================================
% PROBLEM TITLE = Titulo del problema
%
%  Material Properties
%
  kx =              1.00000 ;
  ky =              1.00000 ;
%
% Coordinates
%
global coordinates
coordinates = [
         0.00000   ,        0.00000  ;
         0.50000   ,        0.00000  ;
         1.00000   ,        0.00000  ;
         0.25000   ,        0.43300  ;
		 0.75000   ,		0.43300  ;
		 0.50000   , 		0.86600  ];
%
% Elements
%
global elements
elements = [
     1   ,     2   ,     4   ; 
     2   ,     5   ,     4 	 ;
	 2 	 ,	   3   ,     5   ;
	 4   ,     5   ,     6   ]; 

%
% heat (Para cada elemento)
%
global heat 
heat = [
	10 ;
	10 ;
	10 ;
	10 ];

%
% Fuentes puntuales (Pero no en un nodo especifico)
%

global fuentespuntuales
fuentespuntuales = [ ] ;

%
% Fixed Nodes
%
fixnodes = [
	  1  ,     100.00000  ;
      2  ,     100.00000  ;
	  3  ,	   100.00000  ];
%
% Point loads
%
pointload = [ ] ;
%
%Uniform Side loads
%
sideload = [ 
	 1  ,     4  ,   100.00000  ;
	 4  ,	  6  ,   100.00000 ];
