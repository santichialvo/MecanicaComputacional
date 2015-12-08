%
%  Subject : Discretization techniques using continuous trial functions 
%
%  Example Ej_2_9
%
%        Solving a system of PDEs
%        Galerkin approximation in 2D to linear elasticity 
%
%        example 2.10 , page 85, Zienkiewicz & Morgan
%

global X Y ll mm coef

% Number of terms to be used (M)
M = 3;

ndf = 2;

% the file name to obtain the function Q(x)
coef.M = M;
coef.npg = 4;
coef.number_integ_points = 20;
coef.ndf = ndf;

coef.young = 1.5e8;
coef.poisson = 0.25;

% grid of samples
Nx = 20;
Ny = 20;
a = 0; b= 1; c=0; d=1;
dx = (b-a)/Nx;
dy = (d-c)/Ny;
if 0
    [X,Y]=meshgrid(a:dx:b,c:dy:d);
else
    x1 = (a:dx:b)';
    x1 = [x1,0*x1];
    x2 = (c:dy:d)';
    x2 = [0*x2,x2];
    [xnod,icone] = qq3d(x1,x2);
end

f = zeros(M,ndf);
K = zeros(M,M,ndf,ndf);
coef.ncol = ndf;
for ll=1:M
    coef.ncol = ndf;
    f(ll,1:ndf) = gauss_integration('ffun_Ej_2_9_rhs',1,c,d);    
    for mm=1:M
        coef.ncol = ndf*ndf;        
        vaux = gauss_integration('ffun_Ej_2_9_lhs',2,a,b,c,d);                               
        K(ll,mm,1:ndf,1:ndf) = reshape(vaux,ndf,ndf);  
    end    
end    

K2 = zeros(ndf*M,ndf*M);
f2 = zeros(ndf*M,1);
for ll=1:M
    ll2 = (ll-1)*ndf+(1:ndf);
    f2(ll2) = reshape(f(ll,1:ndf),ndf,1);
    for mm=1:M
        mm2 = (mm-1)*ndf+(1:ndf);
        K2(ll2,mm2) = reshape(K(ll,mm,1:ndf,1:ndf),ndf,ndf);  
    end    
end    

a = K2\f2;

% book solution
K=zeros(6,6);
K(1,:) = [5.6,5.0666667 , 0.87619 , 0.533333, -0.3555556 , 0.228571 ];
K(2,2:6) = [8.251429 , 0.769524 , 0.533333 , 0 , 0.228571];
K(3,3:6) = [1.688889 -0.076190 , 0.050794, 0.025397];
K(4,4:6) = [6.4 , 2.133333 , 2.742857 ];
K(5,5:6) = [1.584762 , 0.914286];
K(6,6) = [2.336508];
for k1=1:5
    for k2=k1+1:6
        K(k2,k1)=K(k1,k2);
    end
end

K_th = K;
f_th = [3.2;3.2;0.457143;0;0;0];
a_th = K_th\f_th;

% Visualization
phi_n = (0*xnod);    
dphidx_n = phi_n; dphidy_n = phi_n;
for mm=1:M,   
    [N1,N2,Lx_N1,Ly_N1,Lx_N2,Ly_N2] = shape_function(xnod(:,1),xnod(:,2),mm);
    N(:,1)=N1; N(:,2)=N2;
    Lx_N(:,1) = Lx_N1;
    Lx_N(:,2) = Lx_N2;
    Ly_N(:,1) = Ly_N1;
    Ly_N(:,2) = Ly_N2;
    for idf=1:ndf,
        mm2 = (mm-1)*ndf+idf;        
        phi_n(:,idf) = phi_n(:,idf) + a(mm2)*N(:,idf);
        dphidx_n(:,idf) = dphidx_n(:,idf) + a(mm2).*Lx_N(:,idf);
        dphidy_n(:,idf) = dphidy_n(:,idf) + a(mm2).*Ly_N(:,idf);                
    end    
end      
figure(1);clf;view3d(xnod,icone,phi_n(:,1));
xlabel('X')
ylabel('Y')
zlabel('U')
title([' Example 9 - using Ej\_2\_9 - max(u) = ' num2str(max2(phi_n(:,1)))])       

figure(2);clf;view3d(xnod,icone,phi_n(:,2));
xlabel('X')
ylabel('Y')
zlabel('V')
title([' Example 9 - using Ej\_2\_9 - max(v) = ' num2str(max2(phi_n(:,2)))])       

sigma = sigma_function(xnod(:,1),xnod(:,2),a);

indx = (Nx+1:Nx+1:size(xnod,1))';
figure(3);clf;plot(xnod(indx,2),(1+coef.poisson)/coef.young*sigma(indx,1))
xlabel('Y'); ylabel('(1+nu)*sigma_{x}/E')
title(' Example 6 - using Ej\_2\_6 - x-traction along x=1')

figure(4);clf;plot(xnod(indx,2),(1+coef.poisson)/coef.young*sigma(indx,3))
xlabel('Y'); ylabel('(1+nu)*sigma_{xy}/E')
title(' Example 6 - using Ej\_2\_6 - xy-traction along x=1')

figure(5);clf;pltmsh(xnod,icone)
xlabel('X')
ylabel('Y')
title([' Example 9 - using Ej\_2\_9 - Original mesh'])

figure(6);clf;pltmsh(xnod+phi_n,icone)
xlabel('X')
ylabel('Y')
title([' Example 9 - using Ej\_2\_9 - Deformed mesh'])

