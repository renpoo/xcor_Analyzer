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

% Last Modified by GUIDE v2.5 09-Apr-2015 13:14:25

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
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_nACF_ICCF_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if nargout
    [varargout{1:nargout}] = handles;
    write_history_( handles.data, 'commandHistory_GUI_nACF_ICCF.mat', 'ERROR: write_history_() : No Command History File.' );
else
    %gui_mainfcn(gui_State, varargin{:});
end

close;



% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume( gcf );


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.data.funcFlag         = 1;
handles.data.normalizeFlag    = 1;
handles.data.nacfSingleFlag   = 0;
handles.data.calcTauE_VecFlag = 0;
handles.data.cyclicFlag       = 0;
handles.data.dumpFlag         = 0;
handles.data.debugFlag        = 1;
handles.data.debugStepFlag    = 0;
handles.data.plotFlag         = 1;
handles.data.plot3dFlag       = 1;
handles.data.playSoundFlag    = 0;
handles.data.windowFlag       = 0;
handles.data.castSignalFlag   = 0;
handles.data.exitFlag         = 0;

handles.data.graphTitle       = 'Graph Title';
handles.data.timeT            = 1.0;
handles.data.timeS0           = 0.0;
handles.data.timeE0           = 1.0;
handles.data.tauMinus         = -0.005;
handles.data.tauPlus          = +0.005;
handles.data.clipVal          = 0.2;
handles.data.Fs               = 44100;

handles.data.xLabelStr        = 'Tau';
handles.data.yLabelStr        = 'Time';
handles.data.xUnitStr         = 'ms';
handles.data.yUnitStr         = 'sec';
handles.data.xUnitScale       = 1000.0;
handles.data.yUnitScale       = 1.0;

handles.data.pname            = '';
handles.data.fname            = '';
handles.data.wavFileName      = '';
handles.data.defCsvFileName   = '';

handles.data.chDefs           = {};
handles.data.ch               = {};
handles.data.csvFileNames     = {};
handles.data.tmpText_chDefs   = {};

handles.data.nacfAndoFlag     = 0;
handles.data.phiFlag          = 1;

handles.data.numberOfHeaders  = 6;


set( handles.popupmenu1, 'value',  handles.data.funcFlag );
set( handles.checkbox1,  'value',  handles.data.normalizeFlag );
set( handles.checkbox2,  'value',  handles.data.calcTauE_VecFlag );
set( handles.checkbox12, 'value',  handles.data.nacfSingleFlag );
set( handles.checkbox3,  'value',  handles.data.dumpFlag );
set( handles.checkbox4,  'value',  handles.data.debugFlag );
set( handles.checkbox5,  'value',  handles.data.debugStepFlag );
set( handles.checkbox6,  'value',  handles.data.plotFlag );
set( handles.checkbox7,  'value',  handles.data.plot3dFlag );
set( handles.checkbox8,  'value',  handles.data.cyclicFlag );

set( handles.edit6,      'String', handles.data.defCsvFileName );
set( handles.edit7,      'String', handles.data.wavFileName );
set( handles.edit8,      'String', handles.data.timeS0 );
set( handles.edit9,      'String', handles.data.timeE0 );
set( handles.edit12,     'String', handles.data.timeT );
set( handles.edit25,     'String', handles.data.graphTitle );
set( handles.edit26,     'String', handles.data.clipVal );
set( handles.edit27,     'String', handles.data.Fs );

set( handles.text32,     'String', handles.data.tmpText_chDefs );

set( handles.text15,     'String', [ 'Start ' handles.data.yLabelStr ' [' handles.data.yUnitStr ']' ] );
set( handles.text16,     'String', [ 'End '   handles.data.yLabelStr ' [' handles.data.yUnitStr ']' ] );
set( handles.text19,     'String', [ 'T' ' [' handles.data.yUnitStr ']' ] );


% Update handles structure
guidata( handles.figure1, handles );


% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.

if isfield(handles, 'data') && ~isreset
    return;
end;


