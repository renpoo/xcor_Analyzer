clear all;close all
Fs=11025;t=0:(1/Fs):0.5-1/Fs;
yy=sin(2*pi*20*t)+sin(2*pi*10*t); 
figure(1)
set(1,'doublebuffer','on');
plot(t,yy);
hold on
line1=plot(xlim,[0 0]);
line2=plot(0,0,'ro');
hold off
xlab=xlabel(['ƒgƒŠƒKƒŒƒxƒ‹ ',num2str(0)]);
hdl=[];
triglevel=get(line1,'ydata');
btn=0;
set(gcf,'units','normal');
set(gca,'units','normal');
set(gcf,'windowbuttondownfcn','btn=1;trigupdate2;');
set(gcf,'windowbuttonmotionfcn','btn=2;trigupdate2;');
set(gcf,'windowbuttonupfcn','btn=0;trigupdate2;');

ui1=uicontrol('style','radiobutton','string','—§‚¿ã‚è','position',[20 20 80 20],...
'value',1,'callback','set(ui1,''value'',1);set(ui2,''value'',0);btn=0;trigupdate2;');
ui2=uicontrol('style','radiobutton','string','—§‚¿‰º‚è','position',[120 20 80 20],...
             'callback','set(ui1,''value'',0);set(ui2,''value'',1);btn=0;trigupdate2;');
trigupdate2
