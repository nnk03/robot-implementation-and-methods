import matplotlib

matplotlib.use("Qt5Agg")
import numpy as np
import matplotlib.pyplot as plt

# Parameters
r = 2
T = 5
omega = 2 * np.pi / T
dt = 1e-5

# Initial conditions
x = [0]
y = [0]
th = [0]

# Simulation loop
for i in range(1, int(1e6) + 1):
    t = dt * i

    xd = r * np.cos(omega * t)
    yd = r * np.sin(omega * t)
    Dxd = -r * omega * np.sin(omega * t)
    Dyd = r * omega * np.cos(omega * t)
    D2xd = -r * omega**2 * np.cos(omega * t)
    D2yd = -r * omega**2 * np.cos(omega * t)

    v = np.sqrt(Dxd**2 + Dyd**2)
    w = (Dxd * D2yd - Dyd * D2xd) / v**2

    f1 = v * np.cos(th[-1])
    f2 = v * np.sin(th[-1])
    f3 = omega

    x_new = x[-1] + dt * f1
    y_new = y[-1] + dt * f2
    th_new = th[-1] + dt * f3

    x.append(x_new)
    y.append(y_new)
    th.append(th_new)

# Plotting
fig, axs = plt.subplots(2, 2)

axs[0, 0].plot(x, y)
axs[0, 0].set_title("Trajectory")

axs[1, 0].plot(x)
axs[1, 0].set_title("x position")

axs[1, 1].plot(y)
axs[1, 1].set_title("y position")

plt.tight_layout()
plt.show()
