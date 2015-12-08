x = 0:0.01:1; %Dominio de la funcion

phi_ex = 1 + sin((pi/2) * x);

%Numero de terminos usados para la aproximacion
M=4;

%% Metodo 1 (Colocacion puntual) Metodo 2 (Galerkin)
%Matriz K y vector F
K_1=zeros(M,M);
K_2_s=sym(zeros(M,M));
f_1=zeros(M,1);
f_2_s=sym(zeros(M,1));

%Se definen los puntos equiespaciados(Segun M)
delta_x=(max(x)-min(x))/(M+1); 
xc=zeros(M,1);

for i=1:M
  xc(i) = min(x)+i*delta_x;
end

syms X;

for l=1:M,
 for m=1:M,
  K_1(l,m) = sin(m*pi*xc(l));
  K_2_s(l,m) = int(sin(l*pi*X)*sin(m*pi*X),X,0,1);
 end
 A= 1+sin((pi/2)*xc(l));
 B=1 + xc(l);
 f_1(l) = A - B;
 A_s= 1 + sin((pi/2)*X);
 B_s= 1 + X;
 f_2_s(l) = int(sin(l*pi*X)*(A_s-B_s),X,0,1);
end

K_2 = double(K_2_s);
f_2 = double(f_2_s);

a_1 = K_1\f_1;
a_2 = K_2\f_2;

psi = 1 + x;
phi_1 = psi;
phi_2 = psi;
for m=1:M,
  phi_1 = phi_1 + a_1(m)*sin(m*pi*x);
  phi_2 = phi_2 + a_2(m)*sin(m*pi*x);
end  

plot(x,phi_ex,x,phi_1,'r',x,phi_2,'g');

% Error cuadratico 

Err_1=0;
Err_2=0;
for i=1:length(x)
    Err_1= Err_1 + (phi_ex(i) - phi_1(i))^2;
    Err_2= Err_2 + (phi_ex(i) - phi_2(i))^2;
end

Err_1
Err_2