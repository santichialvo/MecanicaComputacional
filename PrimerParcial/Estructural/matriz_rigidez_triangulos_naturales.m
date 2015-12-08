function [Ke1,F] = matriz_rigidez_triangulos_naturales(E,v,x_v,y_v,t,def,denss)

% Ke . de = Fe
syms Xi Eta;

[Je,ecx,ecy,N] = ffs_triangulo_naturales(x_v,y_v);

Z = zeros(size(Je));
iJe = inv(Je);
Jinv = [iJe Z ; Z iJe];

g = 9.8;

LNe = sym(zeros(4,0));
f = sym(zeros(1,1));

for i=1:3
    LN = [diff(N(i),Xi) 0; diff(N(i),Eta) 0; 0 diff(N(i),Xi) ; 0 diff(N(i),Eta)];
    LNe = [LNe LN];
    
    f(i) = denss*N(i)*det(Je);
end

f = [0 -f(1) 0 -f(2) 0 -f(3)];

I = [1 0 0 0; 0 0 0 1; 0 1 1 0];

Be = I * Jinv * LNe; 

D = matriz_constitutiva_def_y_tension_plana(E,v,def);

aux = Be' * D * Be * det(Je);

aux = simplify(aux);

F_s = t*int(int(f,Eta,0,1-Xi),Xi,0,1);
F = double(F_s);

Ke_s = t*int(int(aux,Eta,0,1-Xi),Xi,0,1); %No funciona ni en pedo en rectangulos
Ke1 = double(Ke_s);

%En simbolico es muy lento asi que uso int numerica 

%3 puntos de gauss
%pospg = [-sqrt(15)/5 0 sqrt(15)/5];
%pespg = [5/9 8/9 5/9];

% pospg = [ -0.577350269189626E+00 ,  0.577350269189626E+00 ];
% pespg = [  1.0E+00 ,  1.0E+00 ];
% 
% for l=1:6
%     for m=1:6
%         func1 = inline(aux(l,m));
%         aux(l,m) = 0;
%         len = length(argnames(func1));
%         for i=1:length(pospg)
%             for j=1:length(pospg)
%                 if (len==1)
%                     aux(l,m) = aux(l,m) + (func1(pospg(i)) * pespg(i));
%                 else
%                     aux(l,m) = aux(l,m) + (func1(pospg(i),pospg(j)) * pespg(i) * pespg(j));
%                 end
%             end
%         end
%     end
% end
% 
% 
% Ke2 = double(aux);


end

