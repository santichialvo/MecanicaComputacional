function [G]=Intx(x,p1,p2,a1,a2)
%
%  Funcion requerida por Ej_2_2b para usar QUAD8
%

G= a1*(cos(p1*pi*x).*cos(p2*pi*x))+a2*(cos(p1*pi*x));
