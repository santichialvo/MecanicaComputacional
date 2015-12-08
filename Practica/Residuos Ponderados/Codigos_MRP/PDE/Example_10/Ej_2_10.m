%
%  Subject : Discretization techniques using continuous trial functions 
%            using natural boundary conditions for non linear problems
%
%  Example Ej_2_10
%
%            approximation in 1D to non linear problems: 
%            example 2.11 , page 90, Zienkiewicz & Morgan
%

global X ll mm coef

% number of non linear iterations
nnwt = 6;

% Number of terms to be used (M)
M = 2;

coef.Q_function = 'ffun_Ej_2_10_Q';
coef.kappa_function = 'ffun_Ej_2_10_kappa';
coef.M = M;

% grid of samples
Nx = 20;
x0=0; x1=1; dx = (x1-x0)/Nx;
X = (x0:dx:x1);

f = zeros(M,1);
K = zeros(M,M);
a = zeros(M,1);

figure(1);clf;
type_line = ['bgrkmcy'];

bfh_nwt = a;
for inwt=1:nnwt
    
    coef.solution = a;
    
    for ll=1:M
        f(ll) = gauss_integration('ffun_Ej_2_10_rhs',x0,x1);    
        for mm=1:M
            K(ll,mm) = gauss_integration('ffun_Ej_2_10_lhs',x0,x1); 
        end    
    end    
    
    a = K\f;
    
    % Visualization
    phi_n = 0;    
    for mm=1:M,   
        shapef = shape_function(X,mm);
        phi_n = phi_n + a(mm).*shapef;
    end      
        
    figure(1);hold on;plot(X,phi_n,type_line(inwt));
    disp(' Press return to continue ');pause
    
    bfh_nwt=[bfh_nwt,a];
    
end

xlabel('X')
ylabel('phi')
title([' Example 10 - using Ej\_2\_10 - min(phi) = ' num2str(min(phi_n)) 'max(phi) = ' num2str(max2(phi_n))])       

figure(2);semilogy(abs(bfh_nwt(1,:)-bfh_nwt(1,end))/bfh_nwt(1,end),'b-o');grid on;
figure(2);hold on ; semilogy(abs(bfh_nwt(2,:)-bfh_nwt(2,end))/bfh_nwt(2,end),'r-o')
xlabel('Newton iterations')
ylabel(' |a-a_{th}|/a_th')
title(' Non linear convergence of |a-a_{th}|/a_th')
