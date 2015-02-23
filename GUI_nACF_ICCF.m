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

% Last Modified by GUIDE v2.5 21-Feb-2015 07:44:43

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

if (0),
    disp('######');
    disp( length(varargin{ : }) );
    if (nargin > 0),
        handles = varargin{ : } ;
    end;
    disp('######');
end;

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


handles.flagsdata.funcFlag         = 2;
handles.flagsdata.nacfAndoFlag  = 0;
handles.flagsdata.phiFlag           = 1;
handles.flagsdata.dumpFlag        = 0;
handles.flagsdata.debugFlag       = 1;
handles.flagsdata.debugStepFlag = 0;
handles.flagsdata.plotFlag          = 1;
handles.flagsdata.plot3dFlag       = 1;

handles.flagsdata.exitFlag          = 0;

handles.flagsdata.graphTitle       = 'GraphTest';
handles.flagsdata.nStepIdx         = 100;
handles.flagsdata.tS0                = 0.0;
handles.flagsdata.tE0                = 10.0;
handles.flagsdata.tStart            = -0.005;
handles.flagsdata.tStop             = +0.005;

handles.flagsdata.defCsvFileName   = '';
handles.flagsdata.wavFileName       = '';


set( handles.popupmenu1, 'value', handles.flagsdata.funcFlag );
set( handles.checkbox1,   'value', handles.flagsdata.nacfAndoFlag );
set( handles.checkbox2,   'value', handles.flagsdata.phiFlag );
set( handles.checkbox3,   'value', handles.flagsdata.dumpFlag );
set( handles.checkbox4,   'value', handles.flagsdata.debugFlag );
set( handles.checkbox5,   'value', handles.flagsdata.debugStepFlag );
set( handles.checkbox6,   'value', handles.flagsdata.plotFlag );
set( handles.checkbox7,   'value', handles.flagsdata.plot3dFlag );


set( handles.edit6,   'String', handles.flagsdata.defCsvFileName );
set( handles.edit7,   'String', handles.flagsdata.wavFileName );
set( handles.edit8,   'String', handles.flagsdata.tS0 );
set( handles.edit9,   'String', handles.flagsdata.tE0 );
set( handles.edit10,  'String', handles.flagsdata.tStart );
set( handles.edit11,  'String', handles.flagsdata.tStop );
set( handles.edit12, 'String', handles.flagsdata.nStepIdx );
set( handles.edit25, 'String', handles.flagsdata.graphTitle );

    
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


% Global Constant as Magic Number
%handles.flagsdata.numberOfHeaders = 4; % For CSV Definition File

handles.flagsdata = open_history_( 'commandHistory_GUI_nACF_ICCF.mat', 'ERROR: write_history_() : No Command History File.' );

%handles.flagsdata.exitFlag = 0;

disp( handles.flagsdata );

if ( 0 ),
    handles.flagsdata.funcFlag         = 2;
    handles.flagsdata.nacfAndoFlag  = 0;
    handles.flagsdata.phiFlag           = 1;
    handles.flagsdata.dumpFlag        = 0;
    handles.flagsdata.debugFlag       = 1;
    handles.flagsdata.debugStepFlag = 0;
    handles.flagsdata.plotFlag          = 1;
    handles.flagsdata.plot3dFlag       = 1;
    
    handles.flagsdata.exitFlag          = 0;

    handles.flagsdata.graphTitle       = 'GraphTest';
    handles.flagsdata.nStepIdx         = 100;
    handles.flagsdata.tS0                = 0.0;
    handles.flagsdata.tE0                = 10.0;
    handles.flagsdata.tStart            = -0.005;
    handles.flagsdata.tStop             = +0.005;

    handles.flagsdata.defCsvFileName   = '';
    handles.flagsdata.wavFileName       = '';
end;

