import numpy as np, matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

INK="#2b2d42"; TEAL="#0f8b8d"; AMBER="#e0a458"; CORAL="#ef6461"; LILAC="#8e7dbe"; GRID="#c9c9c9"
plt.rcParams.update({"font.family":"DejaVu Sans","text.color":INK,"axes.labelcolor":INK,
                     "xtick.color":INK,"ytick.color":INK,"axes.edgecolor":INK})

def style_3d(ax, elev=20, azim=-60):
    ax.set_facecolor("none")
    for p in (ax.xaxis.pane, ax.yaxis.pane, ax.zaxis.pane): p.fill=False
    ax.grid(False); ax.view_init(elev=elev, azim=azim)
    ax.set_xlabel("x",fontsize=10); ax.set_ylabel("y",fontsize=10); ax.set_zlabel("z",fontsize=10)

def save(fig,name):
    fig.savefig(f"{name}.png",dpi=170,bbox_inches="tight",transparent=True); plt.close(fig)

# A. Elliptic cone from completing the square: (y+2)^2 = (x-1)^2 + 4(z+1)^2
fig=plt.figure(figsize=(4.2,4.2)); ax=fig.add_subplot(111,projection="3d")
u=np.linspace(0,2*np.pi,44); v=np.linspace(-2.2,2.2,22)
U,V=np.meshgrid(u,v)
X=1+np.abs(V)*np.cos(U); Z=-1+np.abs(V)*np.sin(U)/2.0; Y=-2+V
ax.plot_surface(X,Y,Z,color=CORAL,alpha=0.72,edgecolor=INK,linewidth=0.13,rstride=2,cstride=2)
ax.scatter([1],[-2],[-1],color=TEAL,s=45)
ax.text(1,-2,-1,"  vertex (1,−2,−1)",fontsize=8,color=INK)
style_3d(ax,elev=16,azim=-62); save(fig,"cone_shifted")

# B. Line with zero direction number: v=<4,0,-7>, lies in plane y=-2
fig=plt.figure(figsize=(4.2,4.2)); ax=fig.add_subplot(111,projection="3d")
P0=np.array([3,-2,5]); P1=np.array([7,-2,-2])
t=np.linspace(-0.25,1.3,50)
L=np.array([P0+tt*(P1-P0) for tt in t])
# translucent plane y = -2
xx,zz=np.meshgrid(np.linspace(1,9,6),np.linspace(-4,7,6))
ax.plot_surface(xx,np.full_like(xx,-2.0),zz,color=TEAL,alpha=0.13,edgecolor=TEAL,linewidth=0.3)
ax.plot(L[:,0],L[:,1],L[:,2],color=CORAL,linewidth=2.6)
ax.scatter(*P0,color=TEAL,s=55); ax.scatter(*P1,color=TEAL,s=55)
ax.text(*P0,"  P₀(3,−2,5)",fontsize=8,color=INK)
ax.text(*P1,"  P₁(7,−2,−2)",fontsize=8,color=INK)
ax.text(5,-2,-5.5,"plane y = −2",fontsize=8,color=TEAL)
style_3d(ax,elev=14,azim=-58); save(fig,"line_zero_dir")

# C. Saddle traces for z/2 = y^2/4 - x^2/9
fig,axs=plt.subplots(1,3,figsize=(9,2.8))
yv=np.linspace(-4,4,200); axs[0].plot(yv,yv**2/2,color=TEAL,lw=2)
axs[0].set_title("x=0:  z = y²/2  (min)",fontsize=9)
xv=np.linspace(-4,4,200); axs[1].plot(xv,-2*xv**2/9,color=CORAL,lw=2)
axs[1].set_title("y=0:  z = −2x²/9  (max)",fontsize=9)
Xg,Yg=np.meshgrid(np.linspace(-6,6,300),np.linspace(-5,5,300))
axs[2].contour(Xg,Yg,Yg**2/4-Xg**2/9,levels=[-1,0,1],colors=[CORAL,INK,TEAL],linewidths=1.7)
axs[2].set_title("z=0 lines,  z=±2 hyperbolas",fontsize=9)
for a in axs:
    a.axhline(0,color=GRID,lw=0.6); a.axvline(0,color=GRID,lw=0.6)
    a.set_xticks([]); a.set_yticks([])
    for s in a.spines.values(): s.set_color(GRID)
fig.tight_layout(); save(fig,"traces_hp")
print("ok")
