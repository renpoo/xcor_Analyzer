clear all;close all
Fs = 11025;r = audiorecorder(Fs, 16, 1);
recordblocking (r,0.5);
y = getaudiodata(r, 'int16');
t=((1:length(y))-1)/Fs;
% load y
plot(t,y);
hold on
line1=plot([0.1 0.1],ylim);
line2=plot([0.2 0.2],ylim);
hold off
xlab=xlabel([' ŽžŠÔŠÔŠu',num2str(0.6-0.5),'sec']);
hdl=[];btn=0;
set(gcf,'units','normal');set(gca,'units','normal');
set(gcf,'windowbuttondownfcn','btn=1;timeupdate;');
set(gcf,'windowbuttonmotionfcn','btn=2;timeupdate;');
set(gcf,'windowbuttonupfcn','btn=0;timeupdate;');
