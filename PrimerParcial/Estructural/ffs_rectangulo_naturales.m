function [Je,ecx,ecy,N] = ffs_rectangulo_naturales(x_v,y_v)

syms Xi Eta;

N = sym(zeros(1,4));
xi = [-1 1 1 -1];
eta = [-1 -1 1 1];
dN_dXi = N;
dN_dEta = N;

for i=1:4
    N(i) = 1/4 * (1 + xi(i)*Xi) * (1 + eta(i)*Eta);
    dN_dXi(i) = diff(N(i),Xi);
    dN_dEta(i) = diff(N(i),Eta);
end

Je = [dN_dXi ; dN_dEta] * [x_v' y_v'];

ecx = dot(N,x_v);
ecy = dot(N,y_v);


end

