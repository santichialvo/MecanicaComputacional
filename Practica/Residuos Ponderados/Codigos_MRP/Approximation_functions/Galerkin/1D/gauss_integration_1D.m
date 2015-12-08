%
%   Gauss integration in 1D
%

% number of partitions of the interval (a,b)
Nx = Np;

pgauss1d;

psi = (0:Nx)'/Nx;

xnod = a+(b-a)*psi; 
icone = [(1:Nx)', (2:Nx+1)'];

[numel,nen] = size(icone);

psi_i = [-1,1];

fI = 0;

hele = diff(xnod);
xsj = hele/2;
xs = [xnod(icone(:,1),1),xnod(icone(:,2),1)];
f_PG = 0;
for ipg=1:npg
    shape = 1/2*(1+psi_i*psipg(ipg));
    xpg = (shape*xs')';
    eval(['fpg = ' fun '(xpg);'])
    f_PG = f_PG + wpg(ipg)*fpg.*xsj;        
end        
fI = sum(f_PG);
