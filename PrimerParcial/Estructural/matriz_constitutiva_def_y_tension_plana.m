function D = matriz_constitutiva_def_y_tension_plana(E,v,def)

if (def==0) %deformacion plana 
    D = [1-v, v, 0; v 1-v 0; 0 0 (1-2*v)/2];
    D = E/((1+v)*(1-2*v)) .* D;
else %tension plana
    D = [1 v 0; v 1 0; 0 0 (1-v)/2];
    D = E/(1-v^2) .* D;
end


end

