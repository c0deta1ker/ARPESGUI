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
% Last Modified by GUIDE v2.5 09-Jun-2020 16:30:18
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
clear global; global IniDir RunFile CubePos EWin valPre hGUI
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
% openGL rendering necessary for R2013a or some graphics drivers
try opengl software; end
% data cube
axis(handles.axesCube,[-1 1 -1 1 -1 1]);
set(gca,'layer','top','box','on','Projection','Orthographic','TickLength',[0 0],'XTick',[],'YTick',[],'ZTick',[]); 
axis square tight; view(-86,6);
set(gca,'PlotBoxAspectRatio',[5 1 1]);
try set(gca,'boxstyle','full'); end % R2017b
CubePos=get(handles.axesCube,'Position');
% initial iso-energy window
EWin=[-0.1 0]; valPre=0; %set(handles.editEnergy,'String',sprintf('%g+-%g',[mean(EWin) diff(EWin)/2]));
% Setup panels
% - LockSetup
global dEWin_Lock dEWinIni dESm_Lock dESmIni  feat_Lock featIni setTo_Lock setToIni
dEWinIni=[]; dEWin_Lock=dEWinIni; dESmIni=[]; dESm_Lock=dESmIni; featIni='Edge'; feat_Lock=featIni; setToIni=0.0; setTo_Lock=setToIni;
% - NormSetup
global scCoeffIni scCoeff_Norm RangeIni
scCoeffIni=0.75; scCoeff_Norm=scCoeffIni; RangeIni=[];
% - ViewSetup
global Frac_View FracIni render XRange YRange
FracIni=[1e-2 1-1e-4]; Frac_View=FracIni; render='Flat';
XRange=[]; YRange=[];
% % - NaviSetup
% % global hvNorm_Navi hvNormIni kxNorm_Navi kxNormIni thtANorm_Navi thtANormIni thtMNorm_Navi thtMNormIni surfNx
% % hvNormIni=0; hvNorm_Navi=hvNormIni; kxNormIni=0; kxNorm_Navi=kxNormIni; thtANormIni=0; thtANorm_Navi=thtANormIni; 
% % thtMNormIni=0; thtMNorm_Navi=thtMNormIni; surfNx=0;
% global surfNx surfNx=[];
% position of the Kz-transform fields
PosHvKz=get(handles.popupmenuHvKz,'Position'); PosTextVo=get(handles.textVo,'Position'); PosEditVo=get(handles.editVo,'Position');
PosSurfNy=get(handles.editSurfNy,'Position'); shift=PosHvKz(2)-PosSurfNy(2);
set(handles.popupmenuHvKz,'Position',[PosHvKz(1) PosHvKz(2)-shift PosHvKz(3:4)]);
set(handles.textVo,'Position',[PosTextVo(1) PosTextVo(2)-shift PosTextVo(3:4)]);
set(handles.editVo,'Position',[PosEditVo(1) PosEditVo(2)-shift PosEditVo(3:4)]);
% % initial state of popupmenus
% global valMenuLockPre; valMenuLockPre=1;
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
global FileName FullName IniDir DataFull DataXC FullList
% loading filename
[filename,pathname]=uigetfile({'*.h5;*.sp2'},'Data File',IniDir);
if isequal(filename,0) || isequal(path,0); return; end % return if Cancel pressed
IniDir=pathname; FileName=filename; FullName=[pathname filename];
% reset data and load file
DataFull=[]; DataXC=[]; LoadFile(handles,FullName);
% file list
% - trim filename to show in popupmenu
lenMax=37; if length(FullName)>lenMax TrimName=['...' FullName(max(1,end-(lenMax-4)):end)]; else TrimName=FullName; end
% - full- and trimmed-name lists
TrimList=get(handles.popupmenuFileList,'String');
if isempty(TrimList); FullList={FullName}; TrimList={TrimName};
else
   FullList=[{FullName};FullList]; TrimList=[{TrimName};TrimList];
end
% remove previous identical filenames
for iList=2:size(FullList,1)
%   [num2str(iList) '   ' FullList{iList} '   ' FullName '   ' num2str(strcmp(FullList{iList},FullName))]
   if strcmp(FullList{iList},FullName)==1; FullList(iList,:)=[]; TrimList(iList,:)=[]; break; end 
end
% - max number of last files 
maxList=5; FullList=FullList(1:min(end,maxList)); TrimList=TrimList(1:min(end,maxList));
% - set popupmenu 
set(handles.popupmenuFileList,'String',TrimList,'Value',1);

% --- Executes on selection change in popupmenuFileList.
function popupmenuFileList_Callback(hObject,~,handles)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuFileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuFileList
global DataFull DataXC FullList FullName
n=get(hObject,'Value'); FullName=FullList(n); FullName=FullName{1};
% reset data and load file
DataFull=[]; DataXC=[]; LoadFile(handles,FullName);

% --- Executes on button press in pushbuttonRunFile
function pushbuttonRunFile_Callback(~,~,handles)
% hObject    handle to popupmenuFileList (see GCBO)
global RunFile FileName FullName DataFull DataXC
% check if exists
if exist(RunFile,'file')~=2
   msgbox('Run File Inavailable','modal'); return;
