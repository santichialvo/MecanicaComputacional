function pltmsh3d(XX,CONEC,IELM,type_line)
%       pltmsh3d(XX,CONEC,IELM,type_line)
%
%   Dibuja una malla de elementos finitos
%
%   XX:    Tabla de coordenadas nodales
%   CONEC: Tabla de conectividades
%   IELM:  Lista de elementos a dibujar
%

[IN,ndm] = size(XX);
IN = (1:IN);

[bas,nen]=size(CONEC);
lflag=1;
while lflag,
    if sum(CONEC(:,nen))==0,
        CONEC(:,nen)=[];
        nen = nen-1;
    else
        lflag=0;
    end
end

if nargin < 3,
    [IELM,nen]=size(CONEC);
    IELM = (1:IELM);
else
    [bas,nen]=size(CONEC);
end

if nargin < 4,  type_line = 'r-'; end


CONEC = CONEC(IELM,:);

iii = input('Clear screen [y/n] ','s')
if iii=='y',
    %icone      clg
    clf
end
axis('square')
%setaxr(XX);
hold on

nel = length (IELM);
[numel,nen]=size(CONEC);

inn        = zeros(max(IN),1);
inn(IN(:)) = 1:length(IN);

if ndm==2,
    if nen==3,
        ind = [1,2,3,1];
    else
        ind = [1,2,3,4,1];
    end
else
    if nen==4,
        ind = [1,2,3,1,4,2,3,4];
    elseif nen==6,
        ind = [1,2,3,1,4,5,6,4,5,2,3,6];
    else
        ind = [1,2,3,4,1,5,6,7,8,5,6,2,3,7,8,4];
    end
end

nnel = length(ind);
for i=1:nnel
    in1 = (i-1)*nel;
    ii(in1+1:in1+nel) = inn(CONEC(:,ind(i  )));
end

iiv = v2m(ii',nel)';

X1(:,1:ndm)  = XX(inn(:),1:ndm);

if ndm==3,
    view(30,30)
    for k=1:nel,
        inod = iiv(k,:);
        plot3(X1(inod,1),X1(inod,2),X1(inod,3),type_line)
    end
else
    for k=1:nel,
        inod = iiv(k,:);
        plot(X1(inod,1),X1(inod,2),type_line)
    end
end

axis;
hold off
