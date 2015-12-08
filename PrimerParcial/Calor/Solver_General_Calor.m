clear;

% Variables de la rutina
% kx   = Heat transfer coeffcient in X direction
% ky   = Heat transfer coeffcient in Y direction
% heat = Vector con heat para cada elemento especifico (Longitud == a
% cantidad de elementos)
% coordinates = [ x , y ] coordinate matrix nnode x ndime (2)
% elements    = [ inode , jnode , knode ] element connectivity matrix
%               nelem x nnode; nnode = 3 for triangular elements and 
%               nnode = 4 for cuadrilateral elements
% fixnodes    = [ node number , fixed value ] matrix with 
%               restricted temperature restrictions
% pointload   = [ node number i , punctual flux ] matrix with 
%               punctual fluxes applied
% sideload    = [ node number i , node number j , normal flux ] matrix
%               with line definition and uniform normal flux applied

archivo = input('Nombre del archivo con datos: ','s');

eval(archivo);

npnod = size(coordinates,1); %Cantidad de nodos
nndof = npnod;               % Number of total DOF (temperatura en cada nodo)
nelem = size(elements,1);    % Number of elements 
nnode = size(elements,2);    % Number of nodes per element
neleq = nnode;               % Number of DOF per element (tres o cuatro)

% Dimension the global matrices
StifMat  = sparse( nndof , nndof );  % Create the global stiffness matrix
force    = sparse( nndof , 1 );      % Create the global force vector
force1   = sparse( nndof , 1 );      % Create the global force vector
reaction = sparse( nndof , 1 );      % Create the global reaction vector
u        = sparse( nndof , 1 );      % Nodal variables

% Material properties (Constant over the domain)
%dmat = [kx 0 ; 0 ky];
c = 0; % Por defecto

% Condiciones mixtas -- Agregarlas aca a pata
cbm = 1; %Por defecto, no hay CB mixta
%lcbmnods = [1 2 3 4]; %Vector con nodos vertices del elemento con CBM
lcbmnods = [2 3 5 ; 4 5 6];
cantcbm = 1; %CBM que estoy evaluando actualmente
cantcbm_max = 2; %CBM que hay en total

% Element cycle
  for ielem = 1 : nelem

% Recover element properties
    lnods = elements(ielem,:);                         % Elem. connectivity
    coord(1:nnode,:) = coordinates(lnods(1:nnode),:);  % Elem. coordinates
 
% Evaluate the elemental stiffnes matrix and mass force vector
    if (nnode == 3)
      [ElemMat,ElemFor] = matriz_rigidez_triangulos_naturales_calor(coord(:,1)',coord(:,2)',kx,ky,c,heat(ielem)); 
    else 
      [ElemMat,ElemFor] = matriz_rigidez_rectangulos_naturales_calor(coord(:,1)',coord(:,2)',kx,ky,c,heat(ielem));
    end
    
    %CB Mixtas
    if (lcbmnods(cantcbm,:)==lnods)
        h = 10;
        Qamb = 50;
        lnods = lcbmnods(cantcbm,:);
        coord(1:nnode,:) = coordinates(lnods(1:nnode),:);
        %Nfaltante = [1, 2];
        Nfaltante = 1;
        
        if (nnode == 3)
            %[ECBM,FCBM] = co_borde_mix_triangulos_cartesianas_calor(coord(:,1)',coord(:,2)',h,Nfaltante,Qamb);
            [ECBM,FCBM] = co_borde_mix_triangulos_naturales_calor(coord(:,1)',coord(:,2)',h,Nfaltante,Qamb);
        else 
            [ECBM,FCBM] = co_borde_mix_rectangulos_naturales_calor(coord(:,1)',coord(:,2)',h,Nfaltante,Qamb);
        end
        
        if (cantcbm<cantcbm_max) 
            cantcbm = cantcbm + 1; 
        end;
        
        ElemMat = ElemMat + ECBM;
        ElemFor = ElemFor + FCBM;
    end
    
