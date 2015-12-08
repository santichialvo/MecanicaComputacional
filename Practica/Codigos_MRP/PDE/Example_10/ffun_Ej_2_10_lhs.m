function fI = ffun_Ej_2_10_lhs(x)
%
%
%

global X ll mm coef

a = coef.solution;
M = coef.M;
phi = compute_solution(x,a,M);

filename = coef.kappa_function;
eval(['kappa=' filename '(phi);' ])

[Nl,L_Nl] = shape_function(x,ll);
[Nm,L_Nm] = shape_function(x,mm);

fI = kappa.*(L_Nl.*L_Nm)  ;
