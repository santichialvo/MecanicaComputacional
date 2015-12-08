%
%  Subject : Discretization techniques using continuous trial functions 
%
%  Example Ej_2_0_1D : ------> approximation in 1D 
%
%  user data :
%
%  ffun_Ej_2_0_1D : routine for function to be approximated
%  shape_function : shape function to be used
%  L              : number of terms in the approximation
%

global X Z ll ll2 

% Number of terms to be used (M)
%L = 4;

% grid of samples
X=(0:0.25:1);

% some refined grid
XI=(0:0.25/100:1);

% function to be approximated, defined in a discrete way
Z = ffun_Ej_2_0_1D(X);

ZI = interp1(X,Z,XI);
ZI = ffun_Ej_2_0_1D(XI);

indx = (1:1:L);
% theoretical solution only for Fourier shape functions
for ll=indx
    a_th(ll) = trapz(XI,ZI.*sin(ll*pi*XI))/trapz(XI,sin(ll*pi*XI).*sin(ll*pi*XI));
end

K = eye(L);
f = zeros(L,1);
a = 0;
b = 1;

for ll=indx    
    f(ll,1) = gauss_integration('ffun_Ej_2_0_1D_rhs',a,b);
    for ll2=indx
        K(ll,ll2) = gauss_integration('ffun_Ej_2_0_1D_lhs',a,b); 
    end        
end

a = K\f;

phi_n = 0;
phi_n2 = 0;
for ll=1:L,
    shapef = shape_function(XI,ll);
    phi_n = phi_n + a(ll).*shapef;
    phi_n2 = phi_n2 + a_th(ll).*shapef;
end

figure(1);clf;plot(XI,ZI,'-',XI,phi_n);grid

% error in the approximation
err = trapz(XI,abs(phi_n-ZI))

