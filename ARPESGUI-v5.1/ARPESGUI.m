function varargout = ARPESGUI(varargin)
% ARPESGUI MATLAB code for ARPESGUI.fig
%      ARPESGUI, by itself, creates a new ARPESGUI or raises the existing
%      singleton*.
%
%      H = ARPESGUI returns the handle to a new ARPESGUI or the handle to
%      the existing singleton*.
%
%      ARPESGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ARPESGUI.M with the given input arguments.
%
%      ARPESGUI('Property','Value',...) creates a new ARPESGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ARPESGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ARPESGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ARPESGUI

% Last Modified by GUIDE v2.5 16-Jan-2019 15:47:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ARPESGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ARPESGUI_OutputFcn, ...
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INITIALISATION %%%%%%%%%%%

% --- Executes just before ARPESGUI is made visible.
function ARPESGUI_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ARPESGUI (see VARARGIN)

%% 1 - Setting the native size of the whole GUI figure
screen_size = get(0,'ScreenSize');
screen_size(3) = 400;
screen_size(4) = 375;
set(handles.figure1,'Units','Pixels','Position',screen_size, 'name', 'ARPESGUI');
%% Choose default command line output for ARPESGUI
handles.output = hObject;
%% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = ARPESGUI_OutputFcn(hObject, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)

%% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUSH BUTTONS %%%%%%%%%%%
% --- Executes on button press in pushbutton_CLOSEFIGS.
function pushbutton_CLOSEFIGS_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_CLOSEFIGS (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Remove the GUI handle
hPlots=findobj('Type','figure'); hGUI=gcf; hPlots=hPlots(hPlots~=hGUI);
%% Close all open figures
close(hPlots);

% --- Executes on button press in pushbutton_RESTART.
function pushbutton_RESTART_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_RESTART (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Remove the GUI handle and restart
close(gcbf); run ARPESGUI;

% --- Executes on button press in pushbutton_RESIZEGUI.
function pushbutton_RESIZEGUI_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_RESIZEGUI (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Resetting the native size of the whole GUI figure
screen_size = get(0, 'ScreenSize');
screen_pos = get(gcf, 'Position');
screen_size(1) = screen_pos(1);
screen_size(2) = screen_pos(2);
screen_size(3) = 400;
screen_size(4) = 375;
set(handles.figure1,'Units','Pixels','Position',screen_size, 'name', 'ARPESGUI');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_VIEWIMFP.
function pushbutton_VIEWIMFP_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_VIEWIMFP (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the theoretical IMFP curve
eKE = linspace(1, 1e5, 1e5);
imfp_th = 10 .* (143 ./ eKE .^2 + 0.054.*sqrt(eKE));
dkz_th = 1 ./ imfp_th;
%% 2 - Plotting a summary of the IMFP curves
fig = figure(); set(fig, 'Name', 'IMFP curve');
%-Plotting the figure for the Si IMFP 
loglog(eKE, imfp_th, '-', 'LineWidth', 3, 'color', [0,0,0]);
hold on;
%% Figure formatting
grid on; grid minor;
ax = gca;
% Font properties
ax.FontName = 'Helvetica'; ax.FontWeight = 'normal'; ax.FontSize = 15;
% Tick properties
ax.TickLabelInterpreter = 'latex';
ax.XMinorTick = 'on'; ax.YMinorTick = 'on';
ax.TickDir = 'out';
ax.TickLength = [0.01 0.025];
ax.XColor = [0 0 0]; ax.YColor = [0 0 0];
% Ruler properties
ax.XAxisLocation = 'bottom';            % 'bottom' | 'top' | 'origin'
ax.YAxisLocation = 'left';                   % 'left' | 'right' | 'origin'
% Box Styling properties
ax.LineWidth = 1.5;
ax.Box = 'off'; ax.Layer = 'Top';
% Axis labels and limits
xlabel('$$ \bf  E_{KE} (eV) $$', 'Interpreter', 'latex');
ylabel('$$ \bf  IMFP (\AA) $$', 'Interpreter', 'latex');
% Figure properties
fig = gcf; fig.Color = [1 1 1]; fig.InvertHardcopy = 'off';
% Plotting the x- and y-axes
axis([1, 1e4, 1, 1e3]);
line([0 0], [-1e5, 1e5], 'Color', [0 0 0], 'LineWidth', 0.75, 'Linestyle', '--');
line([-1e5, 1e5], [0 0], 'Color', [0 0 0], 'LineWidth', 0.75, 'Linestyle', '--');
%% Adding custom legends
h = zeros(1, 1);
h(1) = plot(NaN,NaN,'.-', 'linewidth', 5, 'color', [0,0,0]);
legend(h, {'$$ IMFP_{theory} $$'}, 'interpreter', 'latex');

% --- Executes on button press in pushbutton_ARPESView.
function pushbutton_ARPESView_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ARPESView (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Run ARPESView
run ARPESView;

% --- Executes on button press in pushbutton_BZnavi.
function pushbutton_BZnavi_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_BZnavi (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Run bz_navigation
run bz_navigation;

% --- Executes on button press in pushbutton_dataProcessing.
function pushbutton_dataProcessing_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_dataProcessing (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Run arpes_processor
run arpes_processor;

% --- Executes on button press in pushbutton_kfAnalysis.
function pushbutton_kfAnalysis_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_kfAnalysis (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Run arpes_kfanalysis
run arpes_kfanalysis;

% --- Executes on button press in pushbutton_isoeAnalysis.
function pushbutton_isoeAnalysis_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_isoeAnalysis (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Run arpes_isoeanalysis
run arpes_isoeanalysis;

% --- Executes on button press in pushbutton_EbkFitting.
function pushbutton_EbkFitting_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_EbkFitting (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Run arpes_statefitting
run arpes_statefitting;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END OF GUI %%%
