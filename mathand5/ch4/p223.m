clear all;close all;
dt=0.01;t=(1:1024)*dt-dt;
omega=2*pi*1;% [Hz]
y=sign(sin(omega*t));
[num,den]= c2dm(1,[1 1],dt);
