%% Aproximacion a PDE por una funcion continua de prueba a traves del m�todo de residuos ponderados

%% Utilizando funciones de peso
% 1-Galerkin
% 2-Colocacion Puntual
% 3-Subdominios

%Defino el dominio de la funcion

x=0:0.01:1;
lx=length(x);

%Numero de terminos usados para la aproximacion
M=2;

%Matriz K y vector F
K_1_s = sym(zeros(M,M));
K_2=zeros(M,M);
K_3_s = sym(zeros(M,M));
F_1=zeros(M,1);
F_2=zeros(M,1);
F_3=zeros(M,1);

%Se definen los puntos equiespaciados(Segun M)
delta_x=(max(x)-min(x))/(M+1); 
xc=zeros(M,1);

for i=1:M
  xc(i) = min(x)+i*delta_x;
end
xc(M+1)=max(x);

syms X N Deriv1_N Deriv2_N;
N=sym(zeros(1,M));

%Calculo los Nm para Galerkin
for i=1:M
    N(i)=X^(i-1);
end

%Lleno las matrices y el vector
for l=1:M,
 for m=1:M,
	 Deriv1_N = (1 - (m^2 * pi^2))*sin(m*pi*X); 
     Deriv2_N = (m-1)*(m-2)*X^(m-3) + X^(m-1);
     K_1_s(l,m) = int((Deriv2_N)*N(l),X,0,1) - (subs(N(m),X,0)*subs(N(l),X,0)) - (subs(N(m),X,1)*(subs(N(l),X,1))); 
	 K_2(l,m) = subs(Deriv1_N,X,xc(l));
     K_3_s(l,m) = int(Deriv1_N,X,xc(l),xc(l+1));
 end
 F_1(l)= subs(N(l),X,0)*-1;
 F_2(l)= -subs(1-X,X,xc(l));
 F_3(l)= -int(1-X,X,xc(l),xc(l+1));
end

%Pasar de simbolo a numero 
K_1 = double(K_1_s);
K_3 = double(K_3_s);

% Computo la solucion
a_1 = K_1\F_1;
a_2 = K_2\F_2;
a_3 = K_3\F_3;

% Solucion exacta
phi_ex = (-cos(1)/sin(1))*sin(x) + cos(x); 
psi = 1-x;
phi_1=0;
phi_2=psi;
phi_3=psi;
for m=1:M,
  phi_1 = phi_1 + a_1(m)*(x.^(m-1));
  phi_2 = phi_2 + a_2(m)*sin(m*pi*x);
  phi_3 = phi_3 + a_3(m)*sin(m*pi*x);
end  


%Computo el error cuadratico medio
Err_1=0;
Err_2=0;
Err_3=0;
for i=1:length(x)
    Err_1=Err_1+(phi_ex(i)-phi_1(i))^2;
    Err_2=Err_2+(phi_ex(i)-phi_2(i))^2;
    Err_3=Err_3+(phi_ex(i)-phi_3(i))^2;
end

L = length(phi_ex);
Err_1=Err_1/L;
Err_2=Err_2/L;
Err_3=Err_3/L;

phi_4 = 1 - x - (5/132)*x.^2;

plot(x,phi_ex,'--',x,phi_4);
