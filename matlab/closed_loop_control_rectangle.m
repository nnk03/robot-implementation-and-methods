clc, clear all, close all;

global k d xd yd i;

xd = [0, 2, 2, 0];
yd = [0, 0, 1, 1];

k = 5;
d = 0.1;
i = 1;

x0 = 8;
y0 = 4;
th0 = pi / 4;

[t, x] = ode45(@mobile, [0 10], [x0; y0; th0]);


plot(x( : , 1), x( : , 2));
axis equal;



function y = mobile(t, x)

global k d xd yd i;

x_pos = x(1);
y_pos = x(2);
th = x(3);

y1 = x_pos + d * cos(th);
y2 = y_pos + d * sin(th);

A = [cos(th), -d * sin(th);
    sin(th), d * cos(th)];

% choosing xd_dot and yd_dot as zero
% u1 = xd_dot - k * e1
u1 = -k * (y1 - xd(i));
u2 = -k * (y2 - yd(i));

if (y1 - xd(i))^2 + (y2 - yd(i))^2 < 1e-6
    i = i + 1;
    if i == 5
        i = 1;
    end
end

inp = inv(A) * [u1; u2];
v = inp(1);
w = inp(2);

y = [v * cos(th);
    v * sin(th);
    w];

end

