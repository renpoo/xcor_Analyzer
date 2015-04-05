clear all;close all
global x y theta
x=0;y=0;theta=0;
v=30;
steering=30*pi/180;
figure;
plot(x,y,'o');axis equal
hold on
for i=0:0.1:12
[outx,outy]=glfunc(v,steering);
plot(outx,outy,'o');
drawnow;
end
hold off
