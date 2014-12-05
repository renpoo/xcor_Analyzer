close all;clear all
figure(1);
Fs = 11025;r = audiorecorder(Fs, 16, 1);
for i=0:0.5:10
recordblocking (r,0.5);
y = getaudiodata(r, 'int16');
t = ((1:length(y))-1)/Fs;
maxyval=y(1);
maxyind=1;
for j=2:length(y)
if(maxyval < y(j))
maxyval=y(j);
maxyind=j;
end
end
plot(t,y,t(maxyind),maxyval,'p');drawnow;
end
