%
%  to generate plots for the theoretical notes
%

clear all

iM=(2:9);
bfh = []; bfh_2=[];
for M=iM
    Ej_2_3
    %    bfh=[bfh;[M,norm(abs(phi_ex-phi_col)),norm(abs(phi_ex-phi_gal))]];
    bfh=[bfh;[M,phi_n(1),phi_n(end)]];    
    bfh_2 = [bfh_2, phi_n'];
end

return
figure(3);clf;
semilogy(bfh(:,1),bfh(:,2),'-o',bfh(:,1),bfh(:,3),'-o');grid
xlabel(' M ');ylabel(' int(|phi - phi_{ex}|) ');title(' convergence with M ');
legend('COL','GAL')
eval(['saveas(3,''Ej_2_1_conv'')']); 
eval(['print -depsc2 Ej_2_1_conv'  ]);    
eval(['print -djpeg Ej_2_1_conv'  ]);    
