clc, clear all;

global k1 k2;

k1 = 100000;
k2 = 100000;

x0 = [0; 0];



tspan = [0 30];

[t, x] = ode45(@filter1, tspan, x0);

plot(t, x( :, 1));

function dxdt = filter1(t, x)

global k1 k2

% sin(2 * pi * frequency * t)

f = sin(2 * pi * 1 * t) + sin(2 * pi * 10 * t) +...
    sin(2 * pi * 100 * t) + sin(2 * pi * 1000 * t);


dxdt = [x(2); -k1 * x(1) - k2 * x(2) + f];

end
