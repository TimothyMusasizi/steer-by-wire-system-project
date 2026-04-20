t = linspace(0, 40, 200);

lane_width = 3;

path_x = t;
path_y = lane_width * tanh(0.2*(t - 20));

waypoints = [path_x(:), path_y(:)];