R = 6;
theta = linspace(0, pi/2, 100);

x1 = linspace(0, 15, 50);
y1 = zeros(size(x1));

x2 = 15 + R*sin(theta);
y2 = -R*(1 - cos(theta));

y3 = linspace(y2(end), y2(end) - 15, 50);
x3 = (15 + R) * ones(size(y3));

path_x = [x1 x2 x3];
path_y = [y1 y2 y3];

waypoints = [path_x(:), path_y(:)];