% Find the equation number list for the i-th element
    eqnum = [];                            % Clear the list
    for i =1 : nnode                       % Node cycle
      eqnum = [eqnum,lnods];               % Build the equation number list
    end

% Assemble the force vector and the stiffnes matrix
    for i = 1 : neleq
      force(eqnum(i)) = force(eqnum(i)) + ElemFor(i);
      for j = 1 : neleq
        StifMat(eqnum(i),eqnum(j)) = StifMat(eqnum(i),eqnum(j)) + ...
                                     ElemMat(i,j);
      end
    end

  end  % End element cycle
  
  % Fuentes puntuales (Pero no en un nodo especifico)
  for ip = 1 : size(fuentespuntuales,1)
      
    % Recover element properties
    lnods = fuentespuntuales(ip,1:nnode);                 % Elem. connectivity
    coord(1:nnode,:) = coordinates(lnods(1:nnode),:);  % Elem. coordinates
      
    if (nnode == 3)
        [Je,ecx,ecy,N] = ffs_triangulo_naturales(coord(:,1)',coord(:,2)');
    else
        [Je,ecx,ecy,N] = ffs_rectangulo_naturales(coord(:,1)',coord(:,2)');
    end
    
    x_c = fuentespuntuales(ip,nnode+1:nnode+2); % Posicion en (x,y) de la fuente
    Q = fuentespuntuales(ip,length(fuentespuntuales)); %Valor de la fuente
    
    %eq1 = ecx == xc(1)
    %eq2 = ecy == xc(2)
    %S = solve(eq1,eq2);
    %Con esos dos valores, utilizarlos con las FF y la Q (supongamos que
    %son x_c nuevos) 
    
    x_c(1) = 1/5;
    x_c(2) = 1/5;
    %x_c(1) = -3/5;
    %x_c(2) = -3/5;
    
    syms Eta Xi;
    for i = 1:nnode
        Ne(i) = subs(N(i),x_c(1),Xi);
        Ne(i) = subs(Ne(i),x_c(2),Eta);
    end
    F = Ne.*Q;
    
    eqnum = [];                            % Clear the list
    for i =1 : nnode                       % Node cycle
      eqnum = [eqnum,lnods];               % Build the equation number list
    end
    
    for i = 1 : neleq
      force(eqnum(i)) = force(eqnum(i)) + F(i);
    end
    
  end
  
  
  % Condiciones Neumann
  for i = 1 : size(sideload,1)
    x = coordinates(sideload(i,1),:) - coordinates(sideload(i,2),:);
    l = sqrt(x*transpose(x));          % Find the lenght of the side
    ieqn = sideload(i,1);              % Find eq. number for the first node
    force(ieqn) = force(ieqn) + l*sideload(i,3)/2;      % Add punctual heat 

    ieqn = sideload(i,2);             % Find eq. number for the second node
    force(ieqn) = force(ieqn) + l*sideload(i,3)/2;      % Add punctual heat 
  end
  
  % Flujo puntual en un punto de la malla específico 
  for i = 1 : size(pointload,1)
    ieqn = pointload(i,1);                               % Find eq. number
    force(ieqn) = force(ieqn) + pointload(i,2);          % and add the flux
  end
  
  % Aplicar condiciones Dirichlet 
  for i = 1 : size(fixnodes,1)
    ieqn = fixnodes(i,1);                        % Find the equation number
    u(ieqn) = fixnodes(i,2);                  % and store the solution in u
    fix(i) = ieqn;                        % and mark the eq. as a fix value
  end
  force1 = force - StifMat * u;      % Adjust the rhs with the known values

% Compute the solution by solving StifMat * u = force for the remaining
% unknown values of u
  FreeNodes = setdiff( 1:nndof , fix );           % Se buscan los nodos libres
                                                  
  u(FreeNodes) = StifMat(FreeNodes,FreeNodes) \ force1(FreeNodes); %se resuelve solo para ellos
  
  %Visualizacion
  figure;
  patch('Faces',elements, 'Vertices',coordinates, 'FaceVertexCData',u, ...
    'FaceColor','interp', 'EdgeColor','k', 'EraseMode','normal'); 
