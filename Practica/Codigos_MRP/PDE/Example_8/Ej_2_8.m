%
%  Subject : Discretization techniques using continuous trial functions 
%            using natural boundary conditions
%
%            solving a system of PDEs
%            obtained by a second order ODE (1D heat equation)
%            as a two ODE equations of first order
%
%            Example Ej_2_8
%
%            Example 2.9 , page 78, Zienkiewicz & Morgan
%

global X ll mm coef

% Number of terms to be used (M)
%M = 4;
ndf = 2;

% the file name to obtain the function Q(x)
coef.p_function = 'ffun_Ej_2_8_Q';
coef.npg = 4;
coef.number_integ_points = 20;
coef.ndf = ndf;

% grid of samples
X = (0:0.025:1)';

f = zeros(M,ndf);
K = zeros(M,M,ndf,ndf);

coef.ncol = ndf;
for ll=1:M
    coef.ncol = ndf;
    f(ll,1:ndf) = gauss_integration('ffun_Ej_2_8_rhs',0,1);    
    for mm=1:M
        coef.ncol = ndf*ndf;        
        vaux = gauss_integration('ffun_Ej_2_8_lhs',0,1);                               
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

% Visualization
phi_n = (0*X)*ones(1,ndf);    
for mm=1:M,   
    [N1,N2,bas,bas] = shape_function(X,mm);    
    N(:,1)=N1; N(:,2)=N2;
    for idf=1:ndf,
        mm2 = (mm-1)*ndf+idf;        
        phi_n(:,idf) = phi_n(:,idf) + a(mm2)*N(:,idf);
    end
end      

figure(1);clf;plot(X,phi_n(:,1));
xlabel('X')
ylabel('q')
title([' Example 8 - using Ej\_2\_8 - min(q) = ' num2str(min(phi_n(:,1))) 'max(q) = ' num2str(max2(phi_n(:,1)))])
dphidx = diff(phi_n(:,2))./diff(X);
Xhalf = (X(1:end-1)+X(2:end))/2;
figure(1);hold on;plot(Xhalf,-dphidx,'ro')

figure(2);clf;plot(X,phi_n(:,2));
xlabel('X')
ylabel('phi')
title([' Example 8 - using Ej\_2\_8 - min(phi) = ' num2str(min(phi_n(:,2))) 'max(phi) = ' num2str(max2(phi_n(:,2)))])       
