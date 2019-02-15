function varargout = defineEventLabelsFromC3dSubGui(varargin)

% Last Modified by GUIDE v2.5 14-Jul-2004 16:56:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @defineeventNamesSubGui_OpeningFcn, ...
                   'gui_OutputFcn',  @defineeventNamesSubGui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


function defineEventLabelsFromC3dSubGui_OpeningFcn(hObject, eventdata, handles, varargin)
handles.events = [];
handles.output = handles.events;
handles.numberOfevents = varargin{1};
for i = handles.numberOfevents + 1:20;
    eval(['set(handles.editboxevent' num2str(i) ', ''Visible'', ''off'')']);
    eval(['set(handles.textevent' num2str(i) ', ''Visible'', ''off'')']);
end
guidata(hObject, handles);
uiwait(handles.figure1);


function varargout = defineEventLabelsFromC3dSubGui_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
delete(handles.figure1);


%   ----------------------------------------------------------------------------
%   Get general event names from editboxes
function editboxEvent1_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent1_Callback(hObject, eventdata, handles)
handles.Events(1).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent2_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent2_Callback(hObject, eventdata, handles)
handles.Events(2).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent3_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent3_Callback(hObject, eventdata, handles)
handles.Events(3).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent4_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent4_Callback(hObject, eventdata, handles)
handles.Events(4).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent5_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent5_Callback(hObject, eventdata, handles)
handles.Events(5).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent6_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent6_Callback(hObject, eventdata, handles)
handles.Events(6).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent7_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent7_Callback(hObject, eventdata, handles)
handles.Events(7).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent8_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent8_Callback(hObject, eventdata, handles)
handles.Events(8).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent9_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent9_Callback(hObject, eventdata, handles)
handles.Events(9).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent10_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function editboxEvent10_Callback(hObject, eventdata, handles)
handles.Events(10).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent11_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent11_Callback(hObject, eventdata, handles)
handles.Events(11).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent12_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent12_Callback(hObject, eventdata, handles)
handles.Events(12).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent13_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent13_Callback(hObject, eventdata, handles)
handles.Events(13).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent14_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent14_Callback(hObject, eventdata, handles)
handles.Events(14).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent15_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent15_Callback(hObject, eventdata, handles)
handles.Events(15).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent16_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent16_Callback(hObject, eventdata, handles)
handles.Events(16).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent17_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent17_Callback(hObject, eventdata, handles)
handles.Events(17).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent18_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent18_Callback(hObject, eventdata, handles)
handles.Events(18).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent19_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent19_Callback(hObject, eventdata, handles)
handles.Events(19).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxEvent20_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxEvent20_Callback(hObject, eventdata, handles)
handles.Events(20).Names = get(hObject,'String');
guidata(hObject, handles);
%   ----------------------------------------------------------------------------

%   Continue
function pushbuttonContinue_Callback(hObject, eventdata, handles)
handles.output = handles.Events;
guidata(hObject, handles);
uiresume(handles.figure1);


%   Load general events
function pushbuttonLoadEvents_Callback(hObject, eventdata, handles)

if exist('C:\Program files\Matlab Executables\TempNormGUI\general events files\') == 7
    [fileName pathName] = uigetfile('*.mat', 'Select the file that you wish to use to define your general events',...
    'C:\Program files\Matlab Executables\TempNormGUI\general events files\*.mat');
else
    [fileName pathName] = uigetfile('*.mat', 'Select the file that you wish to use to define your general events',...
    'C:\*.mat');
end

load(fullfile(pathName, fileName));
handles.EventsPath = pathName;
handles.Events = EventOut;

%   Update editboxes to display loaded general event names
for i = 1:handles.numberOfEvents;
    eval(['set(handles.editboxEvent' num2str(i) ', ''String'', handles.Events(' num2str(i) ').Names);'])
end

i = i+1;

%   Fill remaining edit boxes with blanks
while i <= 20;
    eval(['set(handles.editboxEvent' num2str(i) ', ''String'', '' '')']);
    i = i + 1;
end
guidata(hObject, handles);


%   Save general events
function pushbuttonSaveEvents_Callback(hObject, eventdata, handles)
%   Set up default directory to save general events file to
if isfield(handles, 'EventsPath') == 1;
    cd(handles.EventsPath);
elseif exist('C:\Program files\Matlab Executables\TempNormGUI\general events files\') == 7
    cd('C:\Program files\Matlab Executables\TempNormGUI\general events files\')
else
    cd('C:\');
end

[fileName, pathName] = uiputfile('*.mat', 'Select a directory and a name for your file');
EventOut = handles.Events;
cd(pathName);
eval(['save ' fileName ' EventOut'])
guidata(hObject, handles);

%   Help 
function pushbuttonHelp_Callback(hObject, eventdata, handles)
helpMessage = {' The 1st time that you define a certain set of general events you will      '
               ' need to type them into the relevant boxes.                                 '
               ' If you will be using the same general events for multiple trials/subjects  '
               ' it will be efficient to save them for later use. Once you have finished    '
               ' entering the names into the boxes, click on the ''SAVE GENERAL EVENTS''    '
               ' button, browse to your preferred directory (the default will be the        '
               ' directory that contains your c3d data), and specify a filename             '
               ' (e.g. walkingevents_pmills.mat). Now you have saved the general events     '
               ' you can load them next time they are required.                             '
               '                                                                            '
               ' To load a previously saved set of general event names, click on the        '
               ' ''LOAD GENERAL EVENTS'' button, browse to the directory where the          '
               ' general events file is stored (e.g. walkingevents_pmills.mat), and click   '
               ' on the relevant file. The textboxes will be updated with the previously    ' 
               ' defined general event names. These can be changed if required but changes  '
               ' will not be saved unless you click on the ''SAVE GENERAL EVENTS''  and     '
               ' repeat the process described in the previous paragraph.                    '
               '                                                                            '
               ' * Remember to note the name of any saved general events files saved for    '
               ' future use!                                                                '};

helpdlg(helpMessage);