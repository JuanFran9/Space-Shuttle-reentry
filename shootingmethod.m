function [suggthick,minthick]=shootingmethod(method, nx, nt, tmax, targetInternal)
% Function calculates the minimum thickness of the tile required to maintain the internal surface temperature below the desired limit 
 
% Input arguments: 
% method      - approximation method
% nx          - number of spatial steps
% nt          - number of timesteps 
% targetInternal - internal surface temperature of tile (deg C)
 
% Return arguments:
% suggthick   - values of iterations for suggested thickness 
% minthick     - minimum thickness to maintain a temperature below the
% desired one
 
 
    maxerror = 5;        % Defines the maximum temperature error
    
    suggthick = [0.01,0.1]; % To calculate the first and second errors, two initial values for the thickness are specified
    
                            
    doplot = false;         % Doesn't perform the graph plot from shuttle.m
 
% Finding required thickness 
% Calculates inner temperature using first two thickness guesses 
    for i=1:2
        [~, ~, u] = shuttle(tmax, nt, suggthick(i), nx, method, doplot); 
        maxinner(i)=max(u(:,1));
        error(i) = maxinner(i) - targetInternal;             
    end
 % Loop until a guess for the thickness results in an appropriately accurate 
 % inner temperature
    n = 2;
    while abs(error(end)) > maxerror  % Loop until error is smaller than the maximum allowed     
        [~, t, u] = shuttle(tmax, nt, suggthick(n), nx, method, doplot);       
        error(n) = max(u(:,1)) - targetInternal;
        % Generates a linear approxiation to following guess    
        G = (error(n) - error(n-1))/(suggthick(n) - suggthick(n-1)); % G = Gradient 
        I = error(n) - G*suggthick(n);                               % I = Y Intercept
        suggthick(n+1) = -I/G;
        n = n + 1;
        
        %plot the different iterations
        plot([0 tmax],[targetInternal targetInternal],'--k')
        hold on    
        plot(t,u(:,1))
        xlabel('Time (s)')
        ylabel('Temperature (deg)')
        legend('Maximum temperature limit')
    end
 % Extracts from the thickness array the last thickness guess which is the final
 % solution
    minthick=suggthick(end);
end
