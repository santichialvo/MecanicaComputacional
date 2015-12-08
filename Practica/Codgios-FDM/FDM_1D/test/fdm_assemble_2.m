%
%  esta implementacion es para ver simplemente lo lento que se puede
%  transformar la simulacion si uno no toma recaudo de la vectorizacion
%
%  ver fdm_assemble_1 para una version vectorizada
%

numnp = length(xnod);
indx = (2:numnp-1);

dx_fwd(indx,1) = (xnod(indx+1)-xnod(indx));
dx_bkw(indx,1) = (xnod(indx)-xnod(indx-1));
dx_cen(indx,1) = (xnod(indx+1)-xnod(indx-1));

df_fwd(indx,1) = (state(indx+1)-state(indx));
df_bkw(indx,1) = (state(indx)-state(indx-1));
df_cen(indx,1) = (state(indx+1)-state(indx-1));

dx_fwd(1,1) = (xnod(2)-xnod(1));
dx_bkw(numnp,1) = (xnod(numnp)-xnod(numnp-1));

df_fwd(1,1) = (state(2)-state(1));
df_bkw(numnp,1) = (state(numnp)-state(numnp-1));

for kn=indx
    R(kn,1) = conductivity * (df_fwd(kn)/dx_fwd(kn) - df_bkw(kn)/dx_bkw(kn))/(0.5*dx_cen(kn));
    R(kn,1) = R(kn,1) + source(kn) - rho*Cp/Dt * (state(kn)-state_old(kn));

    K_i0(kn,1) = conductivity * (-1/dx_fwd(kn) - 1/dx_bkw(kn)) /(0.5*dx_cen(kn));
    K_i0(kn,1) = K_i0(kn,1) - rho*Cp/Dt;
    K_iu(kn,1) = conductivity * (1/dx_bkw(kn)) /(0.5*dx_cen(kn));
    K_id(kn,1) = conductivity * (1/dx_fwd(kn)) /(0.5*dx_cen(kn));
end

rowg = []; colg = []; coeg=[];
rows = indx'; cols = rows; coef = K_i0(indx,1);
rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];

rows = indx(2:end)'; cols = rows-1; coef = K_iu(indx(2:end));
rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];

rows = indx(1:end-1)'; cols = rows+1; coef = K_id(indx(1:end-1));
rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];

indx = 1;
R(indx,1) = conductivity * (df_fwd(indx)./dx_fwd(indx)) ./ (dx_fwd(indx));
R(indx,1) = R(indx,1) + source(indx) - rho*Cp/Dt * (state(indx)-state_old(indx));

K_i0 = conductivity * (-1/dx_fwd(indx) ) / (dx_fwd(indx));
K_i0 = K_i0 - rho*Cp/Dt;
K_id = conductivity * (1/dx_fwd(indx)) / (dx_fwd(indx));

rows = [indx]; cols = [rows]; coef = [K_i0];
rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];

rows = [indx]; cols = [rows+1]; coef = [K_id];
rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];

indx = numnp;
R(indx,1) = conductivity * ...
    (-df_bkw(indx)/dx_bkw(indx)) / dx_bkw(indx);
R(indx,1) = R(indx,1) + source(indx) - rho*Cp/Dt * (state(indx)-state_old(indx));

K_i0 = conductivity * (- 1/dx_bkw(indx)) / dx_bkw(indx);
K_i0 = K_i0 - rho*Cp/Dt;
K_iu = conductivity * (1/dx_bkw(indx)) / dx_bkw(indx);

rows = [indx]; cols = [rows]; coef = [K_i0];
rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];

rows = [indx]; cols = [rows-1]; coef = [K_iu];
rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];
