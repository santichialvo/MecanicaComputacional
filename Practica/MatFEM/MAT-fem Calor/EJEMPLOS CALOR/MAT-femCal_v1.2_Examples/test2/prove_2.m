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
 heat=              0.00000 ;
%
% Coordinates
%
global coordinates
coordinates = [
         0.00000   ,         0.00000  ;
         0.00000   ,         0.50000  ;
         0.50000   ,         0.00000  ;
         0.50000   ,         0.50000  ;
         0.00000   ,         1.00000  ;
         1.00000   ,         0.00000  ;
         1.00000   ,         0.50000  ;
         0.50000   ,         1.00000  ;
         1.00000   ,         1.00000  ;
         1.50000   ,         0.00000  ;
         1.50000   ,         0.50000  ;
         1.50000   ,         1.00000  ;
         2.00000   ,         0.00000  ;
         2.00000   ,         0.50000  ;
         2.00000   ,         1.00000  ;
         2.50000   ,         0.00000  ;
         2.50000   ,         0.50000  ;
         2.50000   ,         1.00000  ] ; 
%
% Elements
%
global elements
elements = [
      3   ,      4   ,      1   ; 
      4   ,      2   ,      1   ; 
      6   ,      7   ,      3   ; 
      7   ,      4   ,      3   ; 
     10   ,     11   ,      6   ; 
     11   ,      7   ,      6   ; 
     13   ,     14   ,     10   ; 
     14   ,     11   ,     10   ; 
     16   ,     17   ,     13   ; 
     17   ,     14   ,     13   ; 
      4   ,      8   ,      2   ; 
      8   ,      5   ,      2   ; 
      7   ,      9   ,      4   ; 
      9   ,      8   ,      4   ; 
     11   ,     12   ,      7   ; 
     12   ,      9   ,      7   ; 
     14   ,     15   ,     11   ; 
     15   ,     12   ,     11   ; 
     17   ,     18   ,     14   ; 
     18   ,     15   ,     14   ] ; 
%
% Fixed Nodes
%
fixnodes = [
      1  ,     0.00000  ;
      2  ,     0.00000  ;
      5  ,     0.00000  ] ;
%
% Punctual Fluxes
%
pointload = [ ] ;
%
% Side loads
%
sideload = [
     16  ,     17  ,   -1.00000   ;
     17  ,     18  ,   -1.00000  ];

