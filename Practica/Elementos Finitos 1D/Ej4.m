% Resolucion del ejercicio 4 de la guia de elementos finitos 1D
% COORDENADAS NATURALES - INTEGRACION NUMERICA
% PDE a resolver: -(d2T_dx2) - G = 0 (tomamos G = 5)
% Cond. de borde: T(0) = T(1) = 0
% Parametros de entrada: 
%   xnode: conjuntos de nodos
%   sp: bandera para trabajar o no con matrices sparse
%       sp != 0 --> matriz sparse
%       sp == 0 --> matriz llena
function [T,T_an,err] = Ej4(xnode,sp)
    % Cantidad de nodos y elementos
    Nnod = length(xnode);
    Nelem = Nnod - 1;
    
    T0 = 0; T1 = 0; % Condiciones de borde
    G = 5; % Fuente de calor
        
    % Funciones de forma para elemento master
    N = @(eta)[eta*(eta-1)*0.5,(1+eta).*(1-eta),eta*(eta+1)*0.5];
    dN_deta = @(eta)[eta-0.5,-2*eta,eta+0.5];
    
    % 2 puntos de gauss
    % pospg = [-sqrt(3)/3 sqrt(3)/3];
    % pespg = [1 1];
    
    % 3 puntos de gauss
    pospg = [-sqrt(15)/5 0 sqrt(15)/5];
    pespg = [5/9 8/9 5/9];
    
    N_eval = zeros(length(pospg),3);
    dN_eval = zeros(length(pospg),3);
    for pg=1:length(pospg)
        N_eval(pg,:) = N(pospg(pg));
        dN_eval(pg,:) = dN_deta(pospg(pg));
    end

    Kele = zeros(Nelem,3,3);
    fele = zeros(Nelem,3);
    % Ensamble de cada elemento: matriz y termino derecho
    for ele=1:Nelem
        h = xnode(ele+1)-xnode(ele);
        J = h/2;        
        for l=1:3
            for m=1:3
                acum1 = (pespg.*dN_eval(:,l)')*dN_eval(:,m);
                Kele(ele,l,m) = (1/J)*acum1;
            end
            acum2 = pespg*N_eval(:,l);
            fele(ele,l) = G*J*acum2;
        end
    end
    
    if sp
        rows = [];
        cols = [];
        coef = [];
    else
        Kg = zeros(2*Nnod-1,2*Nnod-1);
    end
    fg = zeros(2*Nnod-1,1);
    for iele=1:Nelem
        n = 2*iele-1;
        in_gl = [n n+1 n+2];
        if sp
            %i_local(il)=1 -> i_global(ig) = iele;
            %j_local(jl)=2 -> j_global(jg) = iele+1;
            for il=1:3
                ig = in_gl(il);
                for jl=1:3
                    jg = in_gl(jl);
                    rows = [rows;ig];
                    cols = [cols;jg];    
                    coef = [coef;Kele(iele,il,jl)];
                end
            end
            Kg = sparse(rows,cols,coef);
            fg(in_gl) = fg(in_gl) + fele(iele,:)';
        else
            Klocal = reshape(Kele(iele,:,:),3,3);
            Kg(in_gl,in_gl) = Kg(in_gl,in_gl) + Klocal;
            fg(in_gl) = fg(in_gl) + fele(iele,:)';
        end
    end

    % CB Dirichlet
    % x = 0
    Kg(1,:) = 0;
    Kg(1,1) = 1;
    fg(1) = T0;
    % x = 1
    Kg(2*Nnod-1,:) = 0;
    Kg(2*Nnod-1,2*Nnod-1) = 1;
    fg(2*Nnod-1) = T1;

    % Resolucion del sist. de ecuaciones
    T = Kg\fg;
    
    xnuevo = zeros(2*Nnod-1,1);
    for i=1:length(xnode)
        xnuevo(2*i-1) = xnode(i);
        if i ~= length(xnode)
            xnuevo(2*i) = (xnode(i)+xnode(i+1))/2;
        end
    end
    
    % Grafica de comparacion: analitica vs FEM
    T_an = (-5/2)*(xnuevo.^2)+(5/2)*xnuevo;
    err = norm(T-T_an);
    figure(2);clf;plot(xnuevo,T,'o-',xnuevo,T_an,'x-r');   
end