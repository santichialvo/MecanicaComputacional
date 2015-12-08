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
         0.00000   ,         0.00000  ;
         6.00000   ,        0.00000  ;
         8.00000   ,        3.00000  ;
         2.00000   ,        3.00000 ] ; 
%
% Elements
%
global elements
elements = [
      1   ,      2   ,      3   ,      4  ] ; 


%
% heat
%
global denss 
denss = [
	1.0 ] ;

%
%
% Fuentes puntuales (Pero no en un nodo especifico)
%

global fuentespuntuales
fuentespuntuales = [
	1	,	2	,	3	,	4, 	4 ,	 1.5,	 5 ] ;


% Fixed Nodes
%
fixnodes = [
      1  ,     0.00000  ;
      2  ,     0.00000  ;
      5  ,   100.00000  ;
      6  ,     0.00000  ;
      8  ,   100.00000  ;
      9  ,   100.00000  ] ;
%
% Punctual Fluxes
%
pointload = [ ] ;
%
% Side loads
%
sideload = [ ];
