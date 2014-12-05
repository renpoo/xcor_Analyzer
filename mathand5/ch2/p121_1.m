[x,y]=meshgrid(-2:.1:2,-2:.1:2);z=(x+y).*exp(-x.^2-y.^2);
surf(z);
shading interp
light('Position',[1 -2 1])
rotate3d
