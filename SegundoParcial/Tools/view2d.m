function view2d(xnod,icone,phi,job)
%
%     view2d(xnod,icone,phi,job)
%
%  job ne 0 for using patch instead of fill
%

if nargin<4, job=0; end

% dibuja la malla
[numel,nel]=size(icone);
X = []; Y=[]; Z=[];
for k=1:nel,
  X = [ X ; xnod(icone(:,k),1)' ]; 
  Y = [ Y ; xnod(icone(:,k),2)' ]; 
  Z = [ Z ; phi(icone(:,k),1)' ];
end
if job~=0
    patch(X,Y,Z);
else
    fill(X,Y,Z);
end
