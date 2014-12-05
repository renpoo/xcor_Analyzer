switch(btn)
  case 1,
    if (gco == line1) hdl=line1;end
    if ~isempty(hdl) set(hdl,'linewidth',5);end
  case 2,
    XX=get(gca,'currentpoint');
    if ~isempty(hdl)
      set(hdl,'xdata',xlim,'ydata',[XX(1,2) XX(1,2)]);
      triglevel=get(hdl,'ydata');
      set(xlab,'string',['トリガレベル',num2str(triglevel(1))]);
    end
  case 0,
    set(hdl,'linewidth',1);
    hdl = [];
    plogicval=(yy >= triglevel(1));
    pupind=findstr(plogicval,[0 1]);
    pdwnind=findstr(plogicval,[1 0]);
    if get(ui1,'value') ==1
      set(line2,'xdata',t(pupind),'ydata',yy(pupind));
    else
      set(line2,'xdata',t(pdwnind),'ydata',yy(pdwnind));
    end
    if ~isempty(pupind)
      set(xlab,'string',['トリガレベル',num2str(triglevel(1)),'平均周期',num2str(mean(diff(t(pupind))))]);
    end
end
