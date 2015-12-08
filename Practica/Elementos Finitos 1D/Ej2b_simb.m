% Resolucion del ejercicio 2b de la guia de elementos finitos 1D
% COORDENADAS CARTESIANAS - INTEGRACION SIMBOLICA
% PDE a resolver: (d2phi_dx2) + phi + x = 0
% Cond. de borde: phi(0) = 0; dphi_dx(1)=1;
% [phi,phi_ex] = Ej2b_simb(xnode,sp)
% Parametros de entrada: 
%   xnode: malla unidimensional
%   sp: bandera para trabajar o no con matrices sparse
%       sp != 0 --> matriz sparse
%       sp == 0 --> matriz llena
% Parametros de salida:
%   phi: aproximacion por FEM
%   phi_ex: solucion analitica
%   err: error de aproximacion
function [phi,phi_ex,err] = Ej2b_simb(xnode,sp)
    syms x
    phi_anal = (2/cos(1))*sin(x) - x;
    Nnod = length(xnode);
    Nelem = Nnod - 1;
    phi_left = 0; % cond. Dirichlet
    Kele = zeros(Nelem,2,2); % Nelem matrices de 2x2
    fele = zeros(Nelem,2); % Nelem vectores de 1x2

    %ensamble de cada elemento: matriz y termino derecho
    for iele=1:Nelem
        xi = xnode(iele);
        xj = xnode(iele+1);
        h = xj-xi;
        N(1) = (h-(x-xi))/h;
        N(2) = (x-xi)/h;
        dNdx = [-1/h 1/h]; %puede hacerse diff 
        for il=1:2
            for jl=1:2
                integ = dNdx(il)*dNdx(jl) - N(il)*N(jl);
                Kele(iele,il,jl) = double(int(integ,x,xi,xj));
            end
            integ2 = N(il)*x;
            fele(iele,il) = double(int(integ2,x,xi,xj));
        end
    end
    
    if ~sp
        Kg = zeros(Nnod,Nnod);
    else
        rows = [];
        cols = [];
        coef = [];
    end
    fg = zeros(Nnod,1);

    %ensamblo la matriz global y el residuo global
    for iele=1:Nelem
        indx_global = [iele iele+1];
        %i_local(il)=1 -> i_global(ig) = iele;
        %j_local(jl)=2 -> j_global(jg) = iele+1;
        for il=1:2
            ig = indx_global(il);
            for jl=1:2
                jg = indx_global(jl);
                if sp
                    rows = [rows;ig];
                    cols = [cols;jg];    
                    coef = [coef;Kele(iele,il,jl)];
                else
                    Kg(ig,jg) = Kg(ig,jg) + Kele(iele,il,jl);
                end
            end
            fg(ig) = fg(ig) + fele(iele,il);
        end
    end
    if sp
        Kg = sparse(rows,cols,coef);
    end

    % CB Dirichlet: phi(x=0) = 0
    Kg(1,:) = 0;
    Kg(1,1) = 1;
    fg(1) = phi_left;
    
    % CB Neumann: dphi_dx(1) = 1
    fg(Nnod) = fg(Nnod) + 1;

    % Resuelvo el sistema de ecuaciones
    phi = Kg\fg;
    
    % Exacta, error y ploteo
    phi_ex = subs(phi_anal,x,xnode);
    err = norm(phi-phi_ex');
    figure(1);clf;plot(xnode,phi,'o-',xnode,phi_ex,'r');
end