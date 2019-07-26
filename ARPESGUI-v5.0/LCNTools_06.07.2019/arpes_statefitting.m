function varargout = arpes_statefitting(varargin)
% arpes_statefitting MATLAB code for arpes_statefitting.fig
%      ARPES_STATEFITTING, by itself, creates a new ARPES_STATEFITTING or raises the existing
%      singleton*.
%
%      H = ARPES_STATEFITTING returns the handle to a new ARPES_STATEFITTING or the handle to
%      the existing singleton*.
%
%      ARPES_STATEFITTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ARPES_STATEFITTING.M with the given input arguments.
%
%      ARPES_STATEFITTING('Property','Value',...) creates a new ARPES_STATEFITTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before arpes_statefitting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to arpes_statefitting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help arpes_statefitting

% Last Modified by GUIDE v2.5 13-Feb-2019 13:36:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @arpes_statefitting_OpeningFcn, ...
                   'gui_OutputFcn',  @arpes_statefitting_OutputFcn, ...
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
% --- Executes just before arpes_statefitting is made visible.
function arpes_statefitting_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to arpes_statefitting (see VARARGIN)

%% Choose default command line output for arpes_statefitting
handles.output = hObject;
%% 1 - Setting the native size of the whole GUI figure
screen_size = get(0,'ScreenSize');
screen_size(3) = 1037;
screen_size(4) = 530;
set(handles.figure1,'Units','Pixels','Position',screen_size, 'name', 'arpes_statefitting');
%% 2 - Setting push-buttons to inactive
set(handles.pushbutton_SAVE, 'Enable', 'off');
set(handles.pushbutton_TRANSFER, 'Enable', 'off');
set(handles.pushbutton_INFO, 'Enable', 'off');
set(handles.pushbutton_RESET, 'Enable', 'off');
set(handles.pushbutton_ViewFitSummary, 'Enable', 'off');
set(handles.pushbutton_edcTable, 'Enable', 'off');
set(handles.pushbutton_mdcTable, 'Enable', 'off');
set(handles.pushbutton_DELETEFIT, 'Enable', 'off');
%% 3 - Initialising slider text
set(handles.text_scanIndex,'String', handles.scan_fig_args{1}(1));
set(handles.text_scanValue,'String', "NaN");
set(handles.text_edcIndex,'String', handles.edc_fig_args{1}(1));
set(handles.text_edcValue,'String', "NaN");
set(handles.text_mdcIndex,'String', handles.mdc_fig_args{1}(1));
set(handles.text_mdcValue,'String', "NaN");
%% 4 - Disabling all UI elements that may be open during analysis
% - ARPES data browser initialisation
set(handles.checkbox_edcFDD, 'Enable', 'off');
set(handles.checkbox_edcFits, 'Enable', 'off');
set(handles.checkbox_mdcFits, 'Enable', 'off');
handles = checkbox_edcFDD_CreateFcn(handles.checkbox_edcFDD, [], handles);
handles = checkbox_edcFits_CreateFcn(handles.checkbox_edcFits, [], handles);
handles = checkbox_mdcFits_CreateFcn(handles.checkbox_mdcFits, [], handles);
% - Stage 2 UI - Background subtraction
set(findall(handles.uipanel_backSub, '-property', 'enable'), 'enable', 'off');
set(handles.pushbutton_ViewBackSub, 'Enable', 'off');
% - Stage 3 UI - State fitting
% -- FDD and Parabolic trail
set(handles.pushbutton_ViewFDD, 'Enable', 'off');
set(handles.pushbutton_ViewPara, 'Enable', 'off');
% -- EDC constraints
set(handles.checkbox_fitEDCs, 'Enable', 'off');
set(handles.uitable_edc, 'Enable', 'off');
% -- MDC constraints
set(handles.checkbox_fitMDCs, 'Enable', 'off');
set(handles.uitable_mdc, 'Enable', 'off');
% -- Fitting algorithm
set(handles.popupmenu_fitRoutine, 'Enable', 'off');
set(handles.pushbutton_ExecuteAlgorithm, 'Enable', 'off');
%% 5 - Setting ui-panels to inactive until data is loaded
set(findall(handles.uipanel_browser, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_stage1, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_stage2, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_stage3, '-property', 'enable'), 'enable', 'off');
%% Save the handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = arpes_statefitting_OutputFcn(hObject, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)

%% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes just before arpes_statefitting is made visible.
function handles = arpes_statefitting_ResetFcn(hObject, ~, handles)
% This is a function that resets the UI elements to their initial, default
% state.
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Setting push-buttons to inactive
set(handles.pushbutton_SAVE, 'Enable', 'off');
set(handles.pushbutton_TRANSFER, 'Enable', 'off');
set(handles.pushbutton_INFO, 'Enable', 'off');
set(handles.pushbutton_RESET, 'Enable', 'off');
set(handles.pushbutton_ViewFitSummary, 'Enable', 'off');
set(handles.pushbutton_edcTable, 'Enable', 'off');
set(handles.pushbutton_mdcTable, 'Enable', 'off');
set(handles.pushbutton_DELETEFIT, 'Enable', 'off');
%% 2 - Initialising slider text
set(handles.text_scanIndex,'String', handles.scan_fig_args{1}(1));
set(handles.text_scanValue,'String', "NaN");
set(handles.text_edcIndex,'String', handles.edc_fig_args{1}(1));
set(handles.text_edcValue,'String', "NaN");
set(handles.text_mdcIndex,'String', handles.mdc_fig_args{1}(1));
set(handles.text_mdcValue,'String', "NaN");
%% 3 - Disabling all UI elements that may be open during analysis
% - ARPES data browser initialisation
set(handles.checkbox_edcFDD, 'Enable', 'off');
set(handles.checkbox_edcFits, 'Enable', 'off');
set(handles.checkbox_mdcFits, 'Enable', 'off');
handles = checkbox_edcFDD_CreateFcn(handles.checkbox_edcFDD, [], handles);
handles = checkbox_edcFits_CreateFcn(handles.checkbox_edcFits, [], handles);
handles = checkbox_mdcFits_CreateFcn(handles.checkbox_mdcFits, [], handles);
% - Stage 2 UI - Background subtraction
set(findall(handles.uipanel_backSub, '-property', 'enable'), 'enable', 'off');
set(handles.pushbutton_ViewBackSub, 'Enable', 'off');
% - Stage 3 UI - State fitting
% -- FDD and Parabolic trail
set(handles.pushbutton_ViewFDD, 'Enable', 'off');
set(handles.pushbutton_ViewPara, 'Enable', 'off');
% -- EDC constraints
set(handles.checkbox_fitEDCs, 'Enable', 'off');
set(handles.uitable_edc, 'Enable', 'off');
% -- MDC constraints
set(handles.checkbox_fitMDCs, 'Enable', 'off');
set(handles.uitable_mdc, 'Enable', 'off');
% -- Fitting algorithm
set(handles.popupmenu_fitRoutine, 'Enable', 'off');
set(handles.pushbutton_ExecuteAlgorithm, 'Enable', 'off');
%% 4 - Setting ui-panels to inactive until data is loaded
set(findall(handles.uipanel_browser, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_stage1, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_stage2, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_stage3, '-property', 'enable'), 'enable', 'off');
%% Save the handles structure
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% MISCALLENOUS PUSH BUTTONS  %%%%%%%%%%%
% --- Executes on button press in pushbutton_ARPESGUI.
function pushbutton_ARPESGUI_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ARPESGUI (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Run ARPESGUI
run ARPESGUI;

% --- Executes on button press in pushbutton_CLOSEFIGS.
function pushbutton_CLOSEFIGS_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_CLOSEFIGS (see GCBO)
% Finding the handles of all figures

%% Remove the GUI handle
hPlots=findobj('Type','figure'); hGUI=gcf; hPlots=hPlots(hPlots~=hGUI);
%% Close all open figures
close(hPlots);

% --- Executes on button press in pushbutton_RESTART.
function pushbutton_RESTART_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_RESTART (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Remove the GUI handle and restart
close(gcbf); run arpes_statefitting;

% --- Executes on button press in pushbutton_RESIZEGUI.
function pushbutton_RESIZEGUI_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_RESIZEGUI (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Resetting the native size of the whole GUI figure
screen_size = get(0, 'ScreenSize');
screen_pos = get(gcf, 'Position');
screen_size(1) = screen_pos(1);
screen_size(2) = screen_pos(2);
screen_size(3) = 1037;
screen_size(4) = 530;
set(handles.figure1,'Units','Pixels','Position',screen_size, 'name', 'arpes_statefitting');s
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_TRANSFER.
function pushbutton_TRANSFER_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_TRANSFER (see GCBO)
% handles    structure with handles and user data (see GUIDATA)
%% Transfer requested data to the MATLAB workspace
assignin('base','arpes_data',handles.myData);
assignin('base','arpes_fits',handles.myFit);
if isfield(handles.myFit, 'edc_fits'); assignin('base','arpes_edc_fits',handles.myFit.edc_fits); end
if isfield(handles.myFit, 'mdc_fits'); assignin('base','arpes_mdc_fits',handles.myFit.mdc_fits); end

% --- Executes on button press in pushbutton_INFO.
function pushbutton_INFO_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_INFO (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Display the handles and handles.myData data structures
disp('HANDLES : '); disp(handles);
disp('DATA (.myData) : '); disp(handles.myData);
if isfield(handles, 'myFit'); disp('ROI data (.myFit) : '); disp(handles.myFit); end
if isfield(handles.myFit, 'fdd'); disp('FDD (.fdd) : '); disp(handles.myFit.fdd); end
if isfield(handles.myFit, 'para'); disp('PARABOLA (.para) : '); disp(handles.myFit.para); end
if isfield(handles.myFit, 'edc_fits'); disp('EDC fits (.edc_fits) : '); disp(handles.myFit.edc_fits); end
if isfield(handles.myFit, 'mdc_fits'); disp('MDC fits (.mdc_fits) : '); disp(handles.myFit.mdc_fits); end

% --- Executes on button press in pushbutton_LOAD.
function pushbutton_LOAD_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_LOAD (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Loading in the FileName and PathName of the selected data
[FileName, PathName] = uigetfile({'*.mat'}, 'Pick a fully processed *.mat ARPES data file...');
% - If Cancel is pressed, then return nothing
if isequal(PathName,0) || isequal(FileName,0); return; end
% - 1.1 - Load in the file selected
[handles.myData, handles.myFit] = load_arpes_data(FileName, handles.freshload);
%% 2 - Reseting the GUI to the initial state
handles = arpes_statefitting_ResetFcn(hObject, [], handles);
%% 3 - Updating handle text and buttons
% - 3.1 - Show the name, type and information of the ARPES data
set(handles.text_FileName,'String',handles.myFit.matfile);
% - 3.2 - Activating push-buttons that can be used
set(handles.pushbutton_SAVE, 'Enable', 'on');
set(handles.pushbutton_TRANSFER, 'Enable', 'on');
set(handles.pushbutton_INFO, 'Enable', 'on');
set(handles.pushbutton_RESET, 'Enable', 'on');
%% 3 - Initialising UI elements for data browsing
% - ARPES data browser initialisation
set(findall(handles.uipanel_browser, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_edcBrowser, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_mdcBrowser, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_stage1, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_stage2, '-property', 'enable'), 'enable', 'on');
% - Disable button UIs not used yet
% - Stage 2 UI - Background subtraction
if isfield(handles.myFit, 'Meta')
    if isfield(handles.myFit.Meta, 'bsub')
        set(findall(handles.uipanel_backSub, '-property', 'enable'), 'enable', 'on');
        set(handles.pushbutton_ViewBackSub, 'Enable', 'on');
    else
        set(findall(handles.uipanel_backSub, '-property', 'enable'), 'enable', 'off');
        set(handles.pushbutton_ViewBackSub, 'Enable', 'off');
    end
else
    set(findall(handles.uipanel_backSub, '-property', 'enable'), 'enable', 'off');
    set(handles.pushbutton_ViewBackSub, 'Enable', 'off');
end
if isfield(handles.myFit, 'fdd'); set(handles.checkbox_edcFDD, 'Enable', 'on');
else; set(handles.checkbox_edcFDD, 'Enable', 'off');
end
if isfield(handles.myFit, 'edc_fits'); set(handles.checkbox_edcFits, 'Enable', 'on'); set(handles.pushbutton_ViewFitSummary, 'Enable', 'on');
else; set(handles.checkbox_edcFits, 'Enable', 'off');
end
if isfield(handles.myFit, 'mdc_fits'); set(handles.checkbox_mdcFits, 'Enable', 'on'); set(handles.pushbutton_ViewFitSummary, 'Enable', 'on');
else; set(handles.checkbox_mdcFits, 'Enable', 'off');
end
% - Load in the state-fitting UI elements
if isfield(handles.myFit, 'kx_roi'); set(findall(handles.uipanel_stage3, '-property', 'enable'), 'enable', 'on');
else; set(findall(handles.uipanel_stage3, '-property', 'enable'), 'enable', 'off');
end
if isfield(handles.myFit, 'fdd'); set(handles.pushbutton_ViewFDD, 'Enable', 'on');
else; set(handles.pushbutton_ViewFDD, 'Enable', 'off');
end
if isfield(handles.myFit, 'para'); set(handles.pushbutton_ViewPara, 'Enable', 'on');
else; set(handles.pushbutton_ViewPara, 'Enable', 'off');
end
%% 4 - Updating UI elements based on whether the data is 2D or 3D
% Finding the extent of the fitting performed
[~, ~, zField, dField] = find_roi_fields(handles.myFit);
% - Initialising the scan slider
if handles.myFit.Type == "Eb(k)"
    set(findall(handles.uipanel_scanBrowser, '-property', 'enable'), 'enable', 'off');
    handles = slider_scanSlider_CreateFcn(handles.slider_scanSlider, [], handles);
    handles = slider_scanSlider_Callback(handles.slider_scanSlider, [], handles, 1);
    handles.scan_fig_args{1}(1) = 1;
    handles.scan_fig_args{1}(2) = handles.myFit.(zField);
    set(handles.text_scanIndex,'String', handles.scan_fig_args{1}(1));
    set(handles.text_scanValue,'String', handles.scan_fig_args{1}(1));
elseif handles.myFit.Type == "Eb(kx,ky)" || handles.myFit.Type == "Eb(kx,kz)"
    set(findall(handles.uipanel_scanBrowser, '-property', 'enable'), 'enable', 'on');
    set(handles.slider_scanSlider,'min', 1, 'max', size(handles.myFit.(dField), 3), 'Value', 1, 'SliderStep', [1/(size(handles.myFit.(dField), 3)-1), 1/(size(handles.myFit.(dField), 3)-1) ]);
    handles = slider_scanSlider_Callback(handles.slider_scanSlider, [], handles, 1);
end
% - Initialising the edc scan slider
set(handles.slider_edcSlider,'min', 1, 'max', size(handles.myFit.(dField), 2), 'Value', floor(0.5*size(handles.myFit.(dField), 2)), 'SliderStep', [1/(size(handles.myFit.(dField), 2)-1), 1/(size(handles.myFit.(dField), 2)-1) ]);
handles = slider_edcSlider_Callback(handles.slider_edcSlider, [], handles, 0);
% - Initialising the mdc scan slider
set(handles.slider_mdcSlider,'min', 1, 'max', size(handles.myFit.(dField), 1), 'Value', floor(0.5*size(handles.myFit.(dField), 1)), 'SliderStep', [1/(size(handles.myFit.(dField), 1)-1), 1/(size(handles.myFit.(dField), 1)-1) ]);
handles = slider_mdcSlider_Callback(handles.slider_mdcSlider, [], handles, 0);
%% Display the handles data
pushbutton_INFO_Callback(handles.pushbutton_INFO, [], handles);
%% Save the handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_SAVE.
function pushbutton_SAVE_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_SAVE (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - User defined FileName and Path for the processed data
filter = {'*.mat'};
[save_filename, save_filepath] = uiputfile(filter, 'Save processed ARPES data', handles.myFit.matfile);
save_fullfile = char(string(save_filepath) + string(save_filename));
% - If Cancel is pressed, then return nothing
if isequal(save_filepath,0) || isequal(save_filename,0); return; end
%% 2 - Executing the saving of the processed data
wbar=waitbar(0.5,'Saving...'); 
dataStruc = handles.myData; dataStruc.fits = handles.myFit;
save(char(save_fullfile), 'dataStruc', '-v7.3');
disp('-> saved arpes fitting : '); display(dataStruc);
close(wbar);
%% 3 - Saving the ROI and latest EDC and MDC cuts
if isfield(handles, 'myFit')
    fig_full = view_scan_fig(handles.myFit, handles.scan_fig_args);
    print(fig_full, char(save_fullfile(1:end-4)+"_roi.png"), '-dpng');
    handles.edc_fig_args{3} = 0; handles.mdc_fig_args{3} = 1; 
    fig_mdc = view_mdc_fig(handles.myFit, handles.scan_fig_args, handles.edc_fig_args, handles.mdc_fig_args);
    print(fig_mdc, char(save_fullfile(1:end-4)+"_mdc.png"), '-dpng');
    handles.edc_fig_args{3} = 1; handles.mdc_fig_args{3} = 0; 
    fig_edc = view_edc_fig(handles.myFit, handles.scan_fig_args, handles.edc_fig_args, handles.mdc_fig_args);
    print(fig_edc, char(save_fullfile(1:end-4)+"_edc.png"), '-dpng');
    if size(handles.myFit.edc_fits, 1) ~= 1 || size(handles.myFit.mdc_fits, 1) ~= 1
        fig_sum = view_fit_summary(handles.myFit, handles.scan_fig_args);
        print(fig_sum, char(save_fullfile(1:end-4)+"_sum.png"), '-dpng');
        edc_tab = view_edc_table(handles.myFit, handles.scan_fig_args, handles.edc_fig_args, handles.mdc_fig_args);
        saveas(edc_tab, char(save_fullfile(1:end-4)+"_edc"));
        mdc_tab = view_mdc_table(handles.myFit, handles.scan_fig_args, handles.edc_fig_args, handles.mdc_fig_args);
        saveas(mdc_tab, char(save_fullfile(1:end-4)+"_mdc"));
    end
end

% --- Executes on button press in pushbutton_RESET.
function pushbutton_RESET_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_RESET (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Re-loading the ARPES file
[handles.myData, handles.myFit] = load_arpes_data(handles.myFit.matfile, 1);
%% 2 - Reseting the GUI to the initial state
handles = arpes_statefitting_ResetFcn(hObject, [], handles);
%% 3 - Updating handle text and buttons
% - 3.1 - Show the name, type and information of the ARPES data
set(handles.text_FileName,'String',handles.myFit.matfile);
% - 3.2 - Activating push-buttons that can be used
set(handles.pushbutton_SAVE, 'Enable', 'on');
set(handles.pushbutton_TRANSFER, 'Enable', 'on');
set(handles.pushbutton_INFO, 'Enable', 'on');
set(handles.pushbutton_RESET, 'Enable', 'on');
%% 3 - Initialising UI elements for data browsing
% - ARPES data browser initialisation
set(findall(handles.uipanel_browser, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_edcBrowser, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_mdcBrowser, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_stage1, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_stage2, '-property', 'enable'), 'enable', 'on');
% - Disable button UIs not used yet
% - Stage 2 UI - Background subtraction
if isfield(handles.myFit, 'back_sub')
    set(findall(handles.uipanel_backSub, '-property', 'enable'), 'enable', 'on');
    set(handles.pushbutton_ViewBackSub, 'Enable', 'on');
else
    set(findall(handles.uipanel_backSub, '-property', 'enable'), 'enable', 'off');
    set(handles.pushbutton_ViewBackSub, 'Enable', 'off');
end
if isfield(handles.myFit, 'fdd'); set(handles.checkbox_edcFDD, 'Enable', 'on');
else; set(handles.checkbox_edcFDD, 'Enable', 'off');
end
if isfield(handles.myFit, 'edc_fits'); set(handles.checkbox_edcFits, 'Enable', 'on');
else; set(handles.checkbox_edcFits, 'Enable', 'off');
end
if isfield(handles.myFit, 'mdc_fits'); set(handles.checkbox_mdcFits, 'Enable', 'on');
else; set(handles.checkbox_mdcFits, 'Enable', 'off');
end
% - Load in the state-fitting UI elements
if isfield(handles.myFit, 'kx_roi'); set(findall(handles.uipanel_stage3, '-property', 'enable'), 'enable', 'on');
else; set(findall(handles.uipanel_stage3, '-property', 'enable'), 'enable', 'off');
end
if isfield(handles.myFit, 'fdd'); set(handles.pushbutton_ViewFDD, 'Enable', 'on');
else; set(handles.pushbutton_ViewFDD, 'Enable', 'off');
end
if isfield(handles.myFit, 'parabola'); set(handles.pushbutton_ViewPara, 'Enable', 'on');
else; set(handles.pushbutton_ViewPara, 'Enable', 'off');
end
%% 4 - Updating UI elements based on whether the data is 2D or 3D
% Finding the extent of the fitting performed
[~, ~, zField, dField] = find_roi_fields(handles.myFit);
% - Initialising the scan slider
if handles.myFit.Type == "Eb(k)"
    set(findall(handles.uipanel_scanBrowser, '-property', 'enable'), 'enable', 'off');
    handles = slider_scanSlider_CreateFcn(handles.slider_scanSlider, [], handles);
    handles = slider_scanSlider_Callback(handles.slider_scanSlider, [], handles, 1);
    handles.scan_fig_args{1}(1) = 1;
    handles.scan_fig_args{1}(2) = handles.myFit.(zField);
    set(handles.text_scanIndex,'String', handles.scan_fig_args{1}(1));
    set(handles.text_scanValue,'String', handles.scan_fig_args{1}(1));
elseif handles.myFit.Type == "Eb(kx,ky)" || handles.myFit.Type == "Eb(kx,kz)"
    set(findall(handles.uipanel_scanBrowser, '-property', 'enable'), 'enable', 'on');
    set(handles.slider_scanSlider,'min', 1, 'max', size(handles.myFit.(dField), 3), 'Value', 1, 'SliderStep', [1/(size(handles.myFit.(dField), 3)-1), 1/(size(handles.myFit.(dField), 3)-1) ]);
    handles = slider_scanSlider_Callback(handles.slider_scanSlider, [], handles, 1);
end
% - Initialising the edc scan slider
set(handles.slider_edcSlider,'min', 1, 'max', size(handles.myFit.(dField), 2), 'Value', floor(0.5*size(handles.myFit.(dField), 2)), 'SliderStep', [1/(size(handles.myFit.(dField), 2)-1), 1/(size(handles.myFit.(dField), 2)-1) ]);
handles = slider_edcSlider_Callback(handles.slider_edcSlider, [], handles, 0);
% - Initialising the mdc scan slider
set(handles.slider_mdcSlider,'min', 1, 'max', size(handles.myFit.(dField), 1), 'Value', floor(0.5*size(handles.myFit.(dField), 1)), 'SliderStep', [1/(size(handles.myFit.(dField), 1)-1), 1/(size(handles.myFit.(dField), 1)-1) ]);
handles = slider_mdcSlider_Callback(handles.slider_mdcSlider, [], handles, 0);
%% Display the handles data
pushbutton_INFO_Callback(handles.pushbutton_INFO, [], handles);
%% Save the handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_DELETEFIT.
function pushbutton_DELETEFIT_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_DELETEFIT (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Delete the fits made depending on the choice of the scan slice
if isfield(handles.myFit, 'edc_fits')
    handles.myFit.edc_fits{handles.scan_fig_args{1}(1)} = [];
end
if isfield(handles.myFit, 'mdc_fits')
    handles.myFit.mdc_fits{handles.scan_fig_args{1}(1)} = [];
end
%% 3 - Verify deletion
handles = slider_scanSlider_Callback(handles.slider_scanSlider, [], handles, 0);
%% 4 - Ask the user if they want to delete the fit
answer = questdlg('Are you sure you want to delete this fit?', ...
	'Delete fit?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end

%% 3 - Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ViewFitSummary.
function pushbutton_ViewFitSummary_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ViewFitSummary (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% View the fit summary
fig = view_fit_summary(handles.myFit, handles.scan_fig_args);

% --- Executes on button press in pushbutton_edcTable.
function pushbutton_edcTable_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_edcTable (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% View the EDC fit table
view_edc_table(handles.myFit, handles.scan_fig_args, handles.edc_fig_args, handles.mdc_fig_args);

% --- Executes on button press in pushbutton_mdcTable.
function pushbutton_mdcTable_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_mdcTable (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% View the MDC fit table
view_mdc_table(handles.myFit, handles.scan_fig_args, handles.edc_fig_args, handles.mdc_fig_args);

% --- Executes on button press in pushbutton_SaveConstraints.
function pushbutton_SaveConstraints_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_SaveConstraints (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

% User-defined filename and path for save_data
filter = {'*.txt'};
[save_filename, save_filepath] = uiputfile(filter);
save_fullfile = char(string(save_filepath) + string(save_filename));
% If Cancel is pressed, then return nothing
if isequal(save_filepath,0) || isequal(save_filename,0); return; end
% Otherwise save the data
wbar=waitbar(0.5,'Saving...');
% Extracting table objects
fdd_table  = cell2table(handles.uitable_fdd.Data, 'Variablename', {'T', 'Ef', 'dEb'});
para_table  = cell2table(handles.uitable_para.Data, 'Variablename', {'k0', 'dk0', 'eb0', 'deb0', 'm'});
edc_table  = cell2table(handles.uitable_edc.Data, 'Variablename', {'kRange', 'curve', 'peak', 'fwhm', 'FDD', 'nullShift'});
mdc_table  = cell2table(handles.uitable_mdc.Data, 'Variablename', {'ebRange', 'curve', 'peak', 'fwhm', 'symmetric', 'nullShift'});
% Writing table to text file
writetable(fdd_table, save_fullfile(1:end-4)+"fdd.txt", 'Delimiter','|')
writetable(para_table, save_fullfile(1:end-4)+"para.txt", 'Delimiter','|')
writetable(edc_table, save_fullfile(1:end-4)+"edc.txt", 'Delimiter','|')
writetable(mdc_table, save_fullfile(1:end-4)+"mdc.txt", 'Delimiter','|')
% - Saving the data object
close(wbar);

% --- Executes on button press in pushbutton_LoadConstraints.
function pushbutton_LoadConstraints_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_LoadConstraints (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

% Loading the filename and path
[FileName, PathName] = uigetfile({'*.txt'}, 'Choose a text file to load...', 'MultiSelect', 'On');
% - If Cancel is pressed, then return nothing
if isequal(PathName,0) || isequal(FileName,0); return; end

% - Loading in the tables from each file selected
wbar = waitbar(0.3,'Reading In...','Windowstyle','Modal');
wbar.Children.Title.Interpreter = 'none';

% For a single file
if ischar(FileName)
    wbar_txt = sprintf("Loading %s...", FileName);
    waitbar(0.5, wbar, wbar_txt);
    % - Extracting table and data
    new_table = readtable(FileName, 'Delimiter','|');
    new_data = table2cell(new_table);
    % - Finding and removing the NaN values 
    nan_indx = ismissing(new_table);
    for i=1:size(nan_indx,1)
        for j=1:size(nan_indx,2)
            if nan_indx(i,j) == 1; new_data{i,j} = []; end
            if j == 5 && string(new_table.Properties.VariableNames{1}) ~= "k0"
                if new_data{i,5} == 1; new_data{i,5} = logical(1);
                else; new_data{i,5} = logical(0);
                end
            end
        end
    end
    % - Find which type of file has been selected
    if string(new_table.Properties.VariableNames{1}) == "T"
        set(handles.uitable_fdd,'Data',new_data);
    elseif string(new_table.Properties.VariableNames{1}) == "k0"
        set(handles.uitable_para,'Data',new_data);
    elseif string(new_table.Properties.VariableNames{1}) == "kRange"
        set(handles.uitable_edc,'Data',new_data);
    elseif string(new_table.Properties.VariableNames{1}) == "ebRange"
        set(handles.uitable_mdc,'Data',new_data);
    end
% For a multiple files
else
    for f = 1:size(FileName,2)
        wbar_txt = sprintf("Loading %s...", FileName{f});
        waitbar(f/size(FileName,2), wbar, wbar_txt);
        % - Extracting table and data
        new_table = readtable(FileName{f}, 'Delimiter','|');
        new_data = table2cell(new_table);
        % - Finding and removing the NaN values 
        nan_indx = ismissing(new_table);
        for i=1:size(nan_indx,1)
            for j=1:size(nan_indx,2)
                if nan_indx(i,j) == 1; new_data{i,j} = []; end
            end
        end
        % - Find which type of file has been selected
        if string(new_table.Properties.VariableNames{1}) == "T"
            set(handles.uitable_fdd,'Data',new_data);
        elseif string(new_table.Properties.VariableNames{1}) == "k0"
            set(handles.uitable_para,'Data',new_data);
        elseif string(new_table.Properties.VariableNames{1}) == "kRange"
            set(handles.uitable_edc,'Data',new_data);
        elseif string(new_table.Properties.VariableNames{1}) == "ebRange"
            set(handles.uitable_mdc,'Data',new_data);
        end
    end
end
close(wbar);
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ViewSeries.
function pushbutton_ViewSeries_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ViewSeries (see GCBO)
% handles    structure with handles and user data (see GUIDATA)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FRESH LOAD CHECKBOX  %%%%%%%%%%%%
% --- Executes on button press in checkbox_freshload.
function checkbox_freshload_Callback(hObject, ~, handles)
% hObject    handle to checkbox_freshload (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the state of the checkbox
val = get(hObject,'Value');
handles.freshload  = val;
if val == 1;  fprintf("--> Omitting all previous fits when loading data: True \n");
else; fprintf("--> Omitting all previous fits when loading data: False \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function checkbox_freshload_CreateFcn(hObject, ~, handles)
% hObject    handle to checkbox_freshload (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% 1 - Setting the default value
handles.freshload =  0;
set(hObject,'Value', 0);
%% Update handles structure
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ARPES DATA BROWSER  %%%%%%%%%%%%
% --- Executes on slider movement.
function handles = slider_scanSlider_Callback(hObject, ~, handles, plotfig)
% hObject    handle to slider_scanSlider (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Default parameters
if nargin < 4; plotfig =  1; end
if isempty(plotfig); plotfig =  1;  end
%% 1 - Extracting the slider value
data_entry =  floor(get(hObject, 'Value'));
%% 2 - Assigning values to handles
% - Extracting the current state of analysis
[~, ~, zField, dField] = find_roi_fields(handles.myFit);
midX_indx = ceil(0.5*size(handles.myFit.(dField), 1));
midY_indx = ceil(0.5*size(handles.myFit.(dField), 2));
if handles.myFit.Type == "Eb(k)"
    handles.scan_fig_args{1}(1) = data_entry;
    handles.scan_fig_args{1}(2) = round(handles.myFit.(zField)(1), 4);
elseif handles.myFit.Type == "Eb(kx,ky)" || handles.myFit.Type == "Eb(kx,kz)"
    handles.scan_fig_args{1}(1) = data_entry;
    if size(handles.myFit.(zField), 2) > 1
        handles.scan_fig_args{1}(2) = round(handles.myFit.(zField)(midX_indx, midY_indx, data_entry), 4);
    else
        handles.scan_fig_args{1}(2) = round(handles.myFit.(zField)(data_entry), 4);
    end
end
%% 2 - Modifying the text to show the scan number
set(handles.text_scanIndex,'String', handles.scan_fig_args{1}(1));
set(handles.text_scanValue,'String', handles.scan_fig_args{1}(2));
%% 3 - Validity check on the integration window
handles = edit_edcWin_Callback(handles.edit_edcWin, [], handles);
handles = edit_mdcWin_Callback(handles.edit_mdcWin, [], handles);
%% 4 - Validity check on the EDC/MDC fits
% - Check on EDC fits
if isfield(handles.myFit, 'edc_fits')
    if isempty(handles.myFit.edc_fits{handles.scan_fig_args{1}(1)})
        set(handles.checkbox_edcFits, 'Enable', 'off');
        handles = checkbox_edcFits_CreateFcn(handles.checkbox_edcFits, [], handles);
        set(handles.pushbutton_edcTable, 'Enable', 'off');
    else
        set(handles.checkbox_edcFits, 'Enable', 'on');
        set(handles.pushbutton_edcTable, 'Enable', 'on');
    end
end
% - Check on MDC fits
if isfield(handles.myFit, 'mdc_fits')
    if isempty(handles.myFit.mdc_fits{handles.scan_fig_args{1}(1)})
        set(handles.checkbox_mdcFits, 'Enable', 'off');
        handles = checkbox_mdcFits_CreateFcn(handles.checkbox_mdcFits, [], handles);
        set(handles.pushbutton_mdcTable, 'Enable', 'off');
    else
        set(handles.checkbox_mdcFits, 'Enable', 'on');
        set(handles.pushbutton_mdcTable, 'Enable', 'on');
    end
end
%% 5 - Plotting the latest ARPES data
if plotfig == 1; view_scan_fig(handles.myFit, handles.scan_fig_args); end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function handles = slider_scanSlider_CreateFcn(hObject, ~, handles)
% hObject    handle to slider_scanSlider (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%%% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%% 1 - Setting the default value
handles.scan_fig_args{1}(1) =  1;
handles.scan_fig_args{1}(2) =  0;
set(hObject,'Value', 1);
%% Update handles structure
guidata(hObject, handles);

% --- Executes on slider movement
function handles = slider_edcSlider_Callback(hObject, ~, handles, plotfig)
% hObject    handle to slider_edcSlider (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Default parameters
if nargin < 4; plotfig =  1; end
if isempty(plotfig); plotfig =  1;  end

%% 1 - Extracting the slider value
data_entry =  floor(get(hObject, 'Value'));
%% 2 - Assigning values to handles
% - Extracting the current state of analysis
[xField, ~, ~, ~] = find_roi_fields(handles.myFit);
handles.edc_fig_args{1}(1) = data_entry;
handles.edc_fig_args{1}(2) = round(handles.myFit.(xField)(1,data_entry, handles.scan_fig_args{1}(1)),4);
%% 2 - Modifying the text to show the scan number
set(handles.text_edcIndex,'String', handles.edc_fig_args{1}(1));
set(handles.text_edcValue,'String', handles.edc_fig_args{1}(2));
%% 3 - Validity check on the integration window
handles = edit_edcWin_Callback(handles.edit_edcWin, [], handles);
%% 4 - Plotting the latest ARPES data with EDC cuts
if plotfig == 1; view_edc_fig(handles.myFit, handles.scan_fig_args, handles.edc_fig_args, handles.mdc_fig_args); end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_edcSlider_CreateFcn(hObject, ~, handles)
% hObject    handle to slider_edcSlider (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%% 1 - Setting the default value
handles.edc_fig_args{1} =  1;
set(hObject,'Value', 1);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_edcWin_Callback(hObject, ~, handles)
% hObject    handle to edit_edcWin (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = abs(round(str2num(get(hObject,'String')), 4));
%% 2 - Validity check on the input
% - Extracting the current state of analysis
[xField, ~, ~, ~] = find_roi_fields(handles.myFit);
% - Extracting the max/min values
dx_min = round(abs(handles.myFit.(xField)(1,2,handles.scan_fig_args{1}(1))...
    - handles.myFit.(xField)(1,1,handles.scan_fig_args{1}(1))), 4);
dx_max = round(abs(handles.myFit.(xField)(1,end,handles.scan_fig_args{1}(1))...
    - handles.myFit.(xField)(1,1,handles.scan_fig_args{1}(1))), 4);
% - Passing through vailidity checks
if isempty(data_entry); data_entry = dx_min;
else
    data_entry = data_entry(1); 
    if data_entry < dx_min; data_entry = dx_min;
    elseif data_entry > dx_max; data_entry = dx_max; 
    end
end
%% 3 - Assigning data entry to variable
handles.edc_fig_args{2} = data_entry;
set(hObject,'String', handles.edc_fig_args{2});
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_edcWin_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_edcWin (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Setting the default value
handles.edc_fig_args{2} =  0;
set(hObject,'Value', 0);
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox_edcFits.
function checkbox_edcFits_Callback(hObject, ~, handles)
% hObject    handle to checkbox_edcFits (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the state of the checkbox
val = get(hObject,'Value');
handles.edc_fig_args{3}  = val;
if val == 1;  fprintf("--> EDC browser - Show Fits: True \n");
else; fprintf("--> EDC browser - Show Fits: False \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function handles = checkbox_edcFits_CreateFcn(hObject, ~, handles)
% hObject    handle to checkbox_edcFits (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% 1 - Set default parameters
set(hObject,'Value',0);
handles.edc_fig_args{3} = get(hObject,'Value');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox_edcFDD.
function checkbox_edcFDD_Callback(hObject, ~, handles)
% hObject    handle to checkbox_edcFDD (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the state of the checkbox
val = get(hObject,'Value');
handles.edc_fig_args{4}  = val;
if val == 1;  fprintf("--> EDC browser - Show FDD: True \n");
else; fprintf("--> EDC browser - Show FDD: False \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function handles = checkbox_edcFDD_CreateFcn(hObject, ~, handles)
% hObject    handle to checkbox_edcFDD (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% 1 - Set default parameters
set(hObject,'Value',0);
handles.edc_fig_args{4} = get(hObject,'Value');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on slider movement.
function handles = slider_mdcSlider_Callback(hObject, ~, handles, plotfig)
% hObject    handle to slider_mdcSlider (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Default parameters
if nargin < 4; plotfig =  1; end
if isempty(plotfig); plotfig =  1;  end

%% 1 - Extracting the slider value
data_entry =  floor(get(hObject, 'Value'));
%% 2 - Assigning values to handles
% - Extracting the current state of analysis
[~, yField, ~, ~] = find_roi_fields(handles.myFit);
handles.mdc_fig_args{1}(1) = data_entry;
handles.mdc_fig_args{1}(2) = round(handles.myFit.(yField)(data_entry,1,handles.scan_fig_args{1}(1)),4);
%% 2 - Modifying the text to show the scan number
set(handles.text_mdcIndex,'String', handles.mdc_fig_args{1}(1));
set(handles.text_mdcValue,'String', handles.mdc_fig_args{1}(2));
%% 3 - Validity check on the integration window
handles = edit_mdcWin_Callback(handles.edit_mdcWin, [], handles);
%% 4 - Plotting the latest ARPES data with MDC cuts
if plotfig == 1; view_mdc_fig(handles.myFit, handles.scan_fig_args, handles.edc_fig_args, handles.mdc_fig_args); end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_mdcSlider_CreateFcn(hObject, ~, handles)
% hObject    handle to slider_mdcSlider (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%% 1 - Setting the default value
handles.mdc_fig_args{1} =  1;
set(hObject,'Value', 1);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_mdcWin_Callback(hObject, ~, handles)
% hObject    handle to edit_mdcWin (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = abs(round(str2num(get(hObject,'String')), 4));
%% 2 - Validity check on the input
% - Extracting the current state of analysis
[~, yField, ~, ~] = find_roi_fields(handles.myFit);
% - Extracting the max/min values
dy_min = round(abs(handles.myFit.(yField)(2,1,handles.scan_fig_args{1}(1))...
    - handles.myFit.(yField)(1,1,handles.scan_fig_args{1}(1))), 4);
dy_max = round(abs(handles.myFit.(yField)(end,1,handles.scan_fig_args{1}(1))...
    - handles.myFit.(yField)(1,1,handles.scan_fig_args{1}(1))), 4);
% - Passing through vailidity checks
if isempty(data_entry); data_entry = dy_min;
else
    data_entry = data_entry(1); 
    if data_entry < dy_min; data_entry = dy_min;
    elseif data_entry > dy_max; data_entry = dy_max; 
    end
end
%% 3 - Assigning data entry to variable
handles.mdc_fig_args{2} = data_entry;
set(hObject,'String', handles.mdc_fig_args{2});
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_mdcWin_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_mdcWin (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Setting the default value
handles.mdc_fig_args{2} =  0;
set(hObject,'Value', 0);
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox_mdcFits.
function checkbox_mdcFits_Callback(hObject, ~, handles)
% hObject    handle to checkbox_mdcFits (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the state of the checkbox
val = get(hObject,'Value');
handles.mdc_fig_args{3}  = val;
if val == 1;  fprintf("--> MDC browser - Show Fits: True \n");
else; fprintf("--> MDC browser - Show Fits: False \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function handles =  checkbox_mdcFits_CreateFcn(hObject, ~, handles)
% hObject    handle to checkbox_mdcFits (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% 1 - Set default parameters
set(hObject,'Value',0);
handles.mdc_fig_args{3} = get(hObject,'Value');
%% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STAGE 1 - REALIGN KX  %%%%%%%%%%%%
% --- Executes when changing the text
function edit_kxShift_Callback(hObject, ~, handles)
% hObject    handle to edit_kxShift (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 4);
%% 2 - Validity check of the ROI input
 % - If no entry is made, default to 3
if isempty(data_entry) ||  length(data_entry) > 2 || size(data_entry, 1) > 1; data_entry = 0;
 % - If a single entry is made, round it down to nearest integer
elseif length(data_entry) == 1 && size(data_entry, 1) ==1; data_entry = data_entry;
 % - Everything else goes to the default value
else; data_entry = 0;
end
handles.kx_align_args{1}  = data_entry;
set(hObject,'String', string(handles.kx_align_args{1})); 
fprintf("--> kx shift: " + string(handles.kx_align_args{1}) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_kxShift_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_kxShift (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.kx_align_args{1} = 0; 
set(hObject,'String', "0");
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExecuteKxAlignment.
function pushbutton_ExecuteKxAlignment_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExecuteKxAlignment (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Performing the re-alignment operation
handles.myFit = align_kx(handles.myFit, handles.kx_align_args);
%% 2 - View the figure update
view_scan_fig(handles.myFit, handles.scan_fig_args);
%% 3 - Ask the user if they want to keep the new filtered data
answer = questdlg('Would you like to store the aligned data?', ...
	'Align data?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
%% Update the handles
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STAGE 1 - SCALE KX  %%%%%%%%%%%%%
% --- Executes on button press in pushbutton_ExecuteKxScaling.
function pushbutton_ExecuteKxScaling_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExecuteKxScaling (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Performing the re-alignment operation
handles.myFit = scale_kx(handles.myFit, handles.kx_scale_args);
%% 2 - View the figure update
view_scan_fig(handles.myFit, handles.scan_fig_args);
%% 3 - Ask the user if they want to keep the new filtered data
answer = questdlg('Would you like to store the aligned data?', ...
	'Align data?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
%% Update the handles
guidata(hObject, handles);

% --- Executes when changing the text
function edit_kxScale_Callback(hObject, ~, handles)
% hObject    handle to edit_kxScale (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 4);
%% 2 - Validity check of the ROI input
 % - If no entry is made, default to 3
if isempty(data_entry) ||  length(data_entry) > 2 || size(data_entry, 1) > 1; data_entry = 1;
 % - If a single entry is made, round it down to nearest integer
elseif length(data_entry) == 1 && size(data_entry, 1) ==1; data_entry = data_entry;
 % - Everything else goes to the default value
else; data_entry = 1;
end
handles.kx_scale_args{1}  = data_entry;
set(hObject,'String', string(handles.kx_scale_args{1})); 
fprintf("--> kx scale factor: " + string(handles.kx_scale_args{1}) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_kxScale_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_kxScale (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.kx_scale_args{1} = 1; 
set(hObject,'String', "1");
%% Update handles structure
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STAGE 1 - REALIGN EB  %%%%%%%%%%%%
% --- Executes when changing the text
function edit_ebWin_Callback(hObject, ~, handles)
% hObject    handle to edit_ebWin (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(strrep(get(hObject,'String'),':',' ')), 3);
%% 2 - Validity check, assigning output and printing change
if isempty(data_entry) || size(data_entry, 1) > 1 || length(data_entry) > 2
    handles.eb_align_args{1} = []; 
    set(hObject,'String','Auto');  fprintf("--> ebWin: Auto \n");
elseif length(data_entry) == 1 
    handles.eb_align_args{1} = data_entry;
    set(hObject,'String',handles.eb_align_args{1});  fprintf("--> ebWin: " + string(handles.eb_align_args{1}) + " \n");
elseif length(data_entry) == 2 && (handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)")
    handles.eb_align_args{1} = data_entry;
    set(hObject,'String', string(handles.eb_align_args{1}(1) + ":" + handles.eb_align_args{1}(2))); 
    fprintf("--> ebWin: " + string(handles.eb_align_args{1}(1) + ":" + handles.eb_align_args{1}(2)) + " \n");
else
    handles.eb_align_args{1} = []; 
    set(hObject,'String','Auto');  fprintf("--> ebWin: Auto \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_ebWin_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_ebWin (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.eb_align_args{1} = []; set(hObject,'String', 'Auto');
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_dEWin_Callback(hObject, ~, handles)
% hObject    handle to edit_dEWin (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = abs(round(str2num(get(hObject,'String')), 3));
%% 2- Validity check
if isempty(data_entry) || length(data_entry) > 1 || size(data_entry, 1) > 1
    handles.eb_align_args{2} = []; 
    set(hObject,'String','Auto');  fprintf("--> dEWin: [] \n");
else
    handles.eb_align_args{2} = data_entry; 
    set(hObject,'String',handles.eb_align_args{2});  fprintf("--> dEWin: " + string(handles.eb_align_args{2}) + " \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_dEWin_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_dEWin (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.eb_align_args{2} = []; set(hObject,'String', 'Auto');
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_dESmooth_Callback(hObject, ~, handles)
% hObject    handle to edit_dESmooth (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = abs(round(str2num(get(hObject,'String')), 3));
%% 2- Validity check
if isempty(data_entry) || length(data_entry) > 1 || size(data_entry, 1) > 1
    handles.eb_align_args{3} = []; 
    set(hObject,'String','Auto');  fprintf("--> dESmooth: [] \n");
else
    handles.eb_align_args{3} = data_entry; 
    set(hObject,'String',handles.eb_align_args{3});  fprintf("--> dESmooth: " + string(handles.eb_align_args{3}) + " \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_dESmooth_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_dESmooth (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.eb_align_args{3} = []; set(hObject,'String', 'Auto');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on selection change in popupmenu_feat.
function popupmenu_feat_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_feat (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
contents = cellstr(get(hObject,'String'));
handles.eb_align_args{4} = lower(char(contents{get(hObject,'Value')}));
fprintf("--> feat: " + handles.eb_align_args{4} + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_feat_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_feat (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
contents = cellstr(get(hObject,'String'));
handles.eb_align_args{4} = lower(string(contents{get(hObject,'Value')}));
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExecuteEbAlignment.
function pushbutton_ExecuteEbAlignment_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExecuteEbAlignment (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Performing the re-alignment operation
handles.myFit = align_energy(handles.myFit, handles.eb_align_args);
%% 2 - View the figure update
view_scan_fig(handles.myFit, handles.scan_fig_args);
%% 3 - Ask the user if they want to keep the new filtered data
answer = questdlg('Would you like to store the aligned data?', ...
	'Align data?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
%% Update the handles
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STAGE 1 - FILTER DATA  %%%%%%%%%%%
% --- Executes on selection change in popupmenu_filterType.
function popupmenu_filterType_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_filterType (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
contents = cellstr(get(hObject,'String'));
data_entry = contents{get(hObject,'Value')};
%% 2 - Validity check on input
% For 'Gaco2' smoothing
if data_entry == "Gaco2"
    set(handles.text_filterParam, 'string', 'hwX,hwY:');
    handles.filter_args{2} = [0.5, 0.5];
% For 'GaussFlt2' smoothing
elseif data_entry == "GaussFlt2"
    set(handles.text_filterParam, 'string', 'hwX,hwY:');
    handles.filter_args{2} = [4, 4];
% For 'LaplaceFlt2' smoothing
elseif data_entry == "LaplaceFlt2"
    set(handles.text_filterParam, 'string', 'y2xRatio:');
    handles.filter_args{2} = 0;
% For 'CurvatureFlt2' smoothing
elseif data_entry == "CurvatureFlt2"
    set(handles.text_filterParam, 'string', 'CX,CY:');
    handles.filter_args{2} = [1,1];
end
handles.filter_args{1} = string(contents{get(hObject,'Value')});
%% 3 - Assigning output and printing change
fprintf("--> Filter Type: " + handles.filter_args{1} + " \n");
if handles.filter_args{1} == "LaplaceFlt2"
    set(handles.edit_filterParam,'String', string(handles.filter_args{2})); 
    fprintf("--> "+ get(handles.text_filterParam, 'string')+" "+string(handles.filter_args{2}) + " \n");
else
    set(handles.edit_filterParam,'String', string(handles.filter_args{2}(1) + "," + handles.filter_args{2}(2))); 
    fprintf("--> "+ get(handles.text_filterParam, 'string')+" "+string(handles.filter_args{2}(1) + "," + handles.filter_args{2}(2)) + " \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_filterType_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_filterType (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
contents = cellstr(get(hObject,'String'));
handles.filter_args{1} = string(contents{1});
set(hObject,'Value', 1);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_filterParam_Callback(hObject, ~, handles)
% hObject    handle to edit_filterParam (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(strrep(get(hObject,'String'),',',' ')), 2);
%%  2- Validity check of user input
% For 'Gaco2' smoothing
if handles.filter_args{1} == "Gaco2"
     % - If no entry is made, default to a given value
    if isempty(data_entry) || length(data_entry) > 2
        data_entry = [0.5, 0.5];
    % - If a single entry is made, make a row vector that is identical
    elseif length(data_entry) == 1
        data_entry = [data_entry, data_entry];
    end
% For 'GaussFlt2' smoothing
elseif handles.filter_args{1} == "GaussFlt2"
     % - If no entry is made, default to a given value
    if isempty(data_entry) || length(data_entry) > 2
        data_entry = [4, 4];
    % - If a single entry is made, make a row vector that is identical
    elseif length(data_entry) == 1
        data_entry = [data_entry, data_entry];
        if data_entry(1) < 1; data_entry(1) = 1; end
        if data_entry(2) < 1; data_entry(2) = 1; end
    elseif length(data_entry) == 2
        if data_entry(1) < 1; data_entry(1) = 1; end
        if data_entry(2) < 1; data_entry(2) = 1; end
    end
% For 'LaplaceFlt2' smoothing
elseif handles.filter_args{1} == "LaplaceFlt2"
     % - If no entry is made, default to a given value
    if isempty(data_entry) || length(data_entry) > 1
        data_entry = 0;
    end
% For 'CurvatureFlt2' smoothing
elseif handles.filter_args{1} == "CurvatureFlt2"
    % - If no entry is made, default to a given value
    if isempty(data_entry) || length(data_entry) > 2
        data_entry = [1, 1];
    % - If a single entry is made, make a row vector that is identical
    elseif length(data_entry) == 1
        data_entry = [data_entry, data_entry];
    end
end
%% 3 - Validity check on the mangitude of the data
if handles.filter_args{1} ~= "LaplaceFlt2"; data_entry = abs(data_entry); end
%% 4 - Assigning output and printing change
handles.filter_args{2} = data_entry;
if handles.filter_args{1} == "LaplaceFlt2"
    set(hObject,'String', string(handles.filter_args{2})); 
    fprintf("--> "+ get(handles.text_filterParam, 'string')+" "+string(handles.filter_args{2}) + " \n");
else
    set(hObject,'String', string(handles.filter_args{2}(1) + "," + handles.filter_args{2}(2))); 
    fprintf("--> "+ get(handles.text_filterParam, 'string')+" "+string(handles.filter_args{2}(1) + "," + handles.filter_args{2}(2)) + " \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_filterParam_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_filterParam (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.filter_args{2} = [0.5, 0.5]; 
set(hObject,'String', string(handles.filter_args{2}(1) + "," + handles.filter_args{2}(2))); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExecuteFilter.
function pushbutton_ExecuteFilter_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExecuteFilter (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Performing the filtering operation
handles.myFit = filter_data(handles.myFit, handles.filter_args);
%% 2 - View the figure update
view_scan_fig(handles.myFit, handles.scan_fig_args);
%% 3 - Ask the user if they want to keep the new filtered data
answer = questdlg('Would you like to store the filtered data?', ...
	'Filter data?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
%% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% STAGE 2 - CROPPING ROI & BACKGROUND  %%%%%%%%%%%
% --- Executes when changing the text
function edit_roikRange_Callback(hObject, ~, handles)
% hObject    handle to edit_roikRange (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 2);
%% 2 - Validity check of the ROI input
 % - If no entry is made, default to a small range around the mean
if isempty(data_entry) ||  length(data_entry) > 2 || size(data_entry, 1) > 1
    data_entry = [-0.25, 0.25]+mean(handles.myFit.kx(:));
 % - If a single entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1 && size(data_entry, 1) ==1
    data_entry = data_entry + [-0.25, 0.25];
    if data_entry(1) < min(handles.myFit.kx(:)) || data_entry(1) > max(handles.myFit.kx(:)); data_entry(1) = min(handles.myFit.kx(:)); end
    if data_entry(2) < min(handles.myFit.kx(:)) || data_entry(2) > max(handles.myFit.kx(:)); data_entry(2) = max(handles.myFit.kx(:)); end
 % - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 2
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < min(handles.myFit.kx(:)) || data_entry(1) > max(handles.myFit.kx(:)); data_entry(1) = min(handles.myFit.kx(:)); end
    if data_entry(2) < min(handles.myFit.kx(:)) || data_entry(2) > max(handles.myFit.kx(:)); data_entry(2) = max(handles.myFit.kx(:)); end
end
handles.crop_roi_args{1} = round(sort(data_entry), 2); 
set(hObject,'String', string(handles.crop_roi_args{1}(1) + ":" + handles.crop_roi_args{1}(2))); 
fprintf("--> ROI crop - kRange: " + string(handles.crop_roi_args{1}(1) + ":" + handles.crop_roi_args{1}(2)) + " \n");
%% 3 - Estimating good values for the background
if mean(handles.crop_roi_args{1}) < 0; handles.crop_back_args{1} = round(sort(data_entry), 2) + 0.6; 
else; handles.crop_back_args{1} = round(sort(data_entry), 2) - 0.6;
end
set(handles.edit_backkRange,'String', string(handles.crop_back_args{1}(1) + ":" + handles.crop_back_args{1}(2))); 
handles = edit_backkRange_Callback(handles.edit_backkRange, [], handles);
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_roikRange_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_roikRange (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.crop_roi_args{1} = [-0.25, 0.25]; 
set(hObject,'String', "-0.25:0.25");
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_roiebRange_Callback(hObject, ~, handles)
% hObject    handle to edit_roiebRange (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 2);
%% 2 - Validity check of the ROI input
 % - If no entry is made, default to a given range
if isempty(data_entry) ||  length(data_entry) > 2 || size(data_entry, 1) > 1
    data_entry = [-0.65, 0.25];
 % - If a single entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1 && size(data_entry, 1) ==1
    data_entry = data_entry + [-0.65, 0.25];
    if data_entry(1) < min(handles.myFit.eb(:)) || data_entry(1) > max(handles.myFit.eb(:)); data_entry(1) = min(handles.myFit.eb(:)); end
    if data_entry(2) < min(handles.myFit.eb(:)) || data_entry(2) > max(handles.myFit.eb(:)); data_entry(2) = max(handles.myFit.eb(:)); end
 % - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 2
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < min(handles.myFit.eb(:)) || data_entry(1) > max(handles.myFit.eb(:)); data_entry(1) = min(handles.myFit.eb(:)); end
    if data_entry(2) < min(handles.myFit.eb(:)) || data_entry(2) > max(handles.myFit.eb(:)); data_entry(2) = max(handles.myFit.eb(:)); end
end
handles.crop_roi_args{2} = round(sort(data_entry), 2);
set(hObject,'String', string(handles.crop_roi_args{2}(1) + ":" + handles.crop_roi_args{2}(2))); 
fprintf("--> ROI crop - ebRange: " + string(handles.crop_roi_args{2}(1) + ":" + handles.crop_roi_args{2}(2)) + " \n");
%% 3 - Estimating good values for the background
handles.crop_back_args{2} = handles.crop_roi_args{2};
set(handles.edit_backebRange,'String', string(handles.crop_back_args{2}(1) + ":" + handles.crop_back_args{2}(2))); 
handles = edit_backebRange_Callback(handles.edit_backebRange, [], handles);
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_roiebRange_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_roiebRange (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.crop_roi_args{2} = [-0.65, 0.25]; 
set(hObject,'String', "-0.65:0.25");
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_backkRange_Callback(hObject, ~, handles)
% hObject    handle to edit_backkRange (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 2);
%% 2 - Validity check of the ROI input
 % - If no entry is made, default to a small range around the mean
if isempty(data_entry) ||  length(data_entry) > 2 || size(data_entry, 1) > 1
    data_entry = [-0.25, 0.25]+mean(handles.myFit.kx(:));
 % - If a single entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1 && size(data_entry, 1) ==1
    data_entry = data_entry + [-0.25, 0.25];
    if data_entry(1) < min(handles.myFit.kx(:)) || data_entry(1) > max(handles.myFit.kx(:)); data_entry(1) = min(handles.myFit.kx(:)); end
    if data_entry(2) < min(handles.myFit.kx(:)) || data_entry(2) > max(handles.myFit.kx(:)); data_entry(2) = max(handles.myFit.kx(:)); end
 % - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 2
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < min(handles.myFit.kx(:)) || data_entry(1) > max(handles.myFit.kx(:)); data_entry(1) = min(handles.myFit.kx(:)); end
    if data_entry(2) < min(handles.myFit.kx(:)) || data_entry(2) > max(handles.myFit.kx(:)); data_entry(2) = max(handles.myFit.kx(:)); end
end
handles.crop_back_args{1} = round(sort(data_entry), 2); 
set(hObject,'String', string(handles.crop_back_args{1}(1) + ":" + handles.crop_back_args{1}(2))); 
fprintf("--> Back. crop - kRange: " + string(handles.crop_back_args{1}(1) + ":" + handles.crop_back_args{1}(2)) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_backkRange_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_backkRange (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.crop_back_args{1} = [0.45,0.95]; 
set(hObject,'String', "0.45,0.95");
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_backebRange_Callback(hObject, ~, handles)
% hObject    handle to edit_backebRange (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 2);
%% 2 - Validity check of the ROI input
 % - If no entry is made, default to a given range
if isempty(data_entry) ||  length(data_entry) > 2 || size(data_entry, 1) > 1
    data_entry = [-0.65, 0.25];
% - If a single entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1 && size(data_entry, 1) ==1
    data_entry = data_entry + [-0.65, 0.25];
    if data_entry(1) < min(handles.myFit.eb(:)) || data_entry(1) > max(handles.myFit.eb(:)); data_entry(1) = min(handles.myFit.eb(:)); end
    if data_entry(2) < min(handles.myFit.eb(:)) || data_entry(2) > max(handles.myFit.eb(:)); data_entry(2) = max(handles.myFit.eb(:)); end
 % - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 2
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < min(handles.myFit.eb(:)) || data_entry(1) > max(handles.myFit.eb(:)); data_entry(1) = min(handles.myFit.eb(:)); end
    if data_entry(2) < min(handles.myFit.eb(:)) || data_entry(2) > max(handles.myFit.eb(:)); data_entry(2) = max(handles.myFit.eb(:)); end
end
handles.crop_back_args{2} = round(sort(data_entry), 2);
set(hObject,'String', string(handles.crop_back_args{2}(1) + ":" + handles.crop_back_args{2}(2))); 
fprintf("--> Back. crop - ebRange: " + string(handles.crop_back_args{2}(1) + ":" + handles.crop_back_args{2}(2)) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_backebRange_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_backebRange (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.crop_back_args{2} = [-0.65, 0.25]; 
set(hObject,'String', "-0.65:0.25");
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_roiExtract.
function pushbutton_roiExtract_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_roiExtract (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1.1 - Assigning meta data
handles.myFit.Meta.roi_args = handles.crop_roi_args;
%% 1.2 - Performing the cropping operation over the ROI and background
[handles.myFit.kx_roi, handles.myFit.eb_roi, handles.myFit.scan_roi, handles.myFit.data_roi] =...
    crop_data(handles.myFit.kx, handles.myFit.eb, handles.myFit.scan, handles.myFit.data,...
    handles.crop_roi_args{1}, handles.crop_roi_args{2});
[handles.myFit.Meta.kx_back, handles.myFit.Meta.eb_back,...
    handles.myFit.Meta.scan_back, handles.myFit.Meta.data_back] =...
    crop_data(handles.myFit.kx, handles.myFit.eb, handles.myFit.scan, handles.myFit.data,...
    handles.crop_back_args{1}, handles.crop_back_args{2});
%% 1.3 - Verify the size of the ROI and background are identical
% - First axis consistency
if size(handles.myFit.Meta.kx_back, 1) < size(handles.myFit.kx_roi, 1)
    axis_1 = size(handles.myFit.Meta.kx_back, 1);    
elseif size(handles.myFit.Meta.kx_back, 1) > size(handles.myFit.kx_roi, 1)
    axis_1 = size(handles.myFit.kx_roi, 1); 
else
    axis_1 = size(handles.myFit.kx_roi, 1); 
end
% - Second axis consistency
if size(handles.myFit.Meta.kx_back, 2) < size(handles.myFit.kx_roi, 2)
    axis_2 = size(handles.myFit.Meta.kx_back, 2);    
elseif size(handles.myFit.Meta.kx_back, 2) > size(handles.myFit.kx_roi, 2)
    axis_2 = size(handles.myFit.kx_roi, 2); 
else
    axis_2 = size(handles.myFit.kx_roi, 2); 
end
% - Third axis consistency
if size(handles.myFit.Meta.kx_back, 3) < size(handles.myFit.kx_roi, 3)
    axis_3 = size(handles.myFit.Meta.kx_back, 3);    
elseif size(handles.myFit.Meta.kx_back, 3) > size(handles.myFit.kx_roi, 3)
    axis_3 = size(handles.myFit.kx_roi, 3); 
else
    axis_3 = size(handles.myFit.kx_roi, 3); 
end
% Forcing consistency for Eb(k) data
if handles.myFit.Type == "Eb(k)"
    % Forcing sizes to be consistent for ROI
    handles.myFit.kx_roi = handles.myFit.kx_roi(1:axis_1, 1:axis_2);
    handles.myFit.eb_roi = handles.myFit.eb_roi(1:axis_1, 1:axis_2);
    handles.myFit.scan_roi = handles.myFit.scan_roi();
    handles.myFit.data_roi = handles.myFit.data_roi(1:axis_1, 1:axis_2);
    % Forcing sizes to be consistent for Background
    handles.myFit.Meta.kx_back = handles.myFit.Meta.kx_back(1:axis_1, 1:axis_2);
    handles.myFit.Meta.eb_back = handles.myFit.Meta.eb_back(1:axis_1, 1:axis_2);
    handles.myFit.Meta.scan_back = handles.myFit.Meta.scan_back();
    handles.myFit.Meta.data_back = handles.myFit.Meta.data_back(1:axis_1, 1:axis_2);
% Forcing consistency for Eb(kx,ky) / Eb(kx,kz) data
elseif handles.myFit.Type == "Eb(kx,ky)" || handles.myFit.Type == "Eb(kx,kz)"
    % Forcing sizes to be consistent for ROI
    handles.myFit.kx_roi = handles.myFit.kx_roi(1:axis_1, 1:axis_2, 1:axis_3);
    handles.myFit.eb_roi = handles.myFit.eb_roi(1:axis_1, 1:axis_2, 1:axis_3);
    handles.myFit.scan_roi = squeeze(round(handles.myFit.scan_roi(ceil(0.5*axis_1), ceil(0.5*axis_2),1:axis_3), 4));
    handles.myFit.data_roi = handles.myFit.data_roi(1:axis_1, 1:axis_2, 1:axis_3);
    % Forcing sizes to be consistent for Background
    handles.myFit.Meta.kx_back = handles.myFit.Meta.kx_back(1:axis_1, 1:axis_2, 1:axis_3);
    handles.myFit.Meta.eb_back = handles.myFit.Meta.eb_back(1:axis_1, 1:axis_2, 1:axis_3);
    handles.myFit.Meta.scan_back = squeeze(round(handles.myFit.Meta.scan_back(ceil(0.5*axis_1), ceil(0.5*axis_2),1:axis_3), 4));
    handles.myFit.Meta.data_back = handles.myFit.Meta.data_back(1:axis_1, 1:axis_2, 1:axis_3);
end
%% 2 - View the updated figure
view_scan_fig(handles.myFit, handles.scan_fig_args);
%% 3 - Ask the user if they want to keep the new cropped data
answer = questdlg('Store the cropped ROI and background?', ...
	'Store the ROI and background?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing but update figure again
if isempty(answer) || string(answer) == "No"; return; end
%% 4 - Activate UI elements to progress with fitting
% - Background subtraction UI
set(findall(handles.uipanel_backSub, '-property', 'enable'), 'enable', 'on');
set(handles.pushbutton_ViewBackSub, 'Enable', 'off');
% -- Initialising the EDC scan slider
set(handles.slider_edcSlider,'min', 1, 'max', size(handles.myFit.data_roi, 2), 'Value', floor(0.5*size(handles.myFit.data_roi, 2)), 'SliderStep', [1/(size(handles.myFit.data_roi, 2)-1), 1/(size(handles.myFit.data_roi, 2)-1) ]);
handles = slider_edcSlider_Callback(handles.slider_edcSlider, [], handles, 0);
% -- Initialising the MDC scan slider
set(handles.slider_mdcSlider,'min', 1, 'max', size(handles.myFit.data_roi, 1), 'Value', floor(0.5*size(handles.myFit.data_roi, 1)), 'SliderStep', [1/(size(handles.myFit.data_roi, 1)-1), 1/(size(handles.myFit.data_roi, 1)-1) ]);
handles = slider_mdcSlider_Callback(handles.slider_mdcSlider, [], handles, 0);
% - State fitting UI
set(findall(handles.uipanel_stage3, '-property', 'enable'), 'enable', 'on');
set(handles.pushbutton_ViewFitSummary, 'Enable', 'on');
set(handles.pushbutton_DELETEFIT, 'Enable', 'on');
% -- FDD UI
if isfield(handles.myFit, 'fdd')
    set(handles.pushbutton_ViewFDD, 'Enable', 'on');
    set(handles.checkbox_edcFDD, 'Enable', 'on');
else
    set(handles.pushbutton_ViewFDD, 'Enable', 'off');
    set(handles.checkbox_edcFDD, 'Enable', 'off');
end
% -- Parabola UI
if isfield(handles.myFit, 'para')
    set(handles.uitable_para, 'Enable', 'on');
    set(handles.pushbutton_ExtractPara, 'Enable', 'on');
    set(handles.pushbutton_ViewPara, 'Enable', 'on');
else
    set(handles.uitable_para, 'Enable', 'off');
    set(handles.pushbutton_ExtractPara, 'Enable', 'off');
    set(handles.pushbutton_ViewPara, 'Enable', 'off');
end
if isfield(handles.myFit, 'fdd') && isfield(handles.myFit, 'para')
    % -- EDC fitting UI
    set(handles.uitable_edc, 'Enable', 'on');
    set(handles.checkbox_fitEDCs, 'Enable', 'on');
    % -- MDC fitting UI
    set(handles.uitable_mdc, 'Enable', 'on');
    set(handles.checkbox_fitMDCs, 'Enable', 'on');
    % -- Final fitting UI
    set(handles.pushbutton_ExecuteAlgorithm, 'Enable', 'on');
    set(handles.popupmenu_fitRoutine, 'Enable', 'on');
else
    % -- EDC fitting UI
    set(handles.uitable_edc, 'Enable', 'off');
    set(handles.checkbox_fitEDCs, 'Enable', 'off');
    % -- MDC fitting UI
    set(handles.uitable_mdc, 'Enable', 'off');
    set(handles.checkbox_fitMDCs, 'Enable', 'off');
    % -- Final fitting UI
    set(handles.pushbutton_ExecuteAlgorithm, 'Enable', 'off');
    set(handles.popupmenu_fitRoutine, 'Enable', 'off');
end
%% 5 - Reset / Initialise EDC and MDC fitting structures
if isfield(handles.myFit, 'edc_fits'); handles.myFit = rmfield(handles.myFit, 'edc_fits'); end
if isfield(handles.myFit, 'mdc_fits'); handles.myFit = rmfield(handles.myFit, 'mdc_fits'); end
for i = 1:size(handles.myFit.data_roi, 3)
    handles.myFit.edc_fits{i} = [];
    handles.myFit.mdc_fits{i} = [];
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_roiView.
function pushbutton_roiView_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_roiView (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% View the ROI and background areas that were cropped
view_crop_roi(handles.myFit, handles.scan_fig_args, handles.crop_roi_args, handles.crop_back_args)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% STAGE 2 - BACKGROUND SUBTRACTION  %%%%%%%%%%%%%
% --- Executes when changing the text
function edit_polyOrder_Callback(hObject, ~, handles)
% hObject    handle to edit_polyorder (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = floor(sort(str2num(strrep(get(hObject,'String'),':',' '))));
%% 2 - Validity check of the ROI input
 % - If no entry is made, default to 3
if isempty(data_entry) ||  length(data_entry) > 2 || size(data_entry, 1) > 1; data_entry = 3;
 % - If a single entry is made, round it down to nearest integer
elseif length(data_entry) == 1 && size(data_entry, 1) ==1; data_entry = data_entry;
 % - Everything else goes to the default value
else; data_entry = 3;
end
handles.backsub_args{1} = data_entry;
set(hObject,'String', string(handles.backsub_args{1})); 
fprintf("--> Back. crop - polynomial order: " + string(handles.backsub_args{1}) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_polyOrder_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_polyorder (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.backsub_args{1} = 3; 
set(hObject,'String', "3");
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExecuteBackSub.
function pushbutton_ExecuteBackSub_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExecuteBackSub (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Performing the background subtraction
handles.myFit = background_subtraction(handles.myFit, handles.backsub_args);
%% 2 - View the background subtraction
view_background_subtraction(handles.myFit, handles.scan_fig_args);
%% 3 - Ask the user if they want to keep the new cropped data
answer = questdlg('Store the background subtracted data?', ...
	'Store the background subtraction?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing but update figure again
if isempty(answer) || string(answer) == "No"; return; end
%% 4 - Activate UI elements to progress with fitting
set(handles.pushbutton_ViewBackSub, 'Enable', 'on');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ViewBackSub.
function pushbutton_ViewBackSub_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ViewBackSub (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% View the background subtraction
view_background_subtraction(handles.myFit, handles.scan_fig_args);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% STAGE 3 - FERMI-DIRAC DISTRIBUTION  %%%%%%%%%%%%%
% --- Executes during object creation, after setting all properties.
function uitable_fdd_CreateFcn(hObject, ~, handles)
% hObject    handle to uitable_fdd (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Clearing the table and creating custom data cell size
hObject.Data = {};
hObject.Data = cell(1, 3);
%% Defining the initial data inputs for the table
hObject.Data{1,1} = 12.00000;
hObject.Data{1,2} = 0.00000;
hObject.Data{1,3} = 40.00000;
%% Update handles structure
guidata(hObject, handles);

% --- Executes when entered data in editable cell(s) in uitable_fdd.
function uitable_fdd_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_fdd (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

%% 1.1 - Validity check of column input index 1
if eventdata.Indices(2) == 1
    data_entry = abs(round(str2double(eventdata.EditData), 5));
    if isnan(data_entry); data_entry = 12; end
%% 1.2 - Validity check of column input index 2
elseif eventdata.Indices(2) == 2
    data_entry = round(str2double(eventdata.EditData), 5);
    if isnan(data_entry); data_entry = 0; end
%% 1.3 - Validity check of column input index 3
elseif eventdata.Indices(2) == 3
    data_entry = abs(round(str2double(eventdata.EditData), 5));
    if isnan(data_entry); data_entry = 40; end
end
%% 2 - Print update text
col_names = get(hObject, 'ColumnName');
fprintf("uitable_fdd.Data{" + string(eventdata.Indices(1)) + "," + string(eventdata.Indices(2)) + "}\n");
fprintf("--> " + string(col_names{eventdata.Indices(2)}) + " = " + string(data_entry) + " \n\n");
%% 3 - Assigning the data entry to the uitable
hObject.Data{eventdata.Indices(1), eventdata.Indices(2)} = data_entry;
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ViewFDD.
function pushbutton_ViewFDD_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ViewFDD (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% View the Fermi-Dirac distribution
view_fdd(handles.myFit);

% --- Executes on button press in pushbutton_ExtractFDD.
function pushbutton_ExtractFDD_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExtractFDD (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the FDD
handles.myFit = extract_fdd(handles.myFit, handles.uitable_fdd.Data);
%% 2 - View the FDD
view_fdd(handles.myFit);
%% 3 - Activate UI elements to progress with fitting
% -- FDD UI
set(handles.checkbox_edcFDD, 'Enable', 'on');
set(handles.pushbutton_ViewFDD, 'Enable', 'on');
% -- Parabola UI
set(handles.uitable_para, 'Enable', 'on');
set(handles.pushbutton_ExtractPara, 'Enable', 'on');
%% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% STAGE 3 - PARABOLIC TRAIL %%%%%%%%%%%%%%
% --- Executes during object creation, after setting all properties.
function uitable_para_CreateFcn(hObject, ~, handles)
% hObject    handle to uitable_para (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Clearing the table and creating custom data cell size
hObject.Data = {};
hObject.Data = cell(4, 5);
%% Defining the initial data inputs for the table
% - First row
hObject.Data{1,1} = 0.00000;
hObject.Data{1,2} = 0.01000;
hObject.Data{1,3} = -0.120000;
hObject.Data{1,4} = 0.01000;
hObject.Data{1,5} = 0.18000;
% - All other rows default to being empty
for i = 2:4; for j = 1:5; hObject.Data{i,j} = []; end; end
%% Update handles structure
guidata(hObject, handles);

% --- Executes when entered data in editable cell(s) in uitable_para.
function uitable_para_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_para (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

%% 1.1 - Validity check of input column index 1
if eventdata.Indices(2) == 1
    if isempty(eventdata.EditData) && eventdata.Indices(1) > 1; data_entry = [];
    else; data_entry = round(str2double(eventdata.EditData), 5);
        if isnan(data_entry); data_entry = 0.00000; end
    end
%% 1.2 - Validity check of input column index 2
elseif eventdata.Indices(2) == 2
    if isempty(eventdata.EditData) && eventdata.Indices(1) > 1; data_entry = [];
    else; data_entry = abs(round(str2double(eventdata.EditData), 5));
        if isnan(data_entry); data_entry = 0.01000; end
    end
%% 1.3 - Validity check of input column index 3
elseif eventdata.Indices(2) == 3
    if isempty(eventdata.EditData) && eventdata.Indices(1) > 1; data_entry = [];
    else; data_entry = round(str2double(eventdata.EditData), 5);
        if isnan(data_entry); data_entry = -0.12000; end
    end
%% 1.4 - Validity check of input column index 4
elseif eventdata.Indices(2) == 4
    if isempty(eventdata.EditData) && eventdata.Indices(1) > 1; data_entry = [];
    else; data_entry = abs(round(str2double(eventdata.EditData), 5));
        if isnan(data_entry); data_entry = 0.01000; end
    end
%% 1.5 - Validity check of input column index 5
elseif eventdata.Indices(2) == 5
    if isempty(eventdata.EditData) && eventdata.Indices(1) > 1; data_entry = [];
    else; data_entry = round(str2double(eventdata.EditData), 5);
        if isnan(data_entry); data_entry = 0.18000; end
    end
end
%% 2 - Print update text
col_names = get(hObject, 'ColumnName');
fprintf("uitable_para.Data{" + string(eventdata.Indices(1)) + "," + string(eventdata.Indices(2)) + "}\n");
if isempty(data_entry); fprintf("--> " + string(col_names{eventdata.Indices(2)}) + " = [] \n\n");
else; fprintf("--> " + string(col_names{eventdata.Indices(2)}) + " = " + string(data_entry) + " \n\n");
end
%% 3 - Assigning the data entry to the uitable
hObject.Data{eventdata.Indices(1), eventdata.Indices(2)} = data_entry;
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ViewPara.
function pushbutton_ViewPara_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ViewPara (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% View the parabolic approximation
view_para(handles.myFit, handles.scan_fig_args);

% --- Executes on button press in pushbutton_ExtractPara.
function pushbutton_ExtractPara_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExtractPara (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the parabolic dispersions
handles.myFit = extract_parabola(handles.myFit, handles.uitable_para.Data);
%% 2 - View the parabolic dispersions
view_para(handles.myFit, handles.scan_fig_args);
%% 3 - Activate UI elements to progress with fitting
% -- Parabola UI
set(handles.pushbutton_ViewPara, 'Enable', 'on');
% -- EDC fitting UI
set(handles.uitable_edc, 'Enable', 'on');
set(handles.checkbox_fitEDCs, 'Enable', 'on');
% -- MDC fitting UI
set(handles.uitable_mdc, 'Enable', 'on');
set(handles.checkbox_fitMDCs, 'Enable', 'on');
% -- Final fitting UI
set(handles.pushbutton_ExecuteAlgorithm, 'Enable', 'on');
set(handles.popupmenu_fitRoutine, 'Enable', 'on');
%% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% STAGE 3 - EDC FITTING CONSTRAINTS  %%%%%%%%%%%%
% --- Executes during object creation, after setting all properties.
function uitable_edc_CreateFcn(hObject, ~, handles)
% hObject    handle to uitable_edc (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Clearing the table and creating custom data cell size
hObject.Data = {};
hObject.Data = cell(4, 5);
%% Defining the initial data inputs for the table
% - First row
hObject.Data{1,1} = '-0.1:0.1';
hObject.Data{1,2} = 'gaussian';
hObject.Data{1,3} = '0.0:1.0';
hObject.Data{1,4} = '0.0:0.2';
hObject.Data{1,5} = true;
hObject.Data{1,6} = '0.0:0.02';
% - All other rows default to being empty
for i = 2:4
    for j = 1:6
        if j == 5; hObject.Data{i,j} = false; 
        else; hObject.Data{i,j} = []; 
        end
    end
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes when entered data in editable cell(s) in uitable_edc.
function uitable_edc_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_edc (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

%% 1.1 - Validity check of input column index 1 (k-range)
if eventdata.Indices(2) == 1
    % - Extracting the input defined by user
    data_entry = sort(round(str2num(strrep(eventdata.EditData, ':', ' ')), 5)); 
    % - Validity check of the input
     % - If no entry is made, default to empty
    if isempty(data_entry) ||  length(data_entry) > 2 || size(data_entry, 1) > 1
        data_entry = [];
     % - If a single entry is made, ensure it does not exceed the max / min limits
    elseif length(data_entry) == 1 && size(data_entry, 1) ==1
        data_entry = data_entry + [-0.05, 0.05];
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < min(handles.myFit.kx_roi(:)) || data_entry(1) > max(handles.myFit.kx_roi(:)); data_entry(1) = min(handles.myFit.kx_roi(:)); end
        if data_entry(2) < min(handles.myFit.kx_roi(:)) || data_entry(2) > max(handles.myFit.kx_roi(:)); data_entry(2) = max(handles.myFit.kx_roi(:)); end
     % - If a double entry is made, ensure it does not exceed the max / min limits
    elseif length(data_entry) == 2
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < min(handles.myFit.kx_roi(:)) || data_entry(1) > max(handles.myFit.kx_roi(:)); data_entry(1) = min(handles.myFit.kx_roi(:)); end
        if data_entry(2) < min(handles.myFit.kx_roi(:)) || data_entry(2) > max(handles.myFit.kx_roi(:)); data_entry(2) = max(handles.myFit.kx_roi(:)); end
    end
    data_entry = round(data_entry, 4);
    % - Printing the data entry
    col_names = get(hObject, 'ColumnName');
    fprintf("uitable_para.Data{" + string(eventdata.Indices(1)) + "," + string(eventdata.Indices(2)) + "}\n");
    if isempty(data_entry)
        data_char = [];
        fprintf("--> " + string(col_names{eventdata.Indices(2)}) + " = [] \n\n");
    else
        data_char = char(string(data_entry(1)) + ":" + data_entry(2)); 
        fprintf("--> " + string(col_names{eventdata.Indices(2)}) + " = " + string(data_entry(1)) + ":" + string(data_entry(2)) + " \n\n");
    end
    % - Assigning the data entry to the uitable
    hObject.Data{eventdata.Indices(1), eventdata.Indices(2)} = data_char;
    
%% 1.2 - Validity check of input column index 2 & 5 (curve & checkbox)
elseif eventdata.Indices(2) == 2 || eventdata.Indices(2) == 5
     % - Printing the data entry
    col_names = get(hObject, 'ColumnName');
    fprintf("uitable_para.Data{" + string(eventdata.Indices(1)) + "," + string(eventdata.Indices(2)) + "}\n");
    fprintf("--> " + string(col_names{eventdata.Indices(2)}) + " = " + string(eventdata.EditData) + " \n\n");
    % - Assigning the data entry to the uitable
    hObject.Data{eventdata.Indices(1), eventdata.Indices(2)} = eventdata.EditData;
    
%% 1.3 - Validity check of input column index 3 & 4 (peak, fwhm & shift)
elseif eventdata.Indices(2) == 3 || eventdata.Indices(2) == 4 || eventdata.Indices(2) == 6
    % - Extracting the input defined by user
    data_entry = sort(round(str2num(strrep(eventdata.EditData, ':', ' ')), 5)); 
    % - Validity check of the input
     % - If no entry is made, default to empty
    if isempty(data_entry) ||  length(data_entry) > 2 || size(data_entry, 1) > 1
        data_entry = [];
     % - If a single entry is made, ensure it does not exceed the max / min limits
    elseif length(data_entry) == 1 && size(data_entry, 1) ==1
        data_entry = data_entry + [-0.05, 0.05];
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < 0 || data_entry(1) > 5; data_entry(1) = 0; end
        if data_entry(2) < 0 || data_entry(2) > 5; data_entry(2) = 5; end
     % - If a double entry is made, ensure it does not exceed the max / min limits
    elseif length(data_entry) == 2
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < 0 || data_entry(1) > 5; data_entry(1) = 0; end
        if data_entry(2) < 0 || data_entry(2) > 5; data_entry(2) = 5; end
    end
    data_entry = round(data_entry, 4);
    % - Printing the data entry
    col_names = get(hObject, 'ColumnName');
    fprintf("uitable_para.Data{" + string(eventdata.Indices(1)) + "," + string(eventdata.Indices(2)) + "}\n");
    if isempty(data_entry)
        data_char = [];
        fprintf("--> " + string(col_names{eventdata.Indices(2)}) + " = [] \n\n");
    else
        data_char = char(string(data_entry(1)) + ":" + data_entry(2)); 
        fprintf("--> " + string(col_names{eventdata.Indices(2)}) + " = " + string(data_entry(1)) + ":" + string(data_entry(2)) + " \n\n");
    end
    % - Assigning the data entry to the uitable
    hObject.Data{eventdata.Indices(1), eventdata.Indices(2)} = data_char;
end

%% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% STAGE 3 - MDC FITTING  CONSTRAINTS %%%%%%%%%%%
% --- Executes during object creation, after setting all properties.
function uitable_mdc_CreateFcn(hObject, ~, handles)
% hObject    handle to uitable_mdc (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Clearing the table and creating custom data cell size
hObject.Data = {};
hObject.Data = cell(4, 5);
%% Defining the initial data inputs for the table
% - First row
hObject.Data{1,1} = '-0.15:0.05';
hObject.Data{1,2} = 'gaussian';
hObject.Data{1,3} = '0.0:1.0';
hObject.Data{1,4} = '0.0:0.2';
hObject.Data{1,5} = true;
hObject.Data{1,6} = '0.0:0.02';

% - All other rows default to being empty
for i = 2:4
    for j = 1:6
        if j == 5; hObject.Data{i,j} = false; 
        else; hObject.Data{i,j} = []; 
        end
    end
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes when entered data in editable cell(s) in uitable_mdc.
function uitable_mdc_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_mdc (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

%% 1.1 - Validity check of input column index 1 (eb-range)
if eventdata.Indices(2) == 1
    % - Extracting the input defined by user
    data_entry = sort(round(str2num(strrep(eventdata.EditData, ':', ' ')), 5)); 
    % - Validity check of the input
     % - If no entry is made, default to a small range around the mean
    if isempty(data_entry) ||  length(data_entry) > 2 || size(data_entry, 1) > 1
        data_entry = [];
     % - If a single entry is made, ensure it does not exceed the max / min limits
    elseif length(data_entry) == 1 && size(data_entry, 1) ==1
        data_entry = data_entry + [-0.1, 0.1];
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < min(handles.myFit.eb_roi(:)) || data_entry(1) > max(handles.myFit.eb_roi(:)); data_entry(1) = min(handles.myFit.eb_roi(:)); end
        if data_entry(2) < min(handles.myFit.eb_roi(:)) || data_entry(2) > max(handles.myFit.eb_roi(:)); data_entry(2) = max(handles.myFit.eb_roi(:)); end
     % - If a double entry is made, ensure it does not exceed the max / min limits
    elseif length(data_entry) == 2
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < min(handles.myFit.eb_roi(:)) || data_entry(1) > max(handles.myFit.eb_roi(:)); data_entry(1) = min(handles.myFit.eb_roi(:)); end
        if data_entry(2) < min(handles.myFit.eb_roi(:)) || data_entry(2) > max(handles.myFit.eb_roi(:)); data_entry(2) = max(handles.myFit.eb_roi(:)); end
    end
    data_entry = round(data_entry, 4);
    % - Printing the data entry
    col_names = get(hObject, 'ColumnName');
    fprintf("uitable_para.Data{" + string(eventdata.Indices(1)) + "," + string(eventdata.Indices(2)) + "}\n");
    if isempty(data_entry)
        data_char = [];
        fprintf("--> " + string(col_names{eventdata.Indices(2)}) + " = [] \n\n");
    else
        data_char = char(string(data_entry(1)) + ":" + data_entry(2)); 
        fprintf("--> " + string(col_names{eventdata.Indices(2)}) + " = " + string(data_entry(1)) + ":" + string(data_entry(2)) + " \n\n");
    end
    % - Assigning the data entry to the uitable
    hObject.Data{eventdata.Indices(1), eventdata.Indices(2)} = data_char;
    
%% 1.2 - Validity check of input column index 2 & 5 (curve & checkbox)
elseif eventdata.Indices(2) == 2 || eventdata.Indices(2) == 5
     % - Printing the data entry
    col_names = get(hObject, 'ColumnName');
    fprintf("uitable_para.Data{" + string(eventdata.Indices(1)) + "," + string(eventdata.Indices(2)) + "}\n");
    fprintf("--> " + string(col_names{eventdata.Indices(2)}) + " = " + string(eventdata.EditData) + " \n\n");
    % - Assigning the data entry to the uitable
    hObject.Data{eventdata.Indices(1), eventdata.Indices(2)} = eventdata.EditData;
    
%% 1.3 - Validity check of input column index 3 & 4 (peak, fwhm & shift)
elseif eventdata.Indices(2) == 3 || eventdata.Indices(2) == 4 || eventdata.Indices(2) == 6
    % - Extracting the input defined by user
    data_entry = sort(round(str2num(strrep(eventdata.EditData, ':', ' ')), 5)); 
    % - Validity check of the input
     % - If no entry is made, default to empty
    if isempty(data_entry) ||  length(data_entry) > 2 || size(data_entry, 1) > 1
        data_entry = [];
     % - If a single entry is made, ensure it does not exceed the max / min limits
    elseif length(data_entry) == 1 && size(data_entry, 1) ==1
        data_entry = data_entry + [-0.05, 0.05];
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < 0 || data_entry(1) > 5; data_entry(1) = 0; end
        if data_entry(2) < 0 || data_entry(2) > 5; data_entry(2) = 5; end
     % - If a double entry is made, ensure it does not exceed the max / min limits
    elseif length(data_entry) == 2
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < 0 || data_entry(1) > 5; data_entry(1) = 0; end
        if data_entry(2) < 0 || data_entry(2) > 5; data_entry(2) = 5; end
    end
    data_entry = round(data_entry, 4);
    % - Printing the data entry
    col_names = get(hObject, 'ColumnName');
    fprintf("uitable_para.Data{" + string(eventdata.Indices(1)) + "," + string(eventdata.Indices(2)) + "}\n");
    if isempty(data_entry)
        data_char = [];
        fprintf("--> " + string(col_names{eventdata.Indices(2)}) + " = [] \n\n");
    else
        data_char = char(string(data_entry(1)) + ":" + data_entry(2)); 
        fprintf("--> " + string(col_names{eventdata.Indices(2)}) + " = " + string(data_entry(1)) + ":" + string(data_entry(2)) + " \n\n");
    end
    % - Assigning the data entry to the uitable
    hObject.Data{eventdata.Indices(1), eventdata.Indices(2)} = data_char;
end

%% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STAGE 3 - FIT ALGORITHM  %%%%%%%%%%%%
% --- Executes on button press in checkbox_fitEDCs.
function checkbox_fitEDCs_Callback(hObject, ~, handles)
% hObject    handle to checkbox_fitEDCs (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the state of the checkbox
val = get(hObject,'Value');
handles.fit_args{1}  = val;
if val == 1;  fprintf("--> EDC fitting: True \n");
else; fprintf("--> EDC fitting: False \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function checkbox_fitEDCs_CreateFcn(hObject, ~, handles)
% hObject    handle to checkbox_fitEDCs (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% 1 - Set default parameters
set(hObject,'Value',0);
handles.fit_args{1} = get(hObject,'Value');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox_fitMDCs.
function checkbox_fitMDCs_Callback(hObject, ~, handles)
% hObject    handle to checkbox_fitMDCs (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the state of the checkbox
val = get(hObject,'Value');
handles.fit_args{2}  = val;
if val == 1;  fprintf("--> MDC fitting: True \n");
else; fprintf("--> MDC fitting: False \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function checkbox_fitMDCs_CreateFcn(hObject, ~, handles)
% hObject    handle to checkbox_fitMDCs (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% 1 - Set default parameters
set(hObject,'Value',0);
handles.fit_args{2} = get(hObject,'Value');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on selection change in popupmenu_fitroutine.
function popupmenu_fitRoutine_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_fitroutine (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the choice of data smoothing
contents = cellstr(get(hObject,'String'));
handles.fit_args{3} = string(contents{get(hObject,'Value')});
%% 2 - Printing the change that has occured
fprintf("--> Fitting routine: " + handles.fit_args{3} + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_fitRoutine_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_fitroutine (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
contents = cellstr(get(hObject,'String'));
handles.fit_args{3} = string(contents{1});
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_voigtMix_Callback(hObject, ~, handles)
% hObject    handle to edit_voigtMix (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = abs(round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 4));
%% 2 - Validity check of the ROI input
 % - If no entry is made, default to 3
if isempty(data_entry) ||  length(data_entry) > 2 || size(data_entry, 1) > 1; data_entry = 0.5;
 % - If a single entry is made, round it down to nearest integer
elseif length(data_entry) == 1 && size(data_entry, 1) ==1
    if data_entry > 1; data_entry = 1; end
 % - Everything else goes to the default value
else; data_entry = 0.5;
end
handles.fit_args{4}  = data_entry;
set(hObject,'String', string(handles.fit_args{4})); 
fprintf("-->voigt mixing (G/L): " + string(handles.fit_args{4}) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_voigtMix_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_voigtMix (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.fit_args{4} = 0.5; 
set(hObject,'String', "0.5");
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExecuteAlgorithm.
function pushbutton_ExecuteAlgorithm_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExecuteAlgorithm (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Executing the fitting algorithm
handles.myFit = fit_algorithm(handles.myFit,...
    handles.fit_args, handles.scan_fig_args, handles.uitable_edc.Data, handles.uitable_mdc.Data);
%% 2 - Activate UI elements to progress with fitting
if handles.fit_args{1} == 1
    set(handles.checkbox_edcFits, 'Enable', 'on');
    set(handles.pushbutton_edcTable, 'Enable', 'on');
    view_edc_fig(handles.myFit, handles.scan_fig_args, handles.edc_fig_args, handles.mdc_fig_args);
end
if handles.fit_args{2} == 1
    set(handles.checkbox_mdcFits, 'Enable', 'on'); 
    set(handles.pushbutton_mdcTable, 'Enable', 'on');
    view_mdc_fig(handles.myFit, handles.scan_fig_args, handles.edc_fig_args, handles.mdc_fig_args);
end
%% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INTERNAL PROCESSING FUNCTIONS %%%%%%
% ---  Function to load in the data
function [dataStr, fitStr] = load_arpes_data(FileName, type)
% [dataStr, fitStr] = load_arpes_data(FileName)
%   This function loads in already processed data in the form 
%   of a *.mat file that has been parsed through the 'arpes_processor'
%   UI. The data is then extracted as a data object.
%
%   REQ. FUNCTIONS: none
%
%   IN:
%   -   FileName:               string of the *.mat file-name to be loaded.
%   -   type:                        logical, where 1 means it will ignore all previous fits.
%
%   OUT:
%   dataStr - MATLAB data structure containing all data below.
%   -   .(H5file):                 string of the raw .H5 filename of the data.
%	-   .(Type):                   string "Eb(k)", "Eb(kx,ky)" or "Eb(kx,kz)".
%	-   .(meta.info):            [1xN] char array of scan information.
%	-   .(meta.ep):              scalar of the Pass energy.
%	-   .(raw_tht):               [1×nAngle] row vector of angles.
% 	-   .(raw_eb):                [nEnergyx1] column vector of energy.
%	-   .(deb):                      scalar of the Analyser resolution.
%   -   .(tltM):                     scalar or [1×nScan] row vector (if Scan parameter for 3Data data).
%	-   .(hv):                       scalar or [1×nScan] row vector (if Scan parameter for 3Data data).
%	-   .(dhv):                     scalar of the Beamline resolution.
%	-   .(raw_data):            2Data [nEnergy x nAngle] or 3Data [nEnergy x nAngle xnScan] data array.
%	-   .(thtM):                    scalar of the manipular Theta angle.
%	-   .(Temp):                  scalar of the sample temperature.
% -- after processing Eb alignment
%	-   .(tht):                       aligned 2D or 3D array of theta.
%	-   .(eb):                        aligned 2D or 3D array of energy.
% -- after processing intensity normalisation
%	-   .(data):                     2D or 3D array of the normalised data.
%   -   .(surfNormX):    double or vector of surface normal vector.
% -- after processing k conversions
%   -   .(kx):                        2D or 3D array of kx from the Theta angle.
%	-   .(ky):                        1D, 2D or 3D array of kx from the Tilt angle.
%	-   .(kz):                        1D, 2D or 3D array of kx from the Photon Energy.
% -- after analysing kf
%	-   .(kf):                        MATLAB data structure containing all kf analysis.
% -- after analysing isoe
%	-   .(isoe):                    MATLAB data structure containing all isoe analysis.
%	-   .(bz):                       MATLAB data structure containing all Brilluoin Zone analysis.
% -- after executing state-fitting
%	-   .(fits):                     MATLAB data structure containing all fitting analysis.
%
%   fitStr - MATLAB data structure containing all data fits as below.
%	-   .(matfile):                     string of the *.mat file-name of the ARPES data.
%	-   .(Type):                        string "Eb(k) fit".
%	-   .(k):                              2D or 3D array of the k-domain of the ARPES data.
%	-   .(eb):                            2D or 3D array of the eb-domain of the ARPES data.
%	-   .(hv)/.(ky)/.(kz):          1D, 2D or 3D array of the scan parameter.
%	-   .(data):                         2D or 3D array of the intensity of ARPES data.
% -- after extracting the region of interest to be fitted.
%	-   .(kx_roi):                       column vector of the k-domain over the ROI of the ARPES data.
%	-   .(eb_roi):                     row vector of the eb-domain over the ROI of the ARPES data.
%	-   .(z_roi):                       1D, 2D or 3D array of the scan parameter.
%	-   .(data_roi):                  2D array of the intensity over the ROI of ARPES data.
%	-   .(k_back):                    column vector of the k-domain over the backgroundof the ARPES data.
%	-   .(eb_back):                  row vector of the eb-domain over the background of the ARPES data.
%	-   .(data_back):               2D array of the intensity over the background of ARPES data.
% -- after defining the fermi-dirac distribution
%	-   .(fdd):                           MATLAB data structure containing all fdd analysis.
% -- after defining the parabolic dispersion trail
%   -   .(parabola):                  MATLAB data structure containing all parabolic analysis.
% -- after performing fits to the edc's
%	-   .(edc_fits):                     MATLAB data structure containing all edc fit analysis.
% -- after performing fits to the mdc's
%	-   .(mdc_fits):                    MATLAB data structure containing all mdc fit analysis.
     
disp('Loading processed ARPES data...')
wbar = waitbar(0.5, 'Loading *.mat data...', 'Name', 'load_arpes_data');

%% Default parameters
if nargin < 2; type = 0; end
if isempty(type); type = 0;  end

%% 1 - Reading in the .mat data that has been processed
arpes_data = load(FileName); dataStr = arpes_data.dataStruc;
%% 2 - If previous fitting has been performed, identify this
if ~isfield(dataStr, 'fits') || type == 1
    %% 3.1 - If previous processing has been performed, identify this
    [xField_proc, yField_proc, zField_proc, dField_proc] = find_data_fields(dataStr);
    %% 3.2 - Adding elements to the fit data-structure
    fitStr = [];
    fitStr.matfile = FileName;
    fitStr.Type = dataStr.Type;
    fitStr.Meta = struct();
    fitStr.kx = dataStr.(xField_proc);
    fitStr.eb = dataStr.(yField_proc);
    fitStr.scan = dataStr.(zField_proc);
    fitStr.data = dataStr.(dField_proc);
else
    %% 4.1 - Loading in the previous fitting
    fitStr = dataStr.fits;
end

%% Close wait-bar
close(wbar);

% --- General function to find the stage of the data processing
function [xField, yField, zField, dField] = find_data_fields(dataStr)
% [xField, yField, zField, dField] = find_data_fields(dataStr)
%   This function determines the most recent processed 
%   fields of the ARPES data-structure so that the correct
%   post-processing can be performed in any order. The
%   fields can be used to explicitly call a field within dataStr
%   by using dataStr.(xField) for example.
%
%   REQ. FUNCTIONS: none
%
%   IN:
%   -   dataStr              loaded MATLAB data structure.
%
%   OUT:
%   -   xField:            char of the most recent x-field ('raw_tht', 'tht', 'kx')
%	-   yField:            char of the most recent y-field ('raw_eb', 'eb')
%   -   zField:            char of the most recent z-field ('hv / tltM', 'kz / ky')
%	-   dField:            char of the most recent d-field ('raw_data', 'data')

% 1 - EbAlign->Normalise->kConvert fields
if isfield(dataStr, 'kx')
    xField = 'kx'; yField = 'eb'; dField = 'data';
    if dataStr.Type == "Eb(k)"; zField = 'hv';
    elseif dataStr.Type == "Eb(kx,ky)"; zField = 'ky';
    elseif dataStr.Type == "Eb(kx,kz)"; zField = 'kz';
    end
% 2 - EbAlign->Normalise fields
elseif isfield(dataStr, 'data')
    xField = 'tht'; yField = 'eb'; dField = 'data';
    if dataStr.Type == "Eb(k)"; zField = 'hv';
    elseif dataStr.Type == "Eb(kx,ky)"; zField = 'tltM';
    elseif dataStr.Type == "Eb(kx,kz)"; zField = 'hv';
    end
% 3 - EbAlign fields
elseif isfield(dataStr, 'eb')
    xField = 'tht'; yField = 'eb'; dField = 'raw_data';
    if dataStr.Type == "Eb(k)"; zField = 'hv';
    elseif dataStr.Type == "Eb(kx,ky)"; zField = 'tltM';
    elseif dataStr.Type == "Eb(kx,kz)"; zField = 'hv';
    end
% 4 - Raw, unprocessed data fields
else
    xField = 'raw_tht'; yField = 'raw_eb'; dField = 'raw_data';
    if dataStr.Type == "Eb(k)"; zField = 'hv';
    elseif dataStr.Type == "Eb(kx,ky)"; zField = 'tltM';
    elseif dataStr.Type == "Eb(kx,kz)"; zField = 'hv';
    end
end

% --- General function to find the stage of the data fitting
function [xField, yField, zField, dField] = find_roi_fields(fitStr)
% [xField, yField, zField, dField] = find_roi_fields(dataStr)
%   This function determines the most recent fitting 
%   fields of the ARPES data-structure so that the correct
%   post-processing can be performed in any order. The
%   fields can be used to explicitly call a field within dataStr
%   by using dataStr.(xField) for example.
%
%   REQ. FUNCTIONS: none
%
%   IN:
%   -   dataStr              loaded MATLAB data structure.
%
%   OUT:
%   -   xField:            char of the most recent x-field ('k', 'kx_roi')
%	-   yField:            char of the most recent y-field ('eb', 'eb_roi')
%   -   zField:            char of the most recent z-field ('hv / kz / ky', 'hv / kz_roi / ky_roi')
%	-   dField:            char of the most recent d-field ('data', 'data_roi')

% 1 - If ROI has been determined
if isfield(fitStr, 'kx_roi'); xField = 'kx_roi'; yField = 'eb_roi'; zField = 'scan_roi'; dField = 'data_roi';
% 2 - If no ROI has yet been defined
else; xField = 'kx'; yField = 'eb'; zField = 'scan'; dField = 'data';
end

% --- Function to filter the ARPES data
function fitStr = filter_data(fitStr, filter_args)
% dataStr = filter_data(dataStr, filter_args)
%   This function filters the ARPES data given the filter arguments, which
%   includes the filter type ("Gaco2", "GaussFlt2", "CurvatureFlt2" or
%   "LaplaceFlt2") and filter parameters.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   AA = Gaco2(A,hwX,hwY [,hsX] [,hsY])
%   -   AA = GaussFlt2(Img,hwX,hwY,hsX,hsY)
%   -   AA = CurvatureFlt2(Img [,order] [,CX] [,CY]) 
%   -   AA = LaplaceFlt2(Img [,y2xRatio] [,order])
%
%   IN:
%   -   dataStr                      loaded MATLAB data structure.
% 	-   filter_args:                1x2 cell of {filter_type, filter_val}.
%
%   OUT:
%   -   dataStr                       modified and filtered ARPES data structure.

disp('Data filtering...')
wbar = waitbar(0, 'Executing data filtering...', 'Name', 'filter_data');

%% 1 - Initialising the filter parameters
fitStr.Meta.filter_args = filter_args;
% - Extracting filter parameters
filter_type = filter_args{1};
filter_val =  filter_args{2};
%% 2 - Performing the filtering operation over all scans
for i = 1:size(fitStr.data, 3)
    waitbar(i/size(fitStr.data, 3), wbar, 'Filtering ARPES data...', 'Name', 'filter_data');
    if filter_type == "Gaco2"
        filtered_data = Gaco2(fitStr.data(:,:,i), filter_val(1), filter_val(2)); 
    elseif filter_type == "GaussFlt2"
        filtered_data = GaussFlt2(fitStr.data(:,:,i), filter_val(1), filter_val(2), 40, 40); 
    elseif filter_type == "LaplaceFlt2"
        filtered_data = GaussFlt2(fitStr.data(:,:,i), 5, 5, 40, 40);
        filtered_data = SetContrast(filtered_data, 0.4, 0.999, 1.5);
        filtered_data = LaplaceFlt2(filtered_data, filter_val(1));
    elseif filter_type == "CurvatureFlt2"
        filtered_data=GaussFlt2(fitStr.data(:,:,i), 100, 100, 500, 500);
        filtered_data = SetContrast(filtered_data, 0.4, 0.999, 1.5);
        filtered_data=CurvatureFlt2(filtered_data, '2D', filter_val(1), filter_val(2));
        filtered_data = GaussFlt2(filtered_data, 1, 1, 10, 10);
        filtered_data = SetContrast(filtered_data, 0.2, 0.999);
    end
    fitStr.data(:,:,i) = filtered_data;
end
%% 3 - Setting NaN values to zero
fitStr.data(isnan(fitStr.data)) = 0;
%% Close wait-bar
close(wbar);

% --- Function to perform Eb alignment
function fitStr = align_energy(fitStr, eb_args)
% dataStr = align_energy(dataStr, eb_args, type_args)
%   This is a function that will align the dataStr ARPES data 
%   to the Fermi-level, VBM or a CB state. It operates using the
%   AlignEF function conditions.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   [EAlign, EF, Fail] = AlignEF(Data, ECorr [,eWin] [,dEWin] [,dESmooth] [,feat]);

disp(' Eb alignment...')
wbar = waitbar(0., 'Executing eb alignment...', 'Name', 'align_energy');

%% 1 - Initialising the re-alignment parameters
fitStr.Meta.eb_args = eb_args;
% - Extracting alignment parameters
eWin = eb_args{1};
dEWin =  eb_args{2};
dESmooth =  eb_args{3};
feat =  eb_args{4};
%% 2 - Performing the re-alignment operation over all scans
for i = 1:size(fitStr.data, 3)
    waitbar(i/size(fitStr.data, 3), wbar, 'Re-aligning ARPES data...', 'Name', 'align_energy');
    [fitStr.eb(:,:,i), ~, ~] = AlignEF(fitStr.data(:,:,i), fitStr.eb(:,:,i), eWin, dEWin,dESmooth, feat);
end
%% Close wait-bar
close(wbar);

% --- Function to perform Kx alignment
function fitStr = align_kx(fitStr, kx_shift_args)
% dataStr = align_energy(dataStr, eb_args, type_args)
%   This is a function that will align the dataStr ARPES data 
%   to the Fermi-level, VBM or a CB state. It operates using the
%   AlignEF function conditions.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   [EAlign, EF, Fail] = AlignEF(Data, ECorr [,eWin] [,dEWin] [,dESmooth] [,feat]);

disp(' Kx alignment...')
wbar = waitbar(0., 'Executing kx alignment...', 'Name', 'align_kx');

%% 1 - Initialising the re-alignment parameters
fitStr.Meta.kx_shift_args = kx_shift_args;
% - Extracting alignment parameters
kxshift = kx_shift_args{1};
%% 2 - Performing the re-alignment operation over all scans
for i = 1:size(fitStr.data, 3)
    waitbar(i/size(fitStr.data, 3), wbar, 'Re-aligning ARPES data...', 'Name', 'align_kx');
    fitStr.kx(:,:,i) = fitStr.kx(:,:,i) + kxshift;
end
%% Close wait-bar
close(wbar);

% --- Function to perform Kx alignment
function fitStr = scale_kx(fitStr, kx_scale_args)
% fitStr = scale_kx(fitStr, kx_scale_args)
%   This is a function that will scale the x-dimension (kx) by a given
%   scale factor to account for any corrections required.
%
%   REQ. FUNCTIONS: (none)

disp(' Kx scaling...')
wbar = waitbar(0.5, 'Executing kx scaling...', 'Name', 'align_kx');

%% 1 - Initialising the re-alignment parameters
fitStr.Meta.kx_scale_args = kx_scale_args;
% - Extracting alignment parameters
kxscale = kx_scale_args{1};
%% 2 - Performing the re-alignment operation over all scans
fitStr.kx = fitStr.kx*kxscale;
%% Close wait-bar
close(wbar);

% --- Function to crop the ARPES data along any dimension
function [xx, yy, zz, dd] = crop_data(x, y, z, d, xLims, yLims)
% dataStr = crop_data(dataStr, xField_lims, yField_lims, zField_lims)
%   This function crops the ARPES x-, y- and z-independent variables over
%   a given range. The function crops the most recently processed data and
%   ensures consistency across both the independent variables and data
%   matrix.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%
%   IN:
%   -   dataStr                       loaded MATLAB data structure.
% 	-   xField_lims:                [1 x 2] row vector of xField ('raw_tht', 'tht', 'kx') crop limits.
% 	-   yField_lims:                [1 x 2] row vector of yField ('raw_eb', 'eb') crop limits.
%	-   zField_lims:                [1 x 2] row vector of zField ('hv / tltM', 'kz / ky') crop limits.
%
%   OUT:
%   -   dataStr                       modified and cropped ARPES data structure.

disp('Data cropping...')

%% Default parameters
maxLim = 1e4;
if nargin < 5; xLims =[-1 1]*maxLim; yLims=[-1 1]*maxLim; end
if nargin < 6; yLims =[-1 1]*maxLim; end
if isempty(xLims); xLims=[-1 1]*maxLim;  end
if isempty(yLims); yLims=[-1 1]*maxLim;  end
if length(xLims) < 2; xLims=[-1 1]*maxLim;  end
if length(yLims) < 2; yLims=[-1 1]*maxLim;  end
% - Sorting the cropping limits in ascending order
xLims = sort(xLims);
yLims = sort(yLims);
%% 1.0 - x cropping indices
[~, indx_L] = min(abs(x(1,:,1) - xLims(1)));
[~, indx_U] = min(abs(x(1,:,1) - xLims(2)));
xIndx = [indx_L indx_U];
%% 1.1 - y cropping indices
[~, indx_L] = min(abs(y(:,1,1) - yLims(1)));
[~, indx_U] = min(abs(y(:,1,1) - yLims(2)));
yIndx = [indx_L indx_U];
%% 2 - Final data cropping using the indices
xx = x(yIndx(1):yIndx(2), xIndx(1):xIndx(2),:);
yy = y(yIndx(1):yIndx(2), xIndx(1):xIndx(2),:);
dd = d(yIndx(1):yIndx(2), xIndx(1):xIndx(2),:);
if length(z) == 1; zz = z;
elseif length(z) > 1; zz = z(yIndx(1):yIndx(2), xIndx(1):xIndx(2),:);
else; zz = [];
end

% --- Function to perform background subtraction
function  fitStr = background_subtraction(fitStr, backsub_args)
% fitStr = background_subtraction(fitStr, backsub_args)
%   This function subtracts the background of the ROI relative
%   to the background defined initially from the cropping.
%
%   REQ. FUNCTIONS: none.
%
%   IN:
%   -   fitStr:           data structure of the fitted ARPES data.
%   -   backsub_args:    1x1 cell array of {polynomial order}.
%
%   OUT:
%   -   fitStr.back_sub:    new data structure with all the background subtraction outputs.

disp('Background subtraction of ROI...')
wbar = waitbar(0, 'Executing background subtraction...', 'Name', 'background_subtraction');

%% Default parameters
% -- Check if a background subtraction was done before
if isfield(fitStr.Meta, 'bsub'); fitStr.Meta = rmfield(fitStr.Meta, 'bsub'); end
%% 1 - Initialising the variables
fitStr.Meta.bsub.args = backsub_args;
fitStr.Meta.bsub.roi_prior = fitStr.data_roi;
fitStr.Meta.bsub.back_prior = fitStr.Meta.data_back;
%% 2 -Extracting the polynomial background over all scans
for s = 1:size(fitStr.data_roi, 3)
    waitbar(s/size(fitStr.data_roi, 3), wbar, 'Extracting polynomial background...', 'Name', 'background_subtraction');
    roi_polyfit(:,:,s) = polyval(polyfit(fitStr.Meta.eb_back(:,:,s), fitStr.Meta.data_back(:,:,s), backsub_args{1}), fitStr.eb_roi(:,:,s));
    back_polyfit(:,:,s) = polyval(polyfit(fitStr.Meta.eb_back(:,:,s), fitStr.Meta.data_back(:,:,s), backsub_args{1}), fitStr.Meta.eb_back(:,:,s));
end
fitStr.Meta.bsub.roi_polyfit = roi_polyfit;
fitStr.Meta.bsub.back_polyfit = back_polyfit;
%% 3 - Performing the background subtraction over all scans
% Performing the background subtraction
for s = 1:size(fitStr.data_roi, 3)
    waitbar(s/size(fitStr.data_roi, 3), wbar, 'Background subtracting data...', 'Name', 'background_subtraction');
    % - Subtracting the polynomial background
    fitStr.data_roi(:,:,s) = fitStr.data_roi(:,:,s) - fitStr.Meta.bsub.roi_polyfit(:,:,s);
    fitStr.Meta.data_back(:,:,s) = fitStr.Meta.data_back(:,:,s) - fitStr.Meta.bsub.back_polyfit(:,:,s);
end
% - Forcing the minimum value to be zero
fitStr.data_roi = fitStr.data_roi - min(fitStr.data_roi(:));
fitStr.Meta.data_back = fitStr.Meta.data_back - min(fitStr.Meta.data_back(:));
% - Scaling the curves to unity
fitStr.data_roi = fitStr.data_roi / max(fitStr.data_roi(:));
fitStr.Meta.data_back = fitStr.Meta.data_back / max(fitStr.data_roi(:));
% - Scaling the curves to maximum value of ROIs
fitStr.data_roi = fitStr.data_roi .* max(fitStr.Meta.bsub.roi_prior(:));
fitStr.Meta.data_back = fitStr.Meta.data_back .* max(fitStr.Meta.bsub.roi_prior(:));
%% 3 - Appending the post background subtraction data
fitStr.Meta.bsub.roi_post = fitStr.data_roi;
fitStr.Meta.bsub.back_post = fitStr.Meta.data_back;
%% Close wait-bar
close(wbar);

% --- Function to extract the Fermi-Diract distibution defined
function fitStr = extract_fdd(fitStr, fdd_args)
% fitStr = extract_fdd(fitStr, fdd_args)
%   This function extracts the Fermi-Diract distribution of the ARPES
%   data, given the temperature, fermi-energy and analyser resolution.
%   The resulting Fermi-Dirac Distribution is convolvuted with the
%   analyser resolution to give an intrinsic broadening.
%
%   REQ. FUNCTIONS: none.
%
%   IN:
%   -   fitStr:           data structure of the fitted ARPES data.
%   -   fdd_args:    1x3 cell array of {Temperature, Fermi-Energy, Beam/Analyser Resolution}.
%
%   OUT:
%   -   fitStr.fdd:    new data structure with all the fdd outputs.

disp('Extracting the Fermi-Dirac Distribution...')
wbar = waitbar(0., 'Extracting the Fermi-Dirac Distribution...', 'Name', 'extract_fdd');
% -- Check if a FDD function was extracted before
if isfield(fitStr, 'fdd'); fitStr = rmfield(fitStr, 'fdd'); end

%% - Initialising the Fermi and Gaussian functions
fitStr.fdd.args = fdd_args;
% - Fermi function
fitStr.fdd.Fermi = @(xdat) 1 ./ (exp((xdat-fdd_args{2})/(8.617E-5*fdd_args{1})) + 1);
% - Normalised Gaussian function
fitStr.fdd.Gauss = @(xdat) exp(-1 * log(2) .* ((xdat - fdd_args{2}) ./ (1e-3*fdd_args{3}/2)).^2);
%% 1 - Evaluating the Functions
fitStr.fdd.eb = linspace(fdd_args{2}-2, fdd_args{2}+2, 1e3); 
fitStr.fdd.y_fermi = fitStr.fdd.Fermi(fitStr.fdd.eb);
fitStr.fdd.y_gauss = fitStr.fdd.Gauss(fitStr.fdd.eb);
%% 2 - Convolving the Fermi and Gaussian functions
fitStr.fdd.y_conv = conv(fitStr.fdd.y_gauss, fitStr.fdd.y_fermi, 'same'); 
fitStr.fdd.y_conv = fitStr.fdd.y_conv / max(fitStr.fdd.y_conv);
% - Eliminate edge effects of the convolution
for i = 1:size(fitStr.fdd.y_conv, 2)
    waitbar(i/size(fitStr.fdd.y_conv, 2), wbar, 'Extracting the Fermi-Dirac Distribution..', 'Name', 'extract_fdd');
    y_conv_val = fitStr.fdd.y_conv(i); if y_conv_val == 1; fitStr.fdd.y_conv(1,1:i) = 1; break; end
end
% - 2.5 - Assigning the best fit Fermi function
fitStr.fdd.FDD = fit(fitStr.fdd.eb', fitStr.fdd.y_conv', 'linearinterp');  
%% Close wait-bar
close(wbar);

% --- Function to extract the parabolic dispersion defined
function fitStr = extract_parabola(fitStr, parabolic_args)
% fitStr = extract_parabola(fitStr, parabolic_args)
%   This function extracts an estimate to the parabolic dispersion
%   of the region of interest. It allows to give error bars on the
%   estimated parabolic dispersion, that can further be used during the
%   fitting to the ROI if required.
%
%   REQ. FUNCTIONS: none.
%
%   IN:
%   -   fitStr:                    data structure of the fitted ARPES data.
%   -   parabolic_args:    1x5 cell array of {k0, eb0, mstar, dk, deb}
%
%   OUT:
%   -   fitStr.parabola:    new data structure with all the parabola outputs

disp('Extracting the parabolic dispersions...')
wbar = waitbar(0.5, 'Extracting the parabolic dispersions...', 'Name', 'extract_parabola');
% -- Check if a parabola function was extracted before
if isfield(fitStr, 'para'); fitStr = rmfield(fitStr, 'para'); end

%% 1 - Initialising the parabolic dispersion parameters
fitStr.para.args = parabolic_args;
% - Defining the parabolic dispersion fits (in terms of Angstroms and eV)
fitStr.para.febk = @(k0, eb0, mstar, kx) (3.8180 / mstar) * (kx - k0).^2 + eb0;
fitStr.para.ifebk = @(k0, eb0, mstar, eb) (mstar / 3.8180) .* sqrt(eb - eb0) + k0;
%% 2 - Evaluating the parabolic dispersions
l = 1;
for i = 1:size(parabolic_args, 1)
    waitbar(i/size(parabolic_args, 1), wbar, 'Extracting the parabolic dispersions...', 'Name', 'extract_parabola');
    valid_check = 0;
    for j = 1:size(parabolic_args, 2); if isempty(parabolic_args{i,j}); valid_check = 1; end; end
    % - If all the columns are filled in for the row, then extract parabolic trail
    if valid_check == 0
        fitStr.para.kx{l} = linspace(parabolic_args{i,1}-2, parabolic_args{i,1}+2, 5e2);
        fitStr.para.eb{l} = fitStr.para.febk(parabolic_args{i,1}, parabolic_args{i,3}, parabolic_args{i,5}, fitStr.para.kx{l});
        l = l +1;
    end
end
%% Close wait-bar
close(wbar);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INTERNAL FITTING FUNCTIONS %%%%%%%%%%%
% --- Defining a general Lorentzian function
function int = Lorz(A, fwhm, mu, xdat)
% int = Lorz(A, fwhm, mu, xdat)
%   General Lorentzian function for spectral response.
%
%   IN:
%   -   A:              amplitude of peak.
%   -   fwhm:       Lorentzian full-width half-maximum
%   -   mu:           mean peak position.
%   -   xdat:         1D row vector of the domain.
%
%   OUT:
%   -   int:            1D row vector of the intensity distribution.

% Ensuring xdat is a column vector
if size(xdat, 2) >1; xdat = xdat'; end
int = A ./ (1 + ((xdat - mu) ./ (fwhm/2)).^2);
    
% --- Defining a general Gaussian function
function int = Gauss(A, fwhm, mu, xdat)
% int = Gauss(A, fwhm, mu, xdat)
%   General Gaussian function for spectral response.
%
%   IN:
%   -   A:              amplitude of peak.
%   -   fwhm:       Gaussian full-width half-maximum
%   -   mu:           mean peak position.
%   -   xdat:         1D row vector of the domain.
%
%   OUT:
%   -   int:            1D row vector of the intensity distribution.

% Ensuring xdat is a column vector
if size(xdat, 2) >1; xdat = xdat'; end
int = A .* exp(-1 * log(2) .* ((xdat - mu) ./ (fwhm/2)).^2);

% --- Defining a general Voigt function
function int = Voigt(A, fwhm, mu, xdat, mix)
% int = Gauss(A, fwhm, mu, xdat, mix)
%   General Gaussian function for spectral response.
%
%   IN:
%   -   A:              amplitude of peak.
%   -   fwhm:       Gauss/Lorentz full-width half-maximum ratio
%   -   mu:           mean peak position.
%   -   xdat:         1D row vector of the domain.
%
%   OUT:
%   -   int:            1D row vector of the intensity distribution.

% Ensuring xdat is a column vector
if size(xdat, 2) >1; xdat = xdat'; end
% Defining the parameters
if mix == 0
    par = [mu; 1; 1e-4; fwhm];
elseif mix == 0.5
    par = [mu; 1; mix*fwhm; mix*fwhm];
elseif mix == 1
    par = [mu; 1; fwhm; 1e-4];
elseif mix < 0.5
    par = [mu; 1; mix*fwhm; fwhm];
elseif mix > 0.5
    par = [mu; 1; fwhm; mix*fwhm];
end
% Extracting the Voigt function
int = voigt(xdat, par);
int = int / max(int(:));
int = A .* int;
if size(int, 2) >1; int = int'; end

% --- Function to fit to the EDCs of an ARPES spectrum
function fitStr = edc_fitter(fitStr, input_args)
% fitStr = edc_fitter(fitStr, fit_args, edc_args)
%   This is a function that will perform a fitting of a desired
%   type over the EDC cuts of the 2D ARPES data.
%
%   REQ. FUNCTIONS: none.
%
%   IN:
%   -   fitStr:                             data structure of the fitted ARPES data.
%   -   fit_args:                 1x3 cell of fit properties {fitRange, cutIndex, fitRoutine}.
%   -   edc_args:   1x8 cell of EDC parameters {fit, fitType, kRange, peak, fwhm, ebPos, FermiFit, ParabolaFit}.
%
%   OUT:
%   -   fitStr.edc_fits:                new data structure with all the fitting data/information

disp('Fitting the EDCs...')
wbar = waitbar(0., 'Performing EDC fits...', 'Name', 'edc_fitter');
fitStr.edc_fits{input_args.scan{1}(1)} = [];

waitbar(0.2, wbar, 'Defining fit functions...', 'Name', 'edc_fitter');
%% 1.0 - Initialising the FDD convolved fit functions
fddLorentz = @(A, fwhm, mu, xdat) Lorz(A, fwhm, mu, xdat) .* input_args.fdd(xdat);
fddGauss = @(A, fwhm, mu, xdat) Gauss(A, fwhm, mu, xdat) .* input_args.fdd(xdat);
fddVoigt = @(A, fwhm, mu, xdat) Voigt(A, fwhm, mu, xdat, input_args.fit_type{4}) .* input_args.fdd(xdat);
%% 1.1 - Defining the singlet state functions to use
if string(input_args.edc{1,2}) == "lorentzian"
    f1 = @(x, xdat) (Lorz(x(1), x(2), x(3), xdat) + x(4));
    fdd_f1 = @(x, xdat) (fddLorentz(x(1), x(2), x(3), xdat) + x(4));
elseif string(input_args.edc{1,2}) == "gaussian"
     f1 = @(x, xdat) (Gauss(x(1), x(2), x(3), xdat) + x(4));
     fdd_f1 = @(x, xdat) (fddGauss(x(1), x(2), x(3), xdat) + x(4));
 elseif string(input_args.edc{1,2}) == "voigt"
     f1 = @(x, xdat) (Voigt(x(1), x(2), x(3), xdat, input_args.fit_type{4}) + x(4));
     fdd_f1 = @(x, xdat) (fddVoigt(x(1), x(2), x(3), xdat) + x(4));
end

 %% 1.2 - Defining the full functional form of the curve used to fit to the EDC cut
 % -- Input form for n fits is: [x1=peak, x2=fwhm, x3=pos, x4=shift, ...]
 % -- Functional form of curve without FDD multiplier
 if input_args.edc{1,5} == 0
      if input_args.nStates == 1 && string(input_args.edc{1,2}) == "lorentzian"
         fn = @(x, xdat) (Lorz(x(1), x(2), x(3), xdat) + x(4));
     elseif input_args.nStates == 1 && string(input_args.edc{1,2}) == "gaussian"
         fn = @(x, xdat) (Gauss(x(1), x(2), x(3), xdat) + x(4));
      elseif input_args.nStates == 1 && string(input_args.edc{1,2}) == "voigt"
         fn = @(x, xdat) Voigt(x(1), x(2), x(3), xdat, input_args.fit_type{4}) + x(4);
     elseif input_args.nStates == 2 && string(input_args.edc{1,2}) == "lorentzian"
         fn = @(x, xdat) (Lorz(x(1), x(2), x(3), xdat) + Lorz(x(5), x(6), x(7), xdat) + 0.5*(x(4) + x(8)));
     elseif input_args.nStates == 2 && string(input_args.edc{1,2}) == "gaussian"
         fn = @(x, xdat) (Gauss(x(1), x(2), x(3), xdat) + Gauss(x(5), x(6), x(7), xdat) + 0.5*(x(4) + x(8)));
     elseif input_args.nStates == 2 && string(input_args.edc{1,2}) == "voigt"
         fn = @(x, xdat) (Voigt(x(1), x(2), x(3), xdat, input_args.fit_type{4}) + Voigt(x(5), x(6), x(7), xdat, input_args.fit_type{4}) + 0.5*(x(4) + x(8)));
      end
  % -- Functional form of curve with FDD multiplier
 elseif input_args.edc{1,5} == 1
      if input_args.nStates == 1 && string(input_args.edc{1,2}) == "lorentzian"
         fn = @(x, xdat) (fddLorentz(x(1), x(2), x(3), xdat) + x(4));
     elseif input_args.nStates == 1 && string(input_args.edc{1,2}) == "gaussian"
         fn = @(x, xdat) (fddGauss(x(1), x(2), x(3), xdat) + x(4));
      elseif input_args.nStates == 1 && string(input_args.edc{1,2}) == "voigt"
         fn = @(x, xdat) (fddVoigt(x(1), x(2), x(3), xdat) + x(4));
     elseif input_args.nStates == 2 && string(input_args.edc{1,2}) == "lorentzian"
        fn = @(x, xdat) (fddLorentz(x(1), x(2), x(3), xdat) + fddLorentz(x(5), x(6), x(7), xdat) + 0.5*(x(4) + x(8)));
     elseif input_args.nStates == 2 && string(input_args.edc{1,2}) == "gaussian"
         fn = @(x, xdat) (fddGauss(x(1), x(2), x(3), xdat) + fddGauss(x(5), x(6), x(7), xdat) + 0.5*(x(4) + x(8)));
      elseif input_args.nStates == 2 && string(input_args.edc{1,2}) == "voigt"
         fn = @(x, xdat) (fddVoigt(x(1), x(2), x(3), xdat) + fddVoigt(x(5), x(6), x(7), xdat) + 0.5*(x(4) + x(8)));
      end
 end

 waitbar(0.4, wbar, 'Defining initial conditions...', 'Name', 'edc_fitter');
%% 2.0 - Defining the initial conditions / constraints for the fits in a cell-array
% -- Input form for n fits is: [peak, fwhm, pos, peak, fwhm, pos, ...., shift]
ic = {input_args.nStates,4}; lb = {input_args.nStates,4}; ub = {input_args.nStates,4};
% -- Filing through the constraints of each state to be fitted
for n = 1:input_args.nStates
    % --- Extracting the peak limits
    ic{n,1} = mean(input_args.edc{n,3});
    lb{n,1} = input_args.edc{n,3}(1);
    ub{n,1} = input_args.edc{n,3}(2);                
    % --- Extracting the fwhm limits 
    ic{n,2} = mean(input_args.edc{4});
    lb{n,2} = input_args.edc{n,4}(1);
    ub{n,2} = input_args.edc{n,4}(2);
    % --- Extracting the eb limits without the parabolic trail 
    ic{n,3} = mean(fitStr.eb_roi(:));
    lb{n,3} = min(fitStr.eb_roi(:));
    ub{n,3} = max(fitStr.eb_roi(:));
    % --- Allowing for a vertical shift in the fits
    ic{n,4} = mean(input_args.edc{n,6});
    lb{n,4} = input_args.edc{n,6}(1);
    ub{n,4} = input_args.edc{n,6}(2);
end

waitbar(0.6, wbar, 'Extracting ARPES data...', 'Name', 'edc_fitter');
%% 2.1 - Extracting the ARPES spectrum about the fitting area
% - Cropping the data around the selected fit region
[kx_crp, eb_crp, ~, data_crp] = crop_data(...
    fitStr.kx_roi(:,:,input_args.scan{1}(1)),...
    fitStr.eb_roi(:,:,input_args.scan{1}(1)),...
    [],...
    fitStr.data_roi(:,:,input_args.scan{1}(1)),...
    input_args.edc{1,1}, []);
% - Extracting the indices of the fitting area for future reference
[~, Lkindx] = min(abs(fitStr.kx_roi(1,:,input_args.scan{1}(1)) - min(kx_crp(:))));
[~, Hkindx] = min(abs(fitStr.kx_roi(1,:,input_args.scan{1}(1)) - max(kx_crp(:))));
fit_indxs = [Lkindx, Hkindx];

%% 3.0 - File through all EDCs and find the best fits
% -- Filing through all EDCs to be fitted
for i = 1:size(kx_crp,2)
    wbar_txt = sprintf("Executing EDC fit #%i...", i);
    waitbar(i/size(kx_crp,2), wbar, wbar_txt, 'Name', 'edc_fitter');
    
    %% - A - Follow this path to perform a least squares fit
    if input_args.fit_type{3} == "scan - lsqcurvefit()" || input_args.fit_type{3} == "scan - lsqnonlin()"
        %% - A.1 - Determine the initial conditions in Eb around the parabola
        for n = 1:input_args.nStates
            % --- Finding the value of kx
            kx_pts{n}(i,1) = mean(mean(kx_crp(:,i)));
            % --- Extracting the eb limits
            fdisp = @(kx) (3.8180/input_args.para{n,5})*(kx-input_args.para{n,1}).^2 + input_args.para{n,3};
            ic{n,3} = fdisp(kx_pts{n}(i));
            lb{n,3} = ic{n,3} - input_args.para{n,4};
            ub{n,3} = ic{n,3} + input_args.para{n,4};
        end
        %% - A.2 - Transform the initial conditions as vectors
        ic_vector = []; lb_vector = []; ub_vector = [];
         for n = 1:input_args.nStates
             ic_vector = horzcat(ic_vector, [ic{n,1}, ic{n,2}, ic{n,3}, ic{n,4}]);
             lb_vector = horzcat(lb_vector, [lb{n,1}, lb{n,2}, lb{n,3}, lb{n,4}]);
             ub_vector = horzcat(ub_vector, [ub{n,1}, ub{n,2}, ub{n,3}, ub{n,4}]);
         end
        %% - A.3 - Executing the curve fitting algorithm
        if input_args.fit_type{3} == "scan - lsqcurvefit()"
            [beta1{i}, resnorm1{i}, resid1{i}, ~, ~, ~, J1] = lsqcurvefit(fn, ic_vector, eb_crp(:,i), data_crp(:,i), lb_vector, ub_vector);
        elseif input_args.fit_type{3} == "scan - lsqnonlin()"
            fun = @ (x) fn(x, eb_crp(:,i)) - data_crp(:,i);
            [beta1{i}, resnorm1{i}, resid1{i}, ~, ~, ~, J1] = lsqnonlin(fun, ic_vector, lb_vector, ub_vector);
        end
        ci1{i} = nlparci(beta1{i}, resid1{i}, 'jacobian', J1);
        %% - A.4 - Determination of the fitted value of Eb
        for n = 1:input_args.nStates
            eb_pts{n}(i,1) = beta1{i}(4*n-1);
        end
    end
end

%% 4.0 - File through all k- and eb-points to fit a parabola
% - Defining the best fit parabola
fpara = @(x, xdat) (3.8180 ./ x(3)) * (xdat - x(1)).^2 + x(2);
% - Filing through all states to fit independent parabola
for n = 1:input_args.nStates
    wbar_txt = sprintf("Executing Parabolic fit #%i...", n);
    waitbar(i/input_args.nStates, wbar, wbar_txt, 'Name', 'edc_fitter');
    % - Defining the initial conditions and bounds of the parabola
    if n == 1
        ic_vector = [input_args.para{n,1}, input_args.para{n,3}, input_args.para{n,5}];
        ub_vector = [input_args.para{n,1}+0.001, input_args.para{n,3}+0.1, input_args.para{n,5}+0.1];
        lb_vector = [input_args.para{n,1}-0.001, input_args.para{n,3}-0.1, input_args.para{n,5}-0.1];
    else
        ic_vector = [beta2{n-1}(1), input_args.para{n,3}, beta2{n-1}(3)];
        ub_vector = [beta2{n-1}(1)+0.001, input_args.para{n,3}+0.1, beta2{n-1}(3)+0.02];
        lb_vector = [beta2{n-1}(1)-0.001, input_args.para{n,3}-0.1, beta2{n-1}(3)-0.02];
    end
    
    % -- Executing fit algorithm
    [beta2{n}, resnorm2{n}, resid2{n}, ~, ~, ~, J2] = lsqcurvefit(fpara, ic_vector, kx_pts{n}, eb_pts{n});
    ci2{n} = nlparci(beta2{n}, resid2{n}, 'jacobian', J2);
end
%% 5.0 - Assigning all relevant outputs
% - Outputs from EDC curve analysis
output_args.fit_indxs = fit_indxs;
output_args.f1 = f1;
output_args.fdd_f1 = fdd_f1;
output_args.fn = fn;
output_args.beta_edc = beta1;
output_args.ci_edc = ci1;
output_args.resnorm_edc = resnorm1;
output_args.resid_edc = resid1;
output_args.kx_pts = kx_pts;
output_args.eb_pts = eb_pts;
% - Outputs from parabolic curve analysis
output_args.fpara = fpara;
output_args.beta_para = beta2;
output_args.ci_para = ci2;
output_args.resnorm_para = resnorm2;
output_args.resid_para = resid2;
%% 6 - File through all EDCs and find the best fits
fitStr.edc_fits{input_args.scan{1}(1)}.in = input_args;
fitStr.edc_fits{input_args.scan{1}(1)}.out = output_args;
%% Close wait-bar
close(wbar);

% --- Function to fit to the MDCs of an ARPES spectrum
function fitStr = mdc_fitter(fitStr, input_args)
% fitStr = mdc_fitter(fitStr, fittype_args, edc_args)
%   This is a function that will perform a fitting of a desired
%   type over the MDC cuts of the 2D ARPES data. The fits
%   will attempt to plot two diverging Gaussians/lorentzians
%   from an origin to trace out the parabolic nature of the
%   dispersion relation.
%
%   REQ. FUNCTIONS: none.
%
%   IN:
%   -   fitStr:                             data structure of the fitted ARPES data.
%   -   fittype_args:                 1x3 cell of fit properties {fitRange, cutIndex, fitRoutine}.
%   -   mdc_args:                    1x9 cell of EDC parameters {fit, fitType, kRange, peak, fwhm, kPos, FermiFit, ParabolaFit, DiffPeakHeights}.
%
%   OUT:
%   -   fitStr.mdc_fits:                new data structure with all the fitting data/information

disp('Fitting the MDCs...')
wbar = waitbar(0., 'Performing MDC fits...', 'Name', 'mdc_fitter');
fitStr.mdc_fits{input_args.scan{1}(1)} = [];

%% 1.0 - Defining the singlet state functions to use
if string(input_args.mdc{1,2}) == "lorentzian"
    f1 = @(x, xdat) (Lorz(x(1), x(2), x(3), xdat) + x(4));
elseif string(input_args.mdc{1,2}) == "gaussian"
     f1 = @(x, xdat) (Gauss(x(1), x(2), x(3), xdat) + x(4));
 elseif string(input_args.mdc{1,2}) == "voigt"
     f1 = @(x, xdat) (Voigt(x(1), x(2), x(3), xdat, input_args.fit_type{4}) + x(4));
end
 %% 1.1 - Defining the full functional form of the curve used to fit to the MDC cut
% --- Input form for sym fits is: [x1=peak, x2=fwhm, x3=pos1, x4=pos1, ...., xend=shift]
% --- Input form for non-sym fits is: [x1=peak, x2=peak, x3=fwhm, x4=pos1, x5=pos1, ...., xend=shift]
% -- Functional form of curve with symmetric curves
 if input_args.mdc{1,5} == 1
      if input_args.nStates == 1 && string(input_args.mdc{1,2}) == "lorentzian"
         fn = @(x, xdat) (Lorz(x(1), x(2), x(3), xdat) + (Lorz(x(1), x(2), x(4), xdat) + x(5)));
     elseif input_args.nStates == 1 && string(input_args.mdc{1,2}) == "gaussian"
         fn = @(x, xdat) (Gauss(x(1), x(2), x(3), xdat) + (Gauss(x(1), x(2), x(4), xdat) + x(5)));
      elseif input_args.nStates == 1 && string(input_args.mdc{1,2}) == "voigt"
         fn = @(x, xdat) (Voigt(x(1), x(2), x(3), xdat, input_args.fit_type{4}) + (Voigt(x(1), x(2), x(4), xdat, input_args.fit_type{4}) + x(5)));
     elseif input_args.nStates == 2 && string(input_args.mdc{1,2}) == "lorentzian"
         fn = @(x, xdat) (Lorz(x(1), x(2), x(3), xdat) + Lorz(x(1), x(2), x(4), xdat) +...
             Lorz(x(6), x(7), x(8), xdat) + Lorz(x(6), x(7), x(9), xdat) + 0.5*(x(10)+x(5)));
     elseif input_args.nStates == 2 && string(input_args.mdc{1,2}) == "gaussian"
         fn = @(x, xdat) (Gauss(x(1), x(2), x(3), xdat) + Gauss(x(1), x(2), x(4), xdat) +...
             Gauss(x(6), x(7), x(8), xdat) + Gauss(x(6), x(7), x(9), xdat) + 0.5*(x(10)+x(5)));
       elseif input_args.nStates == 2 && string(input_args.mdc{1,2}) == "voigt"
         fn = @(x, xdat) (Voigt(x(1), x(2), x(3), xdat, input_args.fit_type{4}) + Voigt(x(1), x(2), x(4), xdat, input_args.fit_type{4}) +...
             Voigt(x(6), x(7), x(8), xdat, input_args.fit_type{4}) + Voigt(x(6), x(7), x(9), xdat, input_args.fit_type{4}) + 0.5*(x(10)+x(5)));
      end
  % -- Functional form of curve with non symmetric curves
 elseif input_args.mdc{1,5} == 0
      if input_args.nStates == 1 && string(input_args.mdc{1,2}) == "lorentzian"
         fn = @(x, xdat) (Lorz(x(1), x(3), x(4), xdat) + (Lorz(x(2), x(3), x(5), xdat) + x(6)));
     elseif input_args.nStates == 1 && string(input_args.mdc{1,2}) == "gaussian"
         fn = @(x, xdat) (Gauss(x(1), x(3), x(4), xdat) + (Gauss(x(2), x(3), x(5), xdat) + x(6)));
      elseif input_args.nStates == 1 && string(input_args.mdc{1,2}) == "voigt"
         fn = @(x, xdat) (Voigt(x(1), x(3), x(4), xdat, input_args.fit_type{4}) + Voigt(x(2), x(3), x(5), xdat, input_args.fit_type{4}) + x(6));
     elseif input_args.nStates == 2 && string(input_args.mdc{1,2}) == "lorentzian"
         fn = @(x, xdat) (Lorz(x(1), x(3), x(4), xdat) + Lorz(x(2), x(3), x(5), xdat) +...
             Lorz(x(7), x(9), x(10), xdat) + Lorz(x(8), x(9), x(11), xdat) + 0.5*(x(12)+x(6)));
     elseif input_args.nStates == 2 && string(input_args.mdc{1,2}) == "gaussian"
         fn = @(x, xdat) (Gauss(x(1), x(3), x(4), xdat) + Gauss(x(2), x(3), x(5), xdat) +...
             Gauss(x(7), x(9), x(10), xdat) + Gauss(x(8), x(9), x(11), xdat) + 0.5*(x(12)+x(6)));
      elseif input_args.nStates == 2 && string(input_args.mdc{1,2}) == "voigt"
         fn = @(x, xdat) (Voigt(x(1), x(3), x(4), xdat, input_args.fit_type{4}) + Voigt(x(2), x(3), x(5), xdat, input_args.fit_type{4}) +...
             Voigt(x(7), x(9), x(10), xdat, input_args.fit_type{4}) + Voigt(x(8), x(9), x(11), xdat, input_args.fit_type{4}) + 0.5*(x(12)+x(6)));
      end
 end
 
waitbar(0.4, wbar, 'Defining initial conditions...', 'Name', 'mdc_fitter');
%% 2.0 - Defining the initial conditions / constraints for the fits in a cell-array
% --- Input form for sym fits is: [x1=peak, x2=fwhm, x3=pos1, x4=pos1, x5=shift, ...]
% --- Input form for non-sym fits is: [x1=peak, x2=peak, x3=fwhm, x4=pos1, x5=pos1, x6=shift, ...]
% -- Initial conditions with symmetric curves
if input_args.mdc{1,5} == 1
    ic = {input_args.nStates,5}; lb = {input_args.nStates,5}; ub = {input_args.nStates,5};
    % -- Filing through the constraints of each state to be fitted
    for n = 1:input_args.nStates
        % --- Extracting the peak limits
        ic{n,1} = mean(input_args.mdc{n,3});
        lb{n,1} = input_args.mdc{n,3}(1);
        ub{n,1} = input_args.mdc{n,3}(2);                
        % --- Extracting the fwhm limits 
        ic{n,2} = mean(input_args.mdc{n,4});
        lb{n,2} = input_args.mdc{n,4}(1);
        ub{n,2} = input_args.mdc{n,4}(2);
        % --- Extracting the kx limits without the parabolic trail 
        ic{n,3} = mean(fitStr.kx_roi(:));
        lb{n,3} = min(fitStr.kx_roi(:));
        ub{n,3} = max(fitStr.kx_roi(:));
        ic{n,4} = mean(fitStr.kx_roi(:));
        lb{n,4} = min(fitStr.kx_roi(:));
        ub{n,4} = max(fitStr.kx_roi(:));
        % --- Allowing for a vertical shift in the fits
        ic{n,5} = mean(input_args.mdc{n,6});
        lb{n,5} = input_args.mdc{n,6}(1);
        ub{n,5} = input_args.mdc{n,6}(2);
    end
  % -- Initial conditions with non symmetric curves
elseif input_args.mdc{1,5} == 0
     ic = {input_args.nStates,6}; lb = {input_args.nStates,6}; ub = {input_args.nStates,6};
     % -- Filing through the constraints of each state to be fitted
    for n = 1:input_args.nStates
        % --- Extracting the peak limits
        ic{n,1} = mean(input_args.mdc{n,3});
        lb{n,1} = input_args.mdc{n,3}(1);
        ub{n,1} = input_args.mdc{n,3}(2);
        ic{n,2} = mean(input_args.mdc{n,3});
        lb{n,2} = input_args.mdc{n,3}(1);
        ub{n,2} = input_args.mdc{n,3}(2);     
        % --- Extracting the fwhm limits 
        ic{n,3} = mean(input_args.mdc{n,4});
        lb{n,3} = input_args.mdc{n,4}(1);
        ub{n,3} = input_args.mdc{n,4}(2);
        % --- Extracting the kx limits without the parabolic trail 
        ic{n,4} = mean(fitStr.kx_roi(:));
        lb{n,4} = min(fitStr.kx_roi(:));
        ub{n,4} = max(fitStr.kx_roi(:));
        ic{n,5} = mean(fitStr.kx_roi(:));
        lb{n,5} = min(fitStr.kx_roi(:));
        ub{n,5} = max(fitStr.kx_roi(:));
        % --- Allowing for a vertical shift in the fits
        ic{n,6} = mean(input_args.mdc{n,6});
        lb{n,6} = input_args.mdc{n,6}(1);
        ub{n,6} = input_args.mdc{n,6}(2);
    end
end

waitbar(0.6, wbar, 'Extracting ARPES data...', 'Name', 'mdc_fitter');
%% 2.1 - Extracting the ARPES spectrum about the fitting area
% - Cropping the data around the selected fit region
[kx_crp, eb_crp, ~, data_crp] = crop_data(...
    fitStr.kx_roi(:,:,input_args.scan{1}(1)),...
    fitStr.eb_roi(:,:,input_args.scan{1}(1)),...
    [],...
    fitStr.data_roi(:,:,input_args.scan{1}(1)),...
    [], input_args.mdc{1,1});
% - Extracting the indices of the fitting area for future reference
[~, Lkindx] = min(abs(fitStr.eb_roi(:,1,input_args.scan{1}(1)) - min(eb_crp(:))));
[~, Hkindx] = min(abs(fitStr.eb_roi(:,1,input_args.scan{1}(1)) - max(eb_crp(:))));
fit_indxs = [Lkindx, Hkindx];

%% 3.0 - File through all MDCs and find the best fits
% -- Filing through all MDCs to be fitted
for i = 1:size(eb_crp, 1)
    wbar_txt = sprintf("Executing MDC fit #%i...", i);
    waitbar(i/size(eb_crp, 1), wbar, wbar_txt, 'Name', 'mdc_fitter');
    
    %% - A - Follow this path to perform a least squares fit
    if input_args.fit_type{3} == "scan - lsqcurvefit()" || input_args.fit_type{3} == "scan - lsqnonlin()"
        %% - A.1 - Determine the initial conditions in Kx around the parabola
        for n = 1:input_args.nStates            
            % --- Finding the value of eb
            eb_pts{n}(i,1) = mean(mean(eb_crp(i,:)));
            ifdisp = @(eb) input_args.para{n,1} + real(sqrt((input_args.para{n,5}/3.8180).*(eb-input_args.para{n,3})));
            % --- symmetric curves kx values
            if input_args.mdc{1,5} == 1
                ic{n,3} = +1*ifdisp(eb_pts{n}(i));
                lb{n,3} = ic{n,3} - input_args.para{n,2};
                ub{n,3} = ic{n,3} + input_args.para{n,2};
                ic{n,4} = -1*ifdisp(eb_pts{n}(i)) + 2*input_args.para{n,1};
                lb{n,4} = ic{n,4} - input_args.para{n,2};
                ub{n,4} = ic{n,4} + input_args.para{n,2};
                % ---- Forcing the peak intensity to be zero if below predicted value of Eb
                if input_args.para{n,5} > 0
                    if round(eb_pts{n}(i), 4) < (round(input_args.para{n,3}, 4)-0.01)
                        diff = 1/abs(round(eb_pts{n}(i), 4) - (round(input_args.para{n,3}, 4)-0.01));
                        ic{n,1} = 0; lb{n,1} = 0; ub{n,1} = 2*input_args.mdc{n,3}(1); 
                        ic{n,3} = 0; lb{n,3} = -0.001; ub{n,3} = 0.001;
                        ic{n,4} = 0; lb{n,4} = -0.001; ub{n,4} = 0.001;
                    else
                        ic{n,1} = mean(input_args.mdc{n,3}); 
                        lb{n,1} = input_args.mdc{n,3}(1); 
                        ub{n,1} = input_args.mdc{n,3}(2);
                    end
                else
                    if round(eb_pts{n}(i), 4) > (round(input_args.para{n,3}, 4)-0.01)
                        diff = 1/abs(round(eb_pts{n}(i), 4) - (round(input_args.para{n,3}, 4)-0.01));
                        ic{n,1} = 0; lb{n,1} = 0; ub{n,1} = 2*input_args.mdc{n,3}(1); 
                        ic{n,3} = 0; lb{n,3} = -0.001; ub{n,3} = 0.001;
                        ic{n,4} = 0; lb{n,4} = -0.001; ub{n,4} = 0.001;
                    else
                        ic{n,1} = mean(input_args.mdc{n,3}); 
                        lb{n,1} = input_args.mdc{n,3}(1); 
                        ub{n,1} = input_args.mdc{n,3}(2);
                    end
                end
                
            % -- non symmetric curves kx values
            elseif input_args.mdc{1,5} == 0
                ic{n,4} = +1*ifdisp(eb_pts{n}(i));
                lb{n,4} = ic{n,4} - input_args.para{n,2};
                ub{n,4} = ic{n,4} + input_args.para{n,2};
                ic{n,5} = -1*ifdisp(eb_pts{n}(i)) + 2*input_args.para{n,1};
                lb{n,5} = ic{n,5} - input_args.para{n,2};
                ub{n,5} = ic{n,5} + input_args.para{n,2};
                % ---- Forcing the peak intensity to be zero if below predicted value of Eb
                if input_args.para{n,5} > 0
                    if round(eb_pts{n}(i), 4) < (round(input_args.para{n,3}, 4)-0.01)
                        diff = 1/abs(round(eb_pts{n}(i), 4) - (round(input_args.para{n,3}, 4)-0.01));
                        ic{n,1} = input_args.mdc{n,3}(1); lb{n,1} = 0; ub{n,1} = 2*input_args.mdc{n,3}(1); 
                        ic{n,2} = input_args.mdc{n,3}(1); lb{n,2} = 0; ub{n,2} = 2*input_args.mdc{n,3}(1); 
                        ic{n,4} = 0; lb{n,4} = -0.001; ub{n,4} = 0.001;
                        ic{n,5} = 0; lb{n,5} = -0.001; ub{n,5} = 0.001;
                    else
                        ic{n,1} = mean(input_args.mdc{n,3}); 
                        lb{n,1} = input_args.mdc{n,3}(1); 
                        ub{n,1} = input_args.mdc{n,3}(2);
                        ic{n,2} = mean(input_args.mdc{n,3}); 
                        lb{n,2} = input_args.mdc{n,3}(1); 
                        ub{n,2} = input_args.mdc{n,3}(2);
                    end
                else
                    if round(eb_pts{n}(i), 4) > (round(input_args.para{n,3}, 4)-0.01)
                        diff = 1/abs(round(eb_pts{n}(i), 4) - (round(input_args.para{n,3}, 4)-0.01));
                        ic{n,1} = input_args.mdc{n,3}(1); lb{n,1} = 0; ub{n,1} = 2*input_args.mdc{n,3}(1); 
                        ic{n,2} = input_args.mdc{n,3}(1); lb{n,2} = 0; ub{n,2} = 2*input_args.mdc{n,3}(1); 
                        ic{n,4} = 0; lb{n,4} = -0.001; ub{n,4} = 0.001;
                        ic{n,5} = 0; lb{n,5} = -0.001; ub{n,5} = 0.001;
                    else
                        ic{n,1} = mean(input_args.mdc{n,3}); 
                        lb{n,1} = input_args.mdc{n,3}(1); 
                        ub{n,1} = input_args.mdc{n,3}(2);
                        ic{n,2} = mean(input_args.mdc{n,3}); 
                        lb{n,2} = input_args.mdc{n,3}(1); 
                        ub{n,2} = input_args.mdc{n,3}(2);
                    end
                end
            end
        end
        %% - A.2 - Transform the initial conditions as vectors
        ic_vector = []; lb_vector = []; ub_vector = [];
        for n = 1:input_args.nStates
            % --- symmetric curves kx values
            if input_args.mdc{1,5} == 1
                ic_vector = horzcat(ic_vector, [ic{n,1}, ic{n,2}, ic{n,3}, ic{n,4}, ic{n,5}]);
                lb_vector = horzcat(lb_vector, [lb{n,1}, lb{n,2}, lb{n,3}, lb{n,4}, lb{n,5}]);
                ub_vector = horzcat(ub_vector, [ub{n,1}, ub{n,2}, ub{n,3}, ub{n,4}, ub{n,5}]);
            % -- non symmetric curves kx values
            elseif input_args.mdc{1,5} == 0
                ic_vector = horzcat(ic_vector, [ic{n,1}, ic{n,2}, ic{n,3}, ic{n,4}, ic{n,5}, ic{n,6}]);
                lb_vector = horzcat(lb_vector, [lb{n,1}, lb{n,2}, lb{n,3}, lb{n,4}, lb{n,5}, lb{n,6}]);
                ub_vector = horzcat(ub_vector, [ub{n,1}, ub{n,2}, ub{n,3}, ub{n,4}, ub{n,5}, ub{n,6}]);
            end
        end
        %% - A.3 - Executing the curve fitting algorithm
        if input_args.fit_type{3} == "scan - lsqcurvefit()"
            [beta1{i}, resnorm1{i}, resid1{i}, ~, ~, ~, J1] = lsqcurvefit(fn, ic_vector, kx_crp(i,:), data_crp(i,:)', lb_vector, ub_vector);
        elseif input_args.fit_type{3} == "scan - lsqnonlin()"
            fun = @ (x) fn(x, kx_crp(i,:)) - data_crp(i,:);
            [beta1{i}, resnorm1{i}, resid1{i}, ~, ~, ~, J1] = lsqnonlin(fun, ic_vector, lb_vector, ub_vector);
        end
        ci1{i} = nlparci(beta1{i}, resid1{i}, 'jacobian', J1);

        %% - A.4 - Determination of the fitted value of Kx
        for n = 1:input_args.nStates
            % --- symmetric curves kx values
            if input_args.mdc{1,5} == 1
                kx_pts{n}(i,1) = beta1{i}(5*n-2);
                kx_pts{n}(i,2) = beta1{i}(5*n-1);
            % -- non symmetric curves kx values
            elseif input_args.mdc{1,5} == 0
                kx_pts{n}(i,1) = beta1{i}(6*n-2);
                kx_pts{n}(i,2) = beta1{i}(6*n-1);
            end
        end
    end
end

%% 4.0 - Making the k- and eb-points consistent
% Deleting any points where the eb-points are below threshold
eb_pts_new = {}; kx_pts_new = {};
for n = 1:input_args.nStates
    l = 1;
    for i = 1:size(eb_pts{n}, 1)
        if input_args.para{n,5} > 0 && round(eb_pts{n}(i,1), 3) >= (round(input_args.para{n,3}, 4)-0.008)
            eb_pts_new{n}(l,1) = eb_pts{n}(i,1);
            kx_pts_new{n}(l,1) = kx_pts{n}(i,1);
            kx_pts_new{n}(l,2) = kx_pts{n}(i,2);
            l = l+1;
        elseif input_args.para{n,5} < 0 && round(eb_pts{n}(i,1), 3) <= (round(input_args.para{n,3}, 4)-0.008)
            eb_pts_new{n}(l,1) = eb_pts{n}(i,1);
            kx_pts_new{n}(l,1) = kx_pts{n}(i,1);
            kx_pts_new{n}(l,2) = kx_pts{n}(i,2);
            l = l+1;
        end
    end
end
% Making the k- and eb-points consistent now
eb_pts = {}; kx_pts = {};
for n = 1:input_args.nStates
    eb_pts{n} = [eb_pts_new{n}; eb_pts_new{n}];
    kx_pts{n} = [kx_pts_new{n}(:,1); kx_pts_new{n}(:,2)];
end

%% 4.1 - File through all k- and eb-points to fit a parabola
% - Defining the best fit parabola
fpara = @(x, xdat)(3.8180 ./ x(3)) * (xdat - x(1)).^2 + x(2);
% - Filing through all states to fit independent parabola
for n = 1:input_args.nStates
    wbar_txt = sprintf("Executing Parabolic fit #%i...", n);
    waitbar(i/(input_args.nStates+1), wbar, wbar_txt, 'Name', 'edc_fitter');
    % - Defining the initial conditions and bounds of the parabola
    if n == 1
        ic_vector = [input_args.para{n,1}, input_args.para{n,3}, input_args.para{n,5}];
        ub_vector = [input_args.para{n,1}+0.001, input_args.para{n,3}+0.1, input_args.para{n,5}+0.1];
        lb_vector = [input_args.para{n,1}-0.001, input_args.para{n,3}-0.1, input_args.para{n,5}-0.1];
    else
        ic_vector = [beta2{n-1}(1), input_args.para{n,3}, beta2{n-1}(3)];
        ub_vector = [beta2{n-1}(1)+0.001, input_args.para{n,3}+0.1, beta2{n-1}(3)+0.02];
        lb_vector = [beta2{n-1}(1)-0.001, input_args.para{n,3}-0.1, beta2{n-1}(3)-0.02];
    end
    % -- Executing fit algorithm
    [beta2{n}, resnorm2{n}, resid2{n}, ~, ~, ~, J2] = lsqcurvefit(fpara, ic_vector, kx_pts{n}, eb_pts{n}, lb_vector, ub_vector);
    ci2{n} = nlparci(beta2{n}, resid2{n}, 'jacobian', J2);
end

%% 5.0 - Assigning all relevant outputs
% - Outputs from EDC curve analysis
output_args.fit_indxs = fit_indxs;
output_args.f1 = f1;
output_args.fn = fn;
output_args.beta_mdc = beta1;
output_args.ci_mdc = ci1;
output_args.resnorm_mdc = resnorm1;
output_args.resid_mdc = resid1;
output_args.kx_pts = kx_pts;
output_args.eb_pts = eb_pts;
% - Outputs from parabolic curve analysis
output_args.fpara = fpara;
output_args.beta_para = beta2;
output_args.ci_para = ci2;
output_args.resnorm_para = resnorm2;
output_args.resid_para = resid2;
%% 6 - File through all EDCs and find the best fits
fitStr.mdc_fits{input_args.scan{1}(1)}.in = input_args;
fitStr.mdc_fits{input_args.scan{1}(1)}.out = output_args;
%% Close wait-bar
close(wbar);

% --- Function to fit to the EDCs / MDCs of an ARPES spectrum
function fitStr = fit_algorithm(fitStr, fit_args, scan_args, edc_args, mdc_args)
% fitStr = fit_algorithm(fitStr, fittype_args, edc_args, mdc_args)
%   This function extracts an estimate to the parabolic dispersion
%   of the region of interest. It allows to give error bars on the
%   estimated parabolic dispersion, that can further be used during the
%   fitting to the ROI if required.
%
%   REQ. FUNCTIONS:
%   -   fitStr = edc_fitter(fitStr, fittype_args, edc_args)
%   -   fitStr = mdc_fitter(fitStr, fittype_args, mdc_args)
%
%   IN:
%   -   fitStr:                             data structure of the fitted ARPES data.
%   -   fit_args:                 1x3 cell of fit properties {fitRange, cutIndex, fitRoutine}.
%   -   edc_args:                      1x8 cell of EDC parameters {fit, fitType, kRange, peak, fwhm, ebPos, FermiFit, ParabolaFit}.
%   -   mdc_args:                    1x7 cell of EDC parameters {fit, fitType, kRange, peak, fwhm, kPos, ParabolaFit}.
%
%   OUT:
%   -   fitStr.edc_fits:                new data structure with all the edc fit data.
%   -   fitStr.mdc_fits:               new data structure with all the mdc fit data.

%% 1 - Assigning all the input arguments to the fit algorithm
input_args.fit_type = fit_args;
% - Scan arguments
input_args.scan = scan_args;
% - Fermi arguments
input_args.fdd = fitStr.fdd.FDD;
% - Parabolic arguments
input_args.para = fitStr.para.args;
input_args.para(any(cellfun(@isempty, input_args.para), 2),:) = [];
input_args.febk = fitStr.para.febk;
input_args.ifebk = fitStr.para.ifebk;
% - EDC arguments
input_args.edc = edc_args;
input_args.edc(any(cellfun(@isempty, input_args.edc), 2),:) = [];
for n = 1:size(input_args.edc, 1)
    input_args.edc{n,1} = round(sort(str2num(strrep(input_args.edc{n,1},':',' '))), 4);
    input_args.edc{n,3} = round(sort(str2num(strrep(input_args.edc{n,3},':',' '))), 4);
    input_args.edc{n,4} = round(sort(str2num(strrep(input_args.edc{n,4},':',' '))), 4);
    input_args.edc{n,6} = round(sort(str2num(strrep(input_args.edc{n,6},':',' '))), 4);
end
% - MDC arguments
input_args.mdc = mdc_args;
input_args.mdc(any(cellfun(@isempty, input_args.mdc), 2),:) = [];
for n = 1:size(input_args.mdc, 1)
    input_args.mdc{n,1} = round(sort(str2num(strrep(input_args.mdc{n,1},':',' '))), 4);
    input_args.mdc{n,3} = round(sort(str2num(strrep(input_args.mdc{n,3},':',' '))), 4);
    input_args.mdc{n,4} = round(sort(str2num(strrep(input_args.mdc{n,4},':',' '))), 4);
    input_args.mdc{n,6} = round(sort(str2num(strrep(input_args.mdc{n,6},':',' '))), 4);
end
% - Total number of states to be fitted
input_args.nStates = min([...
    size(input_args.para, 1),...
    size(input_args.edc, 1),...
    size(input_args.mdc, 1)]);

%% 2 - Run the EDC fitting algorithm if required
if input_args.fit_type{1} == 1
    fitStr = edc_fitter(fitStr, input_args);
end
%% 3 - Run the MDC fitting algorithm if required
if input_args.fit_type{2} == 1
    fitStr = mdc_fitter(fitStr, input_args);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INTERNAL PLOT FUNCTIONS %%%%%%%%%%%%
% --- Constant, global formatting for the figures
function gca_properties(type)
% gca_properties(type)
%   This function outlines the consistent axes and figure
%   parameters to be used for the scan figures. The type reflects the type
%   of figure that is plotted.

%% Default parameters
if nargin < 1; type = 1; end
if isempty(type); type = 1;  end

%% 1 - Defining the consistent axes properties
ax = gca;
% Font properties
ax.FontName = 'Helvetica'; ax.FontWeight = 'normal'; ax.FontSize = 15;
% Tick properties
ax.TickLabelInterpreter = 'latex';
ax.XMinorTick = 'on'; ax.YMinorTick = 'on';
ax.TickDir = 'out';
ax.TickLength = [0.01 0.025];
ax.XColor = [0 0 0]; ax.YColor = [0 0 0];
% Box Styling properties
ax.LineWidth = 1.5;
ax.Box = 'off'; ax.Layer = 'Top';
%% 2 - Defining the figure properties
fig = gcf; fig.Color = [1 1 1]; fig.InvertHardcopy = 'off';
    
%% 3 - Defining other specific properties depending on type
% - For type 1 - scan slice figure (before ROI crop)
if type == 1
    % Figure size
    fig.Position = [1,1, 600, 600];
    % Ruler properties
    ax.XAxisLocation = 'bottom';            % 'bottom' | 'top' | 'origin'
    ax.YAxisLocation = 'left';                   % 'left' | 'right' | 'origin'
    % Background color
    ax.Color = [0, 0, 0];
    % Axis labels
    xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
    ylabel('$$ \bf  E_B (eV) $$', 'Interpreter', 'latex');
    % Axis limits
    xl = xlim; yl = ylim;
    axis([xl(1), xl(2), yl(1), yl(2)]);
    line([0 0], [-1e5, 1e5], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
    line([-1e5, 1e5], [0 0], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
    % Colorbar properties
    colormap hot; cb = colorbar; 
    % Colorbar font properties
    cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
    cb.TickLabelInterpreter = 'latex';
    cb.TickLength = 0.04; cb.TickDirection = 'out';
    % Colorbar position properties
    pos = get(cb, 'Position'); cb.Position = [1.08*pos(1) 7.5*pos(2) 0.03 0.1];
    % Colorbar box properties
    cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
    
% - For type 2 - scan slice figure (after ROI crop)
% - 2.1 - LHS figure of full ARPES scan
elseif type == 2.1
    % Figure size
    fig.Position = [1,1, 750, 450];
    % Ruler properties
    ax.XAxisLocation = 'bottom';            % 'bottom' | 'top' | 'origin'
    ax.YAxisLocation = 'left';                   % 'left' | 'right' | 'origin'
    % Background color
    ax.Color = [0, 0, 0];
    % Axis labels
    xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
    ylabel('$$ \bf  E_B (eV) $$', 'Interpreter', 'latex');
    % Axis limits
    xl = xlim; yl = ylim;
    axis([xl(1), xl(2), yl(1), yl(2)]);
    line([0 0], [-1e5, 1e5], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
    line([-1e5, 1e5], [0 0], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
    % Colorbar properties
    colormap hot; cb = colorbar; 
    % Colorbar font properties
    cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
    cb.TickLabelInterpreter = 'latex';
    cb.TickLength = 0.04; cb.TickDirection = 'out';
    % Colorbar position properties
    pos = get(cb, 'Position'); cb.Position = [1.12*pos(1) 7.6*pos(2) 0.02 0.1];
    % Colorbar box properties
    cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
% - 2.2 - RHS figure of ROI cropped ARPES scan
elseif type == 2.2
    % Ruler properties
    ax.XAxisLocation = 'bottom';            % 'bottom' | 'top' | 'origin'
    ax.YAxisLocation = 'right';                   % 'left' | 'right' | 'origin'
    % Background color
    ax.Color = [0, 0, 0];
    % Axis labels
    xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
    ylabel('$$ \bf  E_B (eV) $$', 'Interpreter', 'latex');
    % Axis limits
    xl = xlim; yl = ylim;
    axis([xl(1), xl(2), yl(1), yl(2)]);
    line([0 0], [-1e5, 1e5], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
    line([-1e5, 1e5], [0 0], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
    % Colorbar properties
    colormap hot; cb = colorbar; 
    % Colorbar font properties
    cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
    cb.TickLabelInterpreter = 'latex';
    cb.TickLength = 0.04; cb.TickDirection = 'out';
    % Colorbar position properties
    pos = get(cb, 'Position'); cb.Position = [1.09*pos(1) 7.6*pos(2) 0.02 0.1];
    % Colorbar box properties
    cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
    pbaspect([1,1,1]);

% - For type 3 - edc slice figure
% - 3.1 - LHS figure of ARPES scan
elseif type == 3.1
    % Figure size
    fig.Position = [1,1, 750, 450];
    % Ruler properties
    ax.XAxisLocation = 'bottom';            % 'bottom' | 'top' | 'origin'
    ax.YAxisLocation = 'left';                   % 'left' | 'right' | 'origin'
    % Background color
    ax.Color = [0, 0, 0];
    % Axis labels
    xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
    ylabel('$$ \bf  E_B (eV) $$', 'Interpreter', 'latex');
    % Axis limits
    xl = xlim; yl = ylim;
    axis([xl(1), xl(2), yl(1), yl(2)]);
    line([0 0], [-1e5, 1e5], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
    line([-1e5, 1e5], [0 0], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
    % Colorbar properties
    colormap hot; cb = colorbar; 
    % Colorbar font properties
    cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
    cb.TickLabelInterpreter = 'latex';
    cb.TickLength = 0.04; cb.TickDirection = 'out';
    % Colorbar position properties
    pos = get(cb, 'Position'); cb.Position = [0.06*pos(1) 7.6*pos(2) 0.02 0.1];
    % Colorbar box properties
    cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
% - 3.2 - RHS figure of edc cut
elseif type == 3.2
    % Ruler properties
    ax.XAxisLocation = 'bottom';            % 'bottom' | 'top' | 'origin'
    ax.YAxisLocation = 'right';                   % 'left' | 'right' | 'origin'
    % Background color
    ax.Color = [1, 1, 1];
    % Axis labels and limits
    xlabel('$$ \bf  Int. (arb.) $$', 'Interpreter', 'latex');
    ylabel('$$ \bf  E_B (eV) $$', 'Interpreter', 'latex');
    % Axis limits
    xl = xlim; yl = ylim;
    axis([xl(1), xl(2), yl(1), yl(2)]);
    line([0 0], [-1e5, 1e5], 'Color', [0 0 0 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
    line([-1e5, 1e5], [0 0], 'Color', [0 0 0 0.5], 'LineWidth', 0.75, 'Linestyle', '--');

% - For type 4 - mdc slice figure
% - 4.1 - LHS figure of ARPES scan
elseif type == 4.1
    % Figure size
    fig.Position = [1,1, 480, 700];
    % Ruler properties
    ax.XAxisLocation = 'bottom';            % 'bottom' | 'top' | 'origin'
    ax.YAxisLocation = 'left';                   % 'left' | 'right' | 'origin'
    % Background color
    ax.Color = [0, 0, 0];
    % Axis labels
    xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
    ylabel('$$ \bf  E_B (eV) $$', 'Interpreter', 'latex');
    % Axis limits
    xl = xlim; yl = ylim;
    axis([xl(1), xl(2), yl(1), yl(2)]);
    line([0 0], [-1e5, 1e5], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
    line([-1e5, 1e5], [0 0], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
    % Colorbar properties
    colormap hot; cb = colorbar; 
    % Colorbar font properties
    cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
    cb.TickLabelInterpreter = 'latex';
    cb.TickLength = 0.04; cb.TickDirection = 'out';
    % Colorbar position properties
    pos = get(cb, 'Position'); cb.Position = [1.11*pos(1) 5.*pos(2) 0.03 0.07];
    % Colorbar box properties
    cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
% - 4.2 - RHS figure of mdc cut
elseif type == 4.2
    % Ruler properties
    ax.XAxisLocation = 'bottom';            % 'bottom' | 'top' | 'origin'
    ax.YAxisLocation = 'left';                   % 'left' | 'right' | 'origin'
    % Background color
    ax.Color = [1, 1, 1];
    % Axis labels and limits
    xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
    ylabel('$$ \bf  Int. (arb.) $$', 'Interpreter', 'latex');
    % Axis limits
    xl = xlim; yl = ylim;
    axis([xl(1), xl(2), yl(1), yl(2)]);
    line([0 0], [-1e5, 1e5], 'Color', [0 0 0 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
    line([-1e5, 1e5], [0 0], 'Color', [0 0 0 0.5], 'LineWidth', 0.75, 'Linestyle', '--');

% - For type 5 - Summary of all fits
% - 5.1 - ROI ARPES image for a given scan
elseif type == 5.1
    % Figure size
    fig.Position = [1,1, 780, 420];
    % Ruler properties
    ax.XAxisLocation = 'bottom';            % 'bottom' | 'top' | 'origin'
    ax.YAxisLocation = 'left';                   % 'left' | 'right' | 'origin'
    % Background color
    ax.Color = [0, 0, 0];
    % Axis labels
    xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
    ylabel('$$ \bf  E_B (eV) $$', 'Interpreter', 'latex');
    % Axis limits
    xl = xlim; yl = ylim;
    axis([xl(1), xl(2), yl(1), yl(2)]);
    line([0 0], [-1e5, 1e5], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
    line([-1e5, 1e5], [0 0], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
    % Colorbar properties
    colormap hot; cb = colorbar; 
    % Colorbar font properties
    cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
    cb.TickLabelInterpreter = 'latex';
    cb.TickLength = 0.04; cb.TickDirection = 'out';
    % Colorbar position properties
    pos = get(cb, 'Position'); cb.Position = [0.07*pos(1) 7.6*pos(2) 0.02 0.1];
    % Colorbar box properties
    cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
% - 5.2 - Summary of all the fits performed
elseif type == 5.2
    % Ruler properties
    ax.XAxisLocation = 'bottom';            % 'bottom' | 'top' | 'origin'
    ax.YAxisLocation = 'left';                   % 'left' | 'right' | 'origin'
    % Background color
    ax.Color = [1, 1, 1];
    % Axis labels and limits
    xlabel('$$ \bf  Scan $$', 'Interpreter', 'latex');
    ylabel('$$ \bf  E_B (eV) $$', 'Interpreter', 'latex');
    % Axis limits
    xl = xlim; yl = ylim;
    axis([xl(1), xl(2), yl(1), yl(2)]);
    line([0 0], [-1e5, 1e5], 'Color', [0 0 0 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
    line([-1e5, 1e5], [0 0], 'Color', [0 0 0 0.5], 'LineWidth', 0.75, 'Linestyle', '--');

% - 5.3 - ROI ARPES image for a given scan
elseif type == 5.3
    
end

% --- Consistent formatting of the colors, markers and lines
function pp = plot_props()
% pp = plot_props()
%   This function outlines theconsistent colors, markers and lines to be
%   used when plotting the figures associated with all the state fitting
%   analysis.

%% - Initialising plot property structure
pp = struct();
%% General properties
pp.fontsize = 12;
%% 1 - Defining background and ROI properties
pp.roi.color = [0.1 0.1 0.6];
pp.roi.linestyle = '-';
pp.roi.linewidth = 2;
pp.back.color = [0.1 0.6 0.1];
pp.back.linestyle = '-';
pp.back.linewidth = 2;
pp.roipoly.color = [0.6, 0.1, 0.1];
pp.roipoly.linestyle = '-';
pp.roipoly.linewidth = 2;
%% 2 - Defining FDD properties
pp.fdd.color = [0, 0, 0];
pp.fdd.linestyle =':';
pp.fdd.linewidth =2;
%% 3 - Defining EDC properties
pp.edc.color = [0.2, 0.6, 0.2];
pp.edc.linestyle = '-';
pp.edc.linewidth = 1.5;
pp.edc.markerstyle = 's';
pp.edc.markersize = 5;
%% 4 - Defining MDC properties
pp.mdc.color = [0.2, 0.2, 0.8];
pp.mdc.linestyle = '-';
pp.mdc.linewidth = 1.5;
pp.mdc.markerstyle = '^';
pp.mdc.markersize = 5;
%% 5 - Defining fit properties
% - For the singlet fits
cols = [...
    0, 0.4470, 0.7410;...
    0.4660, 0.6740, 0.1880;...
    0.4940, 0.1840, 0.5560;...
    0.8500, 0.3250, 0.0980];
for i = 1:4
    pp.fit1.color{i} = cols(i,:);
end
pp.fit1.linestyle = '-';
pp.fit1.linewidth = 1.5;
pp.fit1.alpha = 0.55;
% - For the full functional fit
pp.fitn.color = [0, 0, 0];
pp.fitn.linestyle = '-';
pp.fitn.linewidth = 1.5;

% --- General function to view the ARPES scan
function fig = view_scan_fig(fitStr, scan_fig_args)
% fig = view_scan_fig(fitStr, scan_fig_args)
%   This function plots the 2D ARPES as a function of the scan parameter,
%   either before or after the ROI extraction is made.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_roi_fields(fitStr);
%   -   gca_properties(type)
%   -   pp = plot_props()
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   fitStr:                   data structure of the fitted ARPES data structure.
%   -   scan_fig_args:    1x1 cell array {scan index}
%
%   OUT:
%   -   figure output.

%% Loading in plot properties
pp = plot_props();
%% Initialising and extracting parameters
% - Extracting the scan index to be plotted
scan_indx = scan_fig_args{1}(1);
% - Extracting the fields to be used with most recent processing
[xField, yField, ~, dField] = find_roi_fields(fitStr);
%% Plotting the figure
fig = figure();

% 1 - Plotting the ARPES data before ROI extraction
if string(xField) ~= "kx_roi"
    set(gcf, 'Name', 'State fitting: Scan figure');
    ImData(fitStr.(xField)(:,:,scan_indx), fitStr.(yField)(:,:,scan_indx), fitStr.(dField)(:,:,scan_indx));
    gca_properties(1);
    title(string(fitStr.matfile) + " - scan " + string(scan_indx), 'interpreter', 'none', 'fontsize', pp.fontsize);
    
% 2 - Plotting the ARPES data after ROI extraction
else
    set(gcf, 'Name', 'State fitting: Scan figure');
    % - Plot the full ARPES data
    subplot(1,3,1:2);
    ImData(fitStr.kx(:,:,scan_indx), fitStr.eb(:,:,scan_indx), fitStr.data(:,:,scan_indx));
    hold on;
    gca_properties(2.1);
    title(string(fitStr.matfile) + " - scan " + string(scan_indx), 'interpreter', 'none', 'fontsize', pp.fontsize);
    % - ROI patch
    plot([min(fitStr.kx_roi(:)), min(fitStr.kx_roi(:)),...
        max(fitStr.kx_roi(:)), max(fitStr.kx_roi(:)),...
        min(fitStr.kx_roi(:))],...
        [min(fitStr.eb_roi(:)), max(fitStr.eb_roi(:)),...
        max(fitStr.eb_roi(:)), min(fitStr.eb_roi(:)),...
        min(fitStr.eb_roi(:))],...
         'linestyle', pp.roi.linestyle, 'linewidth', pp.roi.linewidth, 'color', pp.roi.color);
    % - Plot the ROI ARPES data
    subplot(1,3,3);
    ImData(fitStr.(xField)(:,:,scan_indx), fitStr.(yField)(:,:,scan_indx), fitStr.(dField)(:,:,scan_indx));
    gca_properties(2.2);
end

% --- Function to browse through the EDCs of the ROI
function fig = view_edc_fig(fitStr, scan_fig_args, edc_fig_args, mdc_fig_args)
%  fig = view_edc_fig(fitStr, scan_fig_args, edc_fig_args, edc_fig_args)
%   This function plots an EDC cut within the ROI about some
%   cut whose index is defined by the user. There is also the 
%   possibility to plot the outcome of the fitting algorithm
%   too, which will show all of the fits made to the states.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_roi_fields(fitStr);
%   -   gca_properties(type)
%   -   pp = plot_props()
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   fitStr:                    data structure of the fitted ARPES data.
%   -   scan_fig_args:    1x1 cell array {scan index}
%   -   edc_fig_args:      1x3 cell array {edc index, edc window, show edc fits, show fdd}
%   -   mdc_fig_args:    1x2 cell array {mdc index, show mdc fits}
%
%   OUT:
%   -   figure output.

%% Loading in plot properties
pp = plot_props();
%% Initialising and extracting parameters
% - Scan parameters
scan_indx = scan_fig_args{1}(1);
scan_val = scan_fig_args{1}(2);
% - edc parameters
edc_indx = edc_fig_args{1}(1);
edc_val = edc_fig_args{1}(2);
edc_win = edc_fig_args{2};
edc_fits = edc_fig_args{3};
edc_fdd = edc_fig_args{4};
edcWindow = [edc_val-0.5*edc_win, edc_val+0.5*edc_win];
% - mdc parameters
mdc_indx = mdc_fig_args{1}(1);
mdc_val = mdc_fig_args{1}(2);
mdc_win = mdc_fig_args{2};
mdc_fits = mdc_fig_args{3};

%% 1 - Extracting the EDC cut
% - Extracting the fields to be used with most recent processing
[xField, yField, ~, dField] = find_roi_fields(fitStr);
% - Extracting the EDC curve
[XCut, DCut] = Cut(fitStr.(xField)(:,:,scan_indx), fitStr.(yField)(:,:,scan_indx), fitStr.(dField)(:,:,scan_indx), 'edc', edcWindow);

%% 2 - Initialising a new figure
fig = figure();  set(gcf, 'Name', 'State fitting: EDC figure');

%% 3.0 - Plotting the ARPES image
subplot(1,3,1:2); hold on;
ImData(fitStr.(xField)(:,:,scan_indx), fitStr.(yField)(:,:,scan_indx), fitStr.(dField)(:,:,scan_indx));
% - Plot the EDC integration window
fill([edcWindow(1), edcWindow(1),...
    edcWindow(2), edcWindow(2),...
    edcWindow(1)],...
    [-1e5, 1e5, 1e5, -1e5, -1e5], pp.edc.color,...
    'linewidth', pp.edc.linewidth, 'edgecolor', 'none', 'facealpha', 0.3);
% - Plot the EDC extraction line
line([edc_val, edc_val], [-1e5, 1e5], 'color', pp.edc.color, 'Linestyle', pp.edc.linestyle, 'LineWidth', pp.edc.linewidth);
% - Formatting the figure
gca_properties(3.1);
title_str = string(fitStr.matfile) + " - scan " + string(scan_indx) + " - kWin: " + string(round(edcWindow(1),4)) + ":" + string(round(edcWindow(2),4));
title(title_str, 'interpreter', 'none', 'fontsize', pp.fontsize);
axis([min(min(fitStr.(xField)(:,:,scan_indx))), max(max(fitStr.(xField)(:,:,scan_indx))),...
    min(min(fitStr.(yField)(:,:,scan_indx))), max(max(fitStr.(yField)(:,:,scan_indx)))]);
%% 3.1 - Plotting the EDC k- and eb-points
if isfield(fitStr, 'edc_fits')
    if edc_fits == 1
        if ~isempty(fitStr.edc_fits{scan_indx})
            for n = 1:fitStr.edc_fits{scan_indx}.in.nStates
                % - Plotting the best fit data-points
                plot(fitStr.edc_fits{scan_indx}.out.kx_pts{n}, fitStr.edc_fits{scan_indx}.out.eb_pts{n}, 'x', ...
                    'marker', pp.edc.markerstyle, 'markersize', pp.edc.markersize, 'color', pp.fit1.color{n});
                % - Plotting the best fit parabola
                xx = linspace(-8, 8, 5e3);
                fit_params = fitStr.edc_fits{scan_indx}.out.beta_para{n};
                plot(xx, fitStr.edc_fits{scan_indx}.out.fpara(fit_params, xx), '-',...
                    'color', pp.fit1.color{n}, 'linewidth', pp.fit1.linewidth, 'linestyle', pp.fit1.linestyle);
            end
        end
    end
end
%% 3.2 - Plotting the MDC k- and eb-points
if isfield(fitStr, 'mdc_fits')
    if mdc_fits == 1
        if ~isempty(fitStr.mdc_fits{scan_indx})
            for n = 1:fitStr.mdc_fits{scan_indx}.in.nStates
                % - Plotting the best fit data-points
                plot(fitStr.mdc_fits{scan_indx}.out.kx_pts{n}, fitStr.mdc_fits{scan_indx}.out.eb_pts{n}, 'x', ...
                    'marker', pp.mdc.markerstyle, 'markersize', pp.mdc.markersize, 'color', pp.fit1.color{n});
                % - Plotting the best fit parabola
                xx = linspace(-8, 8, 5e3);
                fit_params = fitStr.mdc_fits{scan_indx}.out.beta_para{n};
                plot(xx, fitStr.mdc_fits{scan_indx}.out.fpara(fit_params, xx), '-',...
                    'color', pp.fit1.color{n}, 'linewidth', pp.fit1.linewidth, 'linestyle', pp.fit1.linestyle);
            end
        end
    end
end

%% 4.0 - Plotting the EDC singlet fits if required
subplot(1,3,3); hold on;
if isfield(fitStr, 'edc_fits')
    if ~isempty(fitStr.edc_fits{scan_indx})
        if edc_fits == 1 && edc_indx >= fitStr.edc_fits{scan_indx}.out.fit_indxs(1) && edc_indx <= fitStr.edc_fits{scan_indx}.out.fit_indxs(2)
            % - Initialising the variables
            edc_fit_indx = edc_indx - fitStr.edc_fits{scan_indx}.out.fit_indxs(1) + 1;
            xx = linspace(-8, 8, 5e3)';
            % - Extracting the fit parameters
            fit_params = fitStr.edc_fits{scan_indx}.out.beta_edc{edc_fit_indx};
            % - Plotting the single fits
            for n = 1:fitStr.edc_fits{scan_indx}.in.nStates
                args = [fit_params(4*n-3), fit_params(4*n-2), fit_params(4*n-1), fit_params(4*n)];
                yy_fdd_f1 = fitStr.edc_fits{scan_indx}.out.fdd_f1(args, xx);
                yy_f1 = fitStr.edc_fits{scan_indx}.out.f1(args, xx);
                % - Plotting the fit
                if fitStr.edc_fits{scan_indx}.in.edc{n, 5} == 1
                    fill(yy_f1, xx, pp.fit1.color{n}, 'facealpha', 0.5*pp.fit1.alpha, 'edgecolor', 'none');
                    fill(yy_fdd_f1, xx, pp.fit1.color{n}, 'facealpha', pp.fit1.alpha);
                else
                    fill(yy_f1, xx, pp.fit1.color{n}, 'facealpha', pp.fit1.alpha);
                end
            end
        end
    end
end
%% 4.1 - EDC cut through the data at a given scan index
plot(DCut, XCut, 'k-', 'marker', pp.edc.markerstyle, 'markersize', pp.edc.markersize, 'color', pp.edc.color,...
    'Linestyle', pp.edc.linestyle, 'LineWidth', pp.edc.linewidth);
gca_properties(3.2);
axis([0, 1.1*max(DCut(:)), min(XCut(:)), max(XCut(:))]);
%% 4.2 - Plotting the EDC full fits if required
if isfield(fitStr, 'edc_fits')
    if ~isempty(fitStr.edc_fits{scan_indx})
        if edc_fits == 1 && edc_indx >= fitStr.edc_fits{scan_indx}.out.fit_indxs(1) && edc_indx <= fitStr.edc_fits{scan_indx}.out.fit_indxs(2)
            % - Initialising the variables
            edc_fit_indx = edc_indx - fitStr.edc_fits{scan_indx}.out.fit_indxs(1) + 1;
            xx = linspace(-8, 8, 5e3)';
            % - Extracting the fit
            fit_params = fitStr.edc_fits{scan_indx}.out.beta_edc{edc_fit_indx};
            yy = fitStr.edc_fits{scan_indx}.out.fn(fit_params, xx);
            % - Plotting the fit
            plot(yy, xx, '-', 'color', pp.fitn.color, 'linestyle', pp.fitn.linestyle, 'linewidth', pp.fitn.linewidth);
        end
    end
end
%% 4.3 - Plotting the Fermi-Dirac Distribution if required
if edc_fdd == 1
    plot(fitStr.fdd.y_conv, fitStr.fdd.eb, 'color', pp.fdd.color, 'linestyle', pp.fdd.linestyle, 'linewidth', pp.fdd.linewidth);
end

% --- Function to browse through the MDCs of the ROI
function fig = view_mdc_fig(fitStr, scan_fig_args, edc_fig_args, mdc_fig_args)
% fig = view_mdc_fig(fitStr, scan_fig_args, mdc_fig_args)
%   This function plots an MDC cut within the ROI about some
%   cut whose index is defined by the user. There is also the 
%   possibility to plot the outcome of the fitting algorithm
%   too, which will show all of the fits made to the states.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_roi_fields(fitStr);
%   -   gca_properties(type)
%   -   pp = plot_props()
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   fitStr:                    data structure of the fitted ARPES data.
%   -   scan_fig_args:    1x1 cell array {scan index}
%   -   edc_fig_args:      1x3 cell array {edc index, edc window, show edc fits, show fdd}
%   -   mdc_fig_args:    1x2 cell array {mdc index, show mdc fits}
%
%   OUT:
%   -   figure output.

%% Loading in plot properties
pp = plot_props();
%% Initialising and extracting parameters
% - Scan parameters
scan_indx = scan_fig_args{1}(1);
scan_val = scan_fig_args{1}(2);
% - edc parameters
edc_indx = edc_fig_args{1}(1);
edc_val = edc_fig_args{1}(2);
edc_win = edc_fig_args{2};
edc_fits = edc_fig_args{3};
edc_fdd = edc_fig_args{4};
% - mdc parameters
mdc_indx = mdc_fig_args{1}(1);
mdc_val = mdc_fig_args{1}(2);
mdc_win = mdc_fig_args{2};
mdc_fits = mdc_fig_args{3};
mdcWindow = [mdc_val-0.5*mdc_win, mdc_val+0.5*mdc_win];

%% 1 - Extracting the MDC cut
% - Extracting the fields to be used with most recent processing
[xField, yField, ~, dField] = find_roi_fields(fitStr);
% - Extracting the MDC curve
[XCut, DCut] = Cut(fitStr.(xField)(:,:,scan_indx), fitStr.(yField)(:,:,scan_indx), fitStr.(dField)(:,:,scan_indx), 'mdc', mdcWindow);

%% 2 - Initialising a new figure
fig = figure();  set(gcf, 'Name', 'State fitting: MDC figure');

%% 3.0 - Plotting the ARPES image
subplot(3,1,2:3); hold on;
ImData(fitStr.(xField)(:,:,scan_indx), fitStr.(yField)(:,:,scan_indx), fitStr.(dField)(:,:,scan_indx));
% - Plot the MDC integration window
fill([-1e5, 1e5, 1e5, -1e5, -1e5],...
    [mdcWindow(1), mdcWindow(1),...
    mdcWindow(2), mdcWindow(2),...
    mdcWindow(1)], pp.mdc.color,...
    'linewidth', pp.mdc.linewidth, 'edgecolor', 'none', 'facealpha', 0.3);
% - Plot the MDC extraction line
line([-1e5, 1e5], [mdc_val, mdc_val], 'color', pp.mdc.color, 'Linestyle', pp.mdc.linestyle, 'LineWidth', pp.mdc.linewidth);
% - Formatting the figure
gca_properties(4.1);
axis([min(min(fitStr.(xField)(:,:,scan_indx))), max(max(fitStr.(xField)(:,:,scan_indx))),...
    min(min(fitStr.(yField)(:,:,scan_indx))), max(max(fitStr.(yField)(:,:,scan_indx)))]);
%% 3.1 - Plotting the EDC k- and eb-points
if isfield(fitStr, 'edc_fits')
    if edc_fits == 1
        if ~isempty(fitStr.edc_fits{scan_indx})
            for n = 1:fitStr.edc_fits{scan_indx}.in.nStates
                % - Plotting the best fit data-points
                plot(fitStr.edc_fits{scan_indx}.out.kx_pts{n}, fitStr.edc_fits{scan_indx}.out.eb_pts{n}, 'x', ...
                    'marker', pp.edc.markerstyle, 'markersize', pp.edc.markersize, 'color', pp.fit1.color{n});
                % - Plotting the best fit parabola
                xx = linspace(-8, 8, 5e3);
                fit_params = fitStr.edc_fits{scan_indx}.out.beta_para{n};
                plot(xx, fitStr.edc_fits{scan_indx}.out.fpara(fit_params, xx), '-',...
                    'color', pp.fit1.color{n}, 'linewidth', pp.fit1.linewidth, 'linestyle', pp.fit1.linestyle);
            end
        end
    end
end
%% 3.2 - Plotting the MDC k- and eb-points
if isfield(fitStr, 'mdc_fits')
    if mdc_fits == 1
        if ~isempty(fitStr.mdc_fits{scan_indx})
            for n = 1:fitStr.mdc_fits{scan_indx}.in.nStates
                % - Plotting the best fit data-points
                plot(fitStr.mdc_fits{scan_indx}.out.kx_pts{n}, fitStr.mdc_fits{scan_indx}.out.eb_pts{n}, 'x', ...
                    'marker', pp.mdc.markerstyle, 'markersize', pp.mdc.markersize, 'color', pp.fit1.color{n});
                % - Plotting the best fit parabola
                xx = linspace(-8, 8, 5e3);
                fit_params = fitStr.mdc_fits{scan_indx}.out.beta_para{n};
                plot(xx, fitStr.mdc_fits{scan_indx}.out.fpara(fit_params, xx), '-',...
                    'color', pp.fit1.color{n}, 'linewidth', pp.fit1.linewidth, 'linestyle', pp.fit1.linestyle);
            end
        end
    end
end

%% 4.0 - Plotting the MDC singlet fits if required
subplot(3,1,1); hold on;
if isfield(fitStr, 'mdc_fits')
    if ~isempty(fitStr.mdc_fits{scan_indx})
        if mdc_fits == 1 && mdc_indx >= fitStr.mdc_fits{scan_indx}.out.fit_indxs(1) && mdc_indx <= fitStr.mdc_fits{scan_indx}.out.fit_indxs(2)
            % - Initialising the variables
            mdc_fit_indx = mdc_indx - fitStr.mdc_fits{scan_indx}.out.fit_indxs(1) + 1;
            xx = linspace(-8, 8, 5e3)';
            % - Extracting the fit parameters
            fit_params = fitStr.mdc_fits{scan_indx}.out.beta_mdc{mdc_fit_indx};
            % - Plotting the single fits
            for n = 1:fitStr.mdc_fits{scan_indx}.in.nStates
                if fitStr.mdc_fits{scan_indx}.in.mdc{n, 5} == 1
                    args1 = [fit_params(5*n-4), fit_params(5*n-3), fit_params(5*n-2), fit_params(5*n)];
                    args2 = [fit_params(5*n-4), fit_params(5*n-3), fit_params(5*n-1), fit_params(5*n)];
                    yy_f1 = fitStr.mdc_fits{scan_indx}.out.f1(args1, xx);
                    yy_f2 = fitStr.mdc_fits{scan_indx}.out.f1(args2, xx);
                    fill(xx, yy_f1, pp.fit1.color{n}, 'facealpha', pp.fit1.alpha);
                    fill(xx, yy_f2, pp.fit1.color{n}, 'facealpha', pp.fit1.alpha);
                else
                    args1 = [fit_params(6*n-5), fit_params(6*n-3), fit_params(6*n-2), fit_params(6*n)];
                    args2 = [fit_params(6*n-4), fit_params(6*n-3), fit_params(6*n-1), fit_params(6*n)];
                    yy_f1 = fitStr.mdc_fits{scan_indx}.out.f1(args1, xx);
                    yy_f2 = fitStr.mdc_fits{scan_indx}.out.f1(args2, xx);
                    fill(xx, yy_f1, pp.fit1.color{n}, 'facealpha', pp.fit1.alpha);
                    fill(xx, yy_f2, pp.fit1.color{n}, 'facealpha', pp.fit1.alpha);
                end
            end
        end
    end
end
%% 4.1 - MDC cut through the data at a given scan index
plot(XCut, DCut, 'k-', 'marker', pp.mdc.markerstyle, 'markersize', pp.mdc.markersize, 'color', pp.mdc.color,...
    'Linestyle', pp.mdc.linestyle, 'LineWidth', pp.mdc.linewidth);
gca_properties(4.2);
axis([min(XCut(:)), max(XCut(:)), 0, 1.1*max(DCut(:))]);
title_str = string(fitStr.matfile) + " - scan " + string(scan_indx) + " - ebWin: " + string(round(mdc_val-0.5*mdc_win, 4)) + ":" + string(round(mdc_val+0.5*mdc_win,4));
title(title_str, 'interpreter', 'none', 'fontsize', pp.fontsize);

%% 4.2 - Plotting the MDC full fits if required
if isfield(fitStr, 'mdc_fits')
    if ~isempty(fitStr.mdc_fits{scan_indx})
        if mdc_fits == 1 && mdc_indx >= fitStr.mdc_fits{scan_indx}.out.fit_indxs(1) && mdc_indx <= fitStr.mdc_fits{scan_indx}.out.fit_indxs(2)
            % - Initialising the variables
            mdc_fit_indx = mdc_indx - fitStr.mdc_fits{scan_indx}.out.fit_indxs(1) + 1;
            xx = linspace(-8, 8, 5e3)';
            % - Extracting the fit
            fit_params = fitStr.mdc_fits{scan_indx}.out.beta_mdc{mdc_fit_indx};
            yy = fitStr.mdc_fits{scan_indx}.out.fn(fit_params, xx);
            % - Plotting the fit
            plot(xx, yy, '-', 'color', pp.fitn.color, 'linestyle', pp.fitn.linestyle, 'linewidth', pp.fitn.linewidth);
        end
    end
end

% --- Function to observe the cropped ROI and backgroudn region
function fig = view_crop_roi(fitStr, scan_fig_args, crop_roi_args, crop_back_args)

%% Loading in plot properties
pp = plot_props();
%% Initialising and extracting parameters
scan_indx = scan_fig_args{1}(1);
scan_val = scan_fig_args{1}(2);
%% 1 - View the ROI and background areas that were cropped
fig = figure(); set(fig, 'Name', 'State fitting: Crop ROI figure');
ImData(fitStr.kx(:,:,scan_fig_args{1}(1)), fitStr.eb(:,:,scan_fig_args{1}(1)), fitStr.data(:,:,scan_fig_args{1}(1)));
hold on; 
gca_properties(1);
title(string(fitStr.matfile) + " - scan " + string(scan_indx), 'interpreter', 'none', 'fontsize', pp.fontsize);
%% 2 - Plot patches of color representing the ROI and background
% - ROI patch and label
patch([crop_roi_args{1}(1), crop_roi_args{1}(1),...
    crop_roi_args{1}(2), crop_roi_args{1}(2),...
    crop_roi_args{1}(1)],...
    [crop_roi_args{2}(1), crop_roi_args{2}(2),...
    crop_roi_args{2}(2), crop_roi_args{2}(1),...
    crop_roi_args{2}(1)],...
    pp.roi.color, 'linewidth', pp.roi.linewidth, 'facealpha', 0.25, 'edgecolor', pp.roi.color);
text(mean(crop_roi_args{1}), mean(crop_roi_args{2}), 'ROI',...
    'Fontsize', 13, 'Fontweight', 'bold', 'HorizontalAlignment', 'center', 'color', pp.roi.color);
% - Background patch and label
patch([crop_back_args{1}(1), crop_back_args{1}(1),...
    crop_back_args{1}(2), crop_back_args{1}(2),...
    crop_back_args{1}(1)],...
    [crop_back_args{2}(1), crop_back_args{2}(2),...
    crop_back_args{2}(2), crop_back_args{2}(1),...
    crop_back_args{2}(1)],...
    pp.back.color, 'linewidth', pp.back.linewidth, 'facealpha', 0.25, 'edgecolor', pp.back.color);
text(mean(crop_back_args{1}), mean(crop_back_args{2}),...
    'Background', 'Fontsize', 13, 'Fontweight', 'bold', 'HorizontalAlignment', 'center', 'color', pp.back.color);

% --- Function to view the Background Subtraction summary figure
function view_background_subtraction(fitStr, scan_fig_args)
% view_background_subtraction(fitStr)
%   This function plots a summary figure of the background
%   subtraction that is performed.
%
%   REQ. FUNCTIONS:
%   -   gca_properties(type)
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   fitStr:          data structure of the fitted ARPES data.
%   -   scan_fig_args:    1x1 cell array {scan index}
%
%   OUT:
%   -   figure output.

%% Loading in plot properties
pp = plot_props();
%% Initialising and extracting parameters
scan_indx = scan_fig_args{1}(1);
% - Extracting color constants to be used
col_roi = pp.roi.color.*gray(size(fitStr.Meta.bsub.roi_prior, 2));
col_back = pp.back.color.*gray(size(fitStr.Meta.bsub.back_prior, 2));
% Defining the figure object
fig_title = "State fitting: Back. Sub. - scan " + string(scan_indx);
fig = figure(); set(fig, 'Name', char(fig_title));

%% - 1 - Plotting the pre-background subtracted background data
subplot(221); hold on;
% Plotting the ARPES image
ImData(fitStr.Meta.kx_back(:,:,scan_indx), fitStr.Meta.eb_back(:,:,scan_indx), fitStr.Meta.bsub.back_prior(:,:,scan_indx));
% Formatting the ARPES image
xticks(round(-1e3:0.2:1e3, 2)); yticks(round(-1e3:0.1:1e3, 2));
minC = min(fitStr.Meta.bsub.back_prior(:)); maxC = max(fitStr.Meta.bsub.back_prior(:));
caxis([minC, maxC]); axis([min(fitStr.Meta.kx_back(:)), max(fitStr.Meta.kx_back(:)), min(fitStr.Meta.eb_back(:)), max(fitStr.Meta.eb_back(:))]);
gca_properties(1); colorbar('off');
title(' \bf Background; pre-subtraction', 'interpreter', 'latex', 'fontsize', pp.fontsize);
% On a new axis, plot all the line profiles
ax1 = axes('Position',[.31 .61 .15 .10]); hold on;
ax1.XColor = [0 0 0]; ax1.YColor = [0 0 0];
ax1.XAxisLocation = 'bottom';
ax1.YAxisLocation = 'left';
ylabel(''); yticks([]);
for i = 1:size(col_back, 1)
    plot(fitStr.Meta.eb_back(:,i,scan_indx), fitStr.Meta.bsub.back_prior(:,i,scan_indx), '.', 'color', col_back(i,:), 'markersize', 4);
end
plot(fitStr.Meta.eb_back(:,:,scan_indx), fitStr.Meta.bsub.back_polyfit(:,:,scan_indx), 'k-',...
    'color', pp.roipoly.color, 'linestyle', pp.roipoly.linestyle, 'linewidth', pp.roipoly.linewidth);
axis([min(fitStr.Meta.eb_back(:)), max(fitStr.Meta.eb_back(:)), min(fitStr.Meta.bsub.back_prior(:)), max(fitStr.Meta.bsub.back_prior(:))]);

%% - 2 - Plotting the pre-background subtracted ROI data
subplot(222); hold on;
% Plotting the ARPES image
ImData(fitStr.kx_roi(:,:,scan_indx), fitStr.eb_roi(:,:,scan_indx), fitStr.Meta.bsub.roi_prior(:,:,scan_indx));
% Formatting the ARPES image
xticks(round(-15:0.2:15, 2)); yticks(round(-1e3:0.1:1e3, 2));
minC = min(fitStr.Meta.bsub.roi_prior(:)); maxC = max(fitStr.Meta.bsub.roi_prior(:));
caxis([minC, maxC]); axis([min(fitStr.kx_roi(:)), max(fitStr.kx_roi(:)), min(fitStr.eb_roi(:)), max(fitStr.eb_roi(:))]);
gca_properties(1); colorbar('off');
title(' \bf ROI; pre-subtraction', 'interpreter', 'latex', 'fontsize', pp.fontsize);
% On a new axis, plot all the line profiles
ax2 = axes('Position',[.752 .61 .15 .1]); hold on;
ax2.XColor = [1 1 1]; ax2.YColor = [1 1 1];
ax2.XAxisLocation = 'bottom';
ax2.YAxisLocation = 'right';
ylabel(''); yticks([]);
for i = 1:size(col_roi, 1)
    plot(fitStr.eb_roi(:,i,scan_indx), fitStr.Meta.bsub.roi_prior(:,i,scan_indx), '.', 'color', col_roi(i,:), 'markersize', 4);
end
plot(fitStr.eb_roi(:,:,scan_indx), fitStr.Meta.bsub.roi_polyfit(:,:,scan_indx), 'k-',...
    'color', pp.roipoly.color, 'linestyle', pp.roipoly.linestyle, 'linewidth', pp.roipoly.linewidth);
axis([min(fitStr.eb_roi(:)), max(fitStr.eb_roi(:)), min(fitStr.Meta.bsub.roi_prior(:)), max(fitStr.Meta.bsub.roi_prior(:))]);

%% - 3 - Plotting the post-background subtracted background data
subplot(223); hold on;
% Plotting the ARPES image
ImData(fitStr.Meta.kx_back(:,:,scan_indx), fitStr.Meta.eb_back(:,:,scan_indx), fitStr.Meta.data_back(:,:,scan_indx));
% Formatting the ARPES image
xticks(round(-15:0.2:15, 2)); yticks(round(-1e3:0.1:1e3, 2));
minC = min(fitStr.Meta.bsub.back_post(:)); maxC = max(fitStr.Meta.bsub.back_post(:));
caxis([minC, maxC]); axis([min(fitStr.Meta.kx_back(:)), max(fitStr.Meta.kx_back(:)), min(fitStr.Meta.eb_back(:)), max(fitStr.Meta.eb_back(:))]);
gca_properties(1); colorbar('off');
title(' \bf Background; post-subtraction', 'interpreter', 'latex', 'fontsize', pp.fontsize);
% Colorbar properties
colormap hot; cb = colorbar; 
cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
cb.TickLabelInterpreter = 'latex';
cb.TickLength = 0.04; cb.TickDirection = 'out';
cb.YAxisLocation = 'right';
pos = get(cb, 'Position'); cb.Position = [0.11*pos(1) 0.75*pos(2) 0.02 0.1];
cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
% On a new axis, plot all the line profiles
ax3 = axes('Position',[.31 .14 .15 .1]); hold on;
ax3.XColor = [0 0 0]; ax3.YColor = [0 0 0];
ax3.XAxisLocation = 'bottom';
ax3.YAxisLocation = 'right';
ylabel(''); yticks([]);
for i = 1:size(col_back, 1)
    plot(fitStr.Meta.eb_back(:,i,scan_indx), fitStr.Meta.bsub.back_post(:,i,scan_indx), '.', 'color', col_back(i,:), 'markersize', 4);
end
axis([min(fitStr.Meta.eb_back(:)), max(fitStr.Meta.eb_back(:)), min(fitStr.Meta.bsub.back_post(:)), max(fitStr.Meta.bsub.back_post(:))]);

%% - 4 - Plotting the post-background subtracted ROI data
subplot(224); hold on;
% Plotting the ARPES image
ImData(fitStr.kx_roi(:,:,scan_indx), fitStr.eb_roi(:,:,scan_indx), fitStr.data_roi(:,:,scan_indx));
% Formatting the ARPES image
xticks(round(-15:0.2:15, 2)); yticks(round(-1e3:0.1:1e3, 2));
minC = min(fitStr.Meta.bsub.roi_post(:)); maxC = max(fitStr.Meta.bsub.roi_post(:));
caxis([minC, maxC]); axis([min(fitStr.kx_roi(:)), max(fitStr.kx_roi(:)), min(fitStr.eb_roi(:)), max(fitStr.eb_roi(:))]);
gca_properties(1); colorbar('off');
title(' \bf ROI; post-subtraction', 'interpreter', 'latex', 'fontsize', pp.fontsize);
% Colorbar properties
colormap hot; cb = colorbar; 
% Colorbar font properties
cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
% Colorbar tick properties
cb.TickLabelInterpreter = 'latex';
cb.TickLength = 0.04; cb.TickDirection = 'out';
cb.YAxisLocation = 'right';
% Colorbar position properties
pos = get(cb, 'Position'); cb.Position = [1.08*pos(1) 0.75*pos(2) 0.02 0.1];
% Colorbar box properties
cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
% On a new axis, plot all the line profiles
ax4 = axes('Position',[.752 .14 .15 .1]); hold on;
ax4.XColor = [1 1 1]; ax4.YColor = [1 1 1];
ax4.XAxisLocation = 'bottom';
ax4.YAxisLocation = 'right';
ylabel(''); yticks([]);
for i = 1:size(col_roi, 1)
    plot(fitStr.eb_roi(:,i,scan_indx), fitStr.Meta.bsub.roi_post(:,i,scan_indx), '.', 'color', col_roi(i,:), 'markersize', 4);
end
axis([min(fitStr.eb_roi(:)), max(fitStr.eb_roi(:)), min(fitStr.Meta.bsub.roi_post(:)), max(fitStr.Meta.bsub.roi_post(:))]);
% Resetting the size of the figure
set(fig, 'Position', [100, 100, 800, 600]);

% --- Function to view the Fermi-Dirac Distribution
function view_fdd(fitStr)
% view_fdd(fitStr)
%   This function plots the Fermi-Diract distribution of the ARPES
%   data and the resulting Fermi-Diract Distribution that is
%   convolvuted with the analyser resolution to give an intrinsic broadening.
%
%   REQ. FUNCTIONS: none.
%
%   IN:
%   -   fitStr:          data structure of the fitted ARPES data.
%
%   OUT:
%   -   figure output.

%% Loading in plot properties
pp = plot_props();
%% - Initialising the figure
figure(); set(gcf, 'Name', 'FDD with ARPES spectral broadening'); hold on;
%% - 1 - Plotting the Fermi-level analysis
plot(fitStr.fdd.eb, fitStr.fdd.y_fermi, 'k--', 'linewidth', pp.fdd.linewidth);
%% 2 - Plotting the Gaussian of the beam/analyser resolution
plot(fitStr.fdd.eb, fitStr.fdd.y_gauss, 'k:', 'linewidth', pp.fdd.linewidth);
%% 3 - Plotting the expected Fermi function with broadening
plot(fitStr.fdd.eb, fitStr.fdd.y_conv, 'k-', 'linewidth', pp.fdd.linewidth);
%% 4.0 - Defining the axes properties
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
xlabel('$$ \bf  E_B - E_F (eV) $$', 'Interpreter', 'latex');
ylabel('$$ \bf  Intensity (arb.) $$', 'Interpreter', 'latex');
axis([-0.4, 0.4, -0.01, 1.01]);
%% 4.1 - Defining the figure properties
fig = gcf; fig.Color = [1 1 1]; fig.InvertHardcopy = 'off';
%% 4.2 - Adding a legend
fermi_label = sprintf('FDD (T=%.2f K)', fitStr.fdd.args{1});
gauss_label = sprintf('Gaussian (FWHM=%.2f meV)', fitStr.fdd.args{3});
fermiconv_label = sprintf('FDD convolved with Gaussian');
legend({fermi_label, gauss_label, fermiconv_label}, 'Fontsize', 10);

% --- Function to view the parabolic dispersions
function view_para(fitStr, scan_fig_args)
% view_parabola(fitStr)
%   This function plots the estimated parabolic dispersion trail.
%
%   REQ. FUNCTIONS: none.
%
%   IN:
%   -   fitStr:          data structure of the fitted ARPES data.
%
%   OUT:
%   -   figure output.

%% Loading in plot properties
pp = plot_props();
%% Initialising and extracting parameters
scan_indx = scan_fig_args{1}(1);
figure(); set(gcf, 'Name', 'State fitting: Approx. Parabolic dispersion');
%% 1 - Image of the region of interest
ImData(fitStr.kx_roi(:,:,scan_indx), fitStr.eb_roi(:,:,scan_indx), fitStr.data_roi(:,:,scan_indx)); hold on;
gca_properties(1);
title(string(fitStr.matfile), 'interpreter', 'none', 'fontsize', 12);
%% 2 - Plotting the parabolic dispersions
h = zeros(size(fitStr.para.kx,2), 1);
for i = 1:size(fitStr.para.kx,2)
    errorbar(fitStr.para.kx{i}, fitStr.para.eb{i},...
        ones(size(fitStr.para.eb{i}))*fitStr.para.args{i,4}, ones(size(fitStr.para.eb{i}))*fitStr.para.args{i,4},...
        ones(size(fitStr.para.kx{i}))*fitStr.para.args{i,2}, ones(size(fitStr.para.kx{i}))*fitStr.para.args{i,2},...
        '.-', 'Color', pp.fit1.color{i}, 'linewidth', pp.fit1.linewidth);
    labels{i} = sprintf('Eb(k) %i; k0=%.4f, eb0=%.4f, m*=%.4f',...
        i, fitStr.para.args{i,1}, fitStr.para.args{i,3},...
        fitStr.para.args{i,5});
    h(i) = errorbar(NaN,NaN,'-', 'Color', pp.fit1.color{i},...
        'linewidth', pp.fit1.linewidth);
end
legend(h, labels, 'Fontsize', 10, 'Color', [1 1 1], 'EdgeColor', [0.15 0.15 0.15], 'Location', 'SouthEast');

% --- Function to browse through the MDCs of the ROI
function fig = view_fit_summary(fitStr, scan_fig_args)
% fig = view_fit_summary(fitStr, scan_fig_args)
%   This function plots an MDC cut within the ROI about some
%   cut whose index is defined by the user. There is also the 
%   possibility to plot the outcome of the fitting algorithm
%   too, which will show all of the fits made to the states.
%
%   REQ. FUNCTIONS: none.
%
%   IN:
%   -   fitStr:                 data structure of the fitted ARPES data.
%   -   mdc_fig_args:    1x2 cell array {mdc index, show mdc fits}
%
%   OUT:
%   -   fig:                  MATLAB figure object with the ARPES data plotted.

%% Loading in plot properties
pp = plot_props();
%% Initialising and extracting parameters
% - Scan parameters
scan_indx = scan_fig_args{1}(1);
scan_val = scan_fig_args{1}(2);
fig = figure(); set(gcf, 'Name', 'State fitting: fitting summary');

%% 1.0 - Plotting the ARPES image
subplot(1,2,1); hold on;
ImData(fitStr.kx_roi(:,:,scan_indx), fitStr.eb_roi(:,:,scan_indx), fitStr.data_roi(:,:,scan_indx));
gca_properties(5.1);
title(string(fitStr.matfile) + " - scan " + string(scan_indx), 'interpreter', 'none', 'fontsize', 12);
axis([min(min(fitStr.kx_roi(:,:,scan_indx))), max(max(fitStr.kx_roi(:,:,scan_indx))), ...
    min(min(fitStr.eb_roi(:,:,scan_indx))), max(max(fitStr.eb_roi(:,:,scan_indx)))]);
%% 1.1 - Plotting the EDC k- and eb-points
if isfield(fitStr, 'edc_fits')
    if ~isempty(fitStr.edc_fits{scan_indx})
        for n = 1:fitStr.edc_fits{scan_indx}.in.nStates
            % - Plotting the best fit data-points
            plot(fitStr.edc_fits{scan_indx}.out.kx_pts{n}, fitStr.edc_fits{scan_indx}.out.eb_pts{n}, 'x', ...
                'marker', pp.edc.markerstyle, 'markersize', pp.edc.markersize, 'color', pp.fit1.color{n});
            % - Plotting the best fit parabola
            xx = linspace(-8, 8, 5e3);
            fit_params = fitStr.edc_fits{scan_indx}.out.beta_para{n};
            plot(xx, fitStr.edc_fits{scan_indx}.out.fpara(fit_params, xx), '-',...
                'color', pp.fit1.color{n}, 'linewidth', pp.fit1.linewidth, 'linestyle', pp.fit1.linestyle);
        end
    end
end
%% 1.2 - Plotting the MDC k- and eb-points
if isfield(fitStr, 'mdc_fits')
    if ~isempty(fitStr.mdc_fits{scan_indx})
        for n = 1:fitStr.mdc_fits{scan_indx}.in.nStates
            % - Plotting the best fit data-points
            plot(fitStr.mdc_fits{scan_indx}.out.kx_pts{n}, fitStr.mdc_fits{scan_indx}.out.eb_pts{n}, 'x', ...
                'marker', pp.mdc.markerstyle, 'markersize', pp.mdc.markersize, 'color', pp.fit1.color{n});
            % - Plotting the best fit parabola
            xx = linspace(-8, 8, 5e3);
            fit_params = fitStr.mdc_fits{scan_indx}.out.beta_para{n};
            plot(xx, fitStr.mdc_fits{scan_indx}.out.fpara(fit_params, xx), '-',...
                'color', pp.fit1.color{n}, 'linewidth', pp.fit1.linewidth, 'linestyle', pp.fit1.linestyle);
        end
    end
end

%% 2 - Plotting a summary of all EDC/MDC fits
subplot(1,2,2); hold on;
% - Summary of all EDC fits in terms of the ground state energies
for i = 1:size(fitStr.edc_fits, 2)
    if ~isempty(fitStr.edc_fits{i})
        % -- Showing EDC fits
        for n = 1:fitStr.edc_fits{i}.in.nStates
            plot(fitStr.scan_roi(i), fitStr.edc_fits{i}.out.beta_para{n}(2), 'x', ...
                'marker', pp.edc.markerstyle, 'markersize', pp.edc.markersize, 'color', pp.fit1.color{n});
        end
        % -- Showing EDC stem if currently selected
        if i == scan_indx
        stem(fitStr.scan_roi(i), fitStr.edc_fits{i}.out.beta_para{1}(2), '-', ...
            'linewidth', 1, 'color', [0,0,0,0.5], 'marker', 'none');
        end
    else
        plot(fitStr.scan_roi(i), 0, 'x', ...
                'marker', pp.edc.markerstyle, 'markersize', pp.edc.markersize, 'color', [0, 0, 0, 0.5]);
        % -- Showing EDC stem if currently selected
        if i == scan_indx
            stem(fitStr.scan_roi(i), 0, '-', 'linewidth', 1, 'color', [0,0,0,0.5], 'marker', 'none');
        end
    end    
end
% - Summary of all MDC fits in terms of the ground state energies
for i = 1:size(fitStr.mdc_fits, 2)
    if ~isempty(fitStr.mdc_fits{i})
        % -- Showing MDC fits
        for n = 1:fitStr.mdc_fits{i}.in.nStates
            plot(fitStr.scan_roi(i), fitStr.mdc_fits{i}.out.beta_para{n}(2), 'x', ...
                'marker', pp.mdc.markerstyle, 'markersize', pp.mdc.markersize, 'color', pp.fit1.color{n});
        end
        % -- Showing MDC stem if currently selected
        if i == scan_indx
        stem(fitStr.scan_roi(i), fitStr.mdc_fits{i}.out.beta_para{1}(2), '-', ...
            'linewidth', 1, 'color', [0,0,0,0.5], 'marker', 'none');
        end
    else
        plot(fitStr.scan_roi(i), 0, 'x', ...
                'marker', pp.mdc.markerstyle, 'markersize', pp.mdc.markersize, 'color', [0, 0, 0, 0.5]);
        % -- Showing MDC stem if currently selected
        if i == scan_indx
            stem(fitStr.scan_roi(i), 0, '-', 'linewidth', 1, 'color', [0,0,0,0.5], 'marker', 'none');
        end
    end    
end
% - Axes limits and properties
axis([min(fitStr.scan_roi(:))*0.99, 1.01*max(fitStr.scan_roi(:)),...
    min(min(fitStr.eb_roi(:,:,scan_indx))), max(max(fitStr.eb_roi(:,:,scan_indx)))]);
gca_properties(5.2);

% --- General function to view a series of all scans from 3D ARPES data - *Eb(kx,ky) or Eb(kx,kz) scans only*
function fig = view_data_series(fitStr)
% view_data_series(dataStr)
%   This function plots the ARPES data in the form of D(X,Y)
%   for all the scan parameter values (tltM or hv) in the form of a 
%   downsampled image series. This function ensures that the 
%   most recent processing is shown in the figure.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   gca_properties(type)
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   dataStr:          data structure of the ARPES data.

disp('-> view series of all scans...')
wbar = waitbar(0., 'Plotting a view series of all scans...', 'Name', 'view_data_series');

%% Default parameters
% - Extracting the fields to be used with most recent processing
[xField, yField, zField, dField] = find_data_fields(dataStr);
% - Each series is an nRows x nCols sub-plot
nRows = 3; nCols = 3;
%% 1 - Down-sampling the form of the data
step_size = 2;
zMidIndx = ceil(size(dataStr.(dField), 3)/2);
%% 2 - Plotting a series of Eb(k) Images
% Filing through all the pages of the figures
for ipage=1:ceil(size(dataStr.(dField), 3)/nRows/nCols)
    figure_cell{ipage} = figure(); orient tall; 
    set(figure_cell{ipage}, 'Position', [1, 1, 800, 700], 'Name', dataStr.H5file);
    % Filing through all the frames in a single figure
    for iframe=1:nRows*nCols
        % - Finding the n'th data object to be plotted
        n = (ipage-1)*nRows*nCols+iframe;
        waitbar(n/size(dataStr.(dField), 3), wbar, 'Plotting a view series of all scans...', 'Name', 'view_data_series');
        % - If n > number of plotting elements, break the statement
        if n > size(dataStr.(dField), 3)
            break; 
        else
            % -- Plotting the n'th data object
            subplot(nRows,nCols,iframe); 
            % -- The plot depends on how far in the analysis 
            % - 2.1 - EbAlign->Normalise->kConvert fields
            if isfield(dataStr, 'kx')
                ImData(dataStr.(xField)(1:step_size:end,1:step_size:end,n), dataStr.(yField)(1:step_size:end,1:step_size:end,n), dataStr.(dField)(1:step_size:end,1:step_size:end,n));
                title(sprintf('scan = %.2f', dataStr.(zField)(zMidIndx,zMidIndx,n)), 'fontsize', 10);
                xticks(round(-15:0.5:15, 2)); yticks(round(-1e3:3:1e3, 2));
            % - 2.2 - EbAlign->Normalise fields
            elseif isfield(dataStr, 'data')
                ImData(dataStr.(xField)(1:step_size:end,1:step_size:end,n), dataStr.(yField)(1:step_size:end,1:step_size:end,n), dataStr.(dField)(1:step_size:end,1:step_size:end,n));
                title(sprintf('scan = %.2f', dataStr.(zField)(n)), 'fontsize', 10);
                xticks(round(-14:2:15, 2)); yticks(round(-1e3:3:1e3, 2));
            % - 2.3 - EbAlign fields
            elseif isfield(dataStr, 'eb')
                ImData(dataStr.(xField)(1:step_size:end,1:step_size:end,n), dataStr.(yField)(1:step_size:end,1:step_size:end,n), dataStr.(dField)(1:step_size:end,1:step_size:end,n));
                title(sprintf('scan = %.2f', dataStr.(zField)(n)), 'fontsize', 10);
                xticks(round(-14:2:15, 2)); yticks(round(-1e3:3:1e3, 2));
            % - 2.4 - Raw, unprocessed data fields
            else
                ImData(dataStr.(xField)(1:step_size:end), dataStr.(yField)(1:step_size:end), dataStr.(dField)(1:step_size:end,1:step_size:end,n));
                title(sprintf('scan = %.2f', dataStr.(zField)(n)), 'fontsize', 10);
                xticks(round(-14:2:15, 2)); yticks(round(-1e3:3:1e3, 2));
            end
            % - 2.5 - Formatting the figure
            minC = min(min(min(dataStr.(dField)(1:step_size:end,1:step_size:end,iframe))));
            maxC = max(max(max(dataStr.(dField)(1:step_size:end,1:step_size:end,iframe))));
            caxis([minC, maxC]);
            gca_properties(string(xField));
            colorbar('off'); xlabel(''); ylabel('');
            % -- Remove the colorbar for all plots, except the first one
            if iframe == 1
                % Setting the colorbar properties
                cb = colorbar; 
                % Colorbar font properties
                cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
                % Colorbar tick properties
                if cb.Limits(1) < 0 || cb.Limits(1) == 0; cb.Ticks = sort(round([0, 0.5*(0.95*cb.Limits(2)), 0.95*cb.Limits(2)], 3));
                else; cb.Ticks = sort(round([1.1*cb.Limits(1), 0.5*(0.95*cb.Limits(2)), 0.95*cb.Limits(2)], 3)); end
                cb.TickLabelInterpreter = 'latex'; cb.TickLength = 0.04;
                cb.TickDirection = 'out';
                % Colorbar position properties
                cb.Position = [0.92, 0.8, 0.03 0.1];
                % Colorbar box properties
                cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
            end
        end
    end
end
close(wbar);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INTERNAL TABLE FUNCTIONS %%%%%%%%%%%
% --- Function to browse through all the EDC fit parameters
function tab = view_edc_table(fitStr, scan_fig_args, edc_fig_args, mdc_fig_args)
%  fig = view_edc_table(fitStr, scan_fig_args, edc_fig_args, mdc_fig_args)
%   This function plots a table UI with all the fit parameters after
%   performing the EDC fitting to the ARPES data.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_roi_fields(fitStr);
%   -   gca_properties(type)
%   -   pp = plot_props()
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   fitStr:                    data structure of the fitted ARPES data.
%   -   scan_fig_args:    1x1 cell array {scan index}
%   -   edc_fig_args:      1x3 cell array {edc index, edc window, show edc fits, show fdd}
%   -   mdc_fig_args:    1x2 cell array {mdc index, show mdc fits}
%
%   OUT:
%   -   figure output.

%% Loading in plot properties
pp = plot_props();
%% Initialising and extracting parameters
% - Scan parameters
scan_indx = scan_fig_args{1}(1);
scan_val = scan_fig_args{1}(2);
% - edc parameters
edc_indx = edc_fig_args{1}(1);
edc_val = edc_fig_args{1}(2);
edc_win = edc_fig_args{2};
edc_fits = edc_fig_args{3};
edc_fdd = edc_fig_args{4};
edcWindow = [edc_val-0.5*edc_win, edc_val+0.5*edc_win];
% - mdc parameters
mdc_indx = mdc_fig_args{1}(1);
mdc_val = mdc_fig_args{1}(2);
mdc_win = mdc_fig_args{2};
mdc_fits = mdc_fig_args{3};

%% 1 - Plotting a table of the EDC fit parameters
if isfield(fitStr, 'edc_fits')
    if ~isempty(fitStr.edc_fits{scan_indx})
        % EXTRACTING ALL EDC FIT PARAMETERS
        for i = 1:size(fitStr.edc_fits{scan_indx}.out.beta_edc, 2)
            for n = 1:fitStr.edc_fits{scan_indx}.in.nStates
                edc_peak(i,n) = round(fitStr.edc_fits{scan_indx}.out.beta_edc{i}(4*n-3), 4);
                edc_dpeak(i,n) = abs(round(diff(fitStr.edc_fits{scan_indx}.out.ci_edc{i}(4*n-3,:)), 4));
                edc_fwhm(i,n) = round(fitStr.edc_fits{scan_indx}.out.beta_edc{i}(4*n-2), 4);
                edc_dfwhm(i,n) = abs(round(diff(fitStr.edc_fits{scan_indx}.out.ci_edc{i}(4*n-2,:)), 4));
                edc_pos(i,n) = round(fitStr.edc_fits{scan_indx}.out.beta_edc{i}(4*n-1), 4);
                edc_dpos(i,n) = abs(round(diff(fitStr.edc_fits{scan_indx}.out.ci_edc{i}(4*n-1,:)), 4));
                edc_res(i,n) = round(fitStr.edc_fits{scan_indx}.out.resnorm_edc{i}, 4);
            end
        end
        % Table for 1 fitted state
        if n == 1
            cnames1 = {'n1,peak', 'n1,dpeak', 'n1,fwhm', 'n1,dfwhm', 'n1,pos', 'n1,dpos', 'n1,res'};
            data1 = [edc_peak, edc_dpeak, edc_fwhm, edc_dfwhm, edc_pos, edc_dpos, edc_res];
        % Table for 2 fitted states
        elseif n == 2
            cnames1 = {'n1,peak', 'n2,peak', 'n1,dpeak', 'n2,dpeak', 'n1,fwhm', 'n2,fwhm', 'n1,dfwhm', 'n2,dfwhm', 'n1,pos', 'n2,pos', 'n1,dpos', 'n2,dpos', 'n1,res', 'n2,res'};
            data1 = [edc_peak, edc_dpeak, edc_fwhm, edc_dfwhm, edc_pos, edc_dpos, edc_res];
        end
        % Label the row names
        rnames1 = fitStr.edc_fits{scan_indx}.out.fit_indxs(1):1:fitStr.edc_fits{scan_indx}.out.fit_indxs(2);

        % EXTRACTING ALL PARABOLIC DISPERSION FITS
        % - Summary of all EDC parabolic fit parameters
        for n = 1:fitStr.edc_fits{scan_indx}.in.nStates
            % - Finding parabolic parameters and uncertainties
            par_k0(n) = round(fitStr.edc_fits{scan_indx}.out.beta_para{n}(1), 4);
            par_dk0(n) = abs(round(diff(fitStr.edc_fits{scan_indx}.out.ci_para{n}(1,:)), 4));
            par_eb0(n) = round(fitStr.edc_fits{scan_indx}.out.beta_para{n}(2), 4);
            par_deb0(n) = abs(round(diff(fitStr.edc_fits{scan_indx}.out.ci_para{n}(2,:)), 4));
            par_m(n) = round(fitStr.edc_fits{scan_indx}.out.beta_para{n}(3), 4);
            par_dm(n) = abs(round(diff(fitStr.edc_fits{scan_indx}.out.ci_para{n}(3,:)), 4));
            par_res(n) = round(fitStr.edc_fits{scan_indx}.out.resnorm_para{n}, 4);
        end
        % Table for 1 fitted state
        if n == 1
            cnames2 = {'Eb0', 'dEb0', 'k0', 'dk0', 'm*', 'dm*', 'res'};
            data2 = [par_eb0', par_deb0', par_k0', par_dk0', par_m', par_dm', par_res'];
        % Table for 2 fitted states
        elseif n == 2
            cnames2 = {'Eb0', 'dEb0', 'k0', 'dk0', 'm*', 'dm*', 'res'};
            data2 = [par_eb0', par_deb0', par_k0', par_dk0', par_m', par_dm', par_res'];
        end

        % PLOTTING THE TABLES WITH PARAMETERS
        tab = figure(); set(tab, 'name', 'EDC fit parameter table');
        % - EDC parameter table
        subplot(4,1,1:3);
        edc_table1 = uitable(tab,'Data', data1, 'ColumnName', cnames1, 'RowName', rnames1, 'ColumnWidth',{65});
        pos1 = get(subplot(4,1,1:3),'position'); delete(subplot(4,1,1:3));
        set(edc_table1,'units','normalized','position', pos1);
        % - Parabolic parameter table
        subplot(4,1,4);
        para_table2 = uitable(tab,'Data', data2, 'ColumnName',cnames2, 'ColumnWidth',{65});
        pos2 = get(subplot(4,1,4),'position'); delete(subplot(4,1,4));
        set(para_table2,'units','normalized','position', pos2);

    end
end

% --- Function to browse through all the EDC fit parameters
function tab = view_mdc_table(fitStr, scan_fig_args, edc_fig_args, mdc_fig_args)
%  tab = view_mdc_table(fitStr, scan_fig_args, edc_fig_args, mdc_fig_args)
%   This function plots a table UI with all the fit parameters after
%   performing the MDC fitting to the ARPES data.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_roi_fields(fitStr);
%   -   gca_properties(type)
%   -   pp = plot_props()
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   fitStr:                    data structure of the fitted ARPES data.
%   -   scan_fig_args:    1x1 cell array {scan index}
%   -   edc_fig_args:      1x3 cell array {edc index, edc window, show edc fits, show fdd}
%   -   mdc_fig_args:    1x2 cell array {mdc index, show mdc fits}
%
%   OUT:
%   -   figure output.

%% Loading in plot properties
pp = plot_props();
%% Initialising and extracting parameters
% - Scan parameters
scan_indx = scan_fig_args{1}(1);
scan_val = scan_fig_args{1}(2);
% - edc parameters
edc_indx = edc_fig_args{1}(1);
edc_val = edc_fig_args{1}(2);
edc_win = edc_fig_args{2};
edc_fits = edc_fig_args{3};
edc_fdd = edc_fig_args{4};
edcWindow = [edc_val-0.5*edc_win, edc_val+0.5*edc_win];
% - mdc parameters
mdc_indx = mdc_fig_args{1}(1);
mdc_val = mdc_fig_args{1}(2);
mdc_win = mdc_fig_args{2};
mdc_fits = mdc_fig_args{3};

%% 1 - Plotting a table of the MDC fit parameters
if isfield(fitStr, 'mdc_fits')
    if ~isempty(fitStr.mdc_fits{scan_indx})
        
        % EXTRACTING ALL MDC FIT PARAMETERS
        for i = 1:size(fitStr.mdc_fits{scan_indx}.out.beta_mdc, 2)
            for n = 1:fitStr.mdc_fits{scan_indx}.in.nStates
                if fitStr.mdc_fits{scan_indx}.in.mdc{n,5} == 1
                    mdc_peak(i,n) = round(fitStr.mdc_fits{scan_indx}.out.beta_mdc{i}(5*n-4), 4);
                    mdc_dpeak(i,n) = abs(round(diff(fitStr.mdc_fits{scan_indx}.out.ci_mdc{i}(5*n-4,:)), 4));
                    mdc_fwhm(i,n) = round(fitStr.mdc_fits{scan_indx}.out.beta_mdc{i}(5*n-3), 4);
                    mdc_dfwhm(i,n) = abs(round(diff(fitStr.mdc_fits{scan_indx}.out.ci_mdc{i}(5*n-3,:)), 4));
                    mdc_pos1(i,n) = round(fitStr.mdc_fits{scan_indx}.out.beta_mdc{i}(5*n-2), 4);
                    mdc_dpos1(i,n) = abs(round(diff(fitStr.mdc_fits{scan_indx}.out.ci_mdc{i}(5*n-2,:)), 4));
                    mdc_pos2(i,n) = round(fitStr.mdc_fits{scan_indx}.out.beta_mdc{i}(5*n-1), 4);
                    mdc_dpos2(i,n) = abs(round(diff(fitStr.mdc_fits{scan_indx}.out.ci_mdc{i}(5*n-1,:)), 4));
                    mdc_res(i,n) = round(fitStr.mdc_fits{scan_indx}.out.resnorm_mdc{i}, 4);
                elseif fitStr.mdc_fits{scan_indx}.in.mdc{n,5} == 0
                    mdc_peak1(i,n) = round(fitStr.mdc_fits{scan_indx}.out.beta_mdc{i}(6*n-5), 4);
                    mdc_dpeak1(i,n) = abs(round(diff(fitStr.mdc_fits{scan_indx}.out.ci_mdc{i}(6*n-5,:)), 4));
                    mdc_peak2(i,n) = round(fitStr.mdc_fits{scan_indx}.out.beta_mdc{i}(6*n-4), 4);
                    mdc_dpeak2(i,n) = abs(round(diff(fitStr.mdc_fits{scan_indx}.out.ci_mdc{i}(6*n-4,:)), 4));
                    mdc_fwhm(i,n) = round(fitStr.mdc_fits{scan_indx}.out.beta_mdc{i}(6*n-3), 4);
                    mdc_dfwhm(i,n) = abs(round(diff(fitStr.mdc_fits{scan_indx}.out.ci_mdc{i}(6*n-3,:)), 4));
                    mdc_pos1(i,n) = round(fitStr.mdc_fits{scan_indx}.out.beta_mdc{i}(6*n-2), 4);
                    mdc_dpos1(i,n) = abs(round(diff(fitStr.mdc_fits{scan_indx}.out.ci_mdc{i}(6*n-2,:)), 4));
                    mdc_pos2(i,n) = round(fitStr.mdc_fits{scan_indx}.out.beta_mdc{i}(6*n-1), 4);
                    mdc_dpos2(i,n) = abs(round(diff(fitStr.mdc_fits{scan_indx}.out.ci_mdc{i}(6*n-1,:)), 4));
                    mdc_res(i,n) = round(fitStr.mdc_fits{scan_indx}.out.resnorm_mdc{i}, 4);
                end
            end
        end
        % Table for 1 fitted state with symmetric peaks
        if fitStr.mdc_fits{scan_indx}.in.mdc{n, 5} == 1 && n == 1
            cnames1 = {'n1,peak', 'n1,dpeak', 'n1,fwhm', 'n1,dfwhm',...
                'n1,pos1', 'n1,pos2', 'n1,dpos1', 'n1,dpos2', 'n1,res'};
            data1 = [mdc_peak, mdc_dpeak, mdc_fwhm, mdc_dfwhm, mdc_pos1, mdc_pos2, mdc_dpos1, mdc_dpos2, mdc_res];
        % Table for 2 fitted states with symmetric peaks
        elseif fitStr.mdc_fits{scan_indx}.in.mdc{n, 5} == 1 && n == 2
            cnames1 = {'n1,peak', 'n2,peak', 'n1,dpeak', 'n2,dpeak', 'n1,fwhm', 'n2,fwhm', 'n1,dfwhm', 'n2,dfwhm',...
                'n1,pos1', 'n1,pos2', 'n2,pos1', 'n2,pos2',  'n1,dpos1', 'n1,dpos2', 'n2,dpos1', 'n2,dpos2', 'n1,res', 'n2,res'};
            data1 = [mdc_peak, mdc_dpeak, mdc_fwhm, mdc_dfwhm, mdc_pos1, mdc_pos2, mdc_dpos1, mdc_dpos2, mdc_res];
        % Table for 1 fitted states with asymmetric peaks
        elseif fitStr.mdc_fits{scan_indx}.in.mdc{n, 5} == 0 && n == 1
            cnames1 = {'n1,peak1', 'n1,peak2', 'n1,dpeak1', 'n1,dpeak2', 'n1,fwhm', 'n1,dfwhm',...
                'n1,pos1', 'n1,pos2', 'n1,dpos1', 'n1,dpos2', 'n1,res'};
            data1 = [mdc_peak1, mdc_peak2, mdc_dpeak1, mdc_dpeak2, mdc_fwhm, mdc_dfwhm, mdc_pos1, mdc_pos2, mdc_dpos1, mdc_dpos2, mdc_res];
        % Table for 2 fitted states with asymmetric peaks
        elseif fitStr.mdc_fits{scan_indx}.in.mdc{n, 5} == 0 && n == 2
            cnames1 = {'n1,peak1', 'n1,peak2', 'n2,peak1', 'n2,peak2', 'n1,dpeak1', 'n1,dpeak2', 'n2,dpeak1', 'n2,dpeak2', 'n1,fwhm', 'n2,fwhm', 'n1,dfwhm', 'n2,dfwhm',...
                'n1,pos1', 'n1,pos2', 'n2,pos1', 'n2,pos2', 'n1,dpos1', 'n1,dpos2', 'n2,dpos1', 'n2,dpos2', 'n1,res', 'n2,res'};
            data1 = [mdc_peak1, mdc_peak2, mdc_dpeak1, mdc_dpeak2, mdc_fwhm, mdc_dfwhm, mdc_pos1, mdc_pos2, mdc_dpos1, mdc_dpos2, mdc_res];
        end
        % Label the row names
        rnames1 = fitStr.mdc_fits{scan_indx}.out.fit_indxs(1):1:fitStr.mdc_fits{scan_indx}.out.fit_indxs(2);

         % EXTRACTING ALL PARABOLIC DISPERSION FITS
        % - Summary of all MDC parabolic fit parameters
        for n = 1:fitStr.mdc_fits{scan_indx}.in.nStates
            % - Finding parabolic parameters and uncertainties
            par_k0(n) = round(fitStr.mdc_fits{scan_indx}.out.beta_para{n}(1), 4);
            par_dk0(n) = abs(round(diff(fitStr.mdc_fits{scan_indx}.out.ci_para{n}(1,:)), 4));
            par_eb0(n) = round(fitStr.mdc_fits{scan_indx}.out.beta_para{n}(2), 4);
            par_deb0(n) = abs(round(diff(fitStr.mdc_fits{scan_indx}.out.ci_para{n}(2,:)), 4));
            par_m(n) = round(fitStr.mdc_fits{scan_indx}.out.beta_para{n}(3), 4);
            par_dm(n) = abs(round(diff(fitStr.mdc_fits{scan_indx}.out.ci_para{n}(3,:)), 4));
            par_res(n) = round(fitStr.mdc_fits{scan_indx}.out.resnorm_para{n}, 4);
        end
        % Table for 1 fitted state
        if n == 1
            cnames2 = {'Eb0', 'dEb0', 'k0', 'dk0', 'm*', 'dm*', 'res'};
            data2 = [par_eb0', par_deb0', par_k0', par_dk0', par_m', par_dm', par_res'];
        % Table for 2 fitted states
        elseif n == 2
            cnames2 = {'Eb0', 'dEb0', 'k0', 'dk0', 'm*', 'dm*', 'res'};
            data2 = [par_eb0', par_deb0', par_k0', par_dk0', par_m', par_dm', par_res'];
        end

        % PLOTTING THE TABLES WITH PARAMETERS
        tab = figure(); set(tab, 'name', 'MDC fit parameters');
        % - EDC parameter table
        subplot(4,1,1:3);
        mdc_table1 = uitable(tab,'Data', data1, 'ColumnName', cnames1, 'RowName', rnames1, 'ColumnWidth',{65});
        pos1 = get(subplot(4,1,1:3),'position'); delete(subplot(4,1,1:3));
        set(mdc_table1,'units','normalized','position', pos1);
        % - Parabolic parameter table
        subplot(4,1,4);
        para_table2 = uitable(tab,'Data', data2, 'ColumnName',cnames2, 'ColumnWidth',{65});
        pos2 = get(subplot(4,1,4),'position'); delete(subplot(4,1,4));
        set(para_table2,'units','normalized','position', pos2);

    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% The End %%%%%%%%%%%%%%%%%%%%
