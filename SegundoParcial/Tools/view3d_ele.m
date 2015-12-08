function [phi_nod]=view3d_ele(xnod,icone,phi_ele)
%
%      [phi_nod]=view3d_ele(xnod,icone,phi_ele)
%
%  phi_ele : campo escalar por elemento
%  phi_nod : campo escalar por nodo
%

[numnp,ndm]=size(xnod);
[numel,nen]=size(icone);
phi_nod=zeros(numnp,1);
for inod=1:nen,
   nodes=icone(:,inod);
   phi_nod(nodes,1)=phi_nod(nodes,1)+phi_ele/nen;
end
view3d(xnod,icone,phi_nod);