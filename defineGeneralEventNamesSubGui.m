function varargout = defineGeneralEventNamesSubGui(varargin)

% Last Modified by GUIDE v2.5 14-Jul-2004 16:56:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @defineGeneralEventNamesSubGui_OpeningFcn, ...
                   'gui_OutputFcn',  @defineGeneralEventNamesSubGui_OutputFcn, ...
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


function defineGeneralEventNamesSubGui_OpeningFcn(hObject, eventdata, handles, varargin)
handles.generalEvents = [];
handles.output = handles.generalEvents;
handles.numberOfGeneralEvents = varargin{1};
for i = handles.numberOfGeneralEvents + 1:20;
    eval(['set(handles.editboxGeneralEvent' num2str(i) ', ''Visible'', ''off'')']);
    eval(['set(handles.textGeneralEvent' num2str(i) ', ''Visible'', ''off'')']);
end
guidata(hObject, handles);
uiwait(handles.figure1);


function varargout = defineGeneralEventNamesSubGui_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
delete(handles.figure1);


%   ----------------------------------------------------------------------------
%   Get general event names from editboxes
function editboxGeneralEvent1_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent1_Callback(hObject, eventdata, handles)
handles.generalEvents(1).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent2_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent2_Callback(hObject, eventdata, handles)
handles.generalEvents(2).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent3_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent3_Callback(hObject, eventdata, handles)
handles.generalEvents(3).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent4_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent4_Callback(hObject, eventdata, handles)
handles.generalEvents(4).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent5_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent5_Callback(hObject, eventdata, handles)
handles.generalEvents(5).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent6_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent6_Callback(hObject, eventdata, handles)
handles.generalEvents(6).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent7_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent7_Callback(hObject, eventdata, handles)
handles.generalEvents(7).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent8_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent8_Callback(hObject, eventdata, handles)
handles.generalEvents(8).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent9_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent9_Callback(hObject, eventdata, handles)
handles.generalEvents(9).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent10_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function editboxGeneralEvent10_Callback(hObject, eventdata, handles)
handles.generalEvents(10).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent11_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent11_Callback(hObject, eventdata, handles)
handles.generalEvents(11).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent12_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent12_Callback(hObject, eventdata, handles)
handles.generalEvents(12).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent13_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent13_Callback(hObject, eventdata, handles)
handles.generalEvents(13).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent14_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent14_Callback(hObject, eventdata, handles)
handles.generalEvents(14).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent15_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent15_Callback(hObject, eventdata, handles)
handles.generalEvents(15).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent16_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent16_Callback(hObject, eventdata, handles)
handles.generalEvents(16).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent17_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent17_Callback(hObject, eventdata, handles)
handles.generalEvents(17).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent18_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent18_Callback(hObject, eventdata, handles)
handles.generalEvents(18).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent19_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent19_Callback(hObject, eventdata, handles)
handles.generalEvents(19).Names = get(hObject,'String');
guidata(hObject, handles);


function editboxGeneralEvent20_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function editboxGeneralEvent20_Callback(hObject, eventdata, handles)
handles.generalEvents(20).Names = get(hObject,'String');
guidata(hObject, handles);
%   ----------------------------------------------------------------------------

%   Continue
function pushbuttonContinue_Callback(hObject, eventdata, handles)
handles.output = handles.generalEvents;
guidata(hObject, handles);
uiresume(handles.figure1);


%   Load general events
function pushbuttonLoadGeneralEvents_Callback(hObject, eventdata, handles)

if exist('C:\Program files\Matlab Executables\TempNormGUI\general events files\') == 7
    [fileName pathName] = uigetfile('*.mat', 'Select the file that you wish to use to define your general events',...
    'C:\Program files\Matlab Executables\TempNormGUI\general events files\*.mat');
else
    [fileName pathName] = uigetfile('*.mat', 'Select the file that you wish to use to define your general events',...
    'C:\*.mat');
end

load(fullfile(pathName, fileName));
handles.generalEventsPath = pathName;
handles.generalEvents = generalEventOut;

%   Update editboxes to display loaded general event names
for i = 1:handles.numberOfGeneralEvents;
    eval(['set(handles.editboxGeneralEvent' num2str(i) ', ''String'', handles.generalEvents(' num2str(i) ').Names);'])
end

i = i+1;

%   Fill remaining edit boxes with blanks
while i <= 20;
    eval(['set(handles.editboxGeneralEvent' num2str(i) ', ''String'', '' '')']);
    i = i + 1;
end
guidata(hObject, handles);


%   Save general events
function pushbuttonSaveGeneralEvents_Callback(hObject, eventdata, handles)
%   Set up default directory to save general events file to
if isfield(handles, 'generalEventsPath') == 1;
    cd(handles.generalEventsPath);
elseif exist('C:\Program files\Matlab Executables\TempNormGUI\general events files\') == 7
    cd('C:\Program files\Matlab Executables\TempNormGUI\general events files\')
else
    cd('C:\');
end

[fileName, pathName] = uiputfile('*.mat', 'Select a directory and a name for your file');
generalEventOut = handles.generalEvents;
cd(pathName);
eval(['save ' fileName ' generalEventOut'])
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