close all;figure;p1=plot(sin(0:0.01:2*pi));
m=uimenu('Label','����');
uimenu(m,'Label','����','callback','set(p1,''linestyle'',''-'')');
uimenu(m,'Label','�_��','callback','set(p1,''linestyle'','':'')');
uimenu(m,'Label','����','callback','set(p1,''linestyle'',''-.'')');
uimenu(m,'Label','�j��','callback','set(p1,''linestyle'',''--'')');
uimenu(m,'Label','�Ȃ�','callback','set(p1,''linestyle'',''none'')');
