function [FilteredMarkers, Markers,AnalogSignals,VideoFrameRate,AnalogFrameRate,EventTimes,EventTypes,EventSides]...
    = readc3duwa_filt(fullFileName, trialType, kinVariableListIn, outputType, fcut, order);

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

Markers=[];
VideoFrameRate=0;
AnalogSignals=[];
AnalogFrameRate=0;
Event=[];
ParameterGroup=[];
CameraInfo=[];
ResidualError=[];

% Create list of markers and analog channels
%[markerlist]=c3dlabelraw(trialType, variableList);

% ###############################################
% ##                                           ##
% ##    open the file                          ##
% ##                                           ##
% ###############################################

ind=findstr(fullFileName,'\');
if ind>0, FileName=fullFileName(ind(length(ind))+1:length(fullFileName)); else FileName=fullFileName; end

fid=fopen(fullFileName,'r','n'); % native format (PC-intel)

if fid==-1,
    h=errordlg(['File: ',FileName,' could not be opened'],'application error');
    uiwait(h)
    return
end

NrecordFirstParameterblock=fread(fid,1,'int8');     % Reading record number of parameter section
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
        offset=fread(fid,1,'int16');							%offset of parameters in bytes
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
            data=fread(fid,Nparameters,'int16');
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
    GroupNumber=fread(fid,1,'int8');				% id number -ve=group / +ve=parameter
end


% ###############################################
% ##                                           ##
% ##    read data block                        ##
% ##                                           ##
% ###############################################
%  Get the coordinate and analog data

fseek(fid,(NrecordDataBlock-1)*512,'bof');

hWaitBar = waitbar(0,[FileName,' is loading...']);

NvideoFrames=EndFrame - StartFrame + 1;			

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
        waitbar(i/NvideoFrames)
        for j=1:NanalogFramesPerVideoFrame,
            AnalogSignals(j+NanalogFramesPerVideoFrame*(i-1),1:NanalogChannels)=...
                fread(fid,NanalogChannels,'float32')';%    this was specified as 'int16' format which caused an error
        end
    end
    AnalogSignals = AnalogSignals - 2048;
else
    for i=1:NvideoFrames
        for j=1:Nmarkers
            Markers(i,j,1:3)=fread(fid,3, 'int16')'.*Scale;
            ResidualError(i,j)=fread(fid,1,'int8');
            CameraInfo(i,j)=fread(fid,1,'int8');
        end
        waitbar(i/NvideoFrames)
        for j=1:NanalogFramesPerVideoFrame,
            AnalogSignals(j+NanalogFramesPerVideoFrame*(i-1),1:NanalogChannels)=...
                fread(fid,NanalogChannels,'int16')';
        end
    end
end

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
for i=1:ParameterNumber
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


%-------------------------------------------------------------------------------

%   PM inserted to read marker labels (not pretty but it works :-)
warning off MATLAB:nonIntegerTruncatedInConversionToChar
fseek(fid,512*(NrecordFirstParameterblock-1),'bof');
tabBinaryCharacter = 24;
spaceBinaryCharacter = 32;
endLabelsBinaryCharacter = 0;
spaceBetweenLabels = 30;
NumberOfMarkerLabels = 0;
MarkerLabels = {};

if type == -1;  
    ParameterSection = fread(fid, inf, 'int8');
    StartLabels = findstr('LABELS', char(char(ParameterSection')));
    StartLabel = StartLabels(1)+12;
    EndLabels = findstr(endLabelsBinaryCharacter, ParameterSection(StartLabel:StartLabel+20000)');
    EndLabel = StartLabel + EndLabels(1);
    i = 1;
    while (i <= Nmarkers) & (i <= 255);
        endOfCurrentLabel = findstr(spaceBinaryCharacter, char(char(ParameterSection(StartLabel:EndLabel)')))-2 + StartLabel;
        MarkerLabels(i) = cellstr(char(char(ParameterSection(StartLabel: endOfCurrentLabel(1))')));
        i = i + 1;
        StartLabel = StartLabel + spaceBetweenLabels;
        
        if  ParameterSection(StartLabel) == tabBinaryCharacter;
            break
        end
    end
    %   Now check to see if LABELS2 exists
    if Nmarkers > 255;
        fseek(fid, 512*(NrecordFirstParameterblock-1), 'bof');
        ParameterSection = fread(fid, inf, 'int8');
        StartLabels = findstr('LABELS2', char(char(ParameterSection')));
        StartLabel = StartLabels(1)+13;
        EndLabels = findstr(endLabelsBinaryCharacter, ParameterSection(StartLabel:StartLabel+20000)');
        EndLabel = StartLabel + EndLabels(1);
        i = 256;
        while i <= Nmarkers;
            endOfCurrentLabel = findstr(spaceBinaryCharacter, char(char(ParameterSection(StartLabel: EndLabel)')))-2 + StartLabel;
            MarkerLabels(i) = cellstr(char(char(ParameterSection(StartLabel: endOfCurrentLabel(1))')));
            i = i + 1;
            StartLabel = StartLabel + spaceBetweenLabels;
            if  ParameterSection(StartLabel) == tabBinaryCharacter;
                break
            end
        end
    end
elseif type == 4;
    
    ParameterSection = fread(fid, inf, 'char');
    StartLabels = findstr('LABELS', char(char(ParameterSection')));
    StartLabel = StartLabels(1)+12;
    EndLabels = findstr(endLabelsBinaryCharacter, ParameterSection(StartLabel:StartLabel+20000)');
    EndLabel = StartLabel + EndLabels(1);
    i = 1;
    while (i <= Nmarkers) & (i <= 255);
        endOfCurrentLabel = findstr(spaceBinaryCharacter, char(char(ParameterSection(StartLabel:EndLabel)')))-2 + StartLabel;
        MarkerLabels(i) = cellstr(char(char(ParameterSection(StartLabel: endOfCurrentLabel(1))')));
        i = i + 1;
        StartLabel = StartLabel + spaceBetweenLabels;
        
        if  ParameterSection(StartLabel) == tabBinaryCharacter;
            break
        end
    end
    %   Now check to see if LABELS2 exists
    if Nmarkers > 255;
        fseek(fid, 512*(NrecordFirstParameterblock-1), 'bof');
        ParameterSection = fread(fid, inf, 'char');
        StartLabels = findstr('LABELS2', char(char(ParameterSection')));
        StartLabel = StartLabels(1)+13;
        EndLabels = findstr(endLabelsBinaryCharacter, ParameterSection(StartLabel:StartLabel+20000)');
        EndLabel = StartLabel + EndLabels(1);
        i = 256;
        while i <= Nmarkers;
            endOfCurrentLabel = findstr(spaceBinaryCharacter, char(char(ParameterSection(StartLabel: EndLabel)')))-2 + StartLabel;
            MarkerLabels(i) = cellstr(char(char(ParameterSection(StartLabel: endOfCurrentLabel(1))')));
            i = i + 1;
            StartLabel = StartLabel + spaceBetweenLabels;
            if  ParameterSection(StartLabel) == tabBinaryCharacter;
                break
            end
        end
    end
else
    disp('Unsupported c3d file format!');
    return
end
%-------------------------------------------------------------------------------

%   --------------------------------------------------------------------------
%ParameterGroup(labelgrp).Parameter(labelprefix).data;
%now append the subject prefix to the marker list
%markerlist=strcat(label_prefix,markerlist);

%-------------------------------------------------------------------------------
%   Extract event information
if ParameterGroup(8).Parameter(7).dim(2)
    EventTimes = ParameterGroup(8).Parameter(7).data(2,:) - ((StartFrame-1)/VideoFrameRate);  % event times in seconds
    EventTypes = ParameterGroup(8).Parameter(3).data;                      % general(|) = 0, foot-strike(<>) = 1, foot-off (+) = 2;
    EventSides = ParameterGroup(8).Parameter(2).data;                      % 'left', 'right', 'general'
else
    disp('No event data found');
    EventTimes = [];
    EventTypes = [];
    EventSides = [];
end

% Finding order of markers to arrange in sequence
lengthKinVariableListIn = length(kinVariableListIn);

numberOfkinVariablesFound = 0;
for k=1:Nmarkers;
    for l=1:lengthKinVariableListIn
        if strcmp(MarkerLabels(k), kinVariableListIn(l))
            landmark(l)= k;
            numberOfkinVariablesFound = numberOfkinVariablesFound + 1;
        end
    end
end

%   Replace missing points with NaNs
for j = 1:3;
    requiredMarkers(:,:,j) = zeros(NvideoFrames,lengthKinVariableListIn);
end

for j = 1:3;
    filteredRequiredMarkers(:,:,j) = matfiltfilt(1/VideoFrameRate, fcut, order, requiredMarkers(:,:,j));
end
Markers = replacezeroswithnans(Markers);
requiredMarkers = replacezeroswithnans(requiredMarkers);
filteredRequiredMarkers = replacezeroswithnans(filteredRequiredMarkers);


%  Zero first marker data
if lower(outputType) == 'structure';      %   Output markers 2d arrays in a structure
    for i=1:length(landmark)
        if landmark(i) ~= 0
            eval(['markerStructure.' char(kinVariableList(i)) ' = squeeze(Markers(:, landmark(i),:))']);
        end
    end
    Markers = markerStructure;
    
else                            %   Output markers as a 3d array
    for i=1:length(landmark)
        if landmark(i) ~= 0
            requiredMarkers(:,i,:) = Markers(:, landmark(i),:);
            filteredRequiredMarkers(:,i,:) = Markers(:, landmark(i),:);
        end
    end
    Markers = replacezeroswithnans(requiredMarkers);
    FilteredMarkers = replacezeroswithnans(filteredRequiredMarkers);
end

if lower(outputType) == '2DimArray';     %   Output markers as a 2d array
    Markers = reduce3dto2d(Markers);
end

close(hWaitBar)
fclose(fid);
return