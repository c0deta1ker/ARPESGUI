function varargout = ProcData(varargin)
% PROCDATA MATLAB code for ProcData.fig
%      PROCDATA, by itself, creates a new PROCDATA or raises the existing
%      singleton*.
%      H = PROCDATA returns the handle to a new PROCDATA or the handle to
%      the existing singleton*.
%      PROCDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROCDATA.M with the given input arguments.
%      PROCDATA('Property','Value',...) creates a new PROCDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ProcData_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ProcData_OpeningFcn via varargin.
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
% Last Modified by GUIDE v2.5 26-May-2019 18:03:16
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProcData_OpeningFcn, ...
                   'gui_OutputFcn',  @ProcData_OutputFcn, ...
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

% --- Executes just before ProcData is made visible.
function ProcData_OpeningFcn(hObject,~,handles,varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% varargin   command line arguments to ProcData (see VARARGIN)
% Choose default command line output for ProcData
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% global parameters
global DivRange scCoeff
global NormGUI
set(handles.editDivEnergy,'String',[num2str(DivRange(1)) ':' num2str(DivRange(2))]);
set(handles.editSubtr,'String',num2str(scCoeff));

NormGUI=gcf; %Create a global refrence to the GUI

% --- Outputs from this function are returned to the command line.
function varargout = ProcData_OutputFcn(~,~,handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in editDivEnergy.
function editDivEnergy_Callback(~,~,handles)
% hObject    handle to editDivEnergy (see GCBO)
% clear normalization array
global DivRange IDiv ISubtr ISlice
IDiv=[]; ISubtr=[]; ISlice=[]; disp('- cleared IDiv ISubtr ISlice')
% Dividing energy range
DivStr=get(handles.editDivEnergy,'String'); DivStr=strrep(DivStr,':',' ');
DivRange=sort(str2num(DivStr));
if length(DivRange)~=2
   DivRange=[0.1 1];
   set(handles.editDivEnergy,'String',[num2str(DivRange(1)) ':' num2str(DivRange(2))]); 
end

% --- Executes on button press in editSubtr.
function editSubtr_Callback(~,~,handles)
% hObject    handle to editSubtr (see GCBO)
global scCoeff ISlice 
ISlice=[]; disp('- cleared ISlice')
% Scaling coefficient to subtract angle-integrated spectrum
scCoeff=str2num(get(handles.editSubtr,'String'));
if length(scCoeff)~=1
   scCoeff=0.0; set(handles.editSubtr,'String','0.0');
end
