function [Ke,Be] = matriz_rigidez_rectangulos_cartesianos(E,v,x_v,y_v,t,def)

% Ke . de = Fe
syms x y;

[N,Ae] = ffs_rectangulo_cartesiano(x_v,y_v);

%Be1 = [diff(N(1),x) 0 diff(N(2),x) 0 diff(N(3),x) 0; 0 diff(N(1),y) 0 diff(N(2),y) 0 diff(N(3),y); diff(N(1),y) diff(N(1),x) diff(N(2),y) diff(N(2),x) diff(N(3),y) diff(N(3),x)];

Be = sym(zeros(4,0));

for i=1:4
    B = [diff(N(i),x) 0; 0 diff(N(i),y); diff(N(i),y) diff(N(i),x)];
    Be = [Be B];
end

D = matriz_constitutiva_def_y_tension_plana(E,v,def);

a = x_v(2) - x_v(1);
b = y_v(3) - y_v(2);

Ke_s = t*int(int(Be' * D * Be,x,0,a),y,0,b);
Ke = double(Ke_s);
end

