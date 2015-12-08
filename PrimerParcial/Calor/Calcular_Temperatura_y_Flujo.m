function [Te,qx,qy] = Calcular_Temperatura_y_Flujo(x_c,y_c,x_v,y_v,T,k)

% x_c e y_c --> punto a calcular
% x_v e y-v --> vertices elemento
% T --> temperatura en los tres puntos

len = length(x_v);

if (len == 3)
    [Je,ecx,ecy,N] = ffs_triangulo_naturales(x_v,y_v);
else
    [Je,ecx,ecy,N] = ffs_rectangulo_naturales(x_v,y_v);
end

%eq1 = ecx == xc(1)
%eq2 = ecy == xc(2)
%S = solve(eq1,eq2);

x_c = 0.34642032332563510392609699769053;
y_c = 0.34642032332563510392609699769053;

syms Eta Xi;
dN_dXi = diff(N,Xi);
dN_dEta = diff(N,Eta);

for i = 1:len
    Ne(i) = subs(N(i),x_c,Xi);
    Ne(i) = subs(Ne(i),y_c,Eta);
    
    dNe_dXi(i) = subs(dN_dXi(i),x_c,Xi);
    dNe_dXi(i) = subs(dNe_dXi(i),y_c,Eta);
    
    dNe_dEta(i) = subs(dN_dEta(i),x_c,Xi);
    dNe_dEta(i) = subs(dNe_dEta(i),y_c,Eta);
end

Te = double(dot(Ne,T));

dx_dXi = dot(x_v,diff(N,Xi));
%dx_dEta = dot(x_v,diff(N,Eta));
%dy_dXi = dot(y_v,diff(N,Xi));
dy_dEta = dot(y_v,diff(N,Eta));

qx = sym(zeros(1,1));
qy = sym(zeros(1,1));
for i = 1:len
    qx = qx + dNe_dXi(i)*(1/dx_dXi)*T(i);
    qy = qy + dNe_dEta(i)*(1/dy_dEta)*T(i);
end

qx = double(-k*qx);
qy = double(-k*qy);


end

