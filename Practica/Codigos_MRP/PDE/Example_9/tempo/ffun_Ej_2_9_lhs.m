function fI = ffun_Ej_2_9_lhs(x,y)
%
%
%

global X Y ll mm coef

E = coef.young;
nu = coef.poisson;

[Nll,Nl2,Lx_Nll,Ly_Nll,Lx_Nl2,Ly_Nl2] = shape_function(x,y,ll);
[Nml,Nm2,Lx_Nml,Ly_Nml,Lx_Nm2,Ly_Nm2] = shape_function(x,y,mm);

LW(:,1,1) = Lx_Nll;
LW(:,2,2) = Ly_Nl2;
LW(:,1,3) = Ly_Nll;
LW(:,2,3) = Lx_Nl2;

LN(:,1,1) = Lx_Nml;
LN(:,2,2) = Ly_Nm2;
LN(:,3,1) = Ly_Nml;
LN(:,3,2) = Lx_Nm2;

D = E/(1-nu^2)*[1,nu,0; nu 1 0 ; 0 0  (1-nu)/2];

for kr=1:3
    for kc=1:2
        vaux = 0;
        for kk=1:3,
            vaux = vaux + D(kr,kk)*LN(:,kk,kc);
        end
        f2(:,kr,kc) = vaux;
    end
end

for kr=1:2
    for kc=1:2
        vaux = 0;
        for kk=1:3,
            vaux = vaux + LW(:,kr,kk).*f2(:,kk,kc);
        end
        fI(:,kr,kc) = vaux;
    end
end

fI = fI(:,[1,3,2,4]);