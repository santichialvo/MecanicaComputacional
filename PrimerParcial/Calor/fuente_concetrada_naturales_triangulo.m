function F = fuente_concetrada_naturales_triangulo(Q,x_c,y_c,e)

% e=0 rectangulo

if (e == 0)
    [Je,ecx,ecy,N]=ffs_triangulo_naturales(x_v,y_v);
else
    [Je,ecx,ecy,N]=ffs_rectangulo_naturales(x_v,y_v);
end

syms x y;

N=subs(N,x,x_c);
N=subs(N,y,y_c);

F(1) = Q * N(1);
F(2) = Q * N(2);
F(3) = Q * N(3);

if (e == 0)
    F(4) = Q * N(4);
end


end