function [Je,ecx,ecy,N] = ffs_triangulo_naturales(x_v,y_v)

syms Xi Eta;

N = sym(zeros(1,3));
dN_dXi = N;
dN_dEta = N;

N(1) = 1 - Xi - Eta;
N(2) = Xi;
N(3) = Eta;

for i=1:3
    dN_dXi(i) = diff(N(i),Xi);
    dN_dEta(i) = diff(N(i),Eta);
end

Je = [dN_dXi ; dN_dEta] * [x_v' y_v'];

ecx = dot(N,x_v);
ecy = dot(N,y_v);


end