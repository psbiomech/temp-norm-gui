function varargout = defineBPCutOffSubGui(varargin)
% DEFINEBPCUTOFFSUBGUI M-file for defineBPCutOffSubGui.fig
%      DEFINEBPCUTOFFSUBGUI, by itself, creates a new DEFINEBPCUTOFFSUBGUI or raises the existing
%      singleton*.
%
%      H = DEFINEBPCUTOFFSUBGUI returns the handle to a new DEFINEBPCUTOFFSUBGUI or the handle to
%      the existing singleton*.
%
%      DEFINEBPCUTOFFSUBGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEFINEBPCUTOFFSUBGUI.M with the given input arguments.
%
%      DEFINEBPCUTOFFSUBGUI('Property','Value',...) creates a new DEFINEBPCUTOFFSUBGUI or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before defineBPCutOffSubGui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to defineBPCutOffSubGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help defineBPCutOffSubGui

% Last Modified by GUIDE v2.5 16-Sep-2009 12:34:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @defineBPCutOffSubGui_OpeningFcn, ...
                   'gui_OutputFcn',  @defineBPCutOffSubGui_OutputFcn, ...
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

% --- Executes just before defineBPCutOffSubGui is made visible.
function defineBPCutOffSubGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to defineBPCutOffSubGui (see VARARGIN)

% Choose default command line output for defineBPCutOffSubGui
handles.bpFilter = [];
handles.output = handles.bpFilter;

% Update handles structure
guidata(hObject, handles);

uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = defineBPCutOffSubGui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
delete(handles.figure1);


% --- Executes during object creation, after setting all properties.
function Bottom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Bottom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Bottom_Callback(hObject, eventdata, handles)
% hObject    handle to Bottom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Bottom as text
%        str2double(get(hObject,'String')) returns contents of Bottom as a double
handles.bpFilter(1) = str2double(get(hObject, 'String'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Top_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Top (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Top_Callback(hObject, eventdata, handles)
% hObject    handle to Top (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Top as text
%        str2double(get(hObject,'String')) returns contents of Top as a double
handles.bpFilter(2)= str2double(get(hObject, 'String'));
guidata(hObject,handles)

% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output = handles.bpFilter;
guidata(hObject, handles);
uiresume(handles.figure1);







