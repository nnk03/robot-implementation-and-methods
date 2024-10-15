%% Assignment 1 - Question 1

global a b R k thetaDot;

a = 1;
b = 0.1; 
R = 0.25;
thetaDot = 1;

k = 0.5;

endTime = 15;

x0 = 0;
y0 = 0;
theta0 = 0;
forwardAcceleration0 = 0;

[t, X] = ode45(@derivativeFunction, [0 endTime], ...
    [x0; y0; theta0; forwardAcceleration0]);

xList = X( : , 1);
yList = X( : , 2);
thetaList = X( : , 3);

vList = X( : , 4);

% x vs y
subplot(2, 4, 1);
plot(yList, xList);
grid on;

% theta vs time
subplot(2, 4, 2);
plot(t, thetaList);
grid on;

% v vs time
subplot(2, 4, 3);
plot(t, vList);
grid on;

% omega vs time
subplot(2, 4, 4);
% omega is difference in consecutive theta divided
% by difference in consecutive time interval (d(theta) / dt)
omegaList = (thetaList(2 : end) - thetaList(1 : end - 1))./...
                (t(2 : end) - t(1 : end - 1));
% initial omega is 0
omegaList = [0; omegaList];
plot(t, omegaList);
grid on;

% omega_r vs time
subplot(2, 4, 5);
omegaRight = (2 * vList + b * omegaList) / (2 * R);
plot(t, omegaRight);
grid on;

% omega_l vs time
subplot(2, 4, 6);
omegaLeft = (2 * vList - b * omegaList) / (2 * R);
plot(t, omegaLeft);
grid on;

% forwardAcceration vs time
% acceleration is dv / dt, i.e difference between consecutive values of v
% divided by difference between consecutive intervals of time
subplot(2, 4, 7);
aList = (vList(2 : end) - vList(1 : end - 1))./...
            (t(2 : end) - t(1 : end - 1));
aList = [0; aList];
plot(t, aList);
grid on;
display("Maximum forward acceleration is ");
display(max(aList));

function derivativeResult = derivativeFunction(t, X)

global a b R k thetaDot;

xPos = X(1);
yPos = X(2);
theta = X(3);
v = X(4);

kTheta = k * thetaDot * t;
currentTheta = thetaDot * t;

skt = sin(kTheta);
ckt = cos(kTheta);

st = sin(currentTheta);
ct = cos(currentTheta);

x = a * ckt * ct;
y = a * ckt * st;

dxdt = -a * thetaDot * (k * skt * ct + ckt * st);
dydt = a * thetaDot * (-k * skt * st + ckt * ct);

d2xdt = -a * thetaDot ^ 2 * (k^2 * ckt * ct - k * skt * st ...
                    -k * skt * st + ckt * ct);

d2ydt = -a * thetaDot ^ 2 * (k^2 * ckt * st + k * skt * ct ...
                    +k * skt * ct + ckt * st);

thetaDesired = atan2(dydt, dxdt);
omegaDesired = (dxdt * d2ydt - dydt * d2xdt) / (dxdt^2 + dydt^2);
vDesired = sqrt(dxdt ^ 2 + dydt ^ 2);

dvdt = (dxdt * d2xdt + dydt * d2ydt) / vDesired;

derivativeResult = [ 
    vDesired * cos(thetaDesired);
    vDesired * sin(thetaDesired);
    omegaDesired;
    dvdt
];

end

