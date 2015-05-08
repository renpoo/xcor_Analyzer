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
    write_history_( handles.flagsdata, 'commandHistory_GUI_nACF_ICCF.mat', 'ERROR: write_history_() : No Command History File.' );
else
    %gui_mainfcn(gui_State, varargin{:});
end

close;



% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%disp(handles.flagsdata);

%GUI_nACF_ICCF_OutputFcn(hObject, eventdata, handles);

uiresume( gcf );


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.flagsdata.funcFlag              = 1;
handles.flagsdata.normalizeFlag       = 1;
handles.flagsdata.nacfSingleFlag      = 0;
handles.flagsdata.calcTauE_VecFlag = 0;
handles.flagsdata.cyclicFlag            = 0;
handles.flagsdata.dumpFlag             = 0;
handles.flagsdata.debugFlag            = 1;
handles.flagsdata.debugStepFlag      = 0;
handles.flagsdata.plotFlag               = 1;
handles.flagsdata.plot3dFlag            = 1;
handles.flagsdata.playSoundFlag      = 0;
handles.flagsdata.windowFlag          = 0;
handles.flagsdata.castSignalFlag      = 0;
handles.flagsdata.exitFlag               = 0;

handles.flagsdata.graphTitle            = 'Graph Title';
handles.flagsdata.time_T                 = 1.0;
handles.flagsdata.tS0                     = 0.0;
handles.flagsdata.tE0                     = 1.0;
handles.flagsdata.tStart                 = -0.005;
handles.flagsdata.tStop                  = +0.005;
handles.flagsdata.clipVal                 = 0.2;
handles.flagsdata.Fs                       = 44100;

handles.flagsdata.xLabelStr             = 'Time';
handles.flagsdata.yLabelStr             = 'Time';
handles.flagsdata.xUnitStr              = 'sec';
handles.flagsdata.yUnitStr              = 'sec';

handles.flagsdata.pname                 = '';
handles.flagsdata.fname                  = '';
handles.flagsdata.wavFileName        = '';
handles.flagsdata.defCsvFileName    = '';

handles.flagsdata.chDefs                = {};
handles.flagsdata.ch                      = {};
handles.flagsdata.csvFileNames       = {};
handles.flagsdata.tmpText_chDefs   = {};

handles.flagsdata.nacfAndoFlag        = 0;
handles.flagsdata.phiFlag                 = 1;

handles.flagsdata.numberOfHeaders = 5;


set( handles.popupmenu1, 'value', handles.flagsdata.funcFlag );
set( handles.checkbox1,   'value', handles.flagsdata.normalizeFlag );
set( handles.checkbox2,   'value', handles.flagsdata.calcTauE_VecFlag );
set( handles.checkbox12,  'value', handles.flagsdata.nacfSingleFlag );
set( handles.checkbox3,   'value', handles.flagsdata.dumpFlag );
set( handles.checkbox4,   'value', handles.flagsdata.debugFlag );
set( handles.checkbox5,   'value', handles.flagsdata.debugStepFlag );
set( handles.checkbox6,   'value', handles.flagsdata.plotFlag );
set( handles.checkbox7,   'value', handles.flagsdata.plot3dFlag );
set( handles.checkbox8,   'value', handles.flagsdata.cyclicFlag );

set( handles.edit6,   'String', handles.flagsdata.defCsvFileName );
set( handles.edit7,   'String', handles.flagsdata.wavFileName );
set( handles.edit8,   'String', handles.flagsdata.tS0 );
set( handles.edit9,   'String', handles.flagsdata.tE0 );
set( handles.edit12, 'String', handles.flagsdata.time_T );
set( handles.edit25, 'String', handles.flagsdata.graphTitle );
set( handles.edit26, 'String', handles.flagsdata.clipVal );
set( handles.edit27, 'String', handles.flagsdata.Fs );

set( handles.text32, 'String', handles.flagsdata.tmpText_chDefs );

set( handles.text15, 'String', [ 'Start ' handles.flagsdata.xLabelStr ' [' handles.flagsdata.xUnitStr ']' ] );
set( handles.text16, 'String', [ 'End ' handles.flagsdata.xLabelStr ' [' handles.flagsdata.xUnitStr ']' ] );
set( handles.text19, 'String', [ 'T' ' [' handles.flagsdata.yUnitStr ']' ] );


