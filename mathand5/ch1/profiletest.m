close all;clear all
profile on;
for i=1:100
  [xx,yy]=meshgrid(-3:0.1:3,-3:0.1:3);
  mesh(sin(xx).*cos(yy)*i);
  zlim([-100,100]);
  drawnow;
end
profile viewer
