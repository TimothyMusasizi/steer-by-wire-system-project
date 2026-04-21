% Script: path_u

path_u_t = linspace(0, pi, 100);

path_u_R = 8; % ensures 16 m diameter

path_u_x1 = linspace(0, 20, 50);
path_u_y1 = zeros(size(path_u_x1));

path_u_x2 = 20 + path_u_R * sin(path_u_t);
path_u_y2 = path_u_R * (1 - cos(path_u_t));

path_u_x3 = linspace(20, 0, 50);
path_u_y3 = 2 * path_u_R * ones(size(path_u_x3));

path_u_path_x = [path_u_x1 path_u_x2 path_u_x3];
path_u_path_y = [path_u_y1 path_u_y2 path_u_y3];

% Keep this as requested
waypoints = [path_u_path_x(:), path_u_path_y(:)];