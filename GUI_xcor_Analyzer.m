function varargout = GUI_xcor_Analyzer(varargin)
% GUI_XCOR_ANALYZER MATLAB code for GUI_xcor_Analyzer.fig
%      GUI_XCOR_ANALYZER, by itself, creates a new GUI_XCOR_ANALYZER or raises the existing
%      singleton*.
%
%      H = GUI_XCOR_ANALYZER returns the handle to a new GUI_XCOR_ANALYZER or the handle to
%      the existing singleton*.
%
%      GUI_XCOR_ANALYZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_XCOR_ANALYZER.M with the given input arguments.
%
%      GUI_XCOR_ANALYZER('Property','Value',...) creates a new GUI_XCOR_ANALYZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_xcor_Analyzer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_xcor_Analyzer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_xcor_Analyzer

% Last Modified by GUIDE v2.5 24-Feb-2017 16:27:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI_xcor_Analyzer_OpeningFcn, ...
    'gui_OutputFcn',  @GUI_xcor_Analyzer_OutputFcn, ...
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


% --- Executes just before GUI_xcor_Analyzer is made visible.
function GUI_xcor_Analyzer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_xcor_Analyzer (see VARARGIN)

% Choose default command line output for GUI_xcor_Analyzer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Custom Initializer
initialize_gui( hObject, handles, false );

% UIWAIT makes GUI_xcor_Analyzer wait for user response (see UIRESUME)
uiwait(handles.figure1);




% --------------------------------------------------------------------
function initialize_gui( hObject, handles, isreset )
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.

if isfield(handles, 'data') && ~isreset
    return;
end


try
    handles.data = open_history_( 'commandHistory_GUI_xcor_Analyzer.mat', 'ERROR: open_history_() : No Command History File.' );
    
    handles.data.exitFlag         = 0;
    %handles.data.playSoundFlag    = 0;
catch err
    [ handles.soundSignals, handles.data ] = resetData_();
    
    write_history_( handles.data, 'commandHistory_GUI_xcor_Analyzer.mat', 'ERROR: write_history_() : No Command History File.' );
end


if (isreset)
    [ handles.soundSignals, handles.data ] = resetData_();
end


set( handles.edit_InputSoundFile, 'String',  strcat( handles.data.pname, handles.data.fname ) );
set( handles.edit_GraphTitle,     'String',  handles.data.graphTitle );
set( handles.edit_StartTime,      'String',  handles.data.timeS0 );
set( handles.edit_EndTime,        'String',  handles.data.timeE0 );
set( handles.edit_T,              'String',  handles.data.timeT );
set( handles.edit_SamplingFreq,   'String',  handles.data.fs );
set( handles.edit_ClipValue,      'String',  handles.data.clipVal );

set( handles.edit_TauUnitLabel,   'String',  handles.data.xUnitStr );
set( handles.edit_TimeUnitLabel,  'String',  handles.data.yUnitStr );

set( handles.checkbox_PlaySoundOnCalc, 'value',  handles.data.playSoundFlag );
set( handles.checkbox_DumpData,        'value',  handles.data.dumpResultFlag );
set( handles.checkbox_SaveTheGraphPlotsIntoFiles, 'value',  handles.data.SaveTheGraphPlotsIntoFilesFlag );

set( handles.checkbox_PlotTauE_Vector, 'value',  handles.data.calcTauE_VecFlag );

set( handles.edit_TauUnitScale, 'value', handles.data.tauUnitScale );

set( handles.popupmenu_FileSuffix, 'value', handles.data.fileSuffixValue );


if ( handles.data.LRCflag == 'L' )
    LRCvalue = 1;
elseif ( handles.data.LRCflag == 'R' )
    LRCvalue = 2;
else
    LRCvalue = 3;
end

set( handles.popupmenu_CalcMode, 'value',  LRCvalue );


set( handles.checkbox_ApplyWindowFunc, 'value', handles.data.applyWindowFuncFlag );
set( handles.popupmenu_WindowFunc,     'value', handles.data.windowFuncMode );


