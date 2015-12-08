function F = carga_distribuida_borde_cartesiano(N,px,py,t,len)
% N = Las dos ff que corresponden a ese borde
% px = Carga en direccion x 
% py = Carga en direccion y
% t = espesor
% len = Longitud del borde

syms x y;

F(1) = int(N(1)*px,y,0,len);
F(2) = int(N(1)*py,x,0,len);
F(3) = int(N(2)*px,y,0,len);
F(4) = int(N(2)*py,x,0,len);

F = F.*t;

end

