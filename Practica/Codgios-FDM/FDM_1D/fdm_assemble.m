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

% llamamos a la rutina que hace el assemble prop. dicha
if 0
    if 0,  % version vectorizada
        fdm_assemble_3;
    else  % version no vectorizada
        fdm_assemble_2;
    end
else
    fdm_assemble_5;
end

% gather contributions (es la rutina encargada de juntar todas las contribuciones en un sistema lineal global)
K = sparse(rowg,colg,coeg);
