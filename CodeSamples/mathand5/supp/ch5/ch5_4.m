function varargout = ch5_4(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ch5_4_OpeningFcn, ...
                   'gui_OutputFcn',  @ch5_4_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function ch5_4_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = ch5_4_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function popupmenu1_Callback(hObject, eventdata, handles)
sensyu=get(findobj('tag','popupmenu1'),'value');
switch sensyu
	case 1,set(findobj('type','line'),'linestyle','-');
	case 2,set(findobj('type','line'),'linestyle',':');
	case 3,set(findobj('type','line'),'linestyle','-.');
	case 4,set(findobj('type','line'),'linestyle','--');
	case 5,set(findobj('type','line'),'linestyle','none');
end

function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu2_Callback(hObject, eventdata, handles)
iro=get(findobj('tag','popupmenu2'),'value');
switch iro
	case 1,set(findobj('type','line'),'color','b');
	case 2,set(findobj('type','line'),'color','g');
	case 3,set(findobj('type','line'),'color','c');
	case 4,set(findobj('type','line'),'color','c');
	case 5,set(findobj('type','line'),'color','m');
	case 6,set(findobj('type','line'),'color','w');
	case 7,set(findobj('type','line'),'color','k');
end

function popupmenu2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function checkbox1_Callback(hObject, eventdata, handles)
gridchk=get(findobj('tag','checkbox1'),'value');
if gridchk, grid on;else grid off;end

function slider1_Callback(hObject, eventdata, handles)
futosa=get(findobj('tag','slider1'),'value');
set(findobj('type','line'),'linewidth',futosa);

function slider1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
