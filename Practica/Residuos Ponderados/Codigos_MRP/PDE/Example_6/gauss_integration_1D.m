%pgauss1d

Nx = Np;

psi = (0:Nx)'/Nx;

xnod = a+(b-a)*psi; 

icone = [(1:Nx)',(2:Nx+1)'];

[numel,nen] = size(icone);
psi_i = [-1,1];

fI = 0;
xs = [];
for k=1:nen
    xs = [xs , xnod(icone(:,k),1)];    
end
hx = (xs(:,2)-xs(:,1));
xsj = hx/2;

f_PG = 0;    
for ipg=1:npg
    shape = 1/2*(1+psi_i*psipg(ipg));
    xpg = (shape*xs')';
    eval(['fpg = ' fun '(xpg);'])
    f_PG = f_PG + wpg(ipg)*fpg.*xsj;        
end        
fI = sum(f_PG);

