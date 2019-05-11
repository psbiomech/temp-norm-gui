function varargout = TempNormGUI_081210(varargin)

% Modified by GUIDE v2.5 08-Dec-2010 11:16:01

% Last modified by Prasanna Sritharan, 10 May 2019


%% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @TempNormGUI_081210_OpeningFcn, ...
    'gui_OutputFcn',  @TempNormGUI_081210_OutputFcn, ...
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
%

%%   Opening function
function TempNormGUI_081210_OpeningFcn(hObject, eventdata, handles, varargin)
% --- Executes during object creation, after setting all properties.
close all

%   Set defaults for required fields
handles.generateOrUpdateSummarySpreadsheet = 0;
handles.getEventLabelsFromC3d = 0;
handles.numberOfEvents = [];
handles.processAnalog = 0;
handles.process3d = 0;
handles.toRectifyAnalog = 0;
handles.filterAnalog = 0;
handles.calcMaxMag3d = 0;
handles.calcMaxTime3d = 0;
handles.calcAbsMaxMag3d = 0;
handles.calcAbsMaxTime3d = 0;
handles.calcMinMag3d = 0;
handles.calcMinTime3d = 0;
handles.calcRange3d = 0;
handles.calcStd3d = 0;
handles.calcMedian3d = 0;
handles.calcMean3d = 0;
handles.calcDuration3d = 0;
handles.calcMaxMagAnalog = 0;
handles.calcMaxTimeAnalog = 0;
handles.calcAbsMaxMagAnalog = 0;
handles.calcAbsMaxTimeAnalog = 0;
handles.calcMinMagAnalog = 0;
handles.calcMinTimeAnalog = 0;
handles.calcRangeAnalog = 0;
handles.calcStdAnalog = 0;
handles.calcMedianAnalog = 0;
handles.calcMeanAnalog = 0;
handles.calcDurationAnalog = 0;
handles.outputNonTempNormData = 1;
handles.outputTempNormData = 1;
handles.toPlotJointAngles = 0;
handles.toPlotJointMoments = 0;
handles.performCustomProcessing = 2;
handles.numberOfC3dVariablesToBeOutput = 0;

%%   Set defaults for ui controls
set(handles.radioFilterAnalog, 'Value', 0);
set(handles.radioRectifyAnalog, 'Value', 0);
set(handles.radio3dMinMag, 'Value', 0);
set(handles.radio3dMaxMag, 'Value', 0);
set(handles.radio3dAbsMaxMag, 'Value', 0);
set(handles.radio3dMinTime, 'Value', 0);
set(handles.radio3dMaxTime, 'Value', 0);
set(handles.radio3dAbsMaxTime, 'Value', 0);
set(handles.radio3dMean, 'Value', 0);
set(handles.radio3dMedian, 'Value', 0);
set(handles.radio3dStd, 'Value', 0);
set(handles.radio3dDur, 'Value', 0);
set(handles.radio3dRange, 'Value', 0);
set(handles.radio3dMinMag, 'Value', 0);
set(handles.radio3dMaxMag, 'Value', 0);
set(handles.radio3dAbsMaxMag, 'Value', 0);
set(handles.radio3dMinTime, 'Value', 0);
set(handles.radio3dMaxTime, 'Value', 0);
set(handles.radio3dAbsMaxTime, 'Value', 0);
set(handles.radio3dMean, 'Value', 0);
set(handles.radio3dMedian, 'Value', 0);
set(handles.radio3dStd, 'Value', 0);
set(handles.radio3dDur, 'Value', 0);
set(handles.radio3dRange, 'Value', 0);
set(handles.radioOutputTempNormData, 'Value', 1);
set(handles.radioOutputNonTempNormData, 'Value', 1);
set(handles.radioPlotJointAngles, 'Value', 0);
set(handles.radioPlotJointMoms, 'Value', 0);


%%   Hide filtering related ui controls and textMedian3d if not required
set(handles.textFilterAnalog, 'Visible', 'off');
set(handles.textRectifyAnalog, 'Visible', 'off');
set(handles.textRectifyStartIndex, 'Visible', 'off');
set(handles.textRectifyEndIndex, 'Visible', 'off');
set(handles.textCutOffFreq, 'Visible', 'off');
set(handles.radioFilterAnalog, 'Visible', 'off');
set(handles.radioRectifyAnalog, 'Visible', 'off');
set(handles.popupFilterOrder, 'Visible', 'off');
set(handles.popupFilterType, 'Visible', 'off');
set(handles.popupFilterModel, 'Visible', 'off');
set(handles.editLowPassCutOff, 'Visible', 'off');
set(handles.editHighPassCutOff, 'Visible', 'off');
set(handles.editRectifyStartIndex, 'Visible', 'off');
set(handles.editRectifyEndIndex, 'Visible', 'off');

guidata(hObject, handles);

%%   Output function (yet to be defined)
function varargout = TempNormGUI_081210_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.numberOfEvents;


