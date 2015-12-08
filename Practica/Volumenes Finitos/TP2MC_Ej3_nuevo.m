function [err,hvs] = TP2MC_Ej3_nuevo ()

h=0.025;
%% Variables iniciales

for hnums = 1:6

h = h/2;
hvs(hnums) = h;
L = 1;
x = 0:h:L;
cant_celdas = length(x) - 1;

deltaT = 1;
tiempofinal = 1;
t = 0:deltaT:tiempofinal;
e = exp(1);

cant_tiempos = length(t);
hv = zeros(cant_celdas,1)+h;
Q = zeros(cant_celdas,1)+0;

tipotemporal = 3;

% Termino convectivo
v = 1;
rho = 1;
upwind = false;
if (upwind)
    if (v>0)
        alfa = 1;
        beta = 0;
    else
        alfa = 0;
        beta = 1;
    end
end

%Termino reactivo
c = 0;

%Termino difusivo
Gamma = 0.01;

%Cond de borde
phi0 = 0;
phi1 = 1; 

gamabi = 1;
gamabd = 1;
hinf = 10;

cond = [0 0];



%% Inicializaciones de estructuras

K = zeros(cant_celdas,cant_celdas);
F = zeros(cant_celdas,1);
left = true;

a = zeros(cant_celdas);
a(:,1) = 1;

Courant = ((deltaT*v) / h);
disp(['Numero de Courant: ' num2str(Courant)]);
Peclet = ((h*v) / Gamma);
disp(['Numero de Peclet: ' num2str(Peclet)]);

%syms phi_left phi_cent phi_right;

%% Loop principal

for i=1:cant_celdas %cada celda
    
    for j=i:i+1 %cada cara
        
        if (j == 1) %primer cara
            %No hago nada
            left = false;
            
        else
            if (j == cant_celdas+1) %ultima cara
                %No hago nada
            else   
                if (left)
                    %Eq = Eq + (-1 * Gamma * (1/h) * (phi_left - phi_cent));
                    gf = hv(i)/(x(i+1) - x(i-1));
                    Gamma1 = Gamma*(1-gf) + Gamma*gf;
                    phili = rho*v; 
                    
                    if (upwind)
                        K(i,j-1) = K(i,j-1) - alfa*phili;
                        K(i,j) = K(i,j) - beta*phili;
                    else
                        K(i,j) = K(i,j) - (1-gf)*rho*v;
                        K(i,j-1) = K(i,j-1) - (gf*rho*v);
                    end
                    
                    K(i,j) = K(i,j) + (Gamma1 * (1/hv(i)));
                    K(i,j-1) = K(i,j-1) - (Gamma1 * (1/hv(i)));
                    
                    
                    left = false;
                else
                    if (~left)
                        %Eq = Eq + (Gamma * (1/h) * (phi_right - phi_cent));
                        gf = hv(i)/(x(i+2) - x(i));
                        Gamma1 = Gamma*(1-gf) + Gamma*gf;
                        phild = rho*v;
                        
                        if (upwind)
                            K(i,j) = K(i,j) + beta*phild;
                            K(i,j-1) = K(i,j-1) + alfa*phild;
                        else
                            K(i,j) = K(i,j) + (gf*rho*v);
                            K(i,j-1) = K(i,j-1) + (1-gf)*rho*v;
                        end
                    
                        K(i,j) = K(i,j) - Gamma1 * (1/hv(i));
                        K(i,j-1) = K(i,j-1) + (Gamma1 * (1/hv(i)));
                        
                        left = true;
                    end
                end
            end     
        end
        
    end
    K(i,i)= K(i,i) + c*hv(i); 
    F(i) = F(i) + Q(i)*hv(i); 
    
end

%% Cond de contorno

h1 = hv(1)/2; %h de la primer celda
hf = hv(cant_celdas)/2; %h de la ultima celda

%Dirichlet
if (cond(1) == 0)
    %termino difusivo
    K(1,1) = K(1,1) + Gamma/h1;
    F(1) = F(1) + (Gamma*phi0)/h1;
    %termino convectivo
    F(1) = F(1) + rho*v*phi0;
end
if (cond(2) == 0)
    %termino difusivo
    K(cant_celdas,cant_celdas) = K(cant_celdas,cant_celdas) + Gamma/hf;
    F(cant_celdas) = F(cant_celdas) + (Gamma*phi1)/hf;
    %termino convectivo
    F(cant_celdas) = F(cant_celdas) - rho*v*phi1;
end

%Neumann
if (cond(1) == 1)
    %termino difusivo
    F(1) = F(1) - phi0; 
    %termino convectivo
    K(1,1) = K(1,1) - rho*v;
    F(1) = F(1) + rho*v*phi0*h1;
end
if (cond(2) == 1)
    %termino difusivo
    F(cant_celdas) = F(cant_celdas) + phi1; 
    %termino convectivo
    K(cant_celdas,cant_celdas) = K(cant_celdas,cant_celdas) + rho*v;
    F(cant_celdas) = F(cant_celdas) - rho*v*phi1*hf;
end

%Mixtas

