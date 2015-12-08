clear; clc;

% The variables are read as a MAT-fem subroutine
% pstrs = 1 indicate Plane Stress; 0 indicate Plane Strain
% young =   Young Modulus
% poiss =   Poission Ratio
% thick =   Thickness only valid for Plane Stress
% denss =   Density
% coordinates = [ x , y ] coordinate matrix nnode x ndime (2)
% elements    = [ inode , jnode , knode ] element connectivity  matrix
%               nelem x nnode; nnode = 3 for triangular elements and 
%               nnode = 4 for quadrilateral elements
% fixnodes    = [ node number , dimension , fixed value ] matrix with 
%               Dirichlet restrictions
% pointload   = [ node number , dimension , load value ] matrix with 
%               nodal loads
% sideload    = [ node number i , node number j , x load , y load ]
%               matrix with line definition and uniform load
%               applied in x and y directions

  archivo = input('Nombre del archivo con datos: ','s');

  eval(archivo);       % Read input file

% Find basic dimensions
  npnod = size(coordinates,1);         % Number of nodes
  nndof = 2*npnod;                     % Number of total DOF
  nelem = size(elements,1);            % Number of elements
  nnode = size(elements,2);            % Number of nodes per element
  neleq = nnode*2;                     % Number of DOF per element

  elements = sortrows(elements);
  
  % Dimension the global matrices
  StifMat  = sparse( nndof , nndof );  % Create the global stiffness matrix
  force    = sparse( nndof , 1 );      % Create the global force vector
  force1   = sparse( nndof , 1 );      % Create the global force vector
  reaction = sparse( nndof , 1 );      % Create the global reaction vector
  u        = sparse( nndof , 1 );      % Nodal variables
  
% Material properties (Constant over the domain)
  dmat = matriz_constitutiva_def_y_tension_plana(young,poiss,pstrs);
  
  % Element cycle
  for ielem = 1 : nelem

% Recover element properties
    lnods = elements(ielem,:);                         % Elem. connectivity
    coord(1:nnode,:) = coordinates(lnods(1:nnode),:);  % Elem. coordinates
 
% Evaluate the elemental stiffness matrix and mass force vector
    if (nnode == 3)   % 3 Nds. Triangle
      %[ElemMat,ElemFor] = TrStif_v1_3(coord,dmat ,thick,denss);
      [ElemMat,ElemFor] = matriz_rigidez_triangulos_naturales(young,poiss,coord(:,1)',coord(:,2)',thick,pstrs,denss(ielem));
    else              % 4 Nds. Quadrilateral
      [ElemMat,ElemFor] = matriz_rigidez_rectangulos_naturales(young,poiss,coord(:,1)',coord(:,2)',thick,pstrs,denss(ielem));
    end
    
% Find the equation number list for the i-th element
    eqnum = [];                                        % Clear the list
    for i = 1 : nnode                                  % Node cycle
      eqnum = [eqnum,lnods(i)*2-1,lnods(i)*2];         % Build the equation 
    end                                                % number list

% Assemble the force vector and the stiffness matrix
    for i = 1 : neleq
      force(eqnum(i)) = force(eqnum(i)) + ElemFor(i);
      for j = 1 : neleq
         StifMat(eqnum(i),eqnum(j)) = StifMat(eqnum(i),eqnum(j)) + ...
                                      ElemMat(i,j);
      end
    end

  end  % End element cycle
  
  % Fuerzas puntuales (Pero no en un nodo especifico)
  for ip = 1 : size(fuerzaspuntuales,1)
      
    % Recover element properties
    lnods = fuerzaspuntuales(ip,1:nnode);                 % Elem. connectivity
    coord(1:nnode,:) = coordinates(lnods(1:nnode),:);  % Elem. coordinates
      
    if (nnode == 3)
        [Je,ecx,ecy,N] = ffs_triangulo_naturales(coord(:,1)',coord(:,2)');
    else
        [Je,ecx,ecy,N] = ffs_rectangulo_naturales(coord(:,1)',coord(:,2)');
    end
    
    x_c = fuerzaspuntuales(ip,nnode+1:nnode+2); % Posicion en (x,y) de la fuente
    dir = fuerzaspuntuales(ip,nnode+3); %direccion de la fuente -> 1 x, 2 y
    Qf = fuerzaspuntuales(ip,length(fuerzaspuntuales)); %Valor de la fuerza
    
    %eq1 = ecx == xc(1)
    %eq2 = ecy == xc(2)
    %S = solve(eq1,eq2);
    %Con esos dos valores, utilizarlos con las FF y la Q (supongamos que
    %son x_c nuevos) 
    
    x_c(1) = 0;
    x_c(2) = 1;
    syms Eta Xi;
    for i = 1:nnode
        Ne(i) = subs(N(i),x_c(1),Xi);
        Ne(i) = subs(Ne(i),x_c(2),Eta);
    end
    F = Ne.*Qf;
    
    eqnum = [];                            % Clear the list
    for i =1 : nnode                       % Node cycle
      eqnum = [eqnum,lnods];               % Build the equation number list
    end
    
    if (dir == 1) % Si es en X
        for i = 1 : neleq/2
            force((eqnum(i)*2)-1) = force((eqnum(i)*2)-1) + F(i);
        end
    else
        for i = 1 : neleq/2
            force((eqnum(i)*2)) = force((eqnum(i)*2)) + F(i);
        end
    end
    
  end
  
  % Fuerzas superficiales (constantes)
  for i = 1 : size(sideload,1)
    x = coordinates(sideload(i,1),:) - coordinates(sideload(i,2),:);
    l = sqrt(x*transpose(x));          % Find the length of the side
    ieqn = sideload(i,1)*2;            % Find eq. number for the first node
    force(ieqn-1) = force(ieqn-1) + l*sideload(i,3)/2;        % Add x force 
    force(ieqn  ) = force(ieqn  ) + l*sideload(i,4)/2;        % Add y force

    ieqn = sideload(i,2)*2;           % Find eq. number for the second node
    force(ieqn-1) = force(ieqn-1) + l*sideload(i,3)/2;        % Add x force 
    force(ieqn  ) = force(ieqn  ) + l*sideload(i,4)/2;        % Add y force
  end

% Cargas puntuales (En un nodo)
  for i = 1 : size(pointload,1)
    ieqn = (pointload(i,1)-1)*2 + pointload(i,2);       % Find eq. number
    force(ieqn) = force(ieqn) + pointload(i,3);         % and add the force
  end

% Aplicar las cond. Dirichlet 
  for i = 1 : size(fixnodes,1)
    ieqn = (fixnodes(i,1)-1)*2 + fixnodes(i,2);  % Find the equation number
    u(ieqn) = fixnodes(i,3);                  % and store the solution in u
    fix(i) = ieqn;                        % and mark the eq. as a fix value
  end
  
  force1 = force - StifMat * u;      % Adjust the rhs with the known values

% Compute the solution by solving StifMat * u = force for the remaining
% unknown values of u
  FreeNodes = setdiff( 1:nndof , fix );           
  
  u(FreeNodes) = StifMat(FreeNodes,FreeNodes) \ force1(FreeNodes);
  
  % Reacciones como R = StifMat * u - F
  reaction(fix) = StifMat(fix,1:nndof) * u(1:nndof) - force(fix);

% Calcular las tensiones 
  Strnod = Stress_v1_3(dmat,poiss,thick,pstrs,u);
  
  