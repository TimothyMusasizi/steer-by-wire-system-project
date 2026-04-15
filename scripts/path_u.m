t = linspace(0, pi, 100);

R = 8; % <-- ensures 16 m diameter

x1 = linspace(0, 20, 50);
y1 = zeros(size(x1));

x2 = 20 + R*sin(t);
y2 = R*(1 - cos(t));

x3 = linspace(20, 0, 50);
y3 = 2*R * ones(size(x3));

path_x = [x1 x2 x3];
path_y = [y1 y2 y3];

waypoints = [path_x(:), path_y(:)];