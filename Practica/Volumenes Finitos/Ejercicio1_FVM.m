function [faces,points,owner,neighbor,Vceldas,Cceldas,Afaces,Cfaces] = Ejercicio1_FVM(xnode,icone,hexa)

%% Para hexaedros y tetraedros

% xnode = array con estructura [x1,y1,z1;x2,y2,z2...;xN,yN,zN]
% icone = array con estructura [ic11,ic12..Ic1N; IcM1 IcM2.. IcMN];
% hexa = booleano para ver si son hexas o tetras

%%
%Example
%icone =  [1     2     3     4     5     6     7     8 ;5     6     7     8    9    10    11    12];
%xnode = [xnode = [0 0 0; 1 0 0; 1 1 0; 0 1 0; 0 0 0.1; 1 0 0.1; 1 1 0.1; 0 1 0.1;  0 0 0.2; 1 0 0.2; 1 1 0.2; 0 1 0.2];

points = xnode;

lenicone = length(icone(:,1)); %Cantidad de celdas

%% Calculo de volumenes y centroides de celdas

Vceldas = zeros(lenicone,1); %vector con volumenes de las celdas
Cceldas = zeros(lenicone,3); %vector con los centroides de las celdas

if (hexa)

    for i=1:lenicone
        tets = [points(icone(i,1),:) points(icone(i,2),:) points(icone(i,4),:) points(icone(i,5),:); points(icone(i,2),:) points(icone(i,4),:) points(icone(i,3),:) points(icone(i,7),:); points(icone(i,5),:) points(icone(i,2),:) points(icone(i,8),:) points(icone(i,7),:); points(icone(i,2),:) points(icone(i,5),:) points(icone(i,6),:) points(icone(i,7),:); points(icone(i,2),:) points(icone(i,5),:) points(icone(i,4),:) points(icone(i,7),:)];
        Vceldas(i) = 0;

        for j=1:5
        tet = tets(j,:);
        v1 = [tet(1) tet(2) tet(3)];
        v2 = [tet(4) tet(5) tet(6)];
        v3 = [tet(7) tet(8) tet(9)];
        v4 = [tet(10) tet(11) tet(12)];
        A = v2 - v1;
        B = v3 - v1;
        C = v4 - v1;
        mat = [A;B;C];
        Vceldas(i) = Vceldas(i) + (1/6)*abs(det(mat));
        end

        %Calcular centroide
        for j=1:8
            Cceldas(i,:) = Cceldas(i,:) + points(icone(i,j),:);
        end
        Cceldas(i,:) = Cceldas(i,:)/8;
    end

else
    
    for i=1:lenicone
        Vceldas(i) = 0;
        
        v1 = [points(icone(i,1),:) 1];
        v2 = [points(icone(i,2),:) 1];
        v3 = [points(icone(i,3),:) 1];
        v4 = [points(icone(i,4),:) 1];
        mat = [v1;v2;v3;v4];
        Vceldas(i) = (1/6)*abs(det(mat));

        %Calcular centroide
        for j=1:4
            Cceldas(i,:) = Cceldas(i,:) + points(icone(i,j),:);
        end
        Cceldas(i,:) = Cceldas(i,:)/4;
    end
    
end

%% Calculo de faces y owner

if (hexa)

    faces = zeros(lenicone*6,4); %6 caras por celda, cada una con 4 vertices
    owner = zeros(lenicone*6,1); %6 caras, cada una con 1 propietario

    for i=1:lenicone
        faces((6*(i-1))+1,:) = [icone(i,5) icone(i,6) icone(i,7) icone(i,8)];
        faces((6*(i-1))+2,:) = [icone(i,1) icone(i,5) icone(i,8) icone(i,4)];
        faces((6*(i-1))+3,:) = [icone(i,2) icone(i,3) icone(i,7) icone(i,6)];
        faces((6*(i-1))+4,:) = [icone(i,1) icone(i,2) icone(i,6) icone(i,5)];
        faces((6*(i-1))+5,:) = [icone(i,4) icone(i,8) icone(i,7) icone(i,3)];
        faces((6*(i-1))+6,:) = [icone(i,1) icone(i,4) icone(i,3) icone(i,2)];

        for j=(6*(i-1) + 1):(6*(i-1) + 6) %Primero ponemos todas, inclusive repetidas
            owner(j) = (i);
        end
    end
    
else
    
    faces = zeros(lenicone*4,3); %4 caras por celda, cada una con 3 vertices
    owner = zeros(lenicone*4,1); %4 caras, cada una con 1 propietario

    for i=1:lenicone
        faces((4*(i-1))+1,:) = [icone(i,1) icone(i,3) icone(i,2)];
        faces((4*(i-1))+2,:) = [icone(i,1) icone(i,4) icone(i,3)];
        faces((4*(i-1))+3,:) = [icone(i,3) icone(i,4) icone(i,2)];
        faces((4*(i-1))+4,:) = [icone(i,1) icone(i,2) icone(i,4)];

        for j=(4*(i-1) + 1):(4*(i-1) + 4) %Primero ponemos todas, inclusive repetidas
            owner(j) = (i);
        end
    end
    
end

lenfaces = length(faces(:,1));

if (hexa)
    facesorted = zeros(lenfaces,4);
else
    facesorted = zeros(lenfaces,3);
end

owner_dup = owner;

for i=1:lenfaces
    facesorted(i,:) = sort(faces(i,:)); %las ordeno para buscar repetidas
end

neighbor = zeros(1,1); %es de long variable asi que lo seteo en 1 fila
neighbor_count = 1; %para ir viendo la fila donde estoy parado

i=1;

while (i<=(lenfaces-neighbor_count+1))
    j = i+1;
    while (j<=(lenfaces-neighbor_count+1)) %busco de ahi para adelante
        if (facesorted(i,:) == facesorted(j,:)) %si encuentro una repetida
            
            neighbournum = owner(j);
            %% swap para openfoam: por lo que pude ver, openfoam realiza un swapeo para que las faces que son neighbor queden primeras que todas. No estoy
            %% seguro si eso se hace por una cuestion de optimización o estandarización.
            if (i ~= neighbor_count)
            faces = [faces(1:neighbor_count-1,:);faces(i,:);faces(neighbor_count:end,:)];
            faces(j+1,:) = [];
            faces(i+1,:) = [];
            owner = [owner(1:neighbor_count-1);owner(i);owner(neighbor_count:end)];
            owner(j+1,:) = [];
            owner(i+1,:) = [];
            facesorted = [facesorted(1:neighbor_count-1,:);facesorted(i,:);facesorted(neighbor_count:end,:)];
            facesorted(j+1,:) = [];
            facesorted(i+1,:) = [];
            
            else
            
            %neighbor(neighbor_count,1) = owner_dup(i); %los agarro de owner_dup porque owner varia en cada loop, y se mueven los indices
            %neighbor(neighbor_count,2) = owner_dup(j);
            faces(j,:) = []; %lo elimino de faces
            facesorted(j,:) = []; %lo elimino de facesorted
            owner(j) = []; %lo elimino de propietarios
            %neighbor_count=neighbor_count+1;
            end
            neighbor(neighbor_count,1) = neighbournum; %los agarro de owner_dup porque owner varia en cada loop, y se mueven los indices
            neighbor_count=neighbor_count+1;
        end
        j=j+1;
    end
    i=i+1;
end

lenfaces = length(faces(:,1));

Afaces = zeros(lenfaces,3); %vector normal area de las caras
Cfaces = zeros(lenfaces,3); %centroide de las caras

if (hexa)

    for i=1:lenfaces
        v1 = points(faces(i,2),:) - points(faces(i,1),:);
        v2 = points(faces(i,4),:) - points(faces(i,1),:);
        Afaces(i,:)=cross(v1,v2);

        Cfaces(i,:) = (points(faces(i,1),:) + points(faces(i,2),:) + points(faces(i,3),:) + points(faces(i,4),:))/4;
    end

else
    
    for i=1:lenfaces
        v1 = points(faces(i,2),:) - points(faces(i,1),:);
        v2 = points(faces(i,3),:) - points(faces(i,1),:);
        Afaces(i,:)=0.5*cross(v1,v2);
        
        Cfaces(i,:) = (points(faces(i,1),:) + points(faces(i,2),:) + points(faces(i,3),:))/3;
    end
    
end

%Porque es base 0
for i=1:lenfaces
    faces(i,:) = faces(i,:)-1;
    owner(i) = owner(i)-1;
end
for i=1:length(neighbor(:,1))
    neighbor(i,1) = neighbor(i,1)-1;
end

generar_archivo(faces,owner,neighbor,points);

end

function generar_archivo(faces,owner,neighbour,points)
    
%faces
lenfaces = length(faces(:,1));
fid = fopen( 'faces', 'wt' );
fprintf(fid, '%i \n',lenfaces);
fprintf(fid, '( \n');
for i = 1:lenfaces
    fprintf( fid, '4(%i %i %i %i) \n', faces(i,1), faces(i,2), faces(i,3), faces(i,4));
end
fprintf(fid, ')');
fclose(fid);

%points
lenpoints = length(points(:,1));
fid = fopen( 'points', 'wt' );
fprintf(fid, '%i \n',lenpoints);
fprintf(fid, '( \n');
for i = 1:lenpoints
    fprintf( fid, '(%i %i %f) \n', points(i,1), points(i,2), points(i,3));
end
fprintf(fid, ')');
fclose(fid);

%neighbor
lenneigh = length(neighbour(:,1));
fid = fopen( 'neighbour', 'wt' );
fprintf(fid, '%i(',lenneigh);
for i = 1:lenneigh
    fprintf( fid, '%i ', neighbour(i,1));
end
fprintf(fid, ')');
fclose(fid);

%owner
lenowner = length(owner(:,1));
fid = fopen( 'owner', 'wt' );
fprintf(fid, '%i \n',lenowner);
fprintf(fid, '( \n');
for i = 1:lenowner
    fprintf( fid, '%i \n', owner(i,1));
end
fprintf(fid, ')');
fclose(fid);

end

