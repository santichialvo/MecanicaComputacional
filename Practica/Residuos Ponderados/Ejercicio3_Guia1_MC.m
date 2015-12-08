x = 0:0.01:1;
e = exp(1);
M=5;

%% Ejercicio 3
%Matriz K y vector F
K_s1=sym(zeros(M,M));
f_s1=sym(zeros(M,1));
K_s2=sym(zeros(M,M));
f_s2=sym(zeros(M,1));

syms X Nl Nm Derivada2 ms ls;
Derivada2_1=diff(diff(sin(ms*pi*X),X),X) + sin(ms*pi*X);
Derivada1_1=diff(sin(ms*pi*X),X);
Nl_1=sin(ls*pi*X);
Nm_1=sin(ms*pi*X);
%-------------------
Derivada2_2=diff(diff(e^(ms*X),X),X) + e^(ms*X);
Derivada1_2=diff(e^(ms*X),X);
Nl_2=e^(ls*X);
Derivada1_Nl_2=diff(e^(ls*X),X);
Nm_2=e^(ms*X);
%-------------------
Derivada2_3=diff(diff(X^(ms),X),X) + X^(ms);
Derivada1_3=diff(X^(ms),X);
Nl_3=X^(ls);
Derivada1_Nl_3=diff(X^(ls),X);
Nm_3=X^(ms);

for l=1:M,
 for m=1:M,
  K_s1(l,m) = int(subs(Nl_3,ls,l)*subs(Derivada2_3,ms,m),X,0,1) - subs(subs(Nl_3,ls,l),X,0)*subs(subs(Nm_3,ms,m),X,0) - subs(subs(Nl_3,ls,l),X,1)*subs(subs(Derivada1_3,ms,m),X,1) - subs(subs(Nm_3,ms,m),X,1)*subs(subs(Nl_3,ls,l),X,1);
  K_s2(l,m) = int(subs(Derivada1_Nl_3,ls,l)*subs(Derivada1_3,ms,m),X,0,1) - int(subs(Nl_3,ls,l)*subs(Nm_3,ms,m),X,0,1) + subs(subs(Nl_3,ls,l),X,0)*subs(subs(Derivada1_3,ms,m),X,0) + subs(subs(Nm_3,ms,m),X,1)*subs(subs(Nl_3,ls,l),X,1);
 end
 f_s1(l) = -int(subs(Nl_3,ls,l)*1,X,0,1);
 f_s2(l) = int(subs(Nl_3,ls,l)*1,X,0,1); 
end

K_1 = double(K_s1);
f_1 = double(f_s1);
K_2 = double(K_s2);
f_2 = double(f_s2);

a_1 = K_1\f_1;
a_2 = K_2\f_2;

phi_1 = 0;
phi_2 = 0;
phi_ex = (sin(1)-cos(1)+1)/(cos(1)+sin(1))*sin(x) + cos(x) - 1;

for m=1:M,
  phi_1 = phi_1 + a_1(m)*x.^(m);
  phi_2 = phi_2 + a_2(m)*x.^(m);
end  

err1 = abs(phi_ex-phi_1);
err2 = abs(phi_ex-phi_2);

plot(x,err1);