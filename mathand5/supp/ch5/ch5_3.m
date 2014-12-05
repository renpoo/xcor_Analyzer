close all;figure;p1=plot(sin(0:0.01:2*pi));
s1=uicontrol('style','slider','max',10,'min',1,'value',1);
set(s1,'callback','set(p1,''linewidth'',get(s1,''value''))');
s2=uicontrol('style','popupmenu','position',[120 20 100 20],...
'string',[{'solid'},{'dotted'},{'dash-dot'},{'dashed'}],...
'value',1,...
'userdata',[{'-'};{':'};{'-.'};{'--'}],...
'callback',['lineobj=findobj(''type'',''line'');',...
'lineinfo=get(s2,''userdata'');',...
'set(lineobj,''linestyle'',lineinfo{get(s2,''value'')})']);
