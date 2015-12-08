function F = carga_distribuida_elemento_cartesiano(e,q,t,x_v,y_v)
% e = 0 rectangulo
% e = 1 triangulo
% q = [qx qy]

if (e == 0)
    [N,A] = ffs_rectangulo_cartesiano(x_v,y_v);
    Ne = sym(zeros(0,2));
    for i=1:4
        N1 = [N(i) 0 ; 0 N(i)];
        Ne = [N1 ; Ne];
    end
    F = A * Ne * q' * t;
else
    [N,A] = ffs_triangulo_cartesiano(x_v,y_v);
    Ne = sym(zeros(0,2));
    for i=1:3
        N1 = [N(i) 0 ; 0 N(i)];
        Ne = [N1 ; Ne];
    end
    F = A * Ne * q' * t;
end

end

