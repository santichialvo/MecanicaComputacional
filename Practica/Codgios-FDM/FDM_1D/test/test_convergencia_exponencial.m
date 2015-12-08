%
% vemos como se propaga numericamente una solucion de difusion y como eso
% se relaciona con los autovalores de la matriz
%

caso = 1;

if caso==1,
    % implicit method
    dt = 5;
    nstep = 10;
    Tf = dt*nstep;
    
    % construimos un problema en 2D
    N=21;K = delsq(numgrid('S',N));
    N1 = N-2;
    
    indx = [(1:N1)';(N1+1:N1:N1*N1)';(2*N1:N1:N1*N1)';(N1-1)*N1+(1:N1)'];
    indx = complement((1:N1*N1)',indx);
    
    K = K(indx,indx);
    
    [xnod,icone]=qq3d((0:N1-1)'/(N1-1),(0:N1-1)'/(N1-1));
    x = xnod(indx,:);
    nodes_in=in_box(xnod,[0.45 0.45],[0.55 0.55]);
    nnod = size(xnod,1);
    Tnod = zeros(nnod,1); Tnod(nodes_in,1)=1;
    % le aplicamos una evolucion temporal explicita
    
    M = eye(size(K));
    A = M+dt*K;
    
    T = Tnod(indx,:);
    
    Tex_f = expm(-K*Tf)*T;
    Tex = 0*Tnod;
    Tex(indx)=Tex_f;
    
    figure(1);clf;
    %plot3(x(:,1),x(:,2),T,'*');
    Tnod = zeros(N1*N1,1); Tnod(indx)=T;
    view3d(xnod,icone,Tnod);colorbar
    %hold on
    pause
    for k=1:nstep
        if 0
            T = inv(A)*T;
        else
            [T,flag1,rr1,iter1,rv1] = pcg(A,T,1e-8,1000);
            if flag1~=0,
                error(' flag1 ~= 0 in PCG - check it');
            end
        end
        
        %plot3(x(:,1),x(:,2),T,'*');
        Tnod = zeros(N1*N1,1); Tnod(indx)=T;
        clf;view3d(xnod,icone,Tnod);colorbar
        pause
    end
    
    return
end

if caso==2,
    % explicit method
    dt = 1;
    nstep = 1;
    
    % construimos un problema en 2D
    N=21;K = delsq(numgrid('S',N));
    N1 = N-2;
    
    indx = [(1:N1)';(N1+1:N1:N1*N1)';(2*N1:N1:N1*N1)';(N1-1)*N1+(1:N1)'];
    indx = complement((1:N1*N1)',indx);
    
    K = K(indx,indx);
    
    [xnod,icone]=qq3d((0:N1-1)'/(N1-1),(0:N1-1)'/(N1-1));
    x = xnod(indx,:);
    nodes_in=in_box(xnod,[0.45 0.45],[0.55 0.55]);
    nnod = size(xnod,1);
    Tnod = zeros(nnod,1); Tnod(nodes_in,1)=1;
    % le aplicamos una evolucion temporal explicita
    
    M = eye(size(K));
    A = M-dt*K;
    
    T = Tnod(indx,:);
    
    figure(1);clf;
    %plot3(x(:,1),x(:,2),T,'*');
    Tnod = zeros(N1*N1,1); Tnod(indx)=T;
    view2d(xnod,icone,Tnod);colorbar
    %hold on
    pause
    for k=1:nstep
        T = A*T;
        %plot3(x(:,1),x(:,2),T,'*');
        Tnod = zeros(N1*N1,1); Tnod(indx)=T;
        clf;view2d(xnod,icone,Tnod);colorbar
        pause
    end
    
    return
end

%
% quiero ver como converge la expansion en serie de la exponencial cuando
% cambia el argumento . No olvidar que el argumento es como el Fou de cada
% uno de los modos de la descomposicion en autovalores de la matriz K de
% difusion. Entonces esto me dice cuantos terminos necesito para aproximar
% con un 1% de discrepancia.
%
if caso==2,
    k=(1:100)';
    figure(1);clf;hold on;
    for Fo=(1:20),
        plot(Fo,max(find(1+cumsum([(Fo.^k)./(factorial(k))])<0.99*exp(Fo))),'r*');
    end
    
    return
end

if caso==3
    %
    % aqui extendemos lo anterior ahora al caso de una matriz extraida de una
    % discretizacion tipo stencil laplaciano en 2D
    %
    
    N=10;A = delsq(numgrid('S',N));
    N1 = N-2;
    
    %indx = (N1+2:(N1^2-(N1+1)));
    indx = [(1:N1)';(N1+1:N1:N1*N1)';(2*N1:N1:N1*N1)';(N1-1)*N1+(1:N1)'];
    indx = complement((1:N1*N1)',indx);
    
    
    A = A(indx,indx);
    Nter = 200;
    Fo=1;
    Fov = [0.25,0.5,0.75,1,1.5];
    Fov = -(1:10);
    for kFo=1:length(Fov)
        Fo = Fov(kFo);
        fA_ex = expm(A*Fo);
        fA_ap = eye(size(A));
        bfh = [];
        for k=1:Nter
            fA_ap = fA_ap + (A*Fo)^k/factorial(k);
            vaux=(fA_ex-fA_ap);
            vaux_norm=norm(vaux,'fro');
            bfh = [bfh;[k,vaux_norm]];
        end
        
        semilogy(bfh(:,1),bfh(:,2));title([' Fourier = ' num2str(-Fo)])
        
        eval(['bfh_full(' num2str(kFo) ').value=bfh;'])
        eval(['bfh_full(' num2str(kFo) ').Fo=Fo;'])
        
        pause
    end
    
    return
end