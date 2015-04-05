close all;figure;p1=plot(sin(0:0.01:2*pi));
s1=uicontrol('style','slider','max',10,'min',1,'value',1);
set(s1,'callback','set(p1,''linewidth'',get(s1,''value''))');
