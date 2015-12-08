%
%  Subject : Discretization techniques using continuous trial functions 
%
%  Example Ej_2_2
%
%  GLS approximation
%
%  approximation in 2D : example 2.1 , page 47, Zienkiewicz & Morgan
%

global X Y ll mm coef

% Number of terms to be used (M)
M = 3;

coef.p = 2;

% grid of samples
[X,Y]=meshgrid(-3:0.1:3,-2:0.1:2);

f = zeros(M,1);
K = zeros(M,M);
for ll=1:M
    f(ll) = gauss_integration('ffun_Ej_2_2_gls_rhs',-3,3,-2,2);    
    for mm=1:M
        K(ll,mm) = gauss_integration('ffun_Ej_2_2_gls_lhs',-3,3,-2,2);                                
    end    
end    

a = K\f;

% Visualization
phi_n = 0;    
for mm=1:M,   
    shapef = shape_function(X,Y,mm);
    phi_n = phi_n + a(mm).*shapef;
end      
figure(1);clf;mesh(X,Y,phi_n);
xlabel('X')
ylabel('Y')
zlabel('phi')
title([' Example 2 - using Ej\_2\_2\_num - max(phi) = ' num2str(max2(phi_n))])       

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