if (cond(1) == 2)
    aux = (hinf*(gamabi/h1))/(hinf+(gamabi/h1));
    convecinf = (hinf*h1)/(gamabi+h1 * hinf);
    convecC = gamabi / (gamabi+h1 * hinf);
    %termino difusivo
    F(1) = F(1) + aux*phi0;
    K(1,1) = K(1,1) + aux;
    %termino convectivo
    K(1,1) = K(1,1) - convecC*rho*v;
    F(1) = F(1) - (convecinf*phi0)*rho*v;
end

if (cond(2) == 2)
    aux = (hinf*(gamabd/hf))/(hinf+(gamabd/hf));
    convecinf = (hinf*hf)/(gamabd+hf * hinf);
    convecC = gamabd / (gamabd+hf * hinf);
    %termino difusivo
    F(cant_celdas) = F(cant_celdas) + aux*phi1;
    K(cant_celdas,cant_celdas) = K(cant_celdas,cant_celdas) + aux;
    %termino convectivo
    K(cant_celdas,cant_celdas) = K(cant_celdas,cant_celdas) + convecC*rho*v;
    F(cant_celdas) = F(cant_celdas) + (convecinf*phi1)*rho*v;
end

%% Calculo de los centroides

for i=1:cant_celdas
    xmid(i)= x(i)+(x(i+1)-x(i))/2;
end

%% Soluciones
%exact = (e.^xmid-1)/(e-1); %Gamma 1
%exact = 0.000045402.*e.^(10.*xmid)-0.000045402; %Gamma 0.1
exact = 3.72008.*10.^-44.*e.^(100.*xmid)-3.72008.*10.^-44; %Gamma 0.01
%exact = e.^(1/2-xmid/2).*csc(sqrt(3)/2).*sin((sqrt(3).*xmid)/2); %Gamma=1,
%c=1
%exact = (e.^(-1/2.*(sqrt(41)-1).*(xmid-1)).*(e.^(sqrt(41).*xmid)-1))/(e.^(sqrt(41))-1);
%exact = (6 - 5.*xmid).*xmid;
%exact = (11 - 5.*xmid).*xmid;
%exact = 2.*(sin(xmid)+5)+(2.*cos(1)-1).*csc(1).*cos(xmid);
%exact = 2.*(sin(xmid)+5)-(9+2.*sin(1)).*sec(1).*cos(xmid);
%exact = (-9.*e.^(1-xmid)-2.*e.^(2-xmid)+2.*e.^xmid-9.*e.^(xmid+1)+10+10.*e.^2)/(1+e.^2);
%exact = -49.3145*sin(3.16228.*xmid)+0.01*cos(3.16228.*xmid)-0.01;
%exact = 0.01-0.0519991.*e.^(-3.16228.*xmid)+0.0419991.*e.^(3.16228.*xmid);

%% Metodo temporal
if (tipotemporal == 0) %semi explicito

terminotemporal = (rho.*hv)./deltaT;
K0(:,:) = K(:,:)./2;
Kn(:,:) = K0(:,:);

for i=1:cant_celdas 
    Kn(i,i) = Kn(i,i) + terminotemporal(i);
    K0(i,i) = K0(i,i) - terminotemporal(i);
end

for time=2:cant_tiempos
    a(:,time) = Kn(:,:)\(F(:) - (K0(:,:)*a(:,time-1)));
    
    err(time) = norm((a(:,time) - exact'));
end

else if (tipotemporal == 1) %explicito
        Faux = zeros(cant_celdas,1);
        for i = 1:cant_celdas
            Kaux(i,:) = -(deltaT/(rho*hv(i)))*K(i,:);
            Faux(i) = (deltaT/(rho*hv(i)))*F(i);
            Kaux(i,i) = Kaux(i,i)+1;
        end
        
        for time=2:cant_tiempos
            a(:,time) = Kaux*a(:,time-1) + Faux;
            
            err(time) = norm((a(:,time) - exact'));
        end
        
    else if (tipotemporal == 2) %implicito
            terminotemporal = (rho.*hv)./deltaT;
            Kaux = K;
            for i = 1:cant_celdas
                Kaux(i,i) = K(i,i) + terminotemporal(i);
            end
            Faux = F;
            
            for time=2:cant_tiempos
                Faux = F + a(:,time-1).*terminotemporal;
                
                a(:,time) = Kaux\Faux;
                
                err(time) = norm((a(:,time) - exact'));
            end
        
        else
            a(:,1) = K\F;
            err(hnums) = norm((a(:,1) - exact'));
        end
    end
end

end

figure;
for i=1:cant_tiempos-1
    title(i*deltaT);
    pause(0.001);
    plot(xmid,a(:,i));
end
hold on;
plot(xmid,exact,'r');

%title('Metodo semi-explicito,Gamma=0.01,h=0.005,deltaT=0.002');
%xlabel('h');
%ylabel('error');

%hold off;
figure;
plot(hvs,err);
figure;
plot(log(hvs),log(err));
pend = (log(abs(hvs(end)))-log(abs(hvs(1))))/(log(abs(err(end)))-log(abs(err(1))))
%title('upwind difference, gamma=0.01');
%xlabel('h');
%ylabel('error');

%plot(err);
%title('Error en funcion del tiempo');
%ylabel('error');