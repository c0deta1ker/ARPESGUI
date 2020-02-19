function varargout = arpes_processor(varargin)
% arpes_processor MATLAB code for arpes_processor.fig
%      ARPES_PROCESSOR, by itself, creates a new ARPES_PROCESSOR or raises the existing
%      singleton*.
%
%      H = ARPES_PROCESSOR returns the handle to a new ARPES_PROCESSOR or the handle to
%      the existing singleton*.
%
%      ARPES_PROCESSOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ARPES_PROCESSOR.M with the given input arguments.
%
%      ARPES_PROCESSOR('Property','Value',...) creates a new ARPES_PROCESSOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before arpes_processor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to arpes_processor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help arpes_processor

% Last Modified by GUIDE v2.5 28-Jul-2019 20:13:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @arpes_processor_OpeningFcn, ...
                   'gui_OutputFcn',  @arpes_processor_OutputFcn, ...
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
% --- Executes just before arpes_processor is made visible.
function arpes_processor_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to arpes_processor (see VARARGIN)

%% Choose default command line output for arpes_processor
handles.output = hObject;
%% 1 - Setting the native size of the whole GUI figure
screen_size = get(0,'ScreenSize');
screen_size(3) = 800;
screen_size(4) = 415;
set(handles.figure1,'Units','Pixels','Position',screen_size, 'name', 'arpes_processor');
%% 2 - Setting push-buttons to inactive
set(handles.pushbutton_SAVE, 'Enable', 'off');
set(handles.pushbutton_TRANSFER, 'Enable', 'off');
set(handles.pushbutton_ViewLatest, 'Enable', 'off');
set(handles.pushbutton_INFO, 'Enable', 'off');
set(handles.pushbutton_RESET, 'Enable', 'off');
%% 3 - Setting other ui-elements inactive until data is loaded
set(handles.popupmenu_3Dtype, 'Enable', 'off');
set(handles.pushbutton_View3Ddata, 'Enable', 'off');
set(handles.pushbutton_ViewSeries, 'Enable', 'off');
%% 4 - Setting ui-panels to inactive until data is loaded
set(findall(handles.uipanel_CropData, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_FilterData, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_ScanCorrections, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_3Dplotter, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_3DARPESbrowser, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_EbAlign, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_IntNorm, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_KConv, '-property', 'enable'), 'enable', 'off');
%% 5 - Initialising variables
set(handles.text_scanIndex,'String', handles.fig_args{1});
set(handles.text_scanValue,'String', "NaN");
%% Save the handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = arpes_processor_OutputFcn(hObject, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)

%% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes to reset GUI to initial state
function handles = arpes_processor_ResetFcn(hObject, ~, handles)
% This is a function that resets the UI elements to their initial, default
% state.
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Setting push-buttons to inactive
set(handles.pushbutton_SAVE, 'Enable', 'off');
set(handles.pushbutton_TRANSFER, 'Enable', 'off');
set(handles.pushbutton_ViewLatest, 'Enable', 'off');
set(handles.pushbutton_INFO, 'Enable', 'off');
set(handles.pushbutton_RESET, 'Enable', 'off');
%% 2 - Setting other ui-elements inactive until data is loaded
set(handles.popupmenu_3Dtype, 'Enable', 'off');
set(handles.pushbutton_View3Ddata, 'Enable', 'off');
set(handles.pushbutton_ViewSeries, 'Enable', 'off');
%% 3 - Setting ui-panels to inactive until data is loaded
set(findall(handles.uipanel_CropData, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_FilterData, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_ScanCorrections, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_3Dplotter, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_3DARPESbrowser, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_EbAlign, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_IntNorm, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_KConv, '-property', 'enable'), 'enable', 'off');
%% 4 - Initialising variables
set(handles.text_scanIndex,'String', handles.fig_args{1});
set(handles.text_scanValue,'String', "NaN");
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
close(gcbf); run arpes_processor;

