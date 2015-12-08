%
%  Subject : Discretization techniques using continuous trial functions 
%
%  Example Ej_2_0_2D
%
%  Fourier approximation
%
%  approximation in 2D : example 2.1 , page 47, Zienkiewicz & Morgan
%

global X Y Z ll mm ll2 mm2

% Number of terms to be used (M)
%M = 3;
%L = 3;

% grid of samples
[X,Y]=meshgrid(0:0.25:1,0:0.25:1);

% some refined grid
[XI,YI]=meshgrid(0:0.25/2:1,0:0.25/2:1);

% function to be approximated, defined in a discrete way
Z = zeros(size(X));

Z(2,2)=0.5;
Z(2,3)=0.75;
Z(2,4)=0.25;

Z(3,2)=1;
Z(3,3)=1.75;
Z(3,4)=0.5;

Z(4,2)=0.75;
Z(4,3)=1.25;
Z(4,4)=0.25;

%Z = ffun_Ej_2_0_2D(X,Y);

ZI = interp2(X,Y,Z,XI,YI);
%ZI = ffun_Ej_2_0_2D(XI,YI);

% theoretical solution
% a_lm = 4*int(int(ZI*sin(l*pi*x)*sin(m*pi*y),0,1),0,1)
if 0
    for ll=1:L
        for mm=1:M
            a_th(ll,mm) = dblquad(@ffun_Ej_2_0_2D_theo,0,1,0,1);
        end
    end
else
    %    fI = gauss_integration('ff_monte_carlo_integration',0,5/4,0,5/4)
    for ll=1:L
        for mm=1:M  
            a_th(ll,mm) = gauss_integration('ffun_Ej_2_0_2D_theo',0,1,0,1);
            %            a_th(ll,mm) = monte_carlo_integration('ffun_Ej_2_0_2D_theo',0,1,0,1);
        end
    end
end

f = zeros(L,M);
K = zeros(L,M,L,M);
for ll=1:L
    for mm=1:M
        f(ll,mm) = gauss_integration('ffun_Ej_2_0_2D_rhs',0,1,0,1);
        for ll2=1:L
            for mm2=1:M
                K(ll,mm,ll2,mm2) = gauss_integration('ffun_Ej_2_0_2D_lhs',0,1,0,1);                                
            end
        end        
    end    
end

K = reshape(K,M*L,M*L);
f = reshape(f,M*L,1);
a = K\f;
a = reshape(a,L,M);

% Visualization
phi_n = 0;
for ll=1:L,
    for mm=1:M,   
        shapef = shape_function(XI,YI,ll,mm);
        phi_n = phi_n + a(ll,mm).*shapef;
    end  
end

figure(1);clf;mesh(X,Y,Z);title(' Sample points distribution ')
figure(2);clf;mesh(XI,YI,phi_n);title(' Numerical approximation ')

figure(3);clf;plot(XI(1,:),phi_n,X(1,:),Z,'o');
xlabel('X');ylabel(' u ');
legend('- : numerical ','o : sample points')

err = sum(sum(abs(phi_n-ZI)));