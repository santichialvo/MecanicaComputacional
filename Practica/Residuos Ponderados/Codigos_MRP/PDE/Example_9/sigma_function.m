function sigma = sigma_function(x,y,a)
%
%  get grad N_m(x,y)
%
%  [grad_N] = dshape_function(x,y,mm)
%


global X Y ll mm coef

M = coef.M;
E = coef.young;
nu = coef.poisson;
ndf = coef.ndf;

sigma = zeros(size(x,1),3);

D = E/(1-nu^2)*[1,nu,0; nu 1 0 ; 0 0  (1-nu)/2];

for m=1:M
    
    [Nb1,Nb2,Lx_Nb1,Ly_Nb1,Lx_Nb2,Ly_Nb2] = shape_function(x,y,m);
    
    LN(:,1,1) = Lx_Nb1;
    LN(:,2,2) = Ly_Nb2;
    LN(:,3,1) = Ly_Nb1;
    LN(:,3,2) = Lx_Nb2;   
    
    for kr=1:3
        for kc=1:2
            vaux = 0;
            for kk=1:3,
                vaux = vaux + D(kr,kk)*LN(:,kk,kc);
            end
            f2(:,kr,kc) = vaux;
        end
    end
    
    for kr=1:3
        for kc=1:2,
            sigma(:,kr) = sigma(:,kr) + f2(:,kr,kc)*a((m-1)*ndf+kc);
        end
    end
end

