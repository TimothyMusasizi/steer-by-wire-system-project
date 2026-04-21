% Script: plot_path

%% ===============================
%  LOAD DATA
% ================================

% Extract vehicle data (timeseries → vectors)
plot_path_vx = squeeze(out.pos_X.Data);
plot_path_vy = squeeze(out.pos_Y.Data);
plot_path_t  = squeeze(out.pos_X.Time);   % 🔥 FIXED (was missing)

% Waypoints (already defined in workspace)
plot_path_wx = waypoints(:,1);
plot_path_wy = waypoints(:,2);

%% ===============================
%  MAIN TRAJECTORY PLOT
% ================================

figure;
plot(plot_path_wx, plot_path_wy, 'k--', 'LineWidth', 2); hold on;
plot(plot_path_vx, plot_path_vy, 'b', 'LineWidth', 2);

scatter(plot_path_wx(1), plot_path_wy(1), 80, 'g', 'filled');
scatter(plot_path_wx(end), plot_path_wy(end), 80, 'r', 'filled');

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

plot_path_error = zeros(length(plot_path_vx),1);

for plot_path_i = 1:length(plot_path_vx)
    plot_path_dx = plot_path_wx - plot_path_vx(plot_path_i);
    plot_path_dy = plot_path_wy - plot_path_vy(plot_path_i);
    plot_path_error(plot_path_i) = min(sqrt(plot_path_dx.^2 + plot_path_dy.^2));
end

figure;
plot(plot_path_error, 'LineWidth', 2);
title('Tracking Error Over Time');
xlabel('Time Step');
ylabel('Error (m)');
grid on;

%% ===============================
%  TRAJECTORY WITH TRAIL EFFECT
% ================================

figure;
plot(plot_path_wx, plot_path_wy, 'k--', 'LineWidth', 2); hold on;

for plot_path_i = 1:10:length(plot_path_vx)
    plot(plot_path_vx(1:plot_path_i), plot_path_vy(1:plot_path_i), ...
        'b', 'LineWidth', 1.5);
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

if exist('vehicle_theta', 'var')
    
    plot_path_theta = squeeze(vehicle_theta.Data);
    
    % Dynamic scaling
    plot_path_scale = max(range(plot_path_wx), range(plot_path_wy));
    plot_path_L = 0.05 * plot_path_scale;

    figure;

    % Static path
    plot(plot_path_wx, plot_path_wy, 'k--', 'LineWidth', 2); hold on;

    % Graphics handles (FAST)
    plot_path_h_traj = plot(NaN, NaN, 'b', 'LineWidth', 1.5);
    plot_path_h_vehicle = fill(NaN, NaN, 'b', 'EdgeColor', 'k', 'LineWidth', 1.2);

    axis equal;
    grid on;

    % 🔥 Fix axis once (no jitter, faster)
    xlim([min(plot_path_wx)-5, max(plot_path_wx)+5]);
    ylim([min(plot_path_wy)-5, max(plot_path_wy)+5]);

    title('Vehicle Motion Animation');

    for plot_path_i = 2:5:length(plot_path_vx)
        tic;
        
        plot_path_px = plot_path_vx(plot_path_i);
        plot_path_py = plot_path_vy(plot_path_i);
        plot_path_th = plot_path_theta(plot_path_i);
        
        % Update trajectory
        set(plot_path_h_traj, ...
            'XData', plot_path_vx(1:plot_path_i), ...
            'YData', plot_path_vy(1:plot_path_i));
        
        % Update vehicle triangle
        plot_path_tri_x = plot_path_px + plot_path_L * ...
            [cos(plot_path_th), cos(plot_path_th+2.5), cos(plot_path_th-2.5)];
        
        plot_path_tri_y = plot_path_py + plot_path_L * ...
            [sin(plot_path_th), sin(plot_path_th+2.5), sin(plot_path_th-2.5)];
        
        set(plot_path_h_vehicle, ...
            'XData', plot_path_tri_x, ...
            'YData', plot_path_tri_y);
        
        drawnow limitrate;
        
        % Real-time sync
        plot_path_speed = 20; %2x faster
        plot_path_dt = plot_path_t(plot_path_i) - plot_path_t(plot_path_i-1);
        pause(max(0, plot_path_dt/plot_path_speed - toc));
    end
end

%% ===============================
%  PERFORMANCE METRICS
% ================================

fprintf('===== PERFORMANCE METRICS =====\n');
fprintf('Max Error: %.4f m\n', max(plot_path_error));
fprintf('Mean Error: %.4f m\n', mean(plot_path_error));
fprintf('RMS Error: %.4f m\n', sqrt(mean(plot_path_error.^2)));