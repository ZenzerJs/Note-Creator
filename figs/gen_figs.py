import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# ---------- Color palette (study-note friendly) ----------
INK   = "#2b2d42"
TEAL  = "#0f8b8d"
AMBER = "#e0a458"
CORAL = "#ef6461"
LILAC = "#8e7dbe"
GRID  = "#c9c9c9"

plt.rcParams.update({
    "font.family": "DejaVu Sans",
    "axes.edgecolor": INK,
    "text.color": INK,
    "axes.labelcolor": INK,
    "xtick.color": INK,
    "ytick.color": INK,
})

def style_3d(ax, elev=20, azim=-60):
    ax.set_facecolor("none")
    ax.xaxis.pane.fill = False
    ax.yaxis.pane.fill = False
    ax.zaxis.pane.fill = False
    ax.xaxis.pane.set_edgecolor((0,0,0,0))
    ax.yaxis.pane.set_edgecolor((0,0,0,0))
    ax.zaxis.pane.set_edgecolor((0,0,0,0))
    ax.grid(False)
    ax.set_xlabel("x", fontsize=11)
    ax.set_ylabel("y", fontsize=11)
    ax.set_zlabel("z", fontsize=11)
    ax.view_init(elev=elev, azim=azim)
    for axis in [ax.xaxis, ax.yaxis, ax.zaxis]:
        axis._axinfo['tick']['inward_factor'] = 0
        axis._axinfo['tick']['outward_factor'] = 0

def save(fig, name):
    fig.savefig(f"{name}.png", dpi=170, bbox_inches="tight", transparent=True)
    plt.close(fig)

# 1. Ellipsoid
fig = plt.figure(figsize=(4,4)); ax = fig.add_subplot(111, projection="3d")
u,v = np.mgrid[0:2*np.pi:40j, 0:np.pi:20j]
a,b,c = 2,1.4,1.7
x=a*np.cos(u)*np.sin(v); y=b*np.sin(u)*np.sin(v); z=c*np.cos(v)
ax.plot_surface(x,y,z,color=TEAL,alpha=0.75,edgecolor=INK,linewidth=0.15,rstride=2,cstride=2)
style_3d(ax); save(fig,"ellipsoid")

# 2. Elliptic Cone
fig = plt.figure(figsize=(4,4)); ax = fig.add_subplot(111, projection="3d")
u = np.linspace(0,2*np.pi,40); v = np.linspace(-1.6,1.6,20)
U,V = np.meshgrid(u,v)
X = V*np.cos(U)*1.2; Y = V*np.sin(U)*1.2; Z = V
ax.plot_surface(X,Y,Z,color=CORAL,alpha=0.75,edgecolor=INK,linewidth=0.15,rstride=2,cstride=2)
style_3d(ax,elev=15); save(fig,"cone")

# 3. Elliptic Paraboloid
fig = plt.figure(figsize=(4,4)); ax = fig.add_subplot(111, projection="3d")
r = np.linspace(0,1.6,25); th = np.linspace(0,2*np.pi,40)
R,TH = np.meshgrid(r,th)
X = R*np.cos(TH)*1.3; Y = R*np.sin(TH); Z = R**2
ax.plot_surface(X,Y,Z,color=AMBER,alpha=0.85,edgecolor=INK,linewidth=0.15,rstride=2,cstride=2)
style_3d(ax,elev=18); save(fig,"elliptic_paraboloid")

# 4. Hyperbolic Paraboloid (saddle)
fig = plt.figure(figsize=(4,4)); ax = fig.add_subplot(111, projection="3d")
x = np.linspace(-1.6,1.6,40); y = np.linspace(-1.6,1.6,40)
X,Y = np.meshgrid(x,y); Z = X**2 - Y**2
ax.plot_surface(X,Y,Z,color=LILAC,alpha=0.85,edgecolor=INK,linewidth=0.12,rstride=2,cstride=2)
style_3d(ax,elev=22,azim=-50); save(fig,"hyp_paraboloid")

# 5. Hyperboloid of One Sheet
fig = plt.figure(figsize=(4,4)); ax = fig.add_subplot(111, projection="3d")
u = np.linspace(0,2*np.pi,40); v = np.linspace(-1.3,1.3,20)
U,V = np.meshgrid(u,v)
X = np.sqrt(1+V**2)*np.cos(U); Y = np.sqrt(1+V**2)*np.sin(U); Z = V*1.4
ax.plot_surface(X,Y,Z,color=TEAL,alpha=0.8,edgecolor=INK,linewidth=0.15,rstride=2,cstride=2)
style_3d(ax,elev=18); save(fig,"hyperboloid_1sheet")

