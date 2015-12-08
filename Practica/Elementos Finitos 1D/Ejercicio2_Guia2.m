function [K,f,a] = Ejercicio2_Guia2()

xnode = [0 1/3 2/3 1]';
icone = [0 1; 1 2; 2 3];

Lxnode = length(xnode);
he = 1/3;

K_1s = sym(zeros(2,2));
Ks = sym(zeros(4,4));
f_1s = sym(zeros(1,2));
fs = sym(zeros(1,4));
syms X;

for e=1:3
    for i=1:2
        for j=1:2
            K_1s(i,j) = int(diff((X-xnode(e))/he,X)*diff((he - (X- xnode(e)))/he,X),X,xnode(e),xnode(e+1)) - int((X-xnode(e))/he * (he - (X- xnode(e)))/he,X,xnode(e),xnode(e+1));
            Ks(e+(i-1),e+(j-1)) = Ks(e+(i-1),e+(j-1)) + K_1s(i,j);
        end
        f_1s(i) = int((he - (X- xnode(e)))/he * X,X,xnode(e),xnode(e+1)) + (he - (1 - xnode(e)))/he; 
        fs(e+(i-1)) = fs(e+(i-1)) + f_1s(i);
    end
end

K = double(Ks);
f = double(fs);

a = K\f'; 

end

