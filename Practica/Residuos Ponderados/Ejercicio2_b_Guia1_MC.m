x = 0:0.01:1;
e = exp(1);
M=12;

%% Segunda parte del ejercicio (Sin psi y con psi)
%Matriz K y vector F
K_s1=sym(zeros(M,M));
f_s1=sym(zeros(M,1));
K_s2=sym(zeros(M,M));
f_s2=sym(zeros(M,1));

syms X Nl Nm Derivada2 ms ls;
Derivada2_1=diff(diff(-cos(ms*pi*X),X),X) - cos(ms*pi*X);
Derivada1_1=diff(-cos(ms*pi*X),X);
Nl_1=-cos(ls*pi*X);
Nm_1=-cos(ms*pi*X);
Derivada2_2=diff(diff(e^(ms*X),X),X) + e^(ms*X);
Derivada1_2=diff(e^(ms*X),X);
Nl_2=e^(ls*X);
Nm_2=e^(ms*X);

for l=1:M,
 for m=1:M,
  K_s1(l,m) = int(subs(Nl_1,ls,l)*subs(Derivada2_1,ms,m),X,0,1) - subs(subs(Nl_1,ls,l),X,0)*subs(subs(Nm_1,ms,m),X,0);
  K_s2(l,m) = int(subs(Nl_2,ls,l)*subs(Derivada2_2,ms,m),X,0,1) - subs(subs(Nl_2,ls,l),X,0)*subs(subs(Nm_2,ms,m),X,0) - subs(subs(Nl_2,ls,l),X,1)*subs(subs(Derivada1_2,ms,m),X,1);
 end
 f_s1(l) = - int(subs(Nl_1,ls,l)*X,X,0,1) - int(subs(Nl_1,ls,l)*2*X,X,0,1);
 f_s2(l) = subs(subs(Nl_2,ls,l),X,0)*0 - int(subs(Nl_2,ls,l)*X,X,0,1) - subs(subs(Nl_2,ls,l),X,1)*1; 
end

K_1 = double(K_s1);
f_1 = double(f_s1);
K_2 = double(K_s2);
f_2 = double(f_s2);

a_1 = K_1\f_1;
a_2 = K_2\f_2;

psi = x;
phi_1 = psi;
phi_2 = 0;
phi_ex = 2*sin(x)/cos(1) - x;

for m=1:M,
  phi_1 = phi_1 + a_1(m)*-cos(m*pi*x);
  phi_2 = phi_2 + a_2(m)*e.^(m*x);
end  

plot(x,phi_1,x,phi_2,'r',x,phi_ex,'g');