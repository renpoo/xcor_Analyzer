function guisample2(mode)
switch(mode)
  case 1,
    if(strcmp(get(gco,'type'),'line'))
      if(length(get(gco,'xdata'))==1)
        set(gco,'linewidth',5);
      end
    end
  case 2,
    XX=get(gca,'currentpoint');
    set(gco,'xdata',XX(1,1),'ydata',XX(1,2));
  case 3,
    set(gco,'linewidth',1);
end
