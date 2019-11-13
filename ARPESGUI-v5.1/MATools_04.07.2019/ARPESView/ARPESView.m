function varargout = ARPESView(varargin)
% ARPESVIEW M-file for ARPESView.fig
%      ARPESVIEW, by itself, creates a new ARPESVIEW or raises the existing
%      singleton*.
%      H = ARPESVIEW returns the handle to a new ARPESVIEW or the handle to
%      the existing singleton*.
%      ARPESVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ARPESVIEW.M with the given input arguments.
%      ARPESVIEW('Property','Value',...) creates a new ARPESVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EasyLineSetup_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ARPESView_OpeningFcn via varargin.
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help ARPESView
% Last Modified by GUIDE v2.5 26-May-2019 18:01:29
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ARPESView_OpeningFcn, ...
                   'gui_OutputFcn',  @ARPESView_OutputFcn, ...
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

% --- Executes just before ARPESView is made visible.
function ARPESView_OpeningFcn(hObject,~,handles,varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% varargin   command line arguments to ARPESView (see VARARGIN)
clear global; global IniDir DivRange scCoeff RunFile CubePos EWin minFrac maxFrac hGUI
% choose default command line output for ARPESView
handles.output = hObject;
% update handles structure
guidata(hObject, handles);
% initial directory
IniDir='X:\';
% run file and pushbutton visibility
if exist('C:\ARPES Tools','dir')==7
   RunFile='C:\temp\LastRun.h5';
else
   set(handles.pushbuttonRunFile,'Visible','Off');
end
% initial image normalization parameters
DivRange=[0.1 1]; scCoeff=0.0;
% openGL rendering necessary for R2013a or some graphics drivers
try opengl software; end
% data cube
axis(handles.axesCube,[-1 1 -1 1 -1 1]);
set(gca,'layer','top','box','on','Projection','Orthographic','TickLength',[0 0],'XTick',[],'YTick',[],'ZTick',[]); 
axis square tight; view(-86,6);
set(gca,'PlotBoxAspectRatio',[5 1 1]);
try set(gca,'boxstyle','full'); end % R2017b
CubePos=get(handles.axesCube,'Position');
% initial energy window
EWin=[-0.1 0]; set(handles.editEnergy,'String',sprintf('%g+-%g',[mean(EWin) diff(EWin)/2]));
% contrast parameters
minFrac=1e-2; maxFrac=1-1e-4; 
% GUI handle
hGUI=gcf;

% --- Outputs from this function are returned to the command line.
function varargout = ARPESView_OutputFcn(~,~,handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbuttonDirFile
function pushbuttonDirFile_Callback(~,~,handles)
% Hint: get(hObject,'Value') returns toggle state of togglebutton2
global FileName PathName IniDir DataFull DataXC
% loading filename
[FileName,PathName]=uigetfile({'*.h5;*.sp2'},'Data File',IniDir);
if isequal(PathName,0) || isequal(FileName,0); return; end % return if Cancel pressed
IniDir=PathName; FullName=[PathName FileName];
% display filename
set(handles.textFileName,'String',FileName);
% reset data and load file
DataFull=[]; DataXC=[]; LoadFile(handles,FullName);

% function editFileName_Callback(hObject,~,handles)
% % hObject    handle to textFileName (see GCBO)
% global RunFile PathName FileName
% % get full filename
% FullName=get(hObject,'String');
% if isempty(FullName); FullName=RunFile; set(hObject,'String',FullName); end
% if exist(FullName,'file')~=2 msgbox('Invalid File Name','modal'); return; end
% % retrieve filename
% lastSlash=strfind(FullName,filesep); lastSlash=lastSlash(end); 
% FileName=FullName(lastSlash+1:end); PathName=FullName(1:lastSlash);
% % load file
% LoadFile(handles,FullName);

% --- Executes on button press in pushbuttonRunFile
function pushbuttonRunFile_Callback(~,~,handles)
% hObject    handle to textFileName (see GCBO)
global RunFile FileName DataFull DataXC
% check if exists
if exist(RunFile,'file')~=2
   msgbox('Run File Inavailable','modal'); return; 
end
Pos=strfind(RunFile,'\'); FileName=RunFile(Pos(end)+1:end);
set(handles.textFileName,'String',FileName)
% reset data and load file
DataFull=[]; DataXC=[]; LoadFile(handles,RunFile);

% --- Executes on selection change in radiobuttonEqImages.
function radiobuttonEqImages_Callback(~,~,handles)
% hObject    handle to radiobuttonEqImages (see GCBO)
global PathName FileName
if isempty(PathName)||isempty(FileName)
   return
else
   LoadFile(handles,[PathName FileName]);
end

% ---  Loads data file.
function LoadFile(handles,FullName)
% LoadFile loads data file with the full name FullName
global FileName Angle AWin Energy ScanFull Scan SWin DataFull DataXC Data ep Note HV ECorr EAlign ACorr AutoAWin ...
       ISlice EInt DataInt IDiv ISubtr ScanType CubePos
% clear memory
ECorr=[]; EAlign=[]; ACorr=[]; ISlice=[]; EInt=[]; DataInt=[]; IDiv=[]; ISubtr=[]; ScanType=[];
% clear Scan field
set(handles.editScan,'String','')
% enable summation
set(handles.radiobuttonEqImages,'Enable','On')
% load file if new filename
if isempty(DataFull)
   try
      if isempty(DataFull)
         h=waitbar(0.5,'Reading In','Windowstyle','Modal'); 
         [Angle,Energy,ScanFull,DataFull,ep,Note]=ReadARPES(FullName); 
         close(h);
      end
   catch
      msgbox('Data Input Error','modal'); return;
   end
end
Data=DataFull; Scan=ScanFull;
% equivalent scans
if ~isempty(Scan)&&~all(diff(Scan))
   if get(handles.radiobuttonEqImages,'Value')==1
% - cross-correlated summation
      if isempty(DataXC)
         h=waitbar(0.5,'Reducing Equivalent Scans','Windowstyle','Modal');
         maxLagE=0.2; DataXC=SumScanXC(Energy,Data,maxLagE);
         close(h)
      end
      Data=DataXC; Scan=[];
   else
% - artificial Scan of the image numbers
      Scan=1:1:length(ScanFull); ScanType='Number';
   end
else
   set(handles.radiobuttonEqImages,'Enable','Off') 
end
% scan name
if isempty(ScanType)
PosColon=strfind(Note,':');
   if ~isempty(PosColon)
      PosEqual=strfind(Note,'='); PosEqual=PosEqual(PosEqual<PosColon(1)); posEqual=PosEqual(end);
      ScanType=Note(posEqual-8:posEqual-1); ScanType=deblank(ScanType);
   end
end
% HV
HV=[]; try
   pos1=strfind(Note,'hv'); pos2=strfind(Note,'Pol'); eval(['HV=' Note(pos1+10:pos2-2) ';']);
   if isempty(Scan)
      HV=HV(1);
   else
      HV=HV(1:length(Scan));
   end
end
% select compatible modes and show Scan range 
if isempty(Scan)||length(Scan)<2
   if get(handles.popupmenuViewMode,'Value')>2; set(handles.popupmenuViewMode,'Value',1); end 
   set(handles.popupmenuViewMode,'String',{'Image';'Angle-Int Image'})
else
   set(handles.popupmenuViewMode,'String',...
       {'Image';'Angle-Int Image';'Image Series';'Iso-E';'Angle-Int Scan'})
% - one scan or full scan range
   if get(handles.popupmenuViewMode,'Value')<=2
%      SWin=Scan(round(1+(length(Scan)-1)/2)); SWin=[SWin SWin];
      SWin=[Scan(end) Scan(end)];
   else
      SWin=[Scan(1) Scan(end)];
   end
   set(handles.editScan,'String',sprintf('%g:%g',SWin))
end
% select curvature and warping correction modes
pos=strfind(Note,'Corr');
if isequal(lower(Note(pos+10:pos+13)),'true')
   set(handles.radiobuttonCurvatureCorr,'Value',0,'Visible','Off')
   set(handles.radiobuttonWarpingCorr,'Value',0,'Visible','Off')
else
   set(handles.radiobuttonCurvatureCorr,'Value',1,'Visible','On')
   set(handles.radiobuttonWarpingCorr,'Value',1,'Visible','On')
   % disable curvature correction if HV unknown (edited in raw table) 
   if any(isnan(HV)); set(handles.radiobuttonWarpingCorr,'Value',0,'Visible','Off'); end
end
% curvature and warping correction
% - check if the data already corrected
if contains(FileName,'_Export') && ...
(get(handles.radiobuttonCurvatureCorr,'Value')==1||get(handles.radiobuttonWarpingCorr,'Value')==1)
   waitfor(warndlg('Data May Be Already Corrected','')); 
end
% - curvature corrected energy: 2D array
if isempty(ECorr)
   if get(handles.radiobuttonCurvatureCorr,'Value')==1
      ECorr=CurveCorr(Angle,Energy,ep);     
   else ECorr=repmat(Energy,1,length(Angle)); end
end
% - warping corrected angles: 2D array for images and angle scans/ 3D for hv scans
if isempty(ACorr)
   if get(handles.radiobuttonWarpingCorr,'Value')==1
      ACorr=WarpCorr(Angle,Energy,HV);
   else
      ACorr=repmat(Angle,length(Energy),1);
      if length(HV)>1; ACorr=repmat(ACorr,[1 1 length(HV)]); end
   end
end
% auto angle range
aMin=Angle(1); aMax=Angle(end); AutoAWin=round([0.95*aMin+0.05*aMax 0.05*aMin+0.95*aMax]*10)/10;
% angle window
AWin=AutoAWin; set(handles.editAngle,'String',sprintf('%g:%g',AWin))
% energy window
% EWin=[-0.1 0]; set(handles.editEnergy,'String',sprintf('%g+-%g',[mean(EWin) diff(EWin)/2]));
% draw data cube
axes(handles.axesCube); cla
% - 2D case
if isempty(Scan)||length(Scan)<2
   SWin=[0 0.5];
   axis([0 1 Angle([1 end]) (Energy([1 end]))']);
   set(gca,'Position',[1.01*CubePos(1) CubePos(2) 0.8*CubePos(3:4)],'PlotBoxAspectRatio',[0.5 1 1]);
% - 3D case
else
   axis([Scan([1 end]) Angle([1 end]) (Energy([1 end]))']); % axis square tight;
   set(gca,'Position',CubePos,'PlotBoxAspectRatio',[5 1 1])
end
set(handles.textAngle,'String',[sprintf('%0.1f',Angle(1)) '<Angle<' sprintf('%0.1f',Angle(end))]); 
set(handles.textEnergy,'String',[sprintf('%0.1f',Energy(1)) '<Eb/k<' sprintf('%0.1f',Energy(end))]);
if ~isempty(Scan); set(handles.textScan,'String',[sprintf('%0.1f',Scan(1)) '<Scan<' sprintf('%0.1f',Scan(end))]); end
% switch fields and visualize slices
SwitchShow(handles)
% reset export mode to data
set(handles.popupmenuExport,'Value',1,'Enable','Off')

% ---  Switches between different fields to show
function SwitchShow(handles)
global Angle AWin Energy EWin Scan SWin
% control groups
ShowNormScans=[handles.textNormScans handles.popupmenuNormScans];
% switch between modes
mode=get(handles.popupmenuViewMode,'Value');
axes(handles.axesCube);
switch mode
   case 1  % Image
   % - fields
   set([handles.editEnergy handles.editAngle ShowNormScans handles.pushbuttonReadSlope],'Enable','Off')
   if isempty(Scan); set(handles.editScan,'Enable','Off')
   else set(handles.editScan,'Enable','On'); set(handles.editScan,'String',sprintf('%g',SWin(end))); 
   end
   % - slice
   try DrawPatch(Angle,Energy,SWin(end)); end
   case 2  % Angle-Int Image
   % - fields
   set([handles.editScan handles.editAngle],'Enable','On')
   set([handles.editEnergy ShowNormScans handles.pushbuttonReadSlope],'Enable','Off');
   if isempty(Scan); set(handles.editScan,'Enable','Off')
   else set(handles.editScan,'Enable','On'); set(handles.editScan,'String',sprintf('%g',SWin(end))); end
   % - slice
   try DrawPatch(AWin,Energy,SWin(end)); end
   case 3   % Image Series
   % - fields
   set(handles.editScan ,'Enable','On')
   set([handles.editAngle handles.editEnergy ShowNormScans handles.pushbuttonReadSlope],'Enable','Off')
   if isempty(Scan); set(handles.editScan,'Enable','Off')
   else set(handles.editScan,'Enable','On'); set(handles.editScan,'String',sprintf('%g:%g',SWin)); end
   % - slice
   try DrawPatch(Angle,Energy,Scan); end
   case 4   % Iso-E
   % - fields
   set([handles.editEnergy ShowNormScans handles.pushbuttonReadSlope],'Enable','On')
   set([handles.editScan handles.editAngle],'Enable','Off')
   set(handles.editScan,'String',sprintf('%g:%g',SWin));
   % - slice
   try DrawPatch(Angle,EWin,Scan); end
   case 5   % Angle-Int Scan
   % - fields
   set(handles.editAngle,'Enable','On');   
   set([handles.editScan handles.editEnergy ShowNormScans handles.pushbuttonReadSlope],'Enable','Off')
   set(handles.editScan,'String',sprintf('%g:%g',SWin));
   % - slice
   try DrawPatch(AWin,Energy,Scan); end
end
% switch between 2D and 3D
if isempty(Scan)||length(Scan)<2
   set([handles.editEnergy handles.textScan handles.editScan],'Visible','Off');
else
   set([handles.editEnergy handles.textScan handles.editScan],'Visible','On');
end

% function to draw patch in data cube
function DrawPatch(AWin,EWin,SWin)
cla
vert = [SWin(end) AWin(end) EWin(1); SWin(1) AWin(end) EWin(1); 
        SWin(1) AWin(end) EWin(end); SWin(end) AWin(end) EWin(end); ...
        SWin(1) AWin(1) EWin(end); SWin(end) AWin(1) EWin(end); ...
        SWin(end) AWin(1) EWin(1); SWin(1) AWin(1) EWin(1)];
fac = [1 2 3 4; 4 3 5 6; 6 7 8 5; 1 2 8 7; 6 7 1 4; 2 3 5 8];
patch('Faces',fac,'Vertices',vert,'FaceColor','g','FaceAlpha',0.65,'EdgeColor','k');

% --- Executes on button press in pushbuttonInfo.
function pushbuttonInfo_Callback(~,~,~)
% hObject    handle to pushbuttonInfo (see GCBO)
global Note; msgbox(Note)

% --- Executes on selection change in popupmenuViewMode.
function popupmenuViewMode_Callback(~,~,handles)
% hObject    handle to popupmenuViewMode (see GCBO)
SwitchShow(handles)

% --- Executes on button press in radiobuttonCurvatureCorr.
function radiobuttonCurvatureCorr_Callback(~,~,~)
% clear correction
global ECorr EAlign DataInt ISlice; ECorr=[]; EAlign=[]; DataInt=[]; ISlice=[];
disp('- cleared ECorr EAlign DataInt ISlice')

% --- Executes on button press in radiobuttonWarpingCorr.
function radiobuttonWarpingCorr_Callback(~,~,~)
% clear correction
global ACorr ISlice; ACorr=[]; ISlice=[];
disp('- cleared ACorr ISlice')

% --- Executes on edit of editScan.
function editScan_Callback(hObject,~,handles)
global Angle AWin Energy Scan SWin
% read in
ScanStr=get(hObject,'String'); ScanStr=strrep(ScanStr,':',' '); ScanStr=strrep(ScanStr,'end','1e6');
SWin=sort(str2num(ScanStr));
% check validity and substitute by the last if invalid
if isempty(SWin); SWin=Scan(end); end
% substitute by actual scan values
[~,n1]=min(abs(Scan-SWin(1))); [~,n2]=min(abs(Scan-SWin(end))); SWin=Scan([n1 n2]);
% display
if diff(SWin)==0; set(hObject,'String',sprintf('%g',SWin(1))); 
else set(hObject,'String',sprintf('%g:%g',SWin)); 
end
% draw slice
axes(handles.axesCube);
mode=get(handles.popupmenuViewMode,'Value');
if mode==1||mode==3; DrawPatch(Angle,Energy,SWin); else DrawPatch(AWin,Energy,SWin); end

% --- Executes on edit of editAngle.
function editAngle_Callback(hObject,~,handles)
global DataInt ISlice Angle AutoAWin AWin Energy Scan SWin
% read in
AngleStr=get(hObject,'String'); AngleStr=strrep(AngleStr,':',' '); AWin=sort(str2num(AngleStr)); 
% check validity and substitute by automatic range if invalid/ 0.1-wide window if one value 
if isempty(AWin); AWin=AutoAWin; end
% if length(AWin)==1; AWin=[AWin-0.1 AWin+0.1]; end
if length(AWin)==1 || diff(AWin)<0.2; AWin=[mean(AWin)-0.1 mean(AWin)+0.1]; end 
% restrict within Angle limits leaving at least 0.2-interval
AWin(1)=max(AWin(1),Angle(1)); AWin(1)=min(AWin(1),Angle(end)-0.2);
AWin(2)=min(AWin(2),Angle(end)); AWin(2)=max(AWin(2),Angle(1)+0.2);
% round up to 0.1
AWin=round(AWin*10)/10;
% display
set(hObject,'String',sprintf('%g:%g',AWin))
% draw slice
axes(handles.axesCube); 
if get(handles.popupmenuViewMode,'Value')==5; DrawPatch(AWin,Energy,Scan);
else DrawPatch(AWin,Energy,SWin);
end
% clear slice
DataInt=[]; ISlice=[]; disp('- cleared AngleInt ISlice')

% --- Executes on button press in editEnergy.
function editEnergy_Callback(hObject,~,handles)
global Angle Energy Scan ISlice EWin
% read in energy window
eStr=get(hObject,'String'); pmPos=strfind(deblank(eStr),'+-');
eSlice=str2num(eStr(1:pmPos-1)); dE=str2num(eStr(pmPos+2:end));
% validity check
if isempty(eSlice*dE); msgbox('Check Energy Window Format E+-dE','modal'); return; end
if eSlice-dE<min(Energy)||eSlice+dE>max(Energy); msgbox('Check Energy Window Ranges','modal'); return; end
EWin=[eSlice-dE eSlice+dE];
% draw slice
axes(handles.axesCube); DrawPatch(Angle,EWin,Scan)
% clear slice
ISlice=[]; disp('- cleared ISlice')

% --- Executes on button press in radiobuttonLockEF.
function radiobuttonLockEF_Callback(~,~,~)
% hObject    handle to radiobuttonLockEF (see GCBO)
% clear alignment
global EAlign DataInt IDiv ISlice; EAlign=[]; DataInt=[]; IDiv=[]; ISlice=[];
disp('- cleared EAlign DataInt ISlice')

% --- Executes on button press in editLockEF.
function editLockEF_Callback(hObject,~,handles)
% hObject    handle to editLockEF (see GCBO)
if isempty(str2num(get(hObject,'String'))); set(hObject,'String','0.0'); end
set(handles.radiobuttonLockEF,'Value',1)
% clear slice
global EAlign DataInt IDiv ISlice; EAlign=[]; DataInt=[]; IDiv=[]; ISlice=[];
disp('- cleared EAlign DataInt ISlice')

% --- Executes on button press in radiobuttonProcData.
function radiobuttonProcData_Callback(~,~,~)
% hObject    handle to radiobuttonProcData (see GCBO)
global ISlice; ISlice=[]; disp('- cleared ISlice')

% --- Executes on button press in pushbuttonNormDataParams.
function pushbuttonNormDataParams_Callback(hObject,~,handles)
% hObject    handle to pushbuttonNormDataParams (see GCBO)
set(handles.radiobuttonProcData,'Value',1)
if get(hObject,'Value')==1; ProcData; end

% --- Executes on button press in pushbuttonView.
function pushbuttonView_Callback(~,~,handles)
% hObject    handle to pushbuttonView (see GCBO)
global FileName ScanType Angle AWin EWin HV Scan SWin Data ECorr EAlign ACorr AutoAWin ISlice ASlice
global DivRange IDiv scCoeff ISubtr mode EInt DataInt X Y Z minFrac maxFrac colorScheme
% return if no data
if isempty(Data); return; end
%
% *** parameters ***
% image mode
mode=get(handles.popupmenuViewMode,'Value');
% colorscheme
modeMap=get(handles.popupmenuColormap,'Value');
modeMapC=get(handles.popupmenuColormap,'String');
colorScheme=char(modeMapC(modeMap)); colorScheme=[colorScheme '(256)'];
% scan window indices
[~,nS1]=min(abs(Scan-SWin(1))); [~,nS2]=min(abs(Scan-SWin(end)));
%
% *** begin 2D block (mode<=2) ***
% - separated for the fastest single image pocessing and for preserving the slow to calculate 3D data
if mode<=2
% 2D data
if isempty(Scan); Data2=Data; ACorr2=ACorr;
% frame of 3D data
else
% extraction and summation of the frames
   if length(HV)>1; ACorr2=ACorr(:,:,nS1:nS2); ACorr2=mean(ACorr2,3); else ACorr2=ACorr; end
   Data2=mean(Data(:,:,nS1:nS2),3);
end
% align the energy scale at EF
if get(handles.radiobuttonLockEF,'Value')==1
   eWin=str2num(get(handles.editLockEF,'String'));
   [EAlign2,~,Fail]=AlignEF(Data2,ECorr,eWin);
%    if ~isempty(Fail); uiwait(msgbox('Warning: Failed to Lock EF','modal')); end
else
   EAlign2=ECorr;
end
% normalize by intensity in the defined energy window
if get(handles.radiobuttonProcData,'Value')==1
   [~,INorm2]=Cut(ACorr2,EAlign2,Data2,'mdc',DivRange);
   INorm2=Gaco2(INorm2,5,0); % HWHM adjusted to suppress effect of uneven sensitivity of the CCD channels
   Data2=Data2./repmat(INorm2,size(Data2,1),1);
% subtract angle-integrated spectrum and zero negative values
   if scCoeff~=0
      [~,ISubtr2]=Cut(ACorr2,EAlign2,Data2,'edc',AutoAWin);
      Data2=Data2-scCoeff*repmat(ISubtr2,1,size(Data2,2)); Data2(Data2<0)=0;
   end
end
switch mode
% image output
case 1
   X=ACorr2; Y=EAlign2; Z=Data2;
case 2
% angle integrate and plot output
   [DataInt2,EInt2]=IntAngle(Data2,Angle,EAlign2,AWin);
   X=EInt2; Y=DataInt2; Z=[];
end
% *** end 2D block ***
%
% *** begin 3D block (mode>2) ***
else
% align the energy scale at EF if EAlign empty (not yet calculated)
if isempty(EAlign) 
   if get(handles.radiobuttonLockEF,'Value')==1
      h=waitbar(0.5,'Aligning EF','Windowstyle','Modal'); % waitbar
% - parameters and alignment       
      eWin=str2num(get(handles.editLockEF,'String'));
      [EAlign,~,Fail]=AlignEF(Data,ECorr,eWin);
%     if ~isempty(Fail); uiwait(msgbox(['Warning: Failed to Lock EF in ' num2str(length(Fail)) ' images'],'modal')); end  
      close(h) % close waitbar  
   else
      EAlign=repmat(ECorr,[1 1 length(Scan)]);
   end
end
% normalize by intensity in the defined energy window
Data3=Data;
if get(handles.radiobuttonProcData,'Value')==1
   if isempty(IDiv)
      ISlice=[]; DataInt=[];
      h=waitbar(0.5,'Forming Normalization Array','Windowstyle','Modal');
         IDiv=Slice(ACorr,EAlign,Data3,'isoE',DivRange);
      close(h)
      IDiv=Gaco2(IDiv,5,0); % HWHM adjusted to suppress uneven sensitivity of the CCD channels
      IDiv=repmat(IDiv,1,1,size(Data3,1)); IDiv=permute(IDiv,[3 2 1]);
   end
   Data3=Data3./IDiv;
% subtract angle-integrated spectrum and zero negative values
   if scCoeff~=0
      if isempty(ISubtr)
         ISlice=[]; DataInt=[];
         h=waitbar(0.5,'Forming Subtraction Array','Windowstyle','Modal');
            ISubtr=Slice(ACorr,EAlign,Data3,'isoK',AutoAWin);
         close(h) 
         ISubtr=repmat(ISubtr,1,1,size(Data3,2)); ISubtr=permute(ISubtr,[1 3 2]);
      end    
      Data3=Data3-scCoeff*ISubtr; Data3(Data3<0)=0;
   end
end
% processing and image modes
switch mode
%
% **** series of images mode ****
case 3
% plot images in the selected Scan range
   if size(ACorr,3)>1; ACorrV=ACorr(:,:,nS1:nS2); else ACorrV=ACorr; end
   if size(EAlign,3)>1; EAlignV=EAlign(:,:,nS1:nS2); else EAlignV=EAlign; end
   nRows=3; nCols=3; ViewSeries(ACorrV,EAlignV,Scan(nS1:nS2),Data3(:,:,nS1:nS2),nRows,nCols,colorScheme,minFrac,maxFrac)
%
% *** iso-E mode ***
case 4
% slice formation if ISlice empty
   if isempty(ISlice)
% - slice formation waitbar
      h=waitbar(0.5,'Forming Data Slice','Windowstyle','Modal');
% - slice within EWin
      [ISlice,ASlice]=Slice(ACorr,EAlign,Data3,'isoE',EWin);
% - close waitbar
   close(h)   
   end
% normalization
   normScanMode=get(handles.popupmenuNormScans,'Value');
   switch normScanMode
% - no normalization    
   case 1
      ISliceN=ISlice;
   otherwise    
% - integral intensity of scans over 90% of angular range
      Ind=find(AutoAWin(1)<Angle&Angle<AutoAWin(end));
      ISliceN=ISlice(:,Ind); ISliceN=sum(ISliceN,2)/(Ind(end)-Ind(1)+1);
% - 2-order smoothing of integral intensity if normalization set to 'Smooth'
      if normScanMode==3; P=polyfit(Scan',ISliceN,2); ISliceN=polyval(P,Scan'); end
% - normalization
      ISliceN=ISlice./repmat(ISliceN,1,length(Angle));
% % - bilinear over 90% of angular range
%       [~,Coeffs]=Flat(AngleN,Scan,ISliceN);
%       [AngleM,ScanM]=meshgrid(Angle,Scan);
%       ISliceN=ISlice./(Coeffs(1)*AngleM+Coeffs(2)*ScanM+Coeffs(3));
   end
% - image output
   X=ASlice; Y=Scan'; Z=ISliceN;
%
% *** angle integration mode ***  
case 5
% angle integrated
   if isempty(DataInt)
      h=waitbar(0.5,'Angle Integrating','Windowstyle','Modal'); % waitbar
      [DataInt,EInt]=IntAngle(Data3,Angle,EAlign,AWin);
      close(h) % close waitbar
   end
% image output
   X=EInt'; Y=Scan'; Z=DataInt';
end
% enable image export
set(handles.popupmenuExport,'Enable','On')
% *** end 3D block ***
end
%
% *** plot ***
Opts.colorScheme=colorScheme; Opts.Scan=Scan; Opts.mode=mode; Opts.FileName=FileName; Opts.ScanType=ScanType;
PlotAll(X,Y,Z,Opts,handles)

% --- Plot and set callbacks function
function PlotAll(X,Y,Z,Opts,handles)
% global colorScheme Scan SWin eSlice dE mode FileName hFig ScanType
global minFrac maxFrac hFig
% reject image series
if Opts.mode==3; return; end
% deactivate slope readout
set(handles.pushbuttonReadSlope,'Enable','Off');
% new figure with zoom and set active figure callbacks; handles passes as argument to WindowButtonUpFcn 
hFig=figure('WindowButtonDownFcn',{@window_Zoom,handles},'WindowButtonUpFcn',{@window_H,handles}); %hFig=gcf;
% linear plot
if isempty(Z)
   plot(X,Y); axis tight; set(gca,'TickDir','Out')
% image plots   
else
% set contrast
   Z=SetContrast(Z,minFrac,maxFrac);
%   if get(handles.popupmenuNorm,'Value')==1; Z=Z*scale; end
% different image modes
   switch Opts.mode
% - image
      case 1
         ImData(X,Y,Z,'Flat'); colorbar;  eval(['colormap ''' Opts.colorScheme ''''])
% - iso-E
      case 4
         ImData(X,Y,Z,'Flat'); colorbar; eval(['colormap ''' Opts.colorScheme ''''])
% - Iso-E(Angle)         
%         if max(Y<=45); % Iso-E(Angle)
         if isequal(Opts.ScanType,'Tilt')
            set(gca,'YDir','Reverse'); axis equal tight;
            set(handles.pushbuttonReadSlope,'Enable','On');
         end
% - angle-integrated scan
      case 5
         ImData(X,Y,Z,'Flat'); colorbar; eval(['colormap ''' Opts.colorScheme ''''])
   end
end
% title and axes information
if Opts.mode~=3
switch Opts.mode
   case 1
      if isempty(Opts.Scan); titleStr=Opts.FileName;   
      else titleStr=[Opts.FileName ', Scan=' get(handles.editScan,'string')]; 
      end
      xlabel('Angle (deg)'); 
      if min(Y)>100; ylabel('E_{k} (eV)'); else ylabel('E_{B} (eV)'); end
   case 2
      if isempty(Opts.Scan); titleStr=[Opts.FileName ', Angle=' get(handles.editAngle,'string')];   
      else titleStr=[Opts.FileName ', Scan=' get(handles.editScan,'string') ', Angle=' get(handles.editAngle,'string')]; 
      end
      if min(X)>100; xlabel('E_{k} (eV)'); else xlabel('E_{B} (eV)'); end
      ylabel('Intensity');
   case 4
      titleStr=[Opts.FileName ', E=' get(handles.editEnergy,'string')];
      xlabel('Angle (deg)');
      switch(Opts.ScanType)
         case 'Number'; ylabel('Image Number');
         case 'hv'; ylabel('hv (eV)');
         case {'Theta','Tilt','Azimuth'}; ylabel([Opts.ScanType ' (deg)'])
         case {'X','Z'}; ylabel([Opts.ScanType ' (mm)'])   
      end
   case 5
      titleStr=[Opts.FileName,', Angle=' get(handles.editAngle,'string')];
      if min(X)>100; xlabel('E_{k} (eV)'); else xlabel('E_{B} (eV)'); end
      switch(Opts.ScanType)
         case 'Number'; ylabel('Image Number');
         case 'hv'; ylabel('hv (eV)');
         case {'Theta','Tilt','Azimuth'}; ylabel([Opts.ScanType ' (deg)'])
         case {'X','Z'}; ylabel([Opts.ScanType ' (mm)']) 
      end
end
if get(handles.radiobuttonProcData,'value')==1; titleStr=[titleStr ', ProcData=Yes']; end
if isequal(get(handles.popupmenuNormScans,'enable'),'on') && get(handles.popupmenuNormScans,'value')~=1; 
   titleStr=[titleStr ', NormScans=Yes']; 
end
title(titleStr,'Interpreter','none','fontweight','normal'); 
end
% user data
UserData.Opts=Opts; UserData.X=X; UserData.Y=Y; UserData.Z=Z;
set(gcf,'UserData',UserData)
% white background
set(gcf,'color','w')
% activate CloseFigs
set(handles.CloseFigs,'Enable','On')

% --- Zoom function
function window_Zoom(~,~,handles)
% global mode X Y Z hFig
% retrieve user data from the figure
hFig=gcf;
UserData=get(hFig,'UserData');
Opts=UserData.Opts; X=UserData.X; Y=UserData.Y; Z=UserData.Z; 
% reject image series
if Opts.mode==3; return; end
% keep the plot figure handle spoiled by rbbox
hhFig=hFig;
% previous limits
XLim0=get(gca,'XLim'); YLim0=get(gca,'YLim'); 
% rbbox and its borders
p1=get(gca,'CurrentPoint'); p1x=p1(1,1); p1y=p1(1,2);
rbbox; 
p2=get(gca,'CurrentPoint'); p2x=p2(1,1); p2y=p2(1,2); 
% restore the plot figure handle
hFig=hhFig;
% process current point
XLim=sort([p1x p2x]); YLim=sort([p1y p2y]);
XLim=[max(XLim(1),XLim0(1)) min(XLim(2),XLim0(2))]; 
YLim=[max(YLim(1),YLim0(1)) min(YLim(2),YLim0(2))];
% return if rbbox is too small
% if diff(XLim)*diff(YLim)==0; return; end
if diff(XLim)*diff(YLim)<0.001*diff(XLim0)*diff(YLim0); return; end
% % return if not the last plotted figure
% if ~isequal(gcf,hhFig); 
%    hMsg=msgbox('Zooming Active Only in the Last Plot','modal'); pause(2); close(hMsg); return; 
% end
% trimming of images to re-colorscale
ZZ=Z;
switch Opts.mode
case 1
   ZZ(X<XLim(1)|X>XLim(2))=NaN; ZZ(Y<YLim(1)|Y>YLim(2))=NaN;
case 2
   ZZ=[];
case 4
   YY=repmat(Y,1,size(X,2));
   ZZ(X<XLim(1)|X>XLim(2))=NaN; ZZ(YY<YLim(1)|YY>YLim(2))=NaN;
case 5
   [XX,YY]=meshgrid(X,Y);
   ZZ(XX<XLim(1)|XX>XLim(2))=NaN; ZZ(YY<YLim(1)|YY>YLim(2))=NaN; 
end
% draw zoomed figure
% close(gcf) % replace previous figure
PlotAll(X,Y,ZZ,Opts,handles); set(gca,'XLim',XLim,'YLim',YLim)

% --- sets global handle of the active figure for readout
function window_H(~,~,handles)
global hFig hGUI
hFig=gcf;
% return if GUI
if isequal(hFig,hGUI); return; end
% activate slope readout
A=daspect;
if isequal(A(1),A(2)); set(handles.pushbuttonReadSlope,'Enable','On'); 
else set(handles.pushbuttonReadSlope,'Enable','Off'); end

% --- Executes on button press in pushbuttonReadPoint.
function pushbuttonReadPoint_Callback(~,~,handles)
% hObject    handle to pushbuttonReadPoint (see GCBO)
global hFig hLine
% return if the window already closed
try dummy=get(hFig); catch; return; end
% set current figure
figure(hFig);
% remove previous line
try delete(hLine); end
% graphical input
XY=ginput(1);
% show coordinates
set(handles.textReadout,'String',{['X=' num2str(XY(1))];['Y=' num2str(XY(2))]})

% --- Executes on button press in pushbuttonReadSlope.
function pushbuttonReadSlope_Callback(~,~,handles)
% hObject    handle to pushbuttonReadSlope (see GCBO)
global hFig hLine
% return if the window already closed
try dummy=get(hFig); catch; return; end
% set current figure
figure(hFig);
% remove previous line
try delete(hLine); end
% graphical input using ginput
XY=ginput(2);
hold on; hLine=line(XY(:,1),XY(:,2),'Color','W'); hold off
% graphical input using imline
% set(hFig,'WindowButtonDownFcn','Off','WindowButtonUpFcn','Off');
% hLine=imline(hFig); wait(hLine);
% set(hFig,'WindowButtonDownFcn',{@window_Zoom,handles},'WindowButtonUpFcn',{@window_H,handles});
% evaluate slope
Fit=polyfit(XY(:,1),XY(:,2),1); slope=atand(Fit(1));
% show slope
set(handles.textReadout,'String',['Slope=' num2str(slope)]);

% --- Executes on button press in CloseFigs.
function CloseFigs_Callback(~,~,~)
% hObject    handle to CloseFigs (see GCBO)
% handles of all figures
hPlots=findobj('Type','figure');
% remove the GUI handle
hGUI=gcf; hPlots=hPlots(hPlots~=hGUI);
% close all plots
close(hPlots)

% --- Executes on button press in pushbuttonExport.
function pushbuttonExport_Callback(~,~,handles)
% hObject    handle to pushbuttonExport (see GCBO)
% global Angle Energy Scan Data X Y Z ep HV Note ECorr EAlign ACorr FileName PathName
global Scan Data X Y Z Note ECorr EAlign ACorr FileName PathName
DataX=Data; ECorrX=ECorr; EAlignX=EAlign; ACorrX=ACorr;
% check data and activated corrections
if isempty(DataX); errordlg('No Data','','modal'); return; end
if get(handles.radiobuttonCurvatureCorr,'Value')==0 && ...
   get(handles.radiobuttonWarpingCorr,'Value')==0 && ...
   get(handles.radiobuttonLockEF,'Value')==0 && ...
   get(handles.radiobuttonProcData,'Value')==0
   errordlg('No Active Corrections Selected','','modal'); return;
end
if contains(FileName,'_Export'); waitfor(warndlg('Data file may be already exported','')); end 
% filename to export
Dots=strfind(FileName,'.'); dot=Dots(end);
[filename,pathname]=uiputfile('*.h5','Export As',[PathName FileName(1:dot-1) '_Export.h5']);
if filename~=0; filename=[pathname filename];
else errordlg('Invalid Filename','','modal'); return;
end
% select export of the current image  
if get(handles.popupmenuExport,'Value')==2
   ACorrX=X; EAlignX=Y; DataX=Z;
% select export of the whole data
else
% curvature corrected energy: 2D array
%    if isempty(ECorrX) 
%       if get(handles.radiobuttonCurvatureCorr,'Value')==1
%          ECorrX=CurveCorr(Angle,Energy,ep);
%       else
%          ECorrX=repmat(Energy,1,length(Angle));
%       end
%    end
% % warping corrected angles: 2D array for images and angle scans/ 3D for hv scans
%    if isempty(ACorrX)
%       if get(handles.radiobuttonWarpingCorr,'Value')==1
%          ACorrX=WarpCorr(Angle,Energy,HV);
%       else
%          ACorrX=repmat(Angle,length(Energy),1);
%          if length(HV)>1; ACorrX=repmat(ACorrX,[1 1 length(HV)]); end
%       end
%    end
% align the energy scale at EF
   if isempty(EAlignX)
      if get(handles.radiobuttonLockEF,'Value')==1
         eWin=str2num(get(handles.editLockEF,'String'));
         [EAlignX,~,Fail]=AlignEF(DataX,ECorrX,eWin);
%         if ~isempty(Fail); uiwait(...
%            msgbox(['Warning: Failed to Lock EF in ' num2str(length(Fail)) ' images'],'modal')); 
%         end
      else
         EAlignX=ECorrX;
      end
   end
end
% open waitbar
h=waitbar(0.5,'Remapping/Saving','Windowstyle','Modal');
% remapping
[AngleR,EnergyR,DataR]=Remap(ACorrX,EAlignX,DataX);
% conversion to int32
DataR=int32(DataR);
% arrays in the IGOR-compatible format
xaxis = [AngleR(1) mean(diff(AngleR))];
yaxis = [EnergyR(1) mean(diff(EnergyR))];
if isempty(Scan)
    scale = [0 0; xaxis; yaxis;];
else
    DataR = permute(DataR, [3 1 2]);
    scan = [Scan(1) mean(diff(Scan))];
    scale = [0 0; xaxis; yaxis; scan];
end
% delete the file to overwrite which otherwise causes error in h5create
if exist(filename,'file'); delete(filename); end
% write into HDF5 file
h5create(filename, '/Matrix', size(DataR));
h5write(filename, '/Matrix', DataR);
h5writeatt(filename, '/Matrix', 'IGORWaveNote', Note);
h5writeatt(filename, '/Matrix', 'IGORWaveScaling', fliplr(scale)');
% close waitbar 
close(h);

% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(~,~,~)
% hObject    handle to figure1 (see GCBO)
% handles of all figures
hPlots=findobj('Type','figure');
% close all figures including the GUI
close(hPlots)