set( handles.uitable_Filenames_w_Channel, 'Data', handles.data.chDefs );


% Update handles structure
guidata( hObject, handles );


% --------------------------------------------------------------------
function [ soundSignals, data ] = resetData_()
% Core Procedure to reset GUI parameters to the default

data.LRCflag          = 'R';
data.calcTauE_VecFlag = 0;
data.dumpResultFlag   = 0;
data.playSoundFlag    = 1;
data.SaveTheGraphPlotsIntoFilesFlag = 0;

data.exitFlag         = 0;

data.graphTitle       = 'Graph Title';
data.timeT            = 0.01;
data.timeS0           = 0.0;
data.timeE0           = 3.0;
data.clipVal          = 0.2;
data.fs               = 44100;

data.xLabelStr        = 'Tau';
data.yLabelStr        = 'Time';
data.xUnitStr         = 'ms';
data.yUnitStr         = 'sec';
data.xUnitScale       = 1000.0;
data.yUnitScale       = 1.0;

data.tauUnitScale     = 1.0 / data.xUnitScale;

data.applyWindowFuncFlag = 0;
data.windowFuncMode   = 1;

data.pname            = '';
data.fname            = 'INPUT Sound File';
data.defCsvFileName   = '';

data.chDefs           = {};

data.currentCellPosition = [ 0, 0 ];

data.fileSuffixValue  = 1;

data.batchModeFlag    = 0;

data.wavFileName      = '';

data.rWavFileName     = '';
data.lWavFileName     = '';
data.rWavChLabel      = '';
data.lWavChLabel      = '';


soundSignals.s        = [];
soundSignals.x0       = [];
soundSignals.y0       = [];


% --- Outputs from this function are returned to the command line.
function varargout = GUI_xcor_Analyzer_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

handles.output = 'Exit: GUI_xcor_Analyzer';

varargout{1} = handles.output;

if nargout
    [varargout{1:nargout}] = handles;
    
    % FORCE RESET for chDefs{}
    % handles.data.chDefs = {};
    
    write_history_( handles.data, 'commandHistory_GUI_xcor_Analyzer.mat', 'ERROR: write_history_() : No Command History File.' );
else
    %gui_mainfcn(gui_State, varargin{:});
end

close;


function edit_InputSoundFile_Callback(hObject, eventdata, handles)
% hObject    handle to edit_InputSoundFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_InputSoundFile as text
%        str2double(get(hObject,'String')) returns contents of edit_InputSoundFile as a double

handles.data.graphTitle = get( hObject, 'String' );

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_InputSoundFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_InputSoundFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_StartTime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_StartTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_StartTime as text
%        str2double(get(hObject,'String')) returns contents of edit_StartTime as a double

handles.data.timeS0 = castNum_( get( hObject, 'String' ) );

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_StartTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_StartTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_EndTime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_EndTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_EndTime as text
%        str2double(get(hObject,'String')) returns contents of edit_EndTime as a double

handles.data.timeE0 = castNum_( get( hObject, 'String' ) );

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_EndTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_EndTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_SamplingFreq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_SamplingFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_SamplingFreq as text
%        str2double(get(hObject,'String')) returns contents of edit_SamplingFreq as a double

handles.data.fs = castNum_( get( hObject, 'String' ) );

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_SamplingFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_SamplingFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ClipValue_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ClipValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ClipValue as text
%        str2double(get(hObject,'String')) returns contents of edit_ClipValue as a double