if ( 1 ),    
    set( handles.popupmenu1, 'value', handles.flagsdata.funcFlag );
    set( handles.checkbox1,   'value', handles.flagsdata.nacfAndoFlag );
    set( handles.checkbox2,   'value', handles.flagsdata.phiFlag );
    set( handles.checkbox3,   'value', handles.flagsdata.dumpFlag );
    set( handles.checkbox4,   'value', handles.flagsdata.debugFlag );
    set( handles.checkbox5,   'value', handles.flagsdata.debugStepFlag );
    set( handles.checkbox6,   'value', handles.flagsdata.plotFlag );
    set( handles.checkbox7,   'value', handles.flagsdata.plot3dFlag );


    set( handles.edit6,   'String', handles.flagsdata.defCsvFileName );
    set( handles.edit7,   'String', handles.flagsdata.wavFileName );
    set( handles.edit8,   'String', handles.flagsdata.tS0 );
    set( handles.edit9,   'String', handles.flagsdata.tE0 );
    set( handles.edit10,  'String', handles.flagsdata.tStart );
    set( handles.edit11,  'String', handles.flagsdata.tStop );
    set( handles.edit12, 'String', handles.flagsdata.nStepIdx );
    set( handles.edit25, 'String', handles.flagsdata.graphTitle );
end;

%disp(handles.flagsdata);

% Update handles structure
guidata( handles.figure1, handles );


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


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1

handles.flagsdata.nacfAndoFlag = get( hObject, 'value' );

%disp(handles.flagsdata);

guidata(hObject,handles);


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2

handles.flagsdata.phiFlag = get( hObject, 'value' );

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


function filenameStr = getAppropriateFileName( label, ch, csvFileNames, numberOfHeaders )
for ( i = numberOfHeaders + 1 : length( csvFileNames ) ),
    if ( strcmp( label, ch{ i } ) ),
        filenameStr = csvFileNames{ i };
        return;
    else
        filenameStr = '';
    end;
end;


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[ fname, pname ] = uigetfile( '*.csv', 'CSV Definition File' );
defCsvFileName = strcat( pname, fname );

handles.flagsdata.fname = fname;
handles.flagsdata.pname = pname;

handles.flagsdata.defCsvFileName = defCsvFileName;
handles.flagsdata.wavFileName = '';
handles.flagsdata.numberOfHeaders = 4;

[ ch, csvFileNames ] = textread( defCsvFileName, '%s %s', 'delimiter', ',' );

%disp(csvFileNames);

handles.flagsdata.ch = ch;
handles.flagsdata.csvFileNames = csvFileNames;

handles.flagsdata.graphTitle = ch{1};                            % FORCE to get TITLE name to treat
handles.flagsdata.tS0 = str2num( ch{2} );                     % FORCE to get tS (Start) to cut the whole music signals
handles.flagsdata.tE0 = str2num( csvFileNames{2} );      % FORCE to get tE (End)   to cut the whole music signals
handles.flagsdata.tStart = str2num( ch{3} );                  % FORCE to get tStart to calculate CCF
handles.flagsdata.tStop  = str2num( csvFileNames{3} );  % FORCE to get tStop  to calculate CCF
handles.flagsdata.nStepIdx = str2num( ch{4} );              % FORCE to get windowSize to calculate Realtime CCF


handles.flagsdata.nCsvFileNames = length( csvFileNames );

handles.flagsdata.ch1Wav = getAppropriateFileName( 'Right',    ch, csvFileNames, handles.flagsdata.numberOfHeaders );
handles.flagsdata.ch2Wav = getAppropriateFileName( 'Left',      ch, csvFileNames, handles.flagsdata.numberOfHeaders );
handles.flagsdata.ch3Wav = getAppropriateFileName( 'Top',      ch, csvFileNames, handles.flagsdata.numberOfHeaders );
handles.flagsdata.ch4Wav = getAppropriateFileName( 'Bottom', ch, csvFileNames, handles.flagsdata.numberOfHeaders );
handles.flagsdata.ch5Wav = getAppropriateFileName( 'Front',   ch, csvFileNames, handles.flagsdata.numberOfHeaders );
handles.flagsdata.ch6Wav = getAppropriateFileName( 'Hind',     ch, csvFileNames, handles.flagsdata.numberOfHeaders );

%disp(handles.flagsdata);

