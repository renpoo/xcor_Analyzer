close all;figure;p1=plot(sin(0:0.01:2*pi));
m=uimenu('Label','üí');
uimenu(m,'Label','Àü','callback','set(p1,''linestyle'',''-'')');
uimenu(m,'Label','“_ü','callback','set(p1,''linestyle'','':'')');
uimenu(m,'Label','½ü','callback','set(p1,''linestyle'',''-.'')');
uimenu(m,'Label','”jü','callback','set(p1,''linestyle'',''--'')');
uimenu(m,'Label','‚È‚µ','callback','set(p1,''linestyle'',''none'')');
