import os
import sys
import pandas as pd
from matplotlib import pyplot as plt

metrics = ["Success", "ResponseTime", "Throughput"]

if(len(sys.argv) != 2):
    print("Usage: PlotOutput <directory>")
    exit

directory = sys.argv[1]

# Creating figure with one plot by metric
fig, ax = plt.subplots(len(metrics), 1, figsize=(7, 5), constrained_layout=True)

for i,metric in enumerate(metrics):

    # Looping over report directory
    for filename in os.listdir(directory):
        if filename.endswith(metric + ".csv"):
            data = pd.read_csv(os.path.join(directory, filename))
            # Adding data
            ax[i].plot(data.Query, data.Value, label=filename.split("-")[0])
    
    ax[i].grid(axis="y")
    ax[i].set(ylabel=metric, xlabel="Query")
    ax[i].legend()

plt.suptitle("Performance Analysis - " + os.path.basename(directory))
plt.show()