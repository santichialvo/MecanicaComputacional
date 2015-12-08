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
         0.00000   ,         0.00000  ;
         40.00000   ,        0.00000  ;
         10.00000   ,        10.00000  ;
         0.00000   ,         20.00000  ;
        10.00000   ,         0.00000  ;
         0.00000   ,        10.00000  ;
         5.00000   ,        10.00000  ;
        10.00000   ,         5.00000  ;
        10.00000   ,        10.00000  ] ; 
%
% Elements
%
global elements
elements = [
      1   ,      2   ,      3   ,      4   ; 
      5   ,      8   ,      4   ,      3   ; 
      4   ,      7   ,      6   ,      2   ; 
      8   ,      9   ,      7   ,      4   ] ; 


%
% heat
%
global heat 
heat = [
	3 ;
	0 ;
	0 ;
	3 ] ;

%
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
