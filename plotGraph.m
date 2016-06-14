function varargout = plotGraph(varargin)
% PLOTGRAPH MATLAB code for plotGraph.fig
%      PLOTGRAPH, by itself, creates a new PLOTGRAPH or raises the existing
%      singleton*.
%
%      H = PLOTGRAPH returns the handle to a new PLOTGRAPH or the handle to
%      the existing singleton*.
%
%      PLOTGRAPH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTGRAPH.M with the given input arguments.
%
%      PLOTGRAPH('Property','Value',...) creates a new PLOTGRAPH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plotGraph_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plotGraph_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plotGraph

% Last Modified by GUIDE v2.5 07-Jun-2016 17:30:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plotGraph_OpeningFcn, ...
                   'gui_OutputFcn',  @plotGraph_OutputFcn, ...
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


% --- Executes just before plotGraph is made visible.
function plotGraph_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plotGraph (see VARARGIN)

% Choose default command line output for plotGraph
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


handles = struct( 'data', [] );


if isfield(handles, 'data'),
    return;
end;


handles.data.editParamX = '';
handles.data.editXlabel = 'X Label';
handles.data.editXmin   = 0.0;
handles.data.editXmax   = 100.0;

handles.data.editParamY = '';
handles.data.editYlabel = 'Y Label';
handles.data.editYmin   = 0.0;
handles.data.editYmax   = 100.0;

handles.data.editTitle  = 'Title';


set( handles.editParamX,      'String', handles.data.editParamX );
set( handles.editXlabel,      'String', handles.data.editXlabel );
set( handles.editXmin,        'String', handles.data.editXmin );
set( handles.editXmax,        'String', handles.data.editXmax );

set( handles.editParamY,      'String', handles.data.editParamY );
set( handles.editYlabel,      'String', handles.data.editYlabel );
set( handles.editYmin,        'String', handles.data.editYmin );
set( handles.editYmax,        'String', handles.data.editYmax );

set( handles.editTitle,        'String', handles.data.editTitle );

guidata( hObject, handles );


% UIWAIT makes plotGraph wait for user response (see UIRESUME)
%uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plotGraph_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editParamX_Callback(hObject, eventdata, handles)
% hObject    handle to editParamX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editParamX as text
%        str2double(get(hObject,'String')) returns contents of editParamX as a double

handles.data.editParamX = get( hObject, 'String' );

handles.data.editXmin = evalin( 'base', strcat( 'min( ', handles.data.editParamX, ')' ) );
handles.data.editXmax = evalin( 'base', strcat( 'max( ', handles.data.editParamX, ')' ) );

set( handles.editXmin, 'String',  handles.data.editXmin );
set( handles.editXmax, 'String',  handles.data.editXmax );

handles.data.editXlabel = handles.data.editParamX;
set( handles.editXlabel, 'String',  handles.data.editXlabel );

guidata( hObject, handles );


% --- Executes during object creation, after setting all properties.
function editParamX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editParamX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editXmin_Callback(hObject, eventdata, handles)
% hObject    handle to editXmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editXmin as text
%        str2double(get(hObject,'String')) returns contents of editXmin as a double

handles.data.editXmin = castNum_( get( hObject, 'String' ) );
guidata( hObject, handles );


% --- Executes during object creation, after setting all properties.
function editXmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editXmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editXmax_Callback(hObject, eventdata, handles)
% hObject    handle to editXmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editXmax as text
%        str2double(get(hObject,'String')) returns contents of editXmax as a double

handles.data.editXmax = castNum_( get( hObject, 'String' ) );
guidata( hObject, handles );


% --- Executes during object creation, after setting all properties.
function editXmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editXmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editParamY_Callback(hObject, eventdata, handles)
% hObject    handle to editParamY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editParamY as text
%        str2double(get(hObject,'String')) returns contents of editParamY as a double

handles.data.editParamY = get( hObject, 'String' );

handles.data.editYmin = evalin( 'base', strcat( 'min( ', handles.data.editParamY, ')' ) );
handles.data.editYmax = evalin( 'base', strcat( 'max( ', handles.data.editParamY, ')' ) );

set( handles.editYmin, 'String',  handles.data.editYmin );
set( handles.editYmax, 'String',  handles.data.editYmax );

handles.data.editYlabel = handles.data.editParamY;
set( handles.editYlabel, 'String',  handles.data.editYlabel );

guidata( hObject, handles );


% --- Executes during object creation, after setting all properties.
function editParamY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editParamY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editYmin_Callback(hObject, eventdata, handles)
% hObject    handle to editYmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editYmin as text
%        str2double(get(hObject,'String')) returns contents of editYmin as a double

handles.data.editYmin = castNum_( get( hObject, 'String' ) );
guidata( hObject, handles );


% --- Executes during object creation, after setting all properties.
function editYmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editYmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editYmax_Callback(hObject, eventdata, handles)
% hObject    handle to editYmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editYmax as text
%        str2double(get(hObject,'String')) returns contents of editYmax as a double

handles.data.editYmax = castNum_( get( hObject, 'String' ) );
guidata( hObject, handles );


% --- Executes during object creation, after setting all properties.
function editYmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editYmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editXlabel_Callback(hObject, eventdata, handles)
% hObject    handle to editXlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editXlabel as text
%        str2double(get(hObject,'String')) returns contents of editXlabel as a double

handles.data.editXlabel = get( hObject, 'String' );
guidata( hObject, handles );


% --- Executes during object creation, after setting all properties.
function editXlabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editXlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editYlabel_Callback(hObject, eventdata, handles)
% hObject    handle to editYlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editYlabel as text
%        str2double(get(hObject,'String')) returns contents of editYlabel as a double

handles.data.editYlabel = get( hObject, 'String' );
guidata( hObject, handles );


% --- Executes during object creation, after setting all properties.
function editYlabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editYlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editTitle_Callback(hObject, eventdata, handles)
% hObject    handle to editTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTitle as text
%        str2double(get(hObject,'String')) returns contents of editTitle as a double

handles.data.editTitle = get( hObject, 'String' );
set( handles.editTitle, 'String',  handles.data.editTitle );

guidata( hObject, handles );


% --- Executes during object creation, after setting all properties.
function editTitle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonPlotGraph.
function pushbuttonPlotGraph_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPlotGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.data.statement01 = strcat( 'plot(', handles.data.editParamX, ', ', handles.data.editParamY, ')' );
disp( handles.data );

figure( );
evalin( 'base', handles.data.statement01 );

grid on;

xlabel( handles.data.editXlabel );
ylabel( handles.data.editYlabel );

axis( [ handles.data.editXmin handles.data.editXmax ...
        handles.data.editYmin handles.data.editYmax ] );


title( handles.data.editTitle );
