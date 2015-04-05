switch(btn)
case 1,
if (gco == line1) hdl=line1;end
if (gco == line2) hdl=line2;end
if ~isempty(hdl) set(hdl,'linewidth',5);end
case 2,
XX=get(gca,'currentpoint');
if ~isempty(hdl)
set(hdl,'xdata',[XX(1,1) XX(1,1)],'ydata',ylim);
end
haba=get(line1,'xdata')-get(line2,'xdata');
set(xlab,'string',[' ŠÔŠÔŠu',num2str(abs(haba(1))),'sec']);
case 0,
set(hdl,'linewidth',1);
hdl = [];
end
