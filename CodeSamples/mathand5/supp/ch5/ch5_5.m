close all;figure;p1=plot(sin(0:0.01:2*pi));
b1=uicontrol('style','radiobutton','position',[20 20 80 20],'string','‘¾‚³1')
b2=uicontrol('style','radiobutton','position',[120 20 80 20],'string','‘¾‚³5');
b3=uicontrol('style','radiobutton','position',[220 20 80 20],'string','‘¾‚³10');
set(b1,'value',1);
set(b1,'callback','set(p1,''linewidth'',1);set(b2,''value'',0);set(b3,''value'',0)');
set(b2,'callback','set(p1,''linewidth'',5);set(b1,''value'',0);set(b3,''value'',0)');
set(b3,'callback','set(p1,''linewidth'',10);set(b1,''value'',0);set(b2,''value'',0)');
