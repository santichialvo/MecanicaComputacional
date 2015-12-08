% Resolucion del ejercicio 3b de la guia de elementos finitos 1D

function [Kg,fg,phi] = Ej3b()
    syms x;
    phi_anal1 = -0.6012*x + 1 - (x^2 / 2);
    phi_anal2 = 1.1488-1.1488*x;
    Np = 10;
    xnode = 0:1/Np:1;
    Nnod = length(xnode);
    Nelem = Nnod - 1;
    phi_left = 1; % cond. Dirichlet izquierda
    dvphi_right = 0; % cond. Dirichlet derecha
    Kele = zeros(Nelem,2,2); % Nelem matrices de 2x2
    fele = zeros(Nelem,2); % Nelem vectores de 1x2

    %ensamble de cada elemento: matriz y termino derecho
    for iele=1:Nelem
        xi = xnode(iele);
        xj = xnode(iele+1);
        h = xj-xi;
        N(1) = (h-(x-xi))/h;
        N(2) = (x-xi)/h;
        dNdx = [diff(N(1),x) diff(N(2),x)]; 
        for il=1:2
            for jl=1:2
                integ = - dNdx(il)*dNdx(jl);
                Kele(iele,il,jl) = double(int(integ,x,xi,xj)); %%%%QUE PASA CON EL TERMINO DE BORDE, SE PUEDE IR?
            end
            if (xi <= 1/2) %%%%HAY ALGUNA MANERA MEJOR DE HACER ESTO ??
                integ2 = - N(il)*1;
            else
                integ2 = 0;
            end
            fele(iele,il) = double(int(integ2,x,xi,xj));
        end
    end
    
    Kg = zeros(Nnod,Nnod);
    fg = zeros(Nnod,1);

    % ensamblo la matriz global y el residuo global
    for iele=1:Nelem
        indx_global = [iele iele+1];
        %i_local(il)=1 -> i_global(ig) = iele;
        %j_local(jl)=2 -> j_global(jg) = iele+1;
        for il=1:2
            ig = indx_global(il);
            for jl=1:2
                jg = indx_global(jl);
                Kg(ig,jg) = Kg(ig,jg) + Kele(iele,il,jl);
            end
            fg(ig) = fg(ig) + fele(iele,il);
        end
    end

    % CB Dirichlet: phi(x=0) = 1
    Kg(1,:) = 0;
    Kg(1,1) = 1;
    fg(1) = phi_left;
    
    % CB Neumann: dphi/dx(x=1) = 0
    fg(Nnod) = fg(Nnod) + dvphi_right;

    % Resuelvo el sistema de ecuaciones
    phi = Kg\fg;
    
    % Exacta, error y ploteo
    x1 = xnode(xnode<=0.5);
    x2 = xnode(xnode>=0.5);
    phi_ex1 = subs(phi_anal1,x,x1);
    phi_ex2 = subs(phi_anal2,x,x2);
    err1 = norm(phi(1:(1+length(phi)/2)) - phi_ex1');
    err2 = norm(phi(length(phi)/2:length(phi)) - phi_ex2');
    err = [err1 err2];
    figure(1);
    clf;
    plot(xnode,phi,'o-',x1,phi_ex1,'r',x2,phi_ex2,'g');
end