% Resolucion del ejercicio 2b de la guia de elementos finitos 1D
% COORDENADAS NATURALES - INTEGRACION NUMERICA
% PDE a resolver: (d2phi_dx2) + phi + x = 0
% Cond. de borde: phi(0) = 0; dphi_dx(1)=1;
% [phi,phi_ex] = Ej2b(xnode,sp)
% Parametros de entrada: 
%   xnode: malla unidimensional
%   sp: bandera para trabajar o no con matrices sparse
%       sp != 0 --> matriz sparse
%       sp == 0 --> matriz llena
% Parametros de salida:
%   phi: aproximacion por FEM
%   phi_ex: solucion analitica
%   err: error de aproximacion
function [phi,phi_ex,err] = Ej2b(xnode,sp)  
    % Cantidad de nodos y elementos
    Nnod = length(xnode);
    Nelem = Nnod - 1;
    
    % Condiciones de borde
    phi_left = 0;
    q = 1;
    
    % Funciones de forma para elemento master
    N = @(eta)[(1-eta)*0.5;(1+eta)*0.5];
    dN_deta = [-0.5,0.5];
    
    % Fuente
    x = @(eta,x1,x2)((1-eta)*0.5*x1+(1+eta)*0.5*x2);
    
    % 2 puntos de gauss
    % pospg = [-sqrt(3)/3 sqrt(3)/3];
    % pespg = [1 1];
    
    % 3 puntos de gauss
    pospg = [-sqrt(15)/5 0 sqrt(15)/5];
    pespg = [5/9 8/9 5/9];
    
    N_eval = N(pospg);
        
    Kele = zeros(Nelem,2,2);
    fele = zeros(Nelem,2);

    %ensamble de cada elemento: matriz y termino derecho
    for iele=1:Nelem
        xi = xnode(iele);
        xj = xnode(iele+1);
        h = xj-xi;
        J=h/2;
        x_eval = x(pospg,xi,xj);
        for il=1:2
            for jl=1:2
                acum1 = sum(pespg*dN_deta(il)*dN_deta(jl));
                acum2 = (pespg.*N_eval(il,:))*N_eval(jl,:)';
                Kele(iele,il,jl) = inv(J)*acum1-J*acum2;
            end
            acum3 = (pespg.*N_eval(il,:))*x_eval';
            fele(iele,il) = J*acum3;
        end
    end
    
    if sp
        rows = [];
        cols = [];
        coef = [];
    else
        Kg = zeros(Nnod,Nnod);
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
    fg(Nnod) = fg(Nnod) + q;

    % Resuelvo el sistema de ecuaciones
    phi = Kg\fg;
    
    % Exacta, error y ploteo
    phi_ex = (2/cos(1))*sin(xnode) - xnode;
    err = norm(phi-phi_ex');
    figure(1);clf;plot(xnode,phi,'o-',xnode,phi_ex,'r');
end