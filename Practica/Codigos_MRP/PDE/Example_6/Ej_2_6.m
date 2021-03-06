%
%  Subject : Discretization techniques using continuous trial functions 
%
%  Example Ej_2_6
%
%  Galerkin approximation in 2D to heat equation : example 2.7 , page 68, Zienkiewicz & Morgan
%

global X Y ll mm coef

% Number of terms to be used (M)
%M = 5;

coef.p = 0;

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

% some refined grid
%[XI,YI]=meshgrid(0:0.25/2:1,0:0.25/2:1);

f = zeros(M,1);
K = zeros(M,M);
for ll=1:M
    f(ll) = gauss_integration('ffun_Ej_2_6_rhs',1,c,d);    
    for mm=1:M
        K(ll,mm) = gauss_integration('ffun_Ej_2_6_lhs',2,a,b,c,d);  
    end    
end    

a = K\f;

% Visualization
if 0
    phi_n = 0;    
    for mm=1:M,   
        shapef = shape_function(X,Y,mm);
        phi_n = phi_n + a(mm).*shapef;
    end      
    figure(1);clf;mesh(X,Y,phi_n);
    xlabel('X')
    ylabel('Y')
    zlabel('phi')
    title([' Example 6 - using Ej\_2\_6 - max(phi) = ' num2str(max2(phi_n))])       
else
    phi_n = 0;    dphidx_n = 0; dphidy_n = 0;
    for mm=1:M,   
        [shapef,Lx_N,Ly_N] = shape_function(xnod(:,1),xnod(:,2),mm);
        phi_n = phi_n + a(mm).*shapef;
        dphidx_n = dphidx_n + a(mm).*Lx_N;
        dphidy_n = dphidy_n + a(mm).*Ly_N;        
    end      
    figure(1);clf;view3d(xnod,icone,phi_n);
    xlabel('X')
    ylabel('Y')
    zlabel('phi')
    title([' Example 6 - using Ej\_2\_6 - max(phi) = ' num2str(max2(phi_n))])       

    figure(2);clf;
    indx=(Nx+1:Nx+1:size(xnod,1));plot(xnod(indx,2),dphidx_n(indx));
    xlabel('X')
    ylabel(' grad phi @ x=1')
    title([' Example 6 - using Ej\_2\_6 - max(grad phi @ x=1) = ' num2str(max2(dphidx_n(indx)))])       
    
end    

return

stress_n = zeros([size(X),2]);
for mm=1:M,   
    dshapef = dshape_function(X,Y,mm);
    stress_n(:,:,1) = stress_n(:,:,1) + a(mm).*dshapef(:,:,1);
    stress_n(:,:,2) = stress_n(:,:,2) + a(mm).*dshapef(:,:,2);    
end  

tau = sqrt(stress_n(:,:,1).^2+stress_n(:,:,2).^2);
figure(2);clf;mesh(X,Y,tau);
xlabel('X')
ylabel('Y')
zlabel('tau')
title([' Example 2 - using Ej\_2\_2\_num - max(|tau|) = ' num2str(max2(tau))])       
