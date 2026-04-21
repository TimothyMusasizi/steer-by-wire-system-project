% Script: path_45_deg

path_45_deg_Radius = 10;
path_45_deg_theta = linspace(0, pi/4, 100);

path_45_deg_x1 = linspace(0, 15, 50);
path_45_deg_y1 = zeros(size(path_45_deg_x1));

path_45_deg_x2 = 15 + path_45_deg_Radius * sin(path_45_deg_theta);
path_45_deg_y2 = path_45_deg_Radius * (1 - cos(path_45_deg_theta));

path_45_deg_L = 20;
path_45_deg_x3 = path_45_deg_x2(end) + linspace(0, path_45_deg_L * cos(pi/4), 50);
path_45_deg_y3 = path_45_deg_y2(end) + linspace(0, path_45_deg_L * sin(pi/4), 50);

path_45_deg_path_x = [path_45_deg_x1 path_45_deg_x2 path_45_deg_x3];
path_45_deg_path_y = [path_45_deg_y1 path_45_deg_y2 path_45_deg_y3];

% Return the waypoints
waypoints = [path_45_deg_path_x(:), path_45_deg_path_y(:)];