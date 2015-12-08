function [Ka,Kb,Kc] = Ejercicio1a_Guia2()

x = 0:0.25:1;
syms X;
Ka = sym(zeros(length(x),length(x)));
Kb = sym(zeros(length(x),length(x)));
Kc = sym(zeros(length(x),length(x)));

%%Parte a
for i = 1:5
    for j = 1:5
        Ka(i,j)=int(N(i,j),X,0,1);
    end
end

%%Parte b
for i=1:5
    for j=1:5
        Kb(i,j)=int(X^i * X^j,X,0,1);
    end
end

%%Parte c

x(1) = 0;
x(2) = 1;
x(3) = 0.5;
x(4) = 0.75;
x(5) = 0.25;

for i = 1:5
    for j = 1:5
        Kc(i,j)=int(N(i,j),X,0,1);
    end
end

end

function y = N(i,j)
    if (i==j) y = 1;
    else y = 0;
    end
end