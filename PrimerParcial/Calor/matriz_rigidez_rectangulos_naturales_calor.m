function [Ke,F] = matriz_rigidez_rectangulos_naturales_calor(x_v,y_v,kx,ky,c,heat)

% Ke . de = Fe
syms Xi Eta;

[Je,ecx,ecy,N] = ffs_rectangulo_naturales(x_v,y_v);
Jinv = inv(Je);

LNe = sym(zeros(2,0));
Ne = sym(zeros(2,0));
f = sym(zeros(1,1));
for i=1:4
    LN = [diff(N(i),Xi); diff(N(i),Eta)];
    LNe = [LNe LN];
    
    %No estoy seguro de esto
    LLN = [N(i); N(i)];
    Ne = [Ne LLN];
    
    f(i) = heat*N(i)*det(Je);
end

Be1 = Jinv * LNe; 
Be2 = Ne; % No se si este se multiplica por la inv del jacobiano

D = [kx 0 ; 0 ky];
C = [c 0 ; 0 c];

aux1 = Be1' * D * Be1 * det(Je);
aux2 = Be2' * C * Be2 * det(Je);

aux1 = simplify(aux1);
aux2 = simplify(aux2);

F_s = int(int(f,Xi,-1,1),Eta,-1,1);

%Ke_s = t*int(int(aux2,Xi,-1,1),Eta,-1,1); No funciona ni en pedo
%Ke = double(Ke_s);

%En simbolico es muy lento asi que uso int numerica 

% 3 puntos de gauss
%pospg = [-sqrt(15)/5 0 sqrt(15)/5];
%pespg = [5/9 8/9 5/9];

pospg = [ -0.577350269189626E+00 ,  0.577350269189626E+00 ];
pespg = [  1.0E+00 ,  1.0E+00 ];

fs = 0;
func3 = inline(f);
len = length(argnames(func3));

for l=1:4
    for m=1:4
        func1 = inline(aux1(l,m));
        aux1(l,m) = 0;
        %func2 = inline(aux2(l,m));
        aux2(l,m) = 0;
        for i=1:length(pospg)
            for j=1:length(pospg)
                aux1(l,m) = aux1(l,m) + (func1(pospg(i),pospg(j)) * pespg(i) * pespg(j));
                %aux2(l,m) = aux2(l,m) + (func2(pospg(i),pospg(j)) * pespg(i) * pespg(j));
                if (len == 1)
                    fs = fs + (func3(pospg(i)) * pespg(i));
                else
                    fs = fs + (func3(pospg(i),pospg(j)) * pespg(i) * pespg(j));
                end
            end
        end
    end
end

F = double(F_s);
Ke = double(aux1); %+ double(aux2);


end