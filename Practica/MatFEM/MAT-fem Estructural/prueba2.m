%=======================================================================
% MAT-fem 1.0  - MAT-fem is a learning tool for undestanding 
%                the Finite Element Method with MATLAB and GiD
%=======================================================================
% PROBLEM TITLE = Titulo del problema
%
%  Material Properties
%
  young =   210000000000.00000 ;
  poiss =              0.20000 ;
  denss = 0.00 ;
  pstrs =  1 ;
  thick =              0.10000 ;
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

