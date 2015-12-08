x = -1:0.01:1;
y = -1:0.01:1;
e = exp(1);
M=3;

%% Ejercicio 7
%Matriz K y vector F
Ks1=sym(zeros(M,M));
Ks2=sym(zeros(M,M));
Ks3=sym(zeros(M,M));
Ks4=sym(zeros(M,M));

f_s1=sym(zeros(M,1));
K_s2=sym(zeros(M,M));
f_s2=sym(zeros(M,1));

syms X Y E v;

N = sym(zeros(2,2)); % Con dos columnas, las filas se van agregando
% Lo hago a pata porque no caché bien el patron 
N(1,1) = X;
N(2,1) = X^3;
N(3,1) = X * Y^2;
N(1,2) = Y;
N(2,2) = X^2 * Y;
N(3,2) = Y^3; 

N = N.*(1-Y^2);

E = 7.5;
v = 0.25;

D = sym([1 v 0; v 1 0; 0 0 (1-v)/2]);
D = E/(1-v^2) .* D;

for l=1:M,
    LW1 = [diff(N(l,1),X) 0; 0 diff(N(l,2),Y); diff(N(l,1),Y) diff(N(l,2),X)];
    LWT1 = transpose(LW1);
 for m=1:M,
  LNm = [diff(N(m,1),X) 0; 0 diff(N(m,2),Y); diff(N(m,1),Y) diff(N(m,2),X)];
  DLNm = D*LNm;
  Ks = int(int(LWT1*DLNm,X,0,1),Y,0,1); 
  
  Ks1(l,m) = Ks(1,1);
  Ks2(l,m) = Ks(1,2);
  Ks3(l,m) = Ks(2,1);
  Ks4(l,m) = Ks(2,2);
 end
 f_s1(l) = (E/(1+v))*int(subs(N(l,1),X,1) * (1 - Y^2),Y,0,1); 
 f_s2(l) = 0;
end

f_1 = double(f_s1);
f_2 = double(f_s2);
KsM = [Ks1 Ks2; Ks3 Ks4];
K = double(KsM);
f = transpose([f_1' f_2']);

a = K\f;

u = 0;
v = 0;

for m=1:M,
  u = a(1,1)*N(1,1) + a(2,1)*N(2,1) + a(3,1)*N(3,1);
  v = a(4,1)*N(1,2) + a(5,1)*N(2,2) + a(6,1)*N(3,2);
end 

%% Probar la funcion obtenida 

U = inline(u);
figure(1);
plot(x,U(x,-1)); %Desplazamiento en Y=-1
hold on;
plot(x,U(x,1),'r'); %Desplazamiento en Y=1
hold off;
V = inline(v);
figure(2);
plot(y,V(1,y)); %X = 1
hold on;
plot(y,V(-1,y),'r'); %X = -1


