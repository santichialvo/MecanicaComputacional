%
%  to generate plots for the theoretical notes
%
%  be sure to choose the appropriate function to be approximated
%  edit file ffun_Ej_2_0_1D.m and change properly.
%

clear all

iM = [2,3,4];
for L=iM
    Ej_2_0_1D
    nn=find(abs(ZI-phi_n)<1e-10); 
    figure(1);clf;
    subplot(121);plot(XI,ZI,'-',XI,phi_n);grid
    xlabel('X');ylabel('phi');title(['solution with L = ' num2str(L) ' Galerkin 1D' ]);grid on
    subplot(122);plot(XI,abs(ZI-phi_n))
    if isempty(nn)==0, subplot(122);hold on;plot(XI(nn),zeros(length(nn),1),'ro'); end
    xlabel('X');ylabel(' | phi - phi_{ex} | ');title(['error with L = ' num2str(L) ' Galerkin 1D' ]);grid on
    eval(['saveas(1,''fg_Ej_2_0_1D_L=' num2str(L) ''')']); 
    eval(['print -depsc2 fg_Ej_2_0_1D_L=' num2str(L) ]);    
    eval(['print -djpeg fg_Ej_2_0_1D_L=' num2str(L) ]);        
end

bfh = [];
for iM=2:1:15
    L = iM;
    Ej_2_0_1D;
    bfh = [bfh;[iM,err]];    
end

figure(3);clf;
semilogy(bfh(:,1),bfh(:,2),'-o');grid
xlabel(' L ');ylabel(' int(|phi - phi_{ex}|) ');title(' convergence with L ');
eval(['saveas(3,''fg_Ej_2_0_1D_conv'')']); 
eval(['print -depsc2 fg_Ej_2_0_1D_conv'  ]);    
eval(['print -djpeg fg_Ej_2_0_1D_conv'  ]);    
