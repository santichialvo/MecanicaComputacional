x = 0:0.01:1;
e = exp(1);
M=5;

%% Ejercicio 4
%Matriz K y vector F
K_s1=sym(zeros(M,M));
f_s1=sym(zeros(M,1));

E=1.5e8;
A=(pi*0.015*0.015);
P=100;
bx=10;

syms X Nl Nm Derivada2 ms ls;
Derivada2_1=diff(diff(sin(ms*pi*X),X),X);
Derivada1_1=diff(sin(ms*pi*X),X);
Nl_1=sin(ls*pi*X);
Nm_1=sin(ms*pi*X);
%-------------------
Derivada2_2=diff(diff(e^(ms*X),X),X);
Derivada1_2=diff(e^(ms*X),X);
Nl_2=e^(ls*X);
Derivada1_Nl_2=diff(e^(ls*X),X);
Nm_2=e^(ms*X);
%-------------------
Derivada2_3=diff(diff(X^(ms),X),X);
Derivada1_3=diff(X^(ms),X);
Nl_3=X^(ls);
Derivada1_Nl_3=diff(X^(ls),X);
Nm_3=X^(ms);

for l=1:M,
 for m=1:M,
  K_s1(l,m) = (E*A*int(subs(Nl_3,ls,l)*subs(Derivada2_3,ms,m),X,0,1)) + (E*A*subs(subs(Nl_3,ls,l),X,1)*subs(subs(Derivada1_3,ms,m),X,1));
 end
 f_s1(l) = subs(subs(Nl_3*P,ls,l),X,1) - int(subs(Nl_3*bx,ls,l)*1,X,0,1) - (E*A*subs(subs(Nl_3,ls,l),X,1));
end

K_1 = double(K_s1);
f_1 = double(f_s1);

a_1 = K_1\f_1;

phi_1 = x;

for m=1:M,
  phi_1 = phi_1 + a_1(m)*x.^(m);
end 

plot(x,phi_1);
