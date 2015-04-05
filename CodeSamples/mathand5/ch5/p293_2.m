ui=uicontrol('style','listbox','position', [10 10 150 100]);
set(ui, 'string', 'item1|item2|item3');
set(ui, 'callback', 'disp(get(ui,''value''));');
