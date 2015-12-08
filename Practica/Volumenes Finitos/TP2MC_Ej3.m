function err = TP2MC_Ej3 (MetodoT, MetodoDiv)

%Variables iniciales
h = 0.05;
x = 0:h:1;
Gamma = 1;
v = 1;
c = 0;
rho = 1;
phi0 = 0;
phi1 = 1;
Q = 0;
deltaT = 0.001;
t = 0:deltaT:1;

%En estado estacionario, la derivada respecto a dt se va

cant_celdas = length(x) - 1;
cant_tiempos = length(t);
hv = zeros(cant_celdas,1)+h;
K = zeros(cant_celdas,cant_celdas,cant_tiempos);
F = zeros(cant_celdas,cant_tiempos);
left = true;

a = zeros(cant_celdas,cant_tiempos);
a(:,1) = 0;

Courant = ((h*v) / deltaT)
if (Courant > 1) disp('Cuidado, numero de Courant mayor a 1'); end
Peclet = ((h*v) / Gamma)

%syms phi_left phi_cent phi_right;
counttime = 1;

for time=2:cant_tiempos

for i=1:cant_celdas %cada celda
    
    for j=i:i+1 %cada cara
        
        if (j == 1) %primer cara
            %Eq = Eq + (-1 * Gamma * (1/h1) * (phi_cent - phi0));
            h1 = hv(i)/2;
            K(i,j,time) = K(i,j,time) + (-1 * Gamma * (1/h1));
            left = false;
            
            %phili = phi0;
            %K(i,j,time) = K(i,j,time) + phili;
        else
            if (j == cant_celdas+1) %ultima cara
                %Eq = Eq + (Gamma * (1/h1) * (phiL - phi_cent));
                h1 = hv(i)/2;
                K(i,j-1,time) = K(i,j-1,time) + (-1 * Gamma * (1/h1));
                
                %phild = 0.5*v;
                %K(i,j-1,time) = K(i,j-1,time) - phild;
            else   
                if (left)
                    %Eq = Eq + (-1 * Gamma * (1/h) * (phi_left - phi_cent));
                    gf = hv(i)/(x(i+1) - x(i-1));
                    %gf = 0.5;
                    Gamma1 = Gamma*(1-gf) + Gamma*gf;
                    %phili = rho*v*(gf + (1-gf)); %central
                    phili = rho*v*gf; %upwind
                    
                    K(i,j,time) = K(i,j,time) + (-Gamma1 * (1/hv(i)));
                    K(i,j-1,time) = K(i,j-1,time) + (Gamma1 * (1/hv(i)));
                    
                    K(i,j-1,time) = K(i,j-1,time) + phili;
                    left = false;
                else
                    if (~left)
                        %Eq = Eq + (Gamma * (1/h) * (phi_right - phi_cent));
                        gf = hv(i)/(x(i+2) - x(i));
                        %gf = 0.5;
                        Gamma1 = Gamma*(1-gf) + Gamma*gf;
                        %phild = rho*v*(gf + (1-gf)); %central
                        phild = rho*v*gf; %upwind
                    
                        K(i,j,time) = K(i,j,time) + Gamma1 * (1/hv(i));
                        K(i,j-1,time) = K(i,j-1,time) + (-Gamma1 * (1/hv(i)));
                        
                        K(i,j,time) = K(i,j,time) - phild;
                        left = true;
                    end
                end
            end     
        end
        
    end
    K(i,i,time)= K(i,i,time) - c*hv(i) - (rho*a(i,time-1)*hv(i))/deltaT;
    F(i,time) = -Q*hv(i); %- (rho*a(i,time-1)*hv(i))/deltaT;
    
end

%Cond dirichlet izq
F(1,time) = F(1,time) - ((2*Gamma)/hv(i) * phi0);
%Cond dirichlet der
F(cant_celdas,time) = F(cant_celdas,time) - ((2*Gamma)/hv(i) * phi1);

a(:,time) = K(:,:,time)\F(:,time);
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

exact = (e.^xmid-1)/(e-1); %Gamma 1
%exact = 0.000045402.*e.^(10.*xmid)-0.000045402; %Gamma 0.1
%exact = 3.72008.*10.^-44.*e.^(100.*xmid)-3.72008.*10.^-44; %Gamma 0.01
%exact = e.^(1/2-xmid/2).*csc(sqrt(3)/2).*sin((sqrt(3).*xmid)/2); %Gamma=1,
%c=1
%exact = (e.^(-1/2.*(sqrt(41)-1).*(xmid-1)).*(e.^(sqrt(41).*xmid)-1))/(e.^(sqrt(41))-1);
%exact = (6 - 5.*xmid).*xmid;

err(time) = norm((a(:,time) - exact'));

counttime = counttime+1;
if (err(time) < 1e-8) break; end


%figure;
%plot(xmid,a(:,time),xmid,exact,'r');
%ylim([-2 2])
%hold on;

end

figure;
%len = size(a,2);
for i=1:counttime-1
    pause(0.01);
    plot(xmid,a(:,i));
end
hold on;
ylim([-2 2]);
plot(xmid,exact,'r');