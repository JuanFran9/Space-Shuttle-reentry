function internalTemp(tmax,nt,nx)

% Function calculates the internal temperature against time for diffrent
% tile thicknesses

% Input arguments: 
% tmax        - maximum time (s)
% nt          - number of time steps
% nx       - number of spatial steps

doplot = false;
method = 'crank-nicolson';

for xmax = 0.01:0.02:0.14 % Loop for thicknesses between 0.01 and 0.14 with 0.02m intervals
    [~, t, u] = shuttle(tmax, nt, xmax, nx, method, doplot);
   
    figure(1)
    plot(t,u(:,1),'DisplayName',['Thickness = ' (num2str(xmax))]) % Plots the internal temp for each tile thcikness
    
    legend()
    xlabel('Time (s)')
    ylabel('Temperature (deg)')
  
    hold on
    
end

plot([0 tmax],[175 175],'--k','DisplayName', '175 degrees celcius')
hold off

end
