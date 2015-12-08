function [ifaceb,face_con,face_con_add] = pfbou3d(xnod,icone,ijob)
%
%    [ifaceb,face_con,face_con_add] = pfbou3d(xnod,icone,ijob)
%
%    if ijob>0, also face_con
%   
%   face_con_add : para el caso que el elemento pueda tener dos tipos
%   distintos de paneles (caso de los prismas)
%

if nargin < 3, ijob=0; end

tol = 1e-10;

[nnod,ndm] = size(xnod);
[nele,nen] = size(icone);

if nen==8,
    inoca = [1 4 3 2 ; 
        1 2 6 5 ;
        6 2 3 7 ;
        8 7 3 4 ;
        1 5 8 4 ;
        8 5 6 7 ];
elseif nen==4,
    inoca = [1 2 4 ; 
        2 3 4 ;
        1 4 3 ;
        1 3 2 ];
else
    inoca = [1 3 2 0 ; 
        1 2 5 4 ;
        2 3 6 5 ;
        1 4 6 3 ;
        4 5 6 0 ];
end

[nface,mface]=size(inoca);

inofa = (nnod+1)*ones(nele*nface,mface);
ifael  = [];

for k=1:nface,
    faces = (1:nface:nele*nface)'+k-1;
    ifael(1:nele,k) = faces;
    mm = mface;
    if (nen==6)&(k==1 | k==5), mm=3;end
    for m=1:mm,
        inofa(faces,m) = icone(:,inoca(k,m));
    end
end

% Remuevo caras duplicadas
% Ordeno nodos por cara por orden decreciente 
[jnofa,is0] = sort(inofa');
jnofa      = jnofa';

% ordeno por multiples llaves
[knofa,is1] = mksort(jnofa);

% calculo operador inverso de ordenamiento
ism1(is1,1) = (1:length(is1))'; 

% Reordeno el arreglo de caras por elemento
for k=1:nface,
    ifael(:,k)= ism1(ifael(:,k));
end

% Calculo aquellas caras duplicadas
mask = (sum(abs((diff(knofa))'))'~=0);
mask = [1;mask];

jfaces = find(mask==0);
jfaces = m2v([jfaces-1 , jfaces]);

kfaces = (1:length(mask))';
kfaces(jfaces) = zeros(length(jfaces),1);

clear jfaces mask knofa inofa jnofa ism1 is1

ifaceb = [];

for k=1:nface,
    iaux = kfaces(ifael(:,k));
    iaux = (find(iaux~=0));
    ifaceb = [ifaceb ; [iaux ones(length(iaux),1)*k ] ];
end

face_con_add = [];
if ijob>0 & isempty(ifaceb)==0,
    %    keyboard;pause
    face_con=[];
    %    for k=1:nen,
    
    if nen==6,
        face_con_quad = [];
        % con prismas hay que distinguir entre caras triangulares y
        % cuadrangulares
        for k=1:nface,        
            nn=find(ifaceb(:,2)==k);
            if isempty(nn)==0,
                iii=inoca(k,:);
                jjj=(find(iii)>0);
                if isempty(jjj)==0,
                    iii=iii(jjj);                    
                    if k==1 | k==5
                        face_con=[face_con;icone(ifaceb(nn,1),iii)];
                    else
                        face_con_quad=[face_con_quad;icone(ifaceb(nn,1),iii)];                        
                    end
                end
            end
        end        
        face_con_add = face_con_quad;
    else
        for k=1:nface,        
            nn=find(ifaceb(:,2)==k);
            if isempty(nn)==0,
                iii=inoca(k,:);
                jjj=(find(iii)>0);
                if isempty(jjj)==0,
                    iii=iii(jjj);
                    face_con=[face_con;icone(ifaceb(nn,1),iii)];
                end
            end
        end
    end
    
end

if isempty(ifaceb)==1
    error(' Problems finding boundary elements ')
end

