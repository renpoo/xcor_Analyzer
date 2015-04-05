function [outx,outy]=glfunc(current_v,current_steering)
global x y theta;
dt=0.1;
theta = theta+current_steering*dt;
x=x+current_v*dt*cos(theta);
y=y+current_v*dt*sin(theta);
outx=x;
outy=y;
