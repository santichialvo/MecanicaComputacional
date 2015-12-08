function [Ke,F] = matriz_rigidez_rectangulos_naturales(E,v,x_v,y_v,t,def,denss)

% Ke . de = Fe
syms Xi Eta;

[Je,ecx,ecy,N] = ffs_rectangulo_naturales(x_v,y_v);

Z = zeros(size(Je));
iJe = inv(Je);
Jinv = [iJe Z ; Z iJe];

LNe = sym(zeros(4,0));
f = sym(zeros(1,1));

g = 9.8;

for i=1:4
    LN = [diff(N(i),Xi) 0; diff(N(i),Eta) 0; 0 diff(N(i),Xi) ; 0 diff(N(i),Eta)];
    LNe = [LNe LN];
    
    f(i) = g*denss*N(i)*det(Je);
end

f = [0 -f(1) 0 -f(2) 0 -f(3) 0 -f(4)];

I = [1 0 0 0; 0 0 0 1; 0 1 1 0];

Be = I * Jinv * LNe; 

D = matriz_constitutiva_def_y_tension_plana(E,v,def);

aux = Be' * D * Be * det(Je) * t;

aux = simplify(aux);

%Ke_s = t*int(int(aux2,Xi,-1,1),Eta,-1,1); No funciona ni en pedo
%Ke = double(Ke_s);

F_s = t*int(int(f,Eta,-1,1),Xi,-1,1);
F = double(F_s);

%En simbolico es muy lento asi que uso int numerica 

% 3 puntos de gauss
%pospg = [-sqrt(15)/5 0 sqrt(15)/5];
%pespg = [5/9 8/9 5/9];

pospg = [ -0.577350269189626E+00 ,  0.577350269189626E+00 ];
pespg = [  1.0E+00 ,  1.0E+00 ];

for l=1:8
    for m=1:8
        func1 = inline(aux(l,m));
        aux(l,m) = 0;
        for i=1:length(pospg)
            for j=1:length(pospg)
                aux(l,m) = aux(l,m) + (func1(pospg(i),pospg(j)) * pespg(i) * pespg(j));
            end
        end
    end
end


Ke = double(aux);


end
