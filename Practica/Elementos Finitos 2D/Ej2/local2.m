function [Klocal,Flocal] = local2(nodos,kx,ky,A,l,h,Tref,Q)
    b1=(nodos(2,2)-nodos(3,2))/(2*A); c1=(nodos(3,1)-nodos(2,1))/(2*A); 
    b2=(nodos(3,2)-nodos(1,2))/(2*A); c2=(nodos(1,1)-nodos(3,1))/(2*A);
    b3=(nodos(1,2)-nodos(2,2))/(2*A); c3=(nodos(2,1)-nodos(1,1))/(2*A);
    Klocal = A*[kx*b1*b1+ky*c1*c1 kx*b1*b2+ky*c1*c2 kx*b1*b3+ky*c1*c3;
                kx*b2*b1+ky*c2*c1 kx*b2*b2+ky*c2*c2 kx*b2*b3+ky*c2*c3;
                kx*b3*b1+ky*c3*c1 kx*b3*b2+ky*c3*c2 kx*b3*b3+ky*c3*c3];
    
    Flocal = [Q*A/3;
              Q*A/3+h*Tref*l/2;
              Q*A/3+h*Tref*l/2];
end