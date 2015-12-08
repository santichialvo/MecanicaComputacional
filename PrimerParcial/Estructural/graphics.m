function graphics(points,icone,e)

% e = 1 triangulos
% e = 0 cuadrados
% points = vector de Nx2
% icone = vector de Nx4 o Nx3

lenp = length(points(:,1));
leni = length(icone(:,1));

if (e==1)
    lim=3;
else
    lim=4;
end


figure;

for i=1:lenp
    scatter(points(i,1),points(i,2));
    hold on;
end

for i=1:leni
    for j=1:lim
        a = j;
        if (j==lim)
            b = 1;
        else
            b=j+1;
        end
        x = [points(icone(i,a),1) points(icone(i,b),1)];
        y = [points(icone(i,a),2) points(icone(i,b),2)];
        plot(x,y);
    end
end


end

