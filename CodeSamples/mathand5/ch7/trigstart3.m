clear all;close all
Fs=11025;t=0:(1/Fs):0.5-1/Fs;
yy=sin(2*pi*20*t)+sin(2*pi*10*t);
yy=yy+rand(size(yy))/10;
figure(1)
plot(t,yy);
hold on
line1=plot(xlim,[0 0]);
line2=plot(0,0,'ro');
hold off
xlab=xlabel(['ƒgƒŠƒKƒŒƒxƒ‹',num2str(0)]);
hdl=[];
triglevel=get(line1,'ydata');
btn=0;
set(gcf,'units','normal');
set(gca,'units','normal');
set(gcf,'windowbuttondownfcn','btn=1;trigupdate3;');
set(gcf,'windowbuttonmotionfcn','btn=2;trigupdate3;');
set(gcf,'windowbuttonupfcn','btn=0;trigupdate3;');
ui1=uicontrol('style','radiobutton','string','—§‚¿ã‚è','position',[20 20 80 20],...
'value',1,'callback','set(ui1,''value'',1);set(ui2,''value'',0);btn=0;trigupdate3;');
ui2=uicontrol('style','radiobutton','string','—§‚¿‰º‚è','position',[120 20 80 20],...
'callback','set(ui1,''value'',0);set(ui2,''value'',1);btn=0;trigupdate3;');
trigupdate3
yy=yy+rand(size(yy))/10;
