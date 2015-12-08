%
%  Subject : Discretization techniques using continuous trial functions 
%            using natural boundary conditions
%
%  Example Ej_2_5
%
%  approximation in 1D : example 2.4 , page 59, Zienkiewicz & Morgan
%

global X ll mm coef

% Number of terms to be used (M)
M = 3;

coef.q = 20;

% grid of samples
X = (0:0.025:1);

f = zeros(M,1);
K = zeros(M,M);
for ll=1:M
    f(ll) = gauss_integration('ffun_Ej_2_5_rhs',0,1);    
    for mm=1:M
        K(ll,mm) = gauss_integration('ffun_Ej_2_5_lhs',0,1);                                
    end    
end    

a = K\f;

% Visualization
phi_n = 0;    
for mm=1:M,   
    shapef = shape_function(X,mm);
    phi_n = phi_n + a(mm).*shapef;
end      
figure(1);clf;plot(X,phi_n);
xlabel('X')
ylabel('phi')
title([' Example 3 - using Ej\_2\_5 - min(phi) = ' num2str(min(phi_n)) 'max(phi) = ' num2str(max2(phi_n))])       
