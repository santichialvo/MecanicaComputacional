%
%  Subject : Discretization techniques using continuous trial functions 
%
%  Example Ej_2_7
%
%  Boundary solution method to solve torsion problem : example 2.8 , page 73, Zienkiewicz & Morgan
%

global X Y ll mm coef

% Number of terms to be used (M)
M = 3;

coef.p = 0;

% grid of samples
Nx = 20;
Ny = 20;
a = 0; b= 3; c=0; d=2;
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

f = zeros(M,1);
K = zeros(M,M);
for ll=1:M
    f1 = gauss_integration('ffun_Ej_2_7_rhs_f1',1,c,d);    
    f2 = gauss_integration('ffun_Ej_2_7_rhs_f2',1,a,b);        
    f(ll) = -(f1+f2);
    for mm=1:M
        K1 = gauss_integration('ffun_Ej_2_7_lhs_f1',1,c,d);  
        K2 = gauss_integration('ffun_Ej_2_7_lhs_f2',1,a,b);          
        K(ll,mm) = K1+K2;
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
        [shapef] = shape_function(xnod(:,1),xnod(:,2),mm);
        phi_n = phi_n + a(mm).*shapef;
    end      
    figure(1);clf;view3d(xnod,icone,phi_n-0.5*(xnod(:,1).^2+xnod(:,2).^2));
    xlabel('X')
    ylabel('Y')
    zlabel('phi')
    title([' Example 6 - using Ej\_2\_6 - max(phi) = ' num2str(max2(phi_n-0.5*(xnod(:,1).^2+xnod(:,2).^2)))])       

end    

