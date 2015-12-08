%
%  to generate plots for the theoretical notes
%

clear all

iM=(2:9);
bfh = [];
for M=iM
    Ej_2_1
    bfh=[bfh;[M,norm(abs(phi_ex-phi_col)),norm(abs(phi_ex-phi_gal))]];
end

figure(3);clf;
semilogy(bfh(:,1),bfh(:,2),'-o',bfh(:,1),bfh(:,3),'-o');grid
xlabel(' M ');ylabel(' int(|phi - phi_{ex}|) ');title(' convergence with M ');
legend('COL','GAL')
eval(['saveas(3,''Ej_2_1_conv'')']); 
eval(['print -depsc2 Ej_2_1_conv'  ]);    
eval(['print -djpeg Ej_2_1_conv'  ]);    
