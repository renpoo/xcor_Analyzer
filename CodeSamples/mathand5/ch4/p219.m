close all;clear all;
dt=0.01;t=(1:1024)*dt-dt;
omega=2*pi*1;% [Hz]
y=sign(sin(omega*t));
