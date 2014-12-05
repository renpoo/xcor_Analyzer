function [outx,outy]=perfunc(current_v,current_steering)
persistent x y theta;
if(isempty(x)) x=0;y=0;theta=0;end
dt=0.1;
theta = theta+current_steering*dt;
x=x+current_v*dt*cos(theta);
y=y+current_v*dt*sin(theta);
outx=x;
outy=y;
