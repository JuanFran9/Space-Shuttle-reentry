function stabilitytimestep(tmax, nx, thick)

% Function analyses stability of the four different methods for a range of
% time steps

% Input arguments: 
% tmax        - maximum time (s)
% nx          - number of spatial steps
% thick       - thickness of the tile (m)

i=0; 

% Calculates the temperature values at different timesteps for each method
for nt = 41:20:1001 
    i=i+1; 
    dt(i) = tmax/(nt-1); 
    disp (['nt = ' num2str(nt) ', dt = ' num2str(dt(i)) ' s'])
    [~, ~, u] = shuttle(tmax, nt, thick, nx, 'forward', false); 
    uf(i) = u(end, 1); 
    [~, ~, u] = shuttle(tmax, nt, thick, nx, 'backward', false); 
    ub(i) = u(end, 1); 
    [~, ~, u] = shuttle(tmax, nt, thick, nx, 'dufort-frankel', false); 
    ud(i) = u(end, 1);
    [~, ~, u] = shuttle(tmax, nt, thick, nx, 'crank-nicolson', false); 
    uc(i) = u(end, 1);
end

% Defines the boundary limits at which the method exceed the desired
% accuracy
boundary1 = 158.6 + 0.5;
boundary2 = 158.6 - 0.5;

% Plots the temperature againt the timestep
plot(dt, [uf; ub; ud; uc]) 

% Plots the boundary limits
hold on
plot([0 tmax], [boundary1 boundary1],'--k')

plot([0 tmax], [boundary2 boundary2],'--k')

plot([77 77], [0 boundary2],'--k')

% Defines axis limits and labels on graph
ylim([150 170]) 
xlim ([0 100])
hold off
xlabel('Timestep size (s)')
ylabel('Midpoint Temperature (C)')
legend ('Forward', 'Backward', 'Dufort-Frankel', 'Crank-Nicolson')
end
