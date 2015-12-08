% Resolucion del ejercicio 3 de la guia de elementos finitos 1D

function [phi,phi_ex,err] = Ej3a()
    syms x;
    %phi_anal = (2/cos(1))*sin(x) - x;
    Np = 10;
    xnode = 0:1/Np:1;
    Nnod = length(xnode);
    Nelem = Nnod - 1;
    phi_left = 1; % cond. Dirichlet izquierda
    phi_right = 0; % cond. Dirichlet derecha
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
                integ2 = N(il)*1;
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
    
    % CB Neumann: phi(x=1) = 0
    Kg(Nnod,:) = 0;
    Kg(Nnod,Nnod) = 1;
    fg(Nnod) = phi_right;

    % Resuelvo el sistema de ecuaciones
    phi = Kg\fg;
    
    % Exacta, error y ploteo
    %phi_ex = subs(phi_anal,x,xnode);
    %err = norm(phi-phi_ex');
    figure(1);clf;plot(xnode,phi,'o-');%,xnode,phi_ex,'r');
end