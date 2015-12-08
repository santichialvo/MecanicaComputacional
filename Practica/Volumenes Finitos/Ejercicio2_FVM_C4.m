function Ejercicio2_FVM_C4()

%Caso 4
%termino reactivo con c=10 y Q=0.1
% 0 < x < L
% phi(0)=0 ; phi(1)=1

Gamma = 1;

phi0 = 0;
phiL = 1;
h = 0.01;
x = 0:h:1;

cant_celdas = length(x)-1;

Q = 0.1;
c = 10;
K = zeros(cant_celdas,cant_celdas);
F = zeros(cant_celdas,1);
left = true;

%syms phi_left phi_cent phi_right;

for i=1:cant_celdas %cada celda
    
    for j=i:i+1 %cada cara
        
        if (j == 1) %primer cara
            %Eq = Eq + (-1 * Gamma * (1/h1) * (phi_cent - phi0));
            h1 = h/2;
            K(i,j) = K(i,j) + (-1 * Gamma * (1/h1));
            left = false;
        else
            if (j == cant_celdas+1) %ultima cara
                %Eq = Eq + (Gamma * (1/h1) * (phiL - phi_cent));
                h1 = h/2;
                K(i,j-1) = K(i,j-1) + (-1 * Gamma * (1/h1));
            else   
                if (left)
                    %Eq = Eq + (-1 * Gamma * (1/h) * (phi_left - phi_cent));
                    gf = h/(x(i)-x(i-1));
                    Gamma1 = Gamma*(1-gf) + Gamma*gf;
                    
                    K(i,j) = K(i,j) + (-Gamma1 * (1/h));
                    K(i,j-1) = K(i,j-1) + (Gamma1 * (1/h));
                    left = false;
                else
                    if (~left)
                        %Eq = Eq + (Gamma * (1/h) * (phi_right - phi_cent));
                        gf = h/(x(i+1)-x(i));
                        Gamma1 = Gamma*(1-gf) + Gamma*gf;
                        
                        K(i,j) = K(i,j) + Gamma1 * (1/h);
                        K(i,j-1) = K(i,j-1) + (-Gamma1 * (1/h));
                        left = true;
                    end
                end
            end     
        end
        
    end
    
    K(i,i) = K(i,i) + c*h;
    F(i) = -Q*h;
    
end

%Cond dirichlet
F(1) = F(1) - ((2*Gamma)/h * phi0);
F(cant_celdas) = F(cant_celdas) - ((2*Gamma)/h * phiL);

a = K\F;
a(2:length(a)+1)=a;
a(1)=phi0;
a(length(a)+1)=phiL;
for i=1:cant_celdas
    xmid(i)= x(i)+(x(i+1)-x(i))/2;
end

xmid(2:length(xmid)+1)=xmid;
xmid(1) = x(1);
xmid(length(xmid)+1)=x(length(x));

exact = -49.3145*sin(3.16228.*xmid)+0.01*cos(3.16228.*xmid)-0.01; %l = 1
%exact = 4.87011*sin(3.16228.*xmid)+0.01*cos(3.16228.*xmid)-0.01; %l = 10
%exact = 1.15488*sin(3.16228.*xmid)+0.01*cos(3.16228.*xmid)-0.01; %l = 100
%exact = 1.24303.*sin(xmid)+0.1.*cos(xmid)-0.1; % con c =1 & l=1
%exact = cos(xmid)-(cos(1)-2).*csc(1).*sin(xmid)-1; %con c=1 & Q=1 & l=1
%exact = 4.81005.*sin(0.316228.*xmid)+10.*cos(0.316228.*xmid)-10; %con c=0.1 & Q=1 & l=1

err = sum((a - exact'));

%figure;
plot(xmid,a,xmid,exact,'r');


end

