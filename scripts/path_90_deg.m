% Script: path_90_deg

path_90_deg_R = 6;
path_90_deg_theta = linspace(0, pi/2, 100);

path_90_deg_x1 = linspace(0, 15, 50);
path_90_deg_y1 = zeros(size(path_90_deg_x1));

path_90_deg_x2 = 15 + path_90_deg_R * sin(path_90_deg_theta);
path_90_deg_y2 = -path_90_deg_R * (1 - cos(path_90_deg_theta));

path_90_deg_y3 = linspace(path_90_deg_y2(end), path_90_deg_y2(end) - 15, 50);
path_90_deg_x3 = (15 + path_90_deg_R) * ones(size(path_90_deg_y3));

path_90_deg_path_x = [path_90_deg_x1 path_90_deg_x2 path_90_deg_x3];
path_90_deg_path_y = [path_90_deg_y1 path_90_deg_y2 path_90_deg_y3];

% Keep this as requested
waypoints = [path_90_deg_path_x(:), path_90_deg_path_y(:)];