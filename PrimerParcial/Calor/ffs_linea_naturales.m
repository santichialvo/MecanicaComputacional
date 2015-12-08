function [Je,ecx,N] = ffs_linea_naturales(x_v)

syms Xi;

N = sym(zeros(1,2));
dN_dXi = N;

N(1) = 1/2 * (1 - Xi);
N(2) = 1/2 * (1 + Xi);

for i=1:2
    dN_dXi(i) = diff(N(i),Xi);
end

Je = dN_dXi * x_v';

ecx = dot(N,x_v);


end
