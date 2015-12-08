function err = TP2MC_Ej1(MetodoT, MetodoDiv)

%Variables iniciales
h = 0.001;
x = 0:h:1;
Gamma = 0.1;
v = 0;
c = 1;
rho = 1;
phi0 = 0;
phi1 = 1;
Q = 0;
%DeltaT = 0.1;

%En estado estacionario, la derivada respecto a dt se va

cant_celdas = length(x) - 1;
hv = zeros(cant_celdas,1)+h;
K = zeros(cant_celdas,cant_celdas);
F = zeros(cant_celdas,1);
left = true;

%syms phi_left phi_cent phi_right;

for i=1:cant_celdas %cada celda
    
    for j=i:i+1 %cada cara
        
        if (j == 1) %primer cara
            %Eq = Eq + (-1 * Gamma * (1/h1) * (phi_cent - phi0));
            h1 = hv(i)/2;
            K(i,j) = K(i,j) + (-1 * Gamma * (1/h1));
            left = false;
            
            %K(i,j)=K(i,j)+phi0;
        else
            if (j == cant_celdas+1) %ultima cara
                %Eq = Eq + (Gamma * (1/h1) * (phiL - phi_cent));
                h1 = hv(i)/2;
                K(i,j-1) = K(i,j-1) + (-1 * Gamma * (1/h1));
                
                phild = 0.5*v;
                K(i,j-1) = K(i,j-1) - phild;
            else   
                if (left)
                    %Eq = Eq + (-1 * Gamma * (1/h) * (phi_left - phi_cent));
                    gf = hv(i)/(x(i+1) - x(i-1));
                    %gf = 0.5;
                    Gamma1 = Gamma*(1-gf) + Gamma*gf;
                    %phili = rho*v*(gf + (1-gf)); %central
                    phili = rho*v*gf; %upwind
                    
                    K(i,j) = K(i,j) + (-Gamma1 * (1/hv(i)));
                    K(i,j-1) = K(i,j-1) + (Gamma1 * (1/hv(i)));
                    
                    K(i,j-1) = K(i,j-1) + phili;
                    left = false;
                else
                    if (~left)
                        %Eq = Eq + (Gamma * (1/h) * (phi_right - phi_cent));
                        gf = hv(i)/(x(i+2) - x(i));
                        %gf = 0.5;
                        Gamma1 = Gamma*(1-gf) + Gamma*gf;
                        %phild = rho*v*(gf + (1-gf)); %central
                        phild = rho*v*gf; %upwind
                    
                        K(i,j) = K(i,j) + Gamma1 * (1/hv(i));
                        K(i,j-1) = K(i,j-1) + (-Gamma1 * (1/hv(i)));
                        
                        K(i,j) = K(i,j) - phild;
                        left = true;
                    end
                end
            end     
        end
        
    end
    K(i,i)= K(i,i) - c*hv(i);
    F(i) = -Q*hv(i);
    
end

%Cond dirichlet izq
F(1) = F(1) - ((2*Gamma)/hv(i) * phi0);
%Cond dirichlet der
F(cant_celdas) = F(cant_celdas) - ((2*Gamma)/hv(i) * phi1);

a = K\F;
%a(2:length(a)+1)=a;
%a(1)=phi0;
%a(length(a)+1)=phiL;
for i=1:cant_celdas
    xmid(i)= x(i)+(x(i+1)-x(i))/2;
end

%xmid(2:length(xmid)+1)=xmid;
%xmid(1) = x(1);
%xmid(length(xmid)+1)=x(length(x));
e=exp(1);

%% No estoy seguro de esta...
%exact = (e.^xmid-1)/(e-1); %Gamma 1
exact = 0.000045402.*e.^(10.*xmid)-0.000045402; %Gamma 0.1
%exact = 3.72008.*10.^-44.*e.^(100.*xmid)-3.72008.*10.^-44; %Gamma 0.01
%exact = e.^(1/2-xmid/2).*csc(sqrt(3)/2).*sin((sqrt(3).*xmid)/2); %Gamma=1,
%c=1
%exact = (e.^(-1/2.*(sqrt(41)-1).*(xmid-1)).*(e.^(sqrt(41).*xmid)-1))/(e.^(sqrt(41))-1);
%exact = (6 - 5.*xmid).*xmid;

err = norm((a - exact'));

%figure;
plot(xmid,a,xmid,exact,'r');

end