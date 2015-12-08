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
  heat=              3.00000 ;
%
% Coordinates
%
global coordinates
coordinates = [
         0.00000   ,        0.00000  ;
         2.00000   ,        0.00000  ;
         2.00000   ,        4.00000  ;
         0.00000   ,        4.00000  ] ; 
%
% Elements
%
global elements
elements = [
     1   ,     2   ,     4   ; 
     2   ,     3   ,     4   ] ; 
%
% Fixed Nodes
%
fixnodes = [ ] ;
%
% Point loads
%
pointload = [ ] ;
%
%Uniform Side loads
%
sideload = [ ];

