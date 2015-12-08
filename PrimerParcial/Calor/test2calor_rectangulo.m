%=======================================================================
% MAT-femcCal 1.0  - MAT-femCal is a learning tool for undestanding 
%                    the Finite Element Method with MATLAB and GiD
%=======================================================================
% PROBLEM TITLE = Titulo del problema
%
%  Material Properties
%
  kx =              2.00000 ;
  ky =              2.00000 ;
%
% Coordinates
%
global coordinates
coordinates = [
         0.00000   ,        0.00000  ;
         5.00000   ,        0.00000  ;
         5.00000   ,        5.00000  ;
         0.00000   ,        5.00000  ] ; 
%
% Elements
%
global elements
elements = [
      1   ,      2   ,      3   ,      4  ] ; 


%
% heat
%
global heat 
heat = [
	1.2 ] ;

%

%
% Fuentes puntuales (Pero no en un nodo especifico)
%

global fuentespuntuales
fuentespuntuales = [
	1	,	2	,	3	,	4, 	1 ,	 1,	 5 ] ;


% Fixed Nodes
%
fixnodes = [
      2  ,     100.00000  ;
      3  ,     100.00000  ] ;
%
% Punctual Fluxes
%
pointload = [ ] ;
%
% Side loads
%
sideload = [ 
		1  ,     4  ,   2.00000  ];