% --- Executes on button press in pushbutton_RESIZEGUI.
function pushbutton_RESIZEGUI_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_RESIZEGUI (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Resetting the native size of the whole GUI figure
screen_size = get(0, 'ScreenSize');
screen_pos = get(gcf, 'Position');
screen_size(1) = screen_pos(1);
screen_size(2) = screen_pos(2);
screen_size(3) = 800;
screen_size(4) = 415;
set(handles.figure1,'Units','Pixels','Position',screen_size, 'name', 'arpes_processor');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_TRANSFER.
function pushbutton_TRANSFER_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_TRANSFER (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Transfer the handles.myData to the MATLAB workspace
assignin('base','arpes_data',handles.myData);

% --- Executes on button press in pushbutton_INFO.
function pushbutton_INFO_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_INFO (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Display the handles and handles.myData data structures
disp('HANDLES : '); disp(handles);
disp('DATA (.myData) : '); disp(handles.myData);

% --- Executes on button press in pushbutton_LOAD.
function pushbutton_LOAD_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_LOAD (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Loading in the FileName and PathName of the selected data
[FileName, PathName] = uigetfile({'*.h5;*.mat'}, 'Pick a *.h5 or *.mat data file...');
% - If Cancel is pressed, then return nothing
if isequal(PathName,0) || isequal(FileName,0); return; end
% - 1.1 - Load in the file selected
handles.myData = [];
handles.myData = load_arpes_data(FileName);
%% 2 - Reseting the GUI to the initial state
handles = arpes_processor_ResetFcn(hObject, [], handles);
%% 3 - Updating handle text and gui elements
% - 2.1 - Show the name, type and information of the ARPES data
set(handles.text_RawFileName,'String',FileName);
set(handles.text_ScanType,'String',handles.myData.Type);
set(handles.text_ScanInfo,'String',handles.myData.meta.info);
% - 2.2 - Activating push-buttons that can be used
% -- General buttons
set(handles.pushbutton_SAVE, 'Enable', 'on');
set(handles.pushbutton_TRANSFER, 'Enable', 'on');
set(handles.pushbutton_INFO, 'Enable', 'on');
set(handles.pushbutton_ViewLatest, 'Enable', 'on');
set(handles.pushbutton_RESET, 'Enable', 'on');
% -- General GUI elements
set(findall(handles.uipanel_CropData, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_FilterData, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_EbAlign, '-property', 'enable'), 'enable', 'on');
% -- Setting the processing constraints based on the scan type
if handles.myData.Type == "Eb(k)"
    set(findall(handles.uipanel_ScanCorrections, '-property', 'enable'), 'enable', 'off');
    set(findall(handles.uipanel_3Dplotter, '-property', 'enable'), 'enable', 'off');
    set(findall(handles.uipanel_3DARPESbrowser, '-property', 'enable'), 'enable', 'off');
    set(handles.edit_zLims, 'Enable', 'off');
    set(handles.pushbutton_ViewSeries, 'Enable', 'off');
    set(handles.popupmenu_EbType, 'Enable', 'off');
elseif handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)"
    set(findall(handles.uipanel_ScanCorrections, '-property', 'enable'), 'enable', 'on');
    set(findall(handles.uipanel_3Dplotter, '-property', 'enable'), 'enable', 'on');
    set(findall(handles.uipanel_3DARPESbrowser, '-property', 'enable'), 'enable', 'on');
    set(handles.edit_zLims, 'Enable', 'on');
    set(handles.pushbutton_ViewSeries, 'Enable', 'on');
    set(handles.popupmenu_EbType, 'Enable', 'off');
    % -- Initialising the scan slider
    [~, ~, ~, dField] = find_data_fields(handles.myData);
    set(handles.slider_scanSlider,'min', 1, 'max', size(handles.myData.(dField), 3), 'Value', 1, 'SliderStep', [1/(size(handles.myData.(dField), 3)-1), 1/(size(handles.myData.(dField), 3)-1) ]);
    handles = slider_scanSlider_Callback(handles.slider_scanSlider, [], handles, 0);
    handles = edit_isoSlice_Callback(handles.edit_isoSlice, [], handles, 0);
    % -- Initialising the 3D plot limits
    handles = popupmenu_3Dtype_Callback(handles.popupmenu_3Dtype, [], handles);
    handles = edit_3DLimits_Callback(handles.edit_3DLimits, [], handles);
end
%% 4 - Running UI call-backs to ensure consistency
handles = edit_xLims_Callback(handles.edit_xLims, [], handles);
handles = edit_yLims_Callback(handles.edit_yLims, [], handles);
handles = edit_zLims_Callback(handles.edit_zLims, [], handles);
handles = popupmenu_EbType_CreateFcn(handles.popupmenu_EbType, [], handles);
handles = popupmenu_EbType_Callback(handles.popupmenu_EbType, [], handles);
%% 5 - If processing has already been performed, load to most recent stage
if isfield(handles.myData, 'kx') || isfield(handles.myData, 'data')
    set(findall(handles.uipanel_IntNorm, '-property', 'enable'), 'enable', 'on');
    set(findall(handles.uipanel_KConv, '-property', 'enable'), 'enable', 'on');
elseif isfield(handles.myData, 'eb')
    set(findall(handles.uipanel_IntNorm, '-property', 'enable'), 'enable', 'on');
    set(findall(handles.uipanel_KConv, '-property', 'enable'), 'enable', 'off');
else
    set(findall(handles.uipanel_IntNorm, '-property', 'enable'), 'enable', 'off');
    set(findall(handles.uipanel_KConv, '-property', 'enable'), 'enable', 'off');
end
%% 6 - View the loaded data
view_data(handles.myData, handles.fig_args);
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
[save_filename, save_filepath] = uiputfile(filter, 'Save processed ARPES data', handles.myData.H5file);
save_fullfile = char(string(save_filepath) + string(save_filename));
% - If Cancel is pressed, then return nothing
if isequal(save_filepath,0) || isequal(save_filename,0); return; end
%% 2 - Executing the saving of the processed data
wbar=waitbar(0.5,'Saving...'); 
dataStruc = handles.myData;
save(char(save_fullfile), 'dataStruc', '-v7.3');
disp('-> saved arpes data : '); display(handles.myData);
close(wbar);
%% 3 - Saving a figure with the data
fig = view_data(handles.myData, handles.fig_args);
print(fig, char(save_fullfile(1:end-4)+"_snap.png"), '-dpng');
%% 4 - Saving a text file with all the info
fileID = fopen(char(save_fullfile(1:end-4)+"_info.txt"), 'w');
fprintf(fileID, handles.myData.meta.info);
fclose(fileID);

% --- Executes on button press in pushbutton_RESET.
function pushbutton_RESET_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_RESET (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Re-load the raw data-file
FileName = char(string(handles.myData.H5file) + ".h5");
handles.myData = [];
handles.myData = load_arpes_data(FileName);
%% 2 - Reseting the GUI to the initial state
handles = arpes_processor_ResetFcn(hObject, [], handles);
%% 3 - Updating handle text and gui elements
% - 3.1 - Show the name, type and information of the ARPES data
set(handles.text_RawFileName,'String',FileName);
set(handles.text_ScanType,'String',handles.myData.Type);
set(handles.text_ScanInfo,'String',handles.myData.meta.info);
% - 3.2 - Activating push-buttons that can be used
% -- General buttons
set(handles.pushbutton_SAVE, 'Enable', 'on');
set(handles.pushbutton_TRANSFER, 'Enable', 'on');
set(handles.pushbutton_INFO, 'Enable', 'on');
set(handles.pushbutton_ViewLatest, 'Enable', 'on');
set(handles.pushbutton_RESET, 'Enable', 'on');
% -- General GUI elements
set(findall(handles.uipanel_CropData, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_FilterData, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_EbAlign, '-property', 'enable'), 'enable', 'on');
% -- Setting the processing constraints based on the scan type
if handles.myData.Type == "Eb(k)"
    set(findall(handles.uipanel_ScanCorrections, '-property', 'enable'), 'enable', 'off');
    set(findall(handles.uipanel_3Dplotter, '-property', 'enable'), 'enable', 'off');
    set(findall(handles.uipanel_3DARPESbrowser, '-property', 'enable'), 'enable', 'off');
    set(handles.edit_zLims, 'Enable', 'off');
    set(handles.pushbutton_ViewSeries, 'Enable', 'off');
    set(handles.popupmenu_EbType, 'Enable', 'off');
elseif handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)"
    set(findall(handles.uipanel_ScanCorrections, '-property', 'enable'), 'enable', 'on');
    set(findall(handles.uipanel_3Dplotter, '-property', 'enable'), 'enable', 'on');
    set(findall(handles.uipanel_3DARPESbrowser, '-property', 'enable'), 'enable', 'on');
    set(handles.edit_zLims, 'Enable', 'on');
    set(handles.pushbutton_ViewSeries, 'Enable', 'on');
    set(handles.popupmenu_EbType, 'Enable', 'off');
    % -- Initialising the scan slider
    [~, ~, ~, dField] = find_data_fields(handles.myData);
    set(handles.slider_scanSlider,'min', 1, 'max', size(handles.myData.(dField), 3), 'Value', 1, 'SliderStep', [1/(size(handles.myData.(dField), 3)-1), 1/(size(handles.myData.(dField), 3)-1) ]);
    handles = slider_scanSlider_Callback(handles.slider_scanSlider, [], handles, 0);
    handles = edit_isoSlice_Callback(handles.edit_isoSlice, [], handles, 0);
    % -- Initialising the 3D plot limits
    handles = popupmenu_3Dtype_Callback(handles.popupmenu_3Dtype, [], handles);
    handles = edit_3DLimits_Callback(handles.edit_3DLimits, [], handles);
end
%% 4 - Running UI call-backs to ensure consistency
handles = edit_xLims_Callback(handles.edit_xLims, [], handles);
handles = edit_yLims_Callback(handles.edit_yLims, [], handles);
handles = edit_zLims_Callback(handles.edit_zLims, [], handles);
handles = popupmenu_EbType_CreateFcn(handles.popupmenu_EbType, [], handles);
handles = popupmenu_EbType_Callback(handles.popupmenu_EbType, [], handles);
%% 5 - If processing has already been performed, load to most recent stage
if isfield(handles.myData, 'kx') || isfield(handles.myData, 'data')
    set(findall(handles.uipanel_IntNorm, '-property', 'enable'), 'enable', 'on');
    set(findall(handles.uipanel_KConv, '-property', 'enable'), 'enable', 'on');
elseif isfield(handles.myData, 'eb')
    set(findall(handles.uipanel_IntNorm, '-property', 'enable'), 'enable', 'on');
    set(findall(handles.uipanel_KConv, '-property', 'enable'), 'enable', 'off');
else
    set(findall(handles.uipanel_IntNorm, '-property', 'enable'), 'enable', 'off');
    set(findall(handles.uipanel_KConv, '-property', 'enable'), 'enable', 'off');
end
%% 6 - View the loaded data
view_data(handles.myData, handles.fig_args);
%% Save the handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ViewLatest.
function pushbutton_ViewLatest_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ViewLatest (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% View the latest ARPES data after processing
view_data(handles.myData, handles.fig_args);

% --- Executes on button press in pushbutton_ViewSeries.
function pushbutton_ViewSeries_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ViewSeries (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Plotting an image for every value of the scan parameter
view_data_series(handles.myData);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CROP DATA  %%%%%%%%%%%
% --- Executes when changing the text
function handles = edit_xLims_Callback(hObject, ~, handles)
% hObject    handle to edit_xLims (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
[xField, ~, ~, ~] = find_data_fields(handles.myData);
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 2);
%% 2 - Validity check on input
% - If no entry is made, default to the maximum range
if isempty(data_entry) ||  length(data_entry) == 1 || length(data_entry) > 2
    data_entry = [min(handles.myData.(xField)(:)), max(handles.myData.(xField)(:))];
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 2
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < min(handles.myData.(xField)(:)) || data_entry(1) > max(handles.myData.(xField)(:)); data_entry(1) = min(handles.myData.(xField)(:)); end
    if data_entry(2) < min(handles.myData.(xField)(:)) || data_entry(2) > max(handles.myData.(xField)(:)); data_entry(2) = max(handles.myData.(xField)(:)); end
end
%% 3 - Assigning output and printing change
handles.crop_args{1}  = sort(round(data_entry, 2));
set(hObject,'String', string(handles.crop_args{1}(1) + ":" + handles.crop_args{1}(2))); 
fprintf("--> xLims: " + string(handles.crop_args{1}(1) + ":" + handles.crop_args{1}(2)) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_xLims_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_xLims (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.crop_args{1} = []; 
set(hObject,'String', "[]");
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_yLims_Callback(hObject, ~, handles)
% hObject    handle to edit_yLims (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
[~, yField, ~, ~] = find_data_fields(handles.myData);
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 2);
%% 2 - Validity check on input
 % - If no entry is made, default to the maximum range
if isempty(data_entry) ||  length(data_entry) == 1 || length(data_entry) > 2
    data_entry = [min(handles.myData.(yField)(:)), max(handles.myData.(yField)(:))];
 % - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 2
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < min(handles.myData.(yField)(:)) || data_entry(1) > max(handles.myData.(yField)(:)); data_entry(1) = min(handles.myData.(yField)(:)); end
    if data_entry(2) < min(handles.myData.(yField)(:)) || data_entry(2) > max(handles.myData.(yField)(:)); data_entry(2) = max(handles.myData.(yField)(:)); end
end
%% 3 - Assigning output and printing change
handles.crop_args{2}  = sort(round(data_entry, 2));
set(hObject,'String', string(handles.crop_args{2}(1) + ":" + handles.crop_args{2}(2))); 
fprintf("--> yLims: " + string(handles.crop_args{2}(1) + ":" + handles.crop_args{2}(2)) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_yLims_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_yLims (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.crop_args{2} = []; 
set(hObject,'String', "[]");
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_zLims_Callback(hObject, ~, handles)
% hObject    handle to edit_zLims (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
[~, ~, zField, ~] = find_data_fields(handles.myData);
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 2);
%% 2 - Validity check on input
if handles.myData.Type == "Eb(k)"
    set(hObject,'Enable', 'off'); 
    data_entry = mean(handles.myData.(zField)(:));
elseif handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)"
    set(hObject,'Enable', 'on'); 
    % - If no entry is made, default to the maximum range
    if isempty(data_entry) ||  length(data_entry) == 1 || length(data_entry) > 2
        data_entry = [min(handles.myData.(zField)(:)), max(handles.myData.(zField)(:))];
     % - If a double entry is made, ensure it does not exceed the max / min limits
    elseif length(data_entry) == 2
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < min(handles.myData.(zField)(:)) || data_entry(1) > max(handles.myData.(zField)(:)); data_entry(1) = min(handles.myData.(zField)(:)); end
        if data_entry(2) < min(handles.myData.(zField)(:)) || data_entry(2) > max(handles.myData.(zField)(:)); data_entry(2) = max(handles.myData.(zField)(:)); end
    end
end
%% 3 - Assigning output and printing change
if handles.myData.Type == "Eb(k)"
    handles.crop_args{3}  = sort(round(data_entry, 2));
    set(hObject,'String', string(handles.crop_args{3})); 
    fprintf("--> zLims: " + string(handles.crop_args{3} + " \n"));
elseif handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)"
    handles.crop_args{3}  = sort(round(data_entry, 2));
    set(hObject,'String', string(handles.crop_args{3}(1) + ":" + handles.crop_args{3}(2))); 
    fprintf("--> zLims: " + string(handles.crop_args{3}(1) + ":" + handles.crop_args{3}(2)) + " \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_zLims_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_zLims (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.crop_args{3} = []; 
set(hObject,'String', "[]");
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExecuteDataCrop.
function pushbutton_ExecuteDataCrop_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExecuteDataCrop (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Performing the cropping operation
handles.myData = crop_data(handles.myData, handles.crop_args{1}, handles.crop_args{2}, handles.crop_args{3});
handles.fig_args{1} = 1;
%% 2 - View the updated figure
view_data(handles.myData, handles.fig_args);
%% 3 - Ask the user if they want to keep the new cropped data
answer = questdlg('Would you like to store the cropped data?', ...
	'Crop data?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing but update figure again
if isempty(answer) || string(answer) == "No"; return; end
%% 4 - Updating UI elements that are affected
if handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)"
    [~, ~, ~, dField] = find_data_fields(handles.myData);
    set(handles.slider_scanSlider,'min', 1, 'max', size(handles.myData.(dField), 3), 'Value', 1, 'SliderStep', [1/(size(handles.myData.(dField), 3)-1), 1/(size(handles.myData.(dField), 3)-1) ]);
    handles = slider_scanSlider_Callback(handles.slider_scanSlider, [], handles, 0);
    % -- Updating the 3D plot limits
    handles = popupmenu_3Dtype_Callback(handles.popupmenu_3Dtype, [], handles);
    handles = edit_3DLimits_Callback(handles.edit_3DLimits, [], handles);
end
handles = edit_xLims_Callback(handles.edit_xLims, [], handles);
handles = edit_yLims_Callback(handles.edit_yLims, [], handles);
handles = edit_zLims_Callback(handles.edit_zLims, [], handles);
handles = edit_ScanNum_Callback(handles.edit_ScanNum, [], handles);
handles = edit_eWin_Callback(handles.edit_eWin, [], handles);
%% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FILTER DATA  %%%%%%%%%%%
% --- Executes on selection change in popupmenu_FilterType.
function popupmenu_FilterType_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_FilterType (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
contents = cellstr(get(hObject,'String'));
data_entry = contents{get(hObject,'Value')};
%% 2 - Validity check on input
% For 'Gaco2' smoothing
if data_entry == "Gaco2"
    set(handles.staticstext_FilterParam, 'string', 'hwX,hwY:');
    handles.filter_args{2} = [0.5, 0.5];
% For 'GaussFlt2' smoothing
elseif data_entry == "GaussFlt2"
    set(handles.staticstext_FilterParam, 'string', 'hwX,hwY:');
    handles.filter_args{2} = [5, 5];
% For 'LaplaceFlt2' smoothing
elseif data_entry == "LaplaceFlt2"
    set(handles.staticstext_FilterParam, 'string', 'y2xRatio:');
    handles.filter_args{2} = 0;
% For 'CurvatureFlt2' smoothing
elseif data_entry == "CurvatureFlt2"
    set(handles.staticstext_FilterParam, 'string', 'CX,CY:');
    handles.filter_args{2} = [1,1];
end
handles.filter_args{1} = string(contents{get(hObject,'Value')});
%% 3 - Assigning output and printing change
fprintf("--> Filter Type: " + handles.filter_args{1} + " \n");
if handles.filter_args{1} == "LaplaceFlt2"
    set(handles.edit_filterParam,'String', string(handles.filter_args{2})); 
    fprintf("--> "+ get(handles.staticstext_FilterParam, 'string')+" "+string(handles.filter_args{2}) + " \n");
else
    set(handles.edit_filterParam,'String', string(handles.filter_args{2}(1) + "," + handles.filter_args{2}(2))); 
    fprintf("--> "+ get(handles.staticstext_FilterParam, 'string')+" "+string(handles.filter_args{2}(1) + "," + handles.filter_args{2}(2)) + " \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_FilterType_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_FilterType (see GCBO)
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
        data_entry = [5, 5];
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
    fprintf("--> "+ get(handles.staticstext_FilterParam, 'string')+" "+string(handles.filter_args{2}) + " \n");
else
    set(hObject,'String', string(handles.filter_args{2}(1) + "," + handles.filter_args{2}(2))); 
    fprintf("--> "+ get(handles.staticstext_FilterParam, 'string')+" "+string(handles.filter_args{2}(1) + "," + handles.filter_args{2}(2)) + " \n");
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
handles.myData = filter_data(handles.myData, handles.filter_args);
%% 2 - View the figure update
view_data(handles.myData, handles.fig_args);
%% 3 - Ask the user if they want to keep the new filtered data
answer = questdlg('Would you like to store the filtered data?', ...
	'Filter data?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
%% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SCAN PROPERTIES  %%%%%%%%%%%
% --- Executes when changing the text
function handles = edit_ScanNum_Callback(hObject, ~, handles)
% hObject    handle to edit_ScanNum (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = sort(floor(str2num(strrep(get(hObject,'String'),',',' '))));
%% 2 - Validity check of the input
[~, ~, ~, dField] = find_data_fields(handles.myData);
%% 2 - Validity check of the input
% - If none or multiple entries are made, default to 90 degrees
if isempty(data_entry) || size(data_entry,1) > 1
    data_entry = 1;
else
    % - Checking that the max/min values for the scans are not exceeded
    data_entry(data_entry<1) = [];
    data_entry(data_entry>size(handles.myData.(dField), 3)) = [];
end
%% 3 - Assigning output and printing change
handles.scan_args{1} = data_entry;
fprintf("--> Scan indices: " + mat2str(handles.scan_args{1} ) + " \n");
set(hObject,'String', mat2str(handles.scan_args{1})); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_ScanNum_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_ScanNum (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.scan_args{1} = 1; 
set(hObject,'String', handles.scan_args{1}); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_DeleteScans.
function pushbutton_DeleteScans_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_DeleteScans (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Performing the deletion operation
handles.myData = delete_scans(handles.myData, handles.scan_args);
handles.fig_args{1} = 1;
%% 2 - View the figure update
view_data(handles.myData, handles.fig_args);
%% 3 - Ask the user if they want to keep the new cropped data
answer = questdlg('Would you like to store the new data after deletion?', ...
	'Delete scans?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
%% 4 - Updating UI elements that are affected
if handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)"
    [~, ~, ~, dField] = find_data_fields(handles.myData);
    set(handles.slider_scanSlider,'min', 1, 'max', size(handles.myData.(dField), 3), 'Value', 1, 'SliderStep', [1/(size(handles.myData.(dField), 3)-1), 1/(size(handles.myData.(dField), 3)-1) ]);
    handles = slider_scanSlider_Callback(handles.slider_scanSlider, [], handles, 0);
    % -- Updating the 3D plot limits
    handles = popupmenu_3Dtype_Callback(handles.popupmenu_3Dtype, [], handles);
    handles = edit_3DLimits_Callback(handles.edit_3DLimits, [], handles);
end
handles = edit_xLims_Callback(handles.edit_xLims, [], handles);
handles = edit_yLims_Callback(handles.edit_yLims, [], handles);
handles = edit_zLims_Callback(handles.edit_zLims, [], handles);
handles = edit_ScanNum_Callback(handles.edit_ScanNum, [], handles);
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_XCorrScans.
function pushbutton_XCorrScans_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_XCorrScans (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Performing the deletion operation
handles.myData = xcorr_scans(handles.myData, handles.scan_args);
%% 2 - View the figure update
view_data(handles.myData, handles.fig_args);
%% 3 - Ask the user if they want to keep the new cross-correlated data
answer = questdlg('Would you like to store the new Eb(k) data after xcorr summing?', ...
	'Save data as Eb(k) data?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
%% 4 - Updating UI elements that are affected (convert 3D -> 2D ARPES data)
set(findall(handles.uipanel_ScanCorrections, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_3Dplotter, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_3DARPESbrowser, '-property', 'enable'), 'enable', 'off');
set(handles.pushbutton_ViewSeries, 'Enable', 'off');
set(handles.popupmenu_EbType, 'Enable', 'off');
handles = edit_xLims_Callback(handles.edit_xLims, [], handles);
handles = edit_yLims_Callback(handles.edit_yLims, [], handles);
handles = edit_zLims_Callback(handles.edit_zLims, [], handles);
%% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3D PLOTTER  %%%%%%%%%%
% --- Executes on selection change in popupmenu_3Dtype.
function handles = popupmenu_3Dtype_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_3Dtype (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Default parameters
[xField, yField, zField, dField] = find_data_fields(handles.myData);
%% 1 - Extracting the choice of 3D plotting
contents = cellstr(get(hObject,'String'));
handles.view3D_args{1} = lower(string(contents{get(hObject,'Value')}));
%% 2 - Changing the text input depending on what is selected
if handles.view3D_args{1} == "eb(k) video"
    set(handles.statictext_3dLimits,'String', "zLims (scan):");
    default_data = sort([min(handles.myData.(zField)(:)), max(handles.myData.(zField)(:))]);
    default_data = round(default_data,2);
    set(handles.edit_3DLimits,'String', string(default_data(1) + ":" + default_data(2))); 
elseif handles.view3D_args{1} == "eb(k) roi video"
    set(handles.statictext_3dLimits,'String', "[k0:k1,eb0:eb1]:");
    default_data = [min(handles.myData.(xField)(:)), max(handles.myData.(xField)(:)), min(handles.myData.(yField)(:)), max(handles.myData.(yField)(:))];
    default_data = round(default_data,2);
    set(handles.edit_3DLimits,'String', string(default_data(1) + ":" + default_data(2) + "," + default_data(3) + ":" + default_data(4))); 
elseif handles.view3D_args{1} == "isoe video"
    set(handles.statictext_3dLimits,'String', "ylims (eb):");
    default_data = sort([min(handles.myData.(yField)(:))+0.1, max(handles.myData.(yField)(:))-0.1]);
    default_data = round(default_data,2);
    set(handles.edit_3DLimits,'String', string(default_data(1) + ":" + default_data(2))); 
elseif handles.view3D_args{1} == "isoe + eb(k) video"
    set(handles.statictext_3dLimits,'String', "yWin,zLims:");
    default_data = [min(handles.myData.(yField)(:))+0.1, max(handles.myData.(yField)(:))-0.1, min(handles.myData.(zField)(:)), max(handles.myData.(zField)(:))];
    default_data = round(default_data,2);
    set(handles.edit_3DLimits,'String', string(default_data(1) + ":" + default_data(2) + "," + default_data(3) + ":" + default_data(4))); 
elseif handles.view3D_args{1} == "isok video"
    set(handles.statictext_3dLimits,'String', "xLims (tht):");
    default_data = sort([min(handles.myData.(xField)(:))+0.1, max(handles.myData.(xField)(:))-0.1]);
    default_data = round(default_data,2);
    set(handles.edit_3DLimits,'String', string(default_data(1) + ":" + default_data(2))); 
elseif handles.view3D_args{1} == "isok + eb(k) video"
    set(handles.statictext_3dLimits,'String', "xWin,zLims:");
    default_data = [min(handles.myData.(xField)(:))+0.1, max(handles.myData.(xField)(:))-0.1, min(handles.myData.(zField)(:)), max(handles.myData.(zField)(:))];
    default_data = round(default_data,2);
    set(handles.edit_3DLimits,'String', string(default_data(1) + ":" + default_data(2) + "," + default_data(3) + ":" + default_data(4))); 
elseif handles.view3D_args{1} == "3d cube"
    set(handles.statictext_3dLimits,'String', "min. contrast:");
    default_data = min(handles.myData.(dField)(:));
    default_data = round(default_data,2);
    set(handles.edit_3DLimits,'String', string(default_data));
end
%% 3 - Assigning output and printing change
handles.view3D_args{2} = round(default_data,2);
fprintf("--> 3D plot type: " + string(handles.view3D_args{1} + " \n"));
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_3Dtype_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_3Dtype (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
contents = cellstr(get(hObject,'String'));
handles.view3D_args{1} = lower(string(contents{1}));
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_3DLimits_Callback(hObject, ~, handles)
% hObject    handle to edit_3DLimits (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Default parameters
[xField, yField, zField, dField] = find_data_fields(handles.myData);
%% 1 - Extracting the input defined by user
data_entry = round(str2num(strrep(get(hObject,'String'),':',' ')), 2);
%% 2 - Validity check
% - Validity check for 'eb(k)' plot
if handles.view3D_args{1} == "eb(k) video"
    video_type = "--> eb(k) video; z (scan) limits: ";
    if isempty(data_entry) || length(data_entry) > 2 || length(data_entry) < 2 || size(data_entry, 1) > 1
        data_entry = sort([min(handles.myData.(zField)(:)), max(handles.myData.(zField)(:))]);
    else
        data_entry = sort(data_entry);
        if data_entry(1) < min(handles.myData.(zField)(:)) || data_entry(1) > max(handles.myData.(zField)(:)); data_entry(1) = min(handles.myData.(zField)(:)); end
        if data_entry(2) < min(handles.myData.(zField)(:)) || data_entry(2) > max(handles.myData.(zField)(:)); data_entry(2) = max(handles.myData.(zField)(:)); end
    end
% - Validity check for 'eb(k) roi video' plot
elseif handles.view3D_args{1} == "eb(k) roi video"
    video_type = "--> eb(k) roi video; zoom in on [k0:k1,eb0:eb1]: ";
    if isempty(data_entry) || length(data_entry) > 4 || length(data_entry) < 4 || size(data_entry, 1) > 1
        data_entry = [min(handles.myData.(xField)(:)), max(handles.myData.(xField)(:)), min(handles.myData.(yField)(:)), max(handles.myData.(yField)(:))];
    else
        data_entry(1:2) = sort(data_entry(1:2)); 
        data_entry(3:4) = sort(data_entry(3:4));
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < min(handles.myData.(xField)(:)) || data_entry(1) > max(handles.myData.(xField)(:)); data_entry(1) = min(handles.myData.(xField)(:)); end
        if data_entry(2) < min(handles.myData.(xField)(:)) || data_entry(2) > max(handles.myData.(xField)(:)); data_entry(2) = max(handles.myData.(xField)(:)); end
        if data_entry(3) < min(handles.myData.(yField)(:)) || data_entry(3) > max(handles.myData.(yField)(:)); data_entry(3) = min(handles.myData.(yField)(:)); end
        if data_entry(4) < min(handles.myData.(yField)(:)) || data_entry(4) > max(handles.myData.(yField)(:)); data_entry(4) = max(handles.myData.(yField)(:)); end
    end
% - Validity check for 'isoe video' plot
elseif handles.view3D_args{1} == "isoe video"
    video_type = "--> isoe video; eb window  [eb0:eb1]: ";
    if isempty(data_entry) || length(data_entry) > 2 || length(data_entry) < 2 || size(data_entry, 1) > 1
        data_entry = sort([min(handles.myData.(yField)(:))+0.1, max(handles.myData.(yField)(:))-0.1]);
    else
        data_entry = sort(data_entry);
        if data_entry(1) < min(handles.myData.(yField)(:))+0.1 || data_entry(1) > max(handles.myData.(yField)(:))-0.1; data_entry(1) = min(handles.myData.(yField)(:))+0.1; end
        if data_entry(2) < min(handles.myData.(yField)(:))+0.1 || data_entry(2) > max(handles.myData.(yField)(:))-0.1; data_entry(2) = max(handles.myData.(yField)(:))-0.1; end
    end
% - Validity check for 'isoe + eb(k) video' plot
elseif handles.view3D_args{1} == "isoe + eb(k) video"
    video_type = "--> isoe + eb(k) video; [yWin,zLims]: ";
    if isempty(data_entry) || length(data_entry) > 4 || length(data_entry) < 4 || size(data_entry, 1) > 1
        data_entry = [min(handles.myData.(yField)(:))+0.1, max(handles.myData.(yField)(:))-0.1, min(handles.myData.(zField)(:)), max(handles.myData.(zField)(:))];
    else
        data_entry(1:2) = sort(data_entry(1:2)); 
        data_entry(3:4) = sort(data_entry(3:4));
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < min(handles.myData.(yField)(:))+0.1 || data_entry(1) > max(handles.myData.(yField)(:))-0.1; data_entry(1) = min(handles.myData.(yField)(:))+0.1; end
        if data_entry(2) < min(handles.myData.(yField)(:))+0.1 || data_entry(2) > max(handles.myData.(yField)(:))-0.1; data_entry(2) = max(handles.myData.(yField)(:))-0.1; end
        if data_entry(3) < min(handles.myData.(zField)(:)) || data_entry(3) > max(handles.myData.(zField)(:)); data_entry(3) = min(handles.myData.(zField)(:)); end
        if data_entry(4) < min(handles.myData.(zField)(:)) || data_entry(4) > max(handles.myData.(zField)(:)); data_entry(4) = max(handles.myData.(zField)(:)); end
    end
% - Validity check for 'isok video' plot
elseif handles.view3D_args{1} == "isok video"
    video_type = "--> isok video; k-window  [k0:k1]: ";
    if isempty(data_entry) || length(data_entry) > 2 || length(data_entry) < 2 || size(data_entry, 1) > 1
        data_entry = sort([min(handles.myData.(xField)(:))+0.1, max(handles.myData.(xField)(:))-0.1]);
    else
        data_entry = sort(data_entry);
        if data_entry(1) < min(handles.myData.(xField)(:))+0.1 || data_entry(1) > max(handles.myData.(xField)(:))-0.1; data_entry(1) = min(handles.myData.(xField)(:))+0.1; end
        if data_entry(2) < min(handles.myData.(xField)(:))+0.1 || data_entry(2) > max(handles.myData.(xField)(:))-0.1; data_entry(2) = max(handles.myData.(xField)(:))-0.1; end
    end
% - Validity check for 'isok + eb(k) video' plot
elseif handles.view3D_args{1} == "isok + eb(k) video"
    video_type = "--> isok + eb(k) video; [kWin,zLims]: ";
    if isempty(data_entry) || length(data_entry) > 4 || length(data_entry) < 4 || size(data_entry, 1) > 1
        data_entry = [min(handles.myData.(xField)(:))+0.1, max(handles.myData.(xField)(:))-0.1, min(handles.myData.(zField)(:)), max(handles.myData.(zField)(:))];
    else
        data_entry(1:2) = sort(data_entry(1:2)); 
        data_entry(3:4) = sort(data_entry(3:4));
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < min(handles.myData.(xField)(:))+0.1 || data_entry(1) > max(handles.myData.(xField)(:))-0.1; data_entry(1) = min(handles.myData.(xField)(:))+0.1; end
        if data_entry(2) < min(handles.myData.(xField)(:))+0.1 || data_entry(2) > max(handles.myData.(xField)(:))-0.1; data_entry(2) = max(handles.myData.(xField)(:))-0.1; end
        if data_entry(3) < min(handles.myData.(zField)(:)) || data_entry(3) > max(handles.myData.(zField)(:)); data_entry(3) = min(handles.myData.(zField)(:)); end
        if data_entry(4) < min(handles.myData.(zField)(:)) || data_entry(4) > max(handles.myData.(zField)(:)); data_entry(4) = max(handles.myData.(zField)(:)); end
    end
% - Validity check for '3d cube' plot
elseif handles.view3D_args{1} == "3d cube"
    video_type = "--> 3d cube lower contrast threshold: ";
    if isempty(data_entry) || length(data_entry) > 1
        data_entry = min(handles.myData.(dField)(:));
    else
         % -- Forcing the max / min limits on the entries
        if data_entry < min(handles.myData.(dField)(:)); data_entry = min(handles.myData.(dField)(:)); end
        if data_entry > max(handles.myData.(dField)(:)); data_entry = max(handles.myData.(dField)(:)); end
    end
end
%% 3 - Assigning output and printing change
handles.view3D_args{2}  = round(data_entry, 2);
label = "";
if length(handles.view3D_args{2}) ==1 
    label = label + string(handles.view3D_args{2});
else
    for i = 1:2:length(handles.view3D_args{2})
        if i == length(handles.view3D_args{2})-1; label = label + string(handles.view3D_args{2}(i) + ":" + handles.view3D_args{2}(i+1));
        else; label = label + string(handles.view3D_args{2}(i) + ":" + handles.view3D_args{2}(i+1) +",");
        end
    end
end
set(hObject,'String', label); 
fprintf(video_type + label +"\n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_3DLimits_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_3DLimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.view3D_args{2} = []; 
set(hObject,'String', "[]");
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox_3Dinterp.
function checkbox_3Dinterp_Callback(hObject, ~, handles)
% hObject    handle to checkbox_3Dinterp (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the state of the checkbox
val = get(hObject,'Value');
handles.view3D_args{3} = val;
if val == 1;  fprintf("--> Interpolate Data: True \n");
else; fprintf("--> Interpolate Data: False \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function checkbox_3Dinterp_CreateFcn(hObject, ~, handles)
% hObject    handle to checkbox_3Dinterp (see GCBO)
% handles    empty - handles not created until after all CreateFcns called
%% 1 - Set the default parameters
handles.view3D_args{3} = get(hObject,'Value');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox_3Dsquare.
function checkbox_3Dsquare_Callback(hObject, ~, handles)
% hObject    handle to checkbox_3Dsquare (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the state of the checkbox
val = get(hObject,'Value');
handles.view3D_args{4} = val;
if val == 1;  fprintf("--> Make axes square (equal grid size): True \n");
else; fprintf("--> Make axes square (equal grid size): False \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function checkbox_3Dsquare_CreateFcn(hObject, ~, handles)
% hObject    handle to checkbox_3Dsquare (see GCBO)
% handles    empty - handles not created until after all CreateFcns called
handles.view3D_args{4} = get(hObject,'Value');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox_3Dremap.
function checkbox_3Dremap_Callback(hObject, ~, handles)
% hObject    handle to checkbox_3Dremap (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the state of the checkbox
val = get(hObject,'Value');
handles.view3D_args{5} = val;
if val == 1;  fprintf("--> Remap slices: True \n");
else; fprintf("--> Remap slices: False \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function checkbox_3Dremap_CreateFcn(hObject, ~, handles)
% hObject    handle to checkbox_3Dremap (see GCBO)
% handles    empty - handles not created until after all CreateFcns called
handles.view3D_args{5} = get(hObject,'Value');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_View3Ddata.
function pushbutton_View3Ddata_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_View3Ddata (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Plotting the 3D ARPES data as required
% - 1.1 - Path for 3D ARPES data cube representation
if handles.view3D_args{1} == "3d cube"
    view_3Ddatacube(handles.myData, handles.view3D_args);
% - 1.2 - Path for Eb(k) vs scan parameter video of the data
elseif handles.view3D_args{1} == "eb(k) video"
    view_ebkvideo(handles.myData, handles.view3D_args);
% - 1.3 - Path for Eb(k) vs scan parameter video with a zoom in
elseif handles.view3D_args{1} == "eb(k) roi video"
    view_ebkvideo_zoom(handles.myData, handles.view3D_args);
% - 1.4 - Path for IsoE or isoK slice video of the data
elseif handles.view3D_args{1} == "isoe video" || handles.view3D_args{1} == "isok video"
    view_slicevideo(handles.myData, handles.view3D_args);
% - 1.5 - Path for IsoE or isoK slice + Eb(k) video of the data
elseif handles.view3D_args{1} == "isoe + eb(k) video" || handles.view3D_args{1} == "isok + eb(k) video"
    view_slice_and_ebk_video(handles.myData, handles.view3D_args);
end
%% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3D ARPES DATA BROWSER  %%%%%%%%%%
% --- Executes on slider movement.
function handles = slider_scanSlider_Callback(hObject, ~, handles, plotfig)
% hObject    handle to slider_scanSlider (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Default parameters
if nargin < 4; plotfig =  1; end
if isempty(plotfig); plotfig =  1;  end
%% 1 - Extracting the slider value
handles.fig_args{1} =  floor(get(hObject, 'Value'));
%% 2 - Modifying the text to show the scan number
% - Extracting the current state of analysis
[xField, ~, zField, dField] = find_data_fields(handles.myData);
midX_indx = ceil(0.5*size(handles.myData.(dField), 1));
midY_indx = ceil(0.5*size(handles.myData.(dField), 2));
 % - Modifying the scan text
set(handles.text_scanIndex,'String', handles.fig_args{1});
if string(xField) == "kx"; set(handles.text_scanValue,'String', round(handles.myData.(zField)(midX_indx, midY_indx, handles.fig_args{1}), 2));
else; set(handles.text_scanValue,'String', round(handles.myData.(zField)(handles.fig_args{1}),2));
end
fprintf("--> scanIndex: " + handles.fig_args{1} + " \n");
%% 3 - Plotting the latest ARPES data
if plotfig == 1; fig = view_data(handles.myData, handles.fig_args); end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_scanSlider_CreateFcn(hObject, ~, handles)
% hObject    handle to slider_scanSlider (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%% 1 - Setting the default value
handles.fig_args{1} =  1;
set(hObject,'Value', 1);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_isoSlice_Callback(hObject, ~, handles, plotfig)
% hObject    handle to edit_isoSlice (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Default parameters
if nargin < 4; plotfig = 0; end
if isempty(plotfig); plotfig =  0;  end
%% 1 - Extracting the input defined by user
[xField, yField, ~, ~] = find_data_fields(handles.myData);
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 2);
min_xval = min(handles.myData.(xField)(:))+0.1;
max_xval = max(handles.myData.(xField)(:))-0.1;
min_yval = min(handles.myData.(yField)(:))+0.1;
max_yval = max(handles.myData.(yField)(:))-0.1;
%% 2 - Validity check on input
if handles.fig_args{3} == "IsoE"
    % - If no entry is made, default to the maximum range
    if isempty(data_entry) || length(data_entry) > 2
        data_entry = [min_yval, max_yval];
    % - If a single entry is made, ensure it does not exceed the max / min limits and add a small range
    elseif length(data_entry) == 1
        data_entry = [-0.1, 0.1]+data_entry; 
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < min_yval || data_entry(1) > max_yval; data_entry(1) = min_yval; end
        if data_entry(2) < min_yval || data_entry(2) > max_yval; data_entry(2) = max_yval; end
    % - If a double entry is made, ensure it does not exceed the max / min limits
    elseif length(data_entry) == 2
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < min_yval || data_entry(1) > max_yval; data_entry(1) = min_yval; end
        if data_entry(2) < min_yval || data_entry(2) > max_yval; data_entry(2) = max_yval; end
    end
elseif handles.fig_args{3} == "IsoK"
    % - If no entry is made, default to the maximum range
    if isempty(data_entry) || length(data_entry) > 2
        data_entry = [min_xval, max_xval];
    % - If a single entry is made, ensure it does not exceed the max / min limits and add a small range
    elseif length(data_entry) == 1
        data_entry = [-0.1, 0.1]+data_entry; 
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < min_xval || data_entry(1) > max_xval; data_entry(1) = min_xval; end
        if data_entry(2) < min_xval || data_entry(2) > max_xval; data_entry(2) = max_xval; end
    % - If a double entry is made, ensure it does not exceed the max / min limits
    elseif length(data_entry) == 2
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < min_xval || data_entry(1) > max_xval; data_entry(1) = min_xval; end
        if data_entry(2) < min_xval || data_entry(2) > max_xval; data_entry(2) = max_xval; end
    end
end
%% 3 - Assigning output and printing change
handles.fig_args{2} = round(sort(data_entry), 2); 
set(hObject,'String', string(handles.fig_args{2}(1) + ":" + handles.fig_args{2}(2))); 
fprintf("--> isoSlice: " + string(handles.fig_args{2}(1) + ":" + handles.fig_args{2}(2)) + " \n");
%% 4 - Plotting the latest ARPES data
if plotfig == 1; view_data(handles.myData, handles.fig_args); end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_isoSlice_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_isoSlice (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.fig_args{2} = [-0.1, 0.1]; 
set(hObject,'String', "-0.1:0.1");
%% Update handles structure
guidata(hObject, handles);

% --- Executes on selection change in popupmenu_isoType.
function popupmenu_isoType_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_isoType (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
contents = cellstr(get(hObject,'String'));
handles.fig_args{3} = string(contents{get(hObject,'Value')});
fprintf("--> isoType: " + handles.fig_args{3} + " \n");
%% 2 - Updating iso-slice values
handles = edit_isoSlice_Callback(handles.edit_isoSlice, [], handles, 0);
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_isoType_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_isoType (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
contents = cellstr(get(hObject,'String'));
handles.fig_args{3} = string(contents{1});
set(hObject,'Value', 1);
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox_Remap.
function checkbox_Remap_Callback(hObject, ~, handles)
% hObject    handle to checkbox_Remap (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the state of the checkbox
val = get(hObject,'Value');
handles.fig_args{4} = val;
if val == 1;  fprintf("--> Remap: True \n");
else; fprintf("--> Remap: False \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function checkbox_Remap_CreateFcn(hObject, ~, handles)
% hObject    handle to checkbox_Remap (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% 1 - Set the default parameters
set(hObject,'Value',1);
handles.fig_args{4} = get(hObject,'Value');
%% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STAGE 1 - EB ALIGNMENT  %%%%%%%%%%
% --- Executes on selection change in popupmenu_EbType.
function handles = popupmenu_EbType_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_EbType (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
contents = cellstr(get(hObject,'String'));
handles.align_type_args{1} = string(contents{get(hObject,'Value')});
%% 2 - Validity check of the input
if isfield(handles.myData, 'eb') && handles.myData.Type ~= "Eb(k)"
    set(hObject, 'Enable', 'on'); 
    if handles.align_type_args{1} == "global"; set(handles.edit_EbScan, 'Enable', 'off');
    elseif handles.align_type_args{1} == "realign scan"; set(handles.edit_EbScan, 'Enable', 'on');
    end
else
    set(hObject, 'Enable', 'off'); 
    set(handles.edit_EbScan, 'Enable', 'off');
end
fprintf("--> ebType: " + string(handles.align_type_args{1}) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function handles = popupmenu_EbType_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_EbType (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
contents = cellstr(get(hObject,'String'));
handles.align_type_args{1} = string(contents{1});
set(hObject,'Value', 1);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_EbScan_Callback(hObject, ~, handles)
% hObject    handle to edit_EbScan (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = sort(floor(str2num(strrep(get(hObject,'String'),':',' '))));
%% 2 - Validity check, assigning output and printing change
max_value = size(handles.myData.raw_data, 3);
if isempty(data_entry) || length(data_entry) > 2
    handles.align_type_args{2} = 1;
    set(hObject,'String', handles.align_type_args{2});  
    fprintf("--> EbScan: " + string(handles.align_type_args{2}) + " \n");
elseif length(data_entry) == 1
    if data_entry > max_value; data_entry = max_value;
    elseif data_entry < 1; data_entry = 1;
    end
    handles.align_type_args{2} = data_entry;
    set(hObject,'String', handles.align_type_args{2});  
    fprintf("--> EbScan: " + string(handles.align_type_args{2}) + " \n");
elseif length(data_entry) == 2
        if data_entry(1) < 1; data_entry(1) = 1; end
        if data_entry(2) > max_value; data_entry(2) = max_value; end
        handles.align_type_args{2} = data_entry;
        set(hObject,'String', string(handles.align_type_args{2}(1) + ":" + handles.align_type_args{2}(2))); 
        fprintf("--> EbScan: " + string(handles.align_type_args{2}(1) + ":" + handles.align_type_args{2}(2)) + " \n");
else
    handles.align_type_args{2} = data_entry;
    set(hObject,'String', handles.align_type_args{2});  
    fprintf("--> EbScan: " + string(handles.align_type_args{2}) + " \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_EbScan_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_EbScan (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.align_type_args{2} = 1; 
set(hObject,'String', handles.align_type_args{2});
%5 Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_ebWin_Callback(hObject, ~, handles)
% hObject    handle to edit_ebWin (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(strrep(get(hObject,'String'),':',' ')), 3);
%% 2 - Validity check, assigning output and printing change
if handles.align_type_args{1} == "global"
    if isempty(data_entry) || size(data_entry, 1) > 1 || length(data_entry) > 2
        handles.align_args{1} = []; 
        set(hObject,'String','Auto');  fprintf("--> ebWin: Auto \n");
    elseif length(data_entry) == 1 
        handles.align_args{1} = data_entry;
        set(hObject,'String',handles.align_args{1});  fprintf("--> ebWin: " + string(handles.align_args{1}) + " \n");
    elseif length(data_entry) == 2 && (handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)")
        handles.align_args{1} = data_entry;
        set(hObject,'String', string(handles.align_args{1}(1) + ":" + handles.align_args{1}(2))); 
        fprintf("--> ebWin: " + string(handles.align_args{1}(1) + ":" + handles.align_args{1}(2)) + " \n");
    else
        handles.align_args{1} = []; 
        set(hObject,'String','Auto');  fprintf("--> ebWin: Auto \n");
    end
elseif handles.align_type_args{1} == "realign scan"
    if isempty(data_entry) || size(data_entry, 1) > 1 || length(data_entry) > 1
        handles.align_args{1} = []; 
        set(hObject,'String','Auto');  fprintf("--> ebWin: Auto \n");
    elseif length(data_entry) == 1
        handles.align_args{1} = data_entry; 
        set(hObject,'String',handles.align_args{1});  fprintf("--> ebWin: " + string(handles.align_args{1}) + " \n");
    end
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
handles.align_args{1} = []; set(hObject,'String', 'Auto');
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
    handles.align_args{2} = []; 
    set(hObject,'String','Auto');  fprintf("--> dEWin: [] \n");
else
    handles.align_args{2} = data_entry; 
    set(hObject,'String',handles.align_args{2});  fprintf("--> dEWin: " + string(handles.align_args{2}) + " \n");
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
handles.align_args{2} = []; set(hObject,'String', 'Auto');
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
    handles.align_args{3} = []; 
    set(hObject,'String','Auto');  fprintf("--> dESmooth: [] \n");
else
    handles.align_args{3} = data_entry; 
    set(hObject,'String',handles.align_args{3});  fprintf("--> dESmooth: " + string(handles.align_args{3}) + " \n");
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
handles.align_args{3} = []; set(hObject,'String', 'Auto');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on selection change in popupmenu_feat.
function popupmenu_feat_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_feat (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
contents = cellstr(get(hObject,'String'));
handles.align_args{4} = lower(char(contents{get(hObject,'Value')}));
fprintf("--> feat: " + handles.align_args{4} + " \n");
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
handles.align_args{4} = lower(string(contents{get(hObject,'Value')}));
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExecuteAlign.
function pushbutton_ExecuteAlign_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExecuteAlign (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Executing the Eb alignment operation
handles.myData = align_energy(handles.myData, handles.align_args, handles.align_type_args);
view_data(handles.myData, handles.fig_args);
%% 2 - Ask the user if they want to keep the new aligned data
answer = questdlg('Would you like to store the aligned data?', ...
	'Align data?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
%% 3 - Updating UI elements
set(findall(handles.uipanel_IntNorm, '-property', 'enable'), 'enable', 'on');
if handles.myData.Type ~= "Eb(k)"; set(handles.popupmenu_EbType, 'Enable', 'on'); end
edit_yLims_Callback(handles.edit_yLims, [], handles);
handles = edit_eWin_Callback(handles.edit_eWin, [], handles);
%% Update the handles
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% STAGE 2 - INTENSITY NORMALISATION  %%%%%%%%%%
% --- Executes on selection change in popupmenu_type.
function popupmenu_type_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_type (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the selected content of the popupmenu
contents = cellstr(get(hObject,'String'));
handles.norm_args{1} = lower(string(contents{get(hObject,'Value')}));
fprintf("--> norm. type: " + handles.norm_args{1} + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_type_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
contents = cellstr(get(hObject,'String'));
handles.norm_args{1} = lower(string(contents{get(hObject,'Value')}));
set(hObject,'Value', 1);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_eWin_Callback(hObject, ~, handles)
% hObject    handle to edit_ebWin (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
[~, yField, ~, ~] = find_data_fields(handles.myData);
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 2);
min_eWin = round(min(handles.myData.(yField)(:))+0.2, 1);
max_eWin = round(max(handles.myData.(yField)(:))-0.2, 1);
%% 2 - Validity check on input
 % - If no entry is made, default to the maximum range
if isempty(data_entry) ||  length(data_entry) == 1 || length(data_entry) > 2
    data_entry = [min_eWin, max_eWin];
 % - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 2
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < min_eWin || data_entry(1) > max_eWin; data_entry(1) = min_eWin; end
    if data_entry(2) < min_eWin || data_entry(2) > max_eWin; data_entry(2) = max_eWin; end
end
%% 3 - Assigning output and printing change
handles.norm_args{2} = sort(round(data_entry,2));
set(hObject,'String',string(handles.norm_args{2}(1) + ":" + handles.norm_args{2}(2))); 
fprintf("--> eWin: " + string(handles.norm_args{2}(1) + ":" + handles.norm_args{2}(2)) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_eWin_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_ebWin (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.norm_args{2} = [-5,0]; set(hObject,'String','-5:0'); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_intScale_Callback(hObject, ~, handles)
% hObject    handle to edit_intScale (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = abs(round(str2num(get(hObject,'String')), 3));
%% 2- Validity check
if isempty(data_entry) || length(data_entry) > 1 || size(data_entry, 1) > 1
    handles.norm_args{3} = 0.25; 
else
    handles.norm_args{3} = data_entry;
end
set(hObject,'String', handles.norm_args{3});  
fprintf("--> scale: " + string(handles.norm_args{3}) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_intScale_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_intScale (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.norm_args{3} = 0.25; set(hObject,'String','0.25'); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExecuteNorm.
function pushbutton_ExecuteNorm_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExecuteNorm (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Executing the intensity normalisation operation
handles.myData = normalise_data(handles.myData, handles.norm_args);
view_data(handles.myData, handles.fig_args);
%% 2 - Ask the user if they want to keep the new aligned data
answer = questdlg('Would you like to store the normalised data?', ...
	'Normalise data?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
%% 3 - Setting subsequent panels to active
set(findall(handles.uipanel_KConv, '-property', 'enable'), 'enable', 'on');
%% Save the updated structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STAGE 3 - K CONVERSION  %%%%%%%%%%
% --- Executes when changing the text
function edit_ebref_Callback(hObject, ~, handles)
% hObject    handle to edit_ebref (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(get(hObject,'String')), 3);
%% 2- Validity check
if isempty(data_entry) || length(data_entry) > 1 || size(data_entry, 1) > 1
    handles.conv_args{1} = 0; 
else
    handles.conv_args{1} = data_entry;
end
set(hObject,'String',handles.conv_args{1});  fprintf("--> ebRef: " + string(handles.conv_args{1}) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_ebref_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_ebref (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
set(hObject,'String', 0);
handles.conv_args{1} = str2double(get(hObject,'String'));
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_kxref_Callback(hObject, ~, handles)
% hObject    handle to edit_kxref (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(get(hObject,'String')), 3);
%% 2- Validity check
if isempty(data_entry) || length(data_entry) > 1 || size(data_entry, 1) > 1
    handles.conv_args{2} = 0;
else
    handles.conv_args{2} = data_entry;
end
set(hObject,'String',handles.conv_args{2});  fprintf("--> kxRef: " + string(handles.conv_args{2}) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_kxref_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_kxref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.conv_args{2} = 0; set(hObject,'String', handles.conv_args{2});
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_thtAref_Callback(hObject, ~, handles)
% hObject    handle to edit_thtAref (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(strrep(get(hObject,'String'),':',' ')), 3);
%% 2 - Validity check, assigning output and printing change
if handles.myData.Type == "Eb(k)"
    if isempty(data_entry) || length(data_entry) > 1 || size(data_entry, 1) > 1; handles.conv_args{3} = 0;
    else; handles.conv_args{3} = data_entry;
    end
    set(hObject,'String',handles.conv_args{3});  fprintf("--> thtAref: " + string(handles.conv_args{3}) + " \n");
elseif handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)"
    if isempty(data_entry) || size(data_entry, 1) > 1 || length(data_entry) > 2
        handles.conv_args{3} = 0; 
        set(hObject,'String','0');  fprintf("--> thtAref: 0 \n");
    elseif length(data_entry) == 1 
        handles.conv_args{3} = data_entry;
        set(hObject,'String',handles.conv_args{3});  fprintf("--> thtAref: " + string(handles.conv_args{3}) + " \n");
    elseif length(data_entry) == 2 && (handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)")
        handles.conv_args{3} = data_entry;
        set(hObject,'String', string(handles.conv_args{3}(1) + ":" + handles.conv_args{3}(2))); 
        fprintf("--> thtAref: " + string(handles.conv_args{3}(1) + ":" + handles.conv_args{3}(2)) + " \n");
    else
        handles.conv_args{3} = 0; 
        set(hObject,'String','0');  fprintf("--> thtAref: 0 \n");
    end
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_thtAref_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_thtAref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
set(hObject,'String', 0);
handles.conv_args{3} = str2double(get(hObject,'String'));
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_v000_Callback(hObject, ~, handles)
% hObject    handle to edit_v000 (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = abs(round(str2num(get(hObject,'String')), 3));
%% 2- Validity check
if isempty(data_entry) || length(data_entry) > 1 || size(data_entry, 1) > 1
    handles.conv_args{4} = 12.5700;
else
    handles.conv_args{4} = data_entry;
end
set(hObject,'String',handles.conv_args{4});  fprintf("--> v000: " + string(handles.conv_args{4}) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_v000_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_v000 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
set(hObject,'String', 12.5700);   %used to use 10.9000
handles.conv_args{4} = round(str2double(get(hObject,'String')), 4);
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExecuteConv.
function pushbutton_ExecuteConv_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExecuteConv (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Executing the k-conversion operation
handles.myData = convert_to_k(handles.myData, handles.conv_args);
%% 2 - Updating UI elements
if handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)"
    [~, ~, ~, dField] = find_data_fields(handles.myData);
    set(handles.slider_scanSlider,'min', 1, 'max', size(handles.myData.(dField), 3), 'Value', 1, 'SliderStep', [1/(size(handles.myData.(dField), 3)-1), 1/(size(handles.myData.(dField), 3)-1) ]);
    handles = slider_scanSlider_Callback(handles.slider_scanSlider, [], handles, 0);
    % -- Updating the 3D plot limits
    handles = popupmenu_3Dtype_Callback(handles.popupmenu_3Dtype, [], handles);
    handles = edit_3DLimits_Callback(handles.edit_3DLimits, [], handles);
    handles = edit_isoSlice_Callback(handles.edit_isoSlice, [], handles, 0);
end
handles = edit_xLims_Callback(handles.edit_xLims, [], handles);
handles = edit_yLims_Callback(handles.edit_yLims, [], handles);
handles = edit_zLims_Callback(handles.edit_zLims, [], handles);
%% 3 - View data
view_data(handles.myData, handles.fig_args);
%% Update the handles
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INTERNAL PROCESSING FUNCTIONS %%%%%%%%%%%
% ---  Function to load in a single ARPES data-file that is unprocessed or previously processed
function dataStr = load_arpes_data(FileName)
% dataStr = load_arpes_data(FileName)
%   This function loads in the HDataF5 H5files of ARPES data from 
%   the ADRESS beamline at the SLS. The output is a MATLAB
%   data-structure that yields all the data and information.
%
%   REQ. FUNCTIONS:
%   -   [data, axes, note] = ReaderHDF5(fname);
%   -   [DataXC,OffsE] = SumScanXC(Energy,Data,maxLagE[,WinE]);
%
%   IN:
%   -   FileName:               char of the input .h5 or .mat file-name.
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

disp('Loading ARPES data...')
wbar = waitbar(0, 'Loading in ARPES data...', 'Name', 'load_arpes_data');
wbar.Children.Title.Interpreter = 'none';

%% 1 - Reading in the HDataF5 data
% - Verify that a .h5 file has been parsed and load the variables
if FileName(end-2:end) == '.h5'
    waitbar(0.1, wbar, sprintf('Loading %s...', FileName), 'Name', 'load_arpes_data');
    % -- Defining the MATLAB data-structure
    dataStr = struct;
    dataStr.H5file = char(FileName(1:end-3));
    % -- Extracting all of the data variables
    [Data, Axes, Note] = ReaderHDF5(FileName);
    Angle = Axes{1};
    Energy = (Axes{2})';
    if size(Axes,1)==3; Scan = Axes{3}; else Scan = []; end
    if ndims(Data)==3; Data = double(permute(Data,[2 1 3])); else Data=double(Data'); end
    % -- Identifying the type of scan that has been performed
    % --- If no Scan parameter is initially defined, it is an Eb(k) scan
    if size(Scan, 1) == 0
        dataStr.Type = "Eb(k)";
        % -- Assigning the photon energy (hv)
        tmpPos = strfind(Note,'hv      =');
        for i = 0:1:3
            hv = str2double(Note(tmpPos+9:tmpPos+13-i));
            if ~isnan(hv); break; end
        end
        if isnan(hv); error('hv in load_data not assigned.'); end
        % -- Assigning the tilt angle (Tilt)
        tmpPos = strfind(Note, 'Tilt    =');
        Tilt = str2double(Note(tmpPos+9:tmpPos+17));   
        for i = 0:1:7
            Tilt = str2double(Note(tmpPos+9:tmpPos+17-i));   
            if ~isnan(Tilt); break;end
        end
        if isnan(Tilt);error('Tilt in load_data not assigned.'); end
    % --- If the first and last Scan parameter are identical, multiple Eb(k) scans have been performed
    elseif Scan(1) - Scan(end) == 0
        dataStr.Type = "Eb(k)";
        % -- Assigning the photon energy (hv)
        tmpPos = strfind(Note,'hv      =');
        for i = 0:1:3
            hv = str2double(Note(tmpPos+9:tmpPos+13-i));
            if ~isnan(hv); break; end
        end
        if isnan(hv); error('hv in load_data not assigned.'); end
        % -- Assigning the tilt angle (Tilt)
        tmpPos = strfind(Note, 'Tilt    =');
        Tilt = str2double(Note(tmpPos+9:tmpPos+17));   
        for i = 0:1:7
            Tilt = str2double(Note(tmpPos+9:tmpPos+17-i));   
            if ~isnan(Tilt); break;end
        end
        if isnan(Tilt);error('Tilt in load_data not assigned.'); end
    % --- If the maximum value of the Scan parameter is > 50, it must be Eb(kx,kzs)
    elseif max(Scan(:)) > 50
        dataStr.Type = "Eb(kx,kz)";
        % -- Assigning the photon energy (hv) as the scan parameter
        hv = Scan;
        % -- Assigning the tilt angle (Tilt)
        tmpPos = strfind(Note, 'Tilt    =');
        Tilt = str2double(Note(tmpPos+9:tmpPos+17));   
        for i = 0:1:7
            Tilt = str2double(Note(tmpPos+9:tmpPos+17-i));   
            if ~isnan(Tilt); break;end
        end
        if isnan(Tilt);error('Tilt in load_data not assigned.'); end
    % --- Else the final type remaining is the Eb(kx,ky) scan
    else
        dataStr.Type = "Eb(kx,ky)";
        % -- Assigning the photon energy (hv)
        tmpPos = strfind(Note,'hv      =');
        for i = 0:1:3
            hv = str2double(Note(tmpPos+9:tmpPos+13-i));
            if ~isnan(hv); break; end
        end
        if isnan(hv); error('hv in load_data not assigned.'); end
        % -- Assigning the tilt angle (Tilt) as the scan parameter
        Tilt = Scan;
    end
    %% 1.2 - Extracting the information variables from the Notes
    waitbar(0.25, wbar, 'Extracting information variables...', 'Name', 'load_arpes_data');
    % -- Pass energy (ep) and uncertainty (dE) evaluations
    tmpPos = strfind(Note, 'Epass   =');
    for i = 0:1:3
        ep = str2double(Note(tmpPos+9:tmpPos+12-i));
        if ~isnan(ep); break; end
    end
    if isnan(ep); error('ep in load_data not assigned.'); end
    dHv = 75e-3;
    dEnergy = 0.5*ep/1000;
    % -- Theta Manipulator (Theta) evaluation
    tmpPos = strfind(Note, 'Theta   =');
    for i = 0:1:7
        Theta = str2double(Note(tmpPos+9:tmpPos+17-i));
        if ~isnan(Theta); break; end
    end
    if isnan(Theta); error('Theta in load_data not assigned.'); end
    % -- Temperature (Temp) evaluation
    tmpPos = strfind(Note, 'Temp     =');
    for i = 0:1:5
        Temp = str2double(Note(tmpPos+10:tmpPos+14-i));
        if ~isnan(Temp); break; end
    end
    %% 1.3 - For an Eb(k) scan with multiple scans, cross-correlate them
    if dataStr.Type == "Eb(k)" && size(Data, 3) > 1
        waitbar(0.50, wbar, 'Cross-correlating repeated scans...', 'Name', 'load_arpes_data');
        [xc_Data, ~] =  SumScanXC(Energy, Data, 0.5); 
        xc_Data(isnan(xc_Data)) = 0;
        Data = xc_Data;
    end
    %% 1.4 - Assigning the data to the MATLAB structure
    waitbar(0.75, wbar, 'Assigning ARPES data to MATLAB structure...', 'Name', 'load_arpes_data');
    % - Assigning the meta data
    dataStr.meta.info = Note;
    dataStr.meta.ep = ep;
    % - Assinging the main experimental variables
    dataStr.raw_data = Data;
    dataStr.raw_tht = Angle;
    dataStr.raw_eb = Energy;
    dataStr.deb = dEnergy;
    dataStr.hv = hv;
    dataStr.dhv = dHv;
    dataStr.tltM = Tilt;
    % - Assinging all other experimental variables
    dataStr.thtM = Theta;
    dataStr.Temp = Temp;
    
%% 2 - Reading in the .mat data that has been processed
elseif FileName(end-3:end) == '.mat'
    waitbar(0.5, wbar, sprintf('Loading %s...', FileName), 'Name', 'load_arpes_data');
    arpes_data = load(FileName); 
    dataStr = arpes_data.dataStruc;
end

%% 3 - Removing all processing that may have been performed
% -- Kf analysis
if isfield(dataStr, 'kf'); dataStr = rmfield(dataStr, 'kf'); end
% -- Isoe analysis
if isfield(dataStr, 'isoe'); dataStr = rmfield(dataStr, 'isoe'); end
if isfield(dataStr, 'bz'); dataStr = rmfield(dataStr, 'bz'); end
% -- State-fitting analysis
if isfield(dataStr, 'fits'); dataStr = rmfield(dataStr, 'fits'); end

%% Close wait-bar
close(wbar);

% --- General function to find the stage of the processing
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

% --- Function to crop the ARPES data along any dimension
function dataStr = crop_data(dataStr, xField_lims, yField_lims, zField_lims)
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
wbar = waitbar(0.1, 'Extracting cropping indices...', 'Name', 'crop_data');

%% Default parameters
maxLim = 1e4;
if nargin < 2; xField_lims=[-1 1]*maxLim; yField_lims=[-1 1]*maxLim; zField_lims=[-1 1]*maxLim; end
if nargin < 3; yField_lims=[-1 1]*maxLim; zField_lims=[-1 1]*maxLim; end
if nargin < 4; zField_lims=[-1 1]*maxLim; end
if isempty(xField_lims); xField_lims=[-1 1]*maxLim;  end
if isempty(yField_lims); yField_lims=[-1 1]*maxLim;  end
if isempty(zField_lims); zField_lims=[-1 1]*maxLim;  end
if length(xField_lims) < 2; xField_lims=[-1 1]*maxLim;  end
if length(yField_lims) < 2; yField_lims=[-1 1]*maxLim;  end
if length(zField_lims) < 2; zField_lims=[-1 1]*maxLim;  end
% - Sorting the cropping limits in ascending order
xField_lims = sort(xField_lims);
yField_lims = sort(yField_lims);
zField_lims = sort(zField_lims);
% - Extracting the fields to be used with most recent processing
[xField, yField, zField, dField] = find_data_fields(dataStr);
%% 1 - First determine the zField indices of the crop over scan parameter
if string(zField) == "hv" || string(zField) == "tltM"
    [~, zIndxL] = min(abs(dataStr.(zField)(1,:) - zField_lims(1)));
    [~, zIndxU] = min(abs(dataStr.(zField)(1,:) - zField_lims(2)));
    zField_indx = [zIndxL zIndxU];
else
    thtIndx = ceil(size(dataStr.(dField), 2)/2);
    ebIndx = ceil(size(dataStr.(dField), 1)/2);
    [~, zIndxL] = min(abs(dataStr.(zField)(ebIndx,thtIndx,:) - zField_lims(1)));
    [~, zIndxU] = min(abs(dataStr.(zField)(ebIndx,thtIndx,:) - zField_lims(2)));
    zField_indx = [zIndxL zIndxU];
end
%% 2 - Next determine the xField and yField indices across each scan
for i = 1:diff(zField_indx)+1
    z_index = i  - 1 + min(zField_indx);
    waitbar(i/diff(zField_indx)+1, wbar, 'Extracting cropping indices...', 'Name', 'crop_data');
    %% 2.1 - xField cropping indices
    if string(xField) == "raw_tht"
        [~, xIndx_L] = min(abs(dataStr.(xField)(1,:) - xField_lims(1)));
        [~, xIndx_U] = min(abs(dataStr.(xField)(1,:) - xField_lims(2)));
        xField_indx{i} = [xIndx_L xIndx_U];
    else
        ebIndx = ceil(size(dataStr.(dField), 1)/2);
        [~, xIndx_L] = min(abs(dataStr.(xField)(ebIndx,:,z_index) - xField_lims(1)));
        [~, xIndx_U] = min(abs(dataStr.(xField)(ebIndx,:,z_index) - xField_lims(2)));
        xField_indx{i} = [xIndx_L xIndx_U];
    end
    %% - 2.2 - yField cropping indices
    if string(yField) == "raw_eb"
        [~, yIndx_L] = min(abs(dataStr.(yField)(:,1) - yField_lims(1)));
        [~, yIndx_U] = min(abs(dataStr.(yField)(:,1) - yField_lims(2)));
        yField_indx{i} = [yIndx_L yIndx_U];
    else
        thtIndx = ceil(size(dataStr.(dField), 2)/2);
        [~, yIndx_L] = min(abs(dataStr.(yField)(:,thtIndx,z_index) - yField_lims(1)));
        [~, yIndx_U] = min(abs(dataStr.(yField)(:,thtIndx,z_index) - yField_lims(2)));
        yField_indx{i} = [yIndx_L yIndx_U];
    end
end
%% 3 - Validity check that the cropping indices for x- and y- are consistent
% x-field consistency checks
xField_diff = diff(cat(1, xField_indx{:}),[], 2);
for i = 1:length(xField_diff)
    waitbar(i/length(xField_diff), wbar, 'Validity checks on x-field indices...', 'Name', 'crop_data');
    if xField_diff(i) ~= min(xField_diff)
        xField_indx{i}(1) = xField_indx{i}(1) - floor((min(xField_diff)-xField_diff(i))/2);
        xField_indx{i}(2) = xField_indx{i}(2) + ceil((min(xField_diff)-xField_diff(i))/2);   
    end
end
%y-field consistency checks
yField_diff = diff(cat(1, yField_indx{:}),[], 2);
for i = 1:length(yField_diff)
    waitbar(i/length(yField_diff), wbar, 'Validity checks on y-field indices...', 'Name', 'crop_data');
    if yField_diff(i) ~= min(yField_diff) && yField_diff(i) > min(yField_diff)
        yField_indx{i}(2) = yField_indx{i}(2) - abs(yField_diff(i) - min(yField_diff));        
    elseif yField_diff(i) ~= min(yField_diff) && yField_diff(i)< min(yfield_diff)
        yField_indx{i}(2) = yField_indx{i}(2) + abs(yField_diff(i) - min(yField_diff));        
    end
end
%% 4 - Filing through each scan parameter and applying a subsequent crop to x and y variables
for i = 1:diff(zField_indx)+1
    z_index = i -1 + min(zField_indx);
    waitbar(i/diff(zField_indx)+1, wbar, 'Cropping ARPES data...', 'Name', 'crop_data');
    % - Applying cropping operations
    if string(xField) == "kx"
        crp_xField{i} = dataStr.(xField)(yField_indx{i}(1):yField_indx{i}(2), xField_indx{i}(1):xField_indx{i}(2), z_index);
        crp_yField{i} = dataStr.(yField)(yField_indx{i}(1):yField_indx{i}(2), xField_indx{i}(1):xField_indx{i}(2), z_index);
        crp_dField{i} = dataStr.(dField)(yField_indx{i}(1):yField_indx{i}(2), xField_indx{i}(1):xField_indx{i}(2), z_index);
        if dataStr.Type == "Eb(k)"; crp_zField = dataStr.(zField)(1, zField_indx(1):zField_indx(2));
        elseif dataStr.Type == "Eb(kx,ky)" || dataStr.Type == "Eb(kx,kz)"; crp_zField{i} = dataStr.(zField)(yField_indx{i}(1):yField_indx{i}(2), xField_indx{i}(1):xField_indx{i}(2), z_index); 
        end
        % Cropping other fields for consistency
        crp_thtField{i} = dataStr.tht(yField_indx{i}(1):yField_indx{i}(2), xField_indx{i}(1):xField_indx{i}(2), z_index);
    elseif string(yField) == "eb"
        crp_xField{i} = dataStr.(xField)(yField_indx{i}(1):yField_indx{i}(2), xField_indx{i}(1):xField_indx{i}(2), z_index);
        crp_yField{i} = dataStr.(yField)(yField_indx{i}(1):yField_indx{i}(2), xField_indx{i}(1):xField_indx{i}(2), z_index);
        if i == diff(zField_indx)+1; crp_zField = dataStr.(zField)(1, zField_indx(1):zField_indx(2)); end
        crp_dField{i} = dataStr.(dField)(yField_indx{i}(1):yField_indx{i}(2), xField_indx{i}(1):xField_indx{i}(2), z_index);
    elseif string(xField) == "raw_tht"
        if i == diff(zField_indx)+1
            crp_xField = dataStr.(xField)(1, xField_indx{1}(1):xField_indx{i}(2));
            crp_yField = dataStr.(yField)(yField_indx{1}(1):yField_indx{i}(2), 1);
            crp_zField = dataStr.(zField)(1, zField_indx(1):zField_indx(2));
        end
        crp_dField{i} = dataStr.(dField)(yField_indx{i}(1):yField_indx{i}(2), xField_indx{i}(1):xField_indx{i}(2), z_index);
    end
end
%% 5 - Converting cell arrays into 3D matrices of data
if iscell(crp_xField); crp_xField = cat(3, crp_xField{:});
else; crp_xField = crp_xField; end
if iscell(crp_yField); crp_yField = cat(3, crp_yField{:});
else; crp_yField = crp_yField; end
if iscell(crp_zField); crp_zField = cat(3, crp_zField{:});
else; crp_zField = crp_zField; end
if iscell(crp_dField); crp_dField = cat(3, crp_dField{:});
else; crp_dField = crp_dField; end
%% 6 - Assigning the cropped variables / data to new matrices
% - Assigning the first set of variables
dataStr.(xField) = []; dataStr.(yField) = []; dataStr.(zField) = []; dataStr.(dField) = [];
dataStr.(xField) = crp_xField;
dataStr.(yField) = crp_yField;
dataStr.(zField) = crp_zField;
dataStr.(dField) = crp_dField;
if exist('crp_thtField', 'var'); crp_thtField = cat(3, crp_thtField{:}); dataStr.tht = crp_thtField; end
% - Saving the crop to the meta data
dataStr.meta.crp_lims = [];
dataStr.meta.crp_lims = [xField_lims, yField_lims, zField_lims];
dataStr.meta.crp_xIndx = xField_indx;
dataStr.meta.crp_yIndx = yField_indx;
dataStr.meta.crp_zIndx = zField_indx;
%% Close wait-bar
close(wbar);

% --- Function to filter the ARPES data
function dataStr = filter_data(dataStr, filter_args)
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
dataStr.meta.filter_args = filter_args;
% - Extracting the fields to be used with most recent processing
[~, ~, ~, dField] = find_data_fields(dataStr);
% - Extracting filter parameters
filter_type = filter_args{1};
filter_val =  filter_args{2};
%% 2 - Performing the filtering operation over all scans
for i = 1:size(dataStr.(dField), 3)
    waitbar(i/size(dataStr.(dField), 3), wbar, 'Filtering ARPES data...', 'Name', 'filter_data');
    if filter_type == "Gaco2"
        filtered_data = Gaco2(dataStr.(dField)(:,:,i), filter_val(1), filter_val(2)); 
    elseif filter_type == "GaussFlt2"
        filtered_data = GaussFlt2(dataStr.(dField)(:,:,i), filter_val(1), filter_val(2), 40, 40); 
    elseif filter_type == "LaplaceFlt2"
        filtered_data = GaussFlt2(dataStr.(dField)(:,:,i), 5, 5, 40, 40);
        filtered_data = SetContrast(filtered_data, 0.4, 0.999, 1.5);
        filtered_data = LaplaceFlt2(filtered_data, filter_val(1));
    elseif filter_type == "CurvatureFlt2"
        filtered_data=GaussFlt2(dataStr.(dField)(:,:,i), 100, 100, 500, 500);
        filtered_data = SetContrast(filtered_data, 0.4, 0.999, 1.5);
        filtered_data=CurvatureFlt2(filtered_data, '2D', filter_val(1), filter_val(2));
        filtered_data = GaussFlt2(filtered_data, 1, 1, 10, 10);
        filtered_data = SetContrast(filtered_data, 0.2, 0.999);
    end
    dataStr.(dField)(:,:,i) = filtered_data;
end
%% 3 - Setting NaN values to zero
dataStr.(dField)(isnan(dataStr.(dField))) = 0;
%% Close wait-bar
close(wbar);

% --- Function to delete a scan - *Eb(kx,ky) or Eb(kx,kz) scans only*
function dataStr = delete_scans(dataStr, scan_args)
% dataStr = delete_scans(dataStr, scan_args)
%   This function deletes a single or linear range of scans that contain
%   anomalies. The given input is a vector of all the scan indices of the
%   ARPES scans to be deleted.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%
%   IN:
%   -   dataStr                      loaded MATLAB data structure.
% 	-   scan_args:                1x1 cell of {scan_lims}.
%
%   OUT:
%   -   dataStr:                     ARPES data structure after deleting desired scans.

disp('Deleting ARPES scans...')
wbar = waitbar(0.5, 'Deleting scans...', 'Name', 'delete_scans');

%% Default parameters
dataStr.meta.scan_args = scan_args;
% - Extracting the fields to be used with most recent processing
[xField, yField, zField, dField] = find_data_fields(dataStr);
% - Sorting the cropping limits in ascending order
scan_lims = sort(scan_args{1});
if length(scan_lims) == 1; scan_lims = [scan_lims(1), scan_lims(1)];
end
%% - 1 - EbAlign->Normalise->kConvert fields
if isfield(dataStr, 'kx')
    dataStr.(xField)(:,:,scan_lims) = [];
    dataStr.tht(:,:,scan_lims) = [];
    dataStr.(yField)(:,:,scan_lims) = [];
    dataStr.(zField)(:,:,scan_lims) = [];
    dataStr.(dField)(:,:,scan_lims) = [];
%% - 2 - EbAlign->Normalise fields
elseif isfield(dataStr, 'data')
    dataStr.(xField)(:,:,scan_lims) = [];
    dataStr.(yField)(:,:,scan_lims) = [];
    dataStr.(zField)(scan_lims) = [];
    dataStr.(dField)(:,:,scan_lims) = [];
%% - 3 - EbAlign fields
elseif isfield(dataStr, 'eb')
    dataStr.(xField)(:,:,scan_lims) = [];
    dataStr.(yField)(:,:,scan_lims) = [];
    dataStr.(zField)(scan_lims) = [];
    dataStr.(dField)(:,:,scan_lims) = [];
%% - 4 - Raw, unprocessed data fields
else
    dataStr.(zField)(scan_lims) = [];
    dataStr.(dField)(:,:,scan_lims) = [];
end
%% Close wait-bar
close(wbar);

% --- Function to xcorr sum over scan parameter - *Eb(kx,ky) or Eb(kx,kz) scans only*
function dataStr = xcorr_scans(dataStr, scan_args)
% dataStr = xcorr_scans(dataStr, scan_args)
%   This function cross-correlates the scans over the defined 
%   scan index and converts it from a 3D data set, into a 2D
%   Eb(k) dispersion.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   [DataXC,OffsE] = SumScanXC(Energy,Data,maxLagE[,WinE]);
%
%   IN:
%   -   dataStr:            data structure of the ARPES data.
% 	-   scan_args:       1x1 cell of {scan_lims}.
%
%   OUT:
%   -   dataStr:            ARPES data structure after the cross-correlation of scans.

disp('Data cross-correlation and Eb(k) conversion...')
wbar = waitbar(0.5, 'Executing cross-correlation...', 'Name', 'xcorr_scans');

%% Default parameters
dataStr.meta.scan_args = scan_args;
% - Extracting the fields to be used with most recent processing
[xField, yField, zField, dField] = find_data_fields(dataStr);
% - Sorting the cropping limits in ascending order
scan_lims = sort(scan_args{1});
if length(scan_lims) == 1; scan_lims = [scan_lims(1), scan_lims(1)]; end
mean_scan_indx = ceil(mean(scan_lims));
xcorr_dE = 0.4;
%% 1 - EbAlign->Normalise->kConvert fields
if isfield(dataStr, 'kx')
    % - Finding the indices to squeeze the 3D arrays into 2D
    ebIndx = ceil(size(dataStr.(dField), 1)/2); 
    thtIndx = ceil(size(dataStr.(dField), 2)/2); 
    % - Cross-correlating the ARPES data
    Y = squeeze(dataStr.(yField)(:,thtIndx,mean_scan_indx));
    D = dataStr.(dField)(:,:,scan_lims);
    [DataXC, ~] = SumScanXC(Y, D, xcorr_dE);
    DataXC(isnan(DataXC)) = 0;
    dataStr.(dField) = []; dataStr.(dField) = DataXC;
    % - Squeezing the variable arrays
    dataStr.(xField) = squeeze(dataStr.(xField)(:,:,mean_scan_indx));
    dataStr.tht = squeeze(dataStr.tht(:,:,mean_scan_indx));
    dataStr.(yField) = squeeze(dataStr.(yField)(:,:,mean_scan_indx));
    dataStr.(zField) = squeeze(dataStr.(zField)(ebIndx,thtIndx,mean_scan_indx));
    % - Converting the wave-vector into a single field
    dataStr.ky = mean(dataStr.ky(:));
    dataStr.kz = mean(dataStr.kz(:));
%% 2 - EbAlign->Normalise fields
elseif isfield(dataStr, 'data')
    % - Finding the indices to squeeze the 3D arrays into 2D
    ebIndx = ceil(size(dataStr.(dField), 1)/2); 
    thtIndx = ceil(size(dataStr.(dField), 2)/2); 
    % - Cross-correlating the ARPES data
    Y =squeeze(dataStr.(yField)(:,thtIndx,mean_scan_indx));
    D = dataStr.(dField)(:,:,scan_lims);
    [DataXC, ~] = SumScanXC(Y, D, xcorr_dE);
    DataXC(isnan(DataXC)) = 0;
    dataStr.(dField) = []; dataStr.(dField) = DataXC;
    % - Squeezing the variable arrays
    dataStr.(xField) = squeeze(dataStr.(xField)(:,:,mean_scan_indx));
    dataStr.(yField) = squeeze(dataStr.(yField)(:,:,mean_scan_indx));
    dataStr.(zField) = dataStr.(zField)(mean_scan_indx);
%% 3 - EbAlign fields
elseif isfield(dataStr, 'eb')
    % - Finding the indices to squeeze the 3D arrays into 2D
    ebIndx = ceil(size(dataStr.(dField), 1)/2); 
    thtIndx = ceil(size(dataStr.(dField), 2)/2); 
    % - Cross-correlating the ARPES data
    Y = squeeze(dataStr.(yField)(:,thtIndx,mean_scan_indx));
    D = dataStr.(dField)(:,:,scan_lims);
    [DataXC, ~] = SumScanXC(Y, D, xcorr_dE);
    DataXC(isnan(DataXC)) = 0;
    dataStr.(dField) = []; dataStr.(dField) = DataXC;
    % - Squeezing the variable arrays
    dataStr.(xField) = squeeze(dataStr.(xField)(ebIndx,:,mean_scan_indx));
    dataStr.(yField) = squeeze(dataStr.(yField)(:,thtIndx,mean_scan_indx));
    dataStr.(zField) = dataStr.(zField)(mean_scan_indx);
%% 4 - Raw, unprocessed data fields
else
    % - Squeezing the variable arrays
    dataStr.(zField) = dataStr.(zField)(mean_scan_indx);
    % - Cross-correlating the ARPES data
    [DataXC, ~] = SumScanXC(dataStr.(yField), dataStr.(dField)(:,:,scan_lims), xcorr_dE);
    DataXC(isnan(DataXC)) = 0;
    dataStr.(dField) = []; dataStr.(dField) = DataXC;
end
%% 5 - Setting the identifier to Eb(k) now after XCorr
dataStr.Type = "Eb(k)";
dataStr.tltM = mean(dataStr.tltM);
dataStr.hv = mean(dataStr.hv);
%% Close wait-bar
close(wbar);

% --- Function to perform stage 1 - Eb alignment
function dataStr = align_energy(dataStr, eb_args, type_args)
% dataStr = align_energy(dataStr, eb_args, type_args)
%   This is a function that will align the dataStr ARPES data 
%   to the Fermi-level, VBM or a CB state. It operates using the
%   AlignEF function conditions.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   [EAlign, EF, Fail] = AlignEF(Data, ECorr [,eWin] [,dEWin] [,dESmooth] [,feat]);
%
%   IN:
%   -   dataStr:            data structure of the ARPES data.
%   -   eb_args:         1x4 cell of {eWin, dEWin, dESmooth, feat}.
%   -   type_args:      1x2 cell of {type, Scans}.
%
%   OUT:
%   dataStr - MATLAB data structure with new additional fields below;
%   -   .meta.eb_args:      1x4 cell of input arguments of alignment.
%	-   .(tht):                      aligned 2D or 3D array of theta.
%	-   .(eb):                       aligned 2D or 3D array of energy.

disp('(1) Eb alignment...')
wbar = waitbar(0., 'Executing eb alignment...', 'Name', 'align_energy');

%% Default parameters
% - Extracting the fields to be used with most recent processing
[~, yField, ~, dField] = find_data_fields(dataStr);

%% - 1 - Initialising the alignment parameters
% - Extracting alignment parameters
eWin = eb_args{1};
dEWin =  eb_args{2};
dESmooth =  eb_args{3};
feat =  eb_args{4};
% - Extracting alignment type parameters
type = type_args{1};
Scans = type_args{2};
% - Defining the scan values over the energy alignment for-loop
if type == "global"
    ScanIndx = 1:size(dataStr.(dField), 3);
elseif type == "realign scan"
    if length(Scans) == 1
        ScanIndx = Scans;
    elseif length(Scans) == 2
        ScanIndx = Scans(1):1:Scans(2);
    end
end

% - Defining the alignment variables
aligned_energy = [];

% - Defining a linear fit over eWin if it has a length larger than 1
if length(eWin) > 1
    eWin = linspace(eWin(1), eWin(2), size(dataStr.(dField), 3));
end

%% - 2 - Binding energy alignment over all scans
for i = ScanIndx
    waitbar(i/size(ScanIndx, 2), wbar, 'Aligning ARPES data...', 'Name', 'align_energy');
    % - 2.1 Global Eb alignment
    if type == "global"
        % For a single value of eWin to be used
        if isempty(eWin) || length(eWin)==1
            % If the alignment was previously performed, apply again
            if string(yField) == "eb"
                [aligned_energy(:,1,i), ~, ~] = AlignEF(dataStr.(dField)(:,:,i), dataStr.eb(:,1,i), eWin, dEWin,dESmooth, feat);
            % If no alignment has been performed, do it for the first time
            elseif string(yField) == "raw_eb"
                [aligned_energy(:,1,i), ~, ~] = AlignEF(dataStr.(dField)(:,:,i), dataStr.raw_eb, eWin, dEWin,dESmooth, feat);
            end
        % For an eWin value at each scan between eWin(1) -> eWin(2)
        else
            % If the alignment was previously performed, apply again
            if string(yField) == "eb"
                [aligned_energy(:,1,i), ~, ~] = AlignEF(dataStr.(dField)(:,:,i), dataStr.eb(:,1,i), eWin(i), dEWin,dESmooth, feat);
            % If no alignment has been performed, do it for the first time
            elseif string(yField) == "raw_eb"
                [aligned_energy(:,1,i), ~, ~] = AlignEF(dataStr.(dField)(:,:,i), dataStr.raw_eb, eWin(i), dEWin,dESmooth, feat);
            end
        end
        
    % - 2.2 Eb alignment over defined scans
    elseif type == "realign scan"
            [~, eb_shift, ~] = AlignEF(dataStr.(dField)(:,:,i), dataStr.eb(:,1,i), eWin, dEWin,dESmooth, feat);
            dataStr.eb(:,:,i) = dataStr.eb(:,:,i) - eb_shift;
    end
end
% - Appending new data to the data object
if ~isempty(aligned_energy); dataStr.eb = aligned_energy; end
dataStr.meta.eb_args = eb_args;

%% - 3 - Remapping matrices into 2D or 3D consistent forms
% - 3.1 Remapping to 2D
% - Remapping the dataStr.eb domain to be 2D
if size(dataStr.eb,1) == 1 || size(dataStr.eb,2) == 1
   dataStr.eb=repmat(dataStr.eb,[1, size(dataStr.(dField),2)]);
end

% - 3.2 Remapping to 3D
% - Remapping the dataStr.eb domain to be 3D
if size(dataStr.eb, 3) == 1
   dataStr.eb = repmat(dataStr.eb,[1, 1, size(dataStr.(dField),3)]);
end

% - 3.3 Remap the tht matrix
if ~isfield(dataStr, 'tht')
    dataStr.tht = dataStr.raw_tht;
    % - 3.1 Remapping to 2D
    % - Remapping the dataStr.tht / K domain to be 2D
    if size(dataStr.tht,1) == 1 || size(dataStr.tht,2) == 1
       dataStr.tht=repmat(dataStr.tht,[size(dataStr.(dField),1), 1]);
    end
    % - 3.2 Remapping to 3D
    % - Remapping the dataStr.tht / K domain to be 3D
    if size(dataStr.tht, 3) == 1
       dataStr.tht = repmat(dataStr.tht,[1, 1, size(dataStr.(dField),3)]);
    end
elseif size(dataStr.tht, 1) == 1
    dataStr.tht = dataStr.raw_tht;
    % - 3.1 Remapping to 2D
    % - Remapping the dataStr.tht / K domain to be 2D
    if size(dataStr.tht,1) == 1 || size(dataStr.tht,2) == 1
       dataStr.tht=repmat(dataStr.tht,[size(dataStr.(dField),1), 1]);
    end
    % - 3.2 Remapping to 3D
    % - Remapping the dataStr.tht / K domain to be 3D
    if size(dataStr.tht, 3) == 1
       dataStr.tht = repmat(dataStr.tht,[1, 1, size(dataStr.(dField),3)]);
    end
end
%% Close wait-bar
close(wbar);

% --- Function to perform stage 2 - Intensity Normalisation
function dataStr = normalise_data(dataStr, norm_args)
% dataStr = normalise_data(dataStr, norm_args)
%   This is a function that will normalise the ARPES data using several
%   different types (standard, max, mean, global max) over a given energy
%   window.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   DataC=SetContrast(Data,minFrac,maxFrac [,gamma]);
%
%   IN:
%   -   dataStr:            data structure of the ARPES data.
%   -   norm_args:      1x3 cell of {type, mdcWin, edcScale}.
%
%   OUT:
%   dataStr - MATLAB data structure with new additional fields below;
%   -   .meta.eb_args:          1x4 cell of input arguments of alignment.
%   -   .meta.norm_args:     1x3 cell of input arguments.
%	-   .(data):                        2D or 3D array of the normalised data.

disp('(2) Intensity normalisation...')
wbar = waitbar(0., 'Executing intensity normalisation...', 'Name', 'normalise_data');

%% Default parameters
% - Extracting the fields to be used with most recent processing
[xField, yField, ~, dField] = find_data_fields(dataStr);

%% - 1 - Initialising the normalisation parameters
% - Extracting normalisation parameters
norm_type = norm_args{1};
mdcWin = norm_args{2};
edcScale = norm_args{3};
% - Defining the normalisation variables
if length(mdcWin) == 1
    eWin = mdcWin + [-0.1, 0.1];
elseif length(mdcWin) == 2
    eWin = mdcWin;
end

%% - 2 -Data normalisation over all scans
for i = 1:size(dataStr.(dField), 3)
    waitbar(i/size(dataStr.(dField), 3), wbar, 'Normalising ARPES data...', 'Name', 'normalise_data');
    % - Extracting x-domain range
    minX = min(min(dataStr.(xField)(:,:,i))); maxX = max(max(dataStr.(xField)(:,:,i)));
    xRange = [0.95*minX+0.05*maxX 0.05*minX+0.95*maxX];
    % - Extracting the integrated MDC slice over the energy location
    [~, DSlice1] = Cut(dataStr.(xField)(:,:,i), dataStr.(yField)(:,:,i), dataStr.(dField)(:,:,i), 'mdc', eWin);
    % - HWHM adjusted to suppress uneven sensitivity of the CCD channels
    DSlice1 = Gaco2(DSlice1, 10, 0);
    % - Dividing the intensity to normalize to the energy window
    if norm_type == "standard"
        for j = 1:size(dataStr.(dField), 1)
            dataStr.data(j,:,i) = dataStr.(dField)(j,:,i) ./ DSlice1;
        end        
    elseif norm_type == "max"
        dataStr.data(:,:,i) = dataStr.(dField)(:,:,i) / max(max(dataStr.(dField)(:,:,i)));
    elseif norm_type == "mean"
        dataStr.data(:,:,i) = dataStr.(dField)(:,:,i) / mean(DSlice1(:));
    elseif norm_type == "global max"
        dataStr.data = dataStr.(dField) / max(max(max(dataStr.(dField))));
    end
    % - Subtracting angle integrated spectrum
   if edcScale ~= 0 && norm_type ~= "global max"
        [~, ISubtr] = Cut(dataStr.(xField)(:,:,i), dataStr.(yField)(:,:,i), dataStr.(dField)(:,:,i), 'edc', xRange);
        for j = 1:size(dataStr.(dField), 2)
            dataStr.data(:,j,i) = dataStr.(dField)(:,j,i) - edcScale * ISubtr;
        end   
   end
end
% - Forcing minimum value across all scans to be zero
dataStr.data = dataStr.data - min(min(min(dataStr.data)));
% - Forcing maximum value across all scans to be unity
dataStr.data = dataStr.data / max(max(max(dataStr.data)));
% - Appending new data to the data object
dataStr.meta.norm_args = norm_args;
%-Setting NaN values to zero
dataStr.data(isnan(dataStr.data)) = 0;
% - Setting the contrast
for i = 1:size(dataStr.(dField), 3)
    dataStr.data(:,:,i) = SetContrast(dataStr.data(:,:,i),0.05,1.);
end
%% Close wait-bar
close(wbar);

% --- Function to perform stage 3 - wavevector conversions
function dataStr = convert_to_k(dataStr, kconv_args)
% dataStr = convert_to_k(dataStr, kconv_args)
%   This is a function that will convert the angles thtA into kx and the
%   scan parameters into either ky (for tltM) or kz (for hv). 
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   surfNormX = SurfNormX(hv, eB_ref, kx_ref, thtM, thtA_ref) calculates the surface normal angle in the MP.
%   -   Kxx = Kxx(HV, Eb, thtM, ThtA, surfNormX) calculates k// in the MP.
%   -   Kyy = Kyy(HV, Eb, thtM, TltM, surfNormX) calculates k// in the MP.
%   -   Kzz = Kzz(HV, Eb, thtM, ThtA, TltM, v000, surfNormX) calculates kz along the surface normal.
%
%   IN:
%   -   dataStr:          data structure of the ARPES data.
%   -   kconv_args:   1x4 cell of {eB_ref, kx_ref, thtA_ref, v000}.
%
%   OUT:
%   dataStr - MATLAB data structure with new additional fields below;
%   -   .(surfNormX):    double or vector of surface normal vector.
%   -   .(kx):                  2D or 3D array of kx from the Theta angle.
%	-   .(ky):                   2D or 3D array of kx from the Tilt angle.
%	-   .(kz):                   2D or 3D array of kx from the Photon Energy.

disp('(3) Wave-vector conversions...')
wbar = waitbar(0., 'Executing wave-vector conversions...', 'Name', 'convert_to_k');

%% - 1 - Initialising the k conversion parameters
dataStr.meta.kconv_args = kconv_args;
% - Extracting conversion parameters
eB_ref = kconv_args{1};
kx_ref = kconv_args{2};
thtA_ref = kconv_args{3};
v000 = kconv_args{4};
%% - 2 -Wave-vector conversions over all scans
% - 2.1 Wave-vector conversions for Eb(k)
if dataStr.Type == "Eb(k)"
    if length(thtA_ref) == 2; thtA_ref = thtA_ref(1); end
    waitbar(0.5, wbar, 'Executing Eb(k) wave-vector conversions...', 'Name', 'convert_to_k');
    dataStr.surfNormX = SurfNormX(dataStr.hv, eB_ref, kx_ref, dataStr.thtM, thtA_ref);
    dataStr.kx = Kxx(dataStr.hv, dataStr.eb, dataStr.thtM, dataStr.tht, dataStr.surfNormX);
    dataStr.ky = Kyy(dataStr.hv, dataStr.eb, dataStr.tht, dataStr.thtM, dataStr.tltM, dataStr.surfNormX);
    dataStr.kz = Kzz(dataStr.hv, dataStr.eb, dataStr.thtM, dataStr.tht, dataStr.tltM, v000, dataStr.surfNormX);
    % Finding the mean value of ky and kz
    dataStr.ky = mean(dataStr.ky(:));
    dataStr.kz = mean(dataStr.kz(:));

% - 2.2 Wave-vector conversions for Eb(kx,ky)
elseif dataStr.Type == "Eb(kx,ky)"
    if length(thtA_ref) == 2; thtA_ref = linspace(thtA_ref(1), thtA_ref(2), size(dataStr.tltM, 2));
    else; thtA_ref = ones(size(dataStr.tltM, 2))*thtA_ref(1); 
    end
    for i = 1:size(dataStr.tltM, 2)
        waitbar(i/size(dataStr.tltM, 2), wbar, 'Executing Eb(kx,ky) wave-vector conversions...', 'Name', 'convert_to_k');
        dataStr.surfNormX(i) = SurfNormX(dataStr.hv, eB_ref, kx_ref, dataStr.thtM, thtA_ref(i));
        dataStr.kx(:,:,i) = Kxx(dataStr.hv, dataStr.eb(:,:,i), dataStr.thtM, dataStr.tht(:,:,i), dataStr.surfNormX(i));
        dataStr.ky(:,:,i) = Kyy(dataStr.hv, dataStr.eb(:,:,i), dataStr.tht(:,:,i), dataStr.thtM, dataStr.tltM(i), dataStr.surfNormX(i));
        dataStr.kz(:,:,i) = Kzz(dataStr.hv, dataStr.eb(:,:,i), dataStr.thtM, dataStr.tht(:,:,i), dataStr.tltM(i), v000, dataStr.surfNormX(i));
    end

% - 2.3 Wave-vector conversions for Eb(kx,kz)
elseif dataStr.Type == "Eb(kx,kz)"
    if length(thtA_ref) == 2; thtA_ref = linspace(thtA_ref(1), thtA_ref(2), size(dataStr.hv, 2)); 
    else; thtA_ref = ones(size(dataStr.hv, 2))*thtA_ref(1); 
    end
    for i = 1:size(dataStr.hv, 2)
        waitbar(i/size(dataStr.hv, 2), wbar, 'Executing Eb(kx,kz) wave-vector conversions...', 'Name', 'convert_to_k');
        dataStr.surfNormX(i) = SurfNormX(dataStr.hv(i), eB_ref, kx_ref, dataStr.thtM, thtA_ref(i));
        dataStr.kx(:,:,i) = Kxx(dataStr.hv(i), dataStr.eb(:,:,i), dataStr.thtM, dataStr.tht(:,:,i), dataStr.surfNormX(i));
        dataStr.ky(:,:,i) = Kyy(dataStr.hv(i), dataStr.eb(:,:,i), dataStr.tht(:,:,i), dataStr.thtM, dataStr.tltM, dataStr.surfNormX(i));
        dataStr.kz(:,:,i) = Kzz(dataStr.hv(i), dataStr.eb(:,:,i), dataStr.thtM, dataStr.tht(:,:,i), dataStr.tltM, v000, dataStr.surfNormX(i));
    end
end
%% Close wait-bar
close(wbar);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INTERNAL PLOT FUNCTIONS %%%%%%%%%%%%%%%%
% --- Constant, global formatting for the figures
function gca_properties(type)
% gca_properties(type)
%   This function outlines the consistent axes and figure
%   parameters to be used. Each field can be edited to what
%   the user desires. Specific inputs are used to isolate the
%   different types of figures that are plotted.
%
% IN:
%   -   type:	string of either "theta" or "kx" for the x-axis label

%% Default parameters
if nargin < 1; type="raw_tht"; end
if isempty(type); type="raw_tht";  end

%% 1 - Defining the axes properties
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
ax.Color = [0, 0, 0];
ax.LineWidth = 1.5;
ax.Box = 'off'; ax.Layer = 'Top';
% Axis labels and limits
if type == "raw_tht" || type == "tht"
    xlabel('$$ \bf  \theta (^{\circ}) $$', 'Interpreter', 'latex');
elseif type == "kx"
    xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
end
ylabel('$$ \bf  E_B (eV) $$', 'Interpreter', 'latex');
%% 2 - Defining the figure properties
fig = gcf; fig.Color = [1 1 1]; fig.InvertHardcopy = 'off';
%% 3 - Colorbar properties
colormap hot;
cb = colorbar; 
% Colorbar font properties
cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
cb.TickLabelInterpreter = 'latex';
cb.TickLength = 0.04; cb.TickDirection = 'out';
% Colorbar position properties
pos = get(cb, 'Position'); cb.Position = [1.09*pos(1) 7.0*pos(2) 0.03 0.1];
% Colorbar box properties
cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
%% 4 - Plotting the x- and y-axes
xl = xlim; yl = ylim;
axis([xl(1), xl(2), yl(1), yl(2)]);
line([0 0], [-1e5, 1e5], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
line([-1e5, 1e5], [0 0], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');

% --- General function to view all ARPES data
function fig = view_data(dataStr, fig_args)
% fig = view_data(dataStr, fig_args)
%   This function plots the ARPES data in the form of D(X,Y)
%   for 2D data, or D(X,Y,Z) for 3D data. The 2D data takes the
%   forms of an image in a single figure, whereas the 3D data
%   is plotted in a dedicated MATLAB GUI that allows the user to
%   browse through all the dimensions easily. This function ensures
%   that the most recent processing is shown in the figure.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   gca_properties(type)
%   -   [h=] ImData(X,Y,Z[,style])
%   -   view_2D_data(dataStr)
%   -   view_3D_data(dataStr, fig_args)
%
%   IN:
%   -   dataStr:          data structure of the ARPES data.
%   -   fig_args:        empty for 2D or 1x4 cell of {scanIndex, isoSlice, isoType, remap} for 3D.
%
%   OUT:
%   -   fig:                  MATLAB figure object with the ARPES data plotted.

%% Default parameters
if nargin < 2; fig_args = cell(1,4); end
if isempty(fig_args); fig_args = cell(1,4);  end

%% 1 - Plotting ARPES data
fig = figure();

% - For an Eb(k) scan type
if dataStr.Type == "Eb(k)"
    % -- Plotting the Eb(k) figure object
    if isfield(dataStr, 'kx'); set(fig, 'Name', 'Eb(k): A, N, K');
    elseif isfield(dataStr, 'data'); set(fig, 'Name', 'Eb(k): A, N');
    elseif isfield(dataStr, 'eb'); set(fig, 'Name', 'Eb(k): A');
    else; set(fig, 'Name', 'Eb(k): Raw');
    end
    % -- Plotting the 2D ARPES data
    view_2D_data(dataStr);
    
% - For a 3D Eb(kx,ky) scan type
elseif dataStr.Type == "Eb(kx,ky)"
    % -- Plotting the Eb(kx,ky) figure object
    if isfield(dataStr, 'kx'); set(fig, 'Name', 'Eb(kx,ky): A, N, K');
    elseif isfield(dataStr, 'data'); set(fig, 'Name', 'Eb(kx,ky): A, N');
    elseif isfield(dataStr, 'eb'); set(fig, 'Name', 'Eb(kx,ky): A');
    else; set(fig, 'Name', 'Eb(kx,ky): Raw');
    end
    set(fig, 'Position', [1,1,850,450]);
    % -- Plotting the 3D ARPES data
    view_3D_data(dataStr, fig_args);
    
% - For a 3D Eb(kx,kz) scan type
elseif dataStr.Type == "Eb(kx,kz)"
    % -- Plotting the Eb(kx,kz) figure object
    if isfield(dataStr, 'kx'); set(fig, 'Name', 'Eb(kx,kz): A, N, K');
    elseif isfield(dataStr, 'data'); set(fig, 'Name', 'Eb(k): A, N');
    elseif isfield(dataStr, 'eb'); set(fig, 'Name', 'Eb(kx,kz): A');
    else; set(fig, 'Name', 'Eb(kx,kz): Raw');
    end
    set(fig, 'Position', [1,1,850,450]);
    % - Plotting the 3D ARPES data
    view_3D_data(dataStr, fig_args);
    
end

% --- General function to view 2D ARPES data - *'Eb(kx)' scans only*
function view_2D_data(dataStr)
% view_2D_data(dataStr)
%   This function plots the 2D ARPES spectrum in the form of D(X,Y), along
%   with a consistent formatting.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   gca_properties(type)
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   dataStr:          data structure of the ARPES data.
%
%   OUT:
%   -   figure output.

%% Default parameters
% - Extracting the fields to be used with most recent processing
[xField, yField, ~, dField] = find_data_fields(dataStr);
%% 1 - Plotting the 2D ARPES spectra
ImData(dataStr.(xField), dataStr.(yField), dataStr.(dField));
%% 2 - Formatting the figure
gca_properties(string(xField));
title(string(dataStr.H5file), 'interpreter', 'none', 'fontsize', 12);

% --- General function to view 3D ARPES data - *'Eb(kx,ky)' or 'Eb(kx,kz)' scans only*
function view_3D_data(dataStr, fig_args)
% view_3D_data(dataStr, fig_args)
%   This function plots the 3D ARPES data that is in the form 
%   D(X,Y,Z) into a single figure that includes the Eb(k) dispersion
%   and an IsoK or IsoE slice.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   [h=] ImData(X,Y,Z[,style])
%   -   [DSlice,XSlice]=Slice(ACorr,ECorr,Data,xMode,Win) 
%   -   [XR,YR,DataR] = Remap(XM,YM,Data)
%
%   IN:
%   -   dataStr:          data structure of the ARPES data.
%   -   fig_args:        1x4 cell of {scanIndex, isoSlice, isoType, remap}.
%
%   OUT:
%   -   figure output.

%% Default parameters
% - Extracting the fields to be used with most recent processing
[xField, yField, zField, dField] = find_data_fields(dataStr);
% - Capping the window to the max/min of the ARPES data
if isempty(fig_args{2}); WinLims = [-0.1, 0.1];
else; WinLims = sort(fig_args{2});
end
step_size = 0.05;
if fig_args{3} == "IsoE"
    if WinLims(1) < min(dataStr.(yField)(:)); WinLims(1) = min(dataStr.(yField)(:))+step_size; end
    if WinLims(2) > max(dataStr.(yField)(:)); WinLims(2) = max(dataStr.(yField)(:))-step_size; end
elseif fig_args{3} == "IsoK"
    if WinLims(1) < min(dataStr.(xField)(:)); WinLims(1) = min(dataStr.(xField)(:))+step_size; end
    if WinLims(2) > max(dataStr.(xField)(:)); WinLims(2) = max(dataStr.(xField)(:))-step_size; end
end
%% 1 - Extracting the Iso slices
if fig_args{3} == "IsoE"
    [DSlice, XSlice] = Slice(dataStr.(xField), dataStr.(yField), dataStr.(dField), 'IsoE', WinLims);
    % - Extracting the scan parameter variables
    if isfield(dataStr, 'kx'); init = ceil(0.5*size(dataStr.(dField), 2)); YSlice = squeeze(dataStr.(zField)(init,:,:))';
    else; YSlice = squeeze(dataStr.(zField))'; YSlice = repmat(YSlice, [1, size(XSlice, 2)]);
    end
elseif fig_args{3}== "IsoK"    
    [DSlice, YSlice] = Slice(dataStr.(xField), dataStr.(yField), dataStr.(dField), 'IsoK', WinLims);
    % - Extracting the scan parameter variables
    if isfield(dataStr, 'kx'); init = ceil(0.5*size(dataStr.(dField), 2)); XSlice = squeeze(dataStr.(zField)(:,init,:));
    else; XSlice = squeeze(dataStr.(zField))'; XSlice = repmat(XSlice, [1, size(YSlice, 1)])';
    end
end

%% 2 - Re-mapping the Iso slices onto a square grid if required
if fig_args{4} == 1
     [XSlice, YSlice, DSlice] = Remap(XSlice, YSlice, DSlice);
     YSlice = YSlice';
     % DSlice(isnan(DSlice)) = 0;
end

%% 3 - Plotting the Eb(k) at the scan value
subplot(1,2,1); hold on;
% -- The plot depends on how far in the analysis 
if isfield(dataStr, 'kx')
    ImData(dataStr.(xField)(:,:,fig_args{1}), dataStr.(yField)(:,:,fig_args{1}), dataStr.(dField)(:,:,fig_args{1}));
elseif isfield(dataStr, 'data') || isfield(dataStr, 'eb')
    ImData(dataStr.(xField)(:,:,fig_args{1}), dataStr.(yField)(:,:,fig_args{1}), dataStr.(dField)(:,:,fig_args{1}));
else
    ImData(dataStr.(xField), dataStr.(yField), dataStr.(dField)(:,:,fig_args{1}));
end
gca_properties(string(xField)); colorbar('off');
axis([min(dataStr.(xField)(:)), max(dataStr.(xField)(:)),min(dataStr.(yField)(:)), max(dataStr.(yField)(:))]);
% -- Plotting an outline over the integrated sliced region
if fig_args{3}== "IsoE"
    patch([-1e3, 1e3, 1e3, -1e3, -1e3], [WinLims(1), WinLims(1), WinLims(2), WinLims(2), WinLims(1)],...
        [0 1 0], 'linewidth', 1, 'facealpha', 0, 'edgecolor', [0 1 0]);
elseif fig_args{3}== "IsoK"
    patch([WinLims(1), WinLims(1), WinLims(2), WinLims(2), WinLims(1)],[-1e3, 1e3, 1e3, -1e3, -1e3],...
        [0 1 0], 'linewidth', 1, 'facealpha', 0, 'edgecolor', [0 1 0]);
end    
% -- Adding title to the figure
title(sprintf(string(dataStr.H5file) + "; scan %i", fig_args{1}), 'interpreter', 'none', 'fontsize', 12);
% -- Colorbar properties
colormap hot;
cb = colorbar; 
% Colorbar font properties
cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
% Colorbar tick properties
cb.TickLabelInterpreter = 'latex';
cb.TickLength = 0.04; cb.TickDirection = 'out';
cb.YAxisLocation = 'right';
% Colorbar position properties
pos = get(cb, 'Position'); cb.Position = [0.17*pos(1) 7.5*pos(2) 0.02 0.1];
% Colorbar box properties
cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;

%% 4 - Plotting the Iso-Slice
subplot(1,2,2); hold on;
% - Plotting the Iso slices
ImData(XSlice, YSlice, DSlice);
% - Formatting the figure
minC = min(DSlice(:)); maxC = max(DSlice(:));
caxis([minC, maxC]);
axis([min(XSlice(:)), max(XSlice(:)), min(YSlice(:)), max(YSlice(:))]);
gca_properties(string(xField)); colorbar('off');
% - Re-labelling the axes depending on what slice is taken
if fig_args{3}== "IsoE"
    if dataStr.Type == "Eb(kx,ky)"
        if isfield(dataStr, 'kx'); xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex'); ylabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex'); 
        else; xlabel('$$ \bf  \theta (^{\circ}) $$', 'Interpreter', 'latex'); ylabel('$$ \bf  \tau (^{\circ}) $$', 'Interpreter', 'latex');
        end
    elseif dataStr.Type == "Eb(kx,kz)"
        if isfield(dataStr, 'kx'); xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex'); ylabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex'); 
        else; xlabel('$$ \bf  \theta (^{\circ}) $$', 'Interpreter', 'latex'); ylabel('$$ \bf  hv (eV) $$', 'Interpreter', 'latex');
        end
    end
elseif fig_args{3}== "IsoK"
    ylabel('$$ \bf  E_B (eV) $$', 'Interpreter', 'latex'); 
    if dataStr.Type == "Eb(kx,ky)"
        if isfield(dataStr, 'kx'); xlabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex');
        else; xlabel('$$ \bf  \tau (^{\circ}) $$', 'Interpreter', 'latex');
        end
    elseif dataStr.Type == "Eb(kx,kz)"
        if isfield(dataStr, 'kx'); xlabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex'); 
        else; xlabel('$$ \bf  hv (eV) $$', 'Interpreter', 'latex');
        end
    end
end
% -- Adding title to the figure
title(sprintf(string(dataStr.H5file) + "; %s; [%.2f,%.2f]", fig_args{3}, fig_args{2}(1),fig_args{2}(2)), 'interpreter', 'none', 'fontsize', 12);
% -- Colorbar properties
colormap hot;
cb = colorbar; 
% Colorbar font properties
cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
% Colorbar tick properties
cb.TickLabelInterpreter = 'latex';
cb.TickLength = 0.04; cb.TickDirection = 'out';
% Colorbar position properties
pos = get(cb, 'Position'); cb.Position = [1.08*pos(1) 7.5*pos(2) 0.02 0.1];
% Colorbar box properties
cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
%% 5 - Extracting the curve formed by the Eb(k) scan slice being looked at
if fig_args{3}== "IsoE"
    initIndx = floor(0.5*size(dataStr.(dField), 1));
    if isfield(dataStr, 'kx')
        x_curve = squeeze(dataStr.(xField)(initIndx,:,fig_args{1}));
        y_curve = squeeze(dataStr.(zField)(initIndx,:,fig_args{1}));
    elseif isfield(dataStr, 'data') || isfield(dataStr, 'eb')
        x_curve = squeeze(dataStr.(xField)(initIndx,:,fig_args{1}));
        y_curve = repmat(squeeze(dataStr.(zField)(fig_args{1})), size(x_curve));
    else
        x_curve = squeeze(dataStr.(xField));
        y_curve = repmat(squeeze(dataStr.(zField)(fig_args{1})), size(x_curve));
    end
    % - Fitting a 4th order polynomial to the slice curve
    x_interp = linspace(min(x_curve(:))-1e2, max(x_curve(:))+1e2, 1e3);
    y_interp = polyval(polyfit(x_curve,y_curve,4),x_interp);
elseif fig_args{3}== "IsoK"
    initIndx = floor(0.5*size(dataStr.(dField), 2));
    if isfield(dataStr, 'kx')
        y_curve = squeeze(dataStr.(yField)(:,initIndx,fig_args{1}));
        x_curve = squeeze(dataStr.(zField)(:,initIndx,fig_args{1}));
        x_interp = linspace(min(x_curve(:))-5, max(x_curve(:))+5, 1e3);
        y_interp = polyval(polyfit(x_curve,y_curve,1),x_interp);
    elseif isfield(dataStr, 'data') || isfield(dataStr, 'eb')
        y_curve = squeeze(dataStr.(yField)(:,initIndx,fig_args{1}));
        x_curve = repmat(squeeze(dataStr.(zField)(fig_args{1})), size(y_curve));
        x_interp = ones(size(x_curve))*mean(x_curve(:));
        y_interp = linspace(-1e3, 1e3, size(x_interp, 1));
    else
        y_curve = squeeze(dataStr.(yField));
        x_curve = repmat(squeeze(dataStr.(zField)(fig_args{1})), size(y_curve));
        x_interp = ones(size(x_curve))*mean(x_curve(:));
        y_interp = linspace(-1e3, 1e3, size(x_interp, 1));
    end
end
% Plotting the scan slice curve
plot(x_interp, y_interp, 'Color', [0 0 1], 'LineWidth', 1., 'Linestyle', '-');

% --- General function to view a series of all scans from 3D ARPES data - *Eb(kx,ky) or Eb(kx,kz) scans only*
function view_data_series(dataStr)
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
            % - 2.2 - EbAlign->Normalise fields
            elseif isfield(dataStr, 'data')
                ImData(dataStr.(xField)(1:step_size:end,1:step_size:end,n), dataStr.(yField)(1:step_size:end,1:step_size:end,n), dataStr.(dField)(1:step_size:end,1:step_size:end,n));
                title(sprintf('scan = %.2f', dataStr.(zField)(n)), 'fontsize', 10);
            % - 2.3 - EbAlign fields
            elseif isfield(dataStr, 'eb')
                ImData(dataStr.(xField)(1:step_size:end,1:step_size:end,n), dataStr.(yField)(1:step_size:end,1:step_size:end,n), dataStr.(dField)(1:step_size:end,1:step_size:end,n));
                title(sprintf('scan = %.2f', dataStr.(zField)(n)), 'fontsize', 10);
            % - 2.4 - Raw, unprocessed data fields
            else
                ImData(dataStr.(xField)(1:step_size:end), dataStr.(yField)(1:step_size:end), dataStr.(dField)(1:step_size:end,1:step_size:end,n));
                title(sprintf('scan = %.2f', dataStr.(zField)(n)), 'fontsize', 10);
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
                cb.Position = [0.92, 0.8, 0.02 0.1];
                % Colorbar box properties
                cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
            end
        end
    end
end
close(wbar);

% --- 3D cube plotter - *Eb(kx,ky) or Eb(kx,kz) scans only*
function view_3Ddatacube(dataStr, view3D_args)
% view_3Ddatacube(dataStr, view3D_args)
%   This function plots a 3D ARPES data data cube in the form
%   of D(X, Y, Z).
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   dataStr:             data structure of the ARPES data.
%   -   view3D_args:    1x5 cell of {3DType, 3DLimits, Interpolate, SquareAxes, RemapSlice}.
%
%   OUT:
%   -   figure output.

disp('-> Plotting 3D data cube...')
wbar = waitbar(0.5, 'Plotting ARPES data as 3D cube (takes a while!)...', 'Name', 'view_3Ddatacube');

%% Default parameters
% - Extracting the fields to be used with most recent processing
[xField, yField, zField, dField] = find_data_fields(dataStr);

%% 1 - Initialising and permuting the variable / data arrays to be consistent in 3D
% - 1.1 - EbAlign->Normalise->kConvert fields
if isfield(dataStr, 'kx')
    v = permute(dataStr.(dField), [3 2 1]);
    x = permute(dataStr.(xField), [3 2 1]);
    y = permute(dataStr.(yField), [3 2 1]);
    z = permute(dataStr.(zField), [3 2 1]);
% - 1.2 - EbAlign->Normalise fields
elseif isfield(dataStr, 'data')
    v = permute(dataStr.(dField), [3 2 1]);
    x = permute(dataStr.(xField), [3 2 1]);
    y = permute(dataStr.(yField), [3 2 1]);
    % - Converting the scan variable into 3D
    z = repmat(dataStr.(zField), [size(dataStr.(dField),1),1,size(dataStr.(dField),2)]);
    z = permute(z, [2 3 1]);
% - 1.3 - EbAlign fields
elseif isfield(dataStr, 'eb')
    v = permute(dataStr.(dField), [3 2 1]);
    x = permute(dataStr.(xField), [3 2 1]);
    y = permute(dataStr.(yField), [3 2 1]);
    % - Converting the scan variable into 3D
    z = repmat(dataStr.(zField), [size(dataStr.(dField),1),1,size(dataStr.(dField),2)]);
    z = permute(z, [2 3 1]);
% - 1.4 - Raw, unprocessed data fields
else
    v = permute(dataStr.(dField), [3 2 1]);
    % - Converting the theta variable into 3D
    x = repmat(dataStr.(xField), [size(dataStr.(dField),1),1,size(dataStr.(dField),3)]);
    x = permute(x, [3 2 1]);
    % - Converting the eb variable into 3D
    y = repmat(dataStr.(yField), [1,size(dataStr.(dField),2),size(dataStr.(dField),3)]);
    y = permute(y, [3 2 1]);
    % - Converting the scan variable into 3D
    z = repmat(dataStr.(zField), [size(dataStr.(dField),1),1,size(dataStr.(dField),2)]);
    z = permute(z, [2 3 1]);
end
%% 2 - Plotting the iso-surfaces of the cube
% - If necessary, smooth the data beforehand
if view3D_args{3} ==1
    v = smooth3(v, 'gaussian', 5);
end
% - Plotting the 3D data-cube
cLim = view3D_args{2};
figure(); hold on;
p1L = patch(isocaps(z, x, y, v, cLim), 'FaceColor', 'interp', 'EdgeColor', 'none');
p2L = patch(isosurface(z, x, y, v, cLim),'FaceColor', 'black', 'EdgeColor', 'none');
isonormals(v, p2L);
%% 3 - Formatting the figure
view([-40, 26]);
axis([min(z(:)), max(z(:)), min(x(:)), max(x(:)), min(y(:)), max(y(:))]);
% - 3.1 - Defining the axes properties
ax = gca;
% Font properties
ax.FontName = 'Helvetica'; ax.FontWeight = 'normal'; ax.FontSize = 15;
% Tick properties
ax.TickLabelInterpreter = 'latex';
ax.XMinorTick = 'on'; ax.YMinorTick = 'on'; ax.ZMinorTick = 'on';
ax.TickDir = 'out';
ax.TickLength = [0.01 0.025];
ax.XColor = [0 0 0]; ax.YColor = [0 0 0]; ax.ZColor = [0 0 0];
% Box Styling properties
ax.LineWidth = 1.5;
ax.Box = 'on'; ax.BoxStyle = 'full'; ax.Layer = 'Top';
% Axis labels and limits
if dataStr.Type == "Eb(kx,ky)" 
    if isfield(dataStr, 'kx'); ylabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex'); xlabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex');
    else; ylabel('$$ \bf  \theta (^{\circ}) $$', 'Interpreter', 'latex'); xlabel('$$ \bf  \tau (^{\circ}) $$', 'Interpreter', 'latex');
    end
elseif dataStr.Type == "Eb(kx,kz)" 
    if isfield(dataStr, 'kx'); ylabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex'); xlabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex');
    else; ylabel('$$ \bf  \theta (^{\circ}) $$', 'Interpreter', 'latex'); xlabel('$$ \bf  hv (eV) $$', 'Interpreter', 'latex');
    end
end
zlabel('$$ \bf  E_B (eV) $$', 'Interpreter', 'latex');
% - 3.2 - Defining the figure properties
fig = gcf; fig.Color = [1 1 1]; fig.InvertHardcopy = 'off';
set(fig, 'Name', dataStr.H5file);
% - 3.3 - Colorbar properties
colormap hot;
cb = colorbar; 
% Colorbar font properties
cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
% Colorbar tick properties
cb.TickLabelInterpreter = 'latex';
cb.TickLength = 0.04; cb.TickDirection = 'out';
% Colorbar position properties
pos = get(cb, 'Position'); cb.Position = [1.08*pos(1) 5.7*pos(2) 0.03 0.1];
% Colorbar box properties
cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
pbaspect([1,1,1]); % axis equal;
%% Close wait-bar
close(wbar);

% --- Eb(k) vs scan parameter video - *Eb(kx,ky) or Eb(kx,kz) scans only*
function view_ebkvideo(dataStr, view3D_args)
% view_ebkvideo(dataStr, view3D_args)
%   This function plots the Eb(kx) ARPES image as a function
%   of the scan parameter.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   gca_properties(type)
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   dataStr:             data structure of the ARPES data.
%   -   view3D_args:    1x5 cell of {3DType, 3DLimits, Interpolate, SquareAxes, RemapSlice}.
%
%   OUT:
%   -   figure output.

%% Initialisation to save the video as a .avi file
filter = {'*.avi'};
[save_filename, save_filepath] = uiputfile(filter);
fname = char(string(save_filepath) + string(save_filename));
% If Cancel is pressed, then return nothing
if isequal(save_filepath,0) || isequal(save_filename,0); return; end
% Else proceed with the video plotting
disp('-> Eb(k) vs scan parameter video...')
wbar = waitbar(0., 'Plotting Eb(k) vs scan parameter video...', 'Name', 'view_ebkvideo');

%% Default parameters
% - Extracting the fields to be used with most recent processing
[xField, yField, zField, dField] = find_data_fields(dataStr);

%% 1 - Initialising variables for the video
% - Initialising the range over which to plot eb(k)
dataStr = crop_data(dataStr, [], [], view3D_args{2});
% - Initialising the frames
nFrames = size(dataStr.(dField), 3);
vidObj = VideoWriter(fname);
vidObj.FrameRate = 10;
open(vidObj);
%% 2 - Running the Eb(k) vs scan parameter frame-by-frame
fig = figure();
for f = 1:nFrames
    waitbar(f/nFrames, wbar, 'Plotting Eb(k) vs scan parameter video...', 'Name', 'view_ebkvideo');
    % - Reset the figure
    fig;
    cla reset; clf reset; delete(findall(gcf,'type','annotation'))
    % - Extracting the scan parameter for the given frame
    if dataStr.Type == "Eb(kx,ky)" 
        if isfield(dataStr, 'kx'); scanVal = sprintf('$$ \\bf ky_{%i} = %.3f \\AA^{-1}$$', f, dataStr.(zField)(1,1,f));
        else; scanVal = sprintf('$$ \\bf \\tau_{%i} = %.2f^{\\circ}$$', f, dataStr.(zField)(f));
        end
    elseif dataStr.Type == "Eb(kx,kz)" 
        if isfield(dataStr, 'kx'); scanVal = sprintf('$$ \\bf kz_{%i} = %.3f \\AA^{-1}$$', f, dataStr.(zField)(1,1,f));
        else; scanVal = sprintf('$$ \\bf hv_{%i} = %.2f eV $$', f, dataStr.(zField)(f));
        end
    end
    % -- The plot depends on how far in the analysis 
    if view3D_args{3} == 1
        if isfield(dataStr, 'kx')
            ImData(dataStr.(xField)(:,:,f), dataStr.(yField)(:,:,f), dataStr.(dField)(:,:,f), 'interp');
        elseif isfield(dataStr, 'data') || isfield(dataStr, 'eb')
            ImData(dataStr.(xField)(:,:,f), dataStr.(yField)(:,:,f), dataStr.(dField)(:,:,f), 'interp');
        else
            ImData(dataStr.(xField), dataStr.(yField), dataStr.(dField)(:,:,f), 'interp');
        end
    else
        if isfield(dataStr, 'kx')
            ImData(dataStr.(xField)(:,:,f), dataStr.(yField)(:,:,f), dataStr.(dField)(:,:,f));
        elseif isfield(dataStr, 'data') || isfield(dataStr, 'eb')
            ImData(dataStr.(xField)(:,:,f), dataStr.(yField)(:,:,f), dataStr.(dField)(:,:,f));
        else
            ImData(dataStr.(xField), dataStr.(yField), dataStr.(dField)(:,:,f));
        end
    end
    if view3D_args{4} == 1; axis square; end
    % - 2.5 - Formatting the figure
    minC = min(min(min(dataStr.(dField)(:,:,f))));
    maxC = max(max(max(dataStr.(dField)(:,:,f))));
    caxis([minC, maxC]);
    axis([min(dataStr.(xField)(:)), max(dataStr.(xField)(:)), min(dataStr.(yField)(:)), max(dataStr.(yField)(:))]);
    gca_properties(string(xField));
    title(dataStr.H5file, 'interpreter', 'none', 'fontsize', 14);
    % - 2.6 - Adding text for the scan parameter
    annotation('textbox', [0.25 0.2 0.17 0.06], 'String',scanVal, 'FitBoxToText','on',...
        'color', [0 0 0], 'fontsize', 13, 'backgroundcolor', [1 1 1], 'facealpha', 0.80,...
        'linewidth', 2, 'horizontalalignment', 'center', 'verticalalignment', 'middle',...
        'interpreter', 'latex');
   %% Adding the current figure as a frame to the video dataObject
    mov = getframe(gcf);          %add current figure as frame
    writeVideo(vidObj,mov);     %write frame to vidObj
end
close(vidObj);
%% Close wait-bar
close(wbar);

% --- Eb(k) vs scan parameter video with zoom - *Eb(kx,ky) or Eb(kx,kz) scans only*
function view_ebkvideo_zoom(dataStr, view3D_args)
% view_ebkvideo_zoom(dataStr, view3D_args)
%   This function plots the Eb(kx) ARPES image as a function
%   of the scan parameter with the addition of a zoomed area 
%   of interest.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   gca_properties(type)
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   dataStr:             data structure of the ARPES data.
%   -   view3D_args:    1x5 cell of {3DType, 3DLimits, Interpolate, SquareAxes, RemapSlice}.
%
%   OUT:
%   -   figure output.

%% Initialisation to save the video as a .avi file
filter = {'*.avi'};
[save_filename, save_filepath] = uiputfile(filter);
fname = char(string(save_filepath) + string(save_filename));
% If Cancel is pressed, then return nothing
if isequal(save_filepath,0) || isequal(save_filename,0); return; end

% Else proceed with the video plotting
disp('-> Eb(k) vs scan parameter zoomed video...')
wbar = waitbar(0., 'Plotting Eb(k) vs scan parameter zoomed video...', 'Name', 'view_ebkvideo_zoom');

%% Default parameters
% - Extracting the fields to be used with most recent processing
[xField, yField, zField, dField] = find_data_fields(dataStr);

%% 1 - Initialising variables for the video
% - Initialising the data structures
dataStr_crp = crop_data(dataStr, [view3D_args{2}(1), view3D_args{2}(2)], [view3D_args{2}(3), view3D_args{2}(4)]);
% - Initialising the frames
nFrames = size(dataStr.(dField), 3);
vidObj = VideoWriter(fname);
vidObj.FrameRate = 10;
open(vidObj);
%% 2 - Running the Eb(k) vs scan parameter frame-by-frame
figure();
for f = 1:nFrames
    % - Reset the figure
    cla reset; clf reset; delete(findall(gcf,'type','annotation')); hold on;
    % - Extracting the scan parameter for the given frame
    if dataStr.Type == "Eb(kx,ky)" 
        if isfield(dataStr, 'kx'); scanVal = sprintf('$$ \\bf ky_{%i} = %.3f \\AA^{-1}$$', f, dataStr.(zField)(1,1,f));
        else; scanVal = sprintf('$$ \\bf \\tau_{%i} = %.2f^{\\circ}$$', f, dataStr.(zField)(f));
        end
    elseif dataStr.Type == "Eb(kx,kz)" 
        if isfield(dataStr, 'kx'); scanVal = sprintf('$$ \\bf kz_{%i} = %.3f \\AA^{-1}$$', f, dataStr.(zField)(1,1,f));
        else; scanVal = sprintf('$$ \\bf hv_{%i} = %.2f eV $$', f, dataStr.(zField)(f));
        end
    end
   %% 2.1 - Plotting the full Eb(k) image first
    % -- The plot depends on how far in the analysis 
    if view3D_args{3} == 1
        if isfield(dataStr, 'kx')
            ImData(dataStr.(xField)(:,:,f), dataStr.(yField)(:,:,f), dataStr.(dField)(:,:,f), 'interp');
        elseif isfield(dataStr, 'data') || isfield(dataStr, 'eb')
            ImData(dataStr.(xField)(:,:,f), dataStr.(yField)(:,:,f), dataStr.(dField)(:,:,f), 'interp');
        else
            ImData(dataStr.(xField), dataStr.(yField), dataStr.(dField)(:,:,f), 'interp');
        end
    else
        if isfield(dataStr, 'kx')
            ImData(dataStr.(xField)(:,:,f), dataStr.(yField)(:,:,f), dataStr.(dField)(:,:,f));
        elseif isfield(dataStr, 'data') || isfield(dataStr, 'eb')
            ImData(dataStr.(xField)(:,:,f), dataStr.(yField)(:,:,f), dataStr.(dField)(:,:,f));
        else
            ImData(dataStr.(xField), dataStr.(yField), dataStr.(dField)(:,:,f));
        end
    end
    % - 2.2 - Formatting the figure
    minC = min(min(min(dataStr.(dField)(:,:,f))));
    maxC = max(max(max(dataStr.(dField)(:,:,f))));
    caxis([minC, maxC]);
    axis([min(dataStr.(xField)(:)), max(dataStr.(xField)(:)), min(dataStr.(yField)(:)), max(dataStr.(yField)(:))]);
    gca_properties(string(xField));
    title(dataStr.H5file, 'interpreter', 'none', 'fontsize', 14);
    if view3D_args{4} == 1; axis square; end
    % - 2.3 - Adding text for the scan parameter
    annotation('textbox', [0.22 0.2 0.17 0.06], 'String',scanVal, 'FitBoxToText','on',...
        'color', [0 0 0], 'fontsize', 13, 'backgroundcolor', [1 1 1], 'facealpha', 0.80,...
        'linewidth', 2, 'horizontalalignment', 'center', 'verticalalignment', 'middle',...
        'interpreter', 'latex');
   %% 3.1 - Plotting the region of interest that is zoomed in on
    x = [view3D_args{2}(1), view3D_args{2}(2), view3D_args{2}(2), view3D_args{2}(1), view3D_args{2}(1)];
    y = [view3D_args{2}(3), view3D_args{2}(3), view3D_args{2}(4), view3D_args{2}(4), view3D_args{2}(3)] ;
    plot(x, y, 'LineWidth', 1.5, 'Color', 'y', 'linestyle', '-');
   %% 4.1 - Plotting the cropped Eb(k) on top
    % - Creating a new inset axes to the figure
    if mean([view3D_args{2}(1),view3D_args{2}(2)]) < 0; new_ax = axes('Position',[.67 .655 .25 .25]);
    else; new_ax = axes('Position',[.12 .655 .25 .25]);
    end
    % - Plotting the cropped ARPES data
    if view3D_args{3} == 1
        if isfield(dataStr_crp, 'kx')
            ImData(dataStr_crp.(xField)(:,:,f), dataStr_crp.(yField)(:,:,f), dataStr_crp.(dField)(:,:,f), 'interp');
        elseif isfield(dataStr_crp, 'data') || isfield(dataStr_crp, 'eb')
            ImData(dataStr_crp.(xField)(:,:,f), dataStr_crp.(yField)(:,:,f), dataStr_crp.(dField)(:,:,f), 'interp');
        else
            ImData(dataStr_crp.(xField), dataStr_crp.(yField), dataStr_crp.(dField)(:,:,f), 'interp');
        end
    else
        if isfield(dataStr_crp, 'kx')
            ImData(dataStr_crp.(xField)(:,:,f), dataStr_crp.(yField)(:,:,f), dataStr_crp.(dField)(:,:,f));
        elseif isfield(dataStr_crp, 'data') || isfield(dataStr_crp, 'eb')
            ImData(dataStr_crp.(xField)(:,:,f), dataStr_crp.(yField)(:,:,f), dataStr_crp.(dField)(:,:,f));
        else
            ImData(dataStr_crp.(xField), dataStr_crp.(yField), dataStr_crp.(dField)(:,:,f));
        end
    end
    % - 4.2 - Formatting the figure
    minC = min(min(min(dataStr_crp.(dField)(:,:,f))));
    maxC = max(max(max(dataStr_crp.(dField)(:,:,f))));
    caxis([minC, maxC]);
    axis([min(dataStr_crp.(xField)(:)), max(dataStr_crp.(xField)(:)), min(dataStr_crp.(yField)(:)), max(dataStr_crp.(yField)(:))]);
    gca_properties(string(xField)); xlabel(''); ylabel('');
    new_ax.XColor = [1 1 1]; new_ax.YColor = [1 1 1]; pbaspect([1 1 1]);
    if mean([view3D_args{2}(1),view3D_args{2}(2)]) < 0
        new_ax.XAxisLocation = 'bottom';
        new_ax.YAxisLocation = 'left';
    else
        new_ax.XAxisLocation = 'bottom';
        new_ax.YAxisLocation = 'right';
    end
    if view3D_args{4} == 1; axis square; end
   %% Adding the current figure as a frame to the video dataObject
    mov = getframe(gcf);          %add current figure as frame
    writeVideo(vidObj,mov);     %write frame to vidObj
end
close(vidObj);
%% Close wait-bar
close(wbar);

% --- IsoK or IsoE video - *Eb(kx,ky) or Eb(kx,kz) scans only*
function view_slicevideo(dataStr, view3D_args)
% view_slicevideo(dataStr, view3D_args)
%   This function plots a slice ARPES image as a function
%   of the binding energy (for IsoE) or kx (for IsoK).
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   gca_properties(type)
%   -   [DSlice,XSlice]=Slice(ACorr,ECorr,Data,xMode,Win) 
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   dataStr:             data structure of the ARPES data.
%   -   view3D_args:    1x5 cell of {3DType, 3DLimits, Interpolate, SquareAxes, RemapSlice}.
%
%   OUT:
%   -   figure output.

%% Initialisation to save the video as a .avi file
filter = {'*.avi'};
[save_filename, save_filepath] = uiputfile(filter);
fname = char(string(save_filepath) + string(save_filename));
% If Cancel is pressed, then return nothing
if isequal(save_filepath,0) || isequal(save_filename,0); return; end
% Else proceed with the video plotting
disp('-> Eb(k) vs scan parameter video...')

%% Default parameters
% - Extracting the fields to be used with most recent processing
[xField, yField, zField, dField] = find_data_fields(dataStr);
if view3D_args{1} == "isoe video" 
    if isempty(view3D_args{2}); WinLims = sort([min(dataStr.(yField)(:))+0.1, max(dataStr.(yField)(:))-0.1]);
    else; WinLims = sort(view3D_args{2}); end
elseif view3D_args{1} == "isok video"  
    if isempty(view3D_args{2}); WinLims = sort([min(min(dataStr.(xField)(:,:,1)))+0.2, max(max(dataStr.(xField)(:,:,1)))-0.2]);
    else; WinLims = sort(view3D_args{2}); end
end

 %% 1 - Initialising variables
stepsize = 0.025;
% - Capping the window to the max/min of the ARPES data
if view3D_args{1} == "isoe video" 
    stepsize = abs((max(dataStr.(yField)(:))-min(dataStr.(yField)(:)))) / size(dataStr.(dField),1);
    if WinLims(1) < min(dataStr.(yField)(:)); WinLims(1) = min(dataStr.(yField)(:))+stepsize; end
    if WinLims(2) > max(dataStr.(yField)(:)); WinLims(2) = max(dataStr.(yField)(:))-stepsize; end
elseif view3D_args{1} == "isok video"  
    stepsize = abs((max(dataStr.(xField)(:))-min(dataStr.(xField)(:)))) / size(dataStr.(dField),2);
    if WinLims(1) < min(dataStr.(xField)(:)); WinLims(1) = min(dataStr.(xField)(:))+stepsize; end
    if WinLims(2) > max(dataStr.(xField)(:)); WinLims(2) = max(dataStr.(xField)(:))-stepsize; end
end
 % - Initialising window parameters
WinLims = sort(WinLims);
iWin = WinLims(2) + [-0.5, 0.5]*stepsize; 
% - Initialising video parameters
nFrames = (WinLims(2) - WinLims(1))/(2*stepsize);
vidObj = VideoWriter(fname);
vidObj.FrameRate = 10;
open(vidObj);
% - Open and freeze the figure axes
fig = figure();

%% 2 - Running the slice video frame by frame
for f = 1:nFrames 
    % - Finding the next iteration of the slice window
    Win = iWin-(f-1)*2*stepsize;
    % - Reset the figure
    fig;
    cla reset; clf reset; delete(findall(gcf,'type','annotation'))
    % - Extracting the mean slice range as a string
    if view3D_args{1} == "isoe video"; scanVal =  sprintf('$$ \\bf E_B = %.3f eV $$', mean(Win));
    elseif view3D_args{1} == "isok video"  && isfield(dataStr, 'kx'); scanVal =  sprintf('$$ \\bf k_x = %.3f \\AA^{-1} $$', mean(Win));
    else; scanVal =  sprintf('$$ \\bf \\theta = %.3f^{\\circ}$$', mean(Win));
    end
   % - Extracting the Iso slices
    if view3D_args{1} == "isoe video"
        [DSlice, XSlice] = Slice(dataStr.(xField), dataStr.(yField), dataStr.(dField), 'IsoE', Win);
        % - Extracting the scan parameter variables
        if isfield(dataStr, 'kx'); init = ceil(0.5*size(dataStr.(dField), 2));YSlice = squeeze(dataStr.(zField)(init,:,:))';
        else; YSlice = squeeze(dataStr.(zField))';
        end
    elseif view3D_args{1} == "isok video"
        [DSlice, YSlice] = Slice(dataStr.(xField), dataStr.(yField), dataStr.(dField), 'IsoK', Win);
        % - Extracting the scan parameter variables
        if isfield(dataStr, 'kx'); init = ceil(0.5*size(dataStr.(dField), 2)); XSlice = squeeze(dataStr.(zField)(:,init,:));
        else; XSlice = squeeze(dataStr.(zField))';
        end
    end
    % - Remapping the slices onto a square grid if required
    if view3D_args{5} == 1
         [XSlice, YSlice, DSlice] = Remap(XSlice, YSlice, DSlice);
         YSlice = YSlice';
         % DSlice(isnan(DSlice)) = 0;
    end
    % - Plotting the Iso slices
    if view3D_args{3} == 1
        ImData(XSlice, YSlice, DSlice, 'interp');
    else
         ImData(XSlice, YSlice, DSlice);
    end
    % - Add annotation of the scan parameter
    if view3D_args{4} == 1; text_pos = [0.5 0.15 0.22 0.06];
    else; text_pos = [0.15 0.15 0.22 0.06];
    end
    annotation('textbox', text_pos, 'String',scanVal, 'FitBoxToText','on',...
        'color', [0 0 0], 'fontsize', 13, 'backgroundcolor', [1 1 1], 'facealpha', 0.8,...
        'linewidth', 2, 'horizontalalignment', 'center', 'verticalalignment', 'middle',...
        'interpreter', 'latex');
    % - Formatting the figure
    minC = round(min(DSlice(:)), 2);
    maxC = round(max(DSlice(:)), 2);
    caxis([minC, maxC]);
    axis([min(XSlice(:)), max(XSlice(:)), min(YSlice(:)), max(YSlice(:))]);
    gca_properties(string(xField));
    title(dataStr.H5file, 'interpreter', 'none', 'fontsize', 14);
    % - Re-labelling the axes depending on what slice is taken
    if view3D_args{1} == "isoe video"
        if dataStr.Type == "Eb(kx,ky)"
            if isfield(dataStr, 'kx'); xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex'); ylabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex'); 
            else; xlabel('$$ \bf  \theta (^{\circ}) $$', 'Interpreter', 'latex'); ylabel('$$ \bf  \tau (^{\circ}) $$', 'Interpreter', 'latex');
            end
        elseif dataStr.Type == "Eb(kx,kz)"
            if isfield(dataStr, 'kx'); xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex'); ylabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex'); 
            else; xlabel('$$ \bf  \theta (^{\circ}) $$', 'Interpreter', 'latex'); ylabel('$$ \bf  hv (eV) $$', 'Interpreter', 'latex');
            end
        end
    elseif view3D_args{1} == "isok video"
        ylabel('$$ \bf  E_B (eV) $$', 'Interpreter', 'latex'); 
        if dataStr.Type == "Eb(kx,ky)"
            if isfield(dataStr, 'kx'); xlabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex');
            else; xlabel('$$ \bf  \tau (^{\circ}) $$', 'Interpreter', 'latex');
            end
        elseif dataStr.Type == "Eb(kx,kz)"
            if isfield(dataStr, 'kx'); xlabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex'); 
            else; xlabel('$$ \bf  hv (eV) $$', 'Interpreter', 'latex');
            end
        end
    end    
    if view3D_args{4} == 1; pbaspect([1 1 1]); end
    % - Adding the current figure as a frame to the video dataObject
    mov = getframe(gcf);        %add current figure as frame
    writeVideo(vidObj,mov);     %write frame to vidObj
end
close(vidObj);

% --- IsoK or IsoE video - *Eb(kx,ky) or Eb(kx,kz) scans only*
function view_slice_and_ebk_video(dataStr, view3D_args)
% view_slice_and_ebk_video(dataStr, view3D_args)
%   This function plots the Eb(kx) ARPES image as a function
%   of the scan parameter with the addition of an iso-slice
%   taken over a specific slice.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   gca_properties(type)
%   -   [DSlice,XSlice]=Slice(ACorr,ECorr,Data,xMode,Win) 
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   dataStr:             data structure of the ARPES data.
%   -   view3D_args:    1x5 cell of {3DType, 3DLimits, Interpolate, SquareAxes, RemapSlice}.
%
%   OUT:
%   -   figure output.

%% Initialisation to save the video as a .avi file
filter = {'*.avi'};
[save_filename, save_filepath] = uiputfile(filter);
fname = char(string(save_filepath) + string(save_filename));
% If Cancel is pressed, then return nothing
if isequal(save_filepath,0) || isequal(save_filename,0); return; end
% Else proceed with the video plotting
disp('-> Iso-slice + Eb(k) vs scan parameter video...')
wbar = waitbar(0., 'Plotting slice + Eb(k) video...', 'Name', 'view_slice_and_ebk_video');

%% Default parameters
% - Extracting the fields to be used with most recent processing
[xField, yField, zField, dField] = find_data_fields(dataStr);
% - Initialising the range over which to plot eb(k)
dataStr_scans = crop_data(dataStr, [], [], [view3D_args{2}(3),view3D_args{2}(4)]);
% - Capping the window to the max/min of the ARPES data
WinLims = sort([view3D_args{2}(1), view3D_args{2}(2)]);
if view3D_args{1} == "isoe + eb(k) video" 
    if WinLims(1) < min(dataStr.(yField)(:)); WinLims(1) = min(dataStr.(yField)(:))+stepsize; end
    if WinLims(2) > max(dataStr.(yField)(:)); WinLims(2) = max(dataStr.(yField)(:))-stepsize; end
elseif view3D_args{1} == "isok + eb(k) video"  
    if WinLims(1) < min(dataStr.(xField)(:)); WinLims(1) = min(dataStr.(xField)(:))+stepsize; end
    if WinLims(2) > max(dataStr.(xField)(:)); WinLims(2) = max(dataStr.(xField)(:))-stepsize; end
end
WinLims = sort(WinLims);
%% 1 - Extracting the Iso slice
if view3D_args{1} == "isoe + eb(k) video"
    [DSlice, XSlice] = Slice(dataStr.(xField), dataStr.(yField), dataStr.(dField), 'IsoE', WinLims);
    % - Extracting the scan parameter variables
    if isfield(dataStr, 'kx'); init = ceil(0.5*size(dataStr.(dField), 2)); YSlice = squeeze(dataStr.(zField)(init,:,:))';
    else; YSlice = squeeze(dataStr.(zField))';
    end
elseif view3D_args{1} == "isok + eb(k) video" 
    [DSlice, YSlice] = Slice(dataStr.(xField), dataStr.(yField), dataStr.(dField), 'IsoK', WinLims);
    % - Extracting the scan parameter variables
    if isfield(dataStr, 'kx'); init = ceil(0.5*size(dataStr.(dField), 2)); XSlice = squeeze(dataStr.(zField)(:,init,:));
    else; XSlice = squeeze(dataStr.(zField))';
    end
end
% - 1.1 - Remapping the slices onto a square grid if required
if view3D_args{5} == 1
     [XSlice, YSlice, DSlice] = Remap(XSlice, YSlice, DSlice);
     YSlice = YSlice';
     % DSlice(isnan(DSlice)) = 0;
end
%% 2 - Initialising video parameters
nFrames = size(dataStr_scans.(dField), 3);
vidObj = VideoWriter(fname);
vidObj.FrameRate = 10;
open(vidObj);
% - Open and freeze the figure axes
fig = figure(); set(fig, 'Position', [1,1,850,450]);

%% 3 - Running the slice + eb(k) video frame by frame
for f = 1:nFrames 
    % - Reset the figure
    fig;
    cla reset; clf reset; delete(findall(gcf,'type','annotation'))
    % - Extracting the scan parameter for the given frame
    if dataStr_scans.Type == "Eb(kx,ky)" 
        if isfield(dataStr_scans, 'kx'); scanVal = sprintf('$$ \\bf ky_{%i} = %.3f \\AA^{-1}$$', f, dataStr_scans.(zField)(1,1,f));
        else; scanVal = sprintf('$$ \\bf \\tau_{%i} = %.2f^{\\circ}$$', f, dataStr_scans.(zField)(f));
        end
    elseif dataStr_scans.Type == "Eb(kx,kz)" 
        if isfield(dataStr_scans, 'kx'); scanVal = sprintf('$$ \\bf kz_{%i} = %.3f \\AA^{-1}$$', f, dataStr_scans.(zField)(1,1,f));
        else; scanVal = sprintf('$$ \\bf hv_{%i} = %.2f eV $$', f, dataStr_scans.(zField)(f));
        end
    end
    %% 4 - Plotting the Eb(k) dispersion at the scan value
    subplot(1,2,1); hold on;
    % -- The plot depends on how far in the analysis 
    if view3D_args{3} == 1
        if isfield(dataStr_scans, 'kx')
            ImData(dataStr_scans.(xField)(:,:,f), dataStr_scans.(yField)(:,:,f), dataStr_scans.(dField)(:,:,f), 'interp');
        elseif isfield(dataStr_scans, 'data') || isfield(dataStr_scans, 'eb')
            ImData(dataStr_scans.(xField)(:,:,f), dataStr_scans.(yField)(:,:,f), dataStr_scans.(dField)(:,:,f), 'interp');
        else
            ImData(dataStr_scans.(xField), dataStr_scans.(yField), dataStr_scans.(dField)(:,:,f), 'interp');
        end
    else
        if isfield(dataStr_scans, 'kx')
            ImData(dataStr_scans.(xField)(:,:,f), dataStr_scans.(yField)(:,:,f), dataStr_scans.(dField)(:,:,f));
        elseif isfield(dataStr_scans, 'data') || isfield(dataStr_scans, 'eb')
            ImData(dataStr_scans.(xField)(:,:,f), dataStr_scans.(yField)(:,:,f), dataStr_scans.(dField)(:,:,f));
        else
            ImData(dataStr_scans.(xField), dataStr_scans.(yField), dataStr_scans.(dField)(:,:,f));
        end
    end
    % -- Formatting the figure
    gca_properties(string(xField));
    colorbar('off');
    minC = min(min(min(dataStr_scans.(dField)(:,:,f)))); 
    maxC = max(max(max(dataStr_scans.(dField)(:,:,f))));
    caxis([minC, maxC]);
    axis([min(dataStr_scans.(xField)(:)), max(dataStr_scans.(xField)(:)),min(dataStr_scans.(yField)(:)), max(dataStr_scans.(yField)(:))]);
    % -- Plotting an outline over the integrated sliced region
    if view3D_args{1} == "isoe + eb(k) video"
        patch([-1e3, 1e3, 1e3, -1e3, -1e3], [WinLims(1), WinLims(1), WinLims(2), WinLims(2), WinLims(1)],...
            [0 1 0], 'linewidth', 1, 'facealpha', 0, 'edgecolor', [0 1 0]);
    elseif view3D_args{1} == "isok + eb(k) video"
        patch([WinLims(1), WinLims(1), WinLims(2), WinLims(2), WinLims(1)],[-1e3, 1e3, 1e3, -1e3, -1e3],...
            [0 1 0], 'linewidth', 1, 'facealpha', 0, 'edgecolor', [0 1 0]);
    end    
    % -- Adding title to the figure
    title(sprintf(string(dataStr.H5file) + "; scan %i", f), 'interpreter', 'none', 'fontsize', 12);
    % -- Colorbar properties
    colormap hot;
    cb = colorbar; 
    % Colorbar font properties
    cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
    % Colorbar tick properties
    if cb.Limits(1) < 0 || cb.Limits(1) == 0; cb.Ticks = sort(round([0, 0.5*(0.95*cb.Limits(2)), 0.95*cb.Limits(2)], 3));
    else; cb.Ticks = sort(round([1.1*cb.Limits(1), 0.5*(0.95*cb.Limits(2)), 0.95*cb.Limits(2)], 3)); end
    cb.TickLabelInterpreter = 'latex';
    cb.TickLength = 0.04; cb.TickDirection = 'out';
    cb.YAxisLocation = 'right';
    % Colorbar position properties
    pos = get(cb, 'Position'); cb.Position = [0.17*pos(1) 7.5*pos(2) 0.02 0.1];
    % Colorbar box properties
    cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
    % -- Adding text for the scan parameter
    annotation('textbox', [0.12 0.2 0.17 0.06], 'String',scanVal, 'FitBoxToText','on',...
        'color', [0 0 0], 'fontsize', 13, 'backgroundcolor', [1 1 1], 'facealpha', 0.80,...
        'linewidth', 2, 'horizontalalignment', 'center', 'verticalalignment', 'middle',...
        'interpreter', 'latex');
    %% 5 - Plotting the iso-slice extracted
    subplot(1,2,2); hold on;
    if view3D_args{3} == 1
        ImData(XSlice, YSlice, DSlice, 'interp');
    else
        ImData(XSlice, YSlice, DSlice);
    end
    % - Formatting the figure
    minC = min(DSlice(:)); maxC = max(DSlice(:));
    caxis([minC, maxC]);
    axis([min(XSlice(:)), max(XSlice(:)), min(YSlice(:)), max(YSlice(:))]);
    gca_properties(string(xField)); colorbar('off');
    % - Re-labelling the axes depending on what slice is taken
    if view3D_args{1} == "isoe + eb(k) video"
        if dataStr.Type == "Eb(kx,ky)"
            if isfield(dataStr, 'kx'); xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex'); ylabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex'); 
            else; xlabel('$$ \bf  \theta (^{\circ}) $$', 'Interpreter', 'latex'); ylabel('$$ \bf  \tau (^{\circ}) $$', 'Interpreter', 'latex');
            end
        elseif dataStr.Type == "Eb(kx,kz)"
            if isfield(dataStr, 'kx'); xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex'); ylabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex'); 
            else; xlabel('$$ \bf  \theta (^{\circ}) $$', 'Interpreter', 'latex'); ylabel('$$ \bf  hv (eV) $$', 'Interpreter', 'latex');
            end
        end
        title(sprintf(string(dataStr.H5file) + "; IsoE; [%.2f,%.2f]", WinLims(1), WinLims(2)), 'interpreter', 'none', 'fontsize', 12);
    elseif view3D_args{1} == "isok + eb(k) video"
        ylabel('$$ \bf  E_B (eV) $$', 'Interpreter', 'latex'); 
        if dataStr.Type == "Eb(kx,ky)"
            if isfield(dataStr, 'kx'); xlabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex');
            else; xlabel('$$ \bf  \tau (^{\circ}) $$', 'Interpreter', 'latex');
            end
        elseif dataStr.Type == "Eb(kx,kz)"
            if isfield(dataStr, 'kx'); xlabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex'); 
            else; xlabel('$$ \bf  hv (eV) $$', 'Interpreter', 'latex');
            end
        end
        title(sprintf(string(dataStr.H5file) + "; IsoK; [%.2f,%.2f]", WinLims(1), WinLims(2)), 'interpreter', 'none', 'fontsize', 12);
    end
    % -- Colorbar properties
    colormap hot;
    cb = colorbar; 
    % Colorbar font properties
    cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
    % Colorbar tick properties
    if cb.Limits(1) < 0 || cb.Limits(1) == 0; cb.Ticks = sort(round([0, 0.5*(0.95*cb.Limits(2)), 0.95*cb.Limits(2)], 3));
    else; cb.Ticks = sort(round([1.1*cb.Limits(1), 0.5*(0.95*cb.Limits(2)), 0.95*cb.Limits(2)], 3)); end
    cb.TickLabelInterpreter = 'latex';
    cb.TickLength = 0.04; cb.TickDirection = 'out';
    % Colorbar position properties
    pos = get(cb, 'Position'); cb.Position = [1.08*pos(1) 7.5*pos(2) 0.02 0.1];
    % Colorbar box properties
    cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
    %% 5 - Extracting the curve formed by the Eb(k) scan slice being looked at
    if view3D_args{1} == "isoe + eb(k) video"
        initIndx = floor(0.5*size(dataStr_scans.(dField), 1));
        if isfield(dataStr_scans, 'kx')
            x_curve = squeeze(dataStr_scans.(xField)(initIndx,:,f));
            y_curve = squeeze(dataStr_scans.(zField)(initIndx,:,f));
        elseif isfield(dataStr_scans, 'data') || isfield(dataStr_scans, 'eb')
            x_curve = squeeze(dataStr_scans.(xField)(initIndx,:,f));
            y_curve = repmat(squeeze(dataStr_scans.(zField)(f)), size(x_curve));
        else
            x_curve = squeeze(dataStr_scans.(xField));
            y_curve = repmat(squeeze(dataStr_scans.(zField)(f)), size(x_curve));
        end
        % - Fitting a 4th order polynomial to the slice curve
        x_interp = linspace(min(x_curve(:))-1e2, max(x_curve(:))+1e2, 1e3);
        y_interp = polyval(polyfit(x_curve,y_curve,4),x_interp);
    elseif view3D_args{1} == "isok + eb(k) video"
        initIndx = floor(0.5*size(dataStr_scans.(dField), 2));
        if isfield(dataStr_scans, 'kx')
            y_curve = squeeze(dataStr_scans.(yField)(:,initIndx,f));
            x_curve = squeeze(dataStr_scans.(zField)(:,initIndx,f));
            x_interp = linspace(min(x_curve(:))-5, max(x_curve(:))+5, 1e3);
            y_interp = polyval(polyfit(x_curve,y_curve,1),x_interp);
        elseif isfield(dataStr_scans, 'data') || isfield(dataStr_scans, 'eb')
            y_curve = squeeze(dataStr_scans.(yField)(:,initIndx,f));
            x_curve = repmat(squeeze(dataStr_scans.(zField)(f)), size(y_curve));
            x_interp = ones(size(x_curve))*mean(x_curve(:));
            y_interp = linspace(-1e3, 1e3, size(x_interp, 1));
        else
            y_curve = squeeze(dataStr_scans.(yField));
            x_curve = repmat(squeeze(dataStr_scans.(zField)(f)), size(y_curve));
            x_interp = ones(size(x_curve))*mean(x_curve(:));
            y_interp = linspace(-1e3, 1e3, size(x_interp, 1));
        end
    end
    % Plotting the scan slice curve
    plot(x_interp, y_interp, 'Color', [0 0 1], 'LineWidth', 1., 'Linestyle', '-');
    % Making the axes a square grid
    if view3D_args{4} == 1; pbaspect([1 1 1]); end
    %% 5 - Adding the current figure as a frame to the video dataObject
    mov = getframe(gcf);        %add current figure as frame
    writeVideo(vidObj,mov);     %write frame to vidObj
end
close(vidObj);
%% Close wait-bar
close(wbar);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% The End %%%%%%%%%%%%%%%%%%%%
