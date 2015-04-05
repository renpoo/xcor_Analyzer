clear all;close all
figure(1);Fs = 11025;i=0;
r = audiorecorder(Fs, 16, 1);
recordblocking (r,0.5);
y = getaudiodata(r, 'int16');
t = ((1:length(y))-1)/Fs;
[maxyval,maxyind]=max(y);
[minyval,minyind]=min(y);
aaa=plot(t,y,t([1,end]),[maxyval maxyval],'r--',t([1 end]),
[minyval minyval],'r--');
axis([t([1,end]),-30000,30000]);
maxminrun