try
    handles.data = open_history_( 'commandHistory_GUI_nACF_ICCF.mat', 'ERROR: open_history_() : No Command History File.' );

    handles.data.playSoundFlag    = 0;
catch err
    handles.data.funcFlag         = 1;
    handles.data.normalizeFlag    = 1;
    handles.data.nacfSingleFlag   = 0;
    handles.data.calcTauE_VecFlag = 0;
    handles.data.cyclicFlag       = 0;
    handles.data.dumpFlag         = 0;
    handles.data.debugFlag        = 1;
    handles.data.debugStepFlag    = 0;
    handles.data.plotFlag         = 1;
    handles.data.plot3dFlag       = 1;
    handles.data.playSoundFlag    = 0;
    handles.data.windowFlag       = 0;
    handles.data.castSignalFlag   = 0;
    handles.data.exitFlag         = 0;
    
    handles.data.graphTitle       = 'Graph Title';
    handles.data.timeT            = 1.0;
    handles.data.timeS0           = 0.0;
    handles.data.timeE0           = 1.0;
    handles.data.tauMinus         = -0.005;
    handles.data.tauPlus          = +0.005;
    handles.data.clipVal          = 0.2;
    handles.data.Fs               = 44100;
    
    handles.data.xLabelStr        = 'Tau';
    handles.data.yLabelStr        = 'Time';
    handles.data.xUnitStr         = 'ms';
    handles.data.yUnitStr         = 'sec';
    handles.data.xUnitScale       = 1000.0;
    handles.data.yUnitScale       = 1.0;
    
    handles.data.pname            = '';
    handles.data.fname            = '';
    handles.data.wavFileName      = '';
    handles.data.defCsvFileName   = '';
    
    handles.data.chDefs           = {};
    handles.data.ch               = {};
    handles.data.csvFileNames     = {};
    handles.data.tmpText_chDefs   = {};
    
    handles.data.nacfAndoFlag     = 0;
    handles.data.phiFlag          = 1;
    
    handles.data.numberOfHeaders  = 6;

    write_history_( handles.data, 'commandHistory_GUI_nACF_ICCF.mat', 'ERROR: write_history_() : No Command History File.' );
end;


set( handles.popupmenu1, 'value',  handles.data.funcFlag );
set( handles.checkbox1,  'value',  handles.data.normalizeFlag );
set( handles.checkbox2,  'value',  handles.data.calcTauE_VecFlag );
set( handles.checkbox12, 'value',  handles.data.nacfSingleFlag );
set( handles.checkbox3,  'value',  handles.data.dumpFlag );
set( handles.checkbox4,  'value',  handles.data.debugFlag );
set( handles.checkbox5,  'value',  handles.data.debugStepFlag );
set( handles.checkbox6,  'value',  handles.data.plotFlag );
set( handles.checkbox7,  'value',  handles.data.plot3dFlag );
set( handles.checkbox8,  'value',  handles.data.cyclicFlag );

set( handles.edit6,      'String', handles.data.defCsvFileName );
set( handles.edit7,      'String', handles.data.wavFileName );
set( handles.edit8,      'String', handles.data.timeS0 );
set( handles.edit9,      'String', handles.data.timeE0 );
set( handles.edit12,     'String', handles.data.timeT );
set( handles.edit25,     'String', handles.data.graphTitle );
set( handles.edit26,     'String', handles.data.clipVal );
set( handles.edit27,     'String', handles.data.Fs );

set( handles.text32,     'String', handles.data.tmpText_chDefs );

set( handles.text15,     'String', [ 'Start ' handles.data.yLabelStr ' [' handles.data.yUnitStr ']' ] );
set( handles.text16,     'String', [ 'End '   handles.data.yLabelStr ' [' handles.data.yUnitStr ']' ] );
set( handles.text19,     'String', [ 'T' ' [' handles.data.yUnitStr ']' ] );


% Update handles structure
guidata( handles.figure1, handles );


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1

handles.data.normalizeFlag = get( hObject, 'value' );

%disp(handles.data);

