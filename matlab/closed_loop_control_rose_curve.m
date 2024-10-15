clc, clear all, close all;

x0 = 0;
y0 = 0;
th0 = pi / 2;

global xd yd A k i d error_parameter num_points;

A = 2;
k = 0.5;
i = 1;
d = 0.01;

% error_parameter
error_parameter = 10;

rose_curve_theta = linspace(0, 4 * pi);
num_points = length(rose_curve_theta);

function [x, y] = find_rose_curve_coordinates(given_theta)
global xd yd A k;

x = A * cos(k * given_theta) * cos(given_theta);
y = A * cos(k * given_theta) * sin(given_theta);

end

[xd, yd] = arrayfun(@find_rose_curve_coordinates, rose_curve_theta);
% plot(xd, yd);
% axis equal;

function y = mobile(t, x)

global xd yd A k error_parameter i d num_points;

x_pos = x(1);
y_pos = x(2);
th = x(3);

y1 = x_pos + d * cos(th);
y2 = y_pos + d * sin(th);

B = [cos(th), -d * sin(th);
    sin(th), d * cos(th)];

% choosing xd_dot and yd_dot as zero
% u1 = xd_dot - error_parameter * e1
u1 = -error_parameter * (y1 - xd(i));
u2 = -error_parameter * (y2 - yd(i));

if (y1 - xd(i))^2 + (y2 - yd(i))^2 < 1e-6
    i = i + 1;
    if i == num_points + 1
        i = 1;
    end
end

inp = inv(B) * [u1; u2];
v = inp(1);
w = inp(2);

y = [v * cos(th);
    v * sin(th);
    w];


end


[t, points] = ode45(@mobile, [0 100], [x0; y0; th0]);


plot(points( : , 1), points( : , 2));
