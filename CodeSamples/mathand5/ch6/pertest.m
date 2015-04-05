clear all;close all
v=30;
steering=30*pi/180;
figure;
plot(0,0,'o');axis equal
hold on
for i=0:0.1:12
[outx,outy]=perfunc(v,steering);
plot(outx,outy,'o');
drawnow;
end
hold off