handles.data.clipVal = castNum_( get( hObject, 'String' ) );

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_ClipValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ClipValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_T_Callback(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_T as text
%        str2double(get(hObject,'String')) returns contents of edit_T as a double

handles.data.timeT = castNum_( get( hObject, 'String' ) );

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ReadSoundFile.
function pushbutton_ReadSoundFile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ReadSoundFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if ( handles.data.fileSuffixValue == 1 )
    [ fname, pname ] = uigetfile( '_Sounds/*.wav', 'WAV Sound File' );
else
    [ fname, pname ] = uigetfile( '_Sounds/*.m4a', 'm4a Sound File' );
end

handles.data.wavFileName = strcat( pname, fname );

handles.data.rWavFileName = handles.data.wavFileName;
handles.data.lWavFileName = handles.data.wavFileName;

handles.data.graphTitle = fname;

handles.data.fname = fname;
handles.data.pname = pname;


chDefs = {};
chDefs{ 1, 1 } = 'Right';
chDefs{ 1, 2 } = strcat( '"', handles.data.wavFileName, '"' );
chDefs{ 2, 1 } = 'Left';
chDefs{ 2, 2 } = strcat( '"', handles.data.wavFileName, '"' );
handles.data.chDefs = chDefs;


[ s, fs ] = audioread( handles.data.wavFileName );
handles.soundSignals.s = s;


handles.data.fs = fs;
handles.data.timeS0 = 0.0;
handles.data.timeE0 = length(s) / fs;
handles.data.timeT  = 0.01;

handles.data.graphTitle = fname;

handles.data.xLabelStr  = 'Tau';
handles.data.yLabelStr  = 'Time';
handles.data.xUnitStr   = 'ms';
handles.data.yUnitStr   = 'sec';
handles.data.xUnitScale = 1000.0;
handles.data.yUnitScale = 1.0;


set( handles.edit_InputSoundFile, 'String', handles.data.graphTitle );
set( handles.edit_StartTime,      'String', handles.data.timeS0 );
set( handles.edit_EndTime,        'String', handles.data.timeE0 );
set( handles.edit_T,              'String', handles.data.timeT );
set( handles.edit_GraphTitle,     'String', handles.data.graphTitle );
set( handles.edit_SamplingFreq,   'String', handles.data.fs );
set( handles.uitable_Filenames_w_Channel, 'Data', handles.data.chDefs );


guidata(hObject, handles);



% --- Executes on button press in pushbutton_Play.
function pushbutton_Play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[ handles.soundSignals.s, handles.soundSignals.x0 ] = readSoundSignals( hObject, eventdata, handles, handles.data.rWavFileName, 2 );

playSoundSignals( hObject, eventdata, handles );

guidata(hObject, handles);



% --- Executes on button press in checkbox_PlotTauE_Vector.
function checkbox_PlotTauE_Vector_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_PlotTauE_Vector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_PlotTauE_Vector

handles.data.calcTauE_VecFlag = get( hObject, 'value' );

guidata(hObject, handles);


% --- Executes on selection change in popupmenu_CalcMode.
function popupmenu_CalcMode_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_CalcMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_CalcMode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_CalcMode

LRCvalue = get( hObject, 'value' );

if ( LRCvalue == 1 )
    handles.data.LRCflag = 'L';
elseif ( LRCvalue == 2 )
    handles.data.LRCflag = 'R';
else
    handles.data.LRCflag = 'C';
end

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu_CalcMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_CalcMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_ApplyWindowFunc.
function checkbox_ApplyWindowFunc_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ApplyWindowFunc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_ApplyWindowFunc

handles.data.applyWindowFuncFlag = get( hObject, 'value' );

guidata(hObject, handles);


% --- Executes on selection change in popupmenu_WindowFunc.
function popupmenu_WindowFunc_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_WindowFunc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_WindowFunc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_WindowFunc

handles.data.windowFuncMode = get( hObject, 'value' );

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu_WindowFunc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_WindowFunc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_PlaySoundOnCalc.
function checkbox_PlaySoundOnCalc_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_PlaySoundOnCalc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_PlaySoundOnCalc

handles.data.playSoundFlag = get( hObject, 'value' );

guidata(hObject, handles);


% --- Executes on button press in checkbox_DumpData.
function checkbox_DumpData_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_DumpData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_DumpData

handles.data.dumpResultFlag = get( hObject, 'value' );

guidata(hObject, handles);


% --- Executes on button press in pushbutton_Calculate.
function pushbutton_Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ( ~handles.data.batchModeFlag )
    handles.data.rWavChLabel = handles.data.chDefs{ 1, 1 };
    handles.data.lWavChLabel = handles.data.chDefs{ 2, 1 };
    
    handles.data.rWavFileName = strrep( handles.data.chDefs{ 1, 2 }, '"', '' );
    handles.data.lWavFileName = strrep( handles.data.chDefs{ 2, 2 }, '"', '' );
end


if ( handles.data.fileSuffixValue == 1 || handles.data.fileSuffixValue == 2 )        
    [ handles.soundSignals.s, handles.soundSignals.x0 ] = readSoundSignals( hObject, eventdata, handles, handles.data.lWavFileName, 2 );
    [ handles.soundSignals.s, handles.soundSignals.y0 ] = readSoundSignals( hObject, eventdata, handles, handles.data.rWavFileName, 1 );
else
%     disp(handles.data.lWavFileName);
%     disp(handles.data.rWavFileName);
    
    [ handles.soundSignals.s, handles.soundSignals.x0 ] = readDataSignals( hObject, eventdata, handles, handles.data.lWavFileName );
    [ handles.soundSignals.s, handles.soundSignals.y0 ] = readDataSignals( hObject, eventdata, handles, handles.data.rWavFileName );
    handles.data.playSoundFlag = 0;

%     disp(handles.soundSignals.x0);
%     disp("");
%     disp(handles.soundSignals.y0);
%     disp("");
end


if ( handles.data.playSoundFlag )
    playSoundSignals( hObject, eventdata, handles );
end


clear handles.results;

handles.results = xcor_Analyzer( handles );
plotSurface_phi_lr_( handles );


if ( handles.data.calcTauE_VecFlag )
    handles.results = calc_tauE_Vec_( handles.data, handles.results );
    plotOVERRIDE_tauE_Vec_( handles.data, handles.results );
end


if ( handles.data.SaveTheGraphPlotsIntoFilesFlag )
    handles.results.tmpLabelStr = strcat( handles.results.zLabelStr, ' [', handles.data.lWavChLabel, ' <-> ', handles.data.rWavChLabel, '] ' );
    pnameImg = strcat( '_Output Images', '/', '(', handles.data.graphTitle, '),', handles.results.tmpLabelStr, ',', handles.results.dateTime, ',', 'timeS0,', num2str(handles.data.timeS0, '%04.2f'), ',', 'timeE0,', num2str(handles.data.timeE0, '%04.2f'), ',', 'tau,', num2str(handles.data.timeT, '%04.3f') );

    if ( exist( pnameImg, 'dir' ) == 0 )
        mkdir( pnameImg );
    end
    
    saveImageName = strcat( '(', handles.data.graphTitle, '),', handles.results.tmpLabelStr, ',timeS0,', num2str(handles.data.timeS0, '%04.2f'), ',', 'timeE0,', num2str(handles.data.timeE0, '%04.2f'), ',', 'tau,', num2str(handles.data.timeT, '%04.3f') );
    
    fname = strcat( saveImageName, '.fig');
    outputDataFileName = strcat( pnameImg, '/', fname );
    saveas( gcf, strcat( outputDataFileName ) );
    
end


if ( handles.data.dumpResultFlag )
    batch_dump_data_( handles );
end


% To save each graphs independently
%pause(5);


guidata(hObject, handles);


% --------------------------------------------------------------------
function [ s, x0 ] = readDataSignals( hObject, eventdata, handles, CsvFileName )
% Core Procedure to read a set of data signals.

s = [];


%disp(CsvFileName);


[ Pathstr, Name, Ext ] = fileparts( CsvFileName );
if ( strcmp( Ext, '.csv' ) || strcmp( Ext, '.CSV' ) )
    fileID = fopen( CsvFileName );
    cells = textscan( fileID, '%s', 'Delimiter', ',', 'TreatAsEmpty', {'NA','na'}, 'CommentStyle', '//' );
    fclose(fileID);
end

x0 = str2double( table2array( cell2table( cells{ 1, 1 } ) ) );

x0 = [ x0; zeros( length(x0), 1 ) ]; % with Zero post-padding

handles.data.timeS0 = 0.0;
handles.data.timeE0 = length(x0);
handles.data.timeT  = 1.0;

guidata(hObject, handles);


% --------------------------------------------------------------------
%function [soundSignals data] = readSoundSignals( handles )
function [ s, x0 ] = readSoundSignals( hObject, eventdata, handles, wavFileName, channel )
% Core Procedure to read sound.

%data = handles.data;

[ s, ~ ] = audioread( wavFileName );
soundSignals.s = s;

x0 = s( :, channel );  % L/R channel

duration = length(x0) / handles.data.fs;

x0 = [ x0; zeros( handles.data.fs, 1 ) ]; % with Zero post-padding

handles.data.timeS0 = max( handles.data.timeS0, 0.0 );
handles.data.timeE0 = min( handles.data.timeE0, duration );

guidata( hObject, handles );


% --------------------------------------------------------------------
function playSoundSignals( hObject, eventdata, handles )
% Core Procedure to play sound for defined interval.

TMPtimeS0_Idx = convTime2Index_( handles.data.timeS0, handles.data.fs );
TMPtimeE0_Idx = convTime2Index_( handles.data.timeE0, handles.data.fs ) - 1;

sCut = handles.soundSignals.s( TMPtimeS0_Idx : TMPtimeE0_Idx, : );

sound( sCut, handles.data.fs );

guidata( hObject, handles );


% --- Executes on button press in pushbutton_Reset.
function pushbutton_Reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

initialize_gui( hObject, handles, true );

guidata(hObject, handles);


function edit_SettingCsvFile_Callback(hObject, eventdata, handles)
% hObject    handle to edit_SettingCsvFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_SettingCsvFile as text
%        str2double(get(hObject,'String')) returns contents of edit_SettingCsvFile as a double


% --- Executes during object creation, after setting all properties.
function edit_SettingCsvFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_SettingCsvFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_RedrawTheGraphPlot.
function pushbutton_RedrawTheGraphPlot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_RedrawTheGraphPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox_SaveTheGraphPlotsIntoFiles.
function checkbox_SaveTheGraphPlotsIntoFiles_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_SaveTheGraphPlotsIntoFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_SaveTheGraphPlotsIntoFiles

handles.data.SaveTheGraphPlotsIntoFilesFlag = get( hObject, 'value' );

guidata(hObject, handles);


% --- Executes on button press in pushbutton_LoadSettingFile.
function pushbutton_LoadSettingFile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_LoadSettingFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.data.numberOfHeaders = 6;

[ fname, pname ] = uigetfile( '_CSVs/*.csv', 'CSV Definition File' );
defCsvFileName = strcat( pname, fname );

handles.data.fname = fname;
handles.data.pname = pname;


handles.data.defCsvFileName = defCsvFileName;


fileID = fopen( defCsvFileName );
[ scanData ] = textscan( fileID, '%s %s', 'delimiter', ',' );
fclose(fileID);


chA = scanData{ 1, 1 };
chB = scanData{ 1, 2 };

handles.data.graphTitle    = castStr_( chA{ 1 } );
handles.data.fs            = castNum_( chB{ 1 } );
handles.data.timeS0        = castNum_( chA{ 2 } );
handles.data.timeE0        = castNum_( chB{ 2 } );
handles.data.timeT         = castNum_( chA{ 3 } );
handles.data.tauUnitScale  = castNum_( chB{ 3 } );

handles.data.xLabelStr     = castStr_( chA{ 4 } );
handles.data.yLabelStr     = castStr_( chB{ 4 } );
handles.data.xUnitStr      = castStr_( chA{ 5 } );
handles.data.yUnitStr      = castStr_( chB{ 5 } );

handles.data.xUnitScale    = castNum_( chA{ 6 } );
handles.data.yUnitScale    = castNum_( chB{ 6 } );

handles.data.tauMinus      = -handles.data.timeT;
handles.data.tauPlus       = +handles.data.timeT;


handles.data.nCsvFileNames = length( chA );


chDefs = {};

for i = handles.data.numberOfHeaders + 1 : length( chA )
    chDefs{ i - handles.data.numberOfHeaders, 1 } = chA{ i };
    chDefs{ i - handles.data.numberOfHeaders, 2 } = chB{ i };
end;

handles.data.chDefs = chDefs;

handles.data.wavFileName = strrep( chB{ 7 }, '"', '' );


set( handles.edit_InputSoundFile, 'String',  handles.data.wavFileName );
set( handles.edit_GraphTitle,     'String',  handles.data.graphTitle );
set( handles.edit_StartTime,      'String',  handles.data.timeS0 );
set( handles.edit_EndTime,        'String',  handles.data.timeE0 );
set( handles.edit_T,              'String',  handles.data.timeT );
set( handles.edit_SamplingFreq,   'String',  handles.data.fs );

set( handles.edit_TauUnitLabel,   'String',  handles.data.xUnitStr );
set( handles.edit_TimeUnitLabel,  'String',  handles.data.yUnitStr );

set( handles.edit_TauUnitScale,   'value',   handles.data.tauUnitScale );

set( handles.edit_SettingCsvFile, 'String',  handles.data.defCsvFileName );

set( handles.uitable_Filenames_w_Channel, 'Data', handles.data.chDefs );


guidata( hObject, handles );


function edit_SoundFilesToRead_Callback(hObject, eventdata, handles)
% hObject    handle to text_SoundFilesToRead (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_SoundFilesToRead as text
%        str2double(get(hObject,'String')) returns contents of text_SoundFilesToRead as a double


% --- Executes during object creation, after setting all properties.
function text_SoundFilesToRead_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_SoundFilesToRead (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_SaveSettingFile.
function pushbutton_SaveSettingFile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SaveSettingFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if ( ~exist('handles.results.dateTime', 'var') )
    [ ~, dateTime ] = system('date +%y%m%d%H%M%S');
    handles.results.dateTime = dateTime( 1 : length( dateTime ) - 1 );
end

fileID = fopen( strcat( handles.data.pname, '../_CSVs/', handles.data.graphTitle, ',', handles.results.dateTime, '.csv' ), 'w+' );

fprintf( fileID, '%s,%s\n', castStr_( handles.data.graphTitle ), castStr_( handles.data.fs ) );
fprintf( fileID, '%s,%s\n', castStr_( handles.data.timeS0 ),     castStr_( handles.data.timeE0 ) );
fprintf( fileID, '%s,%s\n', castStr_( handles.data.timeT ),      castStr_( handles.data.tauUnitScale ) );
fprintf( fileID, '%s,%s\n', castStr_( handles.data.xLabelStr ),  castStr_( handles.data.yLabelStr ) );
fprintf( fileID, '%s,%s\n', castStr_( handles.data.xUnitStr ),   castStr_( handles.data.yUnitStr ) );
fprintf( fileID, '%s,%s\n', castStr_( handles.data.xUnitScale ), castStr_( handles.data.yUnitScale ) );
for m = 1 : size( handles.data.chDefs, 1 )
    fprintf( fileID, '%s,%s\n', char( handles.data.chDefs( m, 1 ) ), char( handles.data.chDefs( m, 2 ) ) );
end


fclose( fileID );


guidata(hObject,handles);


% --- Executes on button press in pushbutton_Exit.
function pushbutton_Exit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.data.exitFlag = 1;


write_history_( handles.data, 'commandHistory_GUI_xcor_Analyzer.mat', 'ERROR: write_history_() : No Command History File.' );


guidata(hObject, handles);

close;


% --- Executes on button press in pushbutton_PlotEachTimeSlices.
function pushbutton_PlotEachTimeSlices_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PlotEachTimeSlices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

for i = 1 : size( handles.results.phi_lrMat, 1 )
    
    plot_graph_everyMoment_( handles, i );
    
    if ( handles.data.SaveTheGraphPlotsIntoFilesFlag )
        
        handles.results.tmpLabelStr = strcat( handles.results.zLabelStr, ' [', handles.data.lWavChLabel, ' <-> ', handles.data.rWavChLabel, '] ' );
        pnameImg = strcat( '_Output Images', '/', '(', handles.data.graphTitle, '),', handles.results.tmpLabelStr, ',', handles.results.dateTime, ',', 'timeS0,', num2str(handles.data.timeS0, '%04.2f'), ',', 'timeE0,', num2str(handles.data.timeE0, '%04.2f'), ',', 'tau,', num2str(handles.data.timeT, '%04.3f') );
        
        if ( exist( pnameImg, 'dir' ) == 0 )
            mkdir( pnameImg );
        end
        
        saveImageName = strcat( '(', handles.data.graphTitle, '),', handles.results.tmpLabelStr, ',', 'timeS0,', num2str(handles.data.timeS0, '%04.2f'), ',', 'timeE0,', num2str(handles.data.timeE0, '%04.2f'), ',', 't,', num2str(handles.results.timeAxis( i ), '%04.3f') );
        
        fname = strcat( saveImageName, '.jpg');
        outputDataFileName = strcat( pnameImg, '/', fname );
        saveas( gcf, strcat( outputDataFileName ) );
    else
        pause( 0.01 );
    end
    
end

guidata(hObject, handles);



function edit_GraphTitle_Callback(hObject, eventdata, handles)
% hObject    handle to edit_GraphTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_GraphTitle as text
%        str2double(get(hObject,'String')) returns contents of edit_GraphTitle as a double

handles.data.graphTitle = castStr_( get( hObject, 'String' ) );

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_GraphTitle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_GraphTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_TauUnitLabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_TauUnitLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_TauUnitLabel as text
%        str2double(get(hObject,'String')) returns contents of edit_TauUnitLabel as a double

handles.data.xUnitStr = get( hObject, 'String' );

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_TauUnitLabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TauUnitLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_ApplyStardardization.
function checkbox_ApplyStardardization_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ApplyStardardization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_ApplyStardardization



function edit_TauUnitScale_Callback(hObject, eventdata, handles)
% hObject    handle to edit_TauUnitScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_TauUnitScale as text
%        str2double(get(hObject,'String')) returns contents of edit_TauUnitScale as a double

handles.data.tauUnitScale = castNum_( get( hObject, 'String' ) );

handles.data.xUnitScale = 1.0 / handles.data.tauUnitScale;

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_TauUnitScale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TauUnitScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_TimeUnitLabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_TimeUnitLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_TimeUnitLabel as text
%        str2double(get(hObject,'String')) returns contents of edit_TimeUnitLabel as a double

handles.data.yUnitStr = get( hObject, 'String' );

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_TimeUnitLabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TimeUnitLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_BatchCalculate.
function pushbutton_BatchCalculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_BatchCalculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.data.batchModeFlag = 1;

for i = 1 : size( handles.data.chDefs, 1 )
    if (handles.data.LRCflag == 'C' )
        for j = i+1 : size( handles.data.chDefs, 1 )
            handles.data.rWavChLabel = handles.data.chDefs{ i, 1 };
            handles.data.lWavChLabel = handles.data.chDefs{ j, 1 };
            
            handles.data.rWavFileName = strrep( handles.data.chDefs{ i, 2 }, '"', '' );
            handles.data.lWavFileName = strrep( handles.data.chDefs{ j, 2 }, '"', '' );
            
            pushbutton_Calculate_Callback(hObject, eventdata, handles);
        end
    else
        handles.data.rWavChLabel = handles.data.chDefs{ i, 1 };
        handles.data.lWavChLabel = handles.data.rWavChLabel;
        
        handles.data.rWavFileName = strrep( handles.data.chDefs{ i, 2 }, '"', '' );
        handles.data.lWavFileName = handles.data.rWavFileName;
        
        pushbutton_Calculate_Callback(hObject, eventdata, handles);
    end
end

handles.data.batchModeFlag = 0;

guidata(hObject, handles);


% --- Executes on button press in pushbutton_AddFile.
function pushbutton_AddFile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_AddFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if ( handles.data.fileSuffixValue == 1 )
    [ fname, pname ] = uigetfile( '_Sounds/*.wav', 'WAV Sound File' );
elseif ( handles.data.fileSuffixValue == 2 )
    [ fname, pname ] = uigetfile( '_Sounds/*.m4a', 'm4a Sound File' );
else
    [ fname, pname ] = uigetfile( '_CSVs/*.csv', 'CSV Data File' );

    handles.data.fs = 1;
    handles.data.timeS0 = 0.0;
    handles.data.timeE0 = 1;
    handles.data.timeT  = 1;
    
    handles.data.graphTitle = fname;
    
    handles.data.xLabelStr  = 'Tau';
    handles.data.yLabelStr  = 'Time';
    handles.data.xUnitStr   = 'ms';
    handles.data.yUnitStr   = 'sec';
    handles.data.xUnitScale = 1.0;
    handles.data.yUnitScale = 1.0;
end

handles.data.wavFileName = strcat( pname, fname );


handles.data.chDefs{ end + 1, 1 } = 'NEW';
handles.data.chDefs{ end,     2 } = strcat( '"', handles.data.wavFileName, '"' );

handles.data.rWavChLabel      = handles.data.chDefs{ 1, 1 };
handles.data.lWavChLabel      = handles.data.chDefs{ 1, 2 };

handles.data.rWavFileName     = handles.data.chDefs{ 1, 1 };
handles.data.lWavFileName     = handles.data.chDefs{ 2, 2 };

set( handles.edit_InputSoundFile, 'String', handles.data.graphTitle );
set( handles.edit_StartTime,      'String', handles.data.timeS0 );
set( handles.edit_EndTime,        'String', handles.data.timeE0 );
set( handles.edit_T,              'String', handles.data.timeT );
set( handles.edit_GraphTitle,     'String', handles.data.graphTitle );
set( handles.edit_SamplingFreq,   'String', handles.data.fs );
set( handles.uitable_Filenames_w_Channel, 'Data', handles.data.chDefs );


guidata( hObject, handles );


% --- Executes on button press in pushbutton_DeleteFile.
function pushbutton_DeleteFile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_DeleteFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


choice = handles.data.currentCellPosition( 1 );


chDefs = {};

for i = 1 : size( handles.data.chDefs, 1 )
    if ( i == choice ), continue; end;
    
    chDefs{ end + 1, 1 } = handles.data.chDefs{ i, 1 };
    chDefs{ end    , 2 } = handles.data.chDefs{ i, 2 };
end

clear handles.data.chDefs;
handles.data.chDefs = chDefs;

set( handles.uitable_Filenames_w_Channel, 'Data', handles.data.chDefs );

guidata( hObject, handles );


% --- Executes when entered data in editable cell(s) in uitable_Filenames_w_Channel.
function uitable_Filenames_w_Channel_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_Filenames_w_Channel (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

handles.data.chDefs = get( hObject, 'Data' );

set( hObject, 'Data', handles.data.chDefs );

guidata( hObject, handles );


% --- Executes during object creation, after setting all properties.
function uitable_Filenames_w_Channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable_Filenames_w_Channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

guidata(hObject, handles);


% --- Executes when selected cell(s) is changed in uitable_Filenames_w_Channel.
function uitable_Filenames_w_Channel_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable_Filenames_w_Channel (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

data = get( hObject, 'Data' );
indices = eventdata.Indices;
r = indices( :, 1 );
c = indices( :, 2 );
linear_index = sub2ind( size(data), r, c );
%selected_vals = data( linear_index );
%disp( [ r c ] );

handles.data.currentCellPosition = [ r, c ];

guidata(hObject, handles);


% --- Executes on selection change in popupmenu_FileSuffix.
function popupmenu_FileSuffix_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_FileSuffix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_FileSuffix contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_FileSuffix

handles.data.fileSuffixValue = get( hObject, 'value' );

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu_FileSuffix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_FileSuffix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
