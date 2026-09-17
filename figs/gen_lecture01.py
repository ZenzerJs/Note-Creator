"""Generate 3D figures for Lecture 01 (Sphere & Coordinate Axes)."""

import matplotlib.pyplot as plt
import numpy as np
from pathlib import Path

def plot_sphere_and_axes(out_path: Path):
    fig = plt.figure(figsize=(6, 5))
    ax = fig.add_subplot(111, projection="3d")

    # Sphere data
    u = np.linspace(0, 2 * np.pi, 50)
    v = np.linspace(0, np.pi, 50)
    r = 2 * np.sqrt(2)
    cx, cy, cz = -2, 3, -1
    x = cx + r * np.outer(np.cos(u), np.sin(v))
    y = cy + r * np.outer(np.sin(u), np.sin(v))
    z = cz + r * np.outer(np.ones(np.size(u)), np.cos(v))

    ax.plot_surface(x, y, z, color="royalblue", alpha=0.35, edgecolor="none")
    ax.scatter([cx], [cy], [cz], color="crimson", s=40, label=f"Center ({cx}, {cy}, {cz})")

    ax.set_xlabel("X")
    ax.set_ylabel("Y")
    ax.set_zlabel("Z")
    ax.set_title(r"Sphere $(x+2)^2 + (y-3)^2 + (z+1)^2 = 8$")
    ax.legend(loc="upper right")
    plt.tight_layout()

    out_path.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(out_path, dpi=200)
    plt.close()

if __name__ == "__main__":
    out_dir = Path(__file__).parent
    plot_sphere_and_axes(out_dir / "sphere_example.png")
    print(f"Generated {out_dir / 'sphere_example.png'}")
