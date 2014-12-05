clear all;close all
Fs=11025;t=0:(1/Fs):0.5-1/Fs;
yy=sin(2*pi*20*t)+sin(2*pi*10*t);
figure(1)
plot(t,yy);
hold on
line1=plot(xlim,[0 0]);
hold off
xlab=xlabel(['ƒgƒŠƒKƒŒƒxƒ‹',num2str(0)]);
hdl=[];
btn=0;
set(gcf,'units','normal');
set(gca,'units','normal');
set(gcf,'windowbuttondownfcn','btn=1;trigupdate0;');
set(gcf,'windowbuttonmotionfcn','btn=2;trigupdate0;');
set(gcf,'windowbuttonupfcn','btn=0;trigupdate0;');
trigupdate0