% Update handles structure
guidata( handles.figure1, handles );


% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.

if isfield(handles, 'flagsdata') && ~isreset
    return;
end;


try
    handles.flagsdata = open_history_( 'commandHistory_GUI_nACF_ICCF.mat', 'ERROR: open_history_() : No Command History File.' );
catch err
    handles.flagsdata.funcFlag              = 1;
    handles.flagsdata.normalizeFlag       = 1;
    handles.flagsdata.nacfSingleFlag      = 0;
    handles.flagsdata.calcTauE_VecFlag = 0;
    handles.flagsdata.cyclicFlag            = 0;
    handles.flagsdata.dumpFlag             = 0;
    handles.flagsdata.debugFlag            = 1;
    handles.flagsdata.debugStepFlag      = 0;
    handles.flagsdata.plotFlag               = 1;
    handles.flagsdata.plot3dFlag            = 1;
    handles.flagsdata.playSoundFlag      = 0;
    handles.flagsdata.windowFlag          = 0;
    handles.flagsdata.castSignalFlag      = 0;
    handles.flagsdata.exitFlag               = 0;
    
    handles.flagsdata.graphTitle            = '';
    handles.flagsdata.time_T                 = 1.0;
    handles.flagsdata.tS0                     = 0.0;
    handles.flagsdata.tE0                     = 1.0;
    handles.flagsdata.tStart                 = -0.005;
    handles.flagsdata.tStop                  = +0.005;
    handles.flagsdata.clipVal                 = 0.2;
    handles.flagsdata.Fs                       = 44100;
    
    handles.flagsdata.xLabelStr             = 'Time';
    handles.flagsdata.yLabelStr             = 'Time';
    handles.flagsdata.xUnitStr              = 'sec';
    handles.flagsdata.yUnitStr              = 'sec';
    
    handles.flagsdata.pname                 = '';
    handles.flagsdata.fname                  = '';
    handles.flagsdata.wavFileName        = '';
    handles.flagsdata.defCsvFileName    = '';

    handles.flagsdata.chDefs                = {};
    handles.flagsdata.ch                      = {};
    handles.flagsdata.csvFileNames       = {};
    handles.flagsdata.tmpText_chDefs   = {};
    
    handles.flagsdata.nacfAndoFlag        = 0;
    handles.flagsdata.phiFlag                 = 1;
    
    handles.flagsdata.numberOfHeaders = 5;
    
    write_history_( handles.flagsdata, 'commandHistory_GUI_nACF_ICCF.mat', 'ERROR: write_history_() : No Command History File.' );
end;

    
if ( 1 ),
    
    set( handles.popupmenu1, 'value', handles.flagsdata.funcFlag );
    set( handles.checkbox1,   'value', handles.flagsdata.normalizeFlag );
    set( handles.checkbox2,   'value', handles.flagsdata.calcTauE_VecFlag );
    set( handles.checkbox12,  'value', handles.flagsdata.nacfSingleFlag );
    set( handles.checkbox3,   'value', handles.flagsdata.dumpFlag );
    set( handles.checkbox4,   'value', handles.flagsdata.debugFlag );
    set( handles.checkbox5,   'value', handles.flagsdata.debugStepFlag );
    set( handles.checkbox6,   'value', handles.flagsdata.plotFlag );
    set( handles.checkbox7,   'value', handles.flagsdata.plot3dFlag );
    set( handles.checkbox8,   'value', handles.flagsdata.cyclicFlag );
    
    set( handles.edit6,   'String', handles.flagsdata.defCsvFileName );
    set( handles.edit7,   'String', handles.flagsdata.wavFileName );
    set( handles.edit8,   'String', handles.flagsdata.tS0 );
    set( handles.edit9,   'String', handles.flagsdata.tE0 );
    set( handles.edit12, 'String', handles.flagsdata.time_T );
    set( handles.edit25, 'String', handles.flagsdata.graphTitle );
    set( handles.edit26, 'String', handles.flagsdata.clipVal );
    set( handles.edit27, 'String', handles.flagsdata.Fs );
    
    set( handles.text32, 'String', handles.flagsdata.tmpText_chDefs );
    
    set( handles.text15, 'String', [ 'Start ' handles.flagsdata.xLabelStr ' [' handles.flagsdata.xUnitStr ']' ] );
    set( handles.text16, 'String', [ 'End ' handles.flagsdata.xLabelStr ' [' handles.flagsdata.xUnitStr ']' ] );
    set( handles.text19, 'String', [ 'T' ' [' handles.flagsdata.yUnitStr ']' ] );

