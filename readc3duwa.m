function [MarkerStruct, AnalogSignals, VideoFrameRate, AnalogFrameRate, AnalogLabels, EventTimes, EventTypes, EventLabels, EventSides]...
    = readc3duwa(fullFileName, trialType, custom, kinVariableListIn, outputType, replaceZeros)

% readc3duwa:	Read coordinate and analog data from a c3d file
%
% Input:
%           fullFileName:   Full filename (including path and extension) to be read
%           trialType:      Description of trial. See below for valid arguments
%           markerSet:      Description of marker set. See below for valid arguments
% Output:
%           Markers            3D-marker data [Nmarkers x NvideoFrames x Ndim(=3)]
%           VideoFrameRate     Frames/sec
%           AnalogSignals      Analog signals [Nsignals x NanalogSamples ]
%           AnalogFrameRate    Samples/sec
%           Event              Event(Nevents).time ..value  ..name
%           ParameterGroup     ParameterGroup(Ngroups).Parameters(Nparameters).data ..etc.
%           CameraInfo         MarkerRelated CameraInfo [Nmarkers x NvideoFrames]
%           ResidualError      MarkerRelated ErrorInfo  [Nmarkers x NvideoFrames]
%
% Valid trialTypes (character array):
%           RHJC, LHJC, RKJA, LKJA, RAJC, LAJC, REJA, LEJA
%
% Valid variableLists (character array)::
%           UWA, VCM

%function [coord, markerlist, NvideoFrames] = readc3duwa(fullFileName, trialType, variableList)

% AUTHOR(S) AND VERSION-HISTORY
% Adapted for UWA HMES processing by: Peter Mills, UWA, June, 2004 from:
%   getrawc3d.m written by: Thor Besiier and Alan Morris &
%   readc3d.m   written by: Alan Morris, Toronto, October 1998) & revised by
%                           Jaap Harlaar, Amsterdam, April 2002)



%%  Set default output arguments
Markers = [];
AnalogSignals = [];
VideoFrameRate = 0;
AnalogSignals = [];
AnalogFrameRate = 0;
Event = [];
EventTimes = [];
EventTypes = [];
EventLabels = [];
EventSides = [];
ParameterGroup = [];
CameraInfo = [];
ResidualError = [];

% Create list of markers and analog channels
%[markerlist]=c3dlabelraw(trialType, variableList);

% ###############################################
% ##                                           ##
% ##    open the file                          ##
% ##                                           ##
% ###############################################

