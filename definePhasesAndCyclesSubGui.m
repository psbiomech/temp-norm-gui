function varargout = definePhasesAndCyclesSubGui(varargin)

% Last Modified by GUIDE v2.5 15-Jul-2004 10:56:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @definePhasesAndCyclesSubGui_OpeningFcn, ...
                   'gui_OutputFcn',  @definePhasesAndCyclesSubGui_OutputFcn, ...
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


function definePhasesAndCyclesSubGui_OpeningFcn(hObject, eventdata, handles, varargin)
handles.phasesAndCycles = [];
handles.output = handles.phasesAndCycles;
handles.numberOfPhasesAndCycles = varargin{1};
handles.generalEvents = varargin{2};
generalEventNames = char(handles.generalEvents.Names);

for i = 1:20;
    eval(['set(handles.popupmenuStartPhase' num2str(i) ', ''String'', [cellstr(''Starting event: ''); cellstr(generalEventNames)]);'])
    eval(['set(handles.popupmenuEndPhase' num2str(i) ', ''String'', [cellstr(''Ending event: ''); cellstr(generalEventNames)]);'])
end

for i = handles.numberOfPhasesAndCycles + 1:20;
    eval(['set(handles.editboxPhase' num2str(i) ', ''Visible'', ''off'');']);
    eval(['set(handles.popupmenuStartPhase' num2str(i) ', ''Visible'', ''off'');']);
    eval(['set(handles.popupmenuEndPhase' num2str(i) ', ''Visible'', ''off'');']);
end
guidata(hObject, handles);
uiwait(handles.figure1);

function varargout = definePhasesAndCyclesSubGui_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
delete(handles.figure1);

function pushbuttonContinue_Callback(hObject, eventdata, handles)
handles.output = handles.phasesAndCycles;
guidata(hObject, handles);
uiresume(handles.figure1);


