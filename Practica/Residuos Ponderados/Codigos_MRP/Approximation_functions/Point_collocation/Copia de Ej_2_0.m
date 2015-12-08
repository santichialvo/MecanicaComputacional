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

M=M+2;

% collocation points
x  = (0:M-1)'/(M-1);

% function to be approximated
phi = ffun_Ej_2_0(x);

% function used to match end values
psi = phi(1)+(phi(end)-phi(1))*x;

indx = 1:M;
indx = 2:M-1;

for k=indx,
    f(k-1,1) = phi(k)-psi(k);
    for m=indx,
        K(k-1,m-1) = shape_Ej_2_0(x(k),m);
    end
end

a = K\f;

a = [0;a;0];

% Visualization
xx = (0:200)'/200;

phi_p = ffun_Ej_2_0(xx);
psi_p = phi(1)+(phi(end)-phi(1))*xx;

phi_n = psi_p;
for m=1:M,
    phi_n = phi_n + a(m)*shape_Ej_2_0(xx,m);
end  

figure(1);clf; plot(xx,phi_p,xx,psi_p);
figure(1);hold on;plot(xx,phi_n,'.r')

figure(2);clf;plot(xx,abs(phi_p-phi_n))
err = trapz(xx,abs(phi_p-phi_n));
title([' |e| = ' num2str(err)])
