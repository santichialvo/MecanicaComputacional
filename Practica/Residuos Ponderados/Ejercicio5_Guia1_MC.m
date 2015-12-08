x = -1:0.01:1;
y = -1:0.01:1;
e = exp(1);
M=10;

%% Ejercicio 5
%Matriz K y vector F
K_s1=sym(zeros(M,M));
f_s1=sym(zeros(M,1));

syms X Y;

N = sym(zeros(2,1));
N(1) = 1;
N(2) = X^2;
N(3) = Y^2;
N(4) = X^2 * Y^2;
for i=5:M
    N(i) = N(i-3)*N(i-3);
end
for i=1:M
    N(i)= N(i)*(1-X^2);
end

Derivada2_X=diff(diff(N,X),X);
Derivada2_Y=diff(diff(N,Y),Y);

for l=1:M,
 for m=1:M,
  K_s1(l,m) = int(int((Derivada2_X(m) + Derivada2_Y(m))*N(l),X,0,1),Y,0,1) + int(subs(N(m)*N(l),Y,1),X,0,1); %+ int(subs(N(m)*N(l),Y,1),X,0,1);
 end
 f_s1(l) = int(subs(N(l),Y,1)*(1-X^2),X,0,1); %+ int(subs(N(l)*(1-X^2),Y,1),X,0,1);
end
f_s1(1) = 8/15;

K_1 = double(K_s1);
f_1 = double(f_s1);

a_1 = K_1\f_1;

phi_1 = 1 - Y.^2;

for m=1:M,
  phi_1 = phi_1 + a_1(m)*N(m);
end 

%% Probar la funcion obtenida 

[X,Y] = meshgrid(x,y);

Z = inline(phi_1);

surf(X,Y,Z(X,Y));

X_1=X(X==-1);
Y_1=Y(X==-1);
figure;
plot(Y_1,Z(X_1,Y_1),Y_1,1-Y_1.^2,'r'); %Esta se cumple exacta por la psi

X_2=X(Y==-1);
Y_2=Y(Y==-1);
figure;
plot(X_2,Z(X_2,Y_2),X_2,1-X_2.^2,'r');