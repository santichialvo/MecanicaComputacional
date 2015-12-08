function fdm_plot(data,itime)
%
%
%

xnod = data.xnod;
phi  = data.state;
figure(1);
if rem(itime,data.param.nfreqplot)==0,
    hold on;
    plot(xnod,phi)
    xlabel('X'),ylabel('phi'),title(' Example Test for FDM - # 1')
end