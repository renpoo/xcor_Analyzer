close all;clear all
Fs = 11025;r = audiorecorder(Fs, 16, 1);
recordblocking (r,0.5);
y = getaudiodata(r, 'int16');
t=((1:length(y))-1)/Fs;
%load y
line3=plot(t,y);
hold on;
line4=plot([t(1),t(end)],[mean(double(y)),mean(double(y))],'r--');
hold off
ylim([-abs(max(double(y))) abs(max(double(y)))]);
ui1=uicontrol('style','radiobutton','string','AC ',...
'position',[20,20,80,20],'callback','AC=1;meanupdate;');
ui2=uicontrol('style','radiobutton','string','DC',...
'position',[120,20,80,20],'callback','AC=0;meanupdate;');
AC=1;meanupdate;
