function [des,defs,ten] = calcular_desplazamientos_tensiones_deformaciones(x_v,y_v,x_c,y_c,u,v,def,E,pois)

len = length(x_v);

if (len == 3)
    [Je,ecx,ecy,N] = ffs_triangulo_naturales(x_v,y_v);
else
    [Je,ecx,ecy,N] = ffs_rectangulo_naturales(x_v,y_v);
end

Z = [0 0; 0 0];
Jinv = [inv(Je) Z ; Z inv(Je)]; 

%eq1 = ecx == xc(1)
%eq2 = ecy == xc(2)
%S = solve(eq1,eq2);

x_c = 0.2;
y_c = 0.5;

syms Eta Xi;
dN_dXi = diff(N,Xi);
dN_dEta = diff(N,Eta);

for i = 1:len
    Ne(i) = subs(N(i),Xi,x_c);
    Ne(i) = subs(Ne(i),Eta,y_c);
    
    dNe_dXi(i) = subs(dN_dXi(i),Xi,x_c);
    dNe_dXi(i) = subs(dNe_dXi(i),Eta,y_c);
    
    dNe_dEta(i) = subs(dN_dEta(i),Xi,x_c);
    dNe_dEta(i) = subs(dNe_dEta(i),Eta,y_c);
end

des(1) = double(dot(Ne,u));
des(2) = double(dot(Ne,v));

%%%%%%%%%%%%%%%%%%%

du_dXi = dot(dNe_dXi,u);
du_dEta = dot(dNe_dEta,u);
dv_dXi = dot(dNe_dXi,v);
dv_dEta = dot(dNe_dEta,v);
Jinv(:) = subs(Jinv(:),Eta,y_c);
Jinv(:) = subs(Jinv(:),Xi,x_c);

Res = Jinv * [du_dXi du_dEta dv_dXi dv_dEta]';

defx = Res(1);
defy = Res(4);
defxy = Res(2) + Res(3);

defs = [double(defx) double(defy) double(defxy)];

D = matriz_constitutiva_def_y_tension_plana(E,pois,def);

ten_s = D * defs';
ten = double(ten_s);

end

