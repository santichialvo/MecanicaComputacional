%
%  to generate plots for the theoretical notes
%
%  be sure to choose the appropriate function to be approximated
%  edit file ffun_Ej_2_0_2D.m and change properly if using continuous
%  function approximation. Be carefull if it is a discrete function
%

clear all

iM = [2,3,4];
for L=iM
    M = L;
    Ej_2_0_2D
    nn=find(abs(ZI-phi_n)<1e-10); 
    figure(1);clf;
    subplot(121);mesh(X,Y,Z);
    title(' Sample points distribution ')
%    title(' Continuous function ')    
    subplot(122);
    mesh(XI,YI,phi_n);
    title(' Numerical approximation ')
    eval(['saveas(1,''fg_Ej_2_0_2D_L=' num2str(L) ''')']); 
    eval(['print -depsc2 fg_Ej_2_0_2D_L=' num2str(L) ]);    
    eval(['print -djpeg fg_Ej_2_0_2D_L=' num2str(L) ]);        
end

bfh = [];
for iM=3:2:11
    L = iM;
    M = L    
    pause(0.1)
    Ej_2_0_2D;
    bfh = [bfh;[iM,err]];    
end

figure(3);clf;
semilogy(bfh(:,1),bfh(:,2),'-o');grid
xlabel(' L ');ylabel(' int(|phi - phi_{ex}|) ');title(' convergence with L ');
eval(['saveas(3,''fg_Ej_2_0_2D_conv'')']); 
eval(['print -depsc2 fg_Ej_2_0_2D_conv'  ]);    
eval(['print -djpeg fg_Ej_2_0_2D_conv'  ]);    
