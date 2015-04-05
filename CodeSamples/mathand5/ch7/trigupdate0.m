switch(btn)
  case 1,
    if (gco == line1) hdl=line1;end
    if ~isempty(hdl) set(hdl,'linewidth',5);end
  case 2,
    XX=get(gca,'currentpoint');
    if ~isempty(hdl)
      set(hdl,'xdata',xlim,'ydata',[XX(1,2) XX(1,2)]);
    end
    triglevel=get(line1,'ydata');
    set(xlab,'string',['ƒgƒŠƒKƒŒƒxƒ‹',num2str(triglevel(1))]);
  case 0,
    set(hdl,'linewidth',1);
    hdl = [];
end
