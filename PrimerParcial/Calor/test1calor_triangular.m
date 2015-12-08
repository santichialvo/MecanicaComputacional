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
         0.00000   ,        5.00000  ;
         5.00000   ,        5.00000  ] ; 
%
% Elements
%
global elements
elements = [
     1   ,     2   ,     3   ; 
     2   ,     4   ,     3 	 ] ; 

%
% heat (Para cada elemento)
%
global heat 
heat = [
	1.2 ;
	1.2 ] ;

%
% Fuentes puntuales (Pero no en un nodo especifico)
%

global fuentespuntuales
fuentespuntuales = [
	1	,	2	,	3	,	1,	1,	5 ] ;

%
% Fixed Nodes
%
fixnodes = [
	  2  ,     100.00000  ;
      4  ,     100.00000  ] ;
%
% Point loads
%
pointload = [ ] ;
%
%Uniform Side loads
%
sideload = [ 
	 3  ,     1  ,   2.00000  ];

