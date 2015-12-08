%% Matriz elemental del operador laplaciano. Coordenadas cartesianas. Elemento rectangular

function [uv1,u2,v2] = rectangulos_cartesianas_elasticidad(u,v,x_n,y_n,x_v,y_v)

%% Modo 1

syms x y;
de = [u(1),v(1),u(2),v(2),u(3),v(3),u(4),v(4)]'; %Desplazamientos de cada vertice

P = [1 x_n y_n x_n*y_n 0 0 0 0 ; 0 0 0 0 1 x_n y_n x_n*y_n]; %Cordenada del nodo donde quiero saber los datos
%Ce = [1 x_v(1) y_v(1) 0 0 0; 0 0 0 1 x_v(1) y_v(1); 1 x_v(2) y_v(2) 0 0 0; 0 0 0 1 x_v(2) y_v(2); 1 x_v(3) y_v(3) 0 0 0; 0 0 0 1 x_v(3) y_v(3)]; %Cordenadas de cada vertice
Ce_s = sym(zeros(0,4*2));

for i=1:4
    C = [1 x_v(i) y_v(i) x_v(i)*y_v(i) 0 0 0 0; 0 0 0 0 1 x_v(i) y_v(i) x_v(i)*y_v(i)];
    Ce_s = [Ce_s ; C];
end

C = double(Ce_s);

alpha = C\de; % alpha1,a2,a3,a4,a5,a6
uv1 = P*alpha; %Desplazamientos en el nodo 

%% Modo 2

[N,A] = ffs_rectangulo_cartesiano(x_v,y_v);

for e=1:4
    N(e)=subs(N(e),x,x_n);
    N(e)=subs(N(e),y,y_n);
end

u2 = double(dot(N,u));
v2 = double(dot(N,v));

end