end;


% Update handles structure
guidata( handles.figure1, handles );


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1

handles.flagsdata.normalizeFlag = get( hObject, 'value' );

%disp(handles.flagsdata);

guidata(hObject,handles);


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2

%handles.flagsdata.phiFlag = get( hObject, 'value' );
handles.flagsdata.calcTauE_VecFlag = get( hObject, 'value' );

%disp(handles.flagsdata);

guidata(hObject,handles);


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3

handles.flagsdata.dumpFlag = get( hObject, 'value' );

%disp(handles.flagsdata);

guidata(hObject,handles);


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4

handles.flagsdata.debugFlag = get( hObject, 'value' );

%disp(handles.flagsdata);

guidata(hObject,handles);


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5

handles.flagsdata.debugStepFlag = get( hObject, 'value' );

%disp(handles.flagsdata);

guidata(hObject,handles);


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6

handles.flagsdata.plotFlag = get( hObject, 'value' );

%disp(handles.flagsdata);

guidata(hObject,handles);


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7

handles.flagsdata.plot3dFlag = get( hObject, 'value' );

%disp(handles.flagsdata);

guidata(hObject,handles);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.flagsdata.exitFlag = 1;

guidata(hObject,handles);

close;


function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double

handles.flagsdata.defCsvFileName = get( hObject, 'String' );

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

handles.flagsdata.fname = fname;
handles.flagsdata.pname = pname;

handles.flagsdata.defCsvFileName = defCsvFileName;
handles.flagsdata.wavFileName = '';

handles.flagsdata.debugFlag = 0;

%handles.flagsdata.numberOfHeaders = 5;


[ ch, csvFileNames ] = textread( defCsvFileName, '%s %s', 'delimiter', ',' );


handles.flagsdata.ch = ch;
handles.flagsdata.csvFileNames = csvFileNames;

handles.flagsdata.graphTitle = ch{1};
handles.flagsdata.tS0          = str2num( ch{2} );
handles.flagsdata.tE0          = str2num( csvFileNames{2} );
handles.flagsdata.time_T      = str2num( ch{3} );
handles.flagsdata.xLabelStr  = ch{4};
handles.flagsdata.yLabelStr  = csvFileNames{4};
handles.flagsdata.xUnitStr   = ch{5};
handles.flagsdata.yUnitStr   = csvFileNames{5};

handles.flagsdata.tStart      = -handles.flagsdata.time_T; % / 2.0;
handles.flagsdata.tStop       = +handles.flagsdata.time_T; % / 2.0;

handles.flagsdata.nCsvFileNames = length( csvFileNames );


chDefs              = {};
tmpText_chDefs = {};
for i = handles.flagsdata.numberOfHeaders+1 : length( ch ),
    chDefs{ i - handles.flagsdata.numberOfHeaders, 1 } = ch{ i };
    chDefs{ i - handles.flagsdata.numberOfHeaders, 2 } = csvFileNames{ i };
    tmpText_chDefs{ i } = strcat( ch{ i }, ' , ', csvFileNames{ i } );
end;

handles.flagsdata.chDefs              = chDefs;
handles.flagsdata.tmpText_chDefs = tmpText_chDefs;

handles.flagsdata.Fs                    = 1;


set( handles.checkbox4,   'value', handles.flagsdata.debugFlag );
        
set( handles.edit25, 'String', handles.flagsdata.graphTitle );

set( handles.text32, 'String', handles.flagsdata.tmpText_chDefs );

set( handles.text15, 'String', [ 'Start ' handles.flagsdata.xLabelStr ' [' handles.flagsdata.xUnitStr ']' ] );
set( handles.text16, 'String', [ 'End ' handles.flagsdata.xLabelStr ' [' handles.flagsdata.xUnitStr ']' ] );
set( handles.text19, 'String', [ 'T' ' [' handles.flagsdata.yUnitStr ']' ] );

