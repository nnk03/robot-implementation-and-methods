import matplotlib

matplotlib.use("Qt5Agg")  # Use the Qt5 backend for compatibility with Wayland
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
import numpy as np
import csv

data = []

with open("test", "r") as file:
    csv_reader = csv.reader(file)
    for row in csv_reader:
        data_row = []
        for i in range(len(row)):
            row[i] = row[i].strip()
            data_row.append(float(row[i]))
        data.append(data_row)


plt.plot(range(1, len(data) + 1), [row[0] for row in data])
plt.show()

data = np.array(data)

# Extract theta1, theta2, and theta3 for animation
theta1 = data[:, 1]
theta2 = data[:, 2]
theta3 = data[:, 3]

# Set up the figure and axis
fig, ax = plt.subplots()
ax.set_xlim(0, len(theta1))  # Set x-axis range
ax.set_ylim(-360, 720)  # Set y-axis range for angles (0-180 degrees)

# Create line objects for each theta
(line1,) = ax.plot([], [], label="theta1", color="r")
(line2,) = ax.plot([], [], label="theta2", color="g")
(line3,) = ax.plot([], [], label="theta3", color="b")

# Add a legend
ax.legend()


# Initialize the lines
def init():
    line1.set_data([], [])
    line2.set_data([], [])
    line3.set_data([], [])
    return line1, line2, line3


# Update function to animate the thetas
def update(frame):
    xdata = np.arange(frame)
    line1.set_data(xdata, theta1[:frame])
    line2.set_data(xdata, theta2[:frame])
    line3.set_data(xdata, theta3[:frame])
    return line1, line2, line3


# Create the animation
ani = FuncAnimation(fig, update, frames=len(theta1), init_func=init, blit=True)

# Display the animation
plt.show()
