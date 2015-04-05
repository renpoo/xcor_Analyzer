if AC==1
  set(ui1,'value',1);
  set(ui2,'value',0);
  set(line3,'ydata',double(y)-mean(double(y)));
  set(line4,'ydata',[0 0]);
else
  set(ui1,'value',0);
  set(ui2,'value',1);
  set(line3,'ydata',double(y));
  set(line4,'ydata',[mean(y) mean(y)]);
end