%%   Define files to be processed
%function pushbuttonSelectFiles_ButtonDownFcn(hObject, eventdata, handles)
function pushbuttonSelectFiles_Callback(hObject, eventdata, handles)
%[fileNames, filePath] = uigetfile('*.c3d', 'Select files for processing', 'C:\', 'MultiSelect', 'on');
[fileNames, filePath] = uigetfile('*.c3d', 'Select files for processing', pwd, 'MultiSelect', 'on');  % Prasanna Sritharan, May 2019
handles.fileNames = fileNames;
handles.filePath = filePath;
handles.numberOfFiles = size(char(fileNames), 1);
guidata(hObject, handles);


%%   Select activity and define relevant markerset
function popupDataType_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupDataType_Callback(hObject, eventdata, handles)
activityStrings = cellstr(get(hObject,'String'));
activityValue = get(hObject,'Value');
handles.activity = char(activityStrings(activityValue, :));
switch handles.activity
    case '3D & Analog';
        handles.trialType = 'standard';%   specify markerlist
        handles.markerSet = 'uwa';
        handles.processAnalog = 1;
        handles.process3d = 1;
    case '3D only'
        handles.trialType = 'threeD';%   specify markerlist
        handles.markerSet = 'uwa';
        handles.processAnalog = 0;
        handles.process3d = 1;
    case 'Analog only';
        handles.trialType = 'analog';%   specify markerlist
        handles.markerSet = 'uwa';
        handles.processAnalog = 1;
        handles.process3d = 0;
    otherwise
        msgbox('You must select a data option to continue!', 'Warning', 'warn')
end

%   Hide analog related ui controls if not required
if handles.processAnalog == 0;
    handles.filterAnalog = 0;
    handles.toRectifyAnalog = 0;
    set(handles.textRectifyAnalog, 'Visible', 'off');
    set(handles.radioRectifyAnalog, 'Visible', 'off');
    set(handles.editRectifyStartIndex, 'Visible', 'off');
    set(handles.editRectifyEndIndex, 'Visible', 'off');
    set(handles.textRectifyStartIndex, 'Visible', 'off');
    set(handles.textRectifyEndIndex, 'Visible', 'off');
    set(handles.textFilterAnalog, 'Visible', 'off');
    set(handles.radioFilterAnalog, 'Visible', 'off');
    %set(handles.textFilterCharacteristics, 'Visible', 'off');
    set(handles.popupFilterOrder, 'Visible', 'off');
    set(handles.popupFilterType, 'Visible', 'off');
    set(handles.popupFilterModel, 'Visible', 'off');
    set(handles.textCutOffFreq, 'Visible', 'off');
    set(handles.editLowPassCutOff, 'Visible', 'off');
    set(handles.editHighPassCutOff, 'Visible', 'off');
    set(handles.textDiscreteAnalog, 'Visible', 'off');
    set(handles.textDiscreteAnalogMag, 'Visible', 'off');
    set(handles.textDiscreteAnalogTime, 'Visible', 'off');
    set(handles.textAnalogMin, 'Visible', 'off');
    set(handles.textAnalogMax, 'Visible', 'off');
    set(handles.textAnalogAbsMax, 'Visible', 'off');
    set(handles.textAnalogMean, 'Visible', 'off');
    set(handles.textAnalogMedian, 'Visible', 'off');
    set(handles.textAnalogRange, 'Visible', 'off');
    set(handles.textAnalogStd, 'Visible', 'off');
    set(handles.textAnalogDur, 'Visible', 'off');
    set(handles.radioAnalogMinMag, 'Visible', 'off');
    set(handles.radioAnalogMaxMag, 'Visible', 'off');
    set(handles.radioAnalogMinTime, 'Visible', 'off');
    set(handles.radioAnalogMaxTime, 'Visible', 'off');
    set(handles.radioAnalogAbsMaxMag, 'Visible', 'off');
    set(handles.radioAnalogAbsMaxTime, 'Visible', 'off');
    set(handles.radioAnalogMean, 'Visible', 'off');
    set(handles.radioAnalogMedian, 'Visible', 'off');
    set(handles.radioAnalogStd, 'Visible', 'off');
    set(handles.radioAnalogDur, 'Visible', 'off');
    set(handles.radioAnalogRange, 'Visible', 'off');
else
    set(handles.textRectifyAnalog, 'Visible', 'on');
    set(handles.radioRectifyAnalog, 'Visible', 'on');
    set(handles.textFilterAnalog, 'Visible', 'on');
    set(handles.radioFilterAnalog, 'Visible', 'on');
    set(handles.textDiscreteAnalog, 'Visible', 'on');
    set(handles.textDiscreteAnalogMag, 'Visible', 'on');
    set(handles.textDiscreteAnalogTime, 'Visible', 'on');
    set(handles.textAnalogMin, 'Visible', 'on');
    set(handles.textAnalogMax, 'Visible', 'on');
    set(handles.textAnalogAbsMax, 'Visible', 'on');
    set(handles.textAnalogMean, 'Visible', 'on');
    set(handles.textAnalogMedian, 'Visible', 'on');
    set(handles.textAnalogRange, 'Visible', 'on');
    set(handles.textAnalogStd, 'Visible', 'on');
    set(handles.textAnalogDur, 'Visible', 'on');
    set(handles.radioAnalogMinMag, 'Visible', 'on');
    set(handles.radioAnalogMaxMag, 'Visible', 'on');
    set(handles.radioAnalogMinTime, 'Visible', 'on');
    set(handles.radioAnalogMaxTime, 'Visible', 'on');
    set(handles.radioAnalogAbsMaxMag, 'Visible', 'on');
    set(handles.radioAnalogAbsMaxTime, 'Visible', 'on');
    set(handles.radioAnalogMean, 'Visible', 'on');
    set(handles.radioAnalogMedian, 'Visible', 'on');
    set(handles.radioAnalogStd, 'Visible', 'on');
    set(handles.radioAnalogDur, 'Visible', 'on');
    set(handles.radioAnalogRange, 'Visible', 'on');
end

%   Hide 3d related ui controls if not required
if handles.process3d == 0;
    %set(handles.textDiscrete3d, 'Visible', 'off');
    set(handles.textDiscrete3dMag, 'Visible', 'off');
    set(handles.textDiscrete3dTime, 'Visible', 'off');
    set(handles.text3dMin, 'Visible', 'off');
    set(handles.text3dMax, 'Visible', 'off');
    set(handles.text3dAbsMax, 'Visible', 'off');
    set(handles.text3dMean, 'Visible', 'off');
    set(handles.text3dMedian, 'Visible', 'off');
    set(handles.text3dRange, 'Visible', 'off');
    set(handles.text3dStd, 'Visible', 'off');
    set(handles.text3dDur, 'Visible', 'off');
    set(handles.radio3dMinMag, 'Visible', 'off');
    set(handles.radio3dMaxMag, 'Visible', 'off');
    set(handles.radio3dMinTime, 'Visible', 'off');
    set(handles.radio3dMaxTime, 'Visible', 'off');
    set(handles.radio3dAbsMaxMag, 'Visible', 'off');
    set(handles.radio3dAbsMaxTime, 'Visible', 'off');
    set(handles.radio3dMean, 'Visible', 'off');
    set(handles.radio3dMedian, 'Visible', 'off');
    set(handles.radio3dStd, 'Visible', 'off');
    set(handles.radio3dDur, 'Visible', 'off');
    set(handles.radio3dRange, 'Visible', 'off');
else
    %set(handles.textDiscrete3d, 'Visible', 'on');
    set(handles.textDiscrete3dMag, 'Visible', 'on');
    set(handles.textDiscrete3dTime, 'Visible', 'on');
    set(handles.text3dMin, 'Visible', 'on');
    set(handles.text3dMax, 'Visible', 'on');
    set(handles.text3dAbsMax, 'Visible', 'on');
    set(handles.text3dMean, 'Visible', 'on');
    set(handles.text3dMedian, 'Visible', 'on');
    set(handles.text3dRange, 'Visible', 'on');
    set(handles.text3dStd, 'Visible', 'on');
    set(handles.text3dDur, 'Visible', 'on');
    set(handles.radio3dMinMag, 'Visible', 'on');
    set(handles.radio3dMaxMag, 'Visible', 'on');
    set(handles.radio3dMinTime, 'Visible', 'on');
    set(handles.radio3dMaxTime, 'Visible', 'on');
    set(handles.radio3dAbsMaxMag, 'Visible', 'on');
    set(handles.radio3dAbsMaxTime, 'Visible', 'on');
    set(handles.radio3dMean, 'Visible', 'on');
    set(handles.radio3dMedian, 'Visible', 'on');
    set(handles.radio3dStd, 'Visible', 'on');
    set(handles.radio3dDur, 'Visible', 'on');
    set(handles.radio3dRange, 'Visible', 'on');
end

guidata(hObject, handles);

%%  If events are defined in c3d file, hide event and phase/cycle ui controls
function checkC3dEventNames_Callback(hObject, eventdata, handles)
handles.getEventLabelsFromC3d = get(hObject,'Value');
if handles.getEventLabelsFromC3d == 1
    set(handles.popupNumEvents, 'Visible', 'off');
    set(handles.pushbuttonDefineEvents, 'Visible', 'off');
    set(handles.pushbuttonDefinePhasesAndCycles, 'Visible', 'off');
else
    set(handles.popupNumEvents, 'Visible', 'on');
    set(handles.pushbuttonDefineEvents, 'Visible', 'on');
    set(handles.pushbuttonDefinePhasesAndCycles, 'Visible', 'on');

end
guidata(hObject, handles);

%%   Number of events
function popupNumEvents_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupNumEvents_Callback(hObject, eventdata, handles)
numberOfEventsStrings = get(hObject, 'String');
numberOfEventsValue = get(hObject, 'Value');
if numberOfEventsValue < 2
    msgbox('A minimum of 2 events are required!', 'Warning', 'warn')
end
handles.numberOfEvents = str2num(char(numberOfEventsStrings(numberOfEventsValue, :)));
guidata(hObject, handles);


%%   Define events
function pushbuttonDefineEvents_Callback(hObject, eventdata, handles)
eventNames = defineGeneralEventNamesSubGui(handles.numberOfEvents);
handles.Events = eventNames;
guidata(hObject, handles);

%%   Number of phases and cycles
function popupNumPhasesAndCycles_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function popupNumPhasesAndCycles_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.numberOfPhasesAndCycles = str2num(char(contents{get(hObject,'Value')}));
guidata(hObject, handles);


%%   Define  phases and cycles
function pushbuttonDefinePhasesAndCycles_Callback(hObject, eventdata, handles)
[phasesAndCycles] = definePhasesAndCyclesSubGui(handles.numberOfPhasesAndCycles, handles.Events);
handles.phasesAndCycles = phasesAndCycles;
guidata(hObject, handles);


%%   To filter analog data
function radioFilterAnalog_Callback(hObject, eventdata, handles)
handles.filterAnalog = get(hObject,'Value');

if handles.filterAnalog == 0;
    %set(handles.textFilterCharacteristics, 'Visible', 'off');
    set(handles.popupFilterOrder, 'Visible', 'off');
    set(handles.popupFilterType, 'Visible', 'off');
    set(handles.popupFilterModel, 'Visible', 'off');
    set(handles.textCutOffFreq, 'Visible', 'off');
    set(handles.editLowPassCutOff, 'Visible', 'off');
    set(handles.editHighPassCutOff, 'Visible', 'off');
else
    set(handles.radioFilterAnalog, 'Visible', 'on');
    set(handles.textFilterCharacteristics, 'Visible', 'on');
    set(handles.popupFilterOrder, 'Visible', 'on');
    set(handles.popupFilterModel, 'Visible', 'on');
    set(handles.popupFilterType, 'Visible', 'on');
    set(handles.textCutOffFreq, 'Visible', 'on');
    set(handles.editLowPassCutOff, 'Visible', 'on');
    set(handles.editHighPassCutOff, 'Visible', 'on');
end

guidata(hObject, handles);

%%  Determine whether EMG is to be rectified
function radioRectifyAnalog_Callback(hObject, eventdata, handles)
handles.toRectifyAnalog = get(hObject,'Value');
if handles.toRectifyAnalog == 1
    set(handles.editRectifyStartIndex, 'Visible', 'on');
    set(handles.editRectifyEndIndex, 'Visible', 'on');
    set(handles.textRectifyStartIndex, 'Visible', 'on');
    set(handles.textRectifyEndIndex, 'Visible', 'on');
else
    set(handles.editRectifyStartIndex, 'Visible', 'off');
    set(handles.editRectifyEndIndex, 'Visible', 'off');
    set(handles.textRectifyStartIndex, 'Visible', 'off');
    set(handles.textRectifyEndIndex, 'Visible', 'off');
end
guidata(hObject, handles);

%%  User input to select first analog channel to rectify
function editRectifyStartIndex_Callback(hObject, eventdata, handles)
handles.rectifyStartIndex = str2num(get(hObject,'String'));
guidata(hObject, handles);

function editRectifyStartIndex_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

%%  User input to select last analog channel to rectify
function editRectifyEndIndex_Callback(hObject, eventdata, handles)
handles.rectifyEndIndex = str2num(get(hObject,'String'));
guidata(hObject, handles);
function editRectifyEndIndex_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

%%   ----- Filtering uicontrols --------------------------------------------------
%   Select filter model
function popupFilterModel_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupFilterModel_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.filterModel = contents{get(hObject, 'Value')};
guidata(hObject, handles);

%%   Define the type of filter
function popupFilterType_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupFilterType_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.filterType = contents{get(hObject, 'Value')};


%%   Hide cut-off frequency boxes that are not required
if strmatch(handles.filterType, 'Select filter type');
    errordlg('This is not a valid selection')
elseif strmatch(handles.filterType, 'Low-pass');
    set(handles.editHighPassCutOff, 'Visible', 'off');
    set(handles.editLowPassCutOff, 'Visible', 'on');
elseif strmatch(handles.filterType, 'High-pass');
    set(handles.editLowPassCutOff, 'Visible', 'off');
    set(handles.editHighPassCutOff, 'Visible', 'on');
else
    set(handles.editLowPassCutOff, 'Visible', 'on');
    set(handles.editHighPassCutOff, 'Visible', 'on');
end
guidata(hObject, handles);


%%   Define filter order
function popupFilterOrder_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupFilterOrder_Callback(hObject, eventdata, handles)
contents = get(hObject,'String');
handles.filterOrder = str2num(char(contents{get(hObject,'Value')}));
guidata(hObject, handles);


%%   Define the high-pass cutoff frequency
function editHighPassCutOff_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function editHighPassCutOff_Callback(hObject, eventdata, handles)
handles.highPassCutOff = str2num(get(hObject,'String'));
guidata(hObject, handles);


%%   Define the low-pass cutoff frequency
function editLowPassCutOff_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function editLowPassCutOff_Callback(hObject, eventdata, handles)
handles.lowPassCutOff = str2num(get(hObject,'String'));
guidata(hObject, handles);


%%   ----- Discrete uicontrols --------------------------------------------------
%   To calculate the minimum magnitudes of kinematic and kinetic data
function radio3dMinMag_Callback(hObject, eventdata, handles)
handles.calcMinMag3d = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate the maximum magnitudes of kinematic and kinetic data
function radio3dMaxMag_Callback(hObject, eventdata, handles)
handles.calcMaxMag3d = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate the absolute maximum magnitudes of kinematic and kinetic data
function radio3dAbsMaxMag_Callback(hObject, eventdata, handles)
handles.calcAbsMaxMag3d = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate the time at which minimum kinematic and kinetic values occur
function radio3dMinTime_Callback(hObject, eventdata, handles)
handles.calcMinTime3d = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate the time at which maximum kinematic and kinetic values occur
function radio3dMaxTime_Callback(hObject, eventdata, handles)
handles.calcMaxTime3d = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate the time at which absolute maximum kinematic and kinetic values
%   occur
function radio3dAbsMaxTime_Callback(hObject, eventdata, handles)
handles.calcAbsMaxTime3d = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate the range of kinematic and kinetic data
function radio3dRange_Callback(hObject, eventdata, handles)
handles.calcRange3d = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate mean value of kinematic variables
function radio3dMean_Callback(hObject, eventdata, handles)
handles.calcMean3d = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate median value of kinematic variables
function radio3dMedian_Callback(hObject, eventdata, handles)
handles.calcMean3d = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate standard deviation of kinematic variables
function radio3dStd_Callback(hObject, eventdata, handles)
handles.calcStd3d = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate duration of kinematic variables
function radio3dDur_Callback(hObject, eventdata, handles)
handles.calcDuration3d = get(hObject,'Value');
guidata(hObject, handles);


%   To calculate the minimum analog values
function radioAnalogMinMag_Callback(hObject, eventdata, handles)
handles.calcMinMagAnalog = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate the time at which minimum analog values occur
function radioAnalogMinTime_Callback(hObject, eventdata, handles)
handles.calcMinTimeAnalog = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate the maximum analog values
function radioAnalogMaxMag_Callback(hObject, eventdata, handles)
handles.calcMaxMagAnalog = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate the time at which maximum analog values occur
function radioAnalogMaxTime_Callback(hObject, eventdata, handles)
handles.calcMaxTimeAnalog = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate the absolute maximum analog values
function radioAnalogAbsMaxMag_Callback(hObject, eventdata, handles)
handles.calcAbsMaxMagAnalog = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate the time at which absolute maximum analog values occur
function radioAnalogAbsMaxTime_Callback(hObject, eventdata, handles)
handles.calcAbsMaxTimeAnalog = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate mean of analog variables
function radioAnalogMean_Callback(hObject, eventdata, handles)
handles.calcMeanAnalog = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate median of analog variables
function radioAnalogMedian_Callback(hObject, eventdata, handles)
handles.calcStdAnalog = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate standard deviation of analog variables
function radioAnalogStd_Callback(hObject, eventdata, handles)
handles.calcStdAnalog = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate duration of analog variables
function radioAnalogDur_Callback(hObject, eventdata, handles)
handles.calcDurationAnalog = get(hObject,'Value');
guidata(hObject, handles);

%   To calculate the range of analog data
function radioAnalogRange_Callback(hObject, eventdata, handles)
handles.calcRangeAnalog = get(hObject,'Value');
guidata(hObject, handles);




%%   ----- Output uicontrols -----------------------------------------------------
%   To output non-temporally normalised data
function radioOutputNonTempNormData_Callback(hObject, eventdata, handles)
handles.outputNonTempNormData = get(hObject,'Value');
guidata(hObject, handles);

%   To output temporally normalised data
function radioOutputTempNormData_Callback(hObject, eventdata, handles)
handles.outputTempNormData = get(hObject,'Value');
guidata(hObject, handles);

%   Define number of data points in temporally normalised series
function editNumTempNormPoints_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function editNumTempNormPoints_Callback(hObject, eventdata, handles)
handles.numTempNormDataPoints = str2num(get(hObject,'String'));
guidata(hObject, handles);


%%   To plot joint angles
function radioPlotJointAngles_Callback(hObject, eventdata, handles)
helpdlg('This option has been disabled. Check your output in Excel'); 
handles.plotJointAngles = 0;%get(hObject,'Value');
set(handles.radioPlotJointAngles, 'Value', 0);
guidata(hObject, handles);

%%   To plot joint moments
function radioPlotJointMoms_Callback(hObject, eventdata, handles)
helpdlg('This option has been disabled. Check your output in Excel'); 
handles.plotJointMoms = 0;%get(hObject,'Value');
set(handles.radioPlotJointMoms, 'Value', 0);
guidata(hObject, handles);


%%   ----- GO Button processing --------------------------------------------------
function pushbuttonGO_Callback(hObject, eventdata, handles)
close all;
TempNormGuiVersion = 'v20190510';   % Prasanna Sritharan

% add code root to path (Added by Prasanna Sritharan, 2019)
addpath(pwd);

%   Unpack relevant fields from handles structure
processAnalog = handles.processAnalog;
process3d = handles.process3d;
getEventLabelsFromC3d = handles.getEventLabelsFromC3d;
performCustomProcessing = handles.performCustomProcessing;

%   Ensure analog filter specs are updated. Edit box values may not be updated
%   in certain situations.
if handles.filterAnalog == 1;
    if strmatch(handles.filterType, 'High-pass')
        handles.highPassCutOff = str2num(get(handles.editHighPassCutOff, 'String'));
    elseif strmatch(handles.filterType, 'Low-pass')
        handles.lowPassCutOff = str2num(get(handles.editLowPassCutOff, 'String'));
    elseif strmatch(handles.filterType, 'Band-pass')
        handles.highPassCutOff = str2num(get(handles.editHighPassCutOff, 'String'));
        handles.lowPassCutOff = str2num(get(handles.editLowPassCutOff, 'String'));
    elseif strmatch(handles.filterType, 'Band-stop')
        handles.highPassCutOff = str2num(get(handles.editHighPassCutOff, 'String'));
        handles.lowPassCutOff = str2num(get(handles.editLowPassCutOff, 'String'));
    end
end

%   Ensure that temporally normalised data points value is updated.
%   Edit box values may not be updated in certain situations.
if handles.outputTempNormData == 1;
    handles.numTemNormPoints = str2num(get(handles.editNumTempNormPoints, 'String'));
end
guidata(hObject, handles);

%   Define constants
handles.markerSet = 'uwa';

%   First ensure that valid selections have been made
if handles.getEventLabelsFromC3d == 0
    if handles.numberOfEvents <=1
        errordlg('You must define at least 2 events to continue');
        return
    end

    if handles.numberOfPhasesAndCycles == 0
        errordlg('You must define at least phase or cycle to continue');
        return
    end
end

if handles.outputNonTempNormData & handles.outputNonTempNormData == 0
    errordlg('You must output either temporally and/or non-temporally normalised data');
    return
end

% if strcmp(handles.performCustomProcessing, 'Standard trial')
%     uiwait(msgbox('No custom processing defined. Standard trial processing will be used!', 'Warning', 'modal'));
%     handles.performCustomProcessing = 'Standard trial';
% end


%%   Set all discrete analog processing statements to zero if analog data
%   not being processed
if  handles.processAnalog == 0
    handles.calcMaxMagAnalog = 0;
    handles.calcMaxTimeAnalog = 0;
    handles.calcAbsMaxMagAnalog = 0;
    handles.calcAbsMaxTimeAnalog = 0;
    handles.calcMinMagAnalog = 0;
    handles.calcMinTimeAnalog = 0;
    handles.calcMeanAnalog = 0;
    handles.calcMedianAnalog = 0;
    handles.calcStdAnalog = 0;
    handles.calcDurationAnalog = 0;
end


%%   Read c3d data
for trialIndex = 1:handles.numberOfFiles;
    close all
    if iscell(handles.fileNames)
        fullFileName = fullfile(handles.filePath, char(handles.fileNames(trialIndex)));
    else
        fullFileName = fullfile(handles.filePath, handles.fileNames);
    end
    
    analogData = [];
    analogLabels = [];
    analogStruct = [];
    
    
    [complete3dData.c3dVariables,analogStruct,videoFrameRate,analogFrameRate,...
        eventTimes,eventTypes,eventLabels,eventSides] = readc3duwaStruct(fullFileName,...
        handles.trialType, handles.performCustomProcessing, handles.complete.c3dVariableNames, 'all', 'y');

    if handles.processAnalog
        analogLabels = fieldnames(analogStruct);
        nAnalogChannels = length(analogLabels);
        
        %   Unpack analog struct to 2d array
        analogData = fields2array(analogStruct);
    end

        
    %   Get names of all 3d variables present in c3d file
    if handles.process3d
        completeVariableNamesInC3d = fieldnames(complete3dData.c3dVariables);
        numCompleteVariablesInC3d = length(completeVariableNamesInC3d);
    else
        completeVariableNamesInC3d = [];
        numCompleteVariablesInC3d = 0;
    end
    
    %   Count number of 3d variables in custom and complete lists
    numCompleteVariablesInTxt = length(handles.complete.c3dVariableNames);
    numCustomVariablesInTxt = length(handles.custom.outputVariableNames);

    %   Deal c3d variables (n*3 arrays) to output variables (n*1 arrays)
    if handles.process3d
        for i = 1:numCompleteVariablesInTxt
            for j = 1:numCompleteVariablesInC3d
                if strcmp(handles.complete.c3dVariableNames(i), completeVariableNamesInC3d(j));
                    for k = 1:3
                        eval(['complete3dData.outputVariables.' char(handles.complete.outputVariableNames(i,k)) ' = complete3dData.c3dVariables.' char(completeVariableNamesInC3d(j)) '(:,k);']);
                    end
                end
            end
        end
    else
        complete3dData.outputVariables = [];
    end

    %   Generate complete output variable array
    if handles.process3d
        complete3dArray = fields2array(complete3dData.outputVariables);
    else
        complete3dArray = [];
    end
        
    %   Generate custom output variable array
    custom3dData.outputVariables = [];  % Prasanna Sritharan
    if handles.process3d
        [nRows, nCols] = size(handles.custom.outputVariableNames);
        completeOutputNames = fieldnames(complete3dData.outputVariables);
        numCompleteOutputNames = length(completeOutputNames);
        customOutputNames = handles.custom.outputVariableNames;
        [num3dRows, num3dCols] = size(complete3dArray);

        for i = 1:numCustomVariablesInTxt
            for j = 1:numCompleteOutputNames
                if strcmp(customOutputNames(i), completeOutputNames(j))
                    eval(['custom3dData.outputVariables.' char(customOutputNames(i)) ' = complete3dData.outputVariables.' char(completeOutputNames(j)) ';']);
                end
            end
        end

        customOutputNames = fieldnames(custom3dData.outputVariables);
        numCustomOutputNames = length(customOutputNames);

        %   Generate array of user defined 3d variables in textMedian3d file order
        custom3dArray = fields2array(custom3dData.outputVariables);
    else
        completeOutputNames = [];
        numCompleteOutputNames = 0;
        customOutputNames = [];
        [nRows, nCols] = size(handles.custom.outputVariableNames);
        [num3dRows, num3dCols] = size(complete3dArray);
    end

    %% Prepare data paths, names and formats for output
    %   Create directories for output files from current trial
    fileNames = char(handles.fileNames);

    %   Split fullFileName into parts
    pathParts = splitPath(fullFileName);
    numPathParts = length(pathParts);
    outputDirName = char(pathParts(end));
    outputDirName = outputDirName(1:end-4);
    outputFilePrefix = outputDirName;

    %   Remove any spaces that may have been used to pad character array
    %   after conversion from cell array
    letterIndex = 1;
    spaceIndexes = isspace(outputDirName);
    for j = 1:length(outputDirName);
        if spaceIndexes(j) == 0
            newOutputDirName(letterIndex) = outputDirName(j);
            letterIndex = letterIndex + 1;
        end
    end

    %   Make output directories for trial
    outputDirName = [newOutputDirName '_out'];
    [success, message, messageId] = mkdir(handles.filePath, outputDirName);
    outputDir = [handles.filePath, outputDirName];
    
    %   Alert user that no analog data was located and that no analog processing
    %   will be performed if no analog channels are present
    if processAnalog == 1 & size(analogData, 2) == 0
        uiwait(msgbox('No analog data found. Your request for analog processing will be ignored', 'modal'));
        processAnalog = 0;
    end

    %   Create output sub directories for 3d data
    if process3d == 1
        [success, message, messageId] = mkdir(fullfile(handles.filePath,outputDirName), 'complete');
        [success, message, messageId] = mkdir(fullfile(handles.filePath,outputDirName), 'custom');
        completeDir = [handles.filePath, outputDirName, '\complete'];
        customDir = [handles.filePath, outputDirName, '\custom'];
    end
    
    %   Create output sub directories for analog data
    if processAnalog == 1
        [success, message, messageId] = mkdir(fullfile(handles.filePath,outputDirName), 'analog');
        analogDir = [handles.filePath, outputDirName, '\analog'];
    end


    %   Generate format string for analog output files
    if processAnalog == 1
        [nAnalogRows, nAnalogCols] = size(analogData);
        for j = 1:6:nAnalogCols * 6;
            analogSpecifiers(j:j+5) = '%6.5f,';
        end
        analogSpecifiers = ['%6.5f,%6.5f,' analogSpecifiers(1:end-1) '\n'];
    end


    %%   Get events from c3d files to determine whether kinematics and/or
    %   kinetics will be output for the left and right sides
    eventSides = char(eventSides);
    eventSides = eventSides(:,1);

    %   Rearrange events in ascending order
    [eventTimes, newOrder] = sort(eventTimes);
    for j = 1:length(eventTypes);
        newEventTypes(j) = eventTypes(newOrder(j));
        newEventSides(j) = eventSides(newOrder(j));
        newEventLabels(j) = cellstr(eventLabels(newOrder(j)));
    end
    eventTypes = newEventTypes;
    eventSides = newEventSides;
    eventLabels = newEventLabels;

    %   Define 'startEvents' as 1st event marker at occurs after the initial frame 
    startEvents = 1;    
    while round(eventTimes(startEvents)*1000)/1000 == 0;
        startEvents = startEvents + 1;
    end
    
    %   Set frame 1 time to equal dt as opposed to 0
    eventTimes = eventTimes + 1/videoFrameRate;

    %   Generate format string for kin output files
    if process3d == 1

        %   Generate specifiers string for complete3dData
        for j = 1:6:numCompleteOutputNames * 6;
            complete3dSpecifiers(j:j+5) = '%6.5f,';
        end
        complete3dSpecifiers = ['%6.5f,%6.5f,' complete3dSpecifiers(1:end-1) '\n'];

        %   Generate specifiers string for custom3dData
        for j = 1:6:numCustomOutputNames * 6;
            custom3dSpecifiers(j:j+5) = '%6.5f,';
        end
        custom3dSpecifiers = ['%6.5f,%6.5f,' custom3dSpecifiers(1:end-1) '\n'];

    end

    %   Remove event times that are on 1st frame (previous versions used
    %   these markers to define outputs)
    eventTimes = eventTimes(startEvents:end);   % remove event times used to define kinetic and kinematic outputs
    eventLabels = eventLabels(startEvents:end);   % remove event labels used to define kinetic and kinematic outputs
    eventSides = eventSides(startEvents:end);   % remove event sides used to define kinetic and kinematic outputs
    clear newEvent*
    
    if handles.getEventLabelsFromC3d == 0
        numberOfEvents = handles.numberOfEvents; % This is number of events specified by user in gui
    else
        numberOfEvents = length(eventTimes);
    end
    numberOfc3dEvents = length(eventTimes); % this is number of events in c3d file

    %   Prefix event names with 'Side' if sidestepping trial type
    if strcmp(handles.performCustomProcessing, 'Sidestepping trial')
        for j = 1:numberOfc3dEvents
            eventLabels(j) = cellstr([eventSides(j) char(eventLabels(j))]);
            eventLabel = char(eventLabels(j));
            index = 1;
            for k = 1:length(eventLabel)
                if isempty(strmatch(eventLabel(k), '_')) && isempty(strmatch(eventLabel(k), ' '))
                    newEventLabels(j,index) = eventLabel(k);
                    index = index + 1;
                end
            end
        end
        eventLabels = cellstr(newEventLabels);
        clear newEvent*
    end

    if strcmp(handles.performCustomProcessing, 'Gait trial')
        if handles.getEventLabelsFromC3d == 1
            for j = 1:numberOfc3dEvents
                eventLabels(j) = cellstr([eventSides(j) char(eventLabels(j))]);
                eventLabel = char(eventLabels(j));
                index = 1;
                for k = 1:length(eventLabel)
                    if isempty(strmatch(eventLabel(k), '_')) && isempty(strmatch(eventLabel(k), ' '))
                        newEventLabels(j,index) = eventLabel(k);
                        index = index + 1;
                    end
                end
            end

            eventLabels = cellstr(newEventLabels);
            clear newEvent*
        end
    end
    
    %   Check to see if there are multiple occurrences of the same label.
    %   Give numeric suffixes if there are in ascending order of time
    for j = 1:numberOfEvents
        currentEventLabel = eventLabels(j);
        occurrences = strmatch(currentEventLabel, eventLabels, 'exact');
        if length(occurrences) >1
            for k = 1:length(occurrences)
                eventLabels(occurrences(k)) = cellstr([char(eventLabels(occurrences(k))) num2str(k)]);
            end
        end
    end

    %   If names are derived from c3d file define eventNames (user based) as
    %   eventLabels(c3d based)
    if handles.getEventLabelsFromC3d == 1
        eventNames = eventLabels;
        if trialIndex == 1
           handles.eventNamesCheck = eventNames; 
        end
    else
        for i = 1:numberOfEvents
            eventNames(i) = cellstr(handles.Events(i).Names);
        end
    end


    %%  Logical loop to define phases and cycles from c3d file if requested
    handles.check2 = [];    % Added by Prasanna Sritharan, 2019
    if trialIndex == 1
        if getEventLabelsFromC3d == 1
            [handles.phasesAndCycles1] = definePhasesAndCyclesFromC3dSubGui(handles.numberOfPhasesAndCycles,eventTimes,eventLabels);
            handles.check2 = 0;
        end
    end
    
    if handles.check2 == 0
        if trialIndex > 1
            if getEventLabelsFromC3d == 1
                if strcmp(eventNames,handles.eventNamesCheck)== 0
                    [handles.phasesAndCycles2] = definePhasesAndCyclesFromC3dSubGui(handles.numberOfPhasesAndCycles,eventTimes,eventLabels);
                    handles.check2 = 1;
                end
            end
        end
    end
    
    if getEventLabelsFromC3d == 1
        if trialIndex == 1
            handles.phasesAndCycles = handles.phasesAndCycles1;
        else
            check = strcmp(eventNames,handles.eventNamesCheck);
            if check == 1
                handles.phasesAndCycles = handles.phasesAndCycles1;
            elseif check == 0
                handles.phasesAndCycles = handles.phasesAndCycles2;
            end
        end
    end
    
    %% Custom Gait Processing
    %  Calculates spatio-temporal parameters
    
    if strcmp(performCustomProcessing, 'Gait trial')
        rStrideLength = [];
        lStrideLength = [];
        rCadence = [];
        lCadence = [];
        rVelocity = [];
        lVelocity = [];
        rStance = [];
        lStance = [];
        rSwing = [];
        lSwing = [];
        rDoubleSupport = [];
        lDoubleSupport = [];
        strideWidth = [];

        %   Extract variables required for spatio-temporal processing
        rMMal = replacezeroswithnans([complete3dData.outputVariables.RMMALX, complete3dData.outputVariables.RMMALY, complete3dData.outputVariables.RMMALZ]);
        lMMal = replacezeroswithnans([complete3dData.outputVariables.LMMALX, complete3dData.outputVariables.LMMALY, complete3dData.outputVariables.LMMALZ]);
        rCal = replacezeroswithnans([complete3dData.outputVariables.RCALX, complete3dData.outputVariables.RCALY, complete3dData.outputVariables.RCALZ]);
        lCal = replacezeroswithnans([complete3dData.outputVariables.LCALX, complete3dData.outputVariables.LCALY, complete3dData.outputVariables.LCALZ]);
        
        %   Calculate stride width from entire trial
        strideWidth = min(Fresultant2(rMMal, lMMal))/1000;

        %   Calculate right and left stride lengths if possible
        RFootContact1Index = strmatch('RFootStrike1', eventNames);
        RFootContact2Index = strmatch('RFootStrike2', eventNames);
        LFootContact1Index = strmatch('LFootStrike1', eventNames);
        LFootContact2Index = strmatch('LFootStrike2', eventNames);

        RMidSwing1Index = strmatch('RMidSwing1', eventNames);
        RMidSwing2Index = strmatch('RMidSwing2', eventNames);
        LMidSwing1Index = strmatch('LMidSwing1', eventNames);
        LMidSwing2Index = strmatch('LMidSwing2', eventNames);

        RFootOff1Index = strmatch('RFootOff1', eventNames);
        RFootOff2Index = strmatch('RFootOff2', eventNames);
        LFootOff1Index = strmatch('LFootOff1', eventNames);
        LFootOff2Index = strmatch('LFootOff2', eventNames);
        
        if isempty(RFootOff1Index) == 1
            RFootOff1Index = strmatch('RFootOff', eventNames);
        end
        
        if isempty(LFootOff1Index) == 1
            LFootOff1Index = strmatch('LFootOff', eventNames);
        end

        % Right stride length and cadence
        if isempty(RFootContact1Index) == 0 && isempty(RFootContact2Index) == 0
            RFootContact1Frame = round(eventTimes(RFootContact1Index) * videoFrameRate);
            RFootContact2Frame = round(eventTimes(RFootContact2Index) * videoFrameRate);
            rCal_stride = rCal(RFootContact1Frame:RFootContact2Frame,:);
            rStrideLength = sqrt(range(rCal_stride(:,1)).^2 + range(rCal_stride(:,2)).^2)/1000;
            rCadence = 1/((RFootContact2Frame - RFootContact1Frame)/videoFrameRate)*120;
        elseif isempty(RMidSwing1Index) == 0 && isempty(RMidSwing2Index) == 0
            RMidSwing1Frame = round(eventTimes(RMidSwing1Index) * videoFrameRate);
            RMidSwing2Frame = round(eventTimes(RMidSwing2Index) * videoFrameRate);
            rCal_stride = rCal(RMidSwing1Frame:RMidSwing2Frame,:);
            rStrideLength = sqrt(range(rCal_stride(:,1)).^2 + range(rCal_stride(:,2)).^2)/1000;
            rCadence = 1/((RMidSwing2Frame - RMidSwing1Frame)/videoFrameRate)*120;
        elseif isempty(RFootOff1Index) == 0 && isempty(RFootOff2Index) == 0
            RFootOff1Frame = round(eventTimes(RFootOff1Index) * videoFrameRate);
            RFootOff2Frame = round(eventTimes(RFootOff2Index) * videoFrameRate);
            rCal_stride = rCal(RFootOff1Frame:RFootOff2Frame,:);
            rStrideLength = sqrt(range(rCal_stride(:,1)).^2 + range(rCal_stride(:,2)).^2)/1000;
            rCadence = 1/((RFootOff2Frame - RFootOff1Frame)/videoFrameRate)*120;
        end

        % Left stride length and cadence
        if isempty(LFootContact1Index) == 0 && isempty(LFootContact2Index) == 0
            LFootContact1Frame = round(eventTimes(LFootContact1Index) * videoFrameRate);
            LFootContact2Frame = round(eventTimes(LFootContact2Index) * videoFrameRate);
            lCal_stride = lCal(LFootContact1Frame:LFootContact2Frame,:);
            lStrideLength = sqrt(range(lCal_stride(:,1)).^2 + range(lCal_stride(:,2)).^2)/1000;
            lCadence = 1/((LFootContact2Frame - LFootContact1Frame)/videoFrameRate)*120;
        elseif isempty(LMidSwing1Index) == 0 && isempty(LMidSwing2Index) == 0
            LMidSwing1Frame = round(eventTimes(LMidSwing1Index) * videoFrameRate);
            LMidSwing2Frame = round(eventTimes(LMidSwing2Index) * videoFrameRate);
            lCal_stride = lCal(LMidSwing1Frame:LMidSwing2Frame,:);
            lStrideLength = sqrt(range(lCal_stride(:,1)).^2 + range(lCal_stride(:,2)).^2)/1000;
            lCadence = 1/((LMidSwing2Frame - LMidSwing1Frame)/videoFrameRate)*120;
        elseif isempty(LFootOff1Index) == 0 && isempty(LFootOff2Index) == 0
            LFootOff1Frame = round(eventTimes(LFootOff1Index) * videoFrameRate);
            LFootOff2Frame = round(eventTimes(LFootOff2Index) * videoFrameRate);
            lCal_stride = lCal(LFootOff1Frame:LFootOff2Frame,:);
            lStrideLength = sqrt(range(lCal_stride(:,1)).^2 + range(lCal_stride(:,2)).^2)/1000;
            lCadence = 1/((LFootOff2Frame - LFootOff1Frame)/videoFrameRate)*120;
        end

        %   Right stance duration
        if isempty(RFootOff1Index) == 0
            try
                if RFootOff1Index > RFootContact1Index
                    rStance = (eventTimes(RFootOff1Index) - eventTimes(RFootContact1Index));
                elseif RFootOff2Index > RFootContact1Index
                    rStance = (eventTimes(RFootOff2Index) - eventTimes(RFootContact1Index));
                end
            catch
            end
        end

        %   Left stance duration
        if isempty(LFootOff1Index) == 0
            try
                if LFootOff1Index > LFootContact1Index
                    lStance = (eventTimes(LFootOff1Index) - eventTimes(LFootContact1Index));
                elseif LFootOff2Index > LFootContact1Index
                    lStance = (eventTimes(LFootOff2Index) - eventTimes(LFootContact1Index));
                end
            catch
            end
        end

       
        %   Calculate velocities
        if exist('rCadence')
            rVelocity = (rCadence/120)*rStrideLength;
        end
        if exist('lCadence')
            lVelocity = (lCadence/120)*lStrideLength;
        end


        % Double support duration
        % Right side
        % If RFootContact1 occurs just before LFootOff1
        if RFootContact1Index < LFootOff1Index
            if isempty(RFootContact1Index) == 0 && isempty(LFootOff1Index) == 0
                RFootContact1Frame = round(eventTimes(RFootContact1Index) * videoFrameRate);
                LFootOff1Frame = round(eventTimes(LFootOff1Index) * videoFrameRate);
                rDoubleSupport = (LFootOff1Frame - RFootContact1Frame)/videoFrameRate;
                rFootY = complete3dData.outputVariables.RMMALY(RFootContact1Frame:LFootOff1Frame);
                lFootY = complete3dData.outputVariables.LMMALY(RFootContact1Frame:LFootOff1Frame);
                rStrideWidth = mean(abs((rFootY-lFootY)/1000));
            elseif isempty(RFootContact2Index) == 0 && isempty(LFootOff2Index) == 0
                RFootContact2Frame = round(eventTimes(RFootContact2Index) * videoFrameRate);
                LFootOff2Frame = round(eventTimes(LFootOff2Index) * videoFrameRate);
                rDoubleSupport = (LFootOff2Frame - RFootContact2Frame)/videoFrameRate;
                rFootY = complete3dData.outputVariables.RMMALY(RFootContact2Frame:LFootOff2Frame);
                lFootY = complete3dData.outputVariables.LMMALY(RFootContact2Frame:LFootOff2Frame);
                rStrideWidth = mean(abs((rFootY-lFootY)/1000));
            end
            % If RFootContact1 occurs just before LFootOff2
        elseif RFootContact1Index < LFootOff2Index
            if isempty(RFootContact1Index) == 0 && isempty(LFootOff2Index) == 0
                RFootContact1Frame = round(eventTimes(RFootContact2Index) * videoFrameRate);
                LFootOff2Frame = round(eventTimes(LFootOff2Index) * videoFrameRate);
                rDoubleSupport = (LFootOff2Frame - RFootContact1Frame)/videoFrameRate;
                rFootY = complete3dData.outputVariables.RMMALY(RFootContact1Frame:LFootOff2Frame);
                lFootY = complete3dData.outputVariables.LMMALY(RFootContact1Frame:LFootOff2Frame);
                rStrideWidth = mean(abs((rFootY-lFootY)/1000));
            end
        end

        % Double support duration
        % Left side
        % If LFootContact1 occurs just before RFootOff1
        if LFootContact1Index < RFootOff1Index
            if isempty(LFootContact1Index) == 0 && isempty(RFootOff1Index) == 0
                LFootContact1Frame = round(eventTimes(LFootContact1Index) * videoFrameRate);
                RFootOff1Frame = round(eventTimes(RFootOff1Index) * videoFrameRate);
                lDoubleSupport = (RFootOff1Frame - LFootContact1Frame)/videoFrameRate;
                rFootY = complete3dData.outputVariables.RMMALY(LFootContact1Frame:RFootOff1Frame);
                lFootY = complete3dData.outputVariables.LMMALY(LFootContact1Frame:RFootOff1Frame);
                lStrideWidth = mean(abs((rFootY-lFootY)/1000));
            elseif isempty(LFootContact2Index) == 0 && isempty(RFootOff2Index) == 0
                LFootContact2Frame = round(eventTimes(LFootContact2Index) * videoFrameRate);
                RFootOff2Frame = round(eventTimes(RFootOff2Index) * videoFrameRate);
                lDoubleSupport = (RFootOff2Frame - LFootContact2Frame)/videoFrameRate;
                rFootY = complete3dData.outputVariables.RMMALY(LFootContact2Frame:RFootOff2Frame);
                lFootY = complete3dData.outputVariables.LMMALY(LFootContact2Frame:RFootOff2Frame);
                lStrideWidth = mean(abs((rFootY-lFootY)/1000));
            end
            % If RFootContact1 occurs just before LFootOff2
        elseif LFootContact1Index < RFootOff2Index
            if isempty(LFootContact1Index) == 0 && isempty(RFootOff2Index) == 0
                LFootContact1Frame = round(eventTimes(LFootContact2Index) * videoFrameRate);
                RFootOff2Frame = round(eventTimes(RFootOff2Index) * videoFrameRate);
                lDoubleSupport = (RFootOff2Frame - LFootContact1Frame)/videoFrameRate;
                rFootY = complete3dData.outputVariables.RMMALY(LFootContact1Frame:RFootOff2Frame);
                lFootY = complete3dData.outputVariables.LMMALY(LFootContact1Frame:RFootOff2Frame);
                lStrideWidth = mean(abs((rFootY-lFootY)/1000));
            end
        end
        
        
        
        if isempty(rStance) == 0
            rSwing = 1/(rCadence/120) - rStance;
        end

        if isempty(lStance) == 0
            lSwing = 1/(lCadence/120) - lStance;
        end


        %%   Write spatio-temporal data to file
        cd(outputDir)
        fid = fopen(eval(['''' outputFilePrefix '_spatioTemporal.csv''']), 'w');
        fprintf(fid, '%s', 'Original file: ');
        fprintf(fid, '%s', fullFileName);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Date processed: ');
        fprintf(fid, '%s', date);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Video sampling rate (Hz): ');
        fprintf(fid, '%6.2f', videoFrameRate);
        fprintf(fid, '\n');
        fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
        fprintf(fid, '\n');
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Right gait velocity [m/s],');
        fprintf(fid, '%s', 'Left gait velocity [m/s],');
        fprintf(fid, '%s', 'Right based stride length [m],');
        fprintf(fid, '%s', 'Left based stride length [m],');
        fprintf(fid, '%s', 'Right based cadence [step/min],');
        fprintf(fid, '%s', 'Left based cadence [step/min],');
        fprintf(fid, '%s', 'Right stance [s],');
        fprintf(fid, '%s', 'Left stance [s],');
        fprintf(fid, '%s', 'Right swing [s],');
        fprintf(fid, '%s', 'Left swing [s],');
        fprintf(fid, '%s', 'Right double support [s],');
        fprintf(fid, '%s', 'Left double support [s],');
        fprintf(fid, '%s', 'RightStride width [m],');
        fprintf(fid, '%s', 'LeftStride width [m],');
        fprintf(fid, '\n');
        fprintf(fid, '%6.2f', rVelocity);
        fprintf(fid, ',');
        fprintf(fid, '%6.2f', lVelocity);
        fprintf(fid, ',');
        fprintf(fid, '%6.2f', rStrideLength);
        fprintf(fid, ',');
        fprintf(fid, '%6.2f', lStrideLength);
        fprintf(fid, ',');
        fprintf(fid, '%6.2f', rCadence);
        fprintf(fid, ',');
        fprintf(fid, '%6.2f', lCadence);
        fprintf(fid, ',');
        fprintf(fid, '%6.2f', rStance);
        fprintf(fid, ',');
        fprintf(fid, '%6.2f', lStance);
        fprintf(fid, ',');
        fprintf(fid, '%6.2f', rSwing);
        fprintf(fid, ',');
        fprintf(fid, '%6.2f', lSwing);
        fprintf(fid, ',');
        fprintf(fid, '%6.2f', rDoubleSupport);
        fprintf(fid, ',');
        fprintf(fid, '%6.2f', lDoubleSupport);
        fprintf(fid, ',');
        fprintf(fid, '%6.3f', rStrideWidth);
        fprintf(fid, ',');
        fprintf(fid, '%6.3f', lStrideWidth);
        fclose(fid);
    end

    if process3d == 1
        %   Define time and frame vectors for 3D data
        kinTimeVector = 0:1/videoFrameRate:(num3dRows-1)/videoFrameRate;
        kinFrameVector = 1:num3dRows;

        %%   Write complete 3D data to file for entire trial
        cd(completeDir);
        fid = fopen(eval(['''' outputFilePrefix '_3d.csv''']), 'w');
        fprintf(fid, '%s', 'Original file: ');
        fprintf(fid, '%s', fullFileName);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Date processed: ');
        fprintf(fid, '%s', date);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Video sampling rate (Hz): ');
        fprintf(fid, '%6.2f', videoFrameRate);
        fprintf(fid, '\n');
        fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
        fprintf(fid, '\n');
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Frame,');
        fprintf(fid, '%s', 'Time [s],');

        for k = 1:numCompleteOutputNames;
            fprintf(fid, '%s', eval(['''' char(completeOutputNames(k)) ',''']));
        end
        completeDataOutput = [kinFrameVector', kinTimeVector', complete3dArray];
        fprintf(fid, '\n');
        fprintf(fid, eval(['''' complete3dSpecifiers '''']), completeDataOutput');
        fclose(fid);

        %%   Write custom 3D data to file for entire trial
        cd(customDir);
        fid = fopen(eval(['''' outputFilePrefix '_3d.csv''']), 'w');
        fprintf(fid, '%s', 'Original file: ');
        fprintf(fid, '%s', fullFileName);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Date processed: ');
        fprintf(fid, '%s', date);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Video sampling rate (Hz): ');
        fprintf(fid, '%6.2f', videoFrameRate);
        fprintf(fid, '\n');
        fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
        fprintf(fid, '\n');
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Frame,');
        fprintf(fid, '%s', 'Time [s],');

        for k = 1:numCustomOutputNames;
            fprintf(fid, '%s', eval(['''' char(customOutputNames(k)) ',''']));
        end
        customDataOutput = [kinFrameVector', kinTimeVector', custom3dArray];
        fprintf(fid, '\n');
        fprintf(fid, eval(['''' custom3dSpecifiers '''']), customDataOutput');
        fclose(fid);
    end

    
    if processAnalog == 1
        analogTimeVector = 0:1/analogFrameRate:(nAnalogRows-1)/analogFrameRate;
        analogFrameVector = 1:nAnalogRows;
        if handles.toRectifyAnalog == 1;
            if trialIndex == 1
                [handles.bpFilter] = defineBPCutOffSubGui;
            end
            averageChannel = mean(analogData(:, handles.rectifyStartIndex: handles.rectifyEndIndex));
            analogData(:, handles.rectifyStartIndex) = analogData(:, handles.rectifyStartIndex) - averageChannel(1);
            for i = 1:(handles.rectifyEndIndex-handles.rectifyStartIndex)
                analogData(:, (handles.rectifyStartIndex + i)) = analogData(:, (handles.rectifyStartIndex + i)) - averageChannel(i+1) ;
            end

            if handles.bpFilter ~= 0
                analogData(:, handles.rectifyStartIndex: handles.rectifyEndIndex) = matfiltfilt2(1/analogFrameRate, [handles.bpFilter(1) handles.bpFilter(2)], 4, 'bp', analogData(:, handles.rectifyStartIndex: handles.rectifyEndIndex));
            end
            
             analogData(:, handles.rectifyStartIndex: handles.rectifyEndIndex) = abs(analogData(:, handles.rectifyStartIndex: handles.rectifyEndIndex));
        end
        %   Filter analog data if required
        if handles.filterAnalog
            switch (handles.filterModel)
                case 'Butterworth'
                    if strcmp(char(handles.filterType), 'Low-pass')
                        filteredAnalogData = matfiltfilt2(1/analogFrameRate, handles.lowPassCutOff,...
                            handles.filterOrder, 'lp', analogData);
                    elseif strcmp(char(handles.filterType), 'Band-pass')
                        filteredAnalogData = matfiltfilt2(1/analogFrameRate, [handles.highPassCutOff,...
                            handles.lowPassCutOff], handles.filterOrder, 'bp', analogData);
                    elseif strcmp(char(handles.filterType), 'Band-stop');
                        filteredAnalogData = matfiltfilt2(1/analogFrameRate, [handles.highPassCutOff,...
                            handles.lowPassCutOff], handles.filterOrder, 'bs', analogData);
                    else  % High pass
                        filteredAnalogData = matfiltfilt2(1/analogFrameRate, handles.highPassCutOff,...
                            handles.filterOrder, 'hp', analogData);
                    end
                case 'OTHER'
                    msgbox('This option is not currently available. The analog data has passed through without filtering')
                    filteredAnalogData = analogData;
                    %   Insert logic and filtering routine if another filter option is added
            end

            %   Write filtered analog data to file
            cd(analogDir);
            fid = fopen(eval(['''' outputFilePrefix '_FilteredAnalogData.csv''']), 'w');
            fprintf(fid, '%s', 'Original file: ');
            fprintf(fid, '%s', fullFileName);
            fprintf(fid, '\n');
            fprintf(fid, '%s', 'Date processed: ');
            fprintf(fid, '%s', date);
            fprintf(fid, '\n');
            fprintf(fid, '%s', 'Analog sampling rate (Hz): ');
            fprintf(fid, '%6.2f', analogFrameRate);
            fprintf(fid, '\n');
            fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
            fprintf(fid, '\n');
            fprintf(fid, '\n');
            fprintf(fid, '%s', 'Frame,');
            fprintf(fid, '%s', 'Time [s],');
            for k = 1:length(analogLabels);
                fprintf(fid, '%s', eval(['''' char(analogLabels(k)) ',''']));
            end
            fprintf(fid, '\n');
            filteredAnalogDataOutput = [analogFrameVector', analogTimeVector', filteredAnalogData];
            fprintf(fid, eval(['''' analogSpecifiers '''']), filteredAnalogDataOutput');
            fclose(fid);
        end

        %   Write unfiltered analog data to file
        cd(analogDir);
        fid = fopen(eval(['''' outputFilePrefix '_AnalogData.csv''']), 'w');
        fprintf(fid, '%s', 'Original file: ');
        fprintf(fid, '%s', fullFileName);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Date processed: ');
        fprintf(fid, '%s', date);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Analog sampling rate (Hz): ');
        fprintf(fid, '%6.2f', analogFrameRate);
        fprintf(fid, '\n');
        fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
        fprintf(fid, '\n');
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Frame,');
        fprintf(fid, '%s', 'Time [s],');
        for k = 1:length(analogLabels);
            fprintf(fid, '%s', eval(['''' char(analogLabels(k)) ',''']));
        end
        fprintf(fid, '\n');
        analogDataOutput = [analogFrameVector', analogTimeVector', analogData];
        fprintf(fid, eval(['''' analogSpecifiers '''']), analogDataOutput');
        fclose(fid);
    end


    %% Determine magnitudes, times and frames at which events occur and write to file
    if process3d == 1

        %%  Write complete 3d data set
        cd(completeDir);
        Events.Indexes = round(eventTimes*videoFrameRate)/videoFrameRate;
        fid = fopen(eval(['''' outputFilePrefix '_3d_events.csv''']), 'w');
        fprintf(fid, '%s', 'Original file: ');
        fprintf(fid, '%s', fullFileName);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Date processed: ');
        fprintf(fid, '%s', date);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Video sampling rate (Hz): ');
        fprintf(fid, '%6.2f', videoFrameRate);
        fprintf(fid, '\n');
        fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
        fprintf(fid, '\n');
        fprintf(fid, '\n');
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Event name:,');
        fprintf(fid, '%s', 'Event time [s]:, ');
        fprintf(fid, '%s', 'Event frame:, ');

        for k = 1:numCompleteOutputNames;
            fprintf(fid, '%s', eval(['''' char(completeOutputNames(k)) ',''']));
        end
        for j = 1:numberOfEvents
            fprintf(fid, '\n');
            complete3dDataAtThisEvent = complete3dArray(round(Events.Indexes(j)* videoFrameRate),:)';
            fprintf(fid, '%s,', char(eventNames(j)));
            fprintf(fid, '%6.2f,', (Events.Indexes(j)));
            fprintf(fid, '%6.0f,', Events.Indexes(j)* videoFrameRate);
            fprintf(fid, eval(['''' complete3dSpecifiers '''']), complete3dDataAtThisEvent');
        end
        fclose(fid);

        %%  Write custom 3d data set
        cd(customDir);
        Events.Indexes = round(eventTimes*videoFrameRate)/videoFrameRate;
        fid = fopen(eval(['''' outputFilePrefix '_3d_events.csv''']), 'w');
        fprintf(fid, '%s', 'Original file: ');
        fprintf(fid, '%s', fullFileName);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Date processed: ');
        fprintf(fid, '%s', date);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Video sampling rate (Hz): ');
        fprintf(fid, '%6.2f', videoFrameRate);
        fprintf(fid, '\n');
        fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
        fprintf(fid, '\n');
        fprintf(fid, '\n');
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Event name:,');
        fprintf(fid, '%s', 'Event time [s]:, ');
        fprintf(fid, '%s', 'Event frame:, ');

        for k = 1:numCustomOutputNames;
            fprintf(fid, '%s', eval(['''' char(customOutputNames(k)) ',''']));
        end
        for j = 1:numberOfEvents
            fprintf(fid, '\n');
            custom3dDataAtThisEvent = custom3dArray(round(Events.Indexes(j)* videoFrameRate),:)';
            fprintf(fid, '%s,', char(eventNames(j)));
            fprintf(fid, '%6.2f,', (Events.Indexes(j)));
            fprintf(fid, '%6.0f,', Events.Indexes(j)* videoFrameRate);
            fprintf(fid, eval(['''' custom3dSpecifiers '''']), custom3dDataAtThisEvent');
        end
        fclose(fid);
    end


    %%   Write Unfiltered analog data set
    if processAnalog == 1
        cd(analogDir)
        Events.Indexes = round(eventTimes*analogFrameRate)/analogFrameRate;
        fid = fopen(eval(['''' outputFilePrefix '_analog_events.csv''']), 'w');
        fprintf(fid, '%s', 'Original file: ');
        fprintf(fid, '%s', fullFileName);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Date processed: ');
        fprintf(fid, '%s', date);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Analog sampling rate (Hz): ');
        fprintf(fid, '%6.2f', analogFrameRate);
        fprintf(fid, '\n');
        fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
        fprintf(fid, '\n');
        fprintf(fid, '\n');
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Event name:,');
        fprintf(fid, '%s', 'Event frame:,');
        fprintf(fid, '%s', 'Event time [s]:,');
        for k = 1:length(analogLabels);
            fprintf(fid, '%s', eval(['''' char(analogLabels(k)) ',''']));
        end

        for j = 1:numberOfEvents
            fprintf(fid, '\n');
            analogDataAtThisEvent = analogData(round(Events.Indexes(j)* analogFrameRate),:)';
            fprintf(fid, '%s,', char(eventNames(j)));
            fprintf(fid, '%6.0f,', Events.Indexes(j)* analogFrameRate);
            fprintf(fid, '%6.2f,', (Events.Indexes(j)));
            fprintf(fid, eval(['''' analogSpecifiers '''']), analogDataAtThisEvent');
        end
        fclose(fid);
    end

    %%   Write filtered analog data set
    if handles.filterAnalog == 1
        cd(analogDir)
        Events.Indexes = round(eventTimes*analogFrameRate)/analogFrameRate;
        fid = fopen(eval(['''' outputFilePrefix '_filteredAnalog_events.csv''']), 'w');
        fprintf(fid, '%s', 'Original file: ');
        fprintf(fid, '%s', fullFileName);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Date processed: ');
        fprintf(fid, '%s', date);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Analog sampling rate (Hz): ');
        fprintf(fid, '%6.2f', analogFrameRate);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Model of filter:,');
        fprintf(fid, '%s', handles.filterModel);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Type of filter:,');
        fprintf(fid, '%s', handles.filterType);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Order of filter:,');
        fprintf(fid, '%6.0f', handles.filterOrder);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Filter LP cutoff (s): ');
        if isfield(handles, 'lowPassCutOff')
            fprintf(fid, '%4.0f', handles.lowPassCutOff);
        else
            fprintf(fid, '%s', 'NaN');
        end
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Filter HP cutoff (s): ');
        if isfield(handles, 'highPassCutOff')
            fprintf(fid, '%4.0f', handles.highPassCutOff);
        else
            fprintf(fid, '%s', 'NaN');
        end
        fprintf(fid, '\n');
        fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
        fprintf(fid, '\n');
        fprintf(fid, '\n');
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Event name:,');
        fprintf(fid, '%s', 'Event frame:,');
        fprintf(fid, '%s', 'Event time [s]:,');

        for k = 1:length(analogLabels);
            fprintf(fid, '%s', eval(['''' char(analogLabels(k)) ',''']));
        end

        for j = 1:numberOfEvents
            fprintf(fid, '\n');
            filteredAnalogDataAtThisEvent = filteredAnalogData(round(Events.Indexes(j)* analogFrameRate),:)';
            fprintf(fid, '%s,', char(eventNames(j)));
            fprintf(fid, '%6.2f,', (Events.Indexes(j)));
            fprintf(fid, '%6.0f,', Events.Indexes(j)* analogFrameRate);
            fprintf(fid, eval(['''' analogSpecifiers '''']), filteredAnalogDataAtThisEvent');
        end
        fclose(fid);
    end


    %%   Extract cycles and phases from entire time histories of data
    warning off
    for j = 1:handles.numberOfPhasesAndCycles   % keep time base
        if processAnalog == 1;
            startPeriodAnalog(j) = round(eventTimes(handles.phasesAndCycles(j).startEventIndex) * analogFrameRate);
            endPeriodAnalog(j) = round(eventTimes(handles.phasesAndCycles(j).endEventIndex) * analogFrameRate);
            cyclePeriodAnalog = [startPeriodAnalog(j): endPeriodAnalog(j)];
        end
        if process3d == 1
            startPeriod3d(j) = round(eventTimes(handles.phasesAndCycles(j).startEventIndex) * videoFrameRate);
            endPeriod3d(j) = round(eventTimes(handles.phasesAndCycles(j).endEventIndex) * videoFrameRate);
            cyclePeriod3d = [startPeriod3d(j): endPeriod3d(j)];
        end

        if handles.outputNonTempNormData
            if process3d == 1

                %%   Write non-temporally normalised complete 3d variables file for all phases
                cd(completeDir)
                eval(['complete3d_' handles.phasesAndCycles(j).Names '_time = complete3dArray(cyclePeriod3d(1): cyclePeriod3d(end),:);'])
                fid = fopen(eval(['''' outputFilePrefix '_3d_' handles.phasesAndCycles(j).Names '_time.csv''']), 'w');
                fprintf(fid, '%s', 'Original file: ');
                fprintf(fid, '%s', fullFileName);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Date processed: ');
                fprintf(fid, '%s', date);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                fprintf(fid, '%6.2f', startPeriod3d(j)/videoFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'End of phase/cycle with respect to start of entire trial [s]: ');
                fprintf(fid, '%6.2f', endPeriod3d(j)/videoFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Video sampling rate (Hz): ');
                fprintf(fid, '%6.2f', videoFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                fprintf(fid, '\n');
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Frame,');
                fprintf(fid, '%s', 'Time [s],');

                for k = 1:numCompleteOutputNames;
                    fprintf(fid, '%s', eval(['''' char(completeOutputNames(k)) ',''']));
                end

                outputData = [cyclePeriod3d', ((cyclePeriod3d-startPeriod3d(j))/videoFrameRate)',...
                    eval(['complete3d_' handles.phasesAndCycles(j).Names '_time'])];
                fprintf(fid, '\n');
                fprintf(fid, eval(['''' complete3dSpecifiers '''']), outputData');
                fclose(fid);

                %%   Write non-temporally normalised custom 3d variables file for all phases
                cd(customDir)
                eval(['custom3d_' handles.phasesAndCycles(j).Names '_time = custom3dArray(cyclePeriod3d(1): cyclePeriod3d(end),:);'])
                fid = fopen(eval(['''' outputFilePrefix '_3d_' handles.phasesAndCycles(j).Names '_time.csv''']), 'w');
                fprintf(fid, '%s', 'Original file: ');
                fprintf(fid, '%s', fullFileName);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Date processed: ');
                fprintf(fid, '%s', date);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                fprintf(fid, '%6.2f', startPeriod3d(j)/videoFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'End of phase/cycle with respect to start of entire trial [s]: ');
                fprintf(fid, '%6.2f', endPeriod3d(j)/videoFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Video sampling rate (Hz): ');
                fprintf(fid, '%6.2f', videoFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                fprintf(fid, '\n');
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Frame,');
                fprintf(fid, '%s', 'Time [s],');

                for k = 1:numCustomOutputNames;
                    fprintf(fid, '%s', eval(['''' char(customOutputNames(k)) ',''']));
                end

                outputData = [cyclePeriod3d', ((cyclePeriod3d-startPeriod3d(j))/videoFrameRate)',...
                    eval(['custom3d_' handles.phasesAndCycles(j).Names '_time'])];
                fprintf(fid, '\n');
                fprintf(fid, eval(['''' custom3dSpecifiers '''']), outputData');
                fclose(fid);
            end
            if processAnalog
                cd(analogDir);
                if handles.filterAnalog
                    %%   Write non-temporally normalised filtered analog data to file for all phases

                    eval(['filteredAnalogData_' handles.phasesAndCycles(j).Names...
                        '_time = filteredAnalogData(cyclePeriodAnalog(1):cyclePeriodAnalog(end),:);'])
                    fid = fopen(eval(['''' outputFilePrefix '_filteredAnalog_' handles.phasesAndCycles(j).Names '_time.csv''']), 'w');
                    fprintf(fid, '%s', 'Original file: ');
                    fprintf(fid, '%s', fullFileName);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Date processed: ');
                    fprintf(fid, '%s', date);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                    fprintf(fid, '%6.2f', startPeriodAnalog(j)/analogFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'End of phase/cycle with respect to entire trial [s]: ');
                    fprintf(fid, '%6.2f', endPeriodAnalog(j)/analogFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Video sampling rate (Hz): ');
                    fprintf(fid, '%6.2f', analogFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                    fprintf(fid, '\n');
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Frame,');
                    fprintf(fid, '%s', 'Time [s],');
                    for k = 1:length(analogLabels);
                        fprintf(fid, '%s', eval(['''' char(analogLabels(k)) ',''']));
                    end
                    fprintf(fid, '\n');
                    outputData = [cyclePeriodAnalog',((cyclePeriodAnalog-startPeriodAnalog(j))/analogFrameRate)',...
                        eval(['filteredAnalogData_' handles.phasesAndCycles(j).Names '_time'])];
                    fprintf(fid, eval(['''' analogSpecifiers '''']), outputData');
                    fclose(fid);
                end
                %%   Write non-temporally raw analog data to file for all phases
                eval(['analogData_' handles.phasesAndCycles(j).Names...
                    '_time = analogData(cyclePeriodAnalog(1):cyclePeriodAnalog(end), :);'])
                fid = fopen(eval(['''' outputFilePrefix '_analog_' handles.phasesAndCycles(j).Names '_time.csv''']), 'w');
                fprintf(fid, '%s', 'Original file: ');
                fprintf(fid, '%s', fullFileName);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Date processed: ');
                fprintf(fid, '%s', date);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                fprintf(fid, '%6.2f', startPeriodAnalog(j)/analogFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'End of phase/cycle with respect to entire trial [s]: ');
                fprintf(fid, '%6.2f', endPeriodAnalog(j)/analogFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Analog sampling rate (Hz): ');
                fprintf(fid, '%6.2f', analogFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                fprintf(fid, '\n');
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Frame,');
                fprintf(fid, '%s', 'Time [s],');
                for k = 1:length(analogLabels);
                    fprintf(fid, '%s', eval(['''' char(analogLabels(k)) ',''']));
                end
                fprintf(fid, '\n');
                fprintf(fid, '\n');
                outputData = [cyclePeriodAnalog', ((cyclePeriodAnalog-startPeriodAnalog(j))/analogFrameRate)',...
                    eval(['analogData_' handles.phasesAndCycles(j).Names '_time'])];
                fprintf(fid, eval(['''' analogSpecifiers '''']), outputData');
                fclose(fid);
            end
        end


        if handles.outputTempNormData
            if processAnalog == 1
                stepAnalog = (endPeriodAnalog(j) - startPeriodAnalog(j)) / (handles.numTempNormDataPoints-1);
                tempNormalisedAnalogCycleVector = startPeriodAnalog(j):stepAnalog:endPeriodAnalog(j);
            end
            if process3d == 1
                step3d = (endPeriod3d(j) - startPeriod3d(j)) / (handles.numTempNormDataPoints-1);
                tempNormalised3dCycleVector = startPeriod3d(j):step3d:endPeriod3d(j);
            end

            if process3d == 1
                %%  Write temporally normalised complete 3d data to file for all phases
                cd(completeDir);
                eval(['complete3d_' handles.phasesAndCycles(j).Names '_' ...
                    num2str(handles.numTempNormDataPoints)...
                    '(:,:) = interp1(cyclePeriod3d, complete3dArray(cyclePeriod3d(1):cyclePeriod3d(end), :), tempNormalised3dCycleVector, ''v5cubic'');'])
                fid = fopen(eval(['''' outputFilePrefix '_3d_' handles.phasesAndCycles(j).Names '_' num2str(handles.numTempNormDataPoints) '.csv''']), 'w');
                fprintf(fid, '%s', 'Original file: ');
                fprintf(fid, '%s', fullFileName);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Date processed: ');
                fprintf(fid, '%s', date);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                fprintf(fid, '%6.2f', startPeriod3d(j)/videoFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'End of phase/cycle with respect to start of entire trial [s]: ');
                fprintf(fid, '%6.2f', endPeriod3d(j)/videoFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Video sampling rate (Hz): ');
                fprintf(fid, '%6.2f', videoFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                fprintf(fid, '\n');
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Frame,');
                fprintf(fid, '%s', '% of phase/cycle,');
                for k = 1:numCompleteOutputNames;
                    fprintf(fid, '%s', eval(['''' char(completeOutputNames(k)) ',''']));
                end
                outputData = [NaN(handles.numTempNormDataPoints, 1),...
                    [0:100/(handles.numTempNormDataPoints-1):100]',...
                    eval(['complete3d_' handles.phasesAndCycles(j).Names '_' num2str(handles.numTempNormDataPoints)])];
                fprintf(fid, '\n');
                fprintf(fid, eval(['''' complete3dSpecifiers '''']), outputData');
                fclose(fid);


                %%  Write temporally normalised custom 3d data to file for all phases
                cd(customDir);
                eval(['custom3d_' handles.phasesAndCycles(j).Names '_' ...
                    num2str(handles.numTempNormDataPoints)...
                    '(:,:) = interp1(cyclePeriod3d, custom3dArray(cyclePeriod3d(1):cyclePeriod3d(end), :), tempNormalised3dCycleVector, ''v5cubic'');'])
                fid = fopen(eval(['''' outputFilePrefix '_3d_' handles.phasesAndCycles(j).Names '_' num2str(handles.numTempNormDataPoints) '.csv''']), 'w');
                fprintf(fid, '%s', 'Original file: ');
                fprintf(fid, '%s', fullFileName);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Date processed: ');
                fprintf(fid, '%s', date);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                fprintf(fid, '%6.2f', startPeriod3d(j)/videoFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'End of phase/cycle with respect to start of entire trial [s]: ');
                fprintf(fid, '%6.2f', endPeriod3d(j)/videoFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Video sampling rate (Hz): ');
                fprintf(fid, '%6.2f', videoFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                fprintf(fid, '\n');
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Frame,');
                fprintf(fid, '%s', '% of phase/cycle,');

                for k = 1:numCustomOutputNames;
                    fprintf(fid, '%s', eval(['''' char(customOutputNames(k)) ',''']));
                end
                outputData = [NaN(handles.numTempNormDataPoints, 1),...
                    [0:100/(handles.numTempNormDataPoints-1):100]',...
                    eval(['custom3d_' handles.phasesAndCycles(j).Names '_' num2str(handles.numTempNormDataPoints)])];
                fprintf(fid, '\n');
                fprintf(fid, eval(['''' custom3dSpecifiers '''']), outputData');
                fclose(fid);
            end


            if processAnalog == 1
                cd(analogDir);
                if handles.filterAnalog
                    %%  Write temporally normalised filtered analog data to file for all phases
                    eval(['filteredAnalogData_' handles.phasesAndCycles(j).Names...
                        '_' num2str(handles.numTempNormDataPoints)...
                        ' = interp1(cyclePeriodAnalog, filteredAnalogData(cyclePeriodAnalog(1):cyclePeriodAnalog(end), :), tempNormalisedAnalogCycleVector, ''v5cubic'', ''extrap'');'])
                    fid = fopen(eval(['''' outputFilePrefix '_filteredAnalogData_' handles.phasesAndCycles(j).Names '_' num2str(handles.numTempNormDataPoints) '.csv''']), 'w');
                    fprintf(fid, '%s', 'Original file: ');
                    fprintf(fid, '%s', fullFileName);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Date processed: ');
                    fprintf(fid, '%s', date);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                    fprintf(fid, '%6.2f', startPeriodAnalog(j)/analogFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'End of phase/cycle with respect to entire trial [s]: ');
                    fprintf(fid, '%6.2f', endPeriodAnalog(j)/analogFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Analog sampling rate (Hz): ');
                    fprintf(fid, '%6.2f', analogFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                    fprintf(fid, '\n');
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Frame,');
                    fprintf(fid, '%s', '% of phase/cycle,');
                    for k = 1:length(analogLabels);
                        fprintf(fid, '%s', eval(['''' char(analogLabels(k)) ',''']));
                    end
                    fprintf(fid, '\n');
                    outputData = [NaN(handles.numTempNormDataPoints, 1), [0:100/(handles.numTempNormDataPoints-1):100]',...
                        eval(['filteredAnalogData_' handles.phasesAndCycles(j).Names '_'...
                        num2str(handles.numTempNormDataPoints)])];
                    fprintf(fid, '\n');
                    fprintf(fid, eval(['''' analogSpecifiers '''']), outputData');
                    fclose(fid);
                end
                %%  Write temporally normalised raw analog data to file for all phases
                eval(['analogData_' handles.phasesAndCycles(j).Names...
                    '_' num2str(handles.numTempNormDataPoints)...
                    ' = interp1(cyclePeriodAnalog, analogData(cyclePeriodAnalog(1):cyclePeriodAnalog(end), :), tempNormalisedAnalogCycleVector, ''v5cubic'', ''extrap'');'])
                fid = fopen(eval(['''' outputFilePrefix '_analog_' handles.phasesAndCycles(j).Names '_' num2str(handles.numTempNormDataPoints) '.csv''']), 'w');
                fprintf(fid, '%s', 'Original file: ');
                fprintf(fid, '%s', fullFileName);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Date processed: ');
                fprintf(fid, '%s', date);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                fprintf(fid, '%6.2f', startPeriodAnalog(j)/analogFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'End of phase/cycle with respect to entire trial [s]: ');
                fprintf(fid, '%6.2f', endPeriodAnalog(j)/analogFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Analog sampling rate (Hz): ');
                fprintf(fid, '%6.2f', analogFrameRate);
                fprintf(fid, '\n');
                fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                fprintf(fid, '\n');
                fprintf(fid, '\n');
                fprintf(fid, '%s', 'Frame,');
                fprintf(fid, '%s', '% of phase/cycle,');
                for k = 1:length(analogLabels);
                    fprintf(fid, '%s', eval(['''' char(analogLabels(k)) ',''']));
                end
                fprintf(fid, '\n');
                outputData = [NaN(handles.numTempNormDataPoints, 1), [0:100/(handles.numTempNormDataPoints-1):100]',...
                    eval(['analogData_' handles.phasesAndCycles(j).Names '_'...
                    num2str(handles.numTempNormDataPoints)])];
                fprintf(fid, '\n');
                fprintf(fid, eval(['''' analogSpecifiers '''']), outputData');
                fclose(fid);
            end
        end
        for i = 1:numberOfEvents
            if eventTimes(i)< eventTimes(handles.phasesAndCycles(j).startEventIndex)
                eventIn.event(i).phase(j).time = (-999);
                eventIn.event(i).phase(j).pct = (-999);
            elseif eventTimes(i)> eventTimes(handles.phasesAndCycles(j).endEventIndex)
                eventIn.event(i).phase(j).time = (-999);
                eventIn.event(i).phase(j).pct = (-999);
            else
                eventIn.event(i).phase(j).time = ...
                    eventTimes(i)- eventTimes(handles.phasesAndCycles(j).startEventIndex);
                eventIn.event(i).phase(j).pct = (eventIn.event(i).phase(j).time/...
                    (eventTimes(handles.phasesAndCycles(j).endEventIndex) -...
                    eventTimes(handles.phasesAndCycles(j).startEventIndex)))*100;
            end
            
        end
    end

    fopen([handles.filePath '/' outputDirName '/EventsInPhases.csv'],'w+')
    fprintf(fid, '%s', 'Original file: ');
    fprintf(fid, '%s', fullFileName);
    fprintf(fid, '\n');
    fprintf(fid, '%s', 'Date processed: ');
    fprintf(fid, '%s', date);
    fprintf(fid, '\n');
    fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
    fprintf(fid, '\n');
    fprintf(fid, '%s', '-999 indicates the event did not occur within the phase of interst');
    fprintf(fid, '\n');
    fprintf(fid, '\n');
    fprintf(fid, '%s', 'Phase,StartEvent,EndEvent,');
    for j = 1:numberOfEvents
        fprintf(fid,'%s',[char(eventNames(j)) '_Time,']);
        fprintf(fid,'%s',[char(eventNames(j)) '_Pct,']);
    end
    fprintf(fid, '\n');
    for j = 1:handles.numberOfPhasesAndCycles
        fprintf(fid, '%s', [char(handles.phasesAndCycles(j).Names) ',']);
        fprintf(fid, '%s', [char(handles.phasesAndCycles(j).Start) ',']);
        fprintf(fid, '%s', [char(handles.phasesAndCycles(j).End) ',']);
        for i = 1:numberOfEvents
            fprintf(fid, '%6.2f,%6.2f', eventIn.event(i).phase(j).time);
            fprintf(fid, '%6.0f,%6.0f', eventIn.event(i).phase(j).pct);
        end
        fprintf(fid, '\n');
    end
    fclose(fid)
    
    %   ----- Calculate discrete variables if required
    %   Full time series kindata descriptive statistics
    if process3d == 1
        if handles.calcMaxMag3d || handles.calcMaxTime3d || handles.calcMinMag3d || handles.calcMinTime3d ||...
                handles.calcAbsMaxMag3d || handles.calcAbsMaxTime3d || handles.calcRange3d || ...
                handles.calcMean3d || handles.calcMedian3d || handles.calcDuration3d || handles.calcStd3d

            %%  Write temporally normalised complete 3d descriptives to file for trial
            cd(completeDir);
            fid = fopen(eval(['''' outputFilePrefix '_descriptive3d.csv''']), 'w');
            fprintf(fid, '%s', 'Original file: ');
            fprintf(fid, '%s', fullFileName);
            fprintf(fid, '\n');
            fprintf(fid, '%s', 'Date processed: ');
            fprintf(fid, '%s', date);
            fprintf(fid, '\n');
            fprintf(fid, '%s', 'Video sampling rate (Hz): ');
            fprintf(fid, '%6.2f', videoFrameRate);
            fprintf(fid, '\n');
            fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
            fprintf(fid, '\n');
            fprintf(fid, '\n');
            fprintf(fid, '%s', ',');

            for k = 1:numCompleteOutputNames;
                fprintf(fid, '%s', eval(['''' char(completeOutputNames(k)) ',''']));
            end

            fprintf(fid, '\n');
            if handles.calcMaxMag3d | handles.calcMaxTime3d
                [max3d indexMax3d] = nanmax(complete3dArray);
                fprintf(fid, '%s', 'Maximum');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' complete3dSpecifiers '''']), max3d);
                if handles.calcMaxTime3d
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', '  Time [s],');
                    fprintf(fid, eval(['''' complete3dSpecifiers '''']), indexMax3d/videoFrameRate);
                end
                fprintf(fid, '\n');
            end

            if handles.calcAbsMaxMag3d | handles.calcAbsMaxTime3d
                [absMax3d indexAbsMax3d] = nanmax(abs(complete3dArray));
                fprintf(fid, '%s', 'Abs Maximum');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' complete3dSpecifiers '''']), absMax3d);
                if handles.calcMaxTime3d
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', '  Time [s],');
                    fprintf(fid, eval(['''' complete3dSpecifiers '''']), indexAbsMax3d/videoFrameRate);
                end
                fprintf(fid, '\n');
            end

            if handles.calcMinMag3d | handles.calcMinTime3d
                [min3d indexMin3d] = nanmin(complete3dArray);
                fprintf(fid, '%s', 'Minimum');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' complete3dSpecifiers '''']), min3d);
                if handles.calcMaxTime3d
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', '  Time [s],');
                    fprintf(fid, eval(['''' complete3dSpecifiers '''']), indexMin3d/videoFrameRate);
                end
                fprintf(fid, '\n');
            end

            if handles.calcMean3d
                mean3d  = nanmean(complete3dArray);
                fprintf(fid, '%s', 'Mean');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' complete3dSpecifiers '''']), mean3d);
                fprintf(fid, '\n');
            end

            if handles.calcMedian3d
                median3d  = nanmedian(complete3dArray);
                fprintf(fid, '%s', 'Median');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' complete3dSpecifiers '''']), median3d);
                fprintf(fid, '\n');
            end

            if handles.calcStd3d
                std3d  = nanstd(complete3dArray);
                fprintf(fid, '%s', 'Std');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' complete3dSpecifiers '''']), std3d);
                fprintf(fid, '\n');
            end

            if handles.calcDuration3d
                duration3d  = length(complete3dArray)/videoFrameRate;
                fprintf(fid, '%s', 'Duration');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' complete3dSpecifiers '''']), duration3d);
                fprintf(fid, '\n');
            end

            if handles.calcRange3d
                range3d  = range(complete3dArray);
                fprintf(fid, '%s', 'Range');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' complete3dSpecifiers '''']), range3d);
            end
            fclose(fid);


            %%  Write temporally normalised custom 3d descriptives to file for trial
            cd(customDir);
            fid = fopen(eval(['''' outputFilePrefix '_descriptive3d.csv''']), 'w');
            fprintf(fid, '%s', 'Original file: ');
            fprintf(fid, '%s', fullFileName);
            fprintf(fid, '\n');
            fprintf(fid, '%s', 'Date processed: ');
            fprintf(fid, '%s', date);
            fprintf(fid, '\n');
            fprintf(fid, '%s', 'Video sampling rate (Hz): ');
            fprintf(fid, '%6.2f', videoFrameRate);
            fprintf(fid, '\n');
            fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
            fprintf(fid, '\n');
            fprintf(fid, '\n');
            fprintf(fid, '%s', ',');

            for k = 1:numCustomOutputNames;
                fprintf(fid, '%s', eval(['''' char(customOutputNames(k)) ',''']));
            end

            fprintf(fid, '\n');
            if handles.calcMaxMag3d || handles.calcMaxTime3d
                [max3d indexMax3d] = nanmax(custom3dArray);
                fprintf(fid, '%s', 'Maximum');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' custom3dSpecifiers '''']), max3d);
                if handles.calcMaxTime3d
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', '  Time [s],');
                    fprintf(fid, eval(['''' custom3dSpecifiers '''']), indexMax3d/videoFrameRate);
                end
                fprintf(fid, '\n');
            end

            if handles.calcAbsMaxMag3d || handles.calcAbsMaxTime3d
                [absMax3d indexAbsMax3d] = nanmax(abs(custom3dArray));
                fprintf(fid, '%s', 'Abs Maximum');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' custom3dSpecifiers '''']), absMax3d);
                if handles.calcMaxTime3d
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', '  Time [s],');
                    fprintf(fid, eval(['''' custom3dSpecifiers '''']), indexAbsMax3d/videoFrameRate);
                end
                fprintf(fid, '\n');
            end
            if handles.calcMinMag3d || handles.calcMinTime3d
                [min3d indexMin3d] = nanmin(custom3dArray);
                fprintf(fid, '%s', 'Minimum');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' custom3dSpecifiers '''']), min3d);
                if handles.calcMaxTime3d
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', '  Time [s],');
                    fprintf(fid, eval(['''' custom3dSpecifiers '''']), indexMin3d/videoFrameRate);
                end
                fprintf(fid, '\n');
            end

            if handles.calcMean3d
                mean3d  = nanmean(custom3dArray);
                fprintf(fid, '%s', 'Mean');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' custom3dSpecifiers '''']), mean3d);
                fprintf(fid, '\n');
            end

            if handles.calcMedian3d
                median3d  = nanmedian(custom3dArray);
                fprintf(fid, '%s', 'Median');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' custom3dSpecifiers '''']), median3d);
                fprintf(fid, '\n');
            end

            if handles.calcStd3d
                std3d  = nanstd(custom3dArray);
                fprintf(fid, '%s', 'Std');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' custom3dSpecifiers '''']), std3d);
                fprintf(fid, '\n');
            end

            if handles.calcDuration3d
                duration3d  = length(custom3dArray)/videoFrameRate;
                fprintf(fid, '%s', 'Duration');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' custom3dSpecifiers '''']), duration3d);
                fprintf(fid, '\n');
            end

            if handles.calcRange3d
                range3d  = range(custom3dArray);
                fprintf(fid, '%s', 'Range');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' custom3dSpecifiers '''']), range3d);
            end
            fclose(fid);
        end
    end

    %%  Full time series filtered analog data descriptive statistics
    %   Filtered analog data
    if handles.processAnalog
        cd(analogDir);
        if handles.filterAnalog
            fid = fopen(eval(['''' outputFilePrefix '_descriptiveFilteredAnalog.csv''']), 'w');
            fprintf(fid, '%s', 'Original file: ');
            fprintf(fid, '%s', fullFileName);
            fprintf(fid, '\n');
            fprintf(fid, '%s', 'Date processed: ');
            fprintf(fid, '%s', date);
            fprintf(fid, '\n');
            fprintf(fid, '%s', 'Analog sampling rate (Hz): ');
            fprintf(fid, '%6.2f', analogFrameRate);
            fprintf(fid, '\n');
            fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
            fprintf(fid, '\n');
            fprintf(fid, '\n');
            fprintf(fid, '%s', ',');
            for k = 1:length(analogLabels);
                fprintf(fid, '%s', eval(['''' char(analogLabels(k)) ',''']));
            end
            fprintf(fid, '\n');
            if handles.calcMaxMagAnalog || handles.calcMaxTimeAnalog
                [maxFilteredAnalogData indexMaxFilteredAnalogData] = nanmax(filteredAnalogData);
                fprintf(fid, '%s', 'Maximum');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' analogSpecifiers '''']), maxFilteredAnalogData);
                if handles.calcMaxTimeAnalog
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', '  Time [s],');
                    fprintf(fid, eval(['''' analogSpecifiers '''']), indexMaxFilteredAnalogData/analogFrameRate);
                end
                fprintf(fid, '\n');
            end

            if handles.calcAbsMaxMagAnalog || handles.calcAbsMaxTimeAnalog
                [absMaxFilteredAnalogData indexAbsMaxFilteredAnalogData] = nanmax(abs(filteredAnalogData));
                fprintf(fid, '%s', 'Abs Maximum');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' analogSpecifiers '''']), absMaxFilteredAnalogData);
                if handles.calcMaxTimeAnalog
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', '  Time [s],');
                    fprintf(fid, eval(['''' analogSpecifiers '''']), indexAbsMaxFilteredAnalogData/analogFrameRate);
                end
                fprintf(fid, '\n');
            end

            if handles.calcMinMagAnalog || handles.calcMinTimeAnalog
                [minFilteredAnalogData indexMinFilteredAnalogData] = nanmin(filteredAnalogData);
                fprintf(fid, '%s', 'Minimum');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' analogSpecifiers '''']), minFilteredAnalogData);
                if handles.calcMinTimeAnalog
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', '  Time [s],');
                    fprintf(fid, eval(['''' analogSpecifiers '''']), indexMinFilteredAnalogData/analogFrameRate);
                end
                fprintf(fid, '\n');
            end

            if handles.calcMeanAnalog
                meanFilteredAnalogData  = nanmean(filteredAnalogData);
                fprintf(fid, '%s', 'Mean');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' analogSpecifiers '''']), meanFilteredAnalogData);
                fprintf(fid, '\n');
            end

            if handles.calcMedianAnalog
                medianFilteredAnalogData  = nanmedian(filteredAnalogData);
                fprintf(fid, '%s', 'Median');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' analogSpecifiers '''']), medianFilteredAnalogData);
                fprintf(fid, '\n');
            end

            if handles.calcStdAnalog
                stdFilteredAnalogData  = nanstd(filteredAnalogData);
                fprintf(fid, '%s', 'Std');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' analogSpecifiers '''']), stdFilteredAnalogData);
                fprintf(fid, '\n');
            end

            if handles.calcDurationAnalog
                durationFilteredAnalogData  = length(filteredAnalogData)/analogFrameRate;
                fprintf(fid, '%s', 'Duration');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' analogSpecifiers '''']), durationFilteredAnalogData);
                fprintf(fid, '\n');
            end

            if handles.calcRangeAnalog
                rangeFilteredAnalogData  = range(filteredAnalogData);
                fprintf(fid, '%s', 'Range');
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Magnitude,');
                fprintf(fid, eval(['''' analogSpecifiers '''']), rangeFilteredAnalogData);
            end
            fclose(fid);
        end

        %%  Full time series raw analog data descriptive statistics
        fid = fopen(eval(['''' outputFilePrefix '_descriptiveAnalog.csv''']), 'w');
        fprintf(fid, '%s', 'Original file: ');
        fprintf(fid, '%s', fullFileName);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Date processed: ');
        fprintf(fid, '%s', date);
        fprintf(fid, '\n');
        fprintf(fid, '%s', 'Analog sampling rate (Hz): ');
        fprintf(fid, '%6.2f', analogFrameRate);
        fprintf(fid, '\n');
        fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
        fprintf(fid, '\n');
        fprintf(fid, '\n');
        fprintf(fid, '%s', ',');
        for k = 1:length(analogLabels);
            fprintf(fid, '%s', eval(['''' char(analogLabels(k)) ',''']));
        end
        fprintf(fid, '\n');

        if handles.calcMaxMagAnalog || handles.calcMaxTimeAnalog
            [maxAnalogData indexMaxAnalogData] = nanmax(analogData);
            fprintf(fid, '%s', 'Maximum');
            fprintf(fid, '\n');
            fprintf(fid, '%s', '  Magnitude,');
            fprintf(fid, eval(['''' analogSpecifiers '''']), maxAnalogData);
            if handles.calcMaxTimeAnalog
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Time [s],');
                fprintf(fid, eval(['''' analogSpecifiers '''']), indexMaxAnalogData/analogFrameRate);
            end
            fprintf(fid, '\n');
        end

        if handles.calcAbsMaxMagAnalog || handles.calcAbsMaxTimeAnalog
            [absMaxAnalogData indexAbsMaxAnalogData] = nanmax(abs(analogData));
            fprintf(fid, '%s', 'Abs Maximum');
            fprintf(fid, '\n');
            fprintf(fid, '%s', '  Magnitude,');
            fprintf(fid, eval(['''' analogSpecifiers '''']), absMaxAnalogData);
            if handles.calcMaxTimeAnalog
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Time [s],');
                fprintf(fid, eval(['''' analogSpecifiers '''']), indexAbsMaxAnalogData/analogFrameRate);
            end
            fprintf(fid, '\n');
        end

        if handles.calcMinMagAnalog || handles.calcMinTimeAnalog
            [minAnalogRowsData indexMinAnalogRowsData] = nanmin(analogData);
            fprintf(fid, '%s', 'Minimum');
            fprintf(fid, '\n');
            fprintf(fid, '%s', '  Magnitude,');
            fprintf(fid, eval(['''' analogSpecifiers '''']), minAnalogRowsData);
            if handles.calcMinTimeAnalog
                fprintf(fid, '\n');
                fprintf(fid, '%s', '  Time [s],');
                fprintf(fid, eval(['''' analogSpecifiers '''']), indexMinAnalogRowsData/analogFrameRate);
            end
            fprintf(fid, '\n');
        end

        if handles.calcMeanAnalog
            meanAnalogData  = nanmean(analogData);
            fprintf(fid, '%s', 'Mean');
            fprintf(fid, '\n');
            fprintf(fid, '%s', '  Magnitude,');
            fprintf(fid, eval(['''' analogSpecifiers '''']), meanAnalogData);
            fprintf(fid, '\n');
        end

        if handles.calcMedianAnalog
            medianAnalogData  = nanmedian(analogData);
            fprintf(fid, '%s', 'Median');
            fprintf(fid, '\n');
            fprintf(fid, '%s', '  Magnitude,');
            fprintf(fid, eval(['''' analogSpecifiers '''']), medianAnalogData);
            fprintf(fid, '\n');
        end

        if handles.calcStdAnalog
            stdAnalogData  = nanstd(analogData);
            fprintf(fid, '%s', 'Std');
            fprintf(fid, '\n');
            fprintf(fid, '%s', '  Magnitude,');
            fprintf(fid, eval(['''' analogSpecifiers '''']), stdAnalogData);
            fprintf(fid, '\n');
        end

        if handles.calcDurationAnalog
            durationAnalogData  = length(analogData)/analogFrameRate;
            fprintf(fid, '%s', 'Duration');
            fprintf(fid, '\n');
            fprintf(fid, '%s', '  Magnitude,');
            fprintf(fid, eval(['''' analogSpecifiers '''']), durationAnalogData);
            fprintf(fid, '\n');
        end

        if handles.calcRangeAnalog
            rangeAnalogData  = range(analogData);
            fprintf(fid, '%s', 'Range');
            fprintf(fid, '\n');
            fprintf(fid, '%s', '  Magnitude,');
            fprintf(fid, eval(['''' analogSpecifiers '''']), rangeAnalogData);
        end
        fclose(fid);
    end

    %   Calculate descriptive statistics for invividual phases for kindata
    if process3d == 1
        if handles.calcMaxMag3d || handles.calcMaxTime3d || handles.calcMinMag3d || handles.calcMinTime3d ||...
                handles.calcAbsMaxMag3d || handles.calcAbsMaxTime3d || handles.calcRange3d
            if handles.outputTempNormData

                %%  Temporally normalised complete 3d descriptive statistics for all phases
                cd(completeDir);
                for j = 1:handles.numberOfPhasesAndCycles;
                    fid = fopen(eval(['''' outputFilePrefix '_descriptive3d_' ...
                        handles.phasesAndCycles(j).Names '_' num2str(handles.numTempNormDataPoints) '.csv''']), 'w');
                    fprintf(fid, '%s', 'Original file: ');
                    fprintf(fid, '%s', fullFileName);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Date processed: ');
                    fprintf(fid, '%s', date);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                    fprintf(fid, '%6.2f', startPeriod3d(j)/videoFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'End of phase/cycle with respect to start of entire trial [s]: ');
                    fprintf(fid, '%6.2f', endPeriod3d(j)/videoFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Video sampling rate (Hz): ');
                    fprintf(fid, '%6.2f', videoFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                    fprintf(fid, '\n');
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', ',');
                    for k = 1:numCompleteOutputNames;
                        fprintf(fid, '%s', eval(['''' char(completeOutputNames(k)) ',''']));
                    end
                    fprintf(fid, '\n');

                    if handles.calcMaxMag3d || handles.calcMaxTime3d
                        eval(['[max3dComplete_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            ', indexMax3dComplete_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '] = nanmax(complete3d_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Maximum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['max3dComplete_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        if handles.calcMaxTime3d
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  % of phase/cycle,');
                            fprintf(fid, eval(['''' complete3dSpecifiers '''']), (eval(['indexMax3dComplete_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)])-1)* 100/(handles.numTempNormDataPoints-1));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcAbsMaxMag3d || handles.calcAbsMaxTime3d
                        eval(['[absMax3dComplete_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            ', indexAbsMax3dComplete_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '] = nanmax(abs(complete3d_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) '));'])
                        fprintf(fid, '%s', 'Absolute Maximum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['absMax3dComplete_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        if handles.calcAbsMaxTime3d
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  % of phase/cycle,');
                            fprintf(fid, eval(['''' complete3dSpecifiers '''']), (eval(['indexAbsMax3dComplete_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)])-1)* 100/(handles.numTempNormDataPoints-1));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcMinMag3d || handles.calcMinTime3d
                        eval(['[min3dComplete_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            ', indexMin3dComplete_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '] = nanmin(complete3d_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Minimum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['min3dComplete_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        if handles.calcMinTime3d
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  % of phase/cycle,');
                            fprintf(fid, eval(['''' complete3dSpecifiers '''']), (eval(['indexMin3dComplete_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)])-1)* 100/(handles.numTempNormDataPoints-1));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcMean3d
                        eval(['mean3dComplete_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '= nanmean(complete3d_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Mean');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['mean3dComplete_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        fprintf(fid, '\n');
                    end

                    if handles.calcMedian3d
                        eval(['median3dComplete_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '= nanmedian(complete3d_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Median');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['median3dComplete_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        fprintf(fid, '\n');
                    end

                    if handles.calcStd3d
                        eval(['std3dComplete_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '= nanstd(complete3d_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Std');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['std3dComplete_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        fprintf(fid, '\n');
                    end

                    if handles.calcDuration3d
                        eval(['duration3dComplete_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '= ' num2str(endPeriod3d(j)/videoFrameRate - startPeriod3d(j)/videoFrameRate) ';'])
                        fprintf(fid, '%s', 'Duration');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['duration3dComplete_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        fprintf(fid, '\n');
                    end

                    if handles.calcRange3d
                        eval(['range3dComplete_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '= range(complete3d_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Range');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['range3dComplete_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        fprintf(fid, '\n');
                    end
                    fclose(fid);
                end
            end

            %%  Non-temporally normalised complete 3d descriptive statistics for all phases
            if handles.outputNonTempNormData
                cd(completeDir);
                for j = 1:handles.numberOfPhasesAndCycles;
                    fid = fopen(eval(['''' outputFilePrefix '_descriptive3d_' handles.phasesAndCycles(j).Names '_time.csv''']), 'w');
                    fprintf(fid, '%s', 'Original file: ');
                    fprintf(fid, '%s', fullFileName);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Date processed: ');
                    fprintf(fid, '%s', date);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                    fprintf(fid, '%6.2f', startPeriod3d(j)/videoFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'End of phase/cycle with respect to start of entire trial [s]: ');
                    fprintf(fid, '%6.2f', endPeriod3d(j)/videoFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Video sampling rate (Hz): ');
                    fprintf(fid, '%6.2f', videoFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                    fprintf(fid, '\n');
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', ',');
                    for k = 1:numCompleteOutputNames;
                        fprintf(fid, '%s', eval(['''' char(completeOutputNames(k)) ',''']));
                    end
                    fprintf(fid, '\n');

                    if handles.calcMaxMag3d || handles.calcMaxTime3d
                        eval(['[max3dComplete_' handles.phasesAndCycles(j).Names...
                            '_time, indexMax3dComplete_' handles.phasesAndCycles(j).Names...
                            '_time] = nanmax(complete3d_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Maximum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['max3dComplete_' handles.phasesAndCycles(j).Names '_time']));
                        if handles.calcMaxTime3d
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Relative time [s],');
                            fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['indexMax3dComplete_' handles.phasesAndCycles(j).Names...
                                '_time/videoFrameRate']));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcAbsMaxMag3d || handles.calcAbsMaxTime3d
                        eval(['[absMax3dComplete_' handles.phasesAndCycles(j).Names...
                            '_time, indexAbsMax3dComplete_' handles.phasesAndCycles(j).Names...
                            '_time] = nanmax(abs(complete3d_' handles.phasesAndCycles(j).Names...
                            '_time));'])
                        fprintf(fid, '%s', 'Absolute Maximum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['absMax3dComplete_' handles.phasesAndCycles(j).Names '_time']));
                        if handles.calcAbsMaxTime3d
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Relative time [s],');
                            fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['indexAbsMax3dComplete_' handles.phasesAndCycles(j).Names...
                                '_time/videoFrameRate']));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcMinMag3d || handles.calcMinTime3d
                        eval(['[min3dComplete_' handles.phasesAndCycles(j).Names...
                            '_time, indexMin3dComplete_' handles.phasesAndCycles(j).Names...
                            '_time] = nanmin(complete3d_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Minimum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['min3dComplete_' handles.phasesAndCycles(j).Names '_time']));
                        if handles.calcMinTime3d
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Relative time [s],');
                            fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['indexMin3dComplete_' handles.phasesAndCycles(j).Names '_time/videoFrameRate']));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcMean3d
                        eval(['mean3dComplete_' handles.phasesAndCycles(j).Names '_time = nanmean(complete3d_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Mean');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['mean3dComplete_' handles.phasesAndCycles(j).Names '_time']));
                        fprintf(fid, '\n');
                    end

                    if handles.calcMedian3d
                        eval(['median3dComplete_' handles.phasesAndCycles(j).Names '_time = nanmedian(complete3d_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Median');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['median3dComplete_' handles.phasesAndCycles(j).Names '_time']));
                        fprintf(fid, '\n');
                    end

                    if handles.calcStd3d
                        eval(['std3dComplete_' handles.phasesAndCycles(j).Names '_time = nanstd(complete3d_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Std');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['std3dComplete_' handles.phasesAndCycles(j).Names '_time']));
                        fprintf(fid, '\n');
                    end

                    if handles.calcDuration3d
                        eval(['duration3dComplete_' handles.phasesAndCycles(j).Names '_time = ' num2str(endPeriod3d(j)/videoFrameRate - startPeriod3d(j)/videoFrameRate) ';'])
                        fprintf(fid, '%s', 'Duration');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['duration3dComplete_' handles.phasesAndCycles(j).Names '_time']));
                        fprintf(fid, '\n');
                    end

                    if handles.calcRange3d
                        eval(['range3dComplete_' handles.phasesAndCycles(j).Names '_time = range(complete3d_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Range');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' complete3dSpecifiers '''']), eval(['range3dComplete_' handles.phasesAndCycles(j).Names '_time']));
                        fprintf(fid, '\n');
                    end
                    fclose(fid);
                end
            end
            %%  Temporally normalised custom 3d descriptive statistics for all phases
            if handles.outputTempNormData
                cd(customDir);
                for j = 1:handles.numberOfPhasesAndCycles;
                    fid = fopen(eval(['''' outputFilePrefix '_descriptive3d_' ...
                        handles.phasesAndCycles(j).Names '_' num2str(handles.numTempNormDataPoints) '.csv''']), 'w');
                    fprintf(fid, '%s', 'Original file: ');
                    fprintf(fid, '%s', fullFileName);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Date processed: ');
                    fprintf(fid, '%s', date);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                    fprintf(fid, '%6.2f', startPeriod3d(j)/videoFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'End of phase/cycle with respect to start of entire trial [s]: ');
                    fprintf(fid, '%6.2f', endPeriod3d(j)/videoFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Video sampling rate (Hz): ');
                    fprintf(fid, '%6.2f', videoFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                    fprintf(fid, '\n');
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', ',');
                    for k = 1:numCustomOutputNames;
                        fprintf(fid, '%s', eval(['''' char(customOutputNames(k)) ',''']));
                    end
                    fprintf(fid, '\n');

                    if handles.calcMaxMag3d || handles.calcMaxTime3d
                        eval(['[max3dCustom_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            ', indexMax3dCustom_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '] = nanmax(custom3d_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Maximum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['max3dCustom_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        if handles.calcMaxTime3d
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  % of phase/cycle,');
                            fprintf(fid, eval(['''' custom3dSpecifiers '''']), (eval(['indexMax3dCustom_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)])-1)* 100/(handles.numTempNormDataPoints-1));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcAbsMaxMag3d || handles.calcAbsMaxTime3d
                        eval(['[absMax3dCustom_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            ', indexAbsMax3dCustom_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '] = nanmax(abs(custom3d_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) '));'])
                        fprintf(fid, '%s', 'Absolute Maximum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['absMax3dCustom_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        if handles.calcAbsMaxTime3d
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  % of phase/cycle,');
                            fprintf(fid, eval(['''' custom3dSpecifiers '''']), (eval(['indexAbsMax3dCustom_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)])-1)* 100/(handles.numTempNormDataPoints-1));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcMinMag3d || handles.calcMinTime3d
                        eval(['[min3dCustom_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            ', indexMin3dCustom_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '] = nanmin(custom3d_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Minimum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['min3dCustom_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        if handles.calcMinTime3d
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  % of phase/cycle,');
                            fprintf(fid, eval(['''' custom3dSpecifiers '''']), (eval(['indexMin3dCustom_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)])-1)* 100/(handles.numTempNormDataPoints-1));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcMean3d
                        eval(['mean3dCustom_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '= nanmean(custom3d_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Mean');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['mean3dCustom_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        fprintf(fid, '\n');
                    end

                    if handles.calcMedian3d
                        eval(['median3dCustom_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '= nanmedian(custom3d_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Median');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['median3dCustom_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        fprintf(fid, '\n');
                    end

                    if handles.calcStd3d
                        eval(['std3dCustom_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '= nanstd(custom3d_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Std');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['std3dCustom_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        fprintf(fid, '\n');
                    end

                    if handles.calcDuration3d
                        eval(['duration3dCustom_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '= ' num2str(endPeriod3d(j)/videoFrameRate - startPeriod3d(j)/videoFrameRate) ';'])
                        fprintf(fid, '%s', 'Duration');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['duration3dCustom_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        fprintf(fid, '\n');
                    end

                    if handles.calcRange3d
                        eval(['range3dCustom_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '= range(custom3d_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Range');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['range3dCustom_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        fprintf(fid, '\n');
                    end
                    fclose(fid);
                end
            end

            %%  Non-temporally normalised complete 3d descriptive statistics for all phases
            if handles.outputNonTempNormData
                cd(customDir);
                for j = 1:handles.numberOfPhasesAndCycles;
                    fid = fopen(eval(['''' outputFilePrefix '_descriptive3d_' handles.phasesAndCycles(j).Names '_time.csv''']), 'w');
                    fprintf(fid, '%s', 'Original file: ');
                    fprintf(fid, '%s', fullFileName);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Date processed: ');
                    fprintf(fid, '%s', date);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                    fprintf(fid, '%6.2f', startPeriod3d(j)/videoFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'End of phase/cycle with respect to start of entire trial [s]: ');
                    fprintf(fid, '%6.2f', endPeriod3d(j)/videoFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Video sampling rate (Hz): ');
                    fprintf(fid, '%6.2f', videoFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                    fprintf(fid, '\n');
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', ',');
                    for k = 1:numCustomOutputNames;
                        fprintf(fid, '%s', eval(['''' char(customOutputNames(k)) ',''']));
                    end
                    fprintf(fid, '\n');

                    if handles.calcMaxMag3d || handles.calcMaxTime3d
                        eval(['[max3dCustom_' handles.phasesAndCycles(j).Names...
                            '_time, indexMax3dCustom_' handles.phasesAndCycles(j).Names...
                            '_time] = nanmax(custom3d_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Maximum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['max3dCustom_' handles.phasesAndCycles(j).Names '_time']));
                        if handles.calcMaxTime3d
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Relative time [s],');
                            fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['indexMax3dCustom_' handles.phasesAndCycles(j).Names...
                                '_time/videoFrameRate']));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcAbsMaxMag3d || handles.calcAbsMaxTime3d
                        eval(['[absMax3dCustom_' handles.phasesAndCycles(j).Names...
                            '_time, indexAbsMax3dCustom_' handles.phasesAndCycles(j).Names...
                            '_time] = nanmax(abs(custom3d_' handles.phasesAndCycles(j).Names...
                            '_time));'])
                        fprintf(fid, '%s', 'Absolute Maximum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['absMax3dCustom_' handles.phasesAndCycles(j).Names '_time']));
                        if handles.calcAbsMaxTime3d
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Relative time [s],');
                            fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['indexAbsMax3dCustom_' handles.phasesAndCycles(j).Names...
                                '_time/videoFrameRate']));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcMinMag3d || handles.calcMinTime3d
                        eval(['[min3dCustom_' handles.phasesAndCycles(j).Names...
                            '_time, indexMin3dCustom_' handles.phasesAndCycles(j).Names...
                            '_time] = nanmin(custom3d_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Minimum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['min3dCustom_' handles.phasesAndCycles(j).Names '_time']));
                        if handles.calcMinTime3d
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Relative time [s],');
                            fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['indexMin3dCustom_' handles.phasesAndCycles(j).Names '_time/videoFrameRate']));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcMean3d
                        eval(['mean3dCustom_' handles.phasesAndCycles(j).Names '_time = nanmean(custom3d_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Mean');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['mean3dCustom_' handles.phasesAndCycles(j).Names '_time']));
                        fprintf(fid, '\n');
                    end

                    if handles.calcMedian3d
                        eval(['median3dCustom_' handles.phasesAndCycles(j).Names '_time = nanmedian(custom3d_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Median');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['median3dCustom_' handles.phasesAndCycles(j).Names '_time']));
                        fprintf(fid, '\n');
                    end

                    if handles.calcStd3d
                        eval(['std3dCustom_' handles.phasesAndCycles(j).Names '_time = nanstd(custom3d_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Std');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['std3dCustom_' handles.phasesAndCycles(j).Names '_time']));
                        fprintf(fid, '\n');
                    end

                    if handles.calcDuration3d
                        eval(['duration3dCustom_' handles.phasesAndCycles(j).Names '_time = ' num2str(endPeriod3d(j)/videoFrameRate - startPeriod3d(j)/videoFrameRate) ';'])
                        fprintf(fid, '%s', 'Duration');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['duration3dCustom_' handles.phasesAndCycles(j).Names '_time']));
                        fprintf(fid, '\n');
                    end

                    if handles.calcRange3d
                        eval(['range3dCustom_' handles.phasesAndCycles(j).Names '_time = range(custom3d_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Range');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' custom3dSpecifiers '''']), eval(['range3dCustom_' handles.phasesAndCycles(j).Names '_time']));
                        fprintf(fid, '\n');
                    end
                    fclose(fid);
                end
            end
        end % kin descriptive statistic loop
    end % 'process3d' if statement


    %   Calculate descriptive statistics for invividual phases of analog data
    if processAnalog
        cd(analogDir)
        
        if handles.calcMaxMagAnalog || handles.calcMaxTimeAnalog || handles.calcMinMagAnalog || handles.calcMinTimeAnalog ||...
                handles.calcAbsMaxMagAnalog || handles.calcAbsMaxTimeAnalog || handles.calcRangeAnalog

            if handles.filterAnalog
                
                if handles.outputTempNormData

                    %%  Temporally normalised filtered analog descriptive statistics for all phases
                    for j = 1:handles.numberOfPhasesAndCycles;
                        fid = fopen(eval(['''' outputFilePrefix '_descriptiveFilteredAnalogData_' handles.phasesAndCycles(j).Names '_' num2str(handles.numTempNormDataPoints) '.csv''']), 'w');
                        fprintf(fid, '%s', 'Original file: ');
                        fprintf(fid, '%s', fullFileName);
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', 'Date processed: ');
                        fprintf(fid, '%s', date);
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                        fprintf(fid, '%6.2f', startPeriodAnalog(j)/analogFrameRate);
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', 'End of phase/cycle with respect to start of entire trial [s]: ');
                        fprintf(fid, '%6.2f', endPeriodAnalog(j)/analogFrameRate);
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', 'Analog sampling rate (Hz): ');
                        fprintf(fid, '%6.2f', analogFrameRate);
                        fprintf(fid, '\n');
                        fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                        fprintf(fid, '\n');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', ',');
                        for k = 1:length(analogLabels);
                            fprintf(fid, '%s', eval(['''' char(analogLabels(k)) ',''']));
                        end
                        fprintf(fid, '\n');
                        if handles.calcMaxMagAnalog || handles.calcMaxTimeAnalog
                            eval(['[maxFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints)...
                                ', indexMaxFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints)...
                                '] = nanmax(filteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints) ');'])
                            fprintf(fid, '%s', 'Maximum');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['maxFilteredAnalogData_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)]));
                            if handles.calcMaxTimeAnalog
                                fprintf(fid, '\n');
                                fprintf(fid, '%s', '  % of phase/cycle,');
                                fprintf(fid, eval(['''' analogSpecifiers '''']), (eval(['indexMaxFilteredAnalogData_' handles.phasesAndCycles(j).Names '_'...
                                    num2str(handles.numTempNormDataPoints)])-1)* 100/(handles.numTempNormDataPoints-1));
                            end
                            fprintf(fid, '\n');
                        end

                        if handles.calcAbsMaxMagAnalog || handles.calcAbsMaxTimeAnalog
                            eval(['[absMaxFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints)...
                                ', indexAbsMaxFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints)...
                                '] = nanmax(abs(filteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints) '));'])
                            fprintf(fid, '%s', 'Absolute Maximum');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['absMaxFilteredAnalogData_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)]));
                            if handles.calcAbsMaxTimeAnalog
                                fprintf(fid, '\n');
                                fprintf(fid, '%s', '  % of phase/cycle,');
                                fprintf(fid, eval(['''' analogSpecifiers '''']), (eval(['indexAbsMaxFilteredAnalogData_' handles.phasesAndCycles(j).Names '_'...
                                    num2str(handles.numTempNormDataPoints)])-1)* 100/(handles.numTempNormDataPoints-1));
                            end
                            fprintf(fid, '\n');
                        end

                        if handles.calcMinMagAnalog || handles.calcMinTimeAnalog
                            eval(['[minFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints)...
                                ', indexMinFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints)...
                                '] = nanmin(filteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints) ');'])
                            fprintf(fid, '%s', 'Minimum');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['minFilteredAnalogData_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)]));
                            if handles.calcMinTimeAnalog
                                fprintf(fid, '\n');
                                fprintf(fid, '%s', '  % of phase/cycle,');
                                fprintf(fid, eval(['''' analogSpecifiers '''']), (eval(['indexMinFilteredAnalogData_' handles.phasesAndCycles(j).Names '_'...
                                    num2str(handles.numTempNormDataPoints)])-1)* 100/(handles.numTempNormDataPoints-1));
                            end
                            fprintf(fid, '\n');
                        end

                        if handles.calcMeanAnalog
                            eval(['meanFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints)...
                                '= nanmean(filteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints) ');'])
                            fprintf(fid, '%s', 'Mean');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['meanFilteredAnalogData_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)]));
                            fprintf(fid, '\n');
                        end

                        if handles.calcMedianAnalog
                            eval(['medianFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints)...
                                '= nanmedian(filteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints) ');'])
                            fprintf(fid, '%s', 'Median');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['medianFilteredAnalogData_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)]));
                            fprintf(fid, '\n');
                        end

                        if handles.calcStdAnalog
                            eval(['stdFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints)...
                                '= nanstd(filteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints) ');'])
                            fprintf(fid, '%s', 'Std');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['stdFilteredAnalogData_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)]));
                            fprintf(fid, '\n');
                        end

                        if handles.calcDurationAnalog
                            eval(['durationFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints)...
                                '= ' num2str(endPeriodAnalog(j)/analogFrameRate - startPeriodAnalog(j)/analogFrameRate) ';'])
                            fprintf(fid, '%s', 'Duration');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['durationFilteredAnalogData_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)]));
                            fprintf(fid, '\n');
                        end

                        if handles.calcRangeAnalog
                            eval(['rangeFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints)...
                                '= range(filteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_' num2str(handles.numTempNormDataPoints) ');'])
                            fprintf(fid, '%s', 'Range');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['rangeFilteredAnalogData_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)]));
                            fprintf(fid, '\n');
                        end
                        fclose(fid);
                    end
                end %temporally normalised loop for filtered analog

                %%  Non-temporally normalised filtered analog descriptive statistics for all phases
                if handles.outputNonTempNormData
                    cd(analogDir);
                    for j = 1:handles.numberOfPhasesAndCycles;
                        fid = fopen(eval(['''' outputFilePrefix '_descriptiveFilteredAnalogData_' handles.phasesAndCycles(j).Names '_time.csv''']), 'w');
                        fprintf(fid, '%s', 'Original file: ');
                        fprintf(fid, '%s', fullFileName);
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', 'Date processed: ');
                        fprintf(fid, '%s', date);
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                        fprintf(fid, '%6.2f', startPeriodAnalog(j)/analogFrameRate);
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', 'End of phase/cycle with respect to start of entire trial [s]: ');
                        fprintf(fid, '%6.2f', endPeriodAnalog(j)/analogFrameRate);
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', 'Analog sampling rate (Hz): ');
                        fprintf(fid, '%6.2f', analogFrameRate);
                        fprintf(fid, '\n');
                        fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                        fprintf(fid, '\n');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', ',');
                        for k = 1:length(analogLabels);
                            fprintf(fid, '%s', eval(['''' char(analogLabels(k)) ',''']));
                        end
                        fprintf(fid, '\n');
                        if handles.calcMaxMagAnalog || handles.calcMaxTimeAnalog
                            eval(['[maxFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_time, indexMaxFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_time] = nanmax(filteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_time);'])
                            fprintf(fid, '%s', 'Maximum');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['maxFilteredAnalogData_' handles.phasesAndCycles(j).Names '_time']));
                            if handles.calcMaxTimeAnalog
                                fprintf(fid, '\n');
                                fprintf(fid, '%s', '  Relative time [s],');
                                fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['indexMaxFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                    '_time/analogFrameRate']));
                            end
                            fprintf(fid, '\n');
                        end

                        if handles.calcAbsMaxMagAnalog || handles.calcAbsMaxTimeAnalog
                            eval(['[absMaxFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_time, indexAbsMaxFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_time] = nanmax(abs(filteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_time));'])
                            fprintf(fid, '%s', 'Absolute Maximum');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['absMaxFilteredAnalogData_' handles.phasesAndCycles(j).Names '_time']));
                            if handles.calcAbsMaxTimeAnalog
                                fprintf(fid, '\n');
                                fprintf(fid, '%s', '  Relative time [s],');
                                fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['indexAbsMaxFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                    '_time/analogFrameRate']));
                            end
                            fprintf(fid, '\n');
                        end

                        if handles.calcMinMagAnalog || handles.calcMinTimeAnalog
                            eval(['[minFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_time, indexMinFilteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_time] = nanmin(filteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_time);'])
                            fprintf(fid, '%s', 'Minimum');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['minFilteredAnalogData_' handles.phasesAndCycles(j).Names '_time']));
                            if handles.calcMinTimeAnalog
                                fprintf(fid, '\n');
                                fprintf(fid, '%s', '  Relative time [s],');
                                fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['indexMinFilteredAnalogData_' handles.phasesAndCycles(j).Names '_time/analogFrameRate']));
                            end
                            fprintf(fid, '\n');
                        end

                        if handles.calcMeanAnalog
                            eval(['meanFilteredAnalogData_' handles.phasesAndCycles(j).Names '_time = nanmean(filteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_time);'])
                            fprintf(fid, '%s', 'Mean');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['meanFilteredAnalogData_' handles.phasesAndCycles(j).Names '_time']));
                            fprintf(fid, '\n');
                        end

                        if handles.calcMedianAnalog
                            eval(['medianFilteredAnalogData_' handles.phasesAndCycles(j).Names '_time = nanmedian(filteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_time);'])
                            fprintf(fid, '%s', 'Median');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['medianFilteredAnalogData_' handles.phasesAndCycles(j).Names '_time']));
                            fprintf(fid, '\n');
                        end

                        if handles.calcStdAnalog
                            eval(['stdFilteredAnalogData_' handles.phasesAndCycles(j).Names '_time = nanstd(filteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_time);'])
                            fprintf(fid, '%s', 'Std');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['stdFilteredAnalogData_' handles.phasesAndCycles(j).Names '_time']));
                            fprintf(fid, '\n');
                        end

                        if handles.calcDurationAnalog
                            eval(['durationFilteredAnalogData_' handles.phasesAndCycles(j).Names '_time = ' num2str(endPeriodAnalog(j)/analogFrameRate - startPeriodAnalog(j)/analogFrameRate) ';'])
                            fprintf(fid, '%s', 'Duration');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['durationFilteredAnalogData_' handles.phasesAndCycles(j).Names '_time']));
                            fprintf(fid, '\n');
                        end

                        if handles.calcRangeAnalog
                            eval(['rangeFilteredAnalogData_' handles.phasesAndCycles(j).Names '_time = range(filteredAnalogData_' handles.phasesAndCycles(j).Names...
                                '_time);'])
                            fprintf(fid, '%s', 'Range');
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Magnitude,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['rangeFilteredAnalogData_' handles.phasesAndCycles(j).Names '_time']));
                            fprintf(fid, '\n');
                        end
                        fclose(fid);
                    end
                end %non temp norm loop filtered
            end % filtered analog data loop

            %%  Temporally normalised raw analog descriptive statistics for all phases
            for j = 1:handles.numberOfPhasesAndCycles
                if handles.outputTempNormData
                    cd(analogDir);
                    fid = fopen(eval(['''' outputFilePrefix '_descriptiveAnalogData_' handles.phasesAndCycles(j).Names '_' num2str(handles.numTempNormDataPoints) '.csv''']), 'w');
                    fprintf(fid, '%s', 'Original file: ');
                    fprintf(fid, '%s', fullFileName);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Date processed: ');
                    fprintf(fid, '%s', date);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                    fprintf(fid, '%6.2f', startPeriodAnalog(j)/analogFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'End of phase/cycle with respect to start of entire trial [s]: ');
                    fprintf(fid, '%6.2f', endPeriodAnalog(j)/analogFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Analog sampling rate (Hz): ');
                    fprintf(fid, '%6.2f', analogFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                    fprintf(fid, '\n');
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', ',');
                    for k = 1:length(analogLabels);
                        fprintf(fid, '%s', eval(['''' char(analogLabels(k)) ',''']));
                    end
                    fprintf(fid, '\n');
                    if handles.calcMaxMagAnalog || handles.calcMaxTimeAnalog
                        eval(['[maxAnalogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            ', indexMaxAnalogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '] = nanmax(analogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Maximum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['maxAnalogData_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        if handles.calcMaxTimeAnalog
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  % of phase/cycle,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), (eval(['indexMaxAnalogData_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)])-1)* 100/(handles.numTempNormDataPoints-1));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcAbsMaxMagAnalog || handles.calcAbsMaxTimeAnalog
                        eval(['[absMaxAnalogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            ', indexAbsMaxAnalogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '] = nanmax(abs(analogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) '));'])
                        fprintf(fid, '%s', 'Absolute Maximum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['absMaxAnalogData_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        if handles.calcAbsMaxTimeAnalog
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  % of phase/cycle,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), (eval(['indexAbsMaxAnalogData_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)])-1)* 100/(handles.numTempNormDataPoints-1));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcMinMagAnalog || handles.calcMinTimeAnalog
                        eval(['[minAnalogRowsData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            ', indexMinAnalogRowsData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '] = nanmin(analogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Minimum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['minAnalogRowsData_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        if handles.calcMinTimeAnalog
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  % of phase/cycle,');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), (eval(['indexMinAnalogRowsData_' handles.phasesAndCycles(j).Names '_'...
                                num2str(handles.numTempNormDataPoints)])-1)* 100/(handles.numTempNormDataPoints-1));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcMeanAnalog
                        eval(['meanAnalogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '= nanmean(analogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Mean');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['meanAnalogData_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        fprintf(fid, '\n');
                    end

                    if handles.calcMedianAnalog
                        eval(['medianAnalogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '= nanmedian(analogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Median');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['medianAnalogData_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        fprintf(fid, '\n');
                    end

                    if handles.calcStdAnalog
                        eval(['stdAnalogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '= nanstd(analogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Std');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['stdAnalogData_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        fprintf(fid, '\n');
                    end


                    if handles.calcDurationAnalog
                        eval(['durationAnalogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '= ' num2str(endPeriodAnalog(j)/analogFrameRate - startPeriodAnalog(j)/analogFrameRate) ';'])
                        fprintf(fid, '%s', 'Duration');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['durationAnalogData_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        fprintf(fid, '\n');
                    end


                    if handles.calcRangeAnalog
                        eval(['rangeAnalogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints)...
                            '= range(analogData_' handles.phasesAndCycles(j).Names...
                            '_' num2str(handles.numTempNormDataPoints) ');'])
                        fprintf(fid, '%s', 'Range');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['rangeAnalogData_' handles.phasesAndCycles(j).Names '_'...
                            num2str(handles.numTempNormDataPoints)]));
                        fprintf(fid, '\n');
                    end

                    fclose(fid);
                end

                %%  Non-temporally normalised raw analog descriptive statistics for all phases
                if handles.outputNonTempNormData
                    cd(analogDir);
                    fid = fopen(eval(['''' outputFilePrefix '_descriptiveAnalogData_' handles.phasesAndCycles(j).Names '_time.csv''']), 'w');
                    fprintf(fid, '%s', 'Original file: ');
                    fprintf(fid, '%s', fullFileName);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Date processed: ');
                    fprintf(fid, '%s', date);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Start of phase/cycle with respect to start of entire trial [s]: ');
                    fprintf(fid, '%6.2f', startPeriodAnalog(j)/analogFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'End of phase/cycle with respect to start of entire trial [s]: ');
                    fprintf(fid, '%6.2f', endPeriodAnalog(j)/analogFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', 'Analog sampling rate (Hz): ');
                    fprintf(fid, '%6.2f', analogFrameRate);
                    fprintf(fid, '\n');
                    fprintf(fid, 'Processed with TempNormGUI_%s', TempNormGuiVersion);        % Prasanna Sritharan
                    fprintf(fid, '\n');
                    fprintf(fid, '\n');
                    fprintf(fid, '%s', ',');
                    for k = 1:length(analogLabels);
                        fprintf(fid, '%s', eval(['''' char(analogLabels(k)) ',''']));
                    end
                    fprintf(fid, '\n');
                    if handles.calcMaxMagAnalog || handles.calcMaxTimeAnalog
                        eval(['[maxAnalogData_' handles.phasesAndCycles(j).Names...
                            '_time, indexMaxAnalogData_' handles.phasesAndCycles(j).Names...
                            '_time] = nanmax(analogData_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Maximum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['maxAnalogData_' handles.phasesAndCycles(j).Names '_time']));
                        if handles.calcMaxTimeAnalog
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Relative time [s],');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['indexMaxAnalogData_' handles.phasesAndCycles(j).Names...
                                '_time/analogFrameRate']));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcAbsMaxMagAnalog || handles.calcAbsMaxTimeAnalog
                        eval(['[absMaxAnalogData_' handles.phasesAndCycles(j).Names...
                            '_time, indexAbsMaxAnalogData_' handles.phasesAndCycles(j).Names...
                            '_time] = nanmax(abs(analogData_' handles.phasesAndCycles(j).Names...
                            '_time));'])
                        fprintf(fid, '%s', 'Absolute Maximum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['absMaxAnalogData_' handles.phasesAndCycles(j).Names '_time']));
                        if handles.calcAbsMaxTimeAnalog
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Relative time [s],');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['indexAbsMaxAnalogData_' handles.phasesAndCycles(j).Names...
                                '_time/analogFrameRate']));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcMinMagAnalog || handles.calcMinTimeAnalog
                        eval(['[minAnalogRowsData_' handles.phasesAndCycles(j).Names...
                            '_time, indexMinAnalogRowsData_' handles.phasesAndCycles(j).Names...
                            '_time] = nanmin(analogData_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Minimum');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['minAnalogRowsData_' handles.phasesAndCycles(j).Names '_time']));
                        if handles.calcMinTimeAnalog
                            fprintf(fid, '\n');
                            fprintf(fid, '%s', '  Relative time [s],');
                            fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['indexMinAnalogRowsData_' handles.phasesAndCycles(j).Names '_time/analogFrameRate']));
                        end
                        fprintf(fid, '\n');
                    end

                    if handles.calcMeanAnalog
                        eval(['meanAnalogData_' handles.phasesAndCycles(j).Names '_time = nanmean(analogData_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Mean');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['meanAnalogData_' handles.phasesAndCycles(j).Names '_time']));
                        fprintf(fid, '\n');
                    end

                    if handles.calcMedianAnalog
                        eval(['medianAnalogData_' handles.phasesAndCycles(j).Names '_time = nanmedian(analogData_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Median');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['medianAnalogData_' handles.phasesAndCycles(j).Names '_time']));
                        fprintf(fid, '\n');
                    end
                    if handles.calcStdAnalog
                        eval(['stdAnalogData_' handles.phasesAndCycles(j).Names '_time = nanstd(analogData_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Std');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['stdAnalogData_' handles.phasesAndCycles(j).Names '_time']));
                        fprintf(fid, '\n');
                    end
                    if handles.calcDurationAnalog
                        eval(['durationAnalogData_' handles.phasesAndCycles(j).Names '_time = ' num2str(endPeriodAnalog(j)/analogFrameRate - startPeriodAnalog(j)/analogFrameRate) ';'])
                        fprintf(fid, '%s', 'Duration');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['durationAnalogData_' handles.phasesAndCycles(j).Names '_time']));
                        fprintf(fid, '\n');
                    end

                    if handles.calcRangeAnalog
                        eval(['rangeAnalogData_' handles.phasesAndCycles(j).Names '_time = range(analogData_' handles.phasesAndCycles(j).Names...
                            '_time);'])
                        fprintf(fid, '%s', 'Range');
                        fprintf(fid, '\n');
                        fprintf(fid, '%s', '  Magnitude,');
                        fprintf(fid, eval(['''' analogSpecifiers '''']), eval(['rangeAnalogData_' handles.phasesAndCycles(j).Names '_time']));
                        fprintf(fid, '\n');
                    end
                    fclose(fid);
                end % phases and cycles loop
            end % non-termpnormalised loop
        end %analog descriptive loop
    end % analog loop

    %%   Output required variables to summary file if requested
    if handles.generateOrUpdateSummarySpreadsheet == 1

        summaryOutputVariables = handles.summaryOutputVariables;
        numSummaryOutputVariables = length(summaryOutputVariables);
        
        %   Preallocate summaryValues as -999
        summaryValue = ones(numSummaryOutputVariables,1)*-999;
        
        %   Initialise Indexes
        minMagVariableIndexes = [];
        minTimeVariableIndexes = [];
        maxMagVariableIndexes = [];
        maxTimeVariableIndexes = [];
        absMaxMagVariableIndexes = [];
        absMaxTimeVariableIndexes = [];
        meanVariableIndexes = [];
        medianVariableIndexes = [];
        stdVariableIndexes = [];
        durationVariableIndexes = [];
        rangeVariableIndexes = [];
        eventVariableIndexes = [];

        minMagVariableIndexes = findstringincellarray('_minMag', summaryOutputVariables);
        minTimeVariableIndexes = findstringincellarray('_minTime', summaryOutputVariables);
        maxMagVariableIndexes = findstringincellarray('_maxMag', summaryOutputVariables);
        maxTimeVariableIndexes = findstringincellarray('_maxTime', summaryOutputVariables);
        absMaxMagVariableIndexes = findstringincellarray('_absMaxMag', summaryOutputVariables);
        absMaxTimeVariableIndexes = findstringincellarray('_absTimeMag', summaryOutputVariables);
        meanVariableIndexes = findstringincellarray('_mean', summaryOutputVariables);
        medianVariableIndexes = findstringincellarray('_median', summaryOutputVariables);
        stdVariableIndexes = findstringincellarray('_std', summaryOutputVariables);
        durationVariableIndexes = findstringincellarray('_duration', summaryOutputVariables);
        rangeVariableIndexes = findstringincellarray('_range', summaryOutputVariables);
        eventVariableIndexes = findstringincellarray('_event', summaryOutputVariables);
        
        
        %   Note to self - this would be a more efficient way of
        %   parameterisation but need to find the time to do it!
        %
        % %         splitNames = splitstring(summaryOutputVariables, '_');
        % %         rawNames = splitNames(:,1);
        % %         phaseNames = splitNames(:,2);
        % %         normNames = splitNames(:,3);
        % %         statNames = splitNames(:,4);


        %%   Extract variables that end in _mean
        thisSectionStartIndex = 0;
        index = 0;
        for i = 1:length(meanVariableIndexes)
            index = thisSectionStartIndex + i;
            meanVariable = char(summaryOutputVariables(meanVariableIndexes(i)));
            startRawNameIndex = 1;
            j = 1;
            while isempty(strmatch(meanVariable(j),'_'))
                rawName(startRawNameIndex) = meanVariable(j);
                startRawNameIndex = startRawNameIndex + 1;
                j = j+1;
            end
            rawNames(index) = cellstr(rawName);

            j = j + 1;
            phasenameIndex = 1;
            while isempty(strmatch(meanVariable(j),'_'))
                phaseName(phasenameIndex) = meanVariable(j);
                j = j + 1;
                phasenameIndex = phasenameIndex + 1;
                if j + 5 > length(meanVariable)
                    phaseNames(i) = cellstr(phaseName);
                    break
                end
            end
            phaseNames(index) = cellstr(phaseName);
            j = j + 1;
            if length(meanVariable) == j + 5 % components + '_mean'
                clear rawName phaseName
                continue
            else
                normNameIndex = 1;
                while isempty(strmatch(meanVariable(j),'_'))
                    normName(normNameIndex) = meanVariable(j);
                    j = j + 1;
                    if j + 5 > length(meanVariable)
                        normNames(index) = cellstr(normName);
                        break
                    end
                    normNameIndex = normNameIndex + 1;
                end
                normNames(index) = cellstr(normName);
            end
            clear rawName phaseName normName

            if isempty(strmatch(char(rawNames(index)), char(analogLabels), 'exact')) ~=1
                analogIndex = strmatch(char(rawNames(index)), char(analogLabels), 'exact');
                summaryValue(meanVariableIndexes(i)) = eval(['meanAnalogData_' char(phaseNames(index)) '_' char(normNames(index)) '(analogIndex)']);
            elseif isempty(strmatch(char(rawNames(i)), char(customOutputNames), 'exact')) ~=1
                kinIndex = strmatch(char(rawNames(index)), char(customOutputNames), 'exact');
                summaryValue(meanVariableIndexes(i)) = eval(['mean3dCustom_' char(phaseNames(index)) '_' char(normNames(index)) '(kinIndex)']);
            end
        end

        %%   Extract variables that end in _median
        thisSectionStartIndex = index;
        for i = 1:length(medianVariableIndexes)
            index = thisSectionStartIndex + i;
            medianVariable = char(summaryOutputVariables(medianVariableIndexes(i)));
            startRawNameIndex = 1;
            j = 1;
            while isempty(strmatch(medianVariable(j),'_'))
                rawName(startRawNameIndex) = medianVariable(j);
                startRawNameIndex = startRawNameIndex + 1;
                j = j+1;
            end
            rawNames(index) = cellstr(rawName);

            j = j + 1;
            phasenameIndex = 1;
            while isempty(strmatch(medianVariable(j),'_'))
                phaseName(phasenameIndex) = medianVariable(j);
                j = j + 1;
                phasenameIndex = phasenameIndex + 1;
                if j + 7 > length(medianVariable)
                    phaseNames(index) = cellstr(phaseName);
                    break
                end
            end
            phaseNames(index) = cellstr(phaseName);
            j = j + 1;
            if length(medianVariable) == j + 7 % components + '_median'
                clear rawName phaseName
                continue
            else
                normNameIndex = 1;
                while isempty(strmatch(medianVariable(j),'_'))
                    normName(normNameIndex) = medianVariable(j);
                    j = j + 1;
                    if j + 7 > length(medianVariable)
                        normNames(index) = cellstr(normName);
                        break
                    end
                    normNameIndex = normNameIndex + 1;
                end
                normNames(index) = cellstr(normName);
            end
            clear rawName phaseName normName

            if isempty(strmatch(char(rawNames(index)), char(analogLabels), 'exact')) ~=1
                analogIndex = strmatch(char(rawNames(index)), char(analogLabels), 'exact'); 
                summaryValue(medianVariableIndexes(i)) = eval(['medianAnalogData_' char(phaseNames(index)) '_' char(normNames(index)) '(analogIndex)']);
            elseif isempty(strmatch(char(rawNames(index)), char(customOutputNames), 'exact')) ~=1
                kinIndex = strmatch(char(rawNames(index)), char(customOutputNames), 'exact');
                summaryValue(medianVariableIndexes(i)) = eval(['median3dCustom_' char(phaseNames(index)) '_' char(normNames(index)) '(kinIndex)']);
            end
        end

        %%   Extract variables that end in _std
        thisSectionStartIndex = index;
        for i = 1:length(stdVariableIndexes)
            index = thisSectionStartIndex + i;
            stdVariable = char(summaryOutputVariables(stdVariableIndexes(i)));
            startRawNameIndex = 1;
            j = 1;
            while isempty(strmatch(stdVariable(j),'_'))
                rawName(startRawNameIndex) = stdVariable(j);
                startRawNameIndex = startRawNameIndex + 1;
                j = j+1;
            end
            rawNames(index) = cellstr(rawName);

            j = j + 1;
            phasenameIndex = 1;
            while isempty(strmatch(stdVariable(j),'_'))
                phaseName(phasenameIndex) = stdVariable(j);
                j = j + 1;
                phasenameIndex = phasenameIndex + 1;
                if j + 4 > length(stdVariable)
                    phaseNames(index) = cellstr(phaseName);
                    break
                end
            end
            phaseNames(index) = cellstr(phaseName);
            j = j + 1;
            if length(stdVariable) == j + 4 % components + '_std'
                clear rawName phaseName
                continue
            else
                normNameIndex = 1;
                while isempty(strmatch(stdVariable(j),'_'))
                    normName(normNameIndex) = stdVariable(j);
                    j = j + 1;
                    if j + 4 > length(stdVariable)
                        normNames(index) = cellstr(normName);
                        break
                    end
                    normNameIndex = normNameIndex + 1;
                end
                normNames(index) = cellstr(normName);
            end
            clear rawName phaseName normName

            if isempty(strmatch(char(rawNames(index)), char(analogLabels), 'exact')) ~=1
                analogIndex = strmatch(char(rawNames(index)), char(analogLabels), 'exact');
                summaryValue(stdVariableIndexes(i)) = eval(['stdAnalogData_' char(phaseNames(index)) '_' char(normNames(index)) '(analogIndex)']);
            elseif isempty(strmatch(char(rawNames(index)), char(customOutputNames), 'exact')) ~=1
                kinIndex = strmatch(char(rawNames(index)), char(customOutputNames), 'exact');
                summaryValue(stdVariableIndexes(i)) = eval(['std3dCustom_' char(phaseNames(index)) '_' char(normNames(index)) '(kinIndex)']);
            end
        end

        %%   Extract variables that end in _duration
        thisSectionStartIndex = index;
        for i = 1:length(durationVariableIndexes)
            index = thisSectionStartIndex + i;
            durationVariable = char(summaryOutputVariables(durationVariableIndexes(i)));
            startRawNameIndex = 1;
            j = 1;
            while isempty(strmatch(durationVariable(j),'_'))
                rawName(startRawNameIndex) = durationVariable(j);
                startRawNameIndex = startRawNameIndex + 1;
                j = j+1;
            end
            rawNames(index) = cellstr(rawName);

            j = j + 1;
            phasenameIndex = 1;
            while isempty(strmatch(durationVariable(j),'_'))
                phaseName(phasenameIndex) = durationVariable(j);
                j = j + 1;
                phasenameIndex = phasenameIndex + 1;
                if j + 9 > length(durationVariable)
                    phaseNames(index) = cellstr(phaseName);
                    break
                end
            end
            phaseNames(index) = cellstr(phaseName);
            j = j + 1;
            if length(durationVariable) == j + 9 % components + '_duration'
                clear rawName phaseName
                continue
            else
                normNameIndex = 1;
                while isempty(strmatch(durationVariable(j),'_'))
                    normName(normNameIndex) = durationVariable(j);
                    j = j + 1;
                    if j + 9 > length(durationVariable)
                        normNames(index) = cellstr(normName);
                        break
                    end
                    normNameIndex = normNameIndex + 1;
                end
                normNames(index) = cellstr(normName);
            end
            clear rawName phaseName normName

            if isempty(strmatch(char(rawNames(index)), char(analogLabels), 'exact')) ~=1
                analogIndex = strmatch(char(rawNames(index)), char(analogLabels), 'exact'); 
                summaryValue(durationVariableIndexes(i)) = eval(['durationAnalogData_' char(phaseNames(index)) '_' char(normNames(index)) '(analogIndex)']);
            elseif isempty(strmatch(char(rawNames(index)), char(customOutputNames), 'exact')) ~=1
                kinIndex = strmatch(char(rawNames(index)), char(customOutputNames), 'exact');
                summaryValue(durationVariableIndexes(i)) = eval(['duration3dCustom_' char(phaseNames(index)) '_' char(normNames(index)) '(kinIndex)']);
            end
        end

        %%   Extract variables that end in _minMag
        thisSectionStartIndex = index;
        for i = 1:length(minMagVariableIndexes)
            index = thisSectionStartIndex + i;
            minMagVariable = char(summaryOutputVariables(minMagVariableIndexes(i)));
            startRawNameIndex = 1;
            j = 1;
            while isempty(strmatch(minMagVariable(j),'_'))
                rawName(startRawNameIndex) = minMagVariable(j);
                startRawNameIndex = startRawNameIndex + 1;
                j = j+1;
            end
            rawNames(index) = cellstr(rawName);

            j = j + 1;
            phasenameIndex = 1;
            while isempty(strmatch(minMagVariable(j),'_'))
                phaseName(phasenameIndex) = minMagVariable(j);
                j = j + 1;
                phasenameIndex = phasenameIndex + 1;
                if j + 7 > length(minMagVariable)
                    phaseNames(index) = cellstr(phaseName);
                    break
                end
            end
            phaseNames(index) = cellstr(phaseName);
            j = j + 1;
            if length(minMagVariable) == j + 7 % components + '_minMag'
                clear rawName phaseName
                continue
            else
                normNameIndex = 1;
                while isempty(strmatch(minMagVariable(j),'_'))
                    normName(normNameIndex) = minMagVariable(j);
                    j = j + 1;
                    if j + 7 > length(minMagVariable)
                        normNames(index) = cellstr(normName);
                        break
                    end
                    normNameIndex = normNameIndex + 1;
                end
                normNames(index) = cellstr(normName);
            end
            clear rawName phaseName normName

            if isempty(strmatch(char(rawNames(index)), char(analogLabels), 'exact')) ~=1
                analogIndex = strmatch(char(rawNames(index)), char(analogLabels), 'exact'); 
                summaryValue(minMagVariableIndexes(i)) = eval(['minAnalogRowsData_' char(phaseNames(index)) '_' char(normNames(index)) '(analogIndex)']);
            elseif isempty(strmatch(char(rawNames(index)), char(customOutputNames), 'exact')) ~=1
                kinIndex = strmatch(char(rawNames(index)), char(customOutputNames), 'exact');
                summaryValue(minMagVariableIndexes(i)) = eval(['min3dCustom_' char(phaseNames(index)) '_' char(normNames(index)) '(kinIndex)']);
            end
        end

        %%   Extract variables that end in _maxMag
        thisSectionStartIndex = index;
        for i = 1:length(maxMagVariableIndexes)
            index = thisSectionStartIndex + i;
            maxMagVariable = char(summaryOutputVariables(maxMagVariableIndexes(i)));
            startRawNameIndex = 1;
            j = 1;
            while isempty(strmatch(maxMagVariable(j),'_'))
                rawName(startRawNameIndex) = maxMagVariable(j);
                startRawNameIndex = startRawNameIndex + 1;
                j = j+1;
            end
            rawNames(index) = cellstr(rawName);

            j = j + 1;
            phasenameIndex = 1;
            while isempty(strmatch(maxMagVariable(j),'_'))
                phaseName(phasenameIndex) = maxMagVariable(j);
                j = j + 1;
                phasenameIndex = phasenameIndex + 1;
                if j + 7 > length(maxMagVariable)
                    phaseNames(index) = cellstr(phaseName);
                    break
                end
            end
            phaseNames(index) = cellstr(phaseName);
            j = j + 1;
            if length(maxMagVariable) == j + 7 % components + '_maxMag'
                clear rawName phaseName
                continue
            else
                normNameIndex = 1;
                while isempty(strmatch(maxMagVariable(j),'_'))
                    normName(normNameIndex) = maxMagVariable(j);
                    j = j + 1;
                    if j + 7 > length(maxMagVariable)
                        normNames(index) = cellstr(normName);
                        break
                    end
                    normNameIndex = normNameIndex + 1;
                end
                normNames(index) = cellstr(normName);
            end
            clear rawName phaseName normName

            if isempty(strmatch(char(rawNames(index)), char(analogLabels), 'exact')) ~=1
                analogIndex = strmatch(char(rawNames(index)), char(analogLabels), 'exact'); 
                summaryValue(maxMagVariableIndexes(i)) = eval(['maxAnalogData_' char(phaseNames(index)) '_' char(normNames(index)) '(analogIndex)']);
            elseif isempty(strmatch(char(rawNames(index)), char(customOutputNames), 'exact')) ~=1
                kinIndex = strmatch(char(rawNames(index)), char(customOutputNames), 'exact');
                summaryValue(maxMagVariableIndexes(i)) = eval(['max3dCustom_' char(phaseNames(index)) '_' char(normNames(index)) '(kinIndex)']);
            end
        end

        %%   Extract variables that end in _absMaxMag
        thisSectionStartIndex = index;
        for i = 1:length(absMaxMagVariableIndexes)
            index = thisSectionStartIndex + i;
            absMaxMagVariable = char(summaryOutputVariables(absMaxMagVariableIndexes(i)));
            startRawNameIndex = 1;
            j = 1;
            while isempty(strmatch(absMaxMagVariable(j),'_'))
                rawName(startRawNameIndex) = absMaxMagVariable(j);
                startRawNameIndex = startRawNameIndex + 1;
                j = j+1;
            end
            rawNames(index) = cellstr(rawName);

            j = j + 1;
            phasenameIndex = 1;
            while isempty(strmatch(absMaxMagVariable(j),'_'))
                phaseName(phasenameIndex) = absMaxMagVariable(j);
                j = j + 1;
                phasenameIndex = phasenameIndex + 1;
                if j + 10 > length(absMaxMagVariable)
                    phaseNames(index) = cellstr(phaseName);
                    break
                end
            end
            phaseNames(index) = cellstr(phaseName);
            j = j + 1;
            if length(absMaxMagVariable) == j + 10 % components + '_absMaxMag'
                clear rawName phaseName
                continue
            else
                normNameIndex = 1;
                while isempty(strmatch(absMaxMagVariable(j),'_'))
                    normName(normNameIndex) = absMaxMagVariable(j);
                    j = j + 1;
                    if j + 10 > length(absMaxMagVariable)
                        normNames(index) = cellstr(normName);
                        break
                    end
                    normNameIndex = normNameIndex + 1;
                end
                normNames(index) = cellstr(normName);
            end
            clear rawName phaseName normName

            if isempty(strmatch(char(rawNames(index)), char(analogLabels), 'exact')) ~=1
                analogIndex = strmatch(char(rawNames(index)), char(analogLabels), 'exact'); 
                summaryValue(absMaxMagVariableIndexes(i)) = eval(['absMaxAnalogData_' char(phaseNames(index)) '_' char(normNames(index)) '(analogIndex)']);
            elseif isempty(strmatch(char(rawNames(index)), char(customOutputNames), 'exact')) ~=1
                kinIndex = strmatch(char(rawNames(index)), char(customOutputNames), 'exact');
                summaryValue(absMaxMagVariableIndexes(i)) = eval(['absMax3dCustom_' char(phaseNames(index)) '_' char(normNames(index)) '(kinIndex)']);
            end
        end

        %%   Extract variables that end in _minTime
        thisSectionStartIndex = index;
        for i = 1:length(minTimeVariableIndexes)
            index = thisSectionStartIndex + i;
            minTimeVariable = char(summaryOutputVariables(minTimeVariableIndexes(i)));
            startRawNameIndex = 1;
            j = 1;
            while isempty(strmatch(minTimeVariable(j),'_'))
                rawName(startRawNameIndex) = minTimeVariable(j);
                startRawNameIndex = startRawNameIndex + 1;
                j = j+1;
            end
            rawNames(index) = cellstr(rawName);

            j = j + 1;
            phasenameIndex = 1;
            while isempty(strmatch(minTimeVariable(j),'_'))
                phaseName(phasenameIndex) = minTimeVariable(j);
                j = j + 1;
                phasenameIndex = phasenameIndex + 1;
                if j + 8 > length(minTimeVariable)
                    phaseNames(index) = cellstr(phaseName);
                    break
                end
            end
            phaseNames(index) = cellstr(phaseName);
            j = j + 1;
            if length(minTimeVariable) == j + 8 % components + '_minTime'
                clear rawName phaseName
                continue
            else
                normNameIndex = 1;
                while isempty(strmatch(minTimeVariable(j),'_'))
                    normName(normNameIndex) = minTimeVariable(j);
                    j = j + 1;
                    if j + 8 > length(minTimeVariable)
                        normNames(index) = cellstr(normName);
                        break
                    end
                    normNameIndex = normNameIndex + 1;
                end
                normNames(index) = cellstr(normName);
            end
            clear rawName phaseName normName

            if isempty(strmatch(char(rawNames(index)), char(analogLabels), 'exact')) ~=1
                analogIndex = strmatch(char(rawNames(index)), char(analogLabels), 'exact');
                summaryValue(minTimeVariableIndexes(i)) = eval(['indexMinAnalogRowsData_' char(phaseNames(index)) '_' char(normNames(index)) '(analogIndex)']);
            elseif isempty(strmatch(char(rawNames(index)), char(customOutputNames), 'exact')) ~=1
                kinIndex = strmatch(char(rawNames(index)), char(customOutputNames), 'exact');
                summaryValue(minTimeVariableIndexes(i)) = eval(['indexMin3dCustom_' char(phaseNames(index)) '_' char(normNames(index)) '(kinIndex)']);
            end
        end

        %%   Extract variables that end in _maxTime
        thisSectionStartIndex = index;
        for i = 1:length(maxTimeVariableIndexes)
            index = thisSectionStartIndex + i;
            maxTimeVariable = char(summaryOutputVariables(maxTimeVariableIndexes(i)));
            startRawNameIndex = 1;
            j = 1;
            while isempty(strmatch(maxTimeVariable(j),'_'))
                rawName(startRawNameIndex) = maxTimeVariable(j);
                startRawNameIndex = startRawNameIndex + 1;
                j = j+1;
            end
            rawNames(index) = cellstr(rawName);

            j = j + 1;
            phasenameIndex = 1;
            while isempty(strmatch(maxTimeVariable(j),'_'))
                phaseName(phasenameIndex) = maxTimeVariable(j);
                j = j + 1;
                phasenameIndex = phasenameIndex + 1;
                if j + 8 > length(maxTimeVariable)
                    phaseNames(index) = cellstr(phaseName);
                    break
                end
            end
            phaseNames(index) = cellstr(phaseName);
            j = j + 1;
            if length(maxTimeVariable) == j + 8 % components + '_maxTime'
                clear rawName phaseName
                continue
            else
                normNameIndex = 1;
                while isempty(strmatch(maxTimeVariable(j),'_'))
                    normName(normNameIndex) = maxTimeVariable(j);
                    j = j + 1;
                    if j + 8 > length(maxTimeVariable)
                        normNames(index) = cellstr(normName);
                        break
                    end
                    normNameIndex = normNameIndex + 1;
                end
                normNames(index) = cellstr(normName);
            end
            clear rawName phaseName normName

            if isempty(strmatch(char(rawNames(index)), char(analogLabels), 'exact')) ~=1
                analogIndex = strmatch(char(rawNames(index)), char(analogLabels), 'exact');
                summaryValue(maxTimeVariableIndexes(i)) = eval(['indexMaxAnalogData_' char(phaseNames(index)) '_' char(normNames(index)) '(analogIndex)']);
            elseif isempty(strmatch(char(rawNames(index)), char(customOutputNames), 'exact')) ~=1
                kinIndex = strmatch(char(rawNames(index)), char(customOutputNames), 'exact');
                summaryValue(maxTimeVariableIndexes(i)) = eval(['indexMax3dCustom_' char(phaseNames(index)) '_' char(normNames(index)) '(kinIndex)']);
            end
        end

        %%   Extract variables that end in _absMaxTime
        thisSectionStartIndex = index;
        for i = 1:length(absMaxTimeVariableIndexes)
            index = thisSectionStartIndex + i;
            absMaxTimeVariable = char(summaryOutputVariables(absMaxTimeVariableIndexes(i)));
            startRawNameIndex = 1;
            j = 1;
            while isempty(strmatch(absMaxTimeVariable(j),'_'))
                rawName(startRawNameIndex) = absMaxTimeVariable(j);
                startRawNameIndex = startRawNameIndex + 1;
                j = j+1;
            end
            rawNames(index) = cellstr(rawName);

            j = j + 1;
            phasenameIndex = 1;
            while isempty(strmatch(absMaxTimeVariable(j),'_'))
                phaseName(phasenameIndex) = absMaxTimeVariable(j);
                j = j + 1;
                phasenameIndex = phasenameIndex + 1;
                if j + 11 > length(absMaxTimeVariable)
                    phaseNames(index) = cellstr(phaseName);
                    break
                end
            end
            phaseNames(index) = cellstr(phaseName);
            j = j + 1;
            if length(absMaxTimeVariable) == j + 11 % components + '_absMaxTime'
                clear rawName phaseName
                continue
            else
                normNameIndex = 1;
                while isempty(strmatch(absMaxTimeVariable(j),'_'))
                    normName(normNameIndex) = absMaxTimeVariable(j);
                    j = j + 1;
                    if j + 11 > length(absMaxTimeVariable)
                        normNames(index) = cellstr(normName);
                        break
                    end
                    normNameIndex = normNameIndex + 1;
                end
                normNames(index) = cellstr(normName);
            end
            clear rawName phaseName normName

            if isempty(strmatch(char(rawNames(index)), char(analogLabels), 'exact')) ~=1
                analogIndex = strmatch(char(rawNames(index)), char(analogLabels), 'exact'); 
                summaryValue(absMaxTimeVariableIndexes(i)) = eval(['indexAbsMaxAnalogData_' char(phaseNames(index)) '_' char(normNames(index)) '(analogIndex)']);
            elseif isempty(strmatch(char(rawNames(index)), char(customOutputNames), 'exact')) ~=1
                kinIndex = strmatch(char(rawNames(index)), char(customOutputNames), 'exact');
                summaryValue(absMaxTimeVariableIndexes(i)) = eval(['indexAbsMax3dCustom_' char(phaseNames(index)) '_' char(normNames(index)) '(kinIndex)']);
            end
        end

        %%   Extract variables that end in _range
        for i = 1:length(rangeVariableIndexes)
            index = thisSectionStartIndex + i;
            rangeVariable = char(summaryOutputVariables(rangeVariableIndexes(i)));
            startRawNameIndex = 1;
            j = 1;
            while isempty(strmatch(rangeVariable(j),'_'))
                rawName(startRawNameIndex) = rangeVariable(j);
                startRawNameIndex = startRawNameIndex + 1;
                j = j+1;
            end
            rawNames(index) = cellstr(rawName);

            j = j + 1;
            phasenameIndex = 1;
            while isempty(strmatch(rangeVariable(j),'_'))
                phaseName(phasenameIndex) = rangeVariable(j);
                j = j + 1;
                phasenameIndex = phasenameIndex + 1;
                if j + 9 > length(rangeVariable)
                    phaseNames(index) = cellstr(phaseName);
                    break
                end
            end
            phaseNames(index) = cellstr(phaseName);
            j = j + 1;
            if length(rangeVariable) == j + 6 % components + '_range'
                clear rawName phaseName
                continue
            else
                normNameIndex = 1;
                while isempty(strmatch(rangeVariable(j),'_'))
                    normName(normNameIndex) = rangeVariable(j);
                    j = j + 1;
                    if j + 6 > length(rangeVariable)
                        normNames(index) = cellstr(normName);
                        break
                    end
                    normNameIndex = normNameIndex + 1;
                end
                normNames(index) = cellstr(normName);
            end
            clear rawName phaseName normName

            if isempty(strmatch(char(rawNames(index)), char(analogLabels), 'exact')) ~=1
                analogIndex = strmatch(char(rawNames(index)), char(analogLabels), 'exact');
                summaryValue(rangeVariableIndexes(i)) = eval(['rangeAnalogData_' char(phaseNames(index)) '_' char(normNames(index)) '(analogIndex)']);
            elseif isempty(strmatch(char(rawNames(index)), char(customOutputNames), 'exact')) ~=1
                kinIndex = strmatch(char(rawNames(index)), char(customOutputNames), 'exact');
                summaryValue(rangeVariableIndexes(i)) = eval(['range3dCustom_' char(phaseNames(index)) '_' char(normNames(index)) '(kinIndex)']);
            end
        end

        %%   Extract variables that end in _event
        thisSectionStartIndex = index;
        for i = 1:length(eventVariableIndexes)
            index = thisSectionStartIndex + i;
            eventVariable = char(summaryOutputVariables(eventVariableIndexes(i)));
            startRawNameIndex = 1;
            j = 1;
            while isempty(strmatch(eventVariable(j),'_'))
                rawName(startRawNameIndex) = eventVariable(j);
                startRawNameIndex = startRawNameIndex + 1;
                j = j+1;
            end
            rawNames(index) = cellstr(rawName);

            j = j + 1;
            phaseNameIndex = 1;
            while isempty(strmatch(eventVariable(j),'_'))
                phaseName(phaseNameIndex) = eventVariable(j);
                j = j + 1;
                phaseNameIndex = phaseNameIndex + 1;
                if j + 6 > length(eventVariable)
                    phaseNames(index) = cellstr(phaseName);
                    break
                end
            end
            phaseNames(index) = cellstr(phaseName);
            j = j + 1;
            if length(eventVariable) == j + 6 % components + '_event'
                clear rawName phaseName
                continue
            else
                normNameIndex = 1;
                while isempty(strmatch(eventVariable(j),'_'))
                    normName(normNameIndex) = eventVariable(j);
                    j = j + 1;
                    if j + 6 > length(eventVariable)
                        normNames(index) = cellstr(normName);
                        break
                    end
                    normNameIndex = normNameIndex + 1;
                end
                normNames(index) = cellstr(normName);
            end

            clear rawName phaseName normName

            if isempty(strmatch(char(rawNames(index)), char(analogLabels), 'exact')) ~=1
                analogIndex = strmatch(char(rawNames(index)), char(analogLabels), 'exact'); 
                eventNameIndex = strmatch(char(phaseNames(index)), char(eventNames), 'exact');
                eventSample = round((eventTimes(eventNameIndex)+ 1/analogFrameRate)*analogFrameRate)-1;
                summaryValue(eventVariableIndexes(i)) = eval(['analogData(' num2str(eventSample) ',' num2str(kinIndex) ')']);
            elseif isempty(strmatch(char(rawNames(index)), char(customOutputNames), 'exact')) ~=1
                kinIndex = strmatch(char(rawNames(index)), char(customOutputNames), 'exact');
                eventNameIndex = strmatch(char(phaseNames(index)), char(eventNames), 'exact');
                eventSample = round((eventTimes(eventNameIndex)+ 1/videoFrameRate)*videoFrameRate)-1;
                summaryValue(eventVariableIndexes(i)) = eval(['custom3dArray(' num2str(eventSample) ',' num2str(kinIndex) ')']);
            end
        end
        %   Write summaryValues to file
        outputSummaryFullFileName = fullfile(handles.summaryOutputPathName,handles.summaryOutputFileName);
        if exist(outputSummaryFullFileName) == 2;
            createHeaders = 'n';
        else
            createHeaders = 'y';
        end

        fid = fopen(outputSummaryFullFileName, 'a+');

        %   Write headers if this is a new summary file
        if createHeaders == 'y'
            for i = 1:numPathParts;
                fprintf(fid, '%s,', ' ');
            end

            for i = 1:length(summaryOutputVariables);
                fprintf(fid, '%s,', char(summaryOutputVariables(i)));
            end
            fprintf(fid, '\n');
        end

        %   Write parts of filename and path to columns
        for i = 1:numPathParts;
            if i == numPathParts
                trialName = char(pathParts(i));
                fprintf(fid, '%s', trialName(1:end-4));
                fprintf(fid, ',');
            else
                fprintf(fid, '%s', char(pathParts(i)));
                fprintf(fid, ',');
            end
        end

        %   Check if all summary output variables have been found
        numSummaryOutputVariablesFound = length(summaryValue);
        
        invalidVars = zeros(numSummaryOutputVariablesFound,1);
        invalidVars(summaryValue == -999) = 1;
        for i = 1:numSummaryOutputVariables
            if invalidVars(i) == 1
                disp(['Summary output variable ' char(summaryOutputVariables(i)) ' not found!']);
            end
        end
        
        for i = 1:length(summaryOutputVariables)
            fprintf(fid, '%6.4f,', summaryValue(i));
        end
        fprintf(fid, '\n');
        fclose(fid);
    end

    %   Plot time normalised joint angles if requested
    if process3d == 1
        figureIndex = 1;
        if handles.toPlotJointAngles
            %if any([rightData, leftData] == 0) || any([rightData, leftData] == 1)
                for j = 1:handles.numberOfPhasesAndCycles
                    switch(handles.trialType)
                        case ('upper')
                            %  Get data
                            lShldrFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peLShldrFlexExt'', customOutputNames, ''exact''))']);
                            lShldrAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peLShldrAddAbd'', customOutputNames, ''exact''))']);
                            lShldrIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peLShldrIntExtRot'', customOutputNames, ''exact''))']);
                            if min(isnan(lShldrFlexExt)) == 1
                                lShldrFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LShldrFlexExt'', customOutputNames, ''exact''))']);
                                lShldrAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LShldrAddAbd'', customOutputNames, ''exact''))']);
                                lShldrIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LShldrIntExtRot'', customOutputNames, ''exact''))']);
                            end

                            rShldrFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peRShldrFlexExt'', customOutputNames, ''exact''))']);
                            rShldrAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peRShldrAddAbd'', customOutputNames, ''exact''))']);
                            rShldrIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peRShldrIntExtRot'', customOutputNames, ''exact''))']);
                            if min(isnan(lShldrFlexExt)) == 1
                                rShldrFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RShldrFlexExt'', customOutputNames, ''exact''))']);
                                rShldrAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RShldrAddAbd'', customOutputNames, ''exact''))']);
                                rShldrIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RShldrIntExtRot'', customOutputNames, ''exact''))']);
                            end


                            lElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''heLElbowFlexExt'', customOutputNames, ''exact''))']);
                            lElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''heLElbowAddAbd'', customOutputNames, ''exact''))']);
                            lElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''heLElbowIntExtRot'', customOutputNames, ''exact''))']);
                            if min(isnan(lElbowFlexExt)) == 1
                                lElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peLElbowFlexExt'', customOutputNames, ''exact''))']);
                                lElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peLElbowAddAbd'', customOutputNames, ''exact''))']);
                                lElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peLElbowIntExtRot'', customOutputNames, ''exact''))']);
                                if min(isnan(lElbowFlexExt)) == 1
                                    lElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''pemwLElbowFlexExt'', customOutputNames, ''exact''))']);
                                    lElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''pemwLElbowAddAbd'', customOutputNames, ''exact''))']);
                                    lElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''pemwLElbowIntExtRot'', customOutputNames, ''exact''))']);
                                    if min(isnan(lElbowFlexExt)) == 1
                                        lElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwLElbowFlexExt'', customOutputNames, ''exact''))']);
                                        lElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwLElbowAddAbd'', customOutputNames, ''exact''))']);
                                        lElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwLElbowIntExtRot'', customOutputNames, ''exact''))']);
                                        if min(isnan(lElbowFlexExt)) == 1
                                            lElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LElbowFlexExt'', customOutputNames, ''exact''))']);
                                            lElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LElbowAddAbd'', customOutputNames, ''exact''))']);
                                            lElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LElbowIntExtRot'', customOutputNames, ''exact''))']);
                                        end
                                    end
                                end
                            end

                            rElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''heRElbowFlexExt'', customOutputNames, ''exact''))']);
                            rElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''heRElbowAddAbd'', customOutputNames, ''exact''))']);
                            rElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''heRElbowIntExtRot'', customOutputNames, ''exact''))']);
                            if min(isnan(rElbowFlexExt)) == 1
                                rElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peRElbowFlexExt'', customOutputNames, ''exact''))']);
                                rElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peRElbowAddAbd'', customOutputNames, ''exact''))']);
                                rElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peRElbowIntExtRot'', customOutputNames, ''exact''))']);
                                if min(isnan(rElbowFlexExt)) == 1
                                    rElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''pemwRElbowFlexExt'', customOutputNames, ''exact''))']);
                                    rElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''pemwRElbowAddAbd'', customOutputNames, ''exact''))']);
                                    rElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''pemwRElbowIntExtRot'', customOutputNames, ''exact''))']);
                                    if min(isnan(rElbowFlexExt)) == 1
                                        rElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwRElbowFlexExt'', customOutputNames, ''exact''))']);
                                        rElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwRElbowAddAbd'', customOutputNames, ''exact''))']);
                                        rElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwRElbowIntExtRot'', customOutputNames, ''exact''))']);
                                        if min(isnan(rElbowFlexExt)) == 1
                                            rElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RElbowFlexExt'', customOutputNames, ''exact''))']);
                                            rElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RElbowAddAbd'', customOutputNames, ''exact''))']);
                                            rElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RElbowIntExtRot'', customOutputNames, ''exact''))']);
                                        end
                                    end
                                end
                            end

                            lWristFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwLWristFlexExt'', customOutputNames, ''exact''))']);
                            lWristAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwLWristAddAbd'', customOutputNames, ''exact''))']);
                            lWristIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwLWristIntExtRot'', customOutputNames, ''exact''))']);
                            if min(isnan(lWristFlexExt)) == 1
                                lWristFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LWristFlexExt'', customOutputNames, ''exact''))']);
                                lWristAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LWristAddAbd'', customOutputNames, ''exact''))']);
                                lWristIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LWristIntExtRot'', customOutputNames, ''exact''))']);
                            end

                            rWristFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwRWristFlexExt'', customOutputNames, ''exact''))']);
                            rWristAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwRWristAddAbd'', customOutputNames, ''exact''))']);
                            rWristIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwRWristIntExtRot'', customOutputNames, ''exact''))']);

                            if min(isnan(rWristFlexExt)) == 1
                                rWristFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RWristFlexExt'', customOutputNames, ''exact''))']);
                                rWristAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RWristAddAbd'', customOutputNames, ''exact''))']);
                                rWristIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RWristIntExtRot'', customOutputNames, ''exact''))']);
                            end

                            t = 1:length(lShldrFlexExt);
                            %   Plot left side upper body angles
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Left upper body joint angles: ' handles.phasesAndCycles(j).Names ''');'])
                            subplot(3,3,1)
                            minMax2dPlot(t, lShldrFlexExt, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Shoulder ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, lShldrAddAbd, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, lShldrIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, lElbowFlexExt, 'y', 'y', 'b', 'r', 'k');
                            h = text(-0.4, 0.5, 'Elbow ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, lElbowAddAbd, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, lElbowIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, lWristFlexExt, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Wrist ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,8);
                            minMax2dPlot(t, lWristAddAbd, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, lWristIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;

                            %   Plot right side upper body angles
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Right upper body joint angles: ' handles.phasesAndCycles(j).Names ''');'])
                            subplot(3,3,1)
                            minMax2dPlot(t, rShldrFlexExt, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Shoulder ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, rShldrAddAbd, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, rShldrIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, rElbowFlexExt, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Elbow ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, rElbowAddAbd, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, rElbowIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, rWristFlexExt, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Wrist ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,8);
                            minMax2dPlot(t, rWristAddAbd, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, rWristIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;

                        case ('lower')
                            lHipFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LHipFlexExt'', customOutputNames, ''exact''))']);
                            lHipAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LHipAddAbd'', customOutputNames, ''exact''))']);
                            lHipIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LHipIntExtRot'', customOutputNames, ''exact''))']);
                            rHipFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RHipFlexExt'', customOutputNames, ''exact''))']);
                            rHipAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RHipAddAbd'', customOutputNames, ''exact''))']);
                            rHipIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RHipIntExtRot'', customOutputNames, ''exact''))']);

                            lKneeFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LKneeFlexExt'', customOutputNames, ''exact''))']);
                            lKneeAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LKneeAddAbd'', customOutputNames, ''exact''))']);
                            lKneeIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LKneeIntExtRot'', customOutputNames, ''exact''))']);
                            rKneeFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RKneeFlexExt'', customOutputNames, ''exact''))']);
                            rKneeAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RKneeAddAbd'', customOutputNames, ''exact''))']);
                            rKneeIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RKneeIntExtRot'', customOutputNames, ''exact''))']);

                            lAnkleFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LAnkPDFlex'', customOutputNames, ''exact''))']);
                            lAnkleInvEv = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LAnkInvEv'', customOutputNames, ''exact''))']);
                            lAnkleAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LAnkAddAbd'', customOutputNames, ''exact''))']);
                            rAnkleFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RAnkPDFlex'', customOutputNames, ''exact''))']);
                            rAnkleInvEv = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RAnkInvEv'', customOutputNames, ''exact''))']);
                            rAnkleAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RAnkAddAbd'', customOutputNames, ''exact''))']);

                            t = 1:length(lHipFlexExt);

                            %   Plot lower body joint angles for left side
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Left lower body joint angles: ' handles.phasesAndCycles(j).Names ''');'])
                            subplot(3,3,1)
                            minMax2dPlot(t, lHipFlexExt, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Hip ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, lHipAddAbd, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, lHipIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, lKneeFlexExt, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Knee ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, lKneeAddAbd, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, lKneeIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, lAnkleFlexExt, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Ankle ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,8);
                            minMax2dPlot(t, lAnkleInvEv, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, lAnkleAddAbd, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;


                            %   Plot lower body joint angles for right side
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Right lower body joint angles: ' handles.phasesAndCycles(j).Names ''');'])
                            subplot(3,3,1)
                            minMax2dPlot(t, rHipFlexExt, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Hip ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, rHipAddAbd, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, rHipIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, rKneeFlexExt, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Knee ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, rKneeAddAbd, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, rKneeIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, rAnkleFlexExt, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Ankle ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,8);
                            minMax2dPlot(t, rAnkleInvEv, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, rAnkleAddAbd, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;

                        case ('whole')
                            %  Get data
                            lShldrFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peLShldrFlexExt'', customOutputNames, ''exact''))']);
                            lShldrAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peLShldrAddAbd'', customOutputNames, ''exact''))']);
                            lShldrIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peLShldrIntExtRot'', customOutputNames, ''exact''))']);
                            if min(isnan(lShldrFlexExt)) == 1
                                lShldrFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LShldrFlexExt'', customOutputNames, ''exact''))']);
                                lShldrAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LShldrAddAbd'', customOutputNames, ''exact''))']);
                                lShldrIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LShldrIntExtRot'', customOutputNames, ''exact''))']);
                            end

                            rShldrFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peRShldrFlexExt'', customOutputNames, ''exact''))']);
                            rShldrAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peRShldrAddAbd'', customOutputNames, ''exact''))']);
                            rShldrIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peRShldrIntExtRot'', customOutputNames, ''exact''))']);
                            if min(isnan(lShldrFlexExt)) == 1
                                rShldrFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RShldrFlexExt'', customOutputNames, ''exact''))']);
                                rShldrAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RShldrAddAbd'', customOutputNames, ''exact''))']);
                                rShldrIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RShldrIntExtRot'', customOutputNames, ''exact''))']);
                            end


                            lElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''heLElbowFlexExt'', customOutputNames, ''exact''))']);
                            lElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''heLElbowAddAbd'', customOutputNames, ''exact''))']);
                            lElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''heLElbowIntExtRot'', customOutputNames, ''exact''))']);
                            if min(isnan(lElbowFlexExt)) == 1
                                lElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peLElbowFlexExt'', customOutputNames, ''exact''))']);
                                lElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peLElbowAddAbd'', customOutputNames, ''exact''))']);
                                lElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peLElbowIntExtRot'', customOutputNames, ''exact''))']);
                                if min(isnan(lElbowFlexExt)) == 1
                                    lElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''pemwLElbowFlexExt'', customOutputNames, ''exact''))']);
                                    lElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''pemwLElbowAddAbd'', customOutputNames, ''exact''))']);
                                    lElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''pemwLElbowIntExtRot'', customOutputNames, ''exact''))']);
                                    if min(isnan(lElbowFlexExt)) == 1
                                        lElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwLElbowFlexExt'', customOutputNames, ''exact''))']);
                                        lElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwLElbowAddAbd'', customOutputNames, ''exact''))']);
                                        lElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwLElbowIntExtRot'', customOutputNames, ''exact''))']);
                                        if min(isnan(lElbowFlexExt)) == 1
                                            lElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LElbowFlexExt'', customOutputNames, ''exact''))']);
                                            lElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LElbowAddAbd'', customOutputNames, ''exact''))']);
                                            lElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LElbowIntExtRot'', customOutputNames, ''exact''))']);
                                        end
                                    end
                                end
                            end

                            rElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''heRElbowFlexExt'', customOutputNames, ''exact''))']);
                            rElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''heRElbowAddAbd'', customOutputNames, ''exact''))']);
                            rElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''heRElbowIntExtRot'', customOutputNames, ''exact''))']);
                            if min(isnan(rElbowFlexExt)) == 1
                                rElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peRElbowFlexExt'', customOutputNames, ''exact''))']);
                                rElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peRElbowAddAbd'', customOutputNames, ''exact''))']);
                                rElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''peRElbowIntExtRot'', customOutputNames, ''exact''))']);
                                if min(isnan(rElbowFlexExt)) == 1
                                    rElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''pemwRElbowFlexExt'', customOutputNames, ''exact''))']);
                                    rElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''pemwRElbowAddAbd'', customOutputNames, ''exact''))']);
                                    rElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''pemwRElbowIntExtRot'', customOutputNames, ''exact''))']);
                                    if min(isnan(rElbowFlexExt)) == 1
                                        rElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwRElbowFlexExt'', customOutputNames, ''exact''))']);
                                        rElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwRElbowAddAbd'', customOutputNames, ''exact''))']);
                                        rElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwRElbowIntExtRot'', customOutputNames, ''exact''))']);
                                        if min(isnan(rElbowFlexExt)) == 1
                                            rElbowFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RElbowFlexExt'', customOutputNames, ''exact''))']);
                                            rElbowAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RElbowAddAbd'', customOutputNames, ''exact''))']);
                                            rElbowIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RElbowIntExtRot'', customOutputNames, ''exact''))']);
                                        end
                                    end
                                end
                            end

                            lWristFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwLWristFlexExt'', customOutputNames, ''exact''))']);
                            lWristAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwLWristAddAbd'', customOutputNames, ''exact''))']);
                            lWristIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwLWristIntExtRot'', customOutputNames, ''exact''))']);
                            if min(isnan(lWristFlexExt)) == 1
                                lWristFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LWristFlexExt'', customOutputNames, ''exact''))']);
                                lWristAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LWristAddAbd'', customOutputNames, ''exact''))']);
                                lWristIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LWristIntExtRot'', customOutputNames, ''exact''))']);
                            end

                            rWristFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwRWristFlexExt'', customOutputNames, ''exact''))']);
                            rWristAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwRWristAddAbd'', customOutputNames, ''exact''))']);
                            rWristIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''mwRWristIntExtRot'', customOutputNames, ''exact''))']);

                            if min(isnan(rWristFlexExt)) == 1
                                rWristFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RWristFlexExt'', customOutputNames, ''exact''))']);
                                rWristAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RWristAddAbd'', customOutputNames, ''exact''))']);
                                rWristIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RWristIntExtRot'', customOutputNames, ''exact''))']);
                            end

                            t = 1:length(lShldrFlexExt);

                            %   Plot left side upper body angles
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Left upper body joint angles: ' handles.phasesAndCycles(j).Names ''');'])
                            subplot(3,3,1)
                            minMax2dPlot(t, lShldrFlexExt, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Shoulder ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, lShldrAddAbd, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, lShldrIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, lElbowFlexExt, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Elbow ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, lElbowAddAbd, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, lElbowIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, lWristFlexExt, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Wrist ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,8);
                            minMax2dPlot(t, lWristAddAbd, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, lWristIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;

                            %   Plot right side upper body angles
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Right upper body joint angles: ' handles.phasesAndCycles(j).Names ''');'])
                            subplot(3,3,1)
                            minMax2dPlot(t, rShldrFlexExt, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Shoulder ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, rShldrAddAbd, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, rShldrIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, rElbowFlexExt, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Elbow ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, rElbowAddAbd, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, rElbowIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, rWristFlexExt, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Wrist ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,8);
                            minMax2dPlot(t, rWristAddAbd, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, rWristIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;

                            lHipFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LHipFlexExt'', customOutputNames, ''exact''))']);
                            lHipAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LHipAddAbd'', customOutputNames, ''exact''))']);
                            lHipIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LHipIntExtRot'', customOutputNames, ''exact''))']);
                            rHipFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RHipFlexExt'', customOutputNames, ''exact''))']);
                            rHipAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RHipAddAbd'', customOutputNames, ''exact''))']);
                            rHipIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RHipIntExtRot'', customOutputNames, ''exact''))']);

                            lKneeFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LKneeFlexExt'', customOutputNames, ''exact''))']);
                            lKneeAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LKneeAddAbd'', customOutputNames, ''exact''))']);
                            lKneeIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LKneeIntExtRot'', customOutputNames, ''exact''))']);
                            rKneeFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RKneeFlexExt'', customOutputNames, ''exact''))']);
                            rKneeAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RKneeAddAbd'', customOutputNames, ''exact''))']);
                            rKneeIntExtRot = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RKneeIntExtRot'', customOutputNames, ''exact''))']);

                            lAnkleFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LAnkPDFlex'', customOutputNames, ''exact''))']);
                            lAnkleInvEv = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LAnkInvEv'', customOutputNames, ''exact''))']);
                            lAnkleAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LAnkAddAbd'', customOutputNames, ''exact''))']);
                            rAnkleFlexExt = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RAnkPDFlex'', customOutputNames, ''exact''))']);
                            rAnkleInvEv = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RAnkInvEv'', customOutputNames, ''exact''))']);
                            rAnkleAddAbd = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RAnkAddAbd'', customOutputNames, ''exact''))']);

                            t = 1:length(lHipFlexExt);

                            %   Plot lower body joint angles for left side
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Left lower body joint angles: ' handles.phasesAndCycles(j).Names ''');'])
                            subplot(3,3,1)
                            minMax2dPlot(t, lHipFlexExt, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Hip ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, lHipAddAbd, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, lHipIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, lKneeFlexExt, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Knee ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, lKneeAddAbd, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, lKneeIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, lAnkleFlexExt, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Ankle ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,8);
                            minMax2dPlot(t, lAnkleInvEv, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, lAnkleAddAbd, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;


                            %   Plot lower body joint angles for right side
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Right lower body joint angles: ' handles.phasesAndCycles(j).Names ''')'])
                            subplot(3,3,1)
                            minMax2dPlot(t, rHipFlexExt, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Hip ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, rHipAddAbd, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, rHipIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, rKneeFlexExt, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Knee ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, rKneeAddAbd, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, rKneeIntExtRot, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, rAnkleFlexExt, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Ankle ang. [deg]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,8);
                            minMax2dPlot(t, rAnkleInvEv, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, rAnkleAddAbd, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;
                    end
                end
            %end
        end

        if handles.toPlotJointMoments
            %if any([rightData, leftData] == 0) || any([rightData, leftData] == 2)
                for j = 1:handles.numberOfPhasesAndCycles
                    switch(handles.trialType)
                        case ('upper' )
                            %  Get data
                            lShldrFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LShldrFlexExtMom'', customOutputNames, ''exact''))']);
                            lShldrAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LShldrAddAbdMom'', customOutputNames, ''exact''))']);
                            lShldrIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LShldrIntExtRotMom'', customOutputNames, ''exact''))']);
                            rShldrFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RShldrFlexExtMom'', customOutputNames, ''exact''))']);
                            rShldrAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RShldrAddAbdMom'', customOutputNames, ''exact''))']);
                            rShldrIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RShldrIntExtRotMom'', customOutputNames, ''exact''))']);

                            lElbowFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LElbowFlexExtMom'', customOutputNames, ''exact''))']);
                            lElbowAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LElbowAddAbdMom'', customOutputNames, ''exact''))']);
                            lElbowIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LElbowIntExtRotMom'', customOutputNames, ''exact''))']);
                            rElbowFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RElbowFlexExtMom'', customOutputNames, ''exact''))']);
                            rElbowAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RElbowAddAbdMom'', customOutputNames, ''exact''))']);
                            rElbowIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RElbowIntExtRotMom'', customOutputNames, ''exact''))']);

                            lWristFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LWristFlexExtMom'', customOutputNames, ''exact''))']);
                            lWristAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LWristAddAbdMom'', customOutputNames, ''exact''))']);
                            lWristIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LWristIntExtRotMom'', customOutputNames, ''exact''))']);
                            rWristFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RWristFlexExtMom'', customOutputNames, ''exact''))']);
                            rWristAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RWristAddAbdMom'', customOutputNames, ''exact''))']);
                            rWristIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RWristIntExtRotMom'', customOutputNames, ''exact''))']);

                            t = 1:length(lShldrFlexExtMom);

                            %   Plot left side upper body moments
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Left upper body joint moments: ' handles.phasesAndCycles(j).Names ''');'])
                            subplot(3,3,1)
                            minMax2dPlot(t, lShldrFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Shoulder mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, lShldrAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, lShldrIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, lElbowFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Elbow mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, lElbowAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, lElbowIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, lWristFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Wrist mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,8);
                            minMax2dPlot(t, lWristAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, lWristIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;

                            %   Plot right side upper body moments
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Right upper body joint moments: ' handles.phasesAndCycles(j).Names ''');'])
                            subplot(3,3,1)
                            minMax2dPlot(t, rShldrFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Shoulder moments [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, rShldrAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, rShldrIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, rElbowFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Elbow moments [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, rElbowAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, rElbowIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, rWristFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Wrist moments [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,8);
                            minMax2dPlot(t, rWristAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, rWristIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;

                        case ('lower')
                            lHipFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LHipFlexExtMom'', customOutputNames, ''exact''))']);
                            lHipAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LHipAddAbdMom'', customOutputNames, ''exact''))']);
                            lHipIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LHipIntExtRotMom'', customOutputNames, ''exact''))']);
                            rHipFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RHipFlexExtMom'', customOutputNames, ''exact''))']);
                            rHipAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RHipAddAbdMom'', customOutputNames, ''exact''))']);
                            rHipIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RHipIntExtRotMom'', customOutputNames, ''exact''))']);

                            lKneeFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LKneeFlexExtMom'', customOutputNames, ''exact''))']);
                            lKneeAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LKneeAddAbdMom'', customOutputNames, ''exact''))']);
                            lKneeIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LKneeIntExtRotMom'', customOutputNames, ''exact''))']);
                            rKneeFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RKneeFlexExtMom'', customOutputNames, ''exact''))']);
                            rKneeAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RKneeAddAbdMom'', customOutputNames, ''exact''))']);
                            rKneeIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RKneeIntExtRotMom'', customOutputNames, ''exact''))']);

                            lAnkleFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LAnkPDFlexMom'', customOutputNames, ''exact''))']);
                            lAnkleInvEvMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LAnkInvEvMom'', customOutputNames, ''exact''))']);
                            lAnkleAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LAnkAddAbdMom'', customOutputNames, ''exact''))']);
                            rAnkleFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RAnkPDFlexMom'', customOutputNames, ''exact''))']);
                            rAnkleInvEvMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RAnkInvEvMom'', customOutputNames, ''exact''))']);
                            rAnkleAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RAnkAddAbdMom'', customOutputNames, ''exact''))']);

                            t = 1:length(lHipFlexExtMom);

                            %   Plot lower body joint moments for left side
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Left lower body joint moments: ' handles.phasesAndCycles(j).Names ''');'])
                            subplot(3,3,1)
                            minMax2dPlot(t, lHipFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Hip mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, lHipAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, lHipIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, lKneeFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Knee mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, lKneeAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, lKneeIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, lAnkleFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Ankle mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,8);
                            minMax2dPlot(t, lAnkleInvEvMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, lAnkleAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;


                            %   Plot lower body joint moments for right side
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Right lower body joint moments: ' handles.phasesAndCycles(j).Names ''');'])
                            subplot(3,3,1)
                            minMax2dPlot(t, rHipFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Hip mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, rHipAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, rHipIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, rKneeFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Knee mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, rKneeAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, rKneeIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, rAnkleFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Ankle mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,8);
                            minMax2dPlot(t, rAnkleInvEvMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, rAnkleAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;

                        case ('whole')
                            %  Get data
                            lShldrFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LShldrFlexExtMom'', customOutputNames, ''exact''))']);
                            lShldrAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LShldrAddAbdMom'', customOutputNames, ''exact''))']);
                            lShldrIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LShldrIntExtRotMom'', customOutputNames, ''exact''))']);
                            rShldrFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RShldrFlexExtMom'', customOutputNames, ''exact''))']);
                            rShldrAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RShldrAddAbdMom'', customOutputNames, ''exact''))']);
                            rShldrIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RShldrIntExtRotMom'', customOutputNames, ''exact''))']);

                            lElbowFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LElbowFlexExtMom'', customOutputNames, ''exact''))']);
                            lElbowAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LElbowAddAbdMom'', customOutputNames, ''exact''))']);
                            lElbowIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LElbowIntExtRotMom'', customOutputNames, ''exact''))']);
                            rElbowFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RElbowFlexExtMom'', customOutputNames, ''exact''))']);
                            rElbowAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RElbowAddAbdMom'', customOutputNames, ''exact''))']);
                            rElbowIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RElbowIntExtRotMom'', customOutputNames, ''exact''))']);

                            lWristFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LWristFlexExtMom'', customOutputNames, ''exact''))']);
                            lWristAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LWristAddAbdMom'', customOutputNames, ''exact''))']);
                            lWristIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LWristIntExtRotMom'', customOutputNames, ''exact''))']);
                            rWristFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RWristFlexExtMom'', customOutputNames, ''exact''))']);
                            rWristAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RWristAddAbdMom'', customOutputNames, ''exact''))']);
                            rWristIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RWristIntExtRotMom'', customOutputNames, ''exact''))']);

                            t = 1:length(lShldrFlexExtMom);

                            %   Plot left side upper body moments
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Left upper body joint moments: ' handles.phasesAndCycles(j).Names ''');'])
                            subplot(3,3,1)
                            minMax2dPlot(t, lShldrFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Shoulder mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, lShldrAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, lShldrIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, lElbowFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Elbow mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, lElbowAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, lElbowIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, lWristFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Wrist mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,8);
                            minMax2dPlot(t, lWristAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, lWristIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;

                            %   Plot right side upper body moments
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Right upper body joint moments: ' handles.phasesAndCycles(j).Names ''');'])
                            subplot(3,3,1)
                            minMax2dPlot(t, rShldrFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Shoulder mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, rShldrAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, rShldrIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, rElbowFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Elbow mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, rElbowAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, rElbowIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, rWristFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Wrist mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,8);
                            minMax2dPlot(t, rWristAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, rWristIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;

                            lHipFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LHipFlexExtMom'', customOutputNames, ''exact''))']);
                            lHipAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LHipAddAbdMom'', customOutputNames, ''exact''))']);
                            lHipIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LHipIntExtRotMom'', customOutputNames, ''exact''))']);
                            rHipFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RHipFlexExtMom'', customOutputNames, ''exact''))']);
                            rHipAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RHipAddAbdMom'', customOutputNames, ''exact''))']);
                            rHipIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RHipIntExtRotMom'', customOutputNames, ''exact''))']);

                            lKneeFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LKneeFlexExtMom'', customOutputNames, ''exact''))']);
                            lKneeAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LKneeAddAbdMom'', customOutputNames, ''exact''))']);
                            lKneeIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LKneeIntExtRotMom'', customOutputNames, ''exact''))']);
                            rKneeFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RKneeFlexExtMom'', customOutputNames, ''exact''))']);
                            rKneeAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RKneeAddAbdMom'', customOutputNames, ''exact''))']);
                            rKneeIntExtRotMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RKneeIntExtRotMom'', customOutputNames, ''exact''))']);

                            lAnkleFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LAnkPDFlexMom'', customOutputNames, ''exact''))']);
                            lAnkleInvEvMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LAnkInvEvMom'', customOutputNames, ''exact''))']);
                            lAnkleAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''LAnkAddAbdMom'', customOutputNames, ''exact''))']);
                            rAnkleFlexExtMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RAnkPDFlexMom'', customOutputNames, ''exact''))']);
                            rAnkleInvEvMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RAnkInvEvMom'', customOutputNames, ''exact''))']);
                            rAnkleAddAbdMom = eval(['kinData_' handles.phasesAndCycles(j).Names '_time(:, strmatch(''RAnkAddAbdMom'', customOutputNames, ''exact''))']);
                            t = 1:length(lHipFlexExtMom);

                            %   Plot lower body joint moments for left side
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Left lower body joint moments: ' handles.phasesAndCycles(j).Names ''');'])
                            subplot(3,3,1)
                            minMax2dPlot(t, lHipFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Hip mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, lHipAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, lHipIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, lKneeFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Knee mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, lKneeAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, lKneeIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, lAnkleFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Ankle mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,8);
                            minMax2dPlot(t, lAnkleInvEvMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, lAnkleAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;


                            %   Plot lower body joint moments for right side
                            h = figure(figureIndex);
                            set(h, 'Units', 'Normalized', 'Position', [0.0109375, 0.0614583, 0.697656, 0.841667]);
                            eval(['set(h, ''Name'', ''Right lower body joint moments: ' handles.phasesAndCycles(j).Names ''');'])
                            subplot(3,3,1)
                            minMax2dPlot(t, rHipFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Hip mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            h = text(0.5, 1.2, 'Flex/Ext', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,2)
                            minMax2dPlot(t, rHipAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Add/Abd', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,3)
                            minMax2dPlot(t, rHipIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(0.5, 1.2, 'Int/Ext Rot', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center');
                            subplot(3,3,4)
                            minMax2dPlot(t, rKneeFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            h = text(-0.4, 0.5, 'Knee mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,5)
                            minMax2dPlot(t, rKneeAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            subplot(3,3,6)
                            minMax2dPlot(t, rKneeIntExtRotMom, 'y', 'y', 'b', 'r', 'k')
                            legend('Series', 'Min', 'Max', 'Location', 'East')
                            subplot(3,3,7);
                            minMax2dPlot(t, rAnkleFlexExtMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            h = text(-0.4, 0.5, 'Ankle mom. [N.m]', 'Units', 'Normalized', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Rotation', 90);
                            subplot(3,3,8);
                            minMax2dPlot(t, rAnkleInvEvMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            subplot(3,3,9);
                            minMax2dPlot(t, rAnkleAddAbdMom, 'y', 'y', 'b', 'r', 'k')
                            xlabel('Samples')
                            figureIndex = figureIndex + 1;
                    end
                end
            %end
        end
    end

    fclose('all');
   
    if trialIndex == handles.numberOfFiles
        uiwait(msgbox('Processing is complete for all of your selected trials!', 'Message', 'modal'));
        fclose('all');
        close all
        clc
%     else
%         eval(['toContinue = menu(''Processing of trial: ' (outputDirName(1:end-4))...
%             ' is complete'' , ''Continue to next trial'', ''Something is wrong. Stop processing!'');']);
%         if toContinue == 2;
%             errordlg('Processing aborted by user');
%             return
%         end
    end
    %clear complete3dSpecifiers analogSpecifiers   
    
    keep4 handles performCustomProcessing getEventLabelsFromC3d completeOutputNames customOutputNames  trialIndex summaryOutputVariables kinOutputGroups processAnalog process3d% remove all workspace variables except...
    close all  % close all figures
end

%   ----- Help uicontrols -------------------------------------------------------
%   Overall help
function pushbuttonHelp_Callback(hObject, eventdata, handles)
helpMessage = {' This GUI will enable you to seperate individual phases and/or cycles from   '
    ' your trial data. For example you may wish to extract the time-histories of  '
    ' your data starting at right foot contact and ending at right foot off (i.e. '
    ' the right stance phase).                                                    '
    '                                                                             '
    ' An additional function of this GUI is to temporally normalise the extracted '
    ' phases and cycles. Temporal normalisation of an extracted time history      '
    ' results in the time history being resampled to a predetermined number of    '
    ' data points (typically 51 or 101). If you are interested in describing      '
    ' aspects of your data with respect to the duration of a phases or cycle      '
    ' temporal normalisation is useful. Temporal normalisation is also very       '
    ' useful if you want to generate graphs including time histories from         '
    ' multiple trials, which had different durations. Keep in mind however, that  '
    ' any form of normalisation removes information from the data. Whether or not '
    ' your data should be analysed following temporal normalisation is a question '
    ' that only you (and your supervisor) can answer.                             '
    '                                                                             '
    '                                                                             '};

helpdlg(helpMessage)


%   Process analog data help - INCOMPLETE
function pushbuttonProcessAnalogHelp_Callback(hObject, eventdata, handles)
helpMessage = {' Do you want to process analog data? If yes, check the radiobutton.          '
    '                                                                             '
    ' If you do check the ''Process analog data'' radiobutton you will be given   '
    ' option of filtering the analog data. If you want to filter you analog data, '
    ' dot the radiobox                                                            '
    '                                                                             '};

helpdlg(helpMessage)


%   Basic information help - INCOMPLETE
function pushbuttonBasicInformationHelp_Callback(hObject, eventdata, handles)
helpMessage = {' This is where you define the information required to access you data.       '
    '                                                                             '
    ' Firstly, select the type of activity that you analysed. If you only had     '
    ' markers on the lower body, then select lower body. If you had markers on    '
    ' upper body only, select upper body. If you had markers on both the lower    '
    ' and upper body, select whole body.                                          '
    '                                                                             '
    ' Now select the files that you want to analyse. Simply click on the ''Select '
    ' file(s)'' button, browse to the directory in which your data is stored, and '
    ' select the files that you want to process. Hold ''Shift'' to select multiple'
    ' sequential files or ''Control'' to select multiple non-sequential files.    '
    '                                                                             '
    ' Now define the number of events that are located within each trial.         '
    ' This does not include the event marker(s) that you placed at the first frame'
    ' to define your combination of kinematic and kinetic outputs for the left and'
    ' right sides.                                                                '
    '                                                                             '
    ' Now click on the ''Define general events'' button. This will bring up       '
    ' another window that will allow you to name your general events. Additional  '
    ' help is provided in that window.                                            '
    '                                                                             '
    ' Now define the number of phases and/or cycles that you want to extract from '
    ' your trial.                                                                 '
    '                                                                             '
    ' Now click on the ''Define phases/cycles events'' button. This will bring up '
    ' another window that will allow you to name and define the start and end     '
    ' events that define phases and/or cycles. Additional help is provided in that'
    ' window.                                                                     '
    '                                                                             '};
helpdlg(helpMessage)


%   Filter characteristics help
function pushbuttonFilterCharacteristicsHelp_Callback(hObject, eventdata, handles)
helpMessage = {' Select the characteristics of the filter. At present the only filter        '
    ' available is a Butterworth zero-lag digital filter. If you really need a    '
    ' different filter contact me and I will see what I can do!                   '
    '                                                                             '
    ' Filter order: this specifies how steep the slope of the filter response is: '
    ' the greater the order, the steeper the slope. However, as the order refers  '
    ' to the number of previous data points that are used in the calculation of   '
    ' the current filtered data point, substantial errors can arise when the order'
    ' is large. For most applications, the order will be set to 2.                '
    '                                                                             '
    ' Filter cutoffs: What frequencies do you want to remove from the data you    '
    ' have collected. This will depend on what you analog data is. Below are some '
    ' \bf suggestions for the typical types of biomechanical analog data.         '
    '                                                                             '
    '                                                                             '
    ' Surface EMG - bandpass -->  LP cut off = 10 Hz, HP cut-off = 500 Hz         '
    ' Indwelling EMG - bandpass -->  LP cut off = 10 Hz, HP cut-off = 1000 Hz     '
    ' Accelerometer - lowpass -->  LP cut off = 25 Hz,                            '
    ' Electrogoniometer - lowpass --> LP cut off = 6 Hz                           '
    '                                                                             '};


helpdlg(helpMessage)


% --- Executes on button press in pushbuttonDifferentiationHelp.
function pushbuttonDifferentiationHelp_Callback(hObject, eventdata, handles)
helpMessage = {' Do you want to calculate velocities and accelerations? Select the           '
    ' appropriate radioboxes.                                                     '
    '                                                                             '
    ' Differentiation is performed using the Matlab function ''gradient'', which  '
    ' employs a first order finite difference equation.                           '
    '                                                                             '};

helpdlg(helpMessage)


% --- Executes on button press in pushbuttonDiscreteVariableIdentificationHelp.
function pushbuttonDiscreteVariableIdentificationHelp_Callback(hObject, eventdata, handles)
helpMessage = {' Select the discrete variables that you wish to from your phases and/or      '
    ' cycles. For each row the first column refers to the magnitude, while the    '
    ' second column refers to when the discrete value occured. These discrete     '
    ' variables will be output for EVERY time-history present within the 3D data  '
    ' and/or analog sections of your c3d file, for every phase/cycle that         '
    ' you have defined so only select what is needed!                             '
    '                                                                             '};

helpdlg(helpMessage)


%   Data output help
function pushbuttonOutputDataHelp_Callback(hObject, eventdata, handles)
helpMessage = {' Select whether you want to output the phase and/or cycle data with a        '
    ' according to: i) a time-base, ii) a user-defined temporally normalised base,'
    ' or iii) both.                                                               '
    '                                                                             '
    ' If you choose option  ii) or iii), you need to specify the number of data   '
    ' temporally normalised data set will contain. Typically this will be 51 or   '
    ' 101 points                                                                  '};

helpdlg(helpMessage)


% --- Executes on selection change in popupCustomProcessing.
function popupCustomProcessing_Callback(hObject, eventdata, handles)
performCustomProcessingStrings = cellstr(get(hObject,'String'));
performCustomProcessingValue = get(hObject,'Value');
if performCustomProcessingValue == 1
    msgbox('No custom processing defined. Standard trial processing will be used!', 'Warning', 'warn');
    performCustomProcessingValue = 2;
    handles.performCustomProcessing = char(performCustomProcessingStrings(performCustomProcessingValue, :));
end

handles.performCustomProcessing = char(performCustomProcessingStrings(performCustomProcessingValue, :));
guidata(hObject, handles)

function popupCustomProcessing_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


%   To create or update summary database
function checkSummarySpreadsheet_Callback(hObject, eventdata, handles)
handles.generateOrUpdateSummarySpreadsheet = get(hObject,'Value');
if handles.generateOrUpdateSummarySpreadsheet == 1
    generateOrUpdate = menu('Select whether you want to create a new summary spreadsheet of update an existing one?', 'Create new', 'Update existing');

    if generateOrUpdate == 1;
        %[handles.summaryOutputFileName, handles.summaryOutputPathName] = uiputfile('*.csv', 'Select name and location of output summary file to be generated', 'C:\\Program files\Matlab Executables\TempNormGUI\summaryOutputFile.csv');
        [handles.summaryOutputFileName, handles.summaryOutputPathName] = uiputfile('*.csv', 'Select name and location of output summary file to be generated', [handles.filePath '\summaryOutputFile.csv']);     % Prasanna Sritharan   
    elseif generateOrUpdate == 2
        %[handles.summaryOutputFileName, handles.summaryOutputPathName] = uigetfile('*.csv', 'Select output summary file', 'C:\Program files\Matlab Executables\TempNormGUI\', 'MultiSelect', 'off');
        [handles.summaryOutputFileName, handles.summaryOutputPathName] = uigetfile('*.csv', 'Select output summary file', handles.filePath, 'MultiSelect', 'off');      % Prasanna Sritharan

    end

    %   Select input file for this
    %[handles.summaryInputFileName, handles.summaryInputPathName] = uigetfile(['*.xls;*.csv'], 'C:\Program files\Matlab Executables\TempNormGUI\', 'MultiSelect', 'off');
    [handles.summaryInputFileName, handles.summaryInputPathName] = uigetfile(['*.xls;*.csv'], handles.filePath, 'MultiSelect', 'off');  % Prasanna Sritharan
    if strmatch(handles.summaryInputFileName(end-2:end), 'xls')
        msgbox('MS Excel files will not be supported in future releases! Save your input template file as a CSV file', 'Warning!', 'warn');
        [handles.numericInputVariables, handles.summaryOutputVariables, handles.rawInputVariables] = xlsread(fullfile(handles.summaryInputPathName, handles.summaryInputFileName));
    else
        handles.summaryOutputVariables = textread(fullfile(handles.summaryInputPathName, handles.summaryInputFileName), '%s', 'delimiter', ',');
    end
    handles.summarySpreadsheetIndexes = length(handles.summaryOutputVariables);
end
guidata(hObject, handles)


function editNumberOfC3dVariablesToBeOutput_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function editNumberOfC3dVariablesToBeOutput_Callback(hObject, eventdata, handles)
handles.numberOfC3dVariablesToBeOutput = str2num(char(get(hObject, 'String')));
guidata(hObject, handles)

% --- Executes on button press in pushbuttonSelectCompleteC3d2OutputNamesCsvFile.
function pushbuttonSelectCompleteC3d2OutputNamesCsvFile_Callback(hObject, eventdata, handles)
%[handles.completeC3d2OutputNamesCsvFileName, handles.completeC3d2OutputNamesCsvPathName] = uigetfile('*.csv', 'Select csv file that contains your C3D and output variable names',  'C:\Program Files\Matlab Executables\TempNormGUI\', 'MultiSelect', 'off');
[handles.completeC3d2OutputNamesCsvFileName, handles.completeC3d2OutputNamesCsvPathName] = uigetfile('*.csv', 'Select csv file that contains your C3D and output variable names', handles.filePath, 'MultiSelect', 'off');  % Prasanna Sritharan, May 2019
completeVariablesFileName = fullfile(handles.completeC3d2OutputNamesCsvPathName, handles.completeC3d2OutputNamesCsvFileName);
[c3dVariableNames, outputVariableNames(:,1), outputVariableNames(:,2), outputVariableNames(:,3)]  = textread(completeVariablesFileName, '%s%s%s%s', 'delimiter', ',', 'headerlines', 1);
handles.complete.c3dVariableNames = c3dVariableNames;
handles.complete.outputVariableNames = outputVariableNames;
guidata(hObject, handles);

% --- Executes on button press in pushbuttonSelectCustomC3d2OutputNamesCsvFile.
function pushbuttonSelectCustomC3d2OutputNamesCsvFile_Callback(hObject, eventdata, handles)
%[handles.customC3d2OutputNamesCsvFileName, handles.customC3d2OutputNamesCsvPathName] = uigetfile('*.csv', 'Select csv file that contains your custom C3D and output variable names',  'C:\Program Files\Matlab Executables\TempNormGUI\', 'MultiSelect', 'off');
[handles.customC3d2OutputNamesCsvFileName, handles.customC3d2OutputNamesCsvPathName] = uigetfile('*.csv', 'Select csv file that contains your custom C3D and output variable names', handles.filePath, 'MultiSelect', 'off');  % Prasanna Sritharan, May 2019
customVariablesFileName = fullfile(handles.customC3d2OutputNamesCsvPathName, handles.customC3d2OutputNamesCsvFileName);
handles.custom.outputVariableNames = textread(customVariablesFileName, '%s', 'delimiter', ',');
guidata(hObject, handles);




% --- Executes on key press with focus on pushbuttonSelectFiles and none of its controls.
function pushbuttonSelectFiles_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbuttonSelectFiles (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
