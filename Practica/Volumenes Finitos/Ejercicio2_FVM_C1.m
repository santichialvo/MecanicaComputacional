function Ejercicio2_FVM_C1()

%Caso 1
% 0 < x < L
% phi(0)=0 ; phi(1)=1
Gamma = 1;
Q = 10;
L=1;

phi0 = 0;
phiL = 1;

h=0.2;

for hh=1:4 %en cada loop se divide en 2 el h

hv(hh) = h;

x = 0:h:L;
cant_celdas = length(x)-1;

h = x(2) - x(1);
h1 = h/2;
% |---|---|---|---|---|
% 1 1 2 2 3 3 4 4 5 5 6

K = zeros(cant_celdas,cant_celdas);
F = zeros(cant_celdas,1);
left = true;

%syms phi_left phi_cent phi_right;

for i=1:cant_celdas %cada celda
    
    for j=i:i+1 %cada cara
        
        if (j == 1) %primer cara
            %Eq = Eq + (-1 * Gamma * (1/h1) * (phi_cent - phi0));
            K(i,j) = K(i,j) + (-1 * Gamma * (1/h1));
            left = false;
        else
            if (j == cant_celdas+1) %ultima cara
                %Eq = Eq + (Gamma * (1/h1) * (phiL - phi_cent));
                K(i,j-1) = K(i,j-1) + (-1 * Gamma * (1/h1));
            else   
                if (left)
                    %Eq = Eq + (-1 * Gamma * (1/h) * (phi_left - phi_cent));
                    K(i,j) = K(i,j) + (-Gamma * (1/h));
                    K(i,j-1) = K(i,j-1) + (Gamma * (1/h));
                    left = false;
                else
                    if (~left)
                        %Eq = Eq + (Gamma * (1/h) * (phi_right - phi_cent));
                        K(i,j) = K(i,j) + Gamma * (1/h);
                        K(i,j-1) = K(i,j-1) + (-Gamma * (1/h));
                        left = true;
                    end
                end
            end     
        end
        
    end
    
    F(i) = -Q * h;
    
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

exact = (6 - 5.*xmid).*xmid;

err(hh) = sum((a - exact'));
h = h/2;

end

figure;
plot(xmid,a,xmid,exact,'r');
figure;
plot(hv,err);

end

