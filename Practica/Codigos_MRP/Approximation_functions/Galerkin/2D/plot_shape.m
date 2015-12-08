%
%  to generate a plot of each shape function
%

psi_i = [-1,1,1,-1];
eta_i = [-1,-1,1,1];
[psi_v,eta_v]=meshgrid(-1:0.1/2:1,-1:0.1/2:1);

for k=1:4,
    shape(:,:,k) = 1/4*(1+psi_i(k)*psi_v).*(1+eta_i(k)*eta_v);
end