end
Pos=strfind(RunFile,'\'); FileName=RunFile(Pos(end)+1:end); FullName=RunFile;
% set(handles.popupmenuFileList,'String',FullName)
% reset data and load file
DataFull=[]; DataXC=[]; LoadFile(handles,FullName);

% --- Executes on selection change in radiobuttonEqImages.
function radiobuttonEqImages_Callback(~,~,handles)
% hObject    handle to radiobuttonEqImages (see GCBO)
global FullName
if isempty(FullName); return; else; LoadFile(handles,FullName); end

% ---  Function to load data file
function LoadFile(handles,FullName)
% LoadFile loads data file with the full name FullName
global Energy Angle ScanFull Scan SWin DataFull DataXC Data ep Note HV thtM tltM ScanType ACorr ECorr ...
          dEWinIni dESmIni EAlign dESm_Lock dEWin_Lock feat_Lock ERange ARange AutoAWin AKx Kx KxRange ...
          AutoKxWin AKxRange AKxWin IDiv ISubtr CubePos RangeIni Range_Norm
% clear arrays
Kx=[]; IDiv=[]; ISubtr=[]; ScanType=[];
disp('- cleared Kx IDiv ISubtr ScanType')
% clear Scan field
set(handles.editScan,'String','')
% enable summation
set(handles.radiobuttonEqImages,'Enable','On')
% load file if new filename
if isempty(DataFull)
   try
      h=waitbar(0.5,'Reading In','Windowstyle','Modal'); 
      [Angle,Energy,ScanFull,DataFull,ep,Note]=ReadARPES(FullName); 
      close(h);
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
   pos1=strfind(Note,'hv'); pos2=strfind(Note,'Pol'); eval(['HV=' Note(pos1+10:pos2-2) ';']); HV=HV(1,:);
   if isempty(Scan) HV=HV(1); else HV=HV(1:length(Scan)); end % if the scan incomplete
end
% thtM
thtM=[]; try
   pos1=strfind(Note,'Theta   = '); pos2=strfind(Note,'Tilt'); eval(['thtM=' Note(pos1+9:pos2-2) ';']);
   if length(thtM)>1; thtM=[]; end
end
% tltM
tltM=[]; try
   pos1=strfind(Note,'Tilt    = '); pos2=strfind(Note,'Azimuth'); eval(['tltM=' Note(pos1+9:pos2-2) ';']);
   if length(tltM)>1; tltM=[]; end
end
% select compatible modes and show Scan range 
if isempty(Scan)||length(Scan)<2
   if get(handles.popupmenuViewMode,'Value')>2; set(handles.popupmenuViewMode,'Value',1); end 
   set(handles.popupmenuViewMode,'String',{'Image';'Angle-Int Img'})
   SWin=[0 0.5];
else
   set(handles.popupmenuViewMode,'String',{'Image';'Angle-Int Img';'Image Series';'Iso-E';'Iso-Angle/Kx'})
   SWin=[Scan(1) Scan(end)];
end
% select curvature and warping correction modes
pos=strfind(Note,'Corr');
if isequal(lower(Note(pos+10:pos+13)),'true')
   set(handles.radiobuttonCurvatureCorr,'Value',0,'Visible','Off')
   set(handles.radiobuttonWarpingCorr,'Value',0,'Visible','Off')
else
%    set(handles.radiobuttonCurvatureCorr,'Value',1,'Visible','On')
%    set(handles.radiobuttonWarpingCorr,'Value',1,'Visible','On')
   set(handles.radiobuttonCurvatureCorr,'Visible','On')
   set(handles.radiobuttonWarpingCorr,'Visible','On')
   % disable curvature correction if HV unknown (edited in raw table) 
   if any(isnan(HV)); set(handles.radiobuttonWarpingCorr,'Value',0,'Visible','Off'); end
end
% curvature and warping correction
% - check if the data already corrected
if contains(FullName,'_Export') && ...
(get(handles.radiobuttonCurvatureCorr,'Value')==1||get(handles.radiobuttonWarpingCorr,'Value')==1)
   waitfor(warndlg('Data may be already corrected','')); 
end
% - curvature corrected energy: 2D array
if get(handles.radiobuttonCurvatureCorr,'Value')==1
   ECorr=CurveCorr(Angle,Energy,ep);   
else ECorr=repmat(Energy,1,length(Angle)); 
end
% - warping corrected angles: 2D array for images and angle scans/ 3D for hv scans
if get(handles.radiobuttonWarpingCorr,'Value')==1
   ACorr=WarpCorr(Angle,Energy,HV);
else
   ACorr=repmat(Angle,length(Energy),1);
   if length(HV)>1; ACorr=repmat(ACorr,[1 1 length(HV)]); end
end
% % - - correcting average Angle
%    Angle=mean(ACorr,3); Angle=mean(Angle,1);
% angle range and auto window
ARange=[min(min(ACorr(:,1,:))) max(max(ACorr(:,end,:)))];
aMin=max(max(ACorr(:,1,:))); aMax=min(min(ACorr(:,end,:))); AutoAWin=[0.95*aMin+0.05*aMax 0.05*aMin+0.95*aMax];
AKx=ACorr; AKxRange=ARange; AKxWin=AutoAWin;
% aligned energy and its range 
% In the case the aligment fails, should it be left here or better disactivate the menu? Left here, consistently with Angle->Kx and Norm/Subtr 
% set(handles.popupmenuLock,'Value',1)
if get(handles.popupmenuLock,'Value')>1
   h=waitbar(0.5,'Aligning EF','Windowstyle','Modal'); % waitbar
% - alignment
   eWin=field2num(handles.editLockEF);
   [EAlign,~,Fail]=AlignEF(Data,ECorr,eWin,dEWin_Lock,dESm_Lock,feat_Lock); EAlign=EAlign+setTo_Lock;
%   if ~isempty(Fail); uiwait(msgbox(['Warning: Failed to Lock EF in ' num2str(length(Fail)) ' images'],'modal')); end  
   close(h) % close waitbar  
else
EAlign=repmat(ECorr,[1 1 max(1,length(Scan))]);
end
% - update energy range
% ERange=[min(min(EAlign(:,1,:))) max(max(EAlign(:,end,:)))];
ERange=[min(ECorr(1,:)) max(ECorr(end,:))];
% Kx-transform and auto Kx range if selected
if get(handles.radiobuttonAKx,'Value')==1
    surfNx=str2num(get(handles.editSurfNx,'String')); Kx=Kxx(HV,EAlign,thtM,ACorr,surfNx);
% - Kx range and auto window 
   KxRange=[min(min(Kx(:,1,:))) max(max(Kx(:,end,:)))];
   aMin=max(max(Kx(:,1,:))); aMax=min(min(Kx(:,end,:))); AutoKxWin=[0.95*aMin+0.05*aMax 0.05*aMin+0.95*aMax];
   AKx=Kx; AKxRange=KxRange; AKxWin=AutoKxWin;
end
% draw data cube
axes(handles.axesCube); cla
% - 2D case
if isempty(Scan)||length(Scan)<2
   axis([0 1 -0.5 0.5 ERange]);
   set(gca,'Position',[1.01*CubePos(1) CubePos(2) 0.8*CubePos(3:4)],'PlotBoxAspectRatio',[0.5 1 1]);
% - 3D case
else
   axis([Scan([1 end]) -0.5 0.5 ERange]); % axis square tight;
   set(gca,'Position',CubePos,'PlotBoxAspectRatio',[5 1 1])
end
% ranges and auto windows
% - Angle/Kx
if get(handles.radiobuttonAKx,'Value')==0
   set(handles.textAKx,'String',[sprintf('%0.1f',ARange(1)) '<Angle<' sprintf('%0.1f',ARange(2))])
   set(handles.editAKx,'String',sprintf('%0.1f:%0.1f',AutoAWin))
else
   set(handles.textAKx,'String',[sprintf('%0.1f',KxRange(1)) '<Kx<' sprintf('%0.1f',KxRange(2))])
   set(handles.editAKx,'String',sprintf('%0.1f:%0.1f',AutoKxWin))
end
% - Energy
set(handles.textEnergy,'String',[sprintf('%0.1f',ERange(1)) '<Eb/k<' sprintf('%0.1f',ERange(end))]);
% - Scan
if ~isempty(Scan); set(handles.textScan,'String',[sprintf('%0.1f',Scan(1)) '<Scan<' sprintf('%0.1f',Scan(end))]); end
% switch fields and visualize slices
SwitchShow(handles)
% auto setup for LockSetup
dEWinIni=0.1*diff(ERange); dEWin_Lock=dEWinIni; dESmIni=0.01*diff(ERange); dESm_Lock=dESmIni;
% auto energy range for NormSetup
meanE=mean(ERange); RangeIni=[meanE-0.05*ep meanE+0.05*ep]; Range_Norm=RangeIni;
% reset export mode to data
set(handles.popupmenuExport,'Value',1,'Enable','Off')

% ---  Function to switch between different fields to show and draws the cube
function SwitchShow(handles)
global AKxRange AKxWin Energy EWin Scan ScanType SWin viewMode
% if isempty(Data); beep; return; end % return if no data
% control groups
ShowEnergy=[handles.textEnergy handles.pushbuttonEMinus handles.editEnergy handles.pushbuttonEPlus]; set(ShowEnergy,'Enable','Off')
ShowAKx=[handles.textAKx handles.pushbuttonAKxMinus handles.editAKx handles.pushbuttonAKxPlus]; set(ShowAKx,'Enable','Off')
ShowScan=[handles.textScan handles.pushbuttonScanMinus handles.editScan handles.pushbuttonScanPlus]; set(ShowScan,'Enable','Off')
ShowNorm=[handles.textNorm handles.popupmenuNorm]; set(ShowNorm,'Enable','On');
ShowNormScans=[handles.textNormScans handles.popupmenuNormScans]; set(ShowNormScans,'Enable','Off')
set(handles.popupmenuReadout,'Value',1,'Enable','Off')
% initially switch off the surfNy the Kz-transform fields
set([handles.textSurfNy handles.editSurfNy],'Visible','Off');
set([handles.popupmenuHvKz handles.textVo handles.editVo],'Visible','Off');
% switch between modes
viewMode=get(handles.popupmenuViewMode,'Value');
axes(handles.axesCube);
switch viewMode
   case 1  % Image
   % - fields
   if ~isempty(Scan); set(ShowScan ,'Enable','On'); set(handles.editScan,'String',sprintf('%g:%g',SWin)); end
   % - slice
   try DrawPatch((AKxRange-mean(AKxRange))/diff(AKxRange),Energy,SWin); end
   case 2  % Angle-Int Image
   % - fields
   set(ShowAKx,'Enable','On')
   if ~isempty(Scan); set(ShowScan,'Enable','On'); set(handles.editScan,'String',sprintf('%g:%g',SWin)); end
   % - slice
   try DrawPatch((AKxWin-mean(AKxRange))/diff(AKxRange),Energy,SWin); end
   case 3   % Image Series
   % - fields
   set(ShowScan,'Enable','On')
   if ~isempty(Scan); set(ShowScan,'Enable','On'); set(handles.editScan,'String',sprintf('%g:%g',SWin)); end
   % - slice
   try DrawPatch((AKxRange-mean(AKxRange))/diff(AKxRange),Energy,SWin); end
   case 4   % Iso-E
   % - fields
   if ~isempty(Scan); set(handles.editEnergy,'String',sprintf('%g+-%g',[mean(EWin) diff(EWin)/2])); end
   set(ShowEnergy,'Enable','On'); set(ShowNormScans,'Enable','On')
   if isequal(ScanType,'Tilt') set(handles.popupmenuReadout,'Enable','On'); end
   if ~isempty(Scan); set(handles.editScan,'String',sprintf('%g:%g',Scan([1 end]))); end % Full Scan can be changed to SWin
   % K-transform fields
   if get(handles.radiobuttonAKx,'Value')==1&&isequal(ScanType,'Tilt')
      set([handles.textSurfNy handles.editSurfNy],'Visible','On')
   end
   if get(handles.radiobuttonAKx,'Value')==1&&isequal(ScanType,'hv')
      set(handles.popupmenuHvKz,'Visible','On')
      if get(handles.popupmenuHvKz,'Value')==2; set([handles.textVo handles.editVo],'Visible','On'); end
   end
   % - slice
   try DrawPatch((AKxRange-mean(AKxRange))/diff(AKxRange),EWin,Scan); end
   case 5   % Angle-Int Scan
   % - fields
   set(ShowAKx,'Enable','On'); set(ShowNormScans,'Enable','On')
   if ~isempty(Scan); set(handles.editScan,'String',sprintf('%g:%g',Scan([1 end]))); end % Full Scan can be changed to SWin
   % K-transform fields
   if get(handles.radiobuttonAKx,'Value')==1&&isequal(ScanType,'Tilt')
      set([handles.textSurfNy handles.editSurfNy],'Visible','On')
   end
   if get(handles.radiobuttonAKx,'Value')==1&&isequal(ScanType,'hv')
      set(handles.popupmenuHvKz,'Visible','On')
      if get(handles.popupmenuHvKz,'Value')==2; set([handles.textVo handles.editVo],'Visible','On'); end
   end
   % - slice
   try DrawPatch((AKxWin-mean(AKxRange))/diff(AKxRange),Energy,Scan); end
end
% switch between 2D and 3D
if isempty(Scan)||length(Scan)<2
%   set([handles.editEnergy handles.textScan handles.editScan],'Enable','Off');
   set(ShowScan,'Visible','Off');
else
%   set([handles.editEnergy handles.textScan handles.editScan],'Enable','On');
   set(ShowScan,'Visible','On');
end

% --- Function to draw patch in data cube
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
% clear plot ranges
global XRange YRange; XRange=[]; YRange=[]; disp('- cleared XRange YRange')
SwitchShow(handles)

% --- Executes on button press in radiobuttonCurvatureCorr.
function radiobuttonCurvatureCorr_Callback(~,~,handles)
% clear correction
global FullName ECorr EAlign Kx; ECorr=[]; EAlign=[]; Kx=[];
disp('- cleared ECorr EAlign Kx')
% re-process file
LoadFile(handles,FullName);

% --- Executes on button press in radiobuttonWarpingCorr.
function radiobuttonWarpingCorr_Callback(~,~,handles)
% clear correction
global FullName ACorr Kx ; ACorr=[]; Kx=[]; disp('- cleared ACorr Kx')
% re-process file
LoadFile(handles,FullName);

% --- Executes on edit of editScan.
function editScan_Callback(hObject,~,handles)
global Scan SWin hFig createNewFig
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
% hide/popup controls and re-draw cube
SwitchShow(handles)
% re-draw the existing view window
try Pos=get(hFig,'Position'); createNewFig=0; ProcessView(handles); set(hFig,'Position',Pos); end
% --- Executes on button press in pushbuttonScanMinus.
function pushbuttonScanMinus_Callback(~,~,handles)
global Scan SWin hFig createNewFig
% read in scan window
SWin=field2num(handles.editScan);
% calculate and write new energy window
SWin=SWin-diff(SWin);
if SWin(1)<min(Scan); return; end
set(handles.editScan,'String',sprintf('%g:%g',SWin))
% hide/popup controls and re-draw cube
SwitchShow(handles)
% re-draw the existing view window
try Pos=get(hFig,'Position'); createNewFig=0; ProcessView(handles); set(hFig,'Position',Pos); end
% --- Executes on button press in pushbuttonScanPlus.
function pushbuttonScanPlus_Callback(~,~,handles)
global Scan SWin hFig createNewFig
% read in scan window
SWin=field2num(handles.editScan);
% calculate and write new energy window
SWin=SWin+diff(SWin);
if SWin(2)>max(Scan); return; end
set(handles.editScan,'String',sprintf('%g:%g',SWin))
% hide/popup controls and re-draw cube
SwitchShow(handles)
% re-draw the existing view window
try Pos=get(hFig,'Position'); createNewFig=0; ProcessView(handles); set(hFig,'Position',Pos); end

% --- Executes on edit of editAKx.
function editAKx_Callback(hObject,~,handles)
global AutoAWin AutoKxWin AKxWin hFig createNewFig
% read in
%AKxWin=sort( sscanf( get(hObject,'String'),'%g:%g') );
AKxWin=field2num(hObject);
% check validity and substitute by automatic range if invalid
if isempty(AKxWin)
   if get(handles.radiobuttonAKx,'Value')==0; set(hObject,'String',sprintf('%g:%g',AutoAWin));
   else set(hObject,'String',sprintf('%g:%g',AutoKxWin)); end  
end
% display
set(hObject,'String',sprintf('%g:%g',AKxWin))
% hide/popup controls and re-draw cube
SwitchShow(handles)
% re-draw the existing view window
try Pos=get(hFig,'Position'); createNewFig=0; ProcessView(handles); set(hFig,'Position',Pos); end
% --- Executes on button press in pushbuttonAKxMinus.
function pushbuttonAKxMinus_Callback(~,~,handles)
global AKxRange AKxWin hFig createNewFig
% read in Angle/Kx
AKxWin=field2num(handles.editAKx);
% calculate and write new Angle/Kx
AKxWin=AKxWin-diff(AKxWin);
if AKxWin(1)<AKxRange(1); return; end
set(handles.editAKx,'String',sprintf('%g:%g',AKxWin))
% hide/popup controls and re-draw cube
SwitchShow(handles)
% re-draw the existing view window
try Pos=get(hFig,'Position'); createNewFig=0; ProcessView(handles); set(hFig,'Position',Pos); end
% --- Executes on button press in pushbuttonAKxPlus.
function pushbuttonAKxPlus_Callback(~,~,handles)
global AKxRange AKxWin hFig createNewFig
% read in Angle/Kx window
AKxWin=field2num(handles.editAKx);
% calculate and write new Angle/Kx window
AKxWin=AKxWin+diff(AKxWin);
if AKxWin(2)>AKxRange(2); return; end
set(handles.editAKx,'String',sprintf('%g:%g',AKxWin))
% hide/popup controls and re-draw cube
SwitchShow(handles)
% re-draw the existing view window
try Pos=get(hFig,'Position'); createNewFig=0; ProcessView(handles); set(hFig,'Position',Pos); end

% --- Executes on selection change in radiobuttonAKx.
function radiobuttonAKx_Callback(hObject,~,handles)
global HV ECorr ACorr ARange AutoAWin thtM Kx KxRange AutoKxWin AKx AKxRange AKxWin
if get(hObject,'Value')==0
   set([handles.textSurfNx handles.editSurfNx handles.pushbuttonFindSurfNx],'Visible','Off');
else
      set([handles.textSurfNx handles.editSurfNx handles.pushbuttonFindSurfNx],'Visible','On');
end
if isempty(HV); return; end % return if no data
% change between angle and Kx modes
if get(hObject,'Value')==0
% - display angle range
   AKx=ACorr; AKxRange=ARange; AKxWin=AutoAWin;
   set(handles.textAKx,'String',[sprintf('%0.1f',ARange(1)) '<Angle<' sprintf('%0.1f',ARange(2))])
else
% - calculate Kx, its ranges and auto window
   if isempty(Kx)
      % surfNx=str2num(get(handles.editSurfNx,'String')); 
      surfNx=field2num(handles.editSurfNx); Kx=Kxx(HV,ECorr,thtM,ACorr,surfNx);
      KxRange=[min(min(Kx(:,1,:))) max(max(Kx(:,end,:)))];
      aMin=max(max(Kx(:,1,:))); aMax=min(min(Kx(:,end,:))); AutoKxWin=[0.95*aMin+0.05*aMax 0.05*aMin+0.95*aMax];
   end
% - display Kx range
   AKx=Kx; AKxRange=KxRange; AKxWin=AutoKxWin;
   set(handles.textAKx,'String',[sprintf('%0.1f',KxRange(1)) '<Kx<' sprintf('%0.1f',KxRange(2))])
end
% display auto window
set(handles.editAKx,'String',sprintf('%0.1f:%0.1f',AKxWin))
% hide/popup controls and re-draw cube
SwitchShow(handles)

% --- Executes on buttonpress in editSurfNx.
function editSurfNx_Callback(hObject,~,handles)
global HV ECorr ACorr thtM Kx KxRange AutoKxWin AKxRange AKxWin
% calculate Kx and display Kx-ranges
%surfNx=str2num(get(hObject,'String'));
surfNx=field2num(hObject);
Kx=Kxx(HV,ECorr,thtM,ACorr,surfNx); KxRange=[min(min(Kx(:,1,:))) max(max(Kx(:,end,:)))]; AKxRange=KxRange;
set(handles.textAKx,'String',[sprintf('%0.1f',KxRange(1)) '<Kx<' sprintf('%0.1f',KxRange(2))])
%set(handles.textAKx,'String',[{'Angle'};{[sprintf('%0.1f',AKxRange(1)) '<Kx<' sprintf('%0.1f',AKxRange(2))]}])
% calculate and display auto Kx window
aMin=max(max(Kx(:,1,:))); aMax=min(min(Kx(:,end,:))); AutoKxWin=[0.95*aMin+0.05*aMax 0.05*aMin+0.95*aMax]; AKxWin=AutoKxWin; 
set(handles.editAKx,'String',sprintf('%0.1f:%0.1f',AKxWin))
% hide/popup controls and re-draw cube
SwitchShow(handles)

% --- Executes on button press in pushbuttonFindSurfNx.
function pushbuttonFindSurfNx_Callback(~,~,handles)
global viewMode hFig CurrentXY ScanType hv_N thtA_N eB_N surfNx_Navi HV ECorr EWin SWin ...
          ACorr thtM Kx KxRange AutoKxWin AKxRange AKxWin createNewFig
% graphics readout for surfNx input
if viewMode==1 || (viewMode==4 && isequal(ScanType,'Tilt'))
% - select Angle mode and XY readout
   set(handles.radiobuttonAKx,'Value',0);
   readoutIni=get(handles.popupmenuReadout,'Value'); set(handles.popupmenuReadout,'Value',1)
% - popup figure and graphics input till the figure is deleted
   createNewFig=1; ProcessView(handles); waitfor(hFig); XY=CurrentXY;
% - back to Kx mode and initial readout    
   set(handles.radiobuttonAKx,'Value',1); set(handles.popupmenuReadout,'Value',readoutIni)
% - parameters   
   thtA_N=XY(1); 
   if length(HV)==1; hv_N=HV; else hv_N=HV(SWin(1)); end 
% - other parameters 
  if viewMode==1 
     eB_N=XY(2);
  else
     eB_N=mean(EWin);
     set(handles.editSurfNy,'String',sprintf('%0.3f',XY(2)))
  end
else
   msgbox('Select an image or iso-E surface as a function of tilt','modal'); return
end
% position of the popup window
% PosFig=get(hObject,'Position'); PosPanel=get(handles.PanelProcessing,'Position'); PosButton=get(hObject,'Position');
% xPos_Navi=PosFig(1)+PosPanel(1)+PosButton(1)+PosButton(3); yPos_Navi=PosFig(2)+PosPanel(2)+PosButton(2);
% PosFig=get(hFig,'Position'); xPos_Navi=PosFig(1)+PosFig(3); yPos_Navi=PosFig(2)-PosFig(4);
% popup the panel to find surfNx and wait for the value
h=NaviSetup; set(h,'WindowStyle','modal'); uiwait(h);
if ~isempty(surfNx_Navi) set(handles.editSurfNx,'String',sprintf('%0.3f',surfNx_Navi)); end
% calculate Kx and display Kx-ranges
Kx=Kxx(HV,ECorr,thtM,ACorr,surfNx_Navi); KxRange=[min(min(Kx(:,1,:))) max(max(Kx(:,end,:)))]; AKxRange=KxRange; 
set(handles.textAKx,'String',[sprintf('%0.1f',AKxRange(1)) '<Kx<' sprintf('%0.1f',AKxRange(2))])
% calculate and display auto Kx window
aMin=max(max(Kx(:,1,:))); aMax=min(min(Kx(:,end,:))); AutoKxWin=[0.95*aMin+0.05*aMax 0.05*aMin+0.95*aMax]; AKxWin=AutoKxWin; 
set(handles.editAKx,'String',sprintf('%0.1f:%0.1f',AutoKxWin))
% hide/popup controls and re-draw cube
SwitchShow(handles)

% --- Executes on selection change in popupmenuHvKz.
function popupmenuHvKz_Callback(hObject,~,handles)
global YRange; YRange=[]; disp ('- clear YRange')
if get(hObject,'Value')==1
   set([handles.textVo handles.editVo],'Visible','Off')
else
   set([handles.textVo handles.editVo],'Visible','On')
end

% --- Executes on button press in editEnergy.
function editEnergy_Callback(hObject,~,handles)
global ERange EWin hFig createNewFig
% read in energy window
eStr=get(hObject,'String'); pmPos=strfind(deblank(eStr),'+-');
eSlice=str2num(eStr(1:pmPos-1)); dE=str2num(eStr(pmPos+2:end));
% validity check
if isempty(eSlice*dE); EWin=[]; msgbox('Check energy-window format E+-dE','modal'); return; end
if eSlice-dE<ERange(1)||eSlice+dE>ERange(2); EWin=[]; msgbox('Check energy-window ranges','modal'); return; end
EWin=[eSlice-dE eSlice+dE];
% hide/popup controls and re-draw cube
SwitchShow(handles)
% re-draw the existing view window
try Pos=get(hFig,'Position'); createNewFig=0; ProcessView(handles); set(hFig,'Position',Pos); end
% --- Executes on button press in pushbuttonEMinus.
% Note: Replacement of malfunctioning Slider
function pushbuttonEMinus_Callback(~,~,handles)
global ERange EWin hFig createNewFig
% read in energy window
eStr=get(handles.editEnergy,'String'); pmPos=strfind(deblank(eStr),'+-');
eSlice=str2num(eStr(1:pmPos-1)); dE=str2num(eStr(pmPos+2:end));
% calculate and write new energy window
eSlice=eSlice-dE;
if eSlice-dE<ERange(1); return; end    % leave the previous window if below the range
EWin=[eSlice-dE eSlice+dE];
set(handles.editEnergy,'String',[num2str(eSlice) '+-' num2str(dE)])
% hide/popup controls and re-draw cube
SwitchShow(handles)
% re-draw the existing view window
try Pos=get(hFig,'Position'); createNewFig=0; ProcessView(handles); set(hFig,'Position',Pos); end
% --- Executes on button press in pushbuttonEPlus.
function pushbuttonEPlus_Callback(~,~,handles)
global ERange EWin hFig createNewFig
% read in energy window
eStr=get(handles.editEnergy,'String'); pmPos=strfind(deblank(eStr),'+-');
eSlice=str2num(eStr(1:pmPos-1)); dE=str2num(eStr(pmPos+2:end));
% calculate and write new energy window
eSlice=eSlice+dE;
if eSlice+dE>ERange(2); return; end    % leave the previous window if above the range
EWin=[eSlice-dE eSlice+dE];
set(handles.editEnergy,'String',[num2str(eSlice) '+-' num2str(dE)])
% hide/popup controls and re-draw cube
SwitchShow(handles)
% re-draw the existing view window
try Pos=get(hFig,'Position'); createNewFig=0; ProcessView(handles); set(hFig,'Position',Pos); end

% --- Executes on button press in editLockEF.
function editLockEF_Callback(hObject,~,handles)
% hObject    handle to editLockEF (see GCBO)
global Data HV ECorr ACorr thtM dEWin_Lock dESm_Lock feat_Lock setTo_Lock ...
   EAlign ERange Kx KxRange AutoKxWin AKxRange AKxWin IDiv
eWin=field2num(hObject,0);
% aligned energy, energy range and Kx range
if get(handles.popupmenuLock,'Value')>1
   h=waitbar(0.5,'Aligning EF','Windowstyle','Modal'); % open waitbar
% - alignment
   [EAlign,~,Fail]=AlignEF(Data,ECorr,eWin,dEWin_Lock,dESm_Lock,feat_Lock); EAlign=EAlign+setTo_Lock;
%   if ~isempty(Fail); uiwait(msgbox(['Warning: Failed to Lock EF in ' num2str(length(Fail)) ' images'],'modal')); end
% - update energy range
   ERange=[min(min(EAlign(:,1,:))) max(max(EAlign(:,end,:)))];
   set(handles.textEnergy,'String',[sprintf('%0.1f',ERange(1)) '<Eb/k<' sprintf('%0.1f',ERange(end))]);
% - update Kx range
   if get(handles.radiobuttonAKx,'Value')==1
      surfNx=field2num(handles.editSurfNx); Kx=Kxx(HV,EAlign,thtM,ACorr,surfNx);
      KxRange=[min(min(Kx(:,1,:))) max(max(Kx(:,end,:)))];
      aMin=max(max(Kx(:,1,:))); aMax=min(min(Kx(:,end,:))); AutoKxWin=[0.95*aMin+0.05*aMax 0.05*aMin+0.95*aMax];
      set(handles.textAKx,'String',[sprintf('%0.1f',KxRange(1)) '<Kx<' sprintf('%0.1f',KxRange(2))])
      set(handles.editAKx,'String',sprintf('%0.1f:%0.1f',AutoKxWin))
      AKxRange=KxRange; AKxWin=AutoKxWin;  
   end
% - reset
   IDiv=[]; disp('- cleared IDiv')
   close(h) % close waitbar
end

% --- Executes on selection change in popupmenuLock.
function popupmenuLock_Callback(hObject,~, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuLock contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuLock
global Data HV thtM ACorr ECorr EAlign ERange Kx KxRange AutoKxWin AKxRange AKxWin ...
          dEWin_Lock dEWinIni dESm_Lock dESmIni  feat_Lock featIni setTo_Lock setToIni IDiv
% % return if no change in selection
% if get(hObject,'Value')==valMenuLockPre; return; else valMenuLockPre=get(hObject,'Value'); end
% reset
IDiv=[]; disp('- cleared IDiv')
if get(hObject,'Value')==1
   EAlign=ECorr;
else
% set initial parameters if 'Auto'
   if get(hObject,'Value')==2
      dEWin_Lock=dEWinIni; dESm_Lock=dESmIni; feat_Lock=featIni; setTo_Lock=setToIni; 
% draw the popup window and wait for initial parameters if 'XTra'
   else
% position of the popup window      
      PosFig=get(gcf,'Position'); PosPanel=get(handles.PanelProcessing,'Position'); PosButton=get(hObject,'Position');
      xPos_Lock=PosFig(1)+PosPanel(1)+PosButton(1)+PosButton(3); yPos_Lock=PosFig(2)+PosPanel(2)+PosButton(2);
% popup window   
      h=LockSetup; 
      Pos=get(h,'Position'); Pos=[xPos_Lock yPos_Lock-Pos(4)-30 Pos(3) Pos(4)]; 
      set(h,'Position',Pos,'WindowStyle','modal'); uiwait(h); 
   end
% aligned energy and energy range
   h=waitbar(0.5,'Aligning EF','WindowStyle','Modal'); % open waitbar
% - alignment
   eWin=field2num(handles.editLockEF);
   [EAlign,~,Fail]=AlignEF(Data,ECorr,eWin,dEWin_Lock,dESm_Lock,feat_Lock); EAlign=EAlign+setTo_Lock;
%   if ~isempty(Fail); uiwait(msgbox(['Warning: Failed to Lock EF in ' num2str(length(Fail)) ' images'],'modal')); end
   close(h) % close waitbar  
end 
% update energy range
   ERange=[min(min(EAlign(:,1,:))) max(max(EAlign(:,end,:)))];
   set(handles.textEnergy,'String',[sprintf('%0.1f',ERange(1)) '<Eb/k<' sprintf('%0.1f',ERange(end))]);
% update Kx range
if get(handles.radiobuttonAKx,'Value')==1
   surfNx=field2num(handles.editSurfNx); Kx=Kxx(HV,EAlign,thtM,ACorr,surfNx);
   KxRange=[min(min(Kx(:,1,:))) max(max(Kx(:,end,:)))];
   aMin=max(max(Kx(:,1,:))); aMax=min(min(Kx(:,end,:))); AutoKxWin=[0.95*aMin+0.05*aMax 0.05*aMin+0.95*aMax];
   set(handles.textAKx,'String',[sprintf('%0.1f',KxRange(1)) '<Kx<' sprintf('%0.1f',KxRange(2))])
   set(handles.editAKx,'String',sprintf('%0.1f:%0.1f',AutoKxWin))
   AKxRange=KxRange; AKxWin=AutoKxWin;
end

% --- Executes on button press in popupmenuNorm.
function popupmenuNorm_Callback(hObject,~,handles)
% hObject    handle to popupmenuNorm (see GCBO)
global Range_Norm RangeIni scCoeff_Norm scCoeffIni
% position of the popup window
PosFig=get(gcf,'Position'); PosPanel=get(handles.PanelProcessing,'Position'); PosButton=get(hObject,'Position');
xPos_Norm=PosFig(1)+PosPanel(1)+PosButton(1)+PosButton(3); yPos_Norm=PosFig(2)+PosPanel(2)+PosButton(2);
% set initial parameters if 'Auto'
if get(hObject,'Value')==2; Range_Norm=RangeIni; scCoeff_Norm=scCoeffIni; end
% draw the popup window if 'XTra'
if get(hObject,'Value')==3; 
   h=NormSetup; 
   Pos=get(h,'position'); Pos=[xPos_Norm yPos_Norm-Pos(4)-30 Pos(3) Pos(4)];
   set(h,'position',Pos,'WindowStyle','modal')
   uiwait(h);
end

% --- Executes on selection change in popupmenuView.
function popupmenuView_Callback(hObject,~,handles)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuView contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuView
global Frac_View FracIni render viewMode
viewMode=get(handles.popupmenuViewMode,'Value');
% position of the popup window
PosFig=get(gcf,'Position'); PosPanel=get(handles.PanelProcessing,'Position'); PosButton=get(hObject,'Position');
xPos_View=PosFig(1)+PosPanel(1)+PosButton(1)+PosButton(3); yPos_View=PosFig(2)+PosPanel(2)+PosButton(2);
% set initial parameters if 'Auto'
if get(hObject,'Value')==1; Frac_View=FracIni; render='Flat'; end
% raise the popup window if 'Xtra'
if get(hObject,'Value')==2
   h=ViewSetup; 
   Pos=get(h,'position'); Pos=[xPos_View yPos_View-Pos(4)-30 Pos(3) Pos(4)];
   set(h,'position',Pos,'WindowStyle','modal')
   uiwait(h) 
end

% --- Executes on button press in pushbuttonView.
function pushbuttonView_Callback(~,~,handles)
global createNewFig
createNewFig=1; ProcessView(handles);

% --- Function to process the data for viewing
function ProcessView(handles)
global FileName ScanType EWin Scan SWin Data EAlign ERange ACorr AutoAWin Kx AKx AKxWin Range_Norm ...
          IDiv scCoeff_Norm ISubtr viewMode X Y Z Frac_View switchAKx HV thtM tltM colorScheme
% return if no data
if isempty(Data); return; end
% *** parameters ***
% image mode
%mode=get(handles.popupmenuViewMode,'Value');
% colorscheme
modeMap=get(handles.popupmenuColormap,'Value');
modeMapC=get(handles.popupmenuColormap,'String');
colorScheme=char(modeMapC(modeMap)); colorScheme=[colorScheme '(256)'];
% scan window indices
if isempty(Scan); nS1=1; nS2=1;
else [~,nS1]=min(abs(Scan-SWin(1))); [~,nS2]=min(abs(Scan-SWin(end)));
end
% % align the energy scale at EF if EAlign empty (not yet calculated)
% if isempty(EAlign) 
%    if get(handles.popupmenuLock,'Value')>1
%       h=waitbar(0.5,'Aligning EF','Windowstyle','Modal'); % waitbar
% % - parameters and alignment       
% %    eWin=str2num(get(handles.editLockEF,'String'));
%       eWin=field2num(handles.editLockEF);
%       [EAlign,~,Fail]=AlignEF(Data,ECorr,eWin,dEWin_Lock,dESm_Lock,feat_Lock); EAlign=EAlign+setTo_Lock;
% %     if ~isempty(Fail); uiwait(msgbox(['Warning: Failed to Lock EF in ' num2str(length(Fail)) ' images'],'modal')); end  
%       close(h) % close waitbar  
%    else
%       EAlign=repmat(ECorr,[1 1 max(1,length(Scan))]);
%    end
% end
% % update energy range
% ERange=[min(min(EAlign(:,1,:))) max(max(EAlign(:,end,:)))];
set(handles.textEnergy,'String',[sprintf('%0.1f',ERange(1)) '<Eb/k<' sprintf('%0.1f',ERange(end))]);
% no need to calculate Kx-transform because it was already calculated 
% either in Load or in textAKx/editSurfNx/pushbuttonFind
% if isempty(Kx)&&get(handles.textAKx,'Value')==2
%    surfNx=str2num(get(handles.editSurfNx,'String')); Kx=Kxx(HV,ECorr,thtM,ACorr,surfNx);
% end
% normalize by intensity in the defined energy window
Data3=Data;
if viewMode~=2&&get(handles.popupmenuNorm,'Value')>1
   if isempty(IDiv)
      h=waitbar(0.5,'Forming Normalization Array','Windowstyle','Modal');
         IDiv=Slice(ACorr,EAlign,Data3,'isoE',Range_Norm);
      close(h)
      IDiv=Gaco2(IDiv,5,0); % HWHM adjusted to suppress uneven sensitivity of the CCD channels
      IDiv=repmat(IDiv,1,1,size(Data3,1)); IDiv=permute(IDiv,[3 2 1]);
   end
   Data3=Data3./IDiv;
% subtract angle-integrated spectrum and zero negative values
   if scCoeff_Norm~=0
      if isempty(ISubtr)
         h=waitbar(0.5,'Forming Subtraction Array','Windowstyle','Modal');
            ISubtr=Slice(ACorr,EAlign,Data3,'isoK',AutoAWin);
         close(h) 
         ISubtr=repmat(ISubtr,1,1,size(Data3,2)); ISubtr=permute(ISubtr,[1 3 2]);
      end    
      Data3=Data3-scCoeff_Norm*ISubtr; Data3(Data3<0)=0;
   end
end
% selecting between Angles and Kx
switchAKx=get(handles.radiobuttonAKx,'Value');
if switchAKx==0; AKx=ACorr; else AKx=Kx; end
% AKxWin=sscanf(get(handles.editAKx,'String'),'%g:%g');
% AKxWin=field2num(handles.editAKx);
% processing and image modes
switch viewMode
%
% *** image *** (summation of images from 3D data ignores their energy shifts; in principle, should use remapping)   
case 1
   if size(AKx,3)>1; X=mean(AKx(:,:,nS1:nS2),3); else X=AKx; end
   Y=mean(EAlign(:,:,nS1:nS2),3);
   Z=mean(Data3(:,:,nS1:nS2),3);
%
case 2
% *** angle integrated image ***
%   [Y,X]=IntAngle(mean(Data3(:,:,nS1:nS2),3),Angle,mean(EAlign(:,:,nS1:nS2),3),AKxWin); 
   [Y,X]=Slice(mean(AKx(:,:,nS1:nS2),3),mean(EAlign(:,:,nS1:nS2),3),mean(Data3(:,:,nS1:nS2),3),'isoK',AKxWin);
   Z=[];
%
% **** series of images mode ****
case 3
% plot images in the selected Scan range
   if size(AKx,3)>1; ACorrV=AKx(:,:,nS1:nS2); else ACorrV=AKx; end
   if size(EAlign,3)>1; EAlignV=EAlign(:,:,nS1:nS2); else EAlignV=EAlign; end
   nRows=3; nCols=3; ViewSeries(ACorrV,EAlignV,Scan(nS1:nS2),Data3(:,:,nS1:nS2),nRows,nCols,colorScheme,Frac_View(1),Frac_View(2))
%
% *** iso-E mode ***
case 4
% - slice formation waitbar
   h=waitbar(0.5,'Forming Data Slice','Windowstyle','Modal');
% - slice within EWin
   try [ISliceE,ASliceE]=Slice(AKx,EAlign,Data3,'isoE',EWin); catch; beep; close(h); return; end
% - close waitbar
   close(h)
% scan normalization
   normScanMode=get(handles.popupmenuNormScans,'Value');
   switch normScanMode
% - no normalization
   case 1
      ISliceN=ISliceE;
   otherwise
% - integral intensity of scans over 90% of angular range
      nA=size(ISliceE,2); n1=round(0.05*nA); n2=round(0.95*nA);
      ISliceN=ISliceE(:,n1:n2); ISliceN=sum(ISliceN,2)/(n2-n1+1);
% - 2-order smoothing of integral intensity if normalization set to 'Smooth'
      if normScanMode==3; P=polyfit(Scan',ISliceN,2); ISliceN=polyval(P,Scan'); end
% - normalization
      ISliceN=ISliceE./repmat(ISliceN,1,nA);
% % - bilinear over 90% of angular range
%       [~,Coeffs]=Flat(AngleN,Scan,ISliceN);
%       [AngleM,ScanM]=meshgrid(Angle,Scan);
%       ISliceN=ISliceE./(Coeffs(1)*AngleM+Coeffs(2)*ScanM+Coeffs(3));
   end
% - image output
   X=ASliceE; Y=Scan'; Z=ISliceN;
% K-space transformations if Kx activated
   if switchAKx==1
%      surfNx=str2num(get(handles.editSurfNx,'String')); surfNy=str2num(get(handles.editSurfNy,'String'));
      surfNx=field2num(handles.editSurfNx); surfNy=field2num(handles.editSurfNy);
% - Tilt scan       
      if isequal(ScanType,'Tilt') 
         Ky=Kyy(HV,mean(EWin),ASliceE,thtM,Scan-surfNy,surfNx); Y=Ky;
      end
% - hv scan  
      if isequal(ScanType,'hv')
         if get(handles.popupmenuHvKz,'Value')==2
%            Vo=str2num(get(handles.editVo,'String')); 
            Vo=field2num(handles.editVo);
            Kz=Kzz(HV,mean(EWin),thtM,ASliceE,tltM-surfNy,Vo,surfNx); Y=Kz;
         end
      end
   end   
%
% *** Iso-Angle/Kx mode ***  
case 5
% angle integration
   h=waitbar(0.5,'Angle Integrating','Windowstyle','Modal'); % waitbar
%    [ISliceA,ESliceA]=IntAngle(Data3,Angle,EAlign,AWin);
   try [ISliceA,ESliceA]=Slice(AKx,EAlign,Data3,'isoK',AKxWin); catch; beep; close(h); return; end
   close(h) % close waitbar
  % scan normalization
   normScanMode=get(handles.popupmenuNormScans,'Value');
   ISliceZ=ISliceA';
   switch normScanMode
% - no normalization
   case {2,3}
% - integral intensity of scans over 90% of energy range
      nE=size(ISliceZ,2); n1=round(0.05*nE); n2=round(0.95*nE);
      ISliceN=ISliceZ(:,n1:n2); ISliceN=sum(ISliceN,2)/(n2-n1+1);
% - 2-order smoothing of integral intensity if normalization set to 'Smooth'
      if normScanMode==3; P=polyfit(Scan',ISliceN,2); ISliceN=polyval(P,Scan'); end
% - normalization
      ISliceZ=ISliceZ./repmat(ISliceN,1,nE);
   end
% image output
   X=ESliceA'; Y=Scan'; Z=ISliceZ;
   % K-space transformations if Kx activated
   if get(handles.radiobuttonAKx,'Value')==1    
%       surfNx=str2num(get(handles.editSurfNx,'String')); 
       surfNx=field2num(handles.editSurfNx); thtMPhys=thtM+surfNx;
%       surfNy=str2num(get(handles.editSurfNy,'String'));
       surfNy=field2num(handles.editSurfNy);
       kx=mean(AKxWin);
       ePhi=4.5; alpha=20; 
% - Tilt scan
      if isequal(ScanType,'Tilt') 
         Eb=X; TltM=repmat(Y,1,size(X,2))-surfNy;
         ThtA=asind((kx+2*pi*HV*cosd(alpha+thtMPhys)/12400)./(0.5124*sqrt(HV-ePhi+Eb)))-thtMPhys;
         Ky=0.5124*sqrt(HV-ePhi+Eb).*sind(TltM).*cosd(ThtA+thtMPhys)+2*pi*HV*sind(alpha+thtMPhys).*sind(TltM)/12400;
         Y=Ky;
      end
 % - hv scan
      if isequal(ScanType,'hv')
         if get(handles.popupmenuHvKz,'Value')==2
%            Vo=str2num(get(handles.editVo,'String'));  
            Vo=field2num(handles.editVo);
            Eb=X; HV2=repmat(Y,1,size(X,2));
            ThtA=asind((kx+2*pi*HV2*cosd(alpha+thtMPhys)/12400)./(0.5124*sqrt(HV2-ePhi+Eb)))-thtMPhys;
            Kxy_2=(HV2-ePhi+Eb).*(sind(ThtA+thtMPhys).^2+(sind(tltM).*cosd(ThtA+thtMPhys)).^2); 
            Kz=0.5124*sqrt(HV2+Eb+Vo-Kxy_2)+2*pi*HV2*sind(alpha+thtMPhys)/12400;
            Y=Kz;
         end   
      end
   end
end
% enable image export
set(handles.popupmenuExport,'Enable','On')
% % *** end 3D block ***
% end
%
% *** plot ***
Opts.colorScheme=colorScheme; Opts.Scan=Scan; Opts.FileName=FileName; Opts.ScanType=ScanType;
PlotAll(X,Y,Z,Opts,handles)

% --- Plot and set callbacks function
function PlotAll(X,Y,Z,Opts,handles)
global switchAKx Frac_View render XRange YRange hFig viewMode ScanType createNewFig %hIm hXDC hYDC 
ScanType=Opts.ScanType;
% reject image series
if viewMode==3; return; end
% deactivate slope readout
% set(handles.popupmenuReadout,'Value',1,'Enable','Off');
% set previous or create new figure 
if createNewFig==0 
%   try delete(hFig); end
% - set previous figure as current
   figure(hFig)
%   clf(hFig)
% - retrieve image axes handle and set it active 
   UserData=get(hFig,'UserData'); hIm=UserData.hIm; axes(hIm)
else
% - new figure with callbacks  
   hFig=figure('WindowButtonDownFcn',{@window_Zoom,handles},'WindowButtonUpFcn',{@window_H,handles}); % default normalized units
end
% linear plot
if isempty(Z)
   plot(X,Y); axis tight; set(gca,'TickDir','Out')
% image plots   
else
% set image limits  
% - render 1D-X,Y to 2D-X,Y  
   if size(X,1)==1; XX=repmat(X,size(Y,1),1); else XX=X; end
   if size(Y,2)==1; YY=repmat(Y,1,size(X,2)); else YY=Y; end
% - set NaN outside the limits
   if ~isempty(XRange); Z(XX<XRange(1)|XX>XRange(2))=NaN; end
   if ~isempty(YRange); Z(YY<YRange(1)|YY>YRange(2))=NaN; end
% set contrast
   RawZ=Z; Z=SetContrast(Z,Frac_View(1),Frac_View(2));
%   if get(handles.popupmenuNorm,'Value')==1; Z=Z*scale; end
% different image modes
   switch viewMode
% - image
      case 1
         ImData(X,Y,Z,render); axis tight; colorbar;  eval(['colormap ''' Opts.colorScheme ''''])
% - iso-E
      case 4
         ImData(X,Y,Z,render); axis tight; colorbar; eval(['colormap ''' Opts.colorScheme ''''])
% - Iso-E(Angle)         
         if isequal(Opts.ScanType,'Tilt')
            axis tight equal %set(gca,'YDir','Reverse'); 
            set(handles.popupmenuReadout,'Enable','On');
         end
% - angle-integrated scan
      case 5
         ImData(X,Y,Z,render); axis tight; colorbar; eval(['colormap ''' Opts.colorScheme ''''])
   end
end
% update image axes handle
hIm=gca;
% limits
if ~isempty(XRange); xlim(XRange); end
if ~isempty(YRange); ylim(YRange); end
% title and axes information
if switchAKx==0; titleAKx=', Angle='; else titleAKx=', Kx='; end
switch viewMode
   case 1
      if isempty(Opts.Scan); titleStr=Opts.FileName;   
      else titleStr=[Opts.FileName ', Scan=' get(handles.editScan,'string')]; 
      end
      if switchAKx==0; xlabel('Angle (deg)'); else xlabel('Kx (1/A)'); end 
      if min(Y)>100; ylabel('E_{k} (eV)'); else ylabel('E_{B} (eV)'); end
   case 2
      if isempty(Opts.Scan); titleStr=[Opts.FileName titleAKx get(handles.editAKx,'string')];   
      else titleStr=[Opts.FileName ', Scan=' get(handles.editScan,'string') titleAKx get(handles.editAKx,'string')]; 
      end
      if min(X)>100; xlabel('E_{k} (eV)'); else xlabel('E_{B} (eV)'); end
      ylabel('Intensity');
   case 4
      titleStr=[Opts.FileName ', E=' get(handles.editEnergy,'string')];
      if switchAKx==0; xlabel('Angle (deg)'); else xlabel('Kx (1/A)'); end
      switch(Opts.ScanType)
         case 'Number'; ylabel('Image Number');
         case 'hv'; if get(handles.popupmenuHvKz,'Value')==1; ylabel('hv (eV)'); else ylabel('Kz (1/A)'); end 
         case {'Theta','Azimuth'}; ylabel([Opts.ScanType ' (deg)'])
         case 'Tilt'; if switchAKx==0; ylabel([Opts.ScanType ' (deg)']); else ylabel('Ky (1/A)'); end   
         case {'X','Z'}; ylabel([Opts.ScanType ' (mm)'])   
      end
   case 5
      titleStr=[Opts.FileName titleAKx get(handles.editAKx,'string')];
      if min(X)>100; xlabel('E_{k} (eV)'); else xlabel('E_{B} (eV)'); end
      switch(Opts.ScanType)
         case 'Number'; ylabel('Image Number');
         case 'hv'; if get(handles.popupmenuHvKz,'Value')==1; ylabel('hv (eV)'); else ylabel('Kz (1/A)'); end
         case {'Theta','Azimuth'}; ylabel([Opts.ScanType ' (deg)'])
         case 'Tilt'; if switchAKx==0; ylabel([Opts.ScanType ' (deg)']); else ylabel('Ky (1/A)'); end               
         case {'X','Z'}; ylabel([Opts.ScanType ' (mm)']) 
      end
end
if get(handles.popupmenuNorm,'value')>1; titleStr=[titleStr ', Processed']; end
if isequal(get(handles.popupmenuNormScans,'enable'),'on') && get(handles.popupmenuNormScans,'value')~=1 
   titleStr=[titleStr ', NormScans']; 
end
title(titleStr,'Interpreter','none','fontweight','normal');
% white background
set(hFig,'color','w')
% user data for Zoom
UserData.viewMode=viewMode; UserData.Opts=Opts; UserData.X=X; UserData.Y=Y; UserData.Z=Z; UserData.hIm=hIm;
set(hFig,'UserData',UserData)
%
% *** add XDC/YDC panels ***
if viewMode~=2 && viewMode~=3 && get(handles.radiobuttonXYDC,'Value')==1
% switch off the Zoom callback on WindowButtonDownFcn   
    set(hFig,'WindowButtonDownFcn',[]);
% switch off resizing (resizing corrupts positioning of the panels)
   set(hFig,'resize','off')
% extend figure for the XYDC panels
   PosFig=get(hFig,'Position'); sizeFig=max(PosFig([3 4])); set(hFig,'Position',[PosFig(1) PosFig(2)+PosFig(4)-sizeFig sizeFig sizeFig])
% prepare the figure
   axis square; colorbar('off'); hIm=gca;
% remove old and draw new panels
   set(hIm,'position',[0.1 0.1 0.5 0.5]); 
%   XLim=get(hIm,'XLim'); YLim=get(hIm,'YLim');
%   hPlot=plot(hOver,XLim,YLim); set(hPlot,'visible','off')
   try delete(UserData.hXDC); end; hXDC=axes('position',[0.1 0.7 0.5 0.25],'box','on','XTick',[],'YTick',[]); 
   try delete(UserData.hYDC); end; hYDC=axes('position',[0.7 0.1 0.25 0.5],'box','on','XTick',[],'YTick',[]);
% X/Y edit fields
hY=uicontrol('Callback',@Plot_XYDC,'Style','edit','fontsize',11,'units','normalized','position',[0.65 0.8 0.16 0.04], ...
                       'string',['-0.1' '+-' sprintf('%0.1f',0.1)]);
uicontrol('Style','text','string','Y=','units','normalized','position',[0.61 0.795 0.04 0.04],'BackgroundColor','w','fontsize',11);
hX=uicontrol('Callback',@Plot_XYDC,'Style','edit','fontsize',11,'units','normalized','position',[0.76 0.625 0.16 0.04], ...
                       'string',['0.0' '+-' sprintf('%0.1f',0.1)]);
uicontrol('Style','text','string','X=','units','normalized','position',[0.72 0.62 0.04 0.04],'BackgroundColor','w','fontsize',11);
% set callback on cursor motion
set(hFig,'WindowButtonDownFcn',@Ginput_XYDC);
%      set(hFig,'WindowButtonMotionFcn',@window_XYDC,'BusyAction','Cancel');
% add user data
   UserData.RawZ=RawZ; UserData.hIm=hIm; UserData.hYDC=hYDC; UserData.hXDC=hXDC; UserData.hX=hX; UserData.hY=hY; 
   set(hFig,'UserData',UserData)  %UserData.hOver=hOver;   
% plot the ROI-cross and XYDCs
Plot_XYDC
end

% graphical input of ROI for XYDCs 
function Ginput_XYDC(~,~,~)
global hFig
% retrieve user data from the current figure 
UserData=get(hFig,'UserData'); hIm=UserData.hIm; 
try hX=UserData.hX; hY=UserData.hY; catch; return; end % return if the previous figure without edit fields
% remove previous lines
try delete([hLine1 hLine2 hLine3 hLine4]); end
%delete(hIm) deleting image makes the function reactive
% plot(hIm,[0 1],[0 1])
% current point
XY=get(hIm,'CurrentPoint'); x=XY(1,1); y=XY(1,2);
% XY=get(hOver,'CurrentPoint'); x=XY(1,1); y=XY(1,2);
% return if outside the image
XLim=get(hIm,'XLim'); YLim=get(hIm,'YLim');
if x<XLim(1) || x>XLim(2) || y<YLim(1) || y>YLim(2); return; end
% X- and Y-fields
xStr=get(hX,'String'); pmPos=strfind(deblank(xStr),'+-'); dX=str2num(xStr(pmPos+2:end)); set(hX,'String',[sprintf('%0.2f+-%0.2f',[x dX])]);
yStr=get(hY,'String'); pmPos=strfind(deblank(yStr),'+-'); dY=str2num(yStr(pmPos+2:end)); set(hY,'String',[sprintf('%0.2f+-%0.2f',[y dY])]);
% plot the ROI-cross and XYDCs
Plot_XYDC

% plot the ROI-cross and XYDCs
function Plot_XYDC(~,~,~)
global hLine1 hLine2 hLine3 hLine4 hFig
% remove previous lines
try delete([hLine1 hLine2 hLine3 hLine4]); end
% retrieve user data from the current figure
UserData=get(hFig,'UserData'); X=UserData.X; Y=UserData.Y; RawZ=UserData.RawZ; 
hIm=UserData.hIm; hXDC=UserData.hXDC; hYDC=UserData.hYDC; hX=UserData.hX; hY=UserData.hY; %hOver=UserData.hOver;
% x- and y-windows
xStr=get(hX,'String'); pmPos=strfind(deblank(xStr),'+-'); x=str2num(xStr(1:pmPos-1)); dX=abs(str2num(xStr(pmPos+2:end)));
if isempty(x*dX); msgbox('Check format X+-dX','modal'); return; end
yStr=get(hY,'String'); pmPos=strfind(deblank(yStr),'+-'); y=str2num(yStr(1:pmPos-1)); dY=abs(str2num(yStr(pmPos+2:end)));
if isempty(y*dY); msgbox('Check format Y+-dY','modal'); return; end
% return if outside the image
XLim=get(hIm,'XLim'); YLim=get(hIm,'YLim');
if x+dX<XLim(1) || x-dX>XLim(2) || y+dY<YLim(1) || y-dY>YLim(2); return; end
% cross
hLine1=line(hIm,[XLim(1) x-dX x-dX],[y-dY y-dY YLim(1)],'color','g');
hLine2=line(hIm,[x+dX x+dX XLim(2)],[YLim(1) y-dY y-dY ],'color','g');
hLine3=line(hIm,[x+dX x+dX XLim(2)],[YLim(2) y+dY y+dY ],'color','g');
hLine4=line(hIm,[XLim(1) x-dX x-dX],[y+dY y+dY YLim(2)],'color','g');
% XDC panel
[XCut,DCut]=Cut(X,Y,RawZ,'mdc',[y-dY y+dY]);
plot(hXDC,XCut,DCut,'linewidth',1); set(hXDC,'xlim',XLim,'xtickmode','auto')
% YDC panel
[YCut,DCut]=Cut(X,Y,RawZ,'edc',[x-dX x+dX]);
plot(hYDC,DCut,YCut,'linewidth',1); set(hYDC,'ylim',YLim,'ytickmode','auto')
% if viewMode==4&&isequal(ScanType,'Tilt'); set(hYDC,'YDir','reverse'); end

% --- Zoom and XY/slope readout function
function window_Zoom(~,~,handles)
% global viewMode X Y Z hGUI hFig 
global CurrentXY PSave ha hc hl hFig hGUI createNewFig
% return if GUI
if isequal(gcf,hGUI); return; end
% clear previous line
try delete([ha hc hl]); end
% retrieve user data from the figure
hFig=gcf;
UserData=get(hFig,'UserData');
viewMode=UserData.viewMode; Opts=UserData.Opts; X=UserData.X; Y=UserData.Y; Z=UserData.Z; 
% reject image series
if viewMode==3; return; end
% keep the plot figure handle which gets spoiled by rbbox
hhFig=hFig;
% previous limits
XLim0=get(gca,'XLim'); YLim0=get(gca,'YLim'); 
% rbbox and its borders
p1=get(gca,'CurrentPoint'); p1x=p1(1,1); p1y=p1(1,2); rbbox; p2=get(gca,'CurrentPoint'); p2x=p2(1,1); p2y=p2(1,2); 
% XY-coordinates if point click
if (p2x-p1x)==0 && (p2y-p1y)==0
% return if the coordinates outside the plot
   if p1x<XLim0(1)||p1x>XLim0(2)||p1y<YLim0(1)||p1y>YLim0(2); return; end
% readout set to XY   
   if get(handles.popupmenuReadout,'Value')==1
%    hc=line(p1x-[-1 1 0 0 0]*diff(XLim0)/20,p1y-[0 0 0 1-1]*diff(YLim0)/20); set(hc,'color','g','linewidth',1.5) % draw cross
      hold on; hc=plot(p1x,p1y,'+g','markersize',20); hold off
      ha=annotation('textbox', [0.7, 0.02, 0.3, 0.05],'String',['X=' sprintf('%0.3f',p1x) '; Y=' sprintf('%0.3f',p1y)],'EdgeColor','W','FontSize',11);
      CurrentXY=[p1x p1y];
%      pause(1); delete(hc) 
      return
% readout set to Slope      
   else 
      if isempty(PSave)
         PSave=[p1x p1y];
         hold on; hc=plot(p1x,p1y,'*g','markersize',10); hold off
      else hl=line([PSave(1) p1x],[PSave(2) p1y]); set(hl,'color','g','linewidth',1.5);
         Fit=polyfit([PSave(1) p1x],[PSave(2) p1y],1); slope=atand(Fit(1));
         ha=annotation('textbox', [0.7, 0.02, 0.3, 0.05],'String',['Slope=' sprintf('%0.3f',slope)],'EdgeColor','W','FontSize',11);
%         pause(1); delete(hl)
         PSave=[];
      end
   end
end
% restore the plot figure handle
hFig=hhFig;
% process current point
XLim=sort([p1x p2x]); YLim=sort([p1y p2y]);
XLim=[max(XLim(1),XLim0(1)) min(XLim(2),XLim0(2))]; 
YLim=[max(YLim(1),YLim0(1)) min(YLim(2),YLim0(2))];
% return if rbbox is too small
% if diff(XLim)*diff(YLim)==0; return; end
if diff(XLim)<0.01*diff(XLim0) || diff(YLim)<0.01*diff(YLim0); return; end
% % return if not the last plotted figure
% if ~isequal(gcf,hhFig); 
%    hMsg=msgbox('Zooming Active Only in the Last Plot','modal'); pause(2); close(hMsg); return; 
% end
% trimming of images to re-colorscale
ZZ=Z;
switch viewMode
case 1
   ZZ(X<XLim(1)|X>XLim(2))=NaN; ZZ(Y<YLim(1)|Y>YLim(2))=NaN;
case 2
   ZZ=[];
case {4,5}
   if size(Y,2)==1; YY=repmat(Y,1,size(X,2)); else YY=Y; end % 1D vector of angles vs 2D array of k
   ZZ(X<XLim(1)|X>XLim(2))=NaN; ZZ(YY<YLim(1)|YY>YLim(2))=NaN;
% case 5
%    [XX,YY]=meshgrid(X,Y);
%    ZZ(X<XLim(1)|X>XLim(2))=NaN; ZZ(YY<YLim(1)|YY>YLim(2))=NaN; 
end
% draw zoomed figure
% close(gcf) % replace previous figure
createNewFig=0; PlotAll(X,Y,ZZ,Opts,handles); set(gca,'XLim',XLim,'YLim',YLim)

% --- Function to set global handle of the active figure for readout
function window_H(~,~,handles)
global hFig hGUI
% return if GUI
if isequal(gcf,hGUI); return; end
hFig=gcf;
% set XDC/YDC of the figure 
hAllAxes=findobj(hFig,'Type','axes');
if length(hAllAxes)==1; set(handles.radiobuttonXYDC,'Value',0); else set(handles.radiobuttonXYDC,'Value',1); end 
% enable slope readout
A=daspect;
if isequal(A(1),A(2)); set(handles.popupmenuReadout,'Enable','On'); 
else set(handles.popupmenuReadout,'Value',1,'Enable','Off'); end

% --- Executes on selection change in popupmenuColormap.
function popupmenuColormap_Callback(~,~,handles)
global createNewFig
createNewFig=0; ProcessView(handles);

% --- Executes on selection change in popupmenuReadout.
function popupmenuReadout_Callback(hObject,~,~)
global PSave
if get(hObject,'Value')==2; PSave=[]; end

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
global ScanFull Scan Data X Y Z Note EAlign FullName
% DataX=Data; ECorrX=ECorr; EAlignX=EAlign; ACorrX=ACorr;
% check data and activated corrections
if isempty(Data); errordlg('No Data','','modal'); return; end
if contains(FullName,'_Export'); waitfor(warndlg('Data file may be already exported','')); end 
% filename to export
Dots=strfind(FullName,'.'); dot=Dots(end);
[filename,pathname]=uiputfile('*.h5','Export As',[FullName(1:dot-1) '_Export.h5']);
if filename~=0; filename=[pathname filename];
else errordlg('Invalid Filename','','modal'); return;
end
% select export of the current image  
if get(handles.popupmenuExport,'Value')==2
   ExpX=X; ExpY=Y; ExpZ=Z;
% select export of the whole data
else
   ExpX=AKx; ExpY=EAlign; ExpZ=Data;
end
% open waitbar
h=waitbar(0.5,'Remapping Data','Windowstyle','Modal');
% remapping (3D data processed sequentally through the images)
[ExpX,ExpY,ExpZ]=Remap(ExpX,ExpY,ExpZ);
% conversion to int32
ExpZ=int32(ExpZ);
% arrays in the IGOR-compatible format
% repeated Data (any acquisition with ones(XXX)) are saved as a sequence of numbered frames and can no more be summed up with correlation;
% all normal scans are OK because Scan is saved
xaxis = [ExpX(1) mean(diff(ExpX))];
yaxis = [ExpY(1) mean(diff(ExpY))];
if isempty(Scan)
    scale = [0 0; xaxis; yaxis;];
else
   ExpZ = permute(ExpZ, [3 1 2]);
% if repeated scans (such as hi-stat scans) the original Scan is ScanFull of the repeated parameters and Scan is their sequential numbers    
%    scan = [Scan(1) mean(diff(Scan))];
    scan = [ScanFull(1) mean(diff(ScanFull))];
    scale = [0 0; xaxis; yaxis; scan];
end
close(h); h=waitbar(0.5,'Saving Data','Windowstyle','Modal');
% delete the file to overwrite which otherwise causes error in h5create
if exist(filename,'file'); delete(filename); end
% write into HDF5 file
h5create(filename, '/Matrix', size(ExpZ));
h5write(filename, '/Matrix', ExpZ);
h5writeatt(filename, '/Matrix', 'IGORWaveNote', Note);
h5writeatt(filename, '/Matrix', 'IGORWaveScaling', fliplr(scale)');
% close waitbar 
close(h);

% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(~,~,~)
% handles of all figures
hPlots=findobj('Type','figure');
% close all figures including the GUI
close(hPlots)
