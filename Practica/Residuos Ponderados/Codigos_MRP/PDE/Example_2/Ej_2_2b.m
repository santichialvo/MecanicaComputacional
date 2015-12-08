%
%  Topic : Solution of PDE by continuous trial functions
%
%  Example 2 : a 2D scalar elasticity problem - Torsion in 2D
%              using Galerkin approximation
%

Np=30;

% Domain
x  = (0:Np)'/Np;
x  = 6*x-3;
y  = (0:Np)'/Np;
y  = 4*y-2;
nn    = length(x);

[x,y]=meshgrid(x,y);

% N_m : approximation trial functions
M       = 3; 
alfa(1) = (1/6);
beta(1) = (1/4);
alfa(2) = (3/6);
beta(2) = (1/4);
alfa(3) = (1/6);
beta(3) = (3/4);
N1      = cos(alfa(1)*pi*x).*cos(beta(1)*pi*y);
N2      = cos(alfa(2)*pi*x).*cos(beta(2)*pi*y);
N3      = cos(alfa(3)*pi*x).*cos(beta(3)*pi*y);
N       = [m2v(N1),m2v(N2),m2v(N3)];

% Integration 

K=zeros(3,3);
f=zeros(3,1);
for l=1:3,
    for m=1:3,
        Iy = quad8('Intx',-2,2,[],[],beta(l),beta(m),1,0);
        Ix = quad8('Intx',-3,3,[],[],alfa(l),alfa(m),1,0);
        K(l,m) = (alfa(m)^2+beta(m)^2)*pi^2*Ix*Iy;
    end
    Iy = quad8('Intx',-2,2,[],[],beta(l),beta(l),0,1);
    Ix = quad8('Intx',-3,3,[],[],alfa(l),alfa(l),0,1);
    f(l) =  2*Ix*Iy;
end

a      = K\f;

psi = 0;
phi_n = psi;

for m=1:M,
  phi_n = phi_n + a(m)*N(:,m);
end  

phi_n = v2m(phi_n,Np+1);

% Plot the solution
figure(1);clg;mesh(x,y,phi_n);
tau_max = max2(abs(phi_n));
stri = [' max(|tau|) = ' num2str(tau_max) ];
figure(1);title(stri)

