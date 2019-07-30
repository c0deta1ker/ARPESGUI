function varargout = arpes_kfanalysis(varargin)
% arpes_kfanalysis MATLAB code for arpes_kfanalysis.fig
%      ARPES_KFANALYSIS, by itself, creates a new ARPES_KFANALYSIS or raises the existing
%      singleton*.
%
%      H = ARPES_KFANALYSIS returns the handle to a new ARPES_KFANALYSIS or the handle to
%      the existing singleton*.
%
%      ARPES_KFANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ARPES_KFANALYSIS.M with the given input arguments.
%
%      ARPES_KFANALYSIS('Property','Value',...) creates a new ARPES_KFANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before arpes_kfanalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to arpes_kfanalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help arpes_kfanalysis

% Last Modified by GUIDE v2.5 28-Jul-2019 21:37:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @arpes_kfanalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @arpes_kfanalysis_OutputFcn, ...
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
% --- Executes just before arpes_kfanalysis is made visible.
function arpes_kfanalysis_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to arpes_kfanalysis (see VARARGIN)

%% Choose default command line output for arpes_kfanalysis
handles.output = hObject;
%% 1 - Setting the native size of the whole GUI figure
screen_size = get(0,'ScreenSize');
screen_size(3) = 720;
screen_size(4) = 310;
set(handles.figure1,'Units','Pixels','Position',screen_size, 'name', 'arpes_kfanalysis');
%% 2 - Setting push-buttons to inactive
set(handles.pushbutton_SAVE, 'Enable', 'off');
set(handles.pushbutton_TRANSFER, 'Enable', 'off');
set(handles.pushbutton_ViewLatest, 'Enable', 'off');
set(handles.pushbutton_INFO, 'Enable', 'off');
set(handles.pushbutton_ViewSeries, 'Enable', 'off');
set(handles.pushbutton_ViewKf, 'Enable', 'off');
set(handles.pushbutton_ViewROI, 'Enable', 'off');
%% 3 - Setting ui-panels to inactive until data is loaded
set(findall(handles.uipanel_3DARPESbrowser, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_filterData, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_findkf, '-property', 'enable'), 'enable', 'off');
%% 4 - Initialising variables
set(handles.text_scanIndex,'String', handles.fig_args{1});
set(handles.text_scanValue,'String', "NaN");
set(handles.text_zIndex,'String', 1);
set(handles.text_zValue,'String', "NaN");
%% Save the handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = arpes_kfanalysis_OutputFcn(hObject, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)

%% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes to reset GUI to initial state
function handles = arpes_kfanalysis_ResetFcn(hObject, ~, handles)
% This is a function that resets the UI elements to their initial, default
% state.
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)

%% Choose default command line output for arpes_kfanalysis
handles.output = hObject;
%% 1 - Setting push-buttons to inactive
set(handles.pushbutton_SAVE, 'Enable', 'off');
set(handles.pushbutton_TRANSFER, 'Enable', 'off');
set(handles.pushbutton_ViewLatest, 'Enable', 'off');
set(handles.pushbutton_INFO, 'Enable', 'off');
set(handles.pushbutton_ViewSeries, 'Enable', 'off');
set(handles.pushbutton_ViewKf, 'Enable', 'off');
set(handles.pushbutton_ViewROI, 'Enable', 'off');
%% 2 - Setting ui-panels to inactive until data is loaded
set(findall(handles.uipanel_3DARPESbrowser, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_filterData, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_findkf, '-property', 'enable'), 'enable', 'off');
%% 3 - Initialising variables
set(handles.text_scanIndex,'String', handles.fig_args{1});
set(handles.text_scanValue,'String', "NaN");
set(handles.text_zIndex,'String', 1);
set(handles.text_zValue,'String', "NaN");
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
close(gcbf); run arpes_kfanalysis;

% --- Executes on button press in pushbutton_RESIZEGUI.
function pushbutton_RESIZEGUI_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_RESIZEGUI (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Resetting the native size of the whole GUI figure
screen_size = get(0, 'ScreenSize');
screen_pos = get(gcf, 'Position');
screen_size(1) = screen_pos(1);
screen_size(2) = screen_pos(2);
screen_size(3) = 720;
screen_size(4) = 310;
set(handles.figure1,'Units','Pixels','Position',screen_size, 'name', 'arpes_kfanalysis');
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
if isfield(handles.myData, 'kf'); disp('KF (.myData.kf) : '); disp(handles.myData.kf); end

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
handles = arpes_kfanalysis_ResetFcn(hObject, [], handles);
%% 3 - Updating handle text and gui elements
% - 3.1 - Show the name, type and information of the ARPES data
set(handles.text_RawFileName,'String',FileName);
% - 3.2 - Activating UI panels
set(findall(handles.uipanel_findkf, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_filterData, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_kfBrowser, '-property', 'enable'), 'enable', 'off');
% - 3.3 - Activating push-buttons that can be used
% -- General buttons
set(handles.pushbutton_SAVE, 'Enable', 'on');
set(handles.pushbutton_TRANSFER, 'Enable', 'on');
set(handles.pushbutton_INFO, 'Enable', 'on');
set(handles.pushbutton_ViewLatest, 'Enable', 'on');
set(handles.pushbutton_ViewKf, 'Enable', 'off');
set(handles.pushbutton_ViewROI, 'Enable', 'on');
% -- Pop-up menus
set(handles.popupmenu_kfType, 'Enable', 'off');
% -- Setting the processing constraints based on the scan type
if handles.myData.Type == "Eb(k)"
    set(handles.edit_zLims, 'Enable', 'off');
    set(handles.edit_zcLims, 'Enable', 'off');
    set(handles.pushbutton_ViewSeries, 'Enable', 'off');
    set(findall(handles.uipanel_3DARPESbrowser, '-property', 'enable'), 'enable', 'off');
elseif handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)"
    set(handles.edit_zLims, 'Enable', 'on');
    set(handles.edit_zcLims, 'Enable', 'on');
    set(handles.pushbutton_ViewSeries, 'Enable', 'on');
    set(findall(handles.uipanel_3DARPESbrowser, '-property', 'enable'), 'enable', 'on');
    % -- Initialising the scan slider
    [~, ~, ~, dField] = find_data_fields(handles.myData);
    set(handles.slider_scanSlider,'min', 1, 'max', size(handles.myData.(dField), 3), 'Value', 1, 'SliderStep', [1/(size(handles.myData.(dField), 3)-1), 1/(size(handles.myData.(dField), 3)-1) ]);
    handles = slider_scanSlider_Callback(handles.slider_scanSlider, [], handles, 0);
    handles = edit_isoSlice_Callback(handles.edit_isoSlice, [], handles);
