function fI = ffun_Ej_2_8_lhs(x)
%
%
%

global X ll mm coef

[Nl1,Nl2,L_Nll,L_Nl2] = shape_function(x,ll);
[Nm1,Nm2,L_Nm1,L_Nm2] = shape_function(x,mm);

% take care with column-wise ordering of multi-index matrices !
fI(:,1) = Nl1.*Nm1;
fI(:,2) = Nl2.*L_Nm1;
fI(:,3) = Nl1.*L_Nm2; 
fI(:,4) = 0;
