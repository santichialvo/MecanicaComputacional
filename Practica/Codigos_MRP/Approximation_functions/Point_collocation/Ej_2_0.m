%
%  Subject : Discretization techniques using continuous trial functions 
%
%  Example Ej_2_0
%
%  Wj = delta(x-x_l) --> punctual collocation
%
%  approximation in 1D
%

% Number of terms to be used (M)
%M = 3;

% collocation points
x  = (0:M+1)'/(M+1);

% function to be approximated
phi = ffun_Ej_2_0(x);

% function used to match end values
psi = phi(1)+(phi(end)-phi(1))*x;

indx = 1:M;

f = zeros(M,1);
K = zeros(M,M);

for k=indx+1,
    f(k-1,1) = phi(k)-psi(k);
    for m=indx,
        % llamada a la rutina que calcula los coeficientes de la matriz
        % como evaluacion del integrando en los puntos donde se aplica 
        % la delta de Dirac.
        K(k-1,m) = shape_Ej_2_0(x(k),m);
    end
end

a = K\f;

%a = [0;a;0];

% Visualization
xx = (0:200)'/200;
xx = [xx;x];
xx = sort(xx);

phi_p = ffun_Ej_2_0(xx);
psi_p = phi(1)+(phi(end)-phi(1))*xx;

phi_n = psi_p;
for m=indx,
    phi_n = phi_n + a(m)*shape_Ej_2_0(xx,m);
end  

figure(1);clf; plot(xx,phi_p,xx,psi_p);
figure(1);hold on;plot(xx,phi_n,'.r')

figure(2);clf;plot(xx,abs(phi_p-phi_n))
err = trapz(xx,abs(phi_p-phi_n));
title([' |e| = ' num2str(err)])
