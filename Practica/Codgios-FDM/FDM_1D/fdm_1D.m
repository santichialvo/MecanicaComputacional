%
% script para un codigo preliminar de diferencias finitas
%

if(exist('initia')==0),
    disp('Enter variable INITIA ')
    disp(' initia == 0 ---> if is a continuation of an older run  ')
    disp(' initia ~= 0 ---> if started from the beginning  ')
    initia = input(' Initia = ')
end

% genera los puntos de la grilla 
% origen (x0) , longitud (Lx) y numero de puntos (Nx)
x0 = 0; Lx = 1; Nx = 100;

% distribuye los nodos uniformente o no segun quiera el usuario
if 0
    psi = (0:Nx)'/Nx;
    xnod = psi.^2*Lx+x0;
else
    %xnod = (0:Nx)'/Nx*Lx.*rand(Nx+1,1)+x0;
    %xnod = sort(xnod);
    xnod = (0:Nx)'/Nx*Lx+x0;
end

% ingreso de los parameteros
dt = 1e15; %1e-3;            % paso de tiempo
ntime = 10; %200;        % numero de pasos de tiempo
ttime = 0;         % clock inicial

rho = 1;           % densidad
Cp = 1;            % calor especifico a presion constante
conductivity = 1;  % conductividad termica

ndf = 1;           % numero de grados de libertad por nodo (prob. escalar ndf=1)
maxit = 15;         % numero maximo de iteraciones por cada iteracion del Newton
tol_newton = 1e-10;% tolerancia de convergencia del Newton

scaling = 1;       % llave para hacer o no el scaling de filas en el sistema lineal
nfreqplot = 10;     % frecuencia de ploteo

% external fields
numnp = size(xnod,1);  % numero de nodos de la grilla 
% termino fuente nodal
%source = ones(numnp,1);  
%source = 0*xnod.^3;
source = zeros(numnp,1)+0*300*((xnod>0.25)&(xnod<0.75));  

% coordenadas minima y maxima en la unica direccion del problema (1D)
xmin = min(xnod);
xmax = max(xnod);
tol  = 1e-6;

% fijaciones
fixa = zeros(numnp,2);  % de entrada todos los nodos son libres (fixa(:,1)=0)
nodes_lef = find(abs(xnod-xmin)<tol); % marco el nodo que esta en el extremo izquierdo 
nodes_rig = find(abs(xnod-xmax)<tol); % idem con el derecho

fixa(nodes_lef,:) = [0,1];  % en este caso el nodo a izquierda tiene temperatura libre con flujo impuesto y unitario (q*n=1)
fixa(nodes_rig,:) = [1,0];  % el nodo a derecha tiene temperatura fija en 0

fixa(nodes_lef,:) = [1,0];  % el nodo a izquierda tiene temperatura fija en 1 
fixa(nodes_rig,:) = [0,1];  % en este caso el nodo a derecha tiene temperatura libre con flujo impuesto y unitario (q*n=1)

% initial state
if initia
    state = sin(pi*(xnod-x0)/Lx);         % inicialmente la temperatura de todos los nodos es 0 
    for idf=1:ndf           % aqui se actualiza la temperatura inicial de aquellos nodos del contorno que tienen temperatura impuesta
        nofree = find(fixa(:,1)~=0)
        state(nofree,idf) = fixa(nofree,2);
    end
    state_old = state;      % aqui se copia el estado inicial como estado anterior para hacer el computo no estacionario
    data.state = state;     % se agrega los estados a la estructura "data"
    data.state_old = state_old;
    data.initial_state = state;
end

% handle data  (sirve para empaquetar (packaging) los datos en la estrutura "data")
data.param.dt = dt;
data.param.rho = rho;
data.param.Cp = Cp;
data.param.conductivity = conductivity;
data.param.ntime = ntime;
data.param.type_solver = 'implicit';
data.param.relax = 1;
data.param.ndf = ndf;
data.param.scaling = scaling;
data.param.nfreqplot = nfreqplot;
data.xnod = xnod;
data.fixa = fixa;
data.source = source;

% si uno quiere puede armar un vector de tiempos de calculo, sino podemos usar ntime y dt 
% aqui en el ejemplo esta siendo usado un vector de tiempos
 
vtime= [(1:1e-5:1e-4),(2e-4:1e-4:1e-3),(1e-2:1e-2:1)];
vtime= [(0:1e-7:1e-5)];
%ntime = length(vtime),

% lazo en el tiempo
for itime=1:ntime
    check_conv = 1;
    iter = 1;
    data.state_old = data.state;

    ttime = ttime+dt;    
    %ttime = vtime(itime);

    % lazo del Newton
    while check_conv
        % ensamblaje, construccion de la matriz y el residuo
        [K,R] = fdm_assemble(data);
        % resolucion del sistema lineal
        [phi_new,R] = fdm_solver(data,K,R);
        % update solution
        data.state = phi_new;
        % convergence check
        disp([' time step = ' num2str(itime) ' t= ' num2str(ttime) ' | R | = ' num2str(norm(R))])
        check_conv = (norm(R)>tol_newton)&(iter<=maxit);
        iter = iter+1;
        %keyboard;pause
    end

    % plot (graficacion)
    fdm_plot(data,itime)
end

