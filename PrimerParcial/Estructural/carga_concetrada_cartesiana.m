function F = carga_concetrada_cartesiana(Qx,Qy,N,x_c,y_c,e)

% e=0 rectangulo

syms x y;

N=subs(N,x,x_c);
N=subs(N,y,y_c);

F(1) = Qx * N(1);
F(2) = Qy * N(1);
F(3) = Qx * N(2);
F(4) = Qy * N(2);
F(5) = Qx * N(3);
F(6) = Qy * N(3);

if (e == 0)
    F(7) = Qx * N(4);
    F(8) = Qy * N(4);
end


end

