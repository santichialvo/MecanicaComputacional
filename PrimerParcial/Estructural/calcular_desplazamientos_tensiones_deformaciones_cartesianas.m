function [des,defs,ten] = calcular_desplazamientos_tensiones_deformaciones_cartesianas(x_v,y_v,x_c,y_c,u,v,def,E,pois)

len = length(x_v);
syms x y;

if (len == 3)
    [N,A] = ffs_triangulo_cartesiano(x_v,y_v);
else
    [N,A] = ffs_rectangulo_cartesiano(x_v,y_v);
end

dNdx = diff(N,x);
dNdy = diff(N,y);

N(:) = subs(N(:),x,x_c);
N(:) = subs(N(:),y,y_c);
dNdx(:) = subs(dNdx(:),x,x_c);
dNdx(:) = subs(dNdx(:),y,y_c);
dNdy(:) = subs(dNdy(:),x,x_c);
dNdy(:) = subs(dNdy(:),y,y_c);

des(1) = double(dot(N,u));
des(2) = double(dot(N,v));

%%%%%%%%%%%%%%%%%%%

defx = dot(dNdx,u);
defy = dot(dNdy,v);
defxy = dot(dNdx,v) + dot(dNdy,u);

defs = [double(defx) double(defy) double(defxy)];

D = matriz_constitutiva_def_y_tension_plana(E,pois,def);

ten_s = D * defs';
ten = double(ten_s);

end