end
%% 4 - Running UI call-backs to ensure consistency
handles = popupmenu_kfType_Callback(handles.popupmenu_kfType, [], handles);
handles = edit_xLims_Callback(handles.edit_xLims, [], handles);
handles = edit_mdcLims_Callback(handles.edit_mdcLims, [], handles);
handles = edit_zLims_Callback(handles.edit_zLims, [], handles);
handles = edit_kfIndex_Callback(handles.edit_kfIndex, [], handles);
handles = edit_kfPeakLocs_Callback(handles.edit_kfPeakLocs, [], handles);
handles = edit_dKf_Callback(handles.edit_dKf, [], handles);
% - Running data crop-limits
handles = edit_xcLims_Callback(handles.edit_xcLims, [], handles);
handles = edit_ycLims_Callback(handles.edit_ycLims, [], handles);
handles = edit_zcLims_Callback(handles.edit_zcLims, [], handles);
%% 5 - Updating UI elements if Kf has already been determined before
if isfield(handles.myData, 'kf')
    % -- Activating the UI elements
    set(handles.pushbutton_ViewKf, 'Enable', 'on');
    % -- Initialising the scan sliders
    if handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)"
        set(handles.popupmenu_kfType, 'Enable', 'on');
        set(handles.slider_zIndx,'min', 1, 'max', length(handles.myData.kf),...
            'Value', 1, 'SliderStep', [1/(length(handles.myData.kf)-1), 1/(length(handles.myData.kf)-1)]);
        handles = slider_zIndx_Callback(handles.slider_zIndx, [], handles, 0);
        set(findall(handles.uipanel_kfBrowser, '-property', 'enable'), 'enable', 'on');
    end
end
%% 6 - View the loaded data
view_data(handles.myData, handles.fig_args);
%% Display the handles data
pushbutton_INFO_Callback(handles.pushbutton_INFO, [], handles);
%% Save the handles structure
handles.FileName = FileName;
guidata(hObject, handles);