%{%}
set( handles.edit6, 'String', handles.flagsdata.defCsvFileName );
set( handles.edit8, 'String', str2num( ch{2} ) );
set( handles.edit9, 'String', str2num( csvFileNames{2} ) );
set( handles.edit10, 'String', str2num( ch{3} ) );
set( handles.edit11, 'String', str2num( csvFileNames{3} ) ); 
set( handles.edit12, 'String', str2num( ch{4} ) ); 
set( handles.edit13, 'String', getAppropriateFileName( 'Right',    ch, csvFileNames, handles.flagsdata.numberOfHeaders ) );
set( handles.edit14, 'String', getAppropriateFileName( 'Left',     ch, csvFileNames, handles.flagsdata.numberOfHeaders ) );
set( handles.edit15, 'String', getAppropriateFileName( 'Top',      ch, csvFileNames, handles.flagsdata.numberOfHeaders ) );
set( handles.edit16, 'String', getAppropriateFileName( 'Bottom', ch, csvFileNames, handles.flagsdata.numberOfHeaders ) );
set( handles.edit17, 'String', getAppropriateFileName( 'Front',    ch, csvFileNames, handles.flagsdata.numberOfHeaders ) );
set( handles.edit18, 'String', getAppropriateFileName( 'HInd',      ch, csvFileNames, handles.flagsdata.numberOfHeaders ) );
%{%}

%{
edit6_Callback( hObject, eventdata, handles );
edit7_Callback( hObject, eventdata, handles );
edit8_Callback(hObject, eventdata, handles);
edit9_Callback(hObject, eventdata, handles);
edit10_Callback(hObject, eventdata, handles);
edit11_Callback(hObject, eventdata, handles);
edit12_Callback(hObject, eventdata, handles);
edit13_Callback(hObject, eventdata, handles);
edit14_Callback(hObject, eventdata, handles);
edit15_Callback(hObject, eventdata, handles);
edit16_Callback(hObject, eventdata, handles);
edit17_Callback(hObject, eventdata, handles);
edit18_Callback(hObject, eventdata, handles);
edit25_Callback(hObject, eventdata, handles);
%}

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

[ fname, pname ] = uigetfile( '*.wav', 'WAV Sound File' );
wavFileName = strcat( pname, fname );


handles.flagsdata.fname = fname;
handles.flagsdata.pname = pname;

handles.flagsdata.wavFileName = wavFileName;


%[ s, fs, bits ] = wavread( wavFileName );
[ s, fs ] = audioread( wavFileName );
handles.flagsdata.tS0 = 0.0;
handles.flagsdata.tE0  = length(s) / fs - 0.1;
handles.flagsdata.nStepIdx = floor( handles.flagsdata.tE0 / 1.0 );

handles.flagsdata.wavFileName = wavFileName;
handles.flagsdata.graphTitle = fname;

%{
edit6_Callback( hObject, eventdata, handles );
edit7_Callback( hObject, eventdata, handles );
edit8_Callback(hObject, eventdata, handles);
edit9_Callback(hObject, eventdata, handles);
%}
set( handles.edit7, 'String', handles.flagsdata.wavFileName );
set( handles.edit8, 'String', 0.0 );
set( handles.edit9, 'String', length(s) / fs - 0.1 );
set( handles.edit12, 'String', floor( handles.flagsdata.tE0 / 1.0 ) );
set( handles.edit25, 'String', fname );
%{
edit10_Callback(hObject, eventdata, handles);
edit11_Callback(hObject, eventdata, handles);
edit12_Callback(hObject, eventdata, handles);
edit25_Callback(hObject, eventdata, handles);
%}


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

handles.flagsdata.tStart = get( hObject, 'String' );

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

handles.flagsdata.tStop = get( hObject, 'String' );

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

handles.flagsdata.nStepIdx = str2num( get( hObject, 'String' ) );

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

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9


% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10


% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox11



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double

handles.flagsdata.ch1Wav = get( hObject, 'String' );

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



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double

handles.flagsdata.ch2Wav = get( hObject, 'String' );

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double

handles.flagsdata.ch3Wav = get( hObject, 'String' );

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double

handles.flagsdata.ch4Wav = get( hObject, 'String' );

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double

handles.flagsdata.ch5Wav = get( hObject, 'String' );

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double

handles.flagsdata.ch6Wav = get( hObject, 'String' );

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


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



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


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



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


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



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


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



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


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



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


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


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



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
