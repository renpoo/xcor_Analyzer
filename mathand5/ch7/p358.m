close all;clear all
Fs = 11025;r = audiorecorder(Fs, 16, 1);
figure(1);
for i=0:0.5:10
recordblocking (r,0.5);
y = getaudiodata(r, 'int16');
t = ((1:length(y))-1)/Fs;
plot(t,y);drawnow;
end
