%% Forward Kinematics
clc, clearvars, close all;

th1 = 0 : 0.1 * pi : pi;
th2 = 0 : 0.1 * pi : pi;

l1 = 1;
l2 = 0.8;

for i = 1 : length(th1)
    for j = 1 : length(th2)

        v1 = [l1 * cos(th1(i)) ; l1 * sin(th1(i))];
        v2 = v1 + [l2 * cos(th2(j)); l2 * sin(th2(j))];

        scatter(v2(1), v2(2)); hold on; axis equal;

    end
end