guidata(hObject,handles);


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2

%handles.data.phiFlag = get( hObject, 'value' );
handles.data.calcTauE_VecFlag = get( hObject, 'value' );

%disp(handles.data);

guidata(hObject,handles);


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3

handles.data.dumpFlag = get( hObject, 'value' );

%disp(handles.data);

guidata(hObject,handles);


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4

handles.data.debugFlag = get( hObject, 'value' );

%disp(handles.data);

guidata(hObject,handles);


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5

handles.data.debugStepFlag = get( hObject, 'value' );

%disp(handles.data);

guidata(hObject,handles);


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6

handles.data.plotFlag = get( hObject, 'value' );

%disp(handles.data);

guidata(hObject,handles);


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7

handles.data.plot3dFlag = get( hObject, 'value' );

%disp(handles.data);

guidata(hObject,handles);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.data.exitFlag = 1;

guidata(hObject,handles);

close;


function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double

handles.data.defCsvFileName = get( hObject, 'String' );

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[ fname, pname ] = uigetfile( '_CSVs/*.csv', 'CSV Definition File' );
defCsvFileName = strcat( pname, fname );

handles.data.fname = fname;
handles.data.pname = pname;

handles.data.defCsvFileName = defCsvFileName;
handles.data.wavFileName = '';

handles.data.debugFlag = 0;


fileID = fopen( defCsvFileName );
[ scanData ] = textscan( fileID, '%s %s', 'delimiter', ',' );
fclose(fileID);


handles.data.ch = scanData{ 1, 1 };
handles.data.csvFileNames  = scanData{ 1, 2 };

handles.data.graphTitle    = handles.data.ch{ 1 };
handles.data.timeS0        = castNum_( handles.data.ch{ 2 } );
handles.data.timeE0        = castNum_( handles.data.csvFileNames{ 2 } );

%disp( handles.data );
%pause;

handles.data.timeT         = castNum_( handles.data.ch{ 3 } );
handles.data.xLabelStr     = handles.data.ch{ 4 };
handles.data.yLabelStr     = handles.data.csvFileNames{ 4 };
handles.data.xUnitStr      = handles.data.ch{ 5 };
handles.data.yUnitStr      = handles.data.csvFileNames{ 5 };
handles.data.xUnitScale    = castNum_( handles.data.ch{ 6 } );
handles.data.yUnitScale    = castNum_( handles.data.csvFileNames{ 6 } );

handles.data.tauMinus      = -handles.data.timeT;
handles.data.tauPlus       = +handles.data.timeT;

handles.data.nCsvFileNames = length( handles.data.ch );


chDefs = {};
tmpText_chDefs = {};
for i = handles.data.numberOfHeaders+1 : length( handles.data.ch ),
    chDefs{ i - handles.data.numberOfHeaders, 1 } = handles.data.ch{ i };
    chDefs{ i - handles.data.numberOfHeaders, 2 } = handles.data.csvFileNames{ i };
    tmpText_chDefs{ i } = strcat( handles.data.ch{ i }, ' , ', handles.data.csvFileNames{ i } );
end;

handles.data.chDefs = chDefs;
handles.data.tmpText_chDefs = tmpText_chDefs;

handles.data.Fs = 1;


set( handles.checkbox4, 'value',  handles.data.debugFlag );
        
set( handles.edit25,    'String', handles.data.graphTitle );

set( handles.text32,    'String', handles.data.tmpText_chDefs );

set( handles.text15,    'String', [ 'Start ' handles.data.xLabelStr ' [' handles.data.xUnitStr ']' ] );
set( handles.text16,    'String', [ 'End ' handles.data.xLabelStr ' [' handles.data.xUnitStr ']' ] );
set( handles.text19,    'String', [ 'T' ' [' handles.data.yUnitStr ']' ] );

set( handles.edit7,     'String', handles.data.wavFileName );

set( handles.edit6,     'String', handles.data.defCsvFileName );
set( handles.edit8,     'String', handles.data.timeS0 );
set( handles.edit9,     'String', handles.data.timeE0 );
set( handles.edit12,    'String', handles.data.timeT ); 

