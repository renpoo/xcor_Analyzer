fig = figure;
hc1 = uicontrol(fig,'style','pushbutton');
hc2 = uicontrol(fig,'style','edit');
set(hc1,'units','normalized','position',[0.1 0.1 0.8 0.2]);
set(hc2,'units','normalized','position',[0.5 0.1 0.8 0.4]);
set(hc1,'string','OK','callback','uiresume(gcf);');

handles = struct();

handles.flagsdata.funcFlag         = 1;
handles.flagsdata.nacfAndoFlag  = 0;
handles.flagsdata.phiFlag           = 1;
handles.flagsdata.dumpFlag        = 0;
handles.flagsdata.debugFlag       = 1;
handles.flagsdata.debugStepFlag = 0;
handles.flagsdata.plotFlag          = 1;
handles.flagsdata.plot3dFlag       = 1;

if ( 0 ),
set( handles.popupmenu1, 'value', handles.flagsdata.funcFlag );
set( handles.checkbox1,   'value', handles.flagsdata.nacfAndoFlag );
set( handles.checkbox2,   'value', handles.flagsdata.phiFlag );
set( handles.checkbox3,   'value', handles.flagsdata.dumpFlag );
set( handles.checkbox4,   'value', handles.flagsdata.debugFlag );
set( handles.checkbox5,   'value', handles.flagsdata.debugStepFlag );
set( handles.checkbox6,   'value', handles.flagsdata.plotFlag );
set( handles.checkbox7,   'value', handles.flagsdata.plot3dFlag );
end;


for n=1:3,
    %disp(n);
    %set(hc2,'string',num2str(n));
    launcher_nACF_ICCF( handles );
    uiwait(fig);
end