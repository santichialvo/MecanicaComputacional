function phi = compute_solution(x,a,M)

%global X ll mm coef

%a = coef.solution;
%M = coef.M;

phi = 0;    
for m=1:M,   
    [shapef,bas] = shape_function(x,m);
    phi = phi + a(m).*shapef;
end      

