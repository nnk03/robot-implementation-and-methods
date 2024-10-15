%% Open Loop Trajectory of Rose Curve

% r = A cos(k theta)
global A k;
A = 1;
k = 0.5;

function result = dXdt(t, X)
global A k;

x = X(1);
y = X(2);
th = X(3);
om = X(4);

result = zeros(4, 1);
result(1) = -A * om * (k * cos(th) * sin(k * th) + ...
                        cos(k * th) * sin(th));

result(2) = A * om * (cos(k * th) * cos(th) - ...
                        k * sin(k * th) * sin(th));

result(3) = om;

result(4) = 0;


end

    [t, res] = ode45(@dXdt, [0 10], [1 1 1 0]);

plot(t, res( : , 1))

