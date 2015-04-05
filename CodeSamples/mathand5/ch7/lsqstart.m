clear all;close all
figure(1)
Fs = 11025;r = audiorecorder(Fs, 16, 1);
%%%%
recordblocking (r,0.5);
y = getaudiodata(r, 'int16');
t=((1:length(y))-1)/Fs;
%%%
yy=double(y);
%%%
n=0;
lines=plot(t,yy,t,mean(yy)*ones(size(t)),'r--');
ui1=uicontrol('style','slider','min',0,'max',6,'value',0);
set(ui1,'callback','lsqupdate;');
lsqupdate;
