%
%  Tema II : TECNICAS DE DISCRETIZACION
%
%  Solucion de una PDE de segundo orden en 2D mediante Residuos ponderados
%  usando funciones de prueba globales y pesos del tipo Galerkin
%

Np=10;
% Dominio a resolver
x  = (0:Np)'/Np;
x  = 6*x-3;
y  = (0:Np)'/Np;
y  = 4*y-2;
nn    = length(x);

[x,y]=meshgrid(x,y);

% Funciones de prueba
M  = 3; 
N1 = cos(pi*x/6).*cos(pi*y/4);
N2 = cos(3*pi*x/6).*cos(pi*y/4);
N3 = cos(pi*x/6).*cos(3*pi*y/4);
N  = [m2v(N1),m2v(N2),m2v(N3)];

lgraf=0;
% Graficacion
if lgraf,
figure(1)
set(1,'Position',[0 200 200 250])
mesh(x,y,N1);title('N1')
figure(2)
set(2,'Position',[200 200 200 250])
mesh(x,y,N2);title('N2')
figure(3);
mesh(x,y,N3);title('N3')
set(3,'Position',[400 200 200 250])
end

% Computo de las integrales
xb(2) =  3/6;
xb(1) = -3/6;
yb(2) =  2/4;
yb(1) = -2/4;

alfa1 = (1/6)^2*(-pi^2);
beta1 = (1/4)^2*(-pi^2);
alfa2 = (1/6)^2*(-9*pi^2);
beta2 = (1/4)^2*(-pi^2);
alfa3 = (1/6)^2*(-pi^2);
beta3 = (1/4)^2*(-9*pi^2);

factor = -24*(alfa1+beta1);
K11    = (1/2*cos(pi*yb(2)).*sin(pi*yb(2))+1/2*pi*yb(2));
K11    = K11-(1/2*cos(pi*yb(1)).*sin(pi*yb(1))+1/2*pi*yb(1));
K11    = (1/pi^2)*K11*( ... 
   ((1/2*sin(pi*xb(2)).*cos(pi*xb(2))+pi*xb(2)/2)) - ...
   ((1/2*sin(pi*xb(1)).*cos(pi*xb(1))+pi*xb(1)/2)) ) ;
K11    = factor.*K11;

factor = -24*(alfa2+beta2);
K22    = (1/2*cos(pi*yb(2)).*sin(pi*yb(2))+1/2*pi*yb(2));
K22    = K22-(1/2*cos(pi*yb(1)).*sin(pi*yb(1))+1/2*pi*yb(1));
K22    = (1/(3*pi^2))*K22*( ... 
   ((1/2*sin(3*pi*xb(2)).*cos(3*pi*xb(2))+3*pi*xb(2)/2)) - ...
   ((1/2*sin(3*pi*xb(1)).*cos(3*pi*xb(1))+3*pi*xb(1)/2)) ) ;
K22    = factor.*K22;

factor = -24*(alfa3+beta3);
K33    = (1/2*cos(3*pi*yb(2)).*sin(3*pi*yb(2))+3/2*pi*yb(2));
K33    = K33-(1/2*cos(3*pi*yb(1)).*sin(3*pi*yb(1))+3/2*pi*yb(1));
K33    = (1/(3*pi^2))*K33*( ... 
   ((1/2*sin(pi*xb(2)).*cos(pi*xb(2))+pi*xb(2)/2)) - ...
   ((1/2*sin(pi*xb(1)).*cos(pi*xb(1))+pi*xb(1)/2)) ) ;
K33    = factor.*K33;

f1     = sin(pi*yb(2))-sin(pi*yb(1));
f1     = 48/pi^2*f1*(sin(pi*xb(2))-sin(pi*xb(1)));

f2     = sin(pi*yb(2))-sin(pi*yb(1));
f2     = 16/pi^2*f2*(sin(3*pi*xb(2))-sin(3*pi*xb(1)));

f3     = sin(3*pi*yb(2))-sin(3*pi*yb(1));
f3     = 16/pi^2*f3*(sin(pi*xb(2))-sin(pi*xb(1)));

K      = diag([K11;K22;K33]);
f	   = [f1;f2;f3];

a      = K\f;

psi = 0;
phi_n = psi;

for m=1:M,
  phi_n = phi_n + a(m)*N(:,m);
end  

phi_n = v2m(phi_n,Np+1);

% Graficacion de la aproximacion
figure(1);clg;mesh(x,y,phi_n);
tau_max = max2(abs(phi_n));
stri = [' max(|tau|) = ' num2str(tau_max) ];
figure(1);title(stri)



