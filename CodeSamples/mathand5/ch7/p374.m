clear all;close all
figure(1)
Fs=11025;t=0:(1/Fs):0.5-1/Fs;
yy=sin(2*pi*20*t)+sin(2*pi*10*t);
plot(t,yy);