set( handles.edit7,   'String', handles.flagsdata.wavFileName );

set( handles.edit6, 'String', handles.flagsdata.defCsvFileName );
set( handles.edit8, 'String', handles.flagsdata.tS0 );
set( handles.edit9, 'String', handles.flagsdata.tE0 );
set( handles.edit12, 'String', handles.flagsdata.time_T ); 

set( handles.edit27, 'String', handles.flagsdata.Fs );    


guidata( hObject, handles );


function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double

handles.flagsdata.wavFileName = get( hObject, 'String' );

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


handles.flagsdata.fname = fname;
handles.flagsdata.pname = pname;

handles.flagsdata.wavFileName = wavFileName;


%[ s, fs, bits ] = wavread( wavFileName );
[ s, fs ] = audioread( wavFileName );
handles.flagsdata.Fs = fs;
handles.flagsdata.tS0 = 0.0;
handles.flagsdata.tE0  = length(s) / fs;
handles.flagsdata.time_T = ( handles.flagsdata.tE0 / 10 - fractionalPart_( handles.flagsdata.tE0 / 10 ) );
handles.flagsdata.tStart = -handles.flagsdata.time_T; % / 2.0;
handles.flagsdata.tStop  = +handles.flagsdata.time_T; % / 2.0;


handles.flagsdata.graphTitle = fname;

handles.flagsdata.xLabelStr = 'Time';
handles.flagsdata.yLabelStr = 'Time';
handles.flagsdata.xUnitStr   = 'sec';
handles.flagsdata.yUnitStr   = 'sec';

handles.flagsdata.chDefs              = {};
handles.flagsdata.ch                    = {};
handles.flagsdata.csvFileNames     = {};
handles.flagsdata.tmpText_chDefs = {};
    
handles.flagsdata.defCsvFileName   = '';


set( handles.edit6,   'String', handles.flagsdata.defCsvFileName );

set( handles.edit7,  'String', handles.flagsdata.wavFileName );
set( handles.edit8,  'String', handles.flagsdata.tS0 );
set( handles.edit9,  'String', handles.flagsdata.tE0 );
set( handles.edit12, 'String', handles.flagsdata.time_T );
set( handles.edit25, 'String', handles.flagsdata.graphTitle );
set( handles.edit27, 'String', handles.flagsdata.Fs );


guidata(hObject,handles);


function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double

handles.flagsdata.tS0 = str2num( get( hObject, 'String' ) );

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

handles.flagsdata.tE0 = str2num( get( hObject, 'String' ) );

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

handles.flagsdata.tStart = str2num( get( hObject, 'String' ) );

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

handles.flagsdata.tStop = str2num( get( hObject, 'String' ) );

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

handles.flagsdata.time_T = str2num( get( hObject, 'String' ) );
%handles.flagsdata.time_T = ceil( handles.flagsdata.tE0 / handles.flagsdata.time_T ) - 1;
handles.flagsdata.tStart = -handles.flagsdata.time_T; % / 2.0;
handles.flagsdata.tStop  = +handles.flagsdata.time_T; % / 2.0;

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

handles.flagsdata.cyclicFlag = get( hObject, 'value' );

%disp(handles.flagsdata);

guidata(hObject,handles);


function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double

handles.flagsdata.chDefs = get( hObject, 'String' );

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

handles.flagsdata.graphTitle = get( hObject, 'String' );

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

handles.flagsdata.playSoundFlag = 1;

guidata(hObject,handles);

uiresume( gcf );


% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox12

handles.flagsdata.nacfSingleFlag = get( hObject, 'value' );

guidata(hObject,handles);


function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double

handles.flagsdata.clipVal = get( hObject, 'String' );

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

handles.flagsdata.Fs = get( hObject, 'String' );

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

handles.flagsdata.funcFlag = get( hObject, 'value' );

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

fileID = fopen( strcat( handles.flagsdata.pname, handles.flagsdata.fname ), 'w+');

for m = 1 : handles.flagsdata.nCsvFileNames,
    fprintf( fileID, '%s,%s\n', char( handles.flagsdata.ch( m ) ), char( handles.flagsdata.csvFileNames( m ) ) );
end;

fclose( fileID );

guidata(hObject,handles);
