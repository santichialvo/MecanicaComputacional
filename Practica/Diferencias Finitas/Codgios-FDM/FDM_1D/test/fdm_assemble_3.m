%
%  version vectorizada
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

R(indx,1) = conductivity * (df_fwd(indx)./dx_fwd(indx) - df_bkw(indx)./dx_bkw(indx))./(0.5*dx_cen(indx));
R(indx,1) = R(indx,1) + source(indx) - rho*Cp/Dt * (state(indx)-state_old(indx));

K_i0(indx,1) = conductivity * (-1 ./dx_fwd(indx) - 1./dx_bkw(indx)) ./(0.5*dx_cen(indx));
K_i0(indx,1) = K_i0(indx,1) - rho*Cp/Dt;
K_iu(indx,1) = conductivity * (1 ./dx_bkw(indx)) ./ (0.5*dx_cen(indx));
K_id(indx,1) = conductivity * (1 ./dx_fwd(indx)) ./ (0.5*dx_cen(indx));

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
