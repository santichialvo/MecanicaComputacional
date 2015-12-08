function [V,C] = Ej1(ve)

%ve = [ve1,ve2,ve3..ve8];

tets = [ve(1,:) ve(2,:) ve(3,:) ve(5,:);ve(2,:) ve(3,:) ve(4,:) ve(8,:);ve(5,:) ve(2,:) ve(7,:) ve(8,:);ve(2,:) ve(5,:) ve(6,:) ve(8,:);ve(2,:) ve(5,:) ve(3,:) ve(8,:)];
V = 0;

%Calcular volumen
for i=1:5 %Tengo 5 tetras
    tet = tets(i,:);
    v1 = [tet(1) tet(2) tet(3)];
    v2 = [tet(4) tet(5) tet(6)];
    v3 = [tet(7) tet(8) tet(9)];
    v4 = [tet(10) tet(11) tet(12)];
    A = v2 - v1;
    B = v3 - v1;
    C = v4 - v1;
    mat = [A;B;C];
    V = V + (1/6)*abs(det(mat));
end

%Calcular centroide
C = 0;
for i=1:8
    C = C + ve(i,:);
end
C = C/8;

for i=1:8
    scatter3(ve(i,1),ve(i,2),ve(i,3));
    hold on;
end
scatter3(C(1),C(2),C(3));
axis equal;

end
