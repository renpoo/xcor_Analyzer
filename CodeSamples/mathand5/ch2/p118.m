[x,y]=meshgrid(-2:.2:2,-2:.2:2);z=(x+y).*exp(-x.^2-y.^2);
[dx dy]=gradient(z,0.5,0.5);
contour(x,y,z,10);
hold on
quiver(x,y,dx,dy)
hold off
