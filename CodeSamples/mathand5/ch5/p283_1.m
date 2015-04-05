figure;
one=uimenu(gcf,'Label','1','callback','plot(sin(1:100));grid;set(gca,''Box'',''on'')');
two=uimenu(gcf,'Label','2','callback','plot(sin(1:100));grid off ;set(gca,''Box'',''off'')');