# 6. Hyperboloid of Two Sheets
fig = plt.figure(figsize=(4,4)); ax = fig.add_subplot(111, projection="3d")
u = np.linspace(0,2*np.pi,40)
for sign,color in [(1,CORAL),(-1,CORAL)]:
    v = np.linspace(0,1.3,20)
    U,V = np.meshgrid(u,v)
    Z = sign*(1+V**2)**0.5*1.3
    X = V*np.cos(U); Y = V*np.sin(U)
    ax.plot_surface(X,Y,Z,color=color,alpha=0.8,edgecolor=INK,linewidth=0.15,rstride=2,cstride=2)
style_3d(ax,elev=12); save(fig,"hyperboloid_2sheet")

# 7. Circular / elliptic cylinder extrusion (z=y^2 parabolic cylinder)
fig = plt.figure(figsize=(4,4)); ax = fig.add_subplot(111, projection="3d")
y = np.linspace(-1.4,1.4,30); x = np.linspace(-1.8,1.8,10)
Y,X = np.meshgrid(y,x); Z = Y**2
ax.plot_surface(X,Y,Z,color=AMBER,alpha=0.8,edgecolor=INK,linewidth=0.15,rstride=2,cstride=2)
style_3d(ax,elev=18,azim=-70); save(fig,"parabolic_cylinder")

# 8. Line through two points in R^3
fig = plt.figure(figsize=(4.3,4.3)); ax = fig.add_subplot(111, projection="3d")
P0 = np.array([-1,-4,-4]); P1 = np.array([2,0,-3])
t = np.linspace(-0.4,1.4,50)
line = np.array([P0 + tt*(P1-P0) for tt in t])
ax.plot(line[:,0],line[:,1],line[:,2],color=TEAL,linewidth=2.5)
ax.scatter(*P0,color=CORAL,s=60)
ax.scatter(*P1,color=CORAL,s=60)
ax.text(*P0,"  P0(-1,-4,-4)",fontsize=9,color=INK)
ax.text(*P1,"  P1(2,0,-3)",fontsize=9,color=INK)
ax.quiver(*P0,*(P1-P0),color=AMBER,linewidth=2,arrow_length_ratio=0.12)
style_3d(ax,elev=18,azim=-55); save(fig,"line_3d")

# 9. Saddle trace deconstruction (2x2 panel)
fig, axs = plt.subplots(1,3, figsize=(9,3))
yv = np.linspace(-2,2,200)
for k,c in [(0,INK),(1,TEAL),(-1,TEAL),(np.sqrt(3),CORAL),(-np.sqrt(3),CORAL)]:
    axs[0].plot(yv, -yv**2 + k**2, color=c, linewidth=1.8)
axs[0].set_title("x-traces:  z = k²−y²", fontsize=10); axs[0].axhline(0,color=GRID,lw=0.6); axs[0].axvline(0,color=GRID,lw=0.6)
xv = np.linspace(-2,2,200)
for k,c in [(0,INK),(1,TEAL),(-1,TEAL),(np.sqrt(3),CORAL),(-np.sqrt(3),CORAL)]:
    axs[1].plot(xv, xv**2 - k**2, color=c, linewidth=1.8)
axs[1].set_title("y-traces:  z = x²−k²", fontsize=10); axs[1].axhline(0,color=GRID,lw=0.6); axs[1].axvline(0,color=GRID,lw=0.6)
th = np.linspace(0,2*np.pi,200)
for k,c in [(1,TEAL),(np.sqrt(3),CORAL)]:
    r = k
    axs[2].plot(r*np.cos(th), r*np.sin(th)*0+0, color="none")
xg = np.linspace(-2,2,300); yg=np.linspace(-2,2,300)
Xg,Yg = np.meshgrid(xg,yg)
axs[2].contour(Xg,Yg,Xg**2-Yg**2, levels=[-3,-1,0,1,3], colors=[CORAL,TEAL,INK,TEAL,CORAL], linewidths=1.6)
axs[2].set_title("z-traces:  k = x²−y²", fontsize=10)
for a in axs:
    a.set_xticks([]); a.set_yticks([])
    for s in a.spines.values(): s.set_color(GRID)
fig.tight_layout()
save(fig,"saddle_traces")

print("done")