set( handles.edit27,    'String', handles.data.Fs );    


guidata( hObject, handles );


function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double

handles.data.wavFileName = get( hObject, 'String' );

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[ fname, pname ] = uigetfile( '_Sounds/*.wav', 'WAV Sound File' );
wavFileName = strcat( pname, fname );


handles.data.fname = fname;
handles.data.pname = pname;

handles.data.wavFileName = wavFileName;


%[ s, fs, bits ] = wavread( wavFileName );
[ s, fs ] = audioread( wavFileName );
handles.data.Fs = fs;
handles.data.timeS0 = 0.0;
handles.data.timeE0  = length(s) / fs;
%handles.data.timeT = castNum_( handles.data.timeE0 / 10 - fractionalPart_( handles.data.timeE0 / 10 ) );
handles.data.timeT = 1.0;
handles.data.tauMinus = -handles.data.timeT;
handles.data.tauPlus  = +handles.data.timeT;


handles.data.graphTitle = fname;

handles.data.xLabelStr  = 'Tau';
handles.data.yLabelStr  = 'Time';
handles.data.xUnitStr   = 'ms';
handles.data.yUnitStr   = 'sec';
handles.data.xUnitScale = 1000.0;
handles.data.yUnitScale = 1.0;

handles.data.chDefs              = {};
handles.data.ch                    = {};
handles.data.csvFileNames     = {};
handles.data.tmpText_chDefs = {};
    
handles.data.defCsvFileName   = '';


handles.data.numberOfHeaders = 0;


set( handles.edit6,   'String', handles.data.defCsvFileName );

set( handles.edit7,  'String', handles.data.wavFileName );
set( handles.edit8,  'String', handles.data.timeS0 );
set( handles.edit9,  'String', handles.data.timeE0 );
set( handles.edit12, 'String', handles.data.timeT );
set( handles.edit25, 'String', handles.data.graphTitle );
set( handles.edit27, 'String', handles.data.Fs );


guidata(hObject,handles);


function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double

handles.data.timeS0 = castNum_( get( hObject, 'String' ) );

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double

handles.data.timeE0 = castNum_( get( hObject, 'String' ) );

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double

handles.data.tauMinus = castNum_( get( hObject, 'String' ) );

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double

handles.data.tauPlus = castNum_( get( hObject, 'String' ) );

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double

handles.data.timeT = castNum_( get( hObject, 'String' ) );
handles.data.tauMinus = castNum_( -handles.data.timeT );
handles.data.tauPlus  = castNum_( +handles.data.timeT );

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.data.cyclicFlag = get( hObject, 'value' );

%disp(handles.data);

guidata(hObject,handles);


function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double

handles.data.chDefs = get( hObject, 'String' );

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double

handles.data.graphTitle = get( hObject, 'String' );

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.data.playSoundFlag = 1;

guidata(hObject,handles);

uiresume( gcf );


% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox12

handles.data.nacfSingleFlag = get( hObject, 'value' );

guidata(hObject,handles);


function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double

handles.data.clipVal = get( hObject, 'String' );

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit27 as text
%        str2double(get(hObject,'String')) returns contents of edit27 as a double

handles.data.Fs = get( hObject, 'String' );

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

handles.data.funcFlag = get( hObject, 'value' );

%disp(handles.data);

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


% --- Executes during object creation, after setting all properties.
function pushbutton10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
guidata( hObject, handles );


% --- Executes during object creation, after setting all properties.
function pushbutton11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
guidata( hObject, handles );


% --- Executes during object creation, after setting all properties.
function pushbutton13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
guidata( hObject, handles );


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fileID = fopen( strcat( handles.data.pname, handles.data.fname ), 'w+');

for m = 1 : handles.data.nCsvFileNames,
    fprintf( fileID, '%s,%s\n', char( handles.data.ch( m ) ), char( handles.data.csvFileNames( m ) ) );
end;

fclose( fileID );

guidata(hObject,handles);
