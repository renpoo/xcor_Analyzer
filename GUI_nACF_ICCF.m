function varargout = GUI_nACF_ICCF(varargin)
% GUI_NACF_ICCF MATLAB code for GUI_nACF_ICCF.fig
%      GUI_NACF_ICCF, by itself, creates a new GUI_NACF_ICCF or raises the existing
%      singleton*.
%
%      H = GUI_NACF_ICCF returns the handle to a new GUI_NACF_ICCF or the handle to
%      the existing singleton*.
%
%      GUI_NACF_ICCF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_NACF_ICCF.M with the given input arguments.
%
%      GUI_NACF_ICCF('Property','Value',...) creates a new GUI_NACF_ICCF or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_nACF_ICCF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_nACF_ICCF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_nACF_ICCF

% Last Modified by GUIDE v2.5 08-Feb-2015 09:39:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_nACF_ICCF_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_nACF_ICCF_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before GUI_nACF_ICCF is made visible.
function GUI_nACF_ICCF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_nACF_ICCF (see VARARGIN)

% Choose default command line output for GUI_nACF_ICCF
handles.output = hObject;

% Update handles structure
guidata( hObject, handles );

initialize_gui( hObject, handles, false );

% UIWAIT makes GUI_nACF_ICCF wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_nACF_ICCF_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles;
%launcher_nACF_ICCF( handles );

initialize_gui( hObject, handles, false );


% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%disp( handles );

%varargout{1} = handles;
launcher_nACF_ICCF( handles );

initialize_gui( gcbf, handles, true );


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

initialize_gui( gcbf, handles, true );


% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
if isfield(handles, 'flagsdata') && ~isreset
    return;
end;


handles.flagsdata.funcFlag         = 1;
handles.flagsdata.nacfAndoFlag  = 0;
handles.flagsdata.phiFlag           = 1;
handles.flagsdata.dumpFlag        = 0;
handles.flagsdata.debugFlag       = 1;
handles.flagsdata.debugStepFlag = 0;
handles.flagsdata.plotFlag          = 1;
handles.flagsdata.plot3dFlag       = 1;

    
set( handles.popupmenu1, 'value', handles.flagsdata.funcFlag );
set( handles.checkbox1,   'value', handles.flagsdata.nacfAndoFlag );
set( handles.checkbox2,   'value', handles.flagsdata.phiFlag );
set( handles.checkbox3,   'value', handles.flagsdata.dumpFlag );
set( handles.checkbox4,   'value', handles.flagsdata.debugFlag );
set( handles.checkbox5,   'value', handles.flagsdata.debugStepFlag );
set( handles.checkbox6,   'value', handles.flagsdata.plotFlag );
set( handles.checkbox7,   'value', handles.flagsdata.plot3dFlag );

% Update handles structure
guidata( handles.figure1, handles );


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
funcFlag = get( hObject, 'value' );

handles.flagsdata.funcFlag = funcFlag;

%disp(handles.flagsdata);

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
nacfAndoFlag = get( hObject, 'value' );

handles.flagsdata.nacfAndoFlag = nacfAndoFlag;

%disp(handles.flagsdata);

guidata(hObject,handles);


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
phiFlag = get( hObject, 'value' );

handles.flagsdata.phiFlag = phiFlag;

%disp(handles.flagsdata);

guidata(hObject,handles);


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
dumpFlag = get( hObject, 'value' );

handles.flagsdata.dumpFlag = dumpFlag;

%disp(handles.flagsdata);

guidata(hObject,handles);


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
debugFlag = get( hObject, 'value' );

handles.flagsdata.debugFlag = debugFlag;

%disp(handles.flagsdata);

guidata(hObject,handles);


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
debugStepFlag = get( hObject, 'value' );

handles.flagsdata.debugStepFlag = debugStepFlag;

%disp(handles.flagsdata);

guidata(hObject,handles);


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6
plotFlag = get( hObject, 'value' );

handles.flagsdata.plotFlag = plotFlag;

%disp(handles.flagsdata);

guidata(hObject,handles);


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7
plot3DFlag = get( hObject, 'value' );

handles.flagsdata.plot3dFlag = plot3dFlag;

%disp(handles.flagsdata);

guidata(hObject,handles);
