function Ejercicio2_FVM_C3()

%Caso 3
% 0 < x < L
% phi(0)=0 ; phi(1)=1
Gamma = 1;
e = exp(1);

phi0 = 0;
phiL = 1;

Eta = 0:0.001:1;
lenEta = length(Eta);

h = 1 - 0.75*e.^(-((Eta-0.5).^2 ./ 0.01));
h = h/sum(h);

x(1) = 0;

for i=2:lenEta
    x(i) = x(i-1) + h(i-1);
end

cant_celdas = length(x)-1;

Q = zeros(cant_celdas,1);

for i=1:cant_celdas
    if ((x(i) >= 0.25)&&(x(i) <= 0.75))
      Q(i) = 10;  
    end
end


K = zeros(cant_celdas,cant_celdas);
F = zeros(cant_celdas,1);
left = true;

%syms phi_left phi_cent phi_right;

for i=1:cant_celdas %cada celda
    
    for j=i:i+1 %cada cara
        
        if (j == 1) %primer cara
            %Eq = Eq + (-1 * Gamma * (1/h1) * (phi_cent - phi0));
            h1 = h(i)/2;
            K(i,j) = K(i,j) + (-1 * (1/h1));
            left = false;
        else
            if (j == cant_celdas+1) %ultima cara
                %Eq = Eq + (Gamma * (1/h1) * (phiL - phi_cent));
                h1 = h(i)/2;
                K(i,j-1) = K(i,j-1) + (-1 * (1/h1));
            else   
                if (left)
                    %Eq = Eq + (-1 * Gamma * (1/h) * (phi_left - phi_cent));
                    gf = h(i)/(x(i+1)-x(i-1));
                    Gamma1 = Gamma*(1-gf) + Gamma*gf;
                    
                    K(i,j) = K(i,j) + (-Gamma1 * (1/h(i)));
                    K(i,j-1) = K(i,j-1) + (Gamma1 * (1/h(i)));
                    left = false;
                else
                    if (~left)
                        %Eq = Eq + (Gamma * (1/h) * (phi_right - phi_cent));
                        gf = h(i+1)/(x(i+2)-x(i));
                        Gamma1 = Gamma*(1-gf) + Gamma*gf;
                        
                        
                        K(i,j) = K(i,j) + Gamma1 * (1/h(i));
                        K(i,j-1) = K(i,j-1) + (-Gamma1 * (1/h(i)));
                        left = true;
                    end
                end
            end     
        end
        
    end
    F(i) = -Q(i) * h(i);
    
end

%Cond dirichlet
%%Que gamma va aca?
F(1) = F(1) - ((2*Gamma)/h(1) * phi0);
F(cant_celdas) = F(cant_celdas) - ((2*Gamma)/h(cant_celdas) * phiL);

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

%exact = (11 - 5.*xmid).*xmid;

%err = sum((a - exact'));

%figure;
plot(xmid,a);

end

