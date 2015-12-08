function [A] = area_ele(nodos)
    A = 0.5*det([1 nodos(1,1) nodos(1,2);
                 1 nodos(2,1) nodos(2,2);
                 1 nodos(3,1) nodos(3,2);]);
end