ind=findstr(fullFileName,'\');
if ind>0, 
    FileName=fullFileName(ind(length(ind))+1:length(fullFileName));
else 
    FileName=fullFileName; 
end
        
fid=fopen(fullFileName,'r','n'); % native format (PC-intel)
    
if fid==-1,
    h=errordlg(['File: ',FileName,' could not be opened'],'application error');
    uiwait(h)
    return
end
       
NrecordFirstParameterblock=fread(fid,1,'int8');    % Reading record number of parameter section
key=fread(fid,1,'int8');                           % key = 80;

if key~=80,
    h=errordlg(['File: ',FileName,' does not comply to the C3D format'],'application error');
    uiwait(h)
    fclose(fid)
    return
end


fseek(fid,512*(NrecordFirstParameterblock-1)+3,'bof'); % jump to processortype - field
proctype=fread(fid,1,'int8')-83;                       % proctype: 1(INTEL-PC); 2(DEC-VAX); 3(MIPS-SUN/SGI)

if proctype==2,
    fclose(fid);
    fid=fopen(fullFileName,'r','d'); % DEC VAX D floating point and VAX ordering
end

% ###############################################
% ##                                           ##
% ##    read header                            ##
% ##                                           ##
% ###############################################

%NrecordFirstParameterblock=fread(fid,1,'int8');        % Reading record number of parameter section
%key1=fread(fid,1,'int8');                              % key = 80;

fseek(fid,2,'bof');

Nmarkers=fread(fid,1,'int16');			                % number of markers
NanalogSamplesPerVideoFrame=fread(fid,1,'int16');		% number of analog channels x #analog frames per video frame
StartFrame=fread(fid,1,'int16');		                % # of first video frame
EndFrame=fread(fid,1,'int16');			                % # of last video frame
MaxInterpolationGap=fread(fid,1,'int16');		        % maximum interpolation gap allowed (in frame)
Scale=fread(fid,1,'float32');			                % floating-point scale factor to convert 3D-integers to ref system units
NrecordDataBlock=fread(fid,1,'int16');			        % starting record number for 3D point and analog data
NanalogFramesPerVideoFrame=fread(fid,1,'int16');

if NanalogFramesPerVideoFrame > 0,
    NanalogChannels=NanalogSamplesPerVideoFrame/NanalogFramesPerVideoFrame;
else
    NanalogChannels=0;
end


VideoFrameRate=fread(fid,1,'float32');
AnalogFrameRate=VideoFrameRate*NanalogFramesPerVideoFrame;

% ###############################################
% ##                                           ##
% ##    read events                            ##
% ##                                           ##
% ###############################################

%   This code does not identify the events from the vicon c3d files - unsure why
%   not but have inserted a workaround following the reordering of Marker data
%   to identify the generic events required for UWA processing - Peter Mills
%%%%%%%%%%%%%%%%%%%
fseek(fid,298,'bof');
EventIndicator=fread(fid,1,'int16');
if EventIndicator==12345,
    Nevents=fread(fid,1,'int16');
    fseek(fid,2,'cof'); % skip one position/2 bytes
    if Nevents>0,
        for i=1:Nevents,
            Event(i).time=fread(fid,1,'float');
        end
        fseek(fid,188*2,'bof');
        for i=1:Nevents,
            Event(i).value=fread(fid,1,'int8');
        end
        fseek(fid,198*2,'bof');
        for i=1:Nevents,
            Event(i).name=cellstr(char(fread(fid,4,'char')'));
        end
    end
end



% ###############################################
% ##                                           ##
% ##    read 1st parameter block               ##
% ##                                           ##
% ###############################################

fseek(fid,512*(NrecordFirstParameterblock-1),'bof');

dat1=fread(fid,1,'int8');
key2=fread(fid,1,'int8');                   % key = 80;
NparameterRecords=fread(fid,1,'int8');
proctype=fread(fid,1,'int8')-83;            % proctype: 1(INTEL-PC); 2(DEC-VAX); 3(MIPS-SUN/SGI)


Ncharacters=fread(fid,1,'int8');   			% characters in group/parameter name
GroupNumber=fread(fid,1,'int8');				% id number -ve=group / +ve=parameter


while Ncharacters > 0 % The end of the parameter record is indicated by <0 characters for group/parameter name

    if GroupNumber<0 % Group data
        GroupNumber=abs(GroupNumber);
        GroupName=fread(fid,[1,Ncharacters],'char');
        ParameterGroup(GroupNumber).name=cellstr(char(GroupName));	%group name
        offset=fread(fid,1,'int16');							%offset in bytes
        deschars=fread(fid,1,'int8');							%description characters
        GroupDescription=fread(fid,[1,deschars],'char');
        ParameterGroup(GroupNumber).description=cellstr(char(GroupDescription)); %group description

        ParameterNumberIndex(GroupNumber)=0;
        fseek(fid,offset-3-deschars,'cof');

    else % parameter data
        clear dimension;
        ParameterNumberIndex(GroupNumber)=ParameterNumberIndex(GroupNumber)+1;%%%***%%%*********************************************
        ParameterNumber=ParameterNumberIndex(GroupNumber);              % index all parameters within a group

        ParameterName=fread(fid,[1,Ncharacters],'char');				% name of parameter

        % read parameter name
        if size(ParameterName)>0
            ParameterGroup(GroupNumber).Parameter(ParameterNumber).name=cellstr(char(ParameterName));	%save parameter name
        end

        % read offset
        %test    offset=fread(fid,1,'int16');							%offset of parameters in bytes
        offset=fread(fid,1,'uint16');							%offset of parameters in bytes
        filepos=ftell(fid);										%present file position
        nextrec=filepos+offset(1)-2;							%position of beginning of next record


        % read type
        type=fread(fid,1,'int8');     % type of data: -1=char/1=byte/2=integer*2/4=real*4
        ParameterGroup(GroupNumber).Parameter(ParameterNumber).datatype=type;


        % read number of dimensions
        dimnum=fread(fid,1,'int8');
        if dimnum==0
            datalength=abs(type);								%length of data record
        else
            mult=1;
            for j=1:dimnum
                dimension(j)=fread(fid,1,'int8');
                mult=mult*dimension(j);
                ParameterGroup(GroupNumber).Parameter(ParameterNumber).dim(j)=dimension(j);  %save parameter dimension data
            end
            datalength=abs(type)*mult;							%length of data record for multi-dimensional array
        end


        if type==-1 %datatype=='char'
            wordlength=dimension(1);	%length of character word
            if dimnum==2 & datalength>0 %& parameter(idnumber,index,2).dim>0
                for j=1:dimension(2)
                    data=fread(fid,[1,wordlength],'char');	%character word data record for 2-D array
                    ParameterGroup(GroupNumber).Parameter(ParameterNumber).data(j)=cellstr(char(data));
                end

            elseif dimnum==1 & datalength>0
                data=fread(fid,[1,wordlength],'char');		%numerical data record of 1-D array
                ParameterGroup(GroupNumber).Parameter(ParameterNumber).data=cellstr(char(data));
            end

        elseif type==1    %1-byte for boolean

            Nparameters=datalength/abs(type);
            data=fread(fid,Nparameters,'int8');
            ParameterGroup(GroupNumber).Parameter(ParameterNumber).data=data;

        elseif type==2 & datalength>0			%integer

            Nparameters=datalength/abs(type);
            %data=fread(fid,Nparameters,'uint16');
            data=fread(fid,Nparameters,'int16');   % orig resulted in errors if
            % offset was greater than 2^15
            if dimnum>1
                ParameterGroup(GroupNumber).Parameter(ParameterNumber).data=reshape(data,dimension);
            else
                ParameterGroup(GroupNumber).Parameter(ParameterNumber).data=data;
            end

        elseif type==4 & datalength>0

            Nparameters=datalength/abs(type);
            data=fread(fid,Nparameters,'float');
            if dimnum>1
                ParameterGroup(GroupNumber).Parameter(ParameterNumber).data=reshape(data,dimension);
            else
                ParameterGroup(GroupNumber).Parameter(ParameterNumber).data=data;
            end
        else
            % error
        end

        deschars=fread(fid,1,'int8');							%description characters
        if deschars>0
            description=fread(fid,[1,deschars],'char');
            ParameterGroup(GroupNumber).Parameter(ParameterNumber).description=cellstr(char(description));
        end
        %moving ahead to next record
        fseek(fid,nextrec,'bof');
    end

    % check group/parameter characters and idnumber to see if more records present
    Ncharacters=fread(fid,1,'int8');   			% characters in next group/parameter name
    GroupNumber=fread(fid,1,'int8');			% id number -ve=group / +ve=parameter
end


% ###############################################
% ##                                           ##
% ##    read data block                        ##
% ##                                           ##
% ###############################################
%  Get the coordinate and analog data

fseek(fid,(NrecordDataBlock-1)*512,'bof');
hWaitBar = waitbar(0,[FileName,' is loading...']);
NvideoFrames = EndFrame - StartFrame + 1;

%   Preallocate arrays - takes much longer when arrays are preallocated???
%Markers = zeros(NvideoFrames, Nmarkers, 3);
%AnalogSignals = zeros(NvideoFrames, NanalogFramesPerVideoFrame, NanalogChannels);

if Scale < 0
    for i=1:NvideoFrames
        for j=1:Nmarkers
            Markers(i,j,:)=fread(fid,3,'float32')';
            a=fix(fread(fid,1,'float32'));
            highbyte=fix(a/256);
            lowbyte=a-highbyte*256;
            CameraInfo(i,j)=highbyte;
            ResidualError(i,j)=lowbyte*abs(Scale);
        end
        hWaitBar = waitbar(i/NvideoFrames);
        for j=1:NanalogFramesPerVideoFrame,
            AnalogSignals(j+NanalogFramesPerVideoFrame*(i-1),1:NanalogChannels)=...
                fread(fid,NanalogChannels,'float32')';%    this was specified as 'int16' format which caused an error
        end
    end
else
    for i=1:NvideoFrames
        for j=1:Nmarkers
            Markers(i,j,1:3)=fread(fid,3, 'int16')'.*Scale;
            ResidualError(i,j)=fread(fid,1,'int8');
            CameraInfo(i,j)=fread(fid,1,'int8');
        end
        hWaitBar = waitbar(i/NvideoFrames);
        for j=1:NanalogFramesPerVideoFrame,
            AnalogSignals(j+NanalogFramesPerVideoFrame*(i-1),1:NanalogChannels)=...
                fread(fid,NanalogChannels,'int16')';
        end
    end
end

   
%%  Scale analog data
%   Identify analog section
for i=1:length(ParameterGroup);
    name=char(ParameterGroup(i).name);
    if strcmp(name,'ANALOG')
        analogGroup = i;
        break
    end
end

%   Read conversion factors
for i=1:length(ParameterGroup);
    name=char(ParameterGroup(analogGroup).Parameter(i).name);
    if strcmp(name,'GEN_SCALE')
        genericAnalogScale = ParameterGroup(analogGroup).Parameter(i).data;
    elseif strcmp(name,'GAIN')
        gain = ParameterGroup(analogGroup).Parameter(i).data;
    elseif strcmp(name,'OFFSET')
        analogOffset = ParameterGroup(analogGroup).Parameter(i).data;
    elseif strcmp(name,'SCALE')
        channelAnalogScale = ParameterGroup(analogGroup).Parameter(i).data;
    else
        continue
    end
end

%   Convert analog signals
if type == 1
    for j = 1:NanalogChannels
        AnalogSignals(:,j) = (AnalogSignals(:,j) - analogOffset(j)) * genericAnalogScale * gain(j)* channelAnalogScale(j);
    end
elseif type == 2
    for j = 1:NanalogChannels
        AnalogSignals(:,j) = -(AnalogSignals(:,j) + analogOffset(j)) * genericAnalogScale * gain(j) * channelAnalogScale(j);
    end
else % type == 3 or 4
    for j = 1:NanalogChannels
        AnalogSignals(:,j) = -(AnalogSignals(:,j) - analogOffset(j)) * genericAnalogScale * gain(j) * channelAnalogScale(j);
    end
end
    

%%
% ###############################################
% ##                                           ##
% ##    Read labels for markers                ##
% ##    and rearrange markers (3d Data)        ##
% ##                                           ##
% ###############################################

%  Get the scaled coordinate data [mm]
%  using 3-dimensional coordinate arrays
parameters = sum(ParameterNumberIndex);

% Find subject label prefixes (if present)
for i=1:length(ParameterGroup)
    % for i = 1:ParameterNumber changed by PM
    name=char(ParameterGroup(i).name);
    if strcmp(name,'SUBJECTS')
        labelgrp=i;
        break
    end
end

for j=1:parameters
    name=char(ParameterGroup(labelgrp).Parameter(j).name);
    if strcmp(name,'LABEL_PREFIXES')
        labelprefix=j;
        break
    end
end

% for j=1:Nmarkers
%     name=char(ParameterGroup(labelgrp).Parameter(j).name);
%     if strcmp(name,'LABELS')
%         labelprefix=j;
%         break
%     end
% end
%-------------------------------------------------------------------------------

%%   PM inserted to read marker labels (not pretty but it works :-)
if isempty(Markers) ~= 1

    warning off MATLAB:nonIntegerTruncatedInConversionToChar
    fseek(fid,512*(NrecordFirstParameterblock-1),'bof');
    NumberOfMarkerLabels = 0;
    MarkerLabels = {};
    
    %   Define character pointers and spaces
    if type == -1;
        tabBinaryCharacter = 24;
        spaceBinaryCharacter = 32;
        endLabelsBinaryCharacter = 0;
        spaceBetweenLabels = 30;
        startLabelIncrement = 12;
        startLabelIncrement2 = 13;
    elseif type == 2;
        tabBinaryCharacter = 24;
        spaceBinaryCharacter = 32;
        endLabelsBinaryCharacter = 0;
        spaceBetweenLabels = 30;
        startLabelIncrement = 12;
        startLabelIncrement2 = 13;
    elseif type == 1;
        tabBinaryCharacter = -1;
        spaceBinaryCharacter = 32;
        endLabelsBinaryCharacter = -1;
        % spaceBetweenLabels = 32; this not valif for old APM data????
        spaceBetweenLabels = 30; 
        startLabelIncrement = 12;
        startLabelIncrement2 = 13;
    elseif type == 4
        tabBinaryCharacter = 24;
        spaceBinaryCharacter = 32;
        endLabelsBinaryCharacter = 0;
        spaceBetweenLabels = 30;
        startLabelIncrement = 12;
        startLabelIncrement2 = 13;
    end

    
%%   Read LABELS
    ParameterSection = fread(fid, inf, 'int8');
    StartLabels = findstr('LABELS', char(char(ParameterSection')));
    StartLabel = StartLabels(1) + startLabelIncrement;
    EndLabels = findstr(endLabelsBinaryCharacter, ParameterSection(StartLabel:StartLabel+20000)');
    EndLabel = StartLabel + EndLabels(1);
    markerLabelIndex = 1;
    while (markerLabelIndex <= Nmarkers) & (markerLabelIndex <= 255);
        endOfCurrentLabel = min(findstr(spaceBinaryCharacter, char(char(ParameterSection(StartLabel:StartLabel+spaceBetweenLabels)')))) + StartLabel;
        MarkerLabels(markerLabelIndex) = cellstr(char(char(ParameterSection(StartLabel: endOfCurrentLabel(1))')));
        markerLabelIndex = markerLabelIndex + 1;
        StartLabel = StartLabel + spaceBetweenLabels;

        if ParameterSection(StartLabel) == tabBinaryCharacter;
            break
        end
    end
    
    %   Read LABELS2 if it exists 
    if Nmarkers > 255;
        fseek(fid, 512*(NrecordFirstParameterblock-1), 'bof');
        %ParameterSection = fread(fid, inf, 'int8');
        StartLabels = findstr('LABELS2', char(char(ParameterSection')));
        StartLabel = StartLabels(1) + startLabelIncrement2;
        EndLabels = findstr(endLabelsBinaryCharacter, ParameterSection(StartLabel:StartLabel+20000)');
        EndLabel = StartLabel + EndLabels(1);
        markerLabelIndex = 256;
        while (markerLabelIndex <= Nmarkers) & (markerLabelIndex <= 510);
        endOfCurrentLabel = min(findstr(spaceBinaryCharacter, char(char(ParameterSection(StartLabel:StartLabel+spaceBetweenLabels)')))) + StartLabel;
        MarkerLabels(markerLabelIndex) = cellstr(char(char(ParameterSection(StartLabel: endOfCurrentLabel(1))')));
        markerLabelIndex = markerLabelIndex + 1;
        StartLabel = StartLabel + spaceBetweenLabels;
            if ParameterSection(StartLabel) == tabBinaryCharacter;
                break
            end
        end
    end
        

    %   Read LABELS3 if it exists
    if Nmarkers > 510;
        fseek(fid, 512*(NrecordFirstParameterblock-1), 'bof');
        %ParameterSection = fread(fid, inf, 'int8');
        StartLabels = findstr('LABELS3', char(char(ParameterSection')));
        StartLabel = StartLabels(1) + startLabelIncrement2;
        EndLabels = findstr(endLabelsBinaryCharacter, ParameterSection(StartLabel:StartLabel+20000)');
        EndLabel = StartLabel + EndLabels(1);
        markerLabelIndex = 511;
        while (markerLabelIndex <= Nmarkers) & (markerLabelIndex <= 765);
        endOfCurrentLabel = min(findstr(spaceBinaryCharacter, char(char(ParameterSection(StartLabel:StartLabel+spaceBetweenLabels)')))) + StartLabel;
        MarkerLabels(markerLabelIndex) = cellstr(char(char(ParameterSection(StartLabel: endOfCurrentLabel(1))')));
        markerLabelIndex = markerLabelIndex + 1;
        StartLabel = StartLabel + spaceBetweenLabels;
            if ParameterSection(StartLabel) == tabBinaryCharacter;
                break
            end
        end
    end

    %   Now check to see if LABELS4 exists
    if Nmarkers > 765;
        fseek(fid, 512*(NrecordFirstParameterblock-1), 'bof');
        %ParameterSection = fread(fid, inf, 'int8');
        StartLabels = findstr('LABELS4', char(char(ParameterSection')));
        StartLabel = StartLabels(1) + startLabelIncrement2;
        EndLabels = findstr(endLabelsBinaryCharacter, ParameterSection(StartLabel:StartLabel+20000)');
        EndLabel = StartLabel + EndLabels(1);
        markerLabelIndex = 766;
        while (markerLabelIndex <= Nmarkers) & (markerLabelIndex <= 1020);
        endOfCurrentLabel = min(findstr(spaceBinaryCharacter, char(char(ParameterSection(StartLabel:StartLabel+spaceBetweenLabels)')))) + StartLabel;
        MarkerLabels(markerLabelIndex) = cellstr(char(char(ParameterSection(StartLabel: endOfCurrentLabel(1))')));
        markerLabelIndex = markerLabelIndex + 1;
        StartLabel = StartLabel + spaceBetweenLabels;
            if ParameterSection(StartLabel) == tabBinaryCharacter;
                break
            end
        end
    end
elseif strmatch(trialType, 'analog') ~= 1
    disp('Unsupported c3d file format!');
end
    

%-------------------------------------------------------------------------------

%%  Read analog labels
for i=1:length(ParameterGroup);
    name=char(ParameterGroup(i).name);
    if strcmp(name,'ANALOG')
        analogGroup = i;
        break
    end
end

for i=1:length(ParameterGroup(analogGroup).Parameter);
    name=char(ParameterGroup(analogGroup).Parameter(i).name);
    if strcmp(name,'LABELS')
        analogLabelGroup = i;
        break
    end
end

AnalogLabels = ParameterGroup(analogGroup).Parameter(analogLabelGroup).data;


%%  Read event information
for i=1:length(ParameterGroup);
    name=char(ParameterGroup(i).name);
    if strcmp(name,'EVENT')
        eventGroup = i;
        break
    end
end

%   Events used?
for i=1:length(ParameterGroup(eventGroup).Parameter);
    name=char(ParameterGroup(eventGroup).Parameter(i).name);
    if strcmp(name,'USED')
        eventUsedGroup = i;
        break
    end
end
eventUsed = ParameterGroup(eventGroup).Parameter(eventUsedGroup).data;


if eventUsed ~= 0
    %   Event times
    for i=1:length(ParameterGroup(eventGroup).Parameter);
        name=char(ParameterGroup(eventGroup).Parameter(i).name);
        if strcmp(name,'TIMES')
            eventTimesGroup = i;
            break
        end
    end
    EventTimes = ParameterGroup(eventGroup).Parameter(eventTimesGroup).data(2,:) - ((StartFrame-1)/VideoFrameRate);

    %   Event sides - 'left', 'right', 'general'
    for i=1:length(ParameterGroup(eventGroup).Parameter);
        name=char(ParameterGroup(eventGroup).Parameter(i).name);
        if strcmp(name,'CONTEXTS')
            eventSidesGroup = i;
            break
        end
    end
    EventSides = ParameterGroup(eventGroup).Parameter(eventSidesGroup).data;

    %   Event types - general(|) = 0, foot-strike(<>) = 1, foot-off (+) = 2;
    for i=1:length(ParameterGroup(eventGroup).Parameter);
        name=char(ParameterGroup(eventGroup).Parameter(i).name);
        if strcmp(name,'ICON_IDS')
            eventTypesGroup = i;
            break
        end
    end
    EventTypes = ParameterGroup(eventGroup).Parameter(eventTypesGroup).data;

    %   Event labels - these are user defined labels;
    for i=1:length(ParameterGroup(eventGroup).Parameter);
        name=char(ParameterGroup(eventGroup).Parameter(i).name);
        if strcmp(name,'LABELS')
            eventLabelsGroup = i;
            break
        end
    end
    EventLabels = ParameterGroup(eventGroup).Parameter(eventLabelsGroup).data;
end
%%  If this is an analog only trial then return from function
if strmatch(trialType, 'analog');
    close(hWaitBar)
    fclose(fid);
    return
end

% %%  Read marker Label Information information
% for i=1:length(ParameterGroup);
%     name=char(ParameterGroup(i).name);
%     if strcmp(name,'POINT')
%         eventGroup = i;
%         break
%     end
% end
%
% %   Event times
% for i=1:length(ParameterGroup(eventGroup).Parameter);
%     name=char(ParameterGroup(eventGroup).Parameter(i).name);
%     if strcmp(name,'TIMES')
%         eventTimesGroup = i;
%         break
%     end
% end
% EventTimes = ParameterGroup(eventGroup).Parameter(eventTimesGroup).data(2,:) - ((StartFrame-1)/VideoFrameRate);
%

if replaceZeros == 'y'
    Markers = replacezeroswithnans(Markers);
end

% Finding order of markers to arrange in sequence
lengthKinVariableListIn = length(kinVariableListIn);
numberOfkinVariablesFound = 0;
kinDataIndex = 1;
for i=1:Nmarkers;
    for j=1:lengthKinVariableListIn
        if strcmp(MarkerLabels(i), kinVariableListIn(j))
            eval(['MarkerStruct. ' char(kinVariableListIn(j)) ' = squeeze(Markers(:,i,:));']);
            numberOfkinVariablesFound = numberOfkinVariablesFound + 1;
        end
    end
end

% %   Replace missing points with NaNs
% for j = 1:3;
%     requiredMarkers(:,:,j) = zeros(NvideoFrames,lengthKinVariableListIn);
% end
% 
% %  Zero first marker data
% if lower(outputType) == 'structure';      %   Output markers 2d arrays in a structure
%     for i=1:length(landmark)
%         if landmark(i) ~= 0
%             eval(['markerStructure.' char(kinVariableList(i)) ' = squeeze(Markers(:, landmark(i),:))']);
%         end
%     end
%     Markers = markerStructure;
% else                            %   Output markers as a 3d array
%     for i=1:length(landmark)
%         if landmark(i) ~= 0
%             requiredMarkers(:,i,:) = Markers(:, landmark(i),:);
%         end
%     end
%     Markers = requiredMarkers;
% end
% 
% 
% if lower(outputType) == '2DimArray';     %   Output markers as a 2d array
%     Markers = reduce3dto2d(Markers);
% end
% 
% %   Replace zeros with Nans if requested
% if replaceZeros == 'y'
%     Markers = replacezeroswithnans(Markers);
% end


close(hWaitBar)
fclose(fid);