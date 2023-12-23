function stabilityspatialstep(tmax, dt, thick)

% Function analyses stability of the four different methods for a range of
% spatial steps

% Input arguments: 
% tmax        - maximum time (s)
% dt          - timestep size
% thick       - thickness of the tile (m)

i=0; 
nt = tmax/dt; % Calculates the number of spatial steps

% Calculates the temperature values at different spatialsteps for each method
for nx = 4:1:80 
    i=i+1; 
    dx(i) = thick/(nx-1); 
    disp (['nx = ' num2str(nx) ', dx = ' num2str(dx(i)) ' s'])
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

% Plots the temperature againt the spatialstep
plot(dx, [uf; ub; ud; uc]) 

% Plots the boundary limits
hold on
plot([0 tmax], [boundary1 boundary1],'--k')

plot([0 tmax], [boundary2 boundary2],'--k')

plot([0.0068 0.0068], [0 boundary2],'--k')

% Defines axis limits and labels on graph
ylim([150 170]) 
xlim ([0 0.018])
xlabel('Spatialstep size (m)')
ylabel('Midpoint Temperature (C)')
legend ('Forward', 'Backward', 'Dufort-Frankel', 'Crank-Nicolson')
end