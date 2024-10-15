import matplotlib

# matplotlib.use("Agg")

import matplotlib.pyplot as plt


plt.plot([0, 1], [0, 1])
plt.savefig("./test.png", format="png")
# plt.show()
