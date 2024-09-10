%% Rose Curve
% Equation in Polar coordinates
% r = a cos(k theta)

% in cartesian coordinates
% x = a cos(k theta) cos(theta)
% y = a cos(k theta) sin(theta)

clc, clearvars, close all;

a = 0.5;
n = 1;
d = 2;
k = n / d;

theta = linspace(0, 4 * pi);

y = [];
x = [];
centre_x = 0;
centre_y = 1;
% robotic arm lengths
l1 = 1;
l2 = 0.8; 

for i = 1 : length(theta)
    curr_theta = theta(i);
    x(i) = a * cos(k * curr_theta) * cos(curr_theta) + centre_x;
    y(i) = a * cos(k * curr_theta) * sin(curr_theta) + centre_y;

    % plot(x(i), y(i));
    % hold on;
    % pause(0.1);
end

figure(1);
plot(x, y);

hold on;

range_theta = 0 : 0.1 * pi : pi;

for i = 1 : length(range_theta)
    for j = 1 : length(range_theta)

        arm_joint = [l1 * cos(range_theta(i)) ; ...
            l1 * sin(range_theta(i))];
        arm_end = arm_joint + [l2 * cos(range_theta(j)); ...
            l2 * sin(range_theta(j))];

        scatter(arm_end(1), arm_end(2));hold on;
    end
end

axis equal;
        

        

