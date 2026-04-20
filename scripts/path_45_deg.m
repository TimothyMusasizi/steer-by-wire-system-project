Radius = 10;
theta = linspace(0, pi/4, 100);

x1 = linspace(0, 15, 50);
y1 = zeros(size(x1));

x2 = 15 + Radius*sin(theta);
y2 = Radius*(1 - cos(theta));

L_ = 20;
x3 = x2(end) + linspace(0, L*cos(pi/4), 50);
y3 = y2(end) + linspace(0, L*sin(pi/4), 50);

path_x = [x1 x2 x3];
path_y = [y1 y2 y3];

waypoints = [path_x(:), path_y(:)];