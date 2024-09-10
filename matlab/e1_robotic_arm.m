% clear command window
clc, clearvars, close all;


l1 = 1;
l2 = 0.8;

th = 0 : 0.1 * pi : 2 * pi;
% centre is (0, 1.2)
y = 1.2 + 0.3 * cos( th );
x = 0 + 0.3 * sin( th );

plot(x, y);
axis equal;
xlim([0.5, 1.5]);
ylim([0, 1]);

th1 = zeros(1, length(th));
th2 = zeros(1, length(th));

for i = 1 : length(th)
    th1(i) = acos( (x(i)^2 + y(i)^2 + l1^2 - l2^2)...
                / 2/l1/sqrt(x(i)^2 + y(i)^2)) + atan2(y(i), x(i));
    th2(i) = atan2( y(i) - l1 * sin(th1(i)), ...
                    x(i) - l1 * cos(th1(i)) );

    v1 = [l1 * cos(th1(i)); l1 * sin(th1(i))];
    v2 = v1 + [l2 * cos(th2(i)); l2 * sin(th2(i))];

        % plot(x, y);
        % axis equal;
        % xlim([-0.5, 2]);
        % ylim([-1, 2])
        % hold on;
    
    % plot([0 v1(1)], [0 v1(2)], 'r');
    % plot([v1(1) v2(1)], [v1(2) v2(2)], 'b');
    %
    % pause (0.2);
end


plot(rad2deg(th1), 'r');
hold on;
plot(rad2deg(th2), 'b');


