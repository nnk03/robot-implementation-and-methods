import matplotlib

matplotlib.use("Qt5Agg")  # Use the Qt5 backend for compatibility with Wayland
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# Link lengths
l1 = 1
l2 = 0.8

# Angle and position arrays
th = np.arange(0, 4 * np.pi, 0.1 * np.pi)
k = 1 / 2
x = 0.8 + 0.4 * np.cos(k * th) * np.cos(th)
y = 0.2 + 0.4 * np.cos(k * th) * np.sin(th)

# Initialize figure
fig, ax = plt.subplots()
ax.set_xlim(-0.5, 2)
ax.set_ylim(-1, 2)
ax.set_aspect("equal")

# Initialize plot elements: curve and two lines
(path,) = ax.plot(x, y, "k")
(link1,) = ax.plot([], [], "r", lw=2)
(link2,) = ax.plot([], [], "b", lw=2)

# Compute th1 and th2 based on inverse kinematics
th1 = np.zeros(len(th))
th2 = np.zeros(len(th))

for i in range(len(th)):
    th1[i] = np.arccos(
        (x[i] ** 2 + y[i] ** 2 + l1**2 - l2**2)
        / (2 * l1 * np.sqrt(x[i] ** 2 + y[i] ** 2))
    ) + np.arctan2(y[i], x[i])
    th2[i] = np.arctan2(y[i] - l1 * np.sin(th1[i]), x[i] - l1 * np.cos(th1[i]))


# Animation function
def animate(i):
    # Clear current plot
    ax.clear()

    # Redraw fixed path
    ax.plot(x, y, "k")

    # Update limits and maintain equal aspect ratio
    ax.set_xlim(-0.5, 2)
    ax.set_ylim(-1, 2)
    ax.set_aspect("equal")

    # Joint positions
    v1 = [l1 * np.cos(th1[i]), l1 * np.sin(th1[i])]
    v2 = [v1[0] + l2 * np.cos(th2[i]), v1[1] + l2 * np.sin(th2[i])]

    # Update links
    ax.plot([0, v1[0]], [0, v1[1]], "r", lw=2)  # Link 1
    ax.plot([v1[0], v2[0]], [v1[1], v2[1]], "b", lw=2)  # Link 2


# Create animation
ani = FuncAnimation(fig, animate, frames=len(th), interval=200)

# Show animation
plt.show()
