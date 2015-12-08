%
%  version de assemble vectorizada
%
%  esto significa que se procesan todos los nodos de la grilla al mismo tiempo en una sola linea de comandos 
%

%conductivity = 1+mean(state);
numnp = length(xnod);

% arreglo de nodos interiores
indx = (2:numnp-1);

% calculo de aproximaciones a las distintas derivadas involucradas
% calculo de las diferencias hacia adelante (fwd), hacia atras (bkw) y centrada (cen) de las coordenadas nodales
dx_fwd(indx,1) = (xnod(indx+1)-xnod(indx));
dx_bkw(indx,1) = (xnod(indx)-xnod(indx-1));
dx_cen(indx,1) = (xnod(indx+1)-xnod(indx-1));

% calculo de las diferencias hacia adelante (fwd), hacia atras (bkw) y centrada (cen) de la variable dependiente o incognita
df_fwd(indx,1) = (state(indx+1)-state(indx));
df_bkw(indx,1) = (state(indx)-state(indx-1));
df_cen(indx,1) = (state(indx+1)-state(indx-1));

% idem pero para los nodos extremos que tienen un tratamiento particular porque le falta algun vecino
dx_fwd(1,1) = (xnod(2)-xnod(1));
dx_bkw(numnp,1) = (xnod(numnp)-xnod(numnp-1));

df_fwd(1,1) = (state(2)-state(1));
df_bkw(numnp,1) = (state(numnp)-state(numnp-1));

% calculo del residuo de la ecuacion
% termino de difusion o conduccion termica 
R(indx,1) = conductivity * (df_fwd(indx)./dx_fwd(indx) - df_bkw(indx)./dx_bkw(indx))./(0.5*dx_cen(indx));
% termino fuente + termino temporal
R(indx,1) = R(indx,1) + source(indx) - rho*Cp/Dt * (state(indx)-state_old(indx));

% calculo de la matriz (recordar que K_{ij} = dR_i/dT_j) donde T es el state (incognita)
% contribucion de la conduccion termica
K_i0(indx,1) = conductivity * (-1 ./dx_fwd(indx) - 1./dx_bkw(indx)) ./(0.5*dx_cen(indx));
K_iu(indx,1) = conductivity * (1 ./dx_bkw(indx)) ./ (0.5*dx_cen(indx));
K_id(indx,1) = conductivity * (1 ./dx_fwd(indx)) ./ (0.5*dx_cen(indx));

% contribucion del termino temporal 
K_i0(indx,1) = K_i0(indx,1) - rho*Cp/Dt;

% las contribuciones van a parar a 3 vectores, 
% (*) rowg : filas 
% (*) colg : columnas
% (*) coeg : coeficiente
% esto se lo conoce como formato CSR y nos dice donde se ubica cada elemento no cero de una matriz rala (sparse)

rowg = []; colg = []; coeg=[];
rows = indx'; cols = rows; coef = K_i0(indx,1);
rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];

% segun el tipo de fijaciones incluye al o a los nodos extremos en la carga
% para el nodo a izquierda
if fixa(1,1)==1
% si el nodo a la izquierda esta fijo
    rows = indx(2:end)'; cols = rows-1; coef = K_iu(indx(2:end));
    rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];
    else
% si esta libre 
    rows = indx(1:end)'; cols = rows-1; coef = K_iu(indx(1:end));
    rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];
end

% para el nodo a derecha
if fixa(numnp,1)==1
% si el nodo a la derecha esta fijo
    rows = indx(1:end-1)'; cols = rows+1; coef = K_id(indx(1:end-1));
    rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];
    else
% si esta libre
    rows = indx(1:end)'; cols = rows+1; coef = K_id(indx(1:end));
    rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];
end

% Contribucion al residuo y la matriz de los nodos extremos
% Expecificamente para el nodo a la izquierda
indx = 1;
if fixa(indx,1)==1
% si esta fijo
    R(indx,1) = 0;
    K_i0 = 1;
    rows = [indx]; cols = [rows]; coef = [K_i0];
    rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];
else
% si esta libre
    R(indx,1) = conductivity * (state(indx+2,1)-state(indx,1))/(2*(xnod(indx+2)-xnod(indx+1))) - fixa(indx,2);

    K_i0 = conductivity * (-1)/(2*(xnod(indx+2)-xnod(indx+1)));
    K_id = conductivity * (+1)/(2*(xnod(indx+2)-xnod(indx+1)));

    rows = [indx]; cols = [rows]; coef = [K_i0];
    rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];
    
    rows = [indx]; cols = [rows+2]; coef = [K_id];
    rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];    
end

% Especificamente para el nodo a la derecha
indx = numnp;
if fixa(indx,1)==0
% si esta libre
    R(indx,1) = conductivity * (state(indx,1)-state(indx-2,1))/(2*(xnod(indx-1)-xnod(indx-2))) - fixa(indx,2);

    K_i0 = conductivity * 1/(2*(xnod(indx-1)-xnod(indx-2)));
    K_iu = conductivity *(-1)/(2*(xnod(indx-1)-xnod(indx-2)));

    rows = [indx]; cols = [rows]; coef = [K_i0];
    rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];

    rows = [indx]; cols = [rows-2]; coef = [K_iu];
    rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];
else
% si esta fijo
    R(indx,1) = 0;
    K_i0 = 1;
    rows = [indx]; cols = [rows]; coef = [K_i0];
    rowg = [rowg;rows]; colg = [colg;cols]; coeg = [coeg;coef];
end
