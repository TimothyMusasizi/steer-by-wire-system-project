path_rand_t = linspace(0, 60, 400);

path_rand_path_x = path_rand_t;
path_rand_path_y = 3*sin(0.15*path_rand_t) + 1.5*sin(0.4*path_rand_t + 1);

waypoints = [path_rand_path_x(:), path_rand_path_y(:)];