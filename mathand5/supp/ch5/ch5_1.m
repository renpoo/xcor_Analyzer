close all;figure;p1=plot(sin(0:0.01:2*pi));
m=uimenu('Label','線種');
uimenu(m,'Label','実線','callback','set(p1,''linestyle'',''-'')');
uimenu(m,'Label','点線','callback','set(p1,''linestyle'','':'')');
uimenu(m,'Label','鎖線','callback','set(p1,''linestyle'',''-.'')');
uimenu(m,'Label','破線','callback','set(p1,''linestyle'',''--'')');
uimenu(m,'Label','なし','callback','set(p1,''linestyle'',''none'')');
