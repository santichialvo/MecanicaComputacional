%
%  analysis of convergence of solution with M 
%

clear all

iM=(1:5);
bfh_2=[];
figure(3);clf;
for M=iM
    Ej_2_6
    bfh_2 = [bfh_2, dphidx_n(indx)];
end

return

type = ['bgrkcmybgrkcmy'];
bfh_error=[];
for k=1:length(iM)
    figure(3);
    semilogy(X,abs(bfh_2(:,k)-bfh_2(:,end)),type(k));
    hold on
    bfh_error = [ bfh_error ; [ norm(abs(bfh_2(:,k)-bfh_2(:,end))) ] ];
end


 
return
figure(3);clf;
semilogy(bfh(:,1),bfh(:,2),'-o',bfh(:,1),bfh(:,3),'-o');grid
xlabel(' M ');ylabel(' int(|phi - phi_{ex}|) ');title(' convergence with M ');
legend('COL','GAL')
eval(['saveas(3,''Ej_2_1_conv'')']); 
eval(['print -depsc2 Ej_2_1_conv'  ]);    
eval(['print -djpeg Ej_2_1_conv'  ]);    
