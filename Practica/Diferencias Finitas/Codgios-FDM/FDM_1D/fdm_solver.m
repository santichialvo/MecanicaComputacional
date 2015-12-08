function [phi,Rg] = fdm_solver(data,Kg,Rg)
%
%    [phi,Rg] = fdm_solver(data,Kg,Rg)
%
%
%   Rutina SOLVER de resolucion del sistema de ecuaciones
%   
%   Type_solver = 0 ---> metodo directo con un parametro de
%                        parametro de relajacion "relax"
%                        grado de implicitud (1/2 Cranck Nicholson) "alpha" (use >0)
%               = 1 ---> Line search
%               = 2 ---> Explicito - Forward Euler
%               = 3 ---> GMRES   
%               = 4 ---> QMR (quasi minimum residual) 
%

%disp(' at SOLVER ')
%keyboard;pause

% desempaqueto datos
relax = data.param.relax;
fixa = data.fixa(:,1);
phi = data.state;
ndf = data.param.ndf;
scaling = data.param.scaling;

if scaling, % si el scaling esta activo divide cada fila por la suma de los valores absolutos de los elementos de cada fila
    scalev = sum(abs(Kg'))';
    Rg   = Rg ./ scalev;
    Kg   = diag(scalev)\Kg;
end

if strcmp(data.param.type_solver,'implicit')
    free = find(fixa==0);
% selecciono solo las filas y columnas libres
    Rg = Rg(free);
    Kg = Kg(free,free);   
% resuelvo
    dphi = -Kg\Rg;
    phiv = m2v(phi);
% actualizo usando relax como un factor que sirve para poder converger en casos fuertemente no lineales
    phiv(free) = phiv(free)+ relax*dphi;
    dphi = relax*dphi;
    phi  = v2m(phiv,ndf);    
else
    error(' Not available other than IMPLICIT ')
end
