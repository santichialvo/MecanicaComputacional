%
%  Topic : Approximation of PDEs by continuous trial functions
%
%  Solution of a second order ODE equation (PDE for steady 1D problem) 
%  by weighted residual method using
%  [a] point collocation
%  [b] Galerkin
%
%  using psi = x
%        N_m = 

% Domain definition 
x     = (0:100)'/100;
nn    = length(x);

% definition of M : number of terms to be used in the approximation
M = 2;

% Matrix lhs K_lm and rhs vector f_l
% by Galerkin
K_gal = zeros(M,M); f_gal=zeros(M,1);
for m=1:M,
  K_gal(m,m) = 1/2*(1+m^2*pi^2);
  f_gal(m)   = (-1)^m/(m*pi);
end
% computation of a_m 
a_gal = K_gal\f_gal;

% Point collocation
K_col = zeros(M,M); f_col=zeros(M,1);
% locate collocation points 
dx = (max(x)-min(x))/(M+1); xc=zeros(M,1);
for k=1:M,
  xc(k) = min(x)+k*dx;
end

for l=1:M,
 for m=1:M,
  K_col(l,m) = (1+m^2*pi^2)*sin(m*pi*xc(l));
  f_col(l)   = -xc(l);
 end
end
% computation of a_m
a_col = K_col\f_col;

psi = x;
phi_gal = psi;
phi_col = psi;
for m=1:M,
  phi_gal = phi_gal + a_gal(m)*sin(m*pi*x);
  phi_col = phi_col + a_col(m)*sin(m*pi*x);
end  

% Exact solution (used for comparison)
phi_ex = (1/(exp(1) - exp(-1)))*(exp(x)-exp(-x));

if 1
% Visualization of results
figure(1);clf;plot(x,x-phi_ex,x,x-phi_col,x,x-phi_gal)
xlabel('X');ylabel('phi-psi');title(['Solution for M= ' num2str(M) ' phi-psi'])
figure(2);clf;plot(x,abs(phi_ex-phi_col),x,abs(phi_ex-phi_gal));grid on
xlabel('X');ylabel('E');title(['Error for M= ' num2str(M)])
e_gal = trapz(x,abs(phi_ex-phi_gal));
e_col = trapz(x,abs(phi_ex-phi_col));
gtext([' |e|_{Gal} = ' num2str(e_gal)])
gtext([' |e|_{Col} = ' num2str(e_col)])
figure(1)
legend('EXACT','COL','GAL')
filename = ['Ej_2_1_sol_M=' num2str(M)];
saveas(1,filename)
eval(['print -djpeg ' filename ])
figure(2)
legend('COL','GAL')
filename = ['Ej_2_1_err_M=' num2str(M)];
saveas(2,filename)
eval(['print -djpeg ' filename ])
end