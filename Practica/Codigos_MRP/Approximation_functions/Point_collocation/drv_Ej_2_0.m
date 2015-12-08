%
%  to generate plots for the theoretical notes
%

clear all

iM = [2,3,4,9];
for M=iM
    Ej_2_0
    nn=find(abs(phi_n-phi_p)<1e-10);xx(nn)    
    figure(1);clf;
    subplot(121);plot(xx,phi_p,xx,psi_p);
    subplot(121);hold on;plot(xx,phi_n,'.r')
    xlabel('X');ylabel('phi');title(['solution with M = ' num2str(M)]);grid on
    subplot(122);plot(xx,abs(phi_p-phi_n))
    subplot(122);hold on;plot(xx(nn),zeros(length(nn),1),'ro')
    xlabel('X');ylabel(' | phi - phi_{ex} | ');title(['error with M = ' num2str(M)]);grid on
    legend([ ' o: collocation points '])
    eval(['saveas(1,''fg_Ej_2_0_M=' num2str(M) ''')']); 
    eval(['print -depsc2 fg_Ej_2_0_M=' num2str(M) ]);    
    eval(['print -djpeg fg_Ej_2_0_M=' num2str(M) ]);        
end

bfh = [];
for iM=1:1:15
    M = iM;
    Ej_2_0;
    bfh = [bfh;[iM,err]];    
end

figure(3);clf;
semilogy(bfh(:,1),bfh(:,2),'-o');grid
xlabel(' M ');ylabel(' int(|phi - phi_{ex}|) ');title(' convergence with M ');
eval(['saveas(3,''fg_Ej_2_0_conv'')']); 
eval(['print -depsc2 fg_Ej_2_0_conv'  ]);    
eval(['print -djpeg fg_Ej_2_0_conv'  ]);    
