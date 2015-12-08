if 1
    if npg==4
        xpg  = sqrt(3)/3;
        psipg = [ -xpg xpg xpg -xpg ];
        etapg = [ -xpg -xpg xpg xpg ];
        wpg   = [    1   1   1    1 ];
    elseif npg==9
        psipg = sqrt(0.6)*[-1,1,1,-1,0,1,0,-1,0];
        etapg = sqrt(0.6)*[-1,-1,1,1,-1,0,1,0,0];
        wpg   = (1/81)*[25*ones(1,4),40*ones(1,4),64];
    else
        error(' ** npg bad choice ** ')    
    end
else
    pgauss2d
end

Nx = Np;
Ny = Np;

psi = (0:Nx)'/Nx;
eta = (0:Ny)'/Ny;
x1 = a+(b-a)*psi; x1 = [x1,0*x1];
x2 = c+(d-c)*eta; x2 = [0*x2,x2];
[xnod,icone] = qq3d(x1,x2);
[numel,nen] = size(icone);
psi_i = [-1,1,1,-1];
eta_i = [-1,-1,1,1];

fI = 0;
xs = []; ys = [];
for k=1:nen
    xs = [xs , xnod(icone(:,k),1)];    
    ys = [ys , xnod(icone(:,k),2)];        
end
hx = (xs(:,2)-xs(:,1));
hy = (ys(:,4)-ys(:,1));
xsj = hx.*hy/4;

f_PG = 0;    
for ipg=1:npg
    shape = 1/4*(1+psi_i*psipg(ipg)).*(1+eta_i*etapg(ipg));
    xpg = (shape*xs')';
    ypg = (shape*ys')';
    eval(['fpg = ' fun '(xpg,ypg);'])
    f_PG = f_PG + wpg(ipg)*fpg.*xsj;        
end        
fI = sum(f_PG);
