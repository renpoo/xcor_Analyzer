[x,y]=meshgrid(-2:.1:2,-2:.1:2);data=(x+y).*exp(-x.^2 -y.^2);
[iy,ix]=find(data==max(data(:)));
mesh(data);
hold on;plot3(ix,iy,data(iy,ix),'p');hold off
