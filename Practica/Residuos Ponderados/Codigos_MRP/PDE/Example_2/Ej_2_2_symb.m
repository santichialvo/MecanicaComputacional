%
%     symbolic resolution of Ej_2_2
%

syms ax ay x y

ax=[1,3,1]
ay=[1,1,3]

N = [ cos(ax(1)*pi*x/6)*cos(ay(1)*pi*y/4);
    cos(ax(2)*pi*x/6)*cos(ay(2)*pi*y/4);
    cos(ax(3)*pi*x/6)*cos(ay(3)*pi*y/4)];

for l=1:3,
    for m=1:3,
        factor = -pi^2*((ax(m)/6)^2+(ay(m)/4)^2);
        K(l,m) = factor*int(int(N(l)*N(m),x,-3,3),y,-2,2);
    end
    f(l,1) = -2*int(int(N(l),x,-3,3),y,-2,2);
end

a = K\f;

for l=1:3
    dNdx(l) = diff(N(l),x);
    dNdy(l) = diff(N(l),y);
end

tau = 0; phi = 0;
for l=1:3,
    phi = phi + a(l)*N(l);
    tau = tau + a(l)*sqrt(dNdx(l)^2+dNdy(l)^2);
end

%figure(1);clf; ezmesh(phi,[-3,3,-2,2]);title(' Solution (phi) ')
%figure(2);clf; ezmesh(tau,[-3,3,-2,2]);title(' Tension (tau) ')

T = 2*int(int(phi,x,-3,3),y,-2,2);
disp([' exact twisting moment = 76.4 ' ])
disp([' The twisting moment =' num2str(double(T))])

[X,Y]=meshgrid(-3:0.1:3,-2:0.1:2);
[N1,N2]=size(X)
for k1=1:N1
    for k2=1:N2
        phi_num(k1,k2)=subs(subs(phi,x,X(k1,k2)),y,Y(k1,k2));
%        tau_num(k1,k2)=subs(subs(tau,x,X(k1,k2)),y,Y(k1,k2));
    end
end

if 0
    figure(1);clf;
    mesh(X,Y,phi_num)
    xlabel('X')
    ylabel('Y')
    zlabel('phi')
    fmax = max(max(phi_num));
    title(['Example 2: torsion problem - phi_{max} = ' num2str(fmax)])
    filename = 'Ej_2_2_sol';
    eval(['print -djpeg ' filename])

    figure(2);clf;
    mesh(X,Y,tau_num)
    xlabel('X')
    ylabel('Y')
    zlabel('tension modulus')
    tmax = max(max(tau_num));
    title(['Example 2: torsion problem - tau_{max} = ' num2str(tmax)])
    filename = 'Ej_2_2_tension';    
    eval(['print -djpeg ' filename])    
end