function [T,T_an,err] = Ej4_Mio(xnode)
    % Cantidad de nodos y elementos
    Nnod = length(xnode);
    Nelem = Nnod - 1;
    
    T0 = 0; T1 = 0; % Condiciones de borde
    Q = 5; % Fuente de calor
        
    % Funciones de forma para elemento master
    %N = @(eta)[eta*(eta-1)*0.5,(1+eta).*(1-eta),eta*(eta+1)*0.5];
    %dN_deta = @(eta)[eta-0.5,-2*eta,eta+0.5];
    
    syms Eta;
    N(1) = -1/2 * Eta * (1 - Eta);
    N(2) = (1 - Eta)*(1 + Eta);
    N(3) = 1/2*(1 + Eta)*Eta;
    dN_eta(1) = diff(N(1),Eta);
    dN_eta(2) = diff(N(2),Eta);
    dN_eta(3) = diff(N(3),Eta);
    
    Kele = zeros(Nelem,3,3);
    fele = zeros(Nelem,3);
    % Ensamble de cada elemento: matriz y termino derecho
    for ele=1:Nelem
        h = xnode(ele+1)-xnode(ele);
        xmed = xnode(ele)+(h/2);
        dx_dEta = (Eta-1/2)*xnode(ele) - 2*Eta*xmed + (Eta + 1/2)*xnode(ele+1);
        for l=1:3
            for m=1:3
                res1 = int(dN_eta(l) * (1/dx_dEta) * dN_eta(m),Eta,-1,1);
                Kele(ele,l,m) = res1;
            end
            res2 = int(N(l)*Q*dx_dEta,Eta,-1,1);
            fele(ele,l) = res2;
        end
    end
    
    
    Kg = zeros(2*Nnod-1,2*Nnod-1);
    fg = zeros(2*Nnod-1,1);
    
    for iele=1:Nelem
        n = 2*iele-1;
        in_gl = [n n+1 n+2];
        Klocal = reshape(Kele(iele,:,:),3,3);
        Kg(in_gl,in_gl) = Kg(in_gl,in_gl) + Klocal;
        fg(in_gl) = fg(in_gl) + fele(iele,:)';
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
    figure(1);
    clf;
    plot(xnuevo,T,'o-',xnuevo,T_an,'x-r');   
    
    end
    
    
    