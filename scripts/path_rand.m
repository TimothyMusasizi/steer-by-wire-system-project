t = linspace(0, 60, 400);

path_x = t;
path_y = 3*sin(0.15*t) + 1.5*sin(0.4*t + 1);

waypoints = [path_x(:), path_y(:)];