% --- Executes on button press in pushbutton_SAVE.
function pushbutton_SAVE_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_SAVE (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - User defined FileName and Path for the processed data
filter = {'*.mat'};
% handles.FileName = '';
[save_filename, save_filepath] = uiputfile(filter, 'Save processed ARPES data', handles.FileName);
save_fullfile = char(string(save_filepath) + string(save_filename));
% - If Cancel is pressed, then return nothing
if isequal(save_filepath,0) || isequal(save_filename,0); return; end
%% 2 - Executing the saving of the processed data
wbar=waitbar(0.5,'Saving...'); 
dataStruc = handles.myData;
save(char(save_fullfile), 'dataStruc', '-v7.3');
disp('-> saved arpes data with kf : '); display(handles.myData);
close(wbar);
%% 3 - Saving a figure with the data
fig = view_kf(handles.myData, handles.kf_fig_args);
print(fig, char(save_fullfile(1:end-4)+"_kf.png"), '-dpng');

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
if plotfig == 1; view_data(handles.myData, handles.fig_args); end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_scanSlider_CreateFcn(hObject, ~, handles)
% hObject    handle to slider_scanSlider (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%% 1 - Setting the default value
handles.fig_args{1} =  1;
set(hObject,'Value', 1);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_isoSlice_Callback(hObject, ~, handles)
% hObject    handle to edit_isoSlice (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

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
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_isoSlice_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_isoSlice (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_isoType_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_isoType (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
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
    set(handles.statictext_FilterParam, 'string', 'hwX,hwY:');
    handles.filter_args{2} = [0.5, 0.5];
% For 'GaussFlt2' smoothing
elseif data_entry == "GaussFlt2"
    set(handles.statictext_FilterParam, 'string', 'hwX,hwY:');
    handles.filter_args{2} = [1.5, 1.5];
% For 'LaplaceFlt2' smoothing
elseif data_entry == "LaplaceFlt2"
    set(handles.statictext_FilterParam, 'string', 'y2xRatio:');
    handles.filter_args{2} = 1;
% For 'CurvatureFlt2' smoothing
elseif data_entry == "CurvatureFlt2"
    set(handles.statictext_FilterParam, 'string', 'CX,CY:');
    handles.filter_args{2} = [1,1];
end
handles.filter_args{1} = string(contents{get(hObject,'Value')});
%% 3 - Printing the change that has occured
fprintf("--> Filter Type: " + handles.filter_args{1} + " \n");
if handles.filter_args{1} == "LaplaceFlt2"
    set(handles.edit_FilterParam,'String', string(handles.filter_args{2})); 
    fprintf("--> "+ get(handles.statictext_FilterParam, 'string')+" "+string(handles.filter_args{2}) + " \n");
else
    set(handles.edit_FilterParam,'String', string(handles.filter_args{2}(1) + "," + handles.filter_args{2}(2))); 
    fprintf("--> "+ get(handles.statictext_FilterParam, 'string')+" "+string(handles.filter_args{2}(1) + "," + handles.filter_args{2}(2)) + " \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_FilterType_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_FilterType (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
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
function edit_FilterParam_Callback(hObject, ~, handles)
% hObject    handle to edit_FilterParam (see GCBO)
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
        data_entry = [1.5, 1.5];
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
        data_entry = 1;
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
    fprintf("--> "+ get(handles.statictext_FilterParam, 'string')+" "+string(handles.filter_args{2}) + " \n");
else
    set(hObject,'String', string(handles.filter_args{2}(1) + "," + handles.filter_args{2}(2))); 
    fprintf("--> "+ get(handles.statictext_FilterParam, 'string')+" "+string(handles.filter_args{2}(1) + "," + handles.filter_args{2}(2)) + " \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_FilterParam_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_FilterParam (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
	'Filter?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
%% Update handles structure
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIND KF  %%%%%%%%%%

%%%% Kf finding type %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in popupmenu_kfType.
function handles = popupmenu_kfType_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_kfType (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
contents = cellstr(get(hObject,'String'));
data_entry = string(contents{get(hObject,'Value')});
%% 2 - Validity check of the input
% - For an Eb(kx,ky) or Eb(kx,kz) type that has kf determined
if isfield(handles.myData, 'kf') && (handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)")
    set(hObject, 'Enable', 'on'); 
    if data_entry == "global - findpeaks()" || data_entry == "global - max()"
        set(handles.edit_mdcLims, 'Enable', 'on');
        set(handles.edit_xLims, 'Enable', 'on');
        set(handles.edit_zLims, 'Enable', 'on');
        set(handles.edit_kfIndex, 'Enable', 'off');
        set(handles.edit_kfPeakLocs, 'Enable', 'off');
        set(handles.edit_dKf, 'Enable', 'off');
    elseif data_entry == "local - findpeaks()"
        set(handles.edit_mdcLims, 'Enable', 'off');
        set(handles.edit_xLims, 'Enable', 'on');
        set(handles.edit_zLims, 'Enable', 'off');
        set(handles.edit_kfIndex, 'Enable', 'on');
        set(handles.edit_kfPeakLocs, 'Enable', 'on');
        set(handles.edit_dKf, 'Enable', 'on');
    elseif data_entry == "local - manual"
        set(handles.edit_mdcLims, 'Enable', 'off');
        set(handles.edit_xLims, 'Enable', 'off');
        set(handles.edit_zLims, 'Enable', 'off');
        set(handles.edit_kfIndex, 'Enable', 'on');
        set(handles.edit_kfPeakLocs, 'Enable', 'on');
        set(handles.edit_dKf, 'Enable', 'on');
    end
% - For an Eb(kx,ky) or Eb(kx,kz) type that has not had kf determined
elseif ~isfield(handles.myData, 'kf') && (handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)")
    data_entry = "global - findpeaks()";
    set(hObject, 'Enable', 'off', 'Value', 1); 
    set(handles.edit_mdcLims, 'Enable', 'on');
    set(handles.edit_xLims, 'Enable', 'on');
    set(handles.edit_zLims, 'Enable', 'on');
    set(handles.edit_kfIndex, 'Enable', 'off');
    set(handles.edit_kfPeakLocs, 'Enable', 'off');
    set(handles.edit_dKf, 'Enable', 'off');
    
% - For an Eb(k) type that has had kf determined
elseif isfield(handles.myData, 'kf') && handles.myData.Type == "Eb(k)"
    set(hObject, 'Enable', 'on'); 
    if data_entry == "global - findpeaks()" || data_entry == "global - max()"
        set(handles.edit_mdcLims, 'Enable', 'on');
        set(handles.edit_xLims, 'Enable', 'on');
        set(handles.edit_zLims, 'Enable', 'off');
        set(handles.edit_kfIndex, 'Enable', 'off');
        set(handles.edit_kfPeakLocs, 'Enable', 'off');
        set(handles.edit_dKf, 'Enable', 'off');
    elseif data_entry == "local - findpeaks()"
        set(handles.edit_mdcLims, 'Enable', 'on');
        set(handles.edit_xLims, 'Enable', 'on');
        set(handles.edit_zLims, 'Enable', 'off');
        set(handles.edit_kfIndex, 'Enable', 'off');
        set(handles.edit_kfPeakLocs, 'Enable', 'on');
        set(handles.edit_dKf, 'Enable', 'on');
    elseif data_entry == "local - manual"
        set(handles.edit_mdcLims, 'Enable', 'on');
        set(handles.edit_xLims, 'Enable', 'on');
        set(handles.edit_zLims, 'Enable', 'off');
        set(handles.edit_kfIndex, 'Enable', 'off');
        set(handles.edit_kfPeakLocs, 'Enable', 'on');
        set(handles.edit_dKf, 'Enable', 'on');
    end
    
% - For an Eb(k) type that has not had kf determined
elseif ~isfield(handles.myData, 'kf') && handles.myData.Type == "Eb(k)"
    data_entry = "global - findpeaks()";
    set(hObject, 'Enable', 'off', 'Value', 1); 
    set(handles.edit_mdcLims, 'Enable', 'on');
    set(handles.edit_xLims, 'Enable', 'on');
    set(handles.edit_zLims, 'Enable', 'off');
    set(handles.edit_kfIndex, 'Enable', 'off');
    set(handles.edit_kfPeakLocs, 'Enable', 'off');
    set(handles.edit_dKf, 'Enable', 'off');
end
%% 3 - Updating handle information
handles.kf_args{1} = data_entry;
fprintf("--> kfType: " + string(handles.kf_args{1}) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_kfType_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_kfType (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
contents = cellstr(get(hObject,'String'));
handles.kf_args{1} = string(contents{1});
set(hObject,'Value', 1);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_kfIndex_Callback(hObject, ~, handles)
% hObject    handle to edit_kfIndex (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = sort(floor(str2num(strrep(get(hObject,'String'),':',' '))));
%% 2- Validity check
% - Setting max limits
if isfield(handles.myData, 'kf');  max_value = length(handles.myData.kf); end
% - Setting constraints on the input
if ~isfield(handles.myData, 'kf') || isempty(data_entry) || length(data_entry) > 2
    handles.kf_args{2} = 1;
    set(hObject,'String', handles.kf_args{2});  
    fprintf("--> kf index: " + string(handles.kf_args{2}) + " \n");
elseif length(data_entry) == 1
    if data_entry > max_value; data_entry = max_value;
    elseif data_entry < 1; data_entry = 1;
    end
    handles.kf_args{2} = data_entry;
    set(hObject,'String', handles.kf_args{2});  
    fprintf("--> kf index: " + string(handles.kf_args{2}) + " \n");
elseif length(data_entry) == 2
        if data_entry(1) < 1; data_entry(1) = 1; end
        if data_entry(2) > max_value; data_entry(2) = max_value; end
        handles.kf_args{2} = data_entry;
        set(hObject,'String', string(handles.kf_args{2}(1) + ":" + handles.kf_args{2}(2))); 
        fprintf("--> kf index: " + string(handles.kf_args{2}(1) + ":" + handles.kf_args{2}(2)) + " \n");
else
    handles.kf_args{2} = data_entry;
    set(hObject,'String', handles.kf_args{2});  
    fprintf("--> kf index: " + string(handles.kf_args{2}) + " \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_kfIndex_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_kfIndex (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.kf_args{2} = 1; 
set(hObject,'String', handles.kf_args{2});
%5 Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_kfPeakLocs_Callback(hObject, ~, handles)
% hObject    handle to edit_kfPeakLocs (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
[xField, ~, ~, ~] = find_data_fields(handles.myData);
data_entry = round(str2num(strrep(get(hObject,'String'),':',' ')), 4);
%% 2 - Validity check on input
% - If no entry is made, default to the maximum range
if ~isfield(handles.myData, 'kf') || isempty(data_entry) || length(data_entry) > 2 || length(data_entry) < 2
    data_entry = [0, 0];
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 2
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < min(handles.myData.(xField)(:)) || data_entry(1) > max(handles.myData.(xField)(:)); data_entry(1) = min(handles.myData.(xField)(:)); end
    if data_entry(2) < min(handles.myData.(xField)(:)) || data_entry(2) > max(handles.myData.(xField)(:)); data_entry(2) = max(handles.myData.(xField)(:)); end
end
%% 3 - Assigning output and printing change
handles.kf_args{3}  = round(data_entry, 4);
set(hObject,'String', string(handles.kf_args{3}(1) + "," + handles.kf_args{3}(2))); 
fprintf("--> peak locs: " + string(handles.kf_args{3}(1) + "," + handles.kf_args{3}(2)) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_kfPeakLocs_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_kfPeakLocs (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.kf_args{3} = 1; 
set(hObject,'String', handles.kf_args{3});
%5 Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_dKf_Callback(hObject, ~, handles)
% hObject    handle to edit_dKf (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = abs(round(str2num(strrep(get(hObject,'String'),':',' ')), 4));
%% 2 - Validity check on input
% - If no entry is made, default to the maximum range
if ~isfield(handles.myData, 'kf') || isempty(data_entry) || length(data_entry) > 1 || length(data_entry) < 1
    data_entry = 0.01;
end
%% 3 - Assigning output and printing change
handles.kf_args{9}  = round(data_entry, 4);
set(hObject,'String', handles.kf_args{9}); 
fprintf("--> Kf uncertainty: " + string(handles.kf_args{9}) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_dKf_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_dKf (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.kf_args{9} = 0.01; 
set(hObject,'String', handles.kf_args{9});
%5 Update handles structure
guidata(hObject, handles);


%%%% Kf finding limits %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes when changing the text
function handles = edit_mdcLims_Callback(hObject, ~, handles)
% hObject    handle to edit_mdcLims (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
[~, yField, ~, ~] = find_data_fields(handles.myData);
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 2);
%% 2 - Validity check on input
 % - If no entry is made, default to the maximum range
if isempty(data_entry) || length(data_entry) > 2
    data_entry = [-0.1, 0.0];
% - If a single entry is made, ensure it does not exceed the max / min limits and add a small range
elseif length(data_entry) == 1
    data_entry = [-0.05, 0.05]+data_entry; 
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < min(handles.myData.(yField)(:)) || data_entry(1) > max(handles.myData.(yField)(:)); data_entry(1) = min(handles.myData.(yField)(:)); end
    if data_entry(2) < min(handles.myData.(yField)(:)) || data_entry(2) > max(handles.myData.(yField)(:)); data_entry(2) = max(handles.myData.(yField)(:)); end
 % - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 2
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < min(handles.myData.(yField)(:)) || data_entry(1) > max(handles.myData.(yField)(:)); data_entry(1) = min(handles.myData.(yField)(:)); end
    if data_entry(2) < min(handles.myData.(yField)(:)) || data_entry(2) > max(handles.myData.(yField)(:)); data_entry(2) = max(handles.myData.(yField)(:)); end
end
%% 3 - Assigning output and printing change
handles.kf_args{4}  = sort(round(data_entry, 2));
set(hObject,'String', string(handles.kf_args{4} (1) + ":" + handles.kf_args{4} (2))); 
fprintf("--> yLims: " + string(handles.kf_args{4} (1) + ":" + handles.kf_args{4} (2)) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_mdcLims_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_mdcLims (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.kf_args{4} = []; 
set(hObject,'String', "[]");
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_xLims_Callback(hObject, ~, handles)
% hObject    handle to edit_xLims (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
[xField, ~, ~, ~] = find_data_fields(handles.myData);
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 2);
%% 2 - Validity check on input
% - If no entry is made, default to the maximum range
if isempty(data_entry) || length(data_entry) > 2
    data_entry = [-0.1, 0.1];
% - If a single entry is made, ensure it does not exceed the max / min limits and add a small range
elseif length(data_entry) == 1
    data_entry = [-0.1, 0.1]+data_entry; 
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < min(handles.myData.(xField)(:)) || data_entry(1) > max(handles.myData.(xField)(:)); data_entry(1) = min(handles.myData.(xField)(:)); end
    if data_entry(2) < min(handles.myData.(xField)(:)) || data_entry(2) > max(handles.myData.(xField)(:)); data_entry(2) = max(handles.myData.(xField)(:)); end
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 2
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < min(handles.myData.(xField)(:)) || data_entry(1) > max(handles.myData.(xField)(:)); data_entry(1) = min(handles.myData.(xField)(:)); end
    if data_entry(2) < min(handles.myData.(xField)(:)) || data_entry(2) > max(handles.myData.(xField)(:)); data_entry(2) = max(handles.myData.(xField)(:)); end
end
%% 3 - Assigning output and printing change
handles.kf_args{5}  = sort(round(data_entry, 2));
set(hObject,'String', string(handles.kf_args{5} (1) + ":" + handles.kf_args{5} (2))); 
fprintf("--> xLims: " + string(handles.kf_args{5} (1) + ":" + handles.kf_args{5} (2)) + " \n");
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
handles.kf_args{5} = []; 
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
    handles.kf_args{6}  = sort(round(data_entry, 2));
    set(hObject,'String', string(handles.kf_args{6})); 
    fprintf("--> zLims: " + string(handles.kf_args{6} + " \n"));
elseif handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)"
    handles.kf_args{6}  = sort(round(data_entry, 2));
    set(hObject,'String', string(handles.kf_args{6}(1) + ":" + handles.kf_args{6}(2))); 
    fprintf("--> zLims: " + string(handles.kf_args{6} (1) + ":" + handles.kf_args{6}(2)) + " \n");
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
handles.kf_args{6} = []; 
set(hObject,'String', "[]");
%% Update handles structure
guidata(hObject, handles);

%%%% MDC pre-smoothing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in popupmenu_smoothType.
function popupmenu_smoothType_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_smoothType (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
contents = cellstr(get(hObject,'String'));
data_entry = string(contents{get(hObject,'Value')});
%% 2 - Validity check of the input
handles.kf_args{7} = data_entry;
fprintf("--> MDC smooth type: " + string(handles.kf_args{7}) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_smoothType_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_smoothType (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
contents = cellstr(get(hObject,'String'));
handles.kf_args{7} = string(contents{1});
set(hObject,'Value', 1);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_hwX_Callback(hObject, ~, handles)
% hObject    handle to edit_hwX (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = abs(round(str2num(get(hObject,'String')), 3));
%% 2- Validity check
if isempty(data_entry); data_entry = 1;
elseif length(data_entry) > 1; data_entry = data_entry(1);
end
handles.kf_args{8}  = sort(round(data_entry, 3));
set(hObject,'String', handles.kf_args{8});  
fprintf("--> MDC smooth parameter (hwX): " + string(handles.kf_args{8}) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_hwX_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_hwX (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.kf_args{8} = 1; 
set(hObject,'String', "1");
%% Update handles structure
guidata(hObject, handles);

%%%% Execute Kf extraction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in pushbutton_ExtractKf.
function pushbutton_ExtractKf_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExtractKf (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Executing the Kf finder function
handles.myData = extract_kf(handles.myData, handles.kf_args);
%% 2 - Updating UI elements
% -- Activating the UI elements
set(handles.pushbutton_ViewKf, 'Enable', 'on');
% -- Updating UI elements as required
if handles.myData.Type == "Eb(k)"
    handles = popupmenu_kfType_Callback(handles.popupmenu_kfType, [], handles);
    
elseif handles.myData.Type == "Eb(kx,ky)" || handles.myData.Type == "Eb(kx,kz)"
    % - Reset the scan slider for global Kf finding
    if handles.kf_args{1} == "global - findpeaks()" || handles.kf_args{1}  == "global - max()"
        set(handles.slider_zIndx,'min', 1, 'max', length(handles.myData.kf),...
            'Value', 1, 'SliderStep', [1/(length(handles.myData.kf)-1), 1/(length(handles.myData.kf)-1)]);
        handles = slider_zIndx_Callback(handles.slider_zIndx, [], handles, 0);
    end
    set(findall(handles.uipanel_kfBrowser, '-property', 'enable'), 'enable', 'on');
    set(handles.popupmenu_kfType, 'Enable', 'on');
end
%% 3 - Plotting the Kf figure
view_kf(handles.myData, handles.kf_fig_args);
%% Update the handles
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% VIEW KF  %%%%%%%%%%
% --- Executes on slider movement.
function handles = slider_zIndx_Callback(hObject, ~, handles, plotfig)
% hObject    handle to slider_zIndx (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Default parameters
if nargin < 4; plotfig =  1; end
if isempty(plotfig); plotfig =  1;  end
%% 1 - Extracting the slider value
handles.kf_fig_args{1} = floor(get(hObject, 'Value'));
%% 2 - Modifying the text to show the scan indx/number
set(handles.text_zIndex,'String', handles.kf_fig_args{1});
set(handles.text_zValue,'String', round(handles.myData.kf{handles.kf_fig_args{1}}.scan, 2));
set(handles.text_zValue,'String', round(handles.myData.kf{handles.kf_fig_args{1}}.scan, 2));
%% 3 - Modifying the kf index and peak location
% - Modifying kf index
set(handles.edit_kfIndex, 'String', handles.kf_fig_args{1});
handles = edit_kfIndex_Callback(handles.edit_kfIndex, [], handles);
% - Modifying peak locations
locs = handles.myData.kf{handles.kf_fig_args{1}}.locs;
locs_str = string(locs(1) + "," + locs(2));
set(handles.edit_kfPeakLocs, 'String', locs_str);
handles = edit_kfPeakLocs_Callback(handles.edit_kfPeakLocs, [], handles);
% - Modifying the kf uncertainty
dKf = handles.myData.kf{handles.kf_fig_args{1}}.dKf;
set(handles.edit_dKf, 'String', dKf);
handles = edit_dKf_Callback(handles.edit_dKf, [], handles);
%% 4 - Plotting the latest ARPES data
if plotfig == 1; view_kf(handles.myData, handles.kf_fig_args); end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_zIndx_CreateFcn(hObject, ~, handles)
% hObject    handle to slider_zIndx (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%% 1 - Setting the default value
handles.kf_fig_args{1} =  1;
set(hObject,'Value', 1);
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ViewKf.
function pushbutton_ViewKf_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ViewKf (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% - Plotting the Kf figure
view_kf(handles.myData, handles.kf_fig_args);

% --- Executes on button press in pushbutton_ViewROI.
function pushbutton_ViewROI_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ViewROI (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Plotting the ARPES data and ROI
view_roi(handles.myData, handles.fig_args, handles.kf_args);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INTERNAL PROCESSING FUNCTIONS %%%%%%%%%%%
% ---  Function to load in the data
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

% ---  Function to extract Kf
function dataStr = extract_kf(dataStr, kf_args)
% kfStr = extract_kf(dataStr, kf_args)
%   This function determines the most recent processed 
%   fields of the ARPES data-structure so that the correct
%   post-processing can be performed in any order. The
%   fields can be used to explicitly call a field within dataStr
%   by using dataStr.(xField) for example.
%   in:
%   -   dataStr:           data structure of the ARPES data.
%   -   kf_args:           1x6 cell array {kfType, zIndex, mdcLims, xLims, zLims, Smooth}.
%   out:
%   -   kfStr:                data structure of the Kf analysis.
%   .(XCut_raw):               tht/kx vector of MDC cut.
%   .(DCut_raw):               data vector of MDC cut.
%   .(DCut_smth):        smoothed data vector of MDC cut.
%   .(XCut_diff):                differentiated MDC domain.
%   .(DCut_diff):               differentiated MDC range.
%   .(pks):                            peaks of the differentiated MDC.
%   .(locs):                            tht/kx location of the peaks in the differentiated MDC.
%   .(scan):                           z scan value of the MDC cut.s
%   .(kf):                               kf of the MDC cut.
 
disp('Extracting Kf...')
wbar = waitbar(0., 'Finding Kf...', 'Name', 'extract_kf');

%% - Initialising variables
% - Extracting the input variables
kfType = kf_args{1};
kfIndex = kf_args{2};
peakLocs = kf_args{3};
mdcLims = kf_args{4};
xLims = kf_args{5};
zLims = kf_args{6};
smoothtype = kf_args{7};
hwX = kf_args{8};
dKf_val = kf_args{9};
% - Extracting the field with most recent processing
[xField, yField, zField, dField] = find_data_fields(dataStr);

%% 1 - Extracting the scan- and kf-indices for using the kF finder
% - Defining the scan values and indices for Eb(k) type
if dataStr.Type == "Eb(k)"
    % -- Determination of the scan values
    scan_values = dataStr.(zField)(:);
    % -- Only a single scan and kf index exists
    scan_indxs = 1;
    kf_indxs = 1;
    
% - Defining the scan values and indices for Eb(kx,ky) and Eb(kx,kz) type
elseif dataStr.Type == "Eb(kx,ky)" || dataStr.Type == "Eb(kx,kz)"
    % -- Determination of the scan values
    if isfield(dataStr, 'kx')
        ebIndx = floor(0.5*size(dataStr.(dField), 1));
        kxIndx = floor(0.5*size(dataStr.(dField), 2));
        scan_values = dataStr.(zField)(ebIndx,kxIndx,:);
    else
        scan_values = dataStr.(zField)(:);
    end
    % -- Determination of the upper and lower indices for the scans
    [~, zIndxL] = min(abs(scan_values - zLims(1)));
    [~, zIndxU] = min(abs(scan_values - zLims(2)));
    
    % -- Determination of the scan indices for global kf extraction
    if kfType == "global - findpeaks()" || kfType == "global - max()"
        if isfield(dataStr, 'kf'); dataStr = rmfield(dataStr, 'kf'); end
        scan_indxs = zIndxL:zIndxU;
        kf_indxs = 1:abs(zIndxU-zIndxL+1);
            
    % -- Determination of the scan indices for local kf extraction
    elseif kfType == "local - findpeaks()" || kfType == "local - manual"
        if ~isfield(dataStr, 'kf')
            kfType = "global - findpeaks()";
            scan_indxs = zIndxL:zIndxU;
            kf_indxs = 1:abs(zIndxU-zIndxL+1);
        elseif length(kfIndex) == 1
            kf_indxs = kfIndex;
            scan_indxs = zIndxL+(kfIndex-1);
        else
            kf_indxs = kfIndex(1):kfIndex(2);
            scan_indxs = zIndxL+(kfIndex(1)-1):zIndxL+(kfIndex(2)-1);
        end
    end
end

%% - 2 - Finding Kf over all the z-indices that are selected
for i = 1:length(kf_indxs)
    waitbar(i/length(kf_indxs), wbar, 'Extracting Kf...', 'Name', 'extract_kf');
    
    % - 2.0 - Extracting the ROI ARPES variables and data
    if isfield(dataStr, 'kx') || isfield(dataStr, 'data') || isfield(dataStr, 'eb')
        XData = dataStr.(xField)(:,:,scan_indxs(i));
        YData = dataStr.(yField)(:,:,scan_indxs(i));
        DData = dataStr.(dField)(:,:,scan_indxs(i));
    else
        XData = dataStr.(xField);
        YData = dataStr.(yField);
        DData = dataStr.(dField)(:,:,scan_indxs(i));
    end
    % - 2.1 - Extracting raw MDC cut
    [XCut_raw, DCut_raw] = Cut(XData, YData, DData, 'mdc', mdcLims);
    % - 2.2 - Smoothing the MDC cut
    if smoothtype == "None"
        DCut_smth = DCut_raw;
    elseif smoothtype == "Gaco2"
        DCut_smth = Gaco2(DCut_raw, hwX, hwX);
    elseif smoothtype == "Binomial"
        coeff = ones(1, 24);
        DCut_smth = filter(coeff, hwX, DCut_raw);
    elseif smoothtype == "Savitzky-Golay"
        DCut_smth = sgolayfilt(DCut_raw, hwX, 11);
    end
    % - 2.3 - Differentiating the MDC cut twice to find Kf inflexion points
    % -- Finding second derivative
    dx = abs(XCut_raw(1) - XCut_raw(2));
    DCut_diff2 = abs(diff(DCut_smth(:), 2) ./ dx);
    XCut_diff2 = XCut_raw(1:length(DCut_diff2));
    if smoothtype == "None"
        DCut_diff2 = DCut_diff2;
    elseif smoothtype == "Gaco2"
        DCut_diff2 = Gaco2(DCut_diff2, hwX, hwX);
    elseif smoothtype == "Binomial"
        coeff = ones(1, 24);
        DCut_diff2 = filter(coeff, hwX, DCut_diff2);
    elseif smoothtype == "Savitzky-Golay"
        DCut_diff2 = sgolayfilt(DCut_diff2, hwX, 9);
    end
    
    % - 2.4 - Extracting the the peaks and locations
    % - Cropping MDC over x-limits defined by the user
    [~, minXindx] = min(abs(XCut_diff2 - xLims(1)));
    [~, maxXindx] = min(abs(XCut_diff2 - xLims(2)));
    xcut = XCut_diff2(minXindx:maxXindx);
    dcut = DCut_diff2(minXindx:maxXindx);
    % -- Initialising pks and locs arrays
    pks = []; locs = [];
    
    % -- For a global kf finding using findpeaks() function
    if kfType == "global - findpeaks()"
        [pks_val, ilocs] = findpeaks(dcut);
        % -- If only 1 peak is found, force kf to be zero
        if length(pks_val) == 1
            pks = [pks_val(1), pks_val(1)];
            locs = [xcut(ilocs(1)), xcut(ilocs(1))];   
        % -- For multiple peaks, search for largest difference
        else
            % --- Finding all of the potential candidates for Kf
            all_locs = xcut(ilocs);
             % --- Sort into ascending order of intensity
            [pks_val, srt_indx] = sort(pks_val);
            all_locs = all_locs(srt_indx);
            % --- Select only the last two, which are the highest +ve intensities
            pks = [pks_val(end-1), pks_val(end)];
            locs = [all_locs(end-1), all_locs(end)]; 
        end
        % -- Extracting an estimate for the uncertainty based on max/min values
        dKf = 0.01 .* abs(max(DCut_smth(:)) ./ (max(DCut_smth(:)) - min(DCut_smth(:))));
        
    % -- For a global kf finding using max() function on LHS and RHS
    elseif kfType == "global - max()"
        % --- Splitting the MDC in half from the origin
        [~, srt_indx] = min(abs(XCut_raw - 0));
        lhs_xcut = XCut_raw(1:srt_indx); 
        lhs_dcut = DCut_smth(1:srt_indx);
        rhs_xcut = XCut_raw(srt_indx:end); 
        rhs_dcut = DCut_smth(srt_indx:end);
        % --- Extracting the peaks and locations from LHS and RHS
        [pks(1), srt_indx] = max(lhs_dcut(:)); 
        locs(1) = lhs_xcut(srt_indx);
        [pks(2), srt_indx] = max(rhs_dcut(:));
        locs(2) = rhs_xcut(srt_indx);
        % -- Extracting an estimate for the uncertainty based on max/min values
        dKf = 0.01 .* abs(max(DCut_smth(:)) ./ (max(DCut_smth(:)) - min(DCut_smth(:))));
        
    % -- For a local kf finder at a specific kf-index using findpeaks()
    elseif kfType == "local - findpeaks()"
        [pks_val, ilocs] = findpeaks(dcut);
        % -- If only 1 peak is found, force kf to be zero
        if length(pks_val) == 1
            pks = [pks_val(1), pks_val(1)];
            locs = [xcut(ilocs(1)), xcut(ilocs(1))];   
        % -- For multiple peaks, search for the peaks nearest to entries made
        else
            % --- Finding all of the potential candidates for Kf
            all_locs = xcut(ilocs);
            % --- select the closest values for Kf given the entries
            [~, indx1] = min(abs(all_locs - peakLocs(1)));
            [~, indx2] = min(abs(all_locs - peakLocs(2)));
            pks = [pks_val(indx1), pks_val(indx2)];
            locs = [all_locs(indx1), all_locs(indx2)];
        end
        % -- Extracting an estimate for the uncertainty based on max/min values
        dKf = dKf_val;
        
    % -- For manually inputting the peak locations to find Kf
    elseif kfType == "local - manual"
        % -- Finding the peak values given the peak locations
        [~, indx1] = min(abs(xcut - peakLocs(1)));
        [~, indx2] = min(abs(xcut - peakLocs(2)));
        pks = [dcut(indx1), dcut(indx2)];
        locs = [peakLocs(1), peakLocs(2)];    
        % -- Extracting an estimate for the uncertainty based on max/min values
        dKf = dKf_val;
    end
    
    % - 2.5 - Sorting the pks and locs into ascending order of locs
    [locs, srt_indx] = sort(locs);
    pks = pks(srt_indx);
    
    % - 2.6 - Finding the scan value and Kf
    scan = scan_values(scan_indxs(i));
    kf = abs(diff(locs));
    
    % - 2.7 - Assigning the variables to the final data structure
    dataStr.kf{kf_indxs(i)}.kf_args = kf_args;
    dataStr.kf{kf_indxs(i)}.XData = XData;
    dataStr.kf{kf_indxs(i)}.YData = YData;
    dataStr.kf{kf_indxs(i)}.DData = DData;
    dataStr.kf{kf_indxs(i)}.XCut_raw = XCut_raw;
    dataStr.kf{kf_indxs(i)}.DCut_raw = DCut_raw;
    dataStr.kf{kf_indxs(i)}.DCut_smth = DCut_smth;
    dataStr.kf{kf_indxs(i)}.XCut_diff = XCut_diff2;
    dataStr.kf{kf_indxs(i)}.DCut_diff = DCut_diff2;
    dataStr.kf{kf_indxs(i)}.pks = round(pks, 4);
    dataStr.kf{kf_indxs(i)}.locs = round(locs, 4);
    dataStr.kf{kf_indxs(i)}.scan = round(scan, 4);
    dataStr.kf{kf_indxs(i)}.kf = round(kf, 4);
    dataStr.kf{kf_indxs(i)}.dKf = round(dKf, 4);
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

% --- General function to view the region of interest
function view_roi(dataStr, fig_args, kf_args)
% view_roi(dataStr, fig_args, kf_args)
%   This function plots the 2D ARPES spectrum in the form of D(X,Y), along
%   with the region of interest that is used to determine Kf.
%
%   REQ. FUNCTIONS:
%   -   [xField, yField, zField, dField] = find_data_fields(dataStr);
%   -   gca_properties(type)
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   dataStr:           data structure of the ARPES data.
%   -   fig_args:          empty for 2D or 1x4 cell of {scanIndex, isoSlice, isoType, remap} for 3D.
%   -   kf_args:           1x6 cell array {kfType, zIndex, mdcLims, xLims, zLims, Smooth}.
%
%   OUT:
%   -   figure output.

%% Initial parameters
% - Extracting the fields to be used with most recent processing
[xField, yField, ~, dField] = find_data_fields(dataStr);
%% 1 - Plotting the ARPES data
figure(); hold on;
% -- Extracting the ARPES data and showing the image
if isfield(dataStr, 'kx') || isfield(dataStr, 'data') || isfield(dataStr, 'eb')
    x = dataStr.(xField)(:,:,fig_args{1});
    y = dataStr.(yField)(:,:,fig_args{1});
    d = dataStr.(dField)(:,:,fig_args{1});
    ImData(x, y, d);
else
    x = dataStr.(xField);
    y = dataStr.(yField);
    d = dataStr.(dField)(:,:,fig_args{1});
    ImData(x, y, d);
end
% -- General formatting of the figure
gca_properties(string(xField));
axis([min(x(:)), max(x(:)), min(y(:)), max(y(:))]);
% -- Adding title to the figure
title(sprintf(string(dataStr.H5file) + "; scan %i", fig_args{1}), 'interpreter', 'none', 'fontsize', 12);
%% 2 - Plotting the region of interest
y = [kf_args{4}(1), kf_args{4}(2), kf_args{4}(2), kf_args{4}(1), kf_args{4}(1)];
x = [kf_args{5}(1), kf_args{5}(1), kf_args{5}(2), kf_args{5}(2), kf_args{5}(1)];
patch(x, y, [0.2, 0.8, 0.2], 'FaceAlpha',0.4, 'EdgeColor', [0.2, 0.8, 0.2]);

% --- General function to view the Kf extraction
function fig = view_kf(dataStr, kf_fig_args)
% fig = view_kf(dataStr, kf_args, kf_fig_args)
%   This function plots the result of Kf.
%
%   REQ. FUNCTIONS:
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   dataStr:              data structure of the ARPES data.
%   -   kf_fig_args:        1x1 cell of {kfIndex}.
%
%   OUT:
%   -   fig:                  MATLAB figure object with the ARPES data plotted.

% - Extracting the field with most recent processing
[xField, yField, ~, ~] = find_data_fields(dataStr);

%% Cropping around the region of interest
% - Determination of the crop-limits
xLims = []; yLims = [];
for i = 1:length(dataStr.kf)
    min_xLim(i) = dataStr.kf{kf_fig_args{1}}.kf_args{5}(1);
    max_xLim(i) = dataStr.kf{kf_fig_args{1}}.kf_args{5}(2);
    min_yLim(i) = dataStr.kf{kf_fig_args{1}}.kf_args{4}(1);
    max_yLim(i) = dataStr.kf{kf_fig_args{1}}.kf_args{4}(2);
end
xLims = [mean(min_xLim(:)), mean(max_xLim(:))]+[-0.25, 0.25];
yLims = [mean(min_yLim(:)), mean(max_yLim(:))]+[-0.35, 0.25];
% - Determination of the crop-limit indices
[~, xIndx_L] = min(abs(dataStr.kf{kf_fig_args{1}}.XData(1,:) - xLims(1)));
[~, xIndx_U] = min(abs(dataStr.kf{kf_fig_args{1}}.XData(1,:) - xLims(2)));
xLims_indx = [xIndx_L,xIndx_U];
[~, yIndx_L] = min(abs(dataStr.kf{kf_fig_args{1}}.YData(:,1) - yLims(1)));
[~, yIndx_U] = min(abs(dataStr.kf{kf_fig_args{1}}.YData(:,1) - yLims(2)));
yLims_indx = [yIndx_L,yIndx_U];
% - Determination of the new, cropped data variables
if string(xField) == "kx" || string(yField) == "eb"
    x_dat = dataStr.kf{kf_fig_args{1}}.XData(yLims_indx(1):yLims_indx(2), xLims_indx(1):xLims_indx(2));
    y_dat = dataStr.kf{kf_fig_args{1}}.YData(yLims_indx(1):yLims_indx(2), xLims_indx(1):xLims_indx(2));
else
    x_dat = dataStr.kf{kf_fig_args{1}}.XData(1, xLims_indx(1):xLims_indx(2));
    y_dat = dataStr.kf{kf_fig_args{1}}.YData(yLims_indx(1):yLims_indx(2), 1);
end
d_dat = dataStr.kf{kf_fig_args{1}}.DData(yLims_indx(1):yLims_indx(2), xLims_indx(1):xLims_indx(2));

%% Opening the figure object
fig = figure(); set(fig, 'Position', [1,1,950,650]);
hold on;

%% 1 - Plotting the Eb(k) at the scan value
subplot(2,2,1); hold on;
% - Plotting the Eb(k) ARPES image
ImData(x_dat, y_dat, d_dat);
% - General formatting of the figure
gca_properties(string(xField)); colorbar('off');
% - Plotting patch of the uncertainty area for peak location 1
x = [dataStr.kf{kf_fig_args{1}}.locs(1)-dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(1)+dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(1)+dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(1)-dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(1)-dataStr.kf{kf_fig_args{1}}.dKf];
y = [-1e8, -1e8, 1e8, 1e8, -1e8];
patch(x, y, [0.2, 0.2, 0.8], 'FaceAlpha',0.2, 'EdgeColor', [0.2, 0.2, 0.8]);
line([dataStr.kf{kf_fig_args{1}}.locs(1), dataStr.kf{kf_fig_args{1}}.locs(1)], [-1e8, 1e8], 'Color', [0.2,0.2,0.8,0.8], 'LineWidth', 2.5, 'Linestyle', '-');
% - Plotting patch of the uncertainty area for peak location 2
x = [dataStr.kf{kf_fig_args{1}}.locs(2)-dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(2)+dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(2)+dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(2)-dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(2)-dataStr.kf{kf_fig_args{1}}.dKf];
y = [-1e8, -1e8, 1e8, 1e8, -1e8];
patch(x, y, [0.2, 0.2, 0.8], 'FaceAlpha',0.2, 'EdgeColor', [0.2, 0.2, 0.8]);
line([dataStr.kf{kf_fig_args{1}}.locs(2), dataStr.kf{kf_fig_args{1}}.locs(2)], [-1e8, 1e8], 'Color', [0.2,0.2,0.8,0.8], 'LineWidth', 2.5, 'Linestyle', '-');

% - Plotting theROI cut for the MDC
x = [-1e8, 1e8, 1e8, -1e8, -1e8];
y = [dataStr.kf{kf_fig_args{1}}.kf_args{4}(1), dataStr.kf{kf_fig_args{1}}.kf_args{4}(1),...
    dataStr.kf{kf_fig_args{1}}.kf_args{4}(2), dataStr.kf{kf_fig_args{1}}.kf_args{4}(2),...
    dataStr.kf{kf_fig_args{1}}.kf_args{4}(1)];
patch(x, y, [0.2, 0.8, 0.2], 'FaceAlpha',0.2, 'EdgeColor', [0.2, 0.8, 0.2]);
% - Axes limits
axis([min(x_dat(:)), max(x_dat(:)), min(y_dat(:)), max(y_dat(:))]);
% - Adding title to the figure
title(sprintf(string(dataStr.H5file) + "; kf index - %i", kf_fig_args{1}), 'interpreter', 'none', 'fontsize', 12);

%% 2.0 - Plotting a summary of the MDC analysis
subplot(2,1,2); hold on;
% - Plotting raw MDC cut
plot(dataStr.kf{kf_fig_args{1}}.XCut_raw, dataStr.kf{kf_fig_args{1}}.DCut_raw, '.-', 'linewidth', 4, 'color', [0.5,0.5,0.5,0.5]);
% - Plotting smoothed MDC cut
plot(dataStr.kf{kf_fig_args{1}}.XCut_raw, dataStr.kf{kf_fig_args{1}}.DCut_smth, '-', 'linewidth', 2, 'color', [0,0,0]);
% - General figure formatting
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
if string(xField) == "kx"
    xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
else
    xlabel('$$ \bf  \theta (^{\circ}) $$', 'Interpreter', 'latex');
end
ylabel('$$ \bf  MDC $$ $$\bf intensity$$ $$\bf (arb.)$$', 'Interpreter', 'latex');
xlim([min(dataStr.kf{kf_fig_args{1}}.XCut_raw(:)), max(dataStr.kf{kf_fig_args{1}}.XCut_raw(:))]);
title(sprintf("MDC cut %i; Extract KF", kf_fig_args{1}), 'interpreter', 'none', 'fontsize', 12);
%% 2.2 - Plotting a summary of the MDC second derivative
yyaxis right;
y2col = [0.91 0.41 0.17 0.8];
ax.YColor = y2col;
% - Plotting the derivative of the two
plot(dataStr.kf{kf_fig_args{1}}.XCut_diff, dataStr.kf{kf_fig_args{1}}.DCut_diff, '-', 'linewidth', 2, 'color', y2col);
% - Plotting patch of the uncertainty area for peak location 1
x = [dataStr.kf{kf_fig_args{1}}.locs(1)-dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(1)+dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(1)+dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(1)-dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(1)-dataStr.kf{kf_fig_args{1}}.dKf];
y = [-1e8, -1e8, 1e8, 1e8, -1e8];
patch(x, y, [0.2, 0.2, 0.8], 'FaceAlpha',0.2, 'EdgeColor', [0.2, 0.2, 0.8]);
line([dataStr.kf{kf_fig_args{1}}.locs(1), dataStr.kf{kf_fig_args{1}}.locs(1)], [-1e8, 1e8], 'Color', [0.2,0.2,0.8,0.8], 'LineWidth', 2.5, 'Linestyle', '-');
% - Plotting patch of the uncertainty area for peak location 2
x = [dataStr.kf{kf_fig_args{1}}.locs(2)-dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(2)+dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(2)+dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(2)-dataStr.kf{kf_fig_args{1}}.dKf,...
    dataStr.kf{kf_fig_args{1}}.locs(2)-dataStr.kf{kf_fig_args{1}}.dKf];
y = [-1e8, -1e8, 1e8, 1e8, -1e8];
patch(x, y, [0.2, 0.2, 0.8], 'FaceAlpha',0.2, 'EdgeColor', [0.2, 0.2, 0.8]);
line([dataStr.kf{kf_fig_args{1}}.locs(2), dataStr.kf{kf_fig_args{1}}.locs(2)], [-1e8, 1e8], 'Color', [0.2,0.2,0.8,0.8], 'LineWidth', 2.5, 'Linestyle', '-');
% - General formatting
ylim([min(dataStr.kf{kf_fig_args{1}}.DCut_diff(:)), max(dataStr.kf{kf_fig_args{1}}.DCut_diff(:))]);
ylabel('$$ \bf  d^2y/dx^2 (arb.) $$', 'Interpreter', 'latex');
%% 2.3 - Adding a legend to the figure
h = zeros(4, 1);
h(1) = plot(NaN,NaN,'.-', 'linewidth', 5, 'color', [0.5,0.5,0.5,0.5]);
h(2) = plot(NaN,NaN,'-', 'linewidth', 5, 'color', [0,0,0]);
h(3) = plot(NaN,NaN,'-', 'linewidth', 5, 'color', [0.91 0.41 0.17]);
h(4) = plot(NaN,NaN,'-', 'linewidth', 5, 'color', [0.2,0.2,0.8,0.8]);
legend(h, {'$$ MDC_{data} $$','$$ MDC_{smooth} $$','$$ d^2y/dx^2$$ ', '$$ k_{edge}$$ '}, 'interpreter', 'latex');

%% 3 - Plotting kf vs the scan parameter
subplot(2,2,2); hold on;
% - Plotting kf vs scan parameter for all values
for i = 1:length(dataStr.kf)
    errorbar(dataStr.kf{i}.scan, dataStr.kf{i}.kf, dataStr.kf{i}.dKf, 's', 'markersize', 5, 'color', [0,0,0], 'markerfacecolor', [0,0,0]);
end
% - Plotting kf vs scan parameter for the selected scan
stem(dataStr.kf{kf_fig_args{1}}.scan, dataStr.kf{kf_fig_args{1}}.kf, '.', 'linewidth', 1.5, 'color', [0.2,0.2,0.8]);
% - General figure formatting
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
if dataStr.Type == "Eb(kx,ky)"
    if isfield(dataStr, 'kx'); xlabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex'); 
    else; xlabel('$$ \bf  \tau (^{\circ}) $$', 'Interpreter', 'latex');
    end
elseif dataStr.Type == "Eb(kx,kz)"
    if isfield(dataStr, 'kx'); xlabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex'); 
    else; xlabel('$$ \bf  \theta (^{\circ}) $$', 'Interpreter', 'latex');
    end
end
ylabel('$$ \bf  k_F (\AA^{-1}) $$', 'Interpreter', 'latex');
title('Kf vs scan parameter', 'interpreter', 'none', 'fontsize', 12);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% The End %%%%%%%%%%%%%%%%%%%%
