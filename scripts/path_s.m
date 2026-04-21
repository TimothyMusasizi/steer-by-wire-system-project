path_s_t = linspace(0, 40, 200);

path_s_lane_width = 3;

path_s_path_x = path_s_t;
path_s_path_y = path_s_lane_width * tanh(0.2*(path_s_t - 20));

waypoints = [path_s_path_x(:), path_s_path_y(:)];