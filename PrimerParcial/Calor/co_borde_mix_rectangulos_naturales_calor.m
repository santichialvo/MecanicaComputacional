function [Ke,F] = co_borde_mix_rectangulos_naturales_calor(x_v,y_v,h,Nfaltante,Qamb)

% Ke . de = Fe
syms t x y;

[N,A] = ffs_rectangulo_cartesiano(x_v,y_v);

if (Nfaltante(1) == 1 && Nfaltante(2) == 2)
    N = [0 0 N(3) N(4)];
    i = 3; j = 4;
else if (Nfaltante(1) == 1 && Nfaltante(2) == 3)
        N = [0 N(2) 0 N(4)];
        i = 2; j = 4;
    else if (Nfaltante(1) == 1 && Nfaltante(2) == 4)
        N = [0 N(2) N(3) 0];
        i = 2; j = 3;
        else if (Nfaltante(1) == 2 && Nfaltante(2) == 3)
                N = [N(1) 0 0 N(4)];
                i = 1; j = 4;
            else if (Nfaltante(1) == 2 && Nfaltante(2) == 4)
                    N = [N(1) 0 N(3) 0];
                    i = 1; j = 3;
                else if (Nfaltante(1) == 3 && Nfaltante(2) == 4)
                        N = [N(1) N(2) 0 0];
                        i = 1; j = 2;
                    end
                end
            end
        end
    end
end

c_t = [x_v(i) y_v(i)]*(1-t) + [x_v(j) y_v(j)]*t;
N(i)=subs(N(i),x,c_t(1));
N(i)=subs(N(i),y,c_t(2));
N(j)=subs(N(j),x,c_t(1));
N(j)=subs(N(j),y,c_t(2));
len = sqrt((x_v(j)-x_v(i))^2 + (y_v(j)-y_v(i))^2);

Ne = sym(zeros(4,0));
f = sym(zeros(1,1));
for i=1:4
    LLN = N(i);
    Ne = [Ne LLN];
    
    f(i) = h*N(i)*Qamb;
end

Be = Ne; % No se si este se multiplica por la inv del jacobiano

H = h;

aux = Be' * H * Be;

aux = simplify(aux);

F_s = len*int(f,t,0,1);
F = double(F_s);

Ke_s = len*int(aux,t,0,1);
Ke = double(Ke_s);

%En simbolico es muy lento asi que uso int numerica 

% 3 puntos de gauss
%pospg = [-sqrt(15)/5 0 sqrt(15)/5];
%pespg = [5/9 8/9 5/9];

% pospg = [ -0.577350269189626E+00 ,  0.577350269189626E+00 ];
% pespg = [  1.0E+00 ,  1.0E+00 ];
% 
% fs = 0;
% func3 = inline(f);
% len1 = length(argnames(func3));
% 
% for l=1:3
%     for m=1:3
%         func1 = inline(aux1(l,m));
%         len2 = length(argnames(func1));
%         aux1(l,m) = 0;
%         %func2 = inline(aux2(l,m));
%         aux2(l,m) = 0;
%         for i=1:length(pospg)
%             for j=1:length(pospg)
%                 if (len2 == 1)
%                     aux1(l,m) = aux1(l,m) + (func1(pospg(i)) * pespg(i) * pespg(j));
%                 else
%                     aux1(l,m) = aux1(l,m) + (func1(pospg(i),pospg(j)) * pespg(i) * pespg(j));
%                 end
%                 %aux2(l,m) = aux2(l,m) + (func2(pospg(i),pospg(j)) * pespg(i) * pespg(j));
%                 if (len1 == 1)
%                     fs = fs + (func3(pospg(i)) * pespg(i));
%                 else
%                     fs = fs + (func3(pospg(i),pospg(j)) * pespg(i) * pespg(j));
%                 end
%             end
%         end
%     end
% end
%Ke = double(aux1); %+ double(aux2);