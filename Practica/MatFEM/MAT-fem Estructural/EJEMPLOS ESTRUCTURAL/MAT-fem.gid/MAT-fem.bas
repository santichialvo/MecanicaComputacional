*loop elems
*if(elemsmat==0)
*messagebox - An element without any material was found, some posibilities are that you forget to asign a material to the problem or there is a repited entity over another - Process finished with error
*endif
*end
*loop nodes
*if(NodesCoord(3)==0)
*else
*messagebox - This is a plane problem so z coordinate must be =0 for all nodes - Process finished with error
*endif
*end
*set var MATERIAL=0
*loop materials
*set var MATERIAL=Operation(MATERIAL(int)+1)
*end
*if(MATERIAL>1)
*messagebox - This program only allows one material
*endif
%=======================================================================
% MAT-fem 1.0  - MAT-fem is a learning tool for undestanding 
%                the Finite Element Method with MATLAB and GiD
%=======================================================================
% PROBLEM TITLE = Titulo del problema
%
%  Material Properties
%
*loop materials
*format "  young = %20.5f ;"
*MatProp(1)
*format "  poiss = %20.5f ;"
*MatProp(2)
*if(strcmp(GenData(3),"No")==0)
  denss = 0.00 ;
*else
*format "  denss = %20.5f ;"
*MatProp(3)
*endif
*if((strcmp(GenData(2),"Plane-Stress")==0))
  pstrs =  1 ;
*format "  thick = %20.5f ;"
*MatProp(4)
*else
  pstrs =  0 ;
  thick =  1 ;
*endif
%
% Coordinates
%
global coordinates
coordinates = [
*loop nodes
*format " %15.5f  %15.5f "
*if(NodesNum == npoin)
*NodesCoord(1) , *NodesCoord(2) ] ; 
*else
*NodesCoord(1) , *NodesCoord(2) ;
*endif
*end nodes
%
% Elements
%
global elements
elements = [
*loop elems
*format " %6i  %6i  %6i  %6i  "
*if(nnode == 3)
*if(ElemsNum == nelem)
*ElemsConec(1) , *ElemsConec(2) , *ElemsConec(3) ] ; 
*else
*ElemsConec(1) , *ElemsConec(2) , *ElemsConec(3) ; 
*endif
*else
*if(ElemsNum == nelem)
*ElemsConec(1) , *ElemsConec(2) , *ElemsConec(3) , *ElemsConec(4) ] ; 
*else
*ElemsConec(1) , *ElemsConec(2) , *ElemsConec(3) , *ElemsConec(4) ; 
*endif
*endif
*end elems
%
% Fixed Nodes
%
fixnodes = [
*Set Cond Point_Constraints *nodes *or(1,int) *or(3,int)
*Add Cond Linear_Constraints *nodes *or(1,int) *or(3,int)
*Set var nod = 0
*loop nodes *OnlyInCond
*if(Cond(1,Int) == 1)
*Set var nod = nod + 1
*endif
*if(Cond(3,Int) == 1)
*Set var nod = nod + 1
*endif
*end nodes
*Set var nod2 = 1
*loop nodes *OnlyInCond
*if(Cond(1,Int) == 1)
*format " %6i %10.5f "
*if(nod==nod2)
*NodesNum() , 1 , *Cond(2) ] ;
*else
*NodesNum() , 1 , *Cond(2) ;
*endif
*Set var nod2 = nod2 + 1
*endif
*if(Cond(3,Int) == 1)
*format " %6i %10.5f "
*if(nod==nod2)
*NodesNum() , 2 , *Cond(4) ] ;
*else
*NodesNum() , 2 , *Cond(4) ;
*endif
*Set var nod2 = nod2 + 1
*endif
*end nodes
%
% Point loads
%
*Set Cond Point_Load *nodes
*if((CondNumEntities(int)>0))
*Set var nod = 0
pointload = [
*loop nodes *OnlyInCond
*Set var nod = nod + 1
*format " %6i %10.5f "
*NodesNum , 1 , *cond(1,real) ;
*format " %6i %10.5f "
*if(CondNumEntities(int)==nod)
*NodesNum , 2 , *cond(2,real) ] ;
*else
*NodesNum , 2 , *cond(2,real) ;
*endif
*end nodes
*else
pointload = [ ] ;
*endif
%
% Side loads
%
*Set Cond Uniform_Load *elems *CanRepeat
*if(CondNumEntities(int)>0)
*Set var nod = 0
sideload = [
*loop elems *OnlyInCond
*Set var nod = nod + 1
*format " %6i %6i %10.5f %10.5f "
*if(CondNumEntities(int)==nod)
*globalnodes(1) , *globalnodes(2) , *cond(1) , *cond(2) ];
*else
*globalnodes(1) , *globalnodes(2) , *cond(1) , *cond(2) ;
*endif
*end elems
*else
sideload = [ ];
*endif

