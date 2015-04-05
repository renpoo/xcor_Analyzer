[x,y]=meshgrid(-2:.2:2,-2:.2:2);z=(x+y).*exp(-x.^2-y.^2);
cs=contour(x,y,z,10);
clabel(cs)
