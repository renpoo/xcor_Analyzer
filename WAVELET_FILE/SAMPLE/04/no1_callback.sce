// This GUI file is generated by guibuilder version 2.2
//////////
f=figure('figure_position',[707,195],'figure_size',[658,615],'auto_resize','on','background',[33],'figure_name','グラフィック・ウインドウ番号 %d');
//////////
delmenu(f.figure_id,gettext('File'))
delmenu(f.figure_id,gettext('?'))
delmenu(f.figure_id,gettext('Tools'))
toolbar(f.figure_id,'off')
handles.dummy = 0;
handles.no1=uicontrol(f,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','helvetica','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0958333,0.7989556,0.2458333,0.0939948],'Relief','flat','SliderStep',[0.01,0.1],'String','番号１','Style','listbox','Value',[1],'VerticalAlignment','middle','Visible','on','Tag','no1','Callback','no1_callback(handles)')
handles.no2=uicontrol(f,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','helvetica','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.1,0.7049608,0.24375,0.0861619],'Relief','flat','SliderStep',[0.01,0.1],'String','番号２','Style','listbox','Value',[1],'VerticalAlignment','middle','Visible','on','Tag','no2','Callback','no2_callback(handles)')
handles.edit=uicontrol(f,'unit','normalized','BackgroundColor',[0.8,0.8,0.8],'Enable','on','FontAngle','normal','FontName','helvetica','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[0,0,0],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.3958333,0.5953003,0.3,0.1984334],'Relief','sunken','SliderStep',[0.01,0.1],'String','編集','Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','edit','Callback','')
.
//////////
// Callbacks are defined as below. Please do not delete the comments as it will be used in coming version
//////////
function no1_callback(handles)
//Write your callback for  no1  here
＜ここに処理のプログラムを記述する。実使用にはこのファンクションを呼ぶ。＞
endfunction

function no2_callback(handles)
//Write your callback for  no2  here

Endfunction