%   Load phases and cycles
function pushbuttonLoadPhasesAndCycles_Callback(hObject, eventdata, handles)
if exist('C:\Program files\Matlab Executables\TempNormGUI\phases and cycles files\') == 7
    [fileName pathName] = uigetfile('*.mat', 'Select the file that you wish to use to define your general events',...
    'C:\Program files\Matlab Executables\TempNormGUI\phases and cycles files\*.mat');
else
    [fileName pathName] = uigetfile('*.mat', 'Select the file that you wish to use to define your general events',...
    'C:\*.mat');
end

load(fullfile(pathName, fileName));
handles.phasesAndCycles = phasesAndCyclesOut;
handles.phasesAndCyclesPath = pathName;

%   Update editboxes and popup menus to display loaded phases and cycle
%   information
for i = 1:handles.numberOfPhasesAndCycles;
    eval(['set(handles.editboxPhase' num2str(i) ', ''String'', handles.phasesAndCycles(' num2str(i) ').Names);'])
    eval(['set(handles.popupmenuStartPhase' num2str(i) ', ''String'', handles.phasesAndCycles(' num2str(i) ').Start);'])
    eval(['set(handles.popupmenuEndPhase' num2str(i) ', ''String'', handles.phasesAndCycles(' num2str(i) ').End);'])
end
i = i + 1; % go to the following popup menus and editboxes
%   Fill remaining editboxes and popup menus with blanks
while i <= 20;
    eval(['set(handles.editboxPhase' num2str(i) ', ''String'', '' '');'])
    eval(['set(handles.popupmenuStartPhase' num2str(i) ', ''String'', '' '');'])
    eval(['set(handles.popupmenuEndPhase' num2str(i) ', ''String'', '' '');'])
    i = i + 1;
end
guidata(hObject, handles);


%   Save phases and cycles
function pushbuttonSavePhasesAndCycles_Callback(hObject, eventdata, handles)
if isfield(handles, 'phasesAndCyclesPath') == 1;
    cd(handles.phasesAndCyclesPath);
elseif exist('C:\Program files\Matlab Executables\TempNormGUI\phases and cycles files\') == 7
    cd('C:\Program files\Matlab Executables\TempNormGUI\phases and cycles files\');
else
    cd('C:\');
end
    
[fileName, pathName] = uiputfile('*.mat', 'Select a directory and a name for your file:');
phasesAndCyclesOut = handles.phasesAndCycles;
cd(pathName);
eval(['save ' fileName ' phasesAndCyclesOut'])
guidata(hObject, handles);

%function pushbuttonContinue_Callback(hObject, eventdata, handles)
%handles.output = handles.phasesAndCycles;
%guidata(hObject, handles);
%uiresume(handles.figure1);


%   Help
function pushbuttonHelp_Callback(hObject, eventdata, handles)
helpMessage = {' The 1st time that you define a certain set of phases and/or cycles you     '
               ' will need to type them into the relevant boxes.                            '
               ' Firstly type a name for the phase or cycle, then select the start event    '
               ' and ending event from the drop down menu (these are the events that you    '
               ' defined in the previous step).                                             ' 
               '                                                                            '
               ' If you will be using the same phases/cycles for multiple trials/subjects   '
               ' it will be efficient to save them for later use. Once you have finished    '
               ' entering the names into the boxes, click on the ''SAVE PHASES/CYCLES ''    '
               ' button, browse to your preferred directory (the default will be the        '
               ' directory that contains your c3d data), and specify a filename             '
               ' (e.g. walkingphasesandcycles_pmills.mat). Now you have saved the phases    '
               ' and cycles you can load them next time they are required.                  '
               '                                                                            '
               ' To load a previously saved set of phases and/or cycles, click on the       '
               ' ''LOAD PHASES/CYCLES'' button, browse to the directory where the phases    '
               ' and/or cycles file is stored (e.g. walkingphasesandcycles_pmills.mat),     '
               ' and click on the relevant file. The textboxes and popup menus will be      ' 
               ' updated with the previously defined phase and cycles information. These    '
               ' can be changed if required but changes will not will not be saved unless   '
               ' you click on the ''SAVE GENERAL EVENTS'' and repeat the process described  '
               ' in the previous paragraph.                                                 '
               '                                                                            '
               ' * Remember to note the name of any phase/cycle files saved for future use! '
               '                                                                            '};

helpdlg(helpMessage)
%-------------------------------------------------------------------------------

%   Phase 1
function editboxPhase1_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(1).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase1_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase1_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(1).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(1).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase1_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase1_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(1).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(1).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 2
function editboxPhase2_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(2).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase2_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase2_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(2).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(2).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase2_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase2_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(2).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(2).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 3
function editboxPhase3_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(3).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase3_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase3_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(3).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(3).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase3_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase3_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(3).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(3).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 4
function editboxPhase4_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(4).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase4_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase4_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(4).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(4).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase4_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase4_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(4).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(4).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 5
function editboxPhase5_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(5).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase5_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase5_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(5).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(5).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase5_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase5_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(5).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(5).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 6
function editboxPhase6_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(6).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase6_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase6_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(6).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(6).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase6_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase6_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(6).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(6).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 7
function editboxPhase7_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(7).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase7_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase7_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(7).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(7).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase7_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase7_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(7).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(7).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 8
function editboxPhase8_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(8).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase8_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase8_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(8).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(8).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase8_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase8_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(8).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(8).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 9
function editboxPhase9_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(9).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase9_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase9_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(9).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(9).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase9_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase9_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(9).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(9).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 10
function editboxPhase10_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(10).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase10_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase10_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(10).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(10).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase10_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase10_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(10).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(10).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 11
function editboxPhase11_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(11).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase11_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase11_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(11).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(11).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase11_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase11_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(11).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(11).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 12
function editboxPhase12_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(12).Names = get(hObject,'String');
guidata(hObject, handles);


function popupmenuStartPhase12_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase12_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(12).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(12).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase12_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase12_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(12).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(12).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 13
function editboxPhase13_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(13).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase13_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase13_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(13).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(13).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase13_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase13_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(13).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(13).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 14
function editboxPhase14_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(14).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase14_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase14_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(14).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(14).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


function popupmenuEndPhase14_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase14_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(14).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(14).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 15
function editboxPhase15_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(15).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase15_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase15_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(15).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(15).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase15_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase15_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(15).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(15).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 16
function editboxPhase16_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(16).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase16_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase16_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(16).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(16).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase16_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase16_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(16).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(16).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 17
function editboxPhase17_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(17).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase17_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase17_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(17).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(17).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase17_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase17_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(17).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(17).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 18
function editboxPhase18_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(18).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase18_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase18_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(18).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(18).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase18_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase18_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(18).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(18).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 19
function editboxPhase19_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(19).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase19_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase19_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(19).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(19).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase19_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase19_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(19).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(19).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);


%   Phase 20
function editboxPhase20_Callback(hObject, eventdata, handles)
handles.phasesAndCycles(20).Names = get(hObject,'String');
guidata(hObject, handles);

function popupmenuStartPhase20_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuStartPhase20_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(20).Start = contents{get(hObject, 'Value')};
handles.phasesAndCycles(20).startEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);

function popupmenuEndPhase20_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenuEndPhase20_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.phasesAndCycles(20).End = contents{get(hObject, 'Value')};
handles.phasesAndCycles(20).endEventIndex = get(hObject, 'Value') - 1;
guidata(hObject, handles);
%-------------------------------------------------------------------------------