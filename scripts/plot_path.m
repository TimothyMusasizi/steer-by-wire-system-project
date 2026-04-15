%% ===============================
%  LOAD DATA
% ================================

% Extract vehicle data (timeseries → vectors)
vx = squeeze(out.pos_X.Data);
vy = squeeze(out.pos_Y.Data);

% Waypoints (already defined in workspace)
wx = waypoints(:,1);
wy = waypoints(:,2);

%% ===============================
%  MAIN TRAJECTORY PLOT
% ================================

figure;
plot(wx, wy, 'k--', 'LineWidth', 2); hold on;
plot(vx, vy, 'b', 'LineWidth', 2);

% Start & End points
scatter(wx(1), wy(1), 80, 'g', 'filled');
scatter(wx(end), wy(end), 80, 'r', 'filled');

legend('Reference Path', 'Vehicle Trajectory', 'Start', 'End');
xlabel('X Position (m)');
ylabel('Y Position (m)');
title('Path Tracking Performance');
axis equal;
grid on;
set(gca, 'FontSize', 12);

%% ===============================
%  TRACKING ERROR (Closest Distance)
% ================================

error = zeros(length(vx),1);

for i = 1:length(vx)
    dx = wx - vx(i);
    dy = wy - vy(i);
    error(i) = min(sqrt(dx.^2 + dy.^2));
end

figure;
plot(error, 'LineWidth', 2);
title('Tracking Error Over Time');
xlabel('Time Step');
ylabel('Error (m)');
grid on;

%% ===============================
%  TRAJECTORY WITH TRAIL EFFECT
% ================================

figure;
plot(wx, wy, 'k--', 'LineWidth', 2); hold on;

for i = 1:10:length(vx)
    plot(vx(1:i), vy(1:i), 'b', 'LineWidth', 1.5);
    drawnow;
end

title('Trajectory Evolution');
xlabel('X (m)');
ylabel('Y (m)');
axis equal;
grid on;

%% ===============================
%  ANIMATED VEHICLE (WITH HEADING)
% ================================

% OPTIONAL: Only if you have theta
if exist('vehicle_theta', 'var')
    
    theta = vehicle_theta.Data;
    
    figure;
    
    for i = 1:10:length(vx)
        clf;
        
        % Plot path
        plot(wx, wy, 'k--', 'LineWidth', 2); hold on;
        
        % Current position
        px = vx(i);
        py = vy(i);
        th = theta(i);
        
        % Draw vehicle (triangle)
        L = 1.5;
        tri_x = px + L*[cos(th), cos(th+2.5), cos(th-2.5)];
        tri_y = py + L*[sin(th), sin(th+2.5), sin(th-2.5)];
        
        fill(tri_x, tri_y, 'b');
        
        % Draw trail
        plot(vx(1:i), vy(1:i), 'b', 'LineWidth', 1.2);
        
        axis equal;
        grid on;
        xlim([min(wx)-5, max(wx)+5]);
        ylim([min(wy)-5, max(wy)+5]);
        
        title('Vehicle Motion Animation');
        drawnow;
    end
end

%% ===============================
%  PERFORMANCE METRICS
% ================================

fprintf('===== PERFORMANCE METRICS =====\n');
fprintf('Max Error: %.4f m\n', max(error));
fprintf('Mean Error: %.4f m\n', mean(error));
fprintf('RMS Error: %.4f m\n', sqrt(mean(error.^2)));