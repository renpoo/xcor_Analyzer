close all;figure;addmenu=uimenu(gcf,'label','test');
dogrid=uimenu(addmenu,'Label','Grid','callback','grid')
addview=uimenu(gcf,'Label','View');
uimenu(addview,'label','2-D','callback','view(2)');
uimenu(addview,'label','3-D','callback','view(3)');
