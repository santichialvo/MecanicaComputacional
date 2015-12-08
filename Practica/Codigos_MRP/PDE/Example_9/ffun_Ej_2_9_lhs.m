function fI = ffun_Ej_2_9_lhs(x,y)
%
%
%

global X Y ll mm coef

E = coef.young;
nu = coef.poisson;

[Na1,Na2,Lx_Na1,Ly_Na1,Lx_Na2,Ly_Na2] = shape_function(x,y,ll);
[Nb1,Nb2,Lx_Nb1,Ly_Nb1,Lx_Nb2,Ly_Nb2] = shape_function(x,y,mm);

LW(:,1,1) = Lx_Na1;
LW(:,2,2) = Ly_Na2;
LW(:,1,3) = Ly_Na1;
LW(:,2,3) = Lx_Na2;

LN(:,1,1) = Lx_Nb1;
LN(:,2,2) = Ly_Nb2;
LN(:,3,1) = Ly_Nb1;
LN(:,3,2) = Lx_Nb2;

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

fI = [fI(:,1,1),fI(:,2,1),fI(:,1,2),fI(:,2,2)];

return

fI(:,1,1) = 8*Lx_Na1.*Lx_Nb1+3*Ly_Na1.*Ly_Nb1;
fI(:,1,2) = 2*Lx_Na1.*Ly_Nb2+3*Ly_Na1.*Lx_Nb2;

fI(:,2,1) = 2*Ly_Na2.*Lx_Nb1+3*Lx_Na2.*Ly_Nb1;
fI(:,2,2) = 8*Ly_Na2.*Ly_Nb2+3*Lx_Na2.*Lx_Nb2;

fI = [fI(:,1,1),fI(:,2,1),fI(:,1,2),fI(:,2,2)];

return
