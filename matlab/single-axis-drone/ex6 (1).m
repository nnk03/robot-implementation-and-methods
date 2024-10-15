%% Vertical Pendulum

clc, clear all, close all;
global g l;
g = 10;
l = 1;

th0 = pi / 4;
omega0 = 0;

function derivativeResult = dXdt(t, x)

global g l;
omega = x(2);
theta = x(1);

derivativeResult = [ omega; g * sin(theta) / l];

end

[t, x] = ode45( @dXdt, [0 10], [th0, omega0]);

plot(t, x( : , 1));




