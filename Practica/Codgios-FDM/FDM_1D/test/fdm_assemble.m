function [K,R] = fdm_assemble(data)
%
%   [K,R] = fdm_assemble(data)
%

% handle data ( desempaquetamos los datos)
Dt = data.param.dt;
rho = data.param.rho;
Cp = data.param.Cp;
conductivity = data.param.conductivity;
ntime = data.param.ntime;
xnod = data.xnod;
state = data.state;
state_old = data.state_old;
source = data.source;
fixa = data.fixa;
type_solver = data.param.type_solver;

if strcmp(type_solver,'implicit');
    fdm_assemble_5;
elseif strcmp(type_solver,'explicit');
    fdm_assemble_explicit;
elseif strcmp(type_solver,'analytic');
    fdm_assemble_analytic;    
end

% gather contributions (es la rutina encargada de juntar todas las contribuciones en un sistema lineal global)
K = sparse(rowg,colg,coeg);
