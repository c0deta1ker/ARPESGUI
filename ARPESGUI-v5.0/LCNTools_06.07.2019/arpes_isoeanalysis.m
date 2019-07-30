function varargout = arpes_isoeanalysis(varargin)
% arpes_isoeanalysis MATLAB code for arpes_isoeanalysis.fig
%      ARPES_ISOEANALYSIS, by itself, creates a new ARPES_ISOEANALYSIS or raises the existing
%      singleton*.
%
%      H = ARPES_ISOEANALYSIS returns the handle to a new ARPES_ISOEANALYSIS or the handle to
%      the existing singleton*.
%
%      ARPES_ISOEANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ARPES_ISOEANALYSIS.M with the given input arguments.
%
%      ARPES_ISOEANALYSIS('Property','Value',...) creates a new ARPES_ISOEANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before arpes_isoeanalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to arpes_isoeanalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help arpes_isoeanalysis

% Last Modified by GUIDE v2.5 29-Jul-2019 17:48:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @arpes_isoeanalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @arpes_isoeanalysis_OutputFcn, ...
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
% --- Executes just before arpes_isoeanalysis is made visible.
function arpes_isoeanalysis_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to arpes_isoeanalysis (see VARARGIN)

%% Choose default command line output for arpes_isoeanalysis
handles.output = hObject;
%% 1 - Setting the native size of the whole GUI figure
screen_size = get(0,'ScreenSize');
screen_size(3) = 650;
screen_size(4) = 700;
set(handles.figure1,'Units','Pixels','Position',screen_size, 'name', 'arpes_isoeanalysis');
%% 2 - Setting push-buttons to inactive
set(handles.pushbutton_SAVE, 'Enable', 'off');
set(handles.pushbutton_TRANSFER, 'Enable', 'off');
set(handles.pushbutton_INFO, 'Enable', 'off');
set(handles.pushbutton_RESET, 'Enable', 'off');
set(handles.edit_bzCol, 'Enable', 'off');
set(handles.edit_bzWidth, 'Enable', 'off');
set(handles.checkbox_bzOn, 'Enable', 'off');
%% 3 - Setting ui-panels to inactive until data is loaded
set(findall(handles.uipanel_FilterData, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_isoeExtract, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_isoeCorrections, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_isoeFigure, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_SAcalc, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_LineProfile, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_bzExtract, '-property', 'enable'), 'enable', 'off');
%% Save the handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = arpes_isoeanalysis_OutputFcn(hObject, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)

%% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes to reset GUI to initial state
function handles = arpes_isoeanalysis_ResetFcn(hObject, ~, handles)
% This is a function that resets the UI elements to their initial, default
% state.
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Setting push-buttons to inactive
set(handles.pushbutton_SAVE, 'Enable', 'off');
set(handles.pushbutton_TRANSFER, 'Enable', 'off');
set(handles.pushbutton_INFO, 'Enable', 'off');
set(handles.pushbutton_RESET, 'Enable', 'off');
set(handles.edit_bzCol, 'Enable', 'off');
set(handles.edit_bzWidth, 'Enable', 'off');
set(handles.checkbox_bzOn, 'Enable', 'off');
%% 2 - Setting ui-panels to inactive until data is loaded
set(findall(handles.uipanel_FilterData, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_isoeExtract, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_isoeCorrections, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_isoeFigure, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_SAcalc, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_LineProfile, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_bzExtract, '-property', 'enable'), 'enable', 'off');
%% 3 - Resetting the state of UI elements
handles = checkbox_bzOn_CreateFcn(handles.checkbox_bzOn, [], handles);
if isfield(handles, 'myBZ'); handles = rmfield(handles, 'myBZ'); end
%% Save the handles structure
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% MISCALLENOUS PUSH BUTTONS  %%%%%%%%%%%
% --- Executes on button press in pushbutton_ARPESGUI.
function pushbutton_ARPESGUI_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ARPESGUI (see GCBO)
% handles    structure with handles and user data (see GUIDATA)
%% Boot the ARPESGUI script

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
close(gcbf); run arpes_isoeanalysis;

% --- Executes on button press in pushbutton_RESIZEGUI.
function pushbutton_RESIZEGUI_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_RESIZEGUI (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Resetting the native size of the whole GUI figure
screen_size = get(0, 'ScreenSize');
screen_pos = get(gcf, 'Position');
screen_size(1) = screen_pos(1);
screen_size(2) = screen_pos(2);
screen_size(3) = 650;
screen_size(4) = 700;
set(handles.figure1,'Units','Pixels','Position',screen_size, 'name', 'arpes_isoeanalysis');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_TRANSFER.
function pushbutton_TRANSFER_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_TRANSFER (see GCBO)
% handles    structure with handles and user data (see GUIDATA)
%% Transfer requested data to the MATLAB workspace
if isfield(handles, 'myData'); assignin('base','arpes_data',handles.myData);end
if isfield(handles, 'myBZ'); assignin('base','arpes_bz',handles.myBZ); end

% --- Executes on button press in pushbutton_INFO.
function pushbutton_INFO_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_INFO (see GCBO)
% handles    structure with handles and user data (see GUIDATA)
%% Display the handles and handles.myData data structures
disp('HANDLES : '); disp(handles);
if isfield(handles, 'myData')
    for i = 1:length(handles.myData)
        fprintf("DATA (.myData{%i}) : \n", i);
        disp(handles.myData{i});
        fprintf("ISOE (.myData{%i}.isoe) : \n", i);
        disp(handles.myData{i}.isoe);
    end
end
if isfield(handles, 'myBZ')
    fprintf("BZ (.myBZ) : \n"); disp(handles.myBZ);
end

% --- Executes on button press in pushbutton_LOAD.
function pushbutton_LOAD_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_LOAD (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Loading in the FileNames and PathNames of the selected data
[FileNames, PathNames] = uigetfile({'*.mat'}, 'Pick a processed *.mat data file...', 'MultiSelect', 'on');
% - If Cancel is pressed, then return nothing
if isequal(PathNames,0) || isequal(FileNames,0); return; end
% - 1.1 - Load in the file selected
handles.myData = [];
handles.myData = load_isoe_data(FileNames);
%% 2 - Reseting the GUI to the initial state
handles = arpes_isoeanalysis_ResetFcn(hObject, [], handles);
%% 3 - Updating handle text and gui elements
% -- General buttons
set(handles.pushbutton_SAVE, 'Enable', 'on');
set(handles.pushbutton_TRANSFER, 'Enable', 'on');
set(handles.pushbutton_INFO, 'Enable', 'on');
set(handles.pushbutton_RESET, 'Enable', 'on');
set(handles.text_FileNames, 'string', FileNames);
% -- General GUI elements
set(findall(handles.uipanel_isoeExtract, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_isoeCorrections, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_bzExtract, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_isoeFigure, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_SAcalc, '-property', 'enable'), 'enable', 'off');
set(findall(handles.uipanel_LineProfile, '-property', 'enable'), 'enable', 'off');
%% 4 - Updating UI elements for previous isoe analysis
handles = checkbox_bzOn_CreateFcn(handles.checkbox_bzOn, [], handles);
if isfield(handles.myData{1}, 'isoe')
    if isfield(handles.myData{1}.isoe, 'XSlice')
        set(findall(handles.uipanel_isoeExtract, '-property', 'enable'), 'enable', 'on');
        set(findall(handles.uipanel_bzExtract, '-property', 'enable'), 'enable', 'on');
        handles = popupmenu_crystal_Callback(handles.popupmenu_crystal, [], handles);
        handles = edit_axLims_Callback(handles.edit_axLims, [], handles);
        handles = edit_cLims_Callback(handles.edit_cLims, [], handles);
    end
    if isfield(handles.myData{1}, 'bz')
        handles.myBZ = handles.myData{1}.bz;
        set(findall(handles.uipanel_isoeCorrections, '-property', 'enable'), 'enable', 'on');
        set(findall(handles.uipanel_isoeFigure, '-property', 'enable'), 'enable', 'on');
        set(findall(handles.uipanel_SAcalc, '-property', 'enable'), 'enable', 'on');
        set(findall(handles.uipanel_LineProfile, '-property', 'enable'), 'enable', 'on');
        if handles.final_fig_args{11}==1
            set(handles.edit_bzCol, 'Enable', 'on');
            set(handles.edit_bzWidth, 'Enable', 'on');
            set(handles.checkbox_bzOn, 'Enable', 'on');
        else
            set(handles.edit_bzCol, 'Enable', 'off');
            set(handles.edit_bzWidth, 'Enable', 'off');
            set(handles.checkbox_bzOn, 'Enable', 'on');
        end
    end    
end
%% 5 - Updating UI elements for IsoE video
handles = edit_yLimsVideo_Callback(handles.edit_yLimsVideo, [], handles);
handles = edit_sliceWin_Callback(handles.edit_sliceWin, [], handles);
%% Display the handles data
pushbutton_INFO_Callback(handles.pushbutton_INFO, [], handles);
%% Save the handles structure
handles.fNames = FileNames;
guidata(hObject, handles);

% --- Executes on button press in pushbutton_SAVE.
function pushbutton_SAVE_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_SAVE (see GCBO)
% handles    structure with handles and user data (see GUIDATA)
%% 1 - User defined FileName and Path for the processed data
filter = {'*.mat'};
[save_filename, save_filepath] = uiputfile(filter, 'Save isoe ARPES data', handles.myData{1}.isoe.matfile);
save_fullfile = char(string(save_filepath) + string(save_filename));
% - If Cancel is pressed, then return nothing
if isequal(save_filepath,0) || isequal(save_filename,0); return; end
%% 2 - Executing the saving of the processed data
wbar=waitbar(0.5,'Saving...'); 
% - 2.1 - Appending the Brilluoin Zone to each data-cell
if length(handles.myData) == 1
    dataStruc = [];
    dataStruc = handles.myData{1};
    if isfield(handles, 'myBZ'); dataStruc.bz = handles.myBZ; end
else
    dataStruc = [];
    dataStruc = handles.myData;
    if isfield(handles, 'myBZ')
        for i = 1:length(handles.myData); dataStruc{i}.bz = handles.myBZ; end
    end
end
save(char(save_fullfile), 'dataStruc', '-v7.3');
disp('-> saved arpes isoe analysis : '); 
display(dataStruc);
close(wbar);
%% 3 - Saving the final IsoE slice
fig_full = figure(); set(fig_full, 'Name', 'Iso-Slice', 'Position', [1,1,700,750]);
if isfield(handles, 'myBZ')
    view_final(handles.myData, handles.myBZ.overlay, handles.final_fig_args);
    title(save_filename(1:end), 'interpreter', 'none');
    print(fig_full, char(save_fullfile(1:end-4)+"_isoe.png"), '-dpng');
end

% --- Executes on button press in pushbutton_RESET.
function pushbutton_RESET_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_RESET (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Loading in the FileNames defined
% - 1.1 - Load in the file selected
handles.myData = [];
handles.myData = load_isoe_data(handles.fNames);
%% 2 - Reseting the GUI to the initial state
handles = arpes_isoeanalysis_ResetFcn(hObject, [], handles);
%% 3 - Updating handle text and gui elements
% -- General buttons
set(handles.pushbutton_SAVE, 'Enable', 'on');
set(handles.pushbutton_TRANSFER, 'Enable', 'on');
set(handles.pushbutton_INFO, 'Enable', 'on');
set(handles.pushbutton_RESET, 'Enable', 'on');
% -- General GUI elements
set(findall(handles.uipanel_isoeExtract, '-property', 'enable'), 'enable', 'on');
%% Display the handles data
pushbutton_INFO_Callback(handles.pushbutton_INFO, [], handles);
%% Save the handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ISOE DATA EXTRACTION  %%%%%%%%%%%%
% --- Executes on selection change in popupmenu_isoType.
function popupmenu_isoType_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_isoType (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
contents = cellstr(get(hObject,'String'));
handles.initfig_args{1} = string(contents{get(hObject,'Value')});
fprintf("--> isoType: " + handles.initfig_args{1} + " \n");
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
handles.initfig_args{1} = string(contents{1});
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_isoSlice_Callback(hObject, ~, handles)
% hObject    handle to edit_isoSlice (see GCBO)
% handles    structure with handles and user data (see GUIDATA)
%% Default parameters

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 2);
%% 2 - Extracting the input defined by user
% Extracting the min/mean/max values of the slices
for i = 1:length(handles.myData)
    if i ==1 && handles.initfig_args{1} == "IsoE"
        ebLims(1) = min(handles.myData{i}.eb(:));
        ebLims(2) = max(handles.myData{i}.eb(:));
    elseif i ==1 && handles.initfig_args{1} == "IsoK"
        kxLims(1) = min(handles.myData{i}.kx(:));
        kxLims(2) = max(handles.myData{i}.kx(:));
    elseif handles.initfig_args{1} == "IsoE"
        if ebLims(1) > min(handles.myData{i}.eb(:)); ebLims(1) = min(handles.myData{i}.eb(:)); end
        if ebLims(2) < max(handles.myData{i}.eb(:)); ebLims(2) = max(handles.myData{i}.eb(:)); end
    elseif handles.initfig_args{1} == "IsoK"
        if kxLims(1) > min(handles.myData{i}.kx(:)); kxLims(1) = min(handles.myData{i}.kx(:)); end
        if kxLims(2) < max(handles.myData{i}.kx(:)); kxLims(2) = max(handles.myData{i}.kx(:)); end
    end
end
%% 3 - Validity check
 % - If no entry is made, default to a small range around the mean
if isempty(data_entry) || length(data_entry) > 2 || size(data_entry, 1) > 1
    if handles.initfig_args{1} == "IsoE"; data_entry = [-0.1, 0.1]+mean(ebLims);
    elseif handles.initfig_args{1} == "IsoK"; data_entry = [-0.1, 0.1]+mean(kxLims); 
    end
 % - If a single entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1 && size(data_entry, 1) ==1
    if handles.initfig_args{1} == "IsoE"
        if data_entry < ebLims(1); data_entry = ebLims(1) + 0.1;
        elseif data_entry > ebLims(2); data_entry = ebLims(2) - 0.1;
        end
    elseif handles.initfig_args{1} == "IsoK"
        if data_entry < kxLims(1); data_entry = kxLims(1) + 0.1;
        elseif data_entry > kxLims(2); data_entry = kxLims(2) - 0.1;
        end
    end
    data_entry = [-0.1, 0.1]+data_entry; 
 % - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 2
    if handles.initfig_args{1} == "IsoE"
        % -- Forcing the max / min limits on the entries
        if data_entry(1) <  ebLims(1); data_entry(1) =  ebLims(1) + 0.1;
        elseif data_entry(1) >  ebLims(2); data_entry(1) =  ebLims(2) - 0.1;
        end
        if data_entry(2) <  ebLims(1); data_entry(2) =  ebLims(1) + 0.1;
        elseif data_entry(2) >  ebLims(2); data_entry(2) =  ebLims(2) - 0.1;
        end
        % -- For identical entries, make sure they are made different
        if data_entry(1) == data_entry(2); data_entry(1) = data_entry(1) - 0.2; end
    elseif handles.initfig_args{1} == "IsoK"
        % -- Forcing the max / min limits on the entries
        if data_entry(1) < kxLims(1); data_entry(1) = kxLims(1) + 0.1;
        elseif data_entry(1) > kxLims(2); data_entry(1) = kxLims(2) - 0.1;
        end
        if data_entry(2) < kxLims(1); data_entry(2) = kxLims(1) + 0.1;
        elseif data_entry(2) > kxLims(2); data_entry(2) = kxLims(2) - 0.1;
        end
        % -- For identical entries, make sure they are made different
        if data_entry(1) == data_entry(2); data_entry(1) = data_entry(1) - 0.1; end
    end
end
handles.initfig_args{2} = round(sort(data_entry), 2); 
set(hObject,'String', string(handles.initfig_args{2}(1) + ":" + handles.initfig_args{2}(2))); 
fprintf("--> isoSlice: " + string(handles.initfig_args{2}(1) + ":" + handles.initfig_args{2}(2)) + " \n");
%% 4 - Plotting the iso-slice
extract_slice(handles.myData, handles.initfig_args);
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
handles.initfig_args{2} = [-0.1, 0.1]; 
set(hObject,'String', "-0.1:0.1");
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox_Remap.
function checkbox_Remap_Callback(hObject, ~, handles)
% hObject    handle to checkbox_Remap (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the state of the checkbox
val = get(hObject,'Value');
handles.initfig_args{3} = val;
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
set(hObject,'Value',0);
handles.initfig_args{3} = get(hObject,'Value');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExtractIsoe.
function pushbutton_ExtractIsoe_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExtractIsoe (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Executing the IsoE slicing operation
% - Forcing an isoe slice
fig_args = handles.initfig_args;
fig_args{1} = "IsoE";
% - Extracting the isoe slice
[XSlice, YSlice, DSlice] = extract_slice(handles.myData, fig_args);
% - Assigning the slices to to Isoe data object
for i = 1:length(XSlice)
    handles.myData{i}.isoe.XSlice = XSlice{i};
    handles.myData{i}.isoe.YSlice = YSlice{i};
    handles.myData{i}.isoe.DSlice = DSlice{i};
    handles.myData{i}.isoe.colLims = [min(DSlice{i}(:)), max(DSlice{i}(:))];
    handles.myData{i}.isoe.xLims = [min(XSlice{i}(:)), max(XSlice{i}(:))];
    handles.myData{i}.isoe.yLims = [min(YSlice{i}(:)), max(YSlice{i}(:))];
end
%% 2 - Extracting the scan parameter axis
for i = 1:length(XSlice)
    if handles.myData{i}.isoe.Type == "Eb(kx,ky)"
        handles.myData{i}.isoe.scanAxis = handles.myData{i}.tltM;
    elseif handles.myData{i}.isoe.Type == "Eb(kx,kz)"
        handles.myData{i}.isoe.scanAxis = handles.myData{i}.hv;
    end
end
%% 3 - Ask the user if they want to keep the new filtered data
answer = questdlg('Would you like to store the isoe slice/s?', ...
	'Store isoe slices?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
%% 4 - Updating UI elements
set(findall(handles.uipanel_isoeExtract, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_bzExtract, '-property', 'enable'), 'enable', 'on');
handles = popupmenu_crystal_Callback(handles.popupmenu_crystal, [], handles);
handles = edit_cLims_Callback(handles.edit_cLims, [], handles);
%% Update the handles
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BRILLUOIN ZONE EXTRACT  %%%%%%%%%%%%
% --- Executes on selection change in popupmenu_crystal.
function handles = popupmenu_crystal_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_crystal (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
contents = cellstr(get(hObject,'String'));
data_entry = contents{get(hObject,'Value')};
handles.bz_args{1} = data_entry;
%% 2 - Changing the GUI elements
% For 'CUB', 'BCC' and 'FCC' crystal
if data_entry == "CUB-Oh" || data_entry == "BCC-Oh" || data_entry == "FCC-Oh"
    % - Forcing symmetry by deactivating degenerate UI elements
    set(handles.edit_a, 'Enable', 'on'); 
    set(handles.edit_b, 'Enable', 'off'); 
    set(handles.edit_c, 'Enable', 'off'); 
    set(handles.edit_alpha, 'Enable', 'off'); 
    set(handles.edit_beta, 'Enable', 'off'); 
    set(handles.edit_gamma, 'Enable', 'off'); 
% For 'HEX' crystal
elseif data_entry == "HEX-D6h"
    % - Forcing symmetry by deactivating degenerate UI elements
    set(handles.edit_a, 'Enable', 'on'); 
    set(handles.edit_b, 'Enable', 'off'); 
    set(handles.edit_c, 'Enable', 'on'); 
    set(handles.edit_alpha, 'Enable', 'off'); 
    set(handles.edit_beta, 'Enable', 'off'); 
    set(handles.edit_gamma, 'Enable', 'off');
% For 'RHL' crystal
elseif data_entry == "RHL-D3d"
    % - Forcing symmetry by deactivating degenerate UI elements
    set(handles.edit_a, 'Enable', 'on'); 
    set(handles.edit_b, 'Enable', 'off'); 
    set(handles.edit_c, 'Enable', 'off'); 
    set(handles.edit_alpha, 'Enable', 'on'); 
    set(handles.edit_beta, 'Enable', 'off'); 
    set(handles.edit_gamma, 'Enable', 'off'); 
% For 'TET' and 'BCT' crystal
elseif data_entry == "TET-D4h" || data_entry == "BCT-D4h"
    % - Forcing symmetry by deactivating degenerate UI elements
    set(handles.edit_a, 'Enable', 'on'); 
    set(handles.edit_b, 'Enable', 'off'); 
    set(handles.edit_c, 'Enable', 'on'); 
    set(handles.edit_alpha, 'Enable', 'off'); 
    set(handles.edit_beta, 'Enable', 'off'); 
    set(handles.edit_gamma, 'Enable', 'off'); 
% For 'ORC', 'ORCC', 'ORCI' and 'ORCF' crystal
elseif data_entry == "ORC-D2h" || data_entry == "ORCC-D2h" || data_entry == "ORCI-D2h" || data_entry == "ORCF-D2h"
    % - Forcing symmetry by deactivating degenerate UI elements
    set(handles.edit_a, 'Enable', 'on'); 
    set(handles.edit_b, 'Enable', 'on'); 
    set(handles.edit_c, 'Enable', 'on'); 
    set(handles.edit_alpha, 'Enable', 'off'); 
    set(handles.edit_beta, 'Enable', 'off'); 
    set(handles.edit_gamma, 'Enable', 'off'); 
% For 'MCL' and 'MCLC' crystal
elseif data_entry == "MCL-C2h" || data_entry == "MCLC-C2h"
    % - Forcing symmetry by deactivating degenerate UI elements
    set(handles.edit_a, 'Enable', 'on'); 
    set(handles.edit_b, 'Enable', 'on'); 
    set(handles.edit_c, 'Enable', 'on'); 
    set(handles.edit_alpha, 'Enable', 'off'); 
    set(handles.edit_beta, 'Enable', 'on');
    set(handles.edit_gamma, 'Enable', 'off'); 
% For 'TRI' crystal
elseif data_entry == "TRI-Ci" 
    % - Forcing symmetry by deactivating degenerate UI elements
    set(handles.edit_a, 'Enable', 'on'); 
    set(handles.edit_b, 'Enable', 'on'); 
    set(handles.edit_c, 'Enable', 'on'); 
    set(handles.edit_alpha, 'Enable', 'on'); 
    set(handles.edit_beta, 'Enable', 'on');
    set(handles.edit_gamma, 'Enable', 'on'); 
end
%% 3 - Run through all crystallographic inputs to update them
handles = edit_a_Callback(handles.edit_a, [], handles);
handles = edit_b_Callback(handles.edit_b, [], handles);
handles = edit_c_Callback(handles.edit_c, [], handles);
handles = edit_alpha_Callback(handles.edit_alpha, [], handles);
handles = edit_beta_Callback(handles.edit_beta, [], handles);
handles = edit_gamma_Callback(handles.edit_gamma, [], handles);
%% 4 - Printing the change that has occured
fprintf("--> Crystal: " + handles.bz_args{1} + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_crystal_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_crystal (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
contents = cellstr(get(hObject,'String'));
handles.bz_args{1} = string(contents{3});
set(hObject,'Value', 3);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_a_Callback(hObject, ~, handles)
% hObject    handle to edit_a (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(strrep(get(hObject,'String'),':',' ')), 4);
%% 2 - Validity check on the input
% - If none or multiple entries are made, default to the silicon lattice constant
if isempty(data_entry) || length(data_entry) > 1; data_entry = 5.431; end
%% 3 - Validity check on the symmetry arguments
% For 'CUB', 'BCC' and 'FCC' crystal
if handles.bz_args{1} == "CUB-Oh" || handles.bz_args{1} == "BCC-Oh" || handles.bz_args{1} == "FCC-Oh"
    % - Applying condition that a(nm) must be equal to b(nm) and c(nm)
    if data_entry ~= handles.bz_args{2}(2); handles.bz_args{2}(2) = data_entry; end
    if data_entry ~= handles.bz_args{2}(3); handles.bz_args{2}(3) = data_entry; end
% For 'HEX' crystal
elseif handles.bz_args{1} == "HEX-D6h"
    % - Applying condition that a(nm) must be equal to b(nm)
    if data_entry ~= handles.bz_args{2}(2); handles.bz_args{2}(2) = data_entry; end
% For 'RHL' crystal
elseif handles.bz_args{1} == "RHL-D3d"
    % - Applying condition that a(nm) must be equal to b(nm) and c(nm)
    if data_entry ~= handles.bz_args{2}(2); handles.bz_args{2}(2) = data_entry; end
    if data_entry ~= handles.bz_args{2}(3); handles.bz_args{2}(3) = data_entry; end
% For 'TET' and 'BCT' crystal
elseif handles.bz_args{1} == "TET-D4h" || handles.bz_args{1} == "BCT-D4h"
    % - Applying condition that a(nm) cannot equal c(nm), but must equal b(nm)
    if data_entry == handles.bz_args{2}(3); data_entry = data_entry-0.001; end
    if data_entry ~= handles.bz_args{2}(2); handles.bz_args{2}(2) = data_entry; end
% For 'ORC', 'ORCC', 'ORCI' and 'ORCF' crystal
elseif handles.bz_args{1} == "ORC-D2h" || handles.bz_args{1} == "ORCC-D2h" || handles.bz_args{1} == "ORCI-D2h" || handles.bz_args{1} == "ORCF-D2h"
    % - Applying condition that a(nm) cannot equal b(nm) or c(nm)
    if data_entry == handles.bz_args{2}(2); data_entry = data_entry-0.001; end
    if data_entry == handles.bz_args{2}(3); data_entry = data_entry-0.001; end
% For 'MCL' and 'MCLC' crystal
elseif handles.bz_args{1} == "MCL-C2h" || handles.bz_args{1} == "MCLC-C2h"
    % - Applying condition that a(nm) cannot equal c(nm)
    if data_entry == handles.bz_args{2}(3); data_entry = data_entry-0.001; end
% For 'TRI' crystal
elseif handles.bz_args{1} == "TRI-Ci"
    % - No conditions for the 'TRI' crystal for a(nm)
end
%% 3 - Printing the change that has occured
handles.bz_args{2}(1) = data_entry;
set(hObject,'String', string(handles.bz_args{2}(1))); 
set(handles.edit_b,'String', string(handles.bz_args{2}(2))); 
set(handles.edit_c, 'String', string(handles.bz_args{2}(3))); 
fprintf("\n--> a (nm): " + handles.bz_args{2}(1) + " \n");
fprintf("---> b (nm): " + handles.bz_args{2}(2) + " \n");
fprintf("---> c (nm): " + handles.bz_args{2}(3) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_a_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.bz_args{2}(1) = 5.431; 
set(hObject,'String', string(handles.bz_args{2}(1)));
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_b_Callback(hObject, ~, handles)
% hObject    handle to edit_b (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(strrep(get(hObject,'String'),':',' ')), 4);
%% 2 - Validity check on the input
% - If none or multiple entries are made, default to the silicon lattice constant
if isempty(data_entry) || length(data_entry) > 1; data_entry = 5.431; end
%% 3 - Validity check on the symmetry arguments
% For 'CUB', 'BCC' and 'FCC' crystal
if handles.bz_args{1} == "CUB-Oh" || handles.bz_args{1} == "BCC-Oh" || handles.bz_args{1} == "FCC-Oh"
    % - Applying condition that a(nm) must be equal to b(nm) and c(nm)
    if data_entry ~= handles.bz_args{2}(1); handles.bz_args{2}(1) = data_entry; end
    if data_entry ~= handles.bz_args{2}(3); handles.bz_args{2}(3) = data_entry; end
% For 'HEX' crystal
elseif handles.bz_args{1} == "HEX-D6h"
    % - Applying condition that a(nm) must be equal to b(nm)
    if data_entry ~= handles.bz_args{2}(1); handles.bz_args{2}(1) = data_entry; end
% For 'RHL' crystal
elseif handles.bz_args{1} == "RHL-D3d"
    % - Applying condition that a(nm) must be equal to b(nm) and c(nm)
    if data_entry ~= handles.bz_args{2}(1); handles.bz_args{2}(1) = data_entry; end
    if data_entry ~= handles.bz_args{2}(3); handles.bz_args{2}(3) = data_entry; end
% For 'TET' and 'BCT' crystal
elseif handles.bz_args{1} == "TET-D4h" || handles.bz_args{1} == "BCT-D4h"
    % - Applying condition that a(nm) cannot equal c(nm), but must equal b(nm)
    if data_entry == handles.bz_args{2}(3); data_entry = data_entry-0.001; end
    if data_entry ~= handles.bz_args{2}(1); handles.bz_args{2}(1) = data_entry; end
% For 'ORC', 'ORCC', 'ORCI' and 'ORCF' crystal
elseif handles.bz_args{1} == "ORC-D2h" || handles.bz_args{1} == "ORCC-D2h" || handles.bz_args{1} == "ORCI-D2h" || handles.bz_args{1} == "ORCF-D2h"
    % - Applying condition that a(nm) cannot equal b(nm) or c(nm)
    if data_entry == handles.bz_args{2}(1); data_entry = data_entry-0.001; end
    if data_entry == handles.bz_args{2}(3); data_entry = data_entry-0.001; end
% For 'MCL' and 'MCLC' crystal
elseif handles.bz_args{1} == "MCL-C2h" || handles.bz_args{1} == "MCLC-C2h"
    % - No conditions for the 'MCL' or 'MCLC' crystal for b(nm)
% For 'TRI' crystal
elseif handles.bz_args{1} == "TRI-Ci"
     % - No conditions for the 'TRI' crystal for a(nm)
end
%% 3 - Printing the change that has occured
handles.bz_args{2}(2) = data_entry;
set(handles.edit_a,'String', string(handles.bz_args{2}(1))); 
set(hObject,'String', string(handles.bz_args{2}(2))); 
set(handles.edit_c, 'String', string(handles.bz_args{2}(3))); 
fprintf("\n---> a (nm): " + handles.bz_args{2}(1) + " \n");
fprintf("--> b (nm): " + handles.bz_args{2}(2) + " \n");
fprintf("---> c (nm): " + handles.bz_args{2}(3) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_b_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.bz_args{2}(2) = 5.431; 
set(hObject,'String', string(handles.bz_args{2}(2)), 'enable', 'off');
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_c_Callback(hObject, ~, handles)
% hObject    handle to edit_c (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(strrep(get(hObject,'String'),':',' ')), 4);
%% 2 - Validity check on the input
% - If none or multiple entries are made, default to the silicon lattice constant
if isempty(data_entry) || length(data_entry) > 1; data_entry = 5.431; end
%% 3 - Validity check on the symmetry arguments
% For 'CUB', 'BCC' and 'FCC' crystal
if handles.bz_args{1} == "CUB-Oh" || handles.bz_args{1} == "BCC-Oh" || handles.bz_args{1} == "FCC-Oh"
    % - Applying condition that a(nm) must be equal to b(nm) and c(nm)
    if data_entry ~= handles.bz_args{2}(1); handles.bz_args{2}(1) = data_entry; end
    if data_entry ~= handles.bz_args{2}(2); handles.bz_args{2}(2) = data_entry; end
% For 'HEX' crystal
elseif handles.bz_args{1} == "HEX-D6h"
    % - No conditions for the 'HEX' crystal for c(nm)
% For 'RHL' crystal
elseif handles.bz_args{1} == "RHL-D3d"
    % - Applying condition that a(nm) must be equal to b(nm) and c(nm)
    if data_entry ~= handles.bz_args{2}(1); handles.bz_args{2}(1) = data_entry; end
    if data_entry ~= handles.bz_args{2}(2); handles.bz_args{2}(2) = data_entry; end
% For 'TET' and 'BCT' crystal
elseif handles.bz_args{1} == "TET-D4h" || handles.bz_args{1} == "BCT-D4h"
    % - Applying condition that a(nm) cannot equal c(nm)
    if data_entry == handles.bz_args{2}(1); data_entry = data_entry-0.001; end
% For 'ORC', 'ORCC', 'ORCI' and 'ORCF' crystal
elseif handles.bz_args{1} == "ORC-D2h" || handles.bz_args{1} == "ORCC-D2h" || handles.bz_args{1} == "ORCI-D2h" || handles.bz_args{1} == "ORCF-D2h"
    % - Applying condition that a(nm) cannot equal c(nm)
    if data_entry == handles.bz_args{2}(1); data_entry = data_entry-0.001; end
% For 'MCL' and 'MCLC' crystal
elseif handles.bz_args{1} == "MCL-C2h" || handles.bz_args{1} == "MCLC-C2h"
    % - Applying condition that a(nm) cannot equal c(nm)
    if data_entry == handles.bz_args{2}(1); data_entry = data_entry-0.001; end
% For 'TRI' crystal
elseif handles.bz_args{1} == "TRI-Ci"
    % - No conditions for the 'TRI' crystal for c(nm)
end
%% 3 - Printing the change that has occured
handles.bz_args{2}(3) = data_entry;
set(handles.edit_a,'String', string(handles.bz_args{2}(1))); 
set(handles.edit_b,'String', string(handles.bz_args{2}(2))); 
set(hObject,'String', string(handles.bz_args{2}(3))); 
fprintf("\n---> a (nm): " + handles.bz_args{2}(1) + " \n");
fprintf("---> b (nm): " + handles.bz_args{2}(2) + " \n");
fprintf("--> c (nm): " + handles.bz_args{2}(3) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_c_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.bz_args{2}(3) = 5.431; 
set(hObject,'String', string(handles.bz_args{2}(3)), 'enable', 'off');
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_alpha_Callback(hObject, ~, handles)
% hObject    handle to edit_alpha (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(strrep(get(hObject,'String'),':',' ')), 2);
%% 2 - Validity check on the input
% - If none or multiple entries are made, default to 90 degrees
if isempty(data_entry) || length(data_entry) > 1; data_entry = 90; end
%% 3 - Validity check on the symmetry arguments
% For 'CUB', 'BCC' and 'FCC' crystal
if handles.bz_args{1} == "CUB-Oh" || handles.bz_args{1} == "BCC-Oh" || handles.bz_args{1} == "FCC-Oh"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.bz_args{3}(2); handles.bz_args{3}(2) = data_entry; end
    if data_entry ~= handles.bz_args{3}(3); handles.bz_args{3}(3) = data_entry; end
% For 'HEX' crystal
elseif handles.bz_args{1} == "HEX-D6h"
    % - Applying condition that alpha must be 90degrees and equal to beta
    data_entry = 90;
    if data_entry ~= handles.bz_args{3}(2); handles.bz_args{3}(2) = data_entry; end
% For 'RHL' crystal
elseif handles.bz_args{1} == "RHL-D3d"
    % - Applying condition that alpha must not be 90degrees, but equal to beta and gamma
    if data_entry == 90; data_entry = data_entry - 1; end
    if data_entry ~= handles.bz_args{3}(2); handles.bz_args{3}(2) = data_entry; end
    if data_entry ~= handles.bz_args{3}(3); handles.bz_args{3}(3) = data_entry; end
% For 'TET' and 'BCT' crystal
elseif handles.bz_args{1} == "TET-D4h" || handles.bz_args{1} == "BCT-D4h"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.bz_args{3}(2); handles.bz_args{3}(2) = data_entry; end
    if data_entry ~= handles.bz_args{3}(3); handles.bz_args{3}(3) = data_entry; end
% For 'ORC', 'ORCC', 'ORCI' and 'ORCF' crystal
elseif handles.bz_args{1} == "ORC-D2h" || handles.bz_args{1} == "ORCC-D2h" || handles.bz_args{1} == "ORCI-D2h" || handles.bz_args{1} == "ORCF-D2h"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.bz_args{3}(2); handles.bz_args{3}(2) = data_entry; end
    if data_entry ~= handles.bz_args{3}(3); handles.bz_args{3}(3) = data_entry; end
% For 'MCL' and 'MCLC' crystal
elseif handles.bz_args{1} == "MCL-C2h" || handles.bz_args{1} == "MCLC-C2h"
    % - Applying condition that alpha must be 90degrees and equal to gamma
    data_entry = 90;
    if data_entry ~= handles.bz_args{3}(3); handles.bz_args{3}(3) = data_entry; end
% For 'TRI' crystal
elseif handles.bz_args{1} == "TRI-Ci"
    % - No conditions for the 'TRI' crystal for alpha
end
%% 3 - Printing the change that has occured
handles.bz_args{3}(1) = data_entry;
set(hObject,'String', string(handles.bz_args{3}(1))); 
set(handles.edit_beta,'String', string(handles.bz_args{3}(2))); 
set(handles.edit_gamma, 'String', string(handles.bz_args{3}(3))); 
fprintf("\n--> alpha (deg): " + handles.bz_args{3}(1) + " \n");
fprintf("---> beta (deg): " + handles.bz_args{3}(2) + " \n");
fprintf("---> gamma (deg): " + handles.bz_args{3}(3) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_alpha_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_alpha (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.bz_args{3}(1) = 90; 
set(hObject,'String', string(handles.bz_args{3}(1)), 'enable', 'off');
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_beta_Callback(hObject, ~, handles)
% hObject    handle to edit_beta (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(strrep(get(hObject,'String'),':',' ')), 2);
%% 2 - Validity check on the input
% - If none or multiple entries are made, default to 90 degrees
if isempty(data_entry) || length(data_entry) > 1; data_entry = 90; end
%% 3 - Validity check on the symmetry arguments
% For 'CUB', 'BCC' and 'FCC' crystal
if handles.bz_args{1} == "CUB-Oh" || handles.bz_args{1} == "BCC-Oh" || handles.bz_args{1} == "FCC-Oh"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.bz_args{3}(1); handles.bz_args{3}(1) = data_entry; end
    if data_entry ~= handles.bz_args{3}(3); handles.bz_args{3}(3) = data_entry; end
% For 'HEX' crystal
elseif handles.bz_args{1} == "HEX-D6h"
    % - Applying condition that alpha must be 90degrees and equal to beta
    data_entry = 90;
    if data_entry ~= handles.bz_args{3}(1); handles.bz_args{3}(1) = data_entry; end
% For 'RHL' crystal
elseif handles.bz_args{1} == "RHL-D3d"
    % - Applying condition that alpha must not be 90degrees, but equal to beta and gamma
    if data_entry == 90; data_entry = data_entry - 1; end
    if data_entry ~= handles.bz_args{3}(1); handles.bz_args{3}(1) = data_entry; end
    if data_entry ~= handles.bz_args{3}(3); handles.bz_args{3}(3) = data_entry; end
% For 'TET' and 'BCT' crystal
elseif handles.bz_args{1} == "TET-D4h" || handles.bz_args{1} == "BCT-D4h"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.bz_args{3}(1); handles.bz_args{3}(1) = data_entry; end
    if data_entry ~= handles.bz_args{3}(3); handles.bz_args{3}(3) = data_entry; end
% For 'ORC', 'ORCC', 'ORCI' and 'ORCF' crystal
elseif handles.bz_args{1} == "ORC-D2h" || handles.bz_args{1} == "ORCC-D2h" || handles.bz_args{1} == "ORCI-D2h" || handles.bz_args{1} == "ORCF-D2h"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.bz_args{3}(1); handles.bz_args{3}(1) = data_entry; end
    if data_entry ~= handles.bz_args{3}(3); handles.bz_args{3}(3) = data_entry; end
% For 'MCL' and 'MCLC' crystal
elseif handles.bz_args{1} == "MCL-C2h" || handles.bz_args{1} == "MCLC-C2h"
    % - Applying condition that beta must not be 90 degrees
    if data_entry == 90; data_entry = data_entry - 1; end
% For 'TRI' crystal
elseif handles.bz_args{1} == "TRI-Ci"
    % - No conditions for the 'TRI' crystal for beta
end
%% 3 - Printing the change that has occured
handles.bz_args{3}(2) = data_entry;
set(handles.edit_alpha,'String', string(handles.bz_args{3}(1))); 
set(hObject,'String', string(handles.bz_args{3}(2)));
set(handles.edit_gamma, 'String', string(handles.bz_args{3}(3))); 
fprintf("\n---> alpha (deg): " + handles.bz_args{3}(1) + " \n");
fprintf("--> beta (deg): " + handles.bz_args{3}(2) + " \n");
fprintf("---> gamma (deg): " + handles.bz_args{3}(3) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_beta_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_beta (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.bz_args{3}(2) = 90; 
set(hObject,'String', string(handles.bz_args{3}(2)), 'enable', 'off');
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_gamma_Callback(hObject, ~, handles)
% hObject    handle to edit_gamma (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(strrep(get(hObject,'String'),':',' ')), 2);
%% 2 - Validity check on the input
% - If none or multiple entries are made, default to 90 degrees
if isempty(data_entry) || length(data_entry) > 1; data_entry = 90; end
%% 3 - Validity check on the symmetry arguments
% For 'CUB', 'BCC' and 'FCC' crystal
if handles.bz_args{1} == "CUB-Oh" || handles.bz_args{1} == "BCC-Oh" || handles.bz_args{1} == "FCC-Oh"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.bz_args{3}(1); handles.bz_args{3}(1) = data_entry; end
    if data_entry ~= handles.bz_args{3}(2); handles.bz_args{3}(2) = data_entry; end
% For 'HEX' crystal
elseif handles.bz_args{1} == "HEX-D6h"
    % - Applying condition that gamma must be equal to 120 degrees
    data_entry = 120;
% For 'RHL' crystal
elseif handles.bz_args{1} == "RHL-D3d"
    % - Applying condition that alpha must not be 90degrees, but equal to beta and gamma
    if data_entry == 90; data_entry = data_entry - 1; end
    if data_entry ~= handles.bz_args{3}(1); handles.bz_args{3}(1) = data_entry; end
    if data_entry ~= handles.bz_args{3}(2); handles.bz_args{3}(2) = data_entry; end
% For 'TET' and 'BCT' crystal
elseif handles.bz_args{1} == "TET-D4h" || handles.bz_args{1} == "BCT-D4h"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.bz_args{3}(1); handles.bz_args{3}(1) = data_entry; end
    if data_entry ~= handles.bz_args{3}(2); handles.bz_args{3}(2) = data_entry; end
% For 'ORC', 'ORCC', 'ORCI' and 'ORCF' crystal
elseif handles.bz_args{1} == "ORC-D2h" || handles.bz_args{1} == "ORCC-D2h" || handles.bz_args{1} == "ORCI-D2h" || handles.bz_args{1} == "ORCF-D2h"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.bz_args{3}(1); handles.bz_args{3}(1) = data_entry; end
    if data_entry ~= handles.bz_args{3}(2); handles.bz_args{3}(2) = data_entry; end
% For 'MCL' and 'MCLC' crystal
elseif handles.bz_args{1} == "MCL-C2h" || handles.bz_args{1} == "MCLC-C2h"
    % - Applying condition that alpha must be equal to gamma and 90 degrees
    data_entry = 90;
    if data_entry ~= handles.bz_args{3}(1); handles.bz_args{3}(1) = data_entry; end
% For 'TRI' crystal
elseif handles.bz_args{1} == "TRI-Ci"
    % - No conditions for the 'TRI' crystal for beta
end
%% 3 - Printing the change that has occured
handles.bz_args{3}(3) = data_entry;
set(handles.edit_alpha,'String', string(handles.bz_args{3}(1))); 
set(handles.edit_beta, 'String', string(handles.bz_args{3}(2))); 
set(hObject,'String', string(handles.bz_args{3}(3)));
fprintf("\n---> alpha (deg): " + handles.bz_args{3}(1) + " \n");
fprintf("---> beta (deg): " + handles.bz_args{3}(2) + " \n");
fprintf("--> gamma (deg): " + handles.bz_args{3}(3) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_gamma_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_gamma (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.bz_args{3}(3) = 90;
set(hObject,'String', string(handles.bz_args{3}(3)), 'enable', 'off');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on selection change in popupmenu_crystalplane.
function popupmenu_crystalplane_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_crystalplane (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
contents = cellstr(get(hObject,'String'));
data_entry = contents{get(hObject,'Value')};
handles.bz_args{4} = data_entry;
fprintf("--> Crystal plane: " + handles.bz_args{4} + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_crystalplane_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_crystalplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
contents = cellstr(get(hObject,'String'));
handles.bz_args{4} = string(contents{1});
set(hObject,'Value', 1);
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_Extract2DBZ.
function pushbutton_Extract2DBZ_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_Extract2DBZ (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the 3D Crystal and Brilluoin Zone
if isfield(handles, 'myBZ'); handles = rmfield(handles, 'myBZ'); end
handles.myBZ.bz_args = handles.bz_args;
[handles.myBZ.realStr, handles.myBZ.reciStr] = extract_lattice(handles.bz_args);
%% 2 - Extracting the 2D Brilluoin Zone overlay
handles.myBZ.overlay = extract_plane(handles.myBZ.reciStr, handles.bz_args{4}, 1);
%% 3 - Updating the next UI panels to active
set(findall(handles.uipanel_isoeCorrections, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_isoeFigure, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_SAcalc, '-property', 'enable'), 'enable', 'on');
set(findall(handles.uipanel_LineProfile, '-property', 'enable'), 'enable', 'on');
%% 4 - Updating UI elements
if handles.final_fig_args{11}==1
    set(handles.edit_bzCol, 'Enable', 'on');
    set(handles.edit_bzWidth, 'Enable', 'on');
    set(handles.checkbox_bzOn, 'Enable', 'on');
else
    set(handles.edit_bzCol, 'Enable', 'off');
    set(handles.edit_bzWidth, 'Enable', 'off');
    set(handles.checkbox_bzOn, 'Enable', 'on');
end
%% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ISOE CORRECTIONS  %%%%%%%%%%%%
% --- Executes when changing the text
function edit_fileNum_Callback(hObject, ~, handles)
% hObject    handle to edit_fileNum (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = sort(floor(str2num(strrep(get(hObject,'String'),',',' '))));
%% 2 - Validity check of the input
% - If none or multiple entries are made, default to 90 degrees
if isempty(data_entry) || size(data_entry,1) > 1
    data_entry = 1;
else
    % - Checking that the max/min values for the scans are not exceeded
    data_entry(data_entry<1) = [];
    data_entry(data_entry>length(handles.myData)) = [];
end
%% 3 - Assigning output and printing change
handles.isocorr.file = data_entry;
fprintf("--> File number/s to correct: " + mat2str(handles.isocorr.file) + " \n");
set(hObject,'String', mat2str(handles.isocorr.file)); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_fileNum_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_fileNum (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.isocorr.file = 1;
set(hObject,'String', string(handles.isocorr.file));
%% Update handles structure
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FILTER DATA  %%%%%%%%%%%
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
    set(handles.staticstext_FilterParam, 'string', 'hwX,hwY:');
    handles.isocorr.filter_args{2} = [0.5, 0.5];
% For 'GaussFlt2' smoothing
elseif data_entry == "GaussFlt2"
    set(handles.staticstext_FilterParam, 'string', 'hwX,hwY:');
    handles.isocorr.filter_args{2} = [1.5, 1.5];
% For 'LaplaceFlt2' smoothing
elseif data_entry == "LaplaceFlt2"
    set(handles.staticstext_FilterParam, 'string', 'y2xRatio:');
    handles.isocorr.filter_args{2} = 1;
% For 'CurvatureFlt2' smoothing
elseif data_entry == "CurvatureFlt2"
    set(handles.staticstext_FilterParam, 'string', 'CX,CY:');
    handles.isocorr.filter_args{2} = [1,1];
end
handles.isocorr.filter_args{1} = string(contents{get(hObject,'Value')});
%% 3 - Printing the change that has occured
fprintf("--> Filter Type: " + handles.isocorr.filter_args{1} + " \n");
if handles.isocorr.filter_args{1} == "LaplaceFlt2"
    set(handles.edit_filterParam,'String', string(handles.isocorr.filter_args{2})); 
    fprintf("--> "+ get(handles.staticstext_FilterParam, 'string')+" "+string(handles.isocorr.filter_args{2}) + " \n");
else
    set(handles.edit_filterParam,'String', string(handles.isocorr.filter_args{2}(1) + "," + handles.isocorr.filter_args{2}(2))); 
    fprintf("--> "+ get(handles.staticstext_FilterParam, 'string')+" "+string(handles.isocorr.filter_args{2}(1) + "," + handles.isocorr.filter_args{2}(2)) + " \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_filterType_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_filterType (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
contents = cellstr(get(hObject,'String'));
handles.isocorr.filter_args{1} = string(contents{1});
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
if handles.isocorr.filter_args{1} == "Gaco2"
     % - If no entry is made, default to a given value
    if isempty(data_entry) || length(data_entry) > 2
        data_entry = [0.5, 0.5];
    % - If a single entry is made, make a row vector that is identical
    elseif length(data_entry) == 1
        data_entry = [data_entry, data_entry];
    end
% For 'GaussFlt2' smoothing
elseif handles.isocorr.filter_args{1} == "GaussFlt2"
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
elseif handles.isocorr.filter_args{1} == "LaplaceFlt2"
     % - If no entry is made, default to a given value
    if isempty(data_entry) || length(data_entry) > 1
        data_entry = 1;
    end
% For 'CurvatureFlt2' smoothing
elseif handles.isocorr.filter_args{1} == "CurvatureFlt2"
    % - If no entry is made, default to a given value
    if isempty(data_entry) || length(data_entry) > 2
        data_entry = [1, 1];
    % - If a single entry is made, make a row vector that is identical
    elseif length(data_entry) == 1
        data_entry = [data_entry, data_entry];
    end
end
%% 3 - Validity check on the mangitude of the data
if handles.isocorr.filter_args{1} ~= "LaplaceFlt2"; data_entry = abs(data_entry); end
%% 4 - Assigning output and printing change
handles.isocorr.filter_args{2} = data_entry;
if handles.isocorr.filter_args{1} == "LaplaceFlt2"
    set(hObject,'String', string(handles.isocorr.filter_args{2})); 
    fprintf("--> "+ get(handles.staticstext_FilterParam, 'string')+" "+string(handles.isocorr.filter_args{2}) + " \n");
else
    set(hObject,'String', string(handles.isocorr.filter_args{2}(1) + "," + handles.isocorr.filter_args{2}(2))); 
    fprintf("--> "+ get(handles.staticstext_FilterParam, 'string')+" "+string(handles.isocorr.filter_args{2}(1) + "," + handles.isocorr.filter_args{2}(2)) + " \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_filterParam_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_filterParam (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.isocorr.filter_args{2} = [0.5, 0.5]; 
set(hObject,'String', string(handles.isocorr.filter_args{2}(1) + "," + handles.isocorr.filter_args{2}(2))); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExecuteFilter.
function pushbutton_ExecuteFilter_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExecuteFilter (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Applying the filtering operation
handles.myData = filter_data(handles.myData, handles.isocorr);
%% 2 - View the figure update
fig = figure(); set(fig, 'Name', 'Iso-Slice', 'Position', [1,1,700,750]);
view_final(handles.myData, handles.myBZ.overlay, handles.final_fig_args);
%% 3 - Ask the user if they want to keep the new filtered data
answer = questdlg('Would you like to store the filtered data?', ...
	'Filter?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
% - Else save the new data
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BACKGROUND SUBTRACTION %%%%%%%%%%%
% --- Executes when changing the text
function edit_isoCut_Callback(hObject, ~, handles)
% hObject    handle to edit_isoCut (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 2);
%% 2 - Extracting the max/min limits for the cut
for i = 1:length(handles.myData)
    kxLims(i,1) = min(handles.myData{i}.isoe.XSlice(:));
    kxLims(i,2) = max(handles.myData{i}.isoe.XSlice(:));
end
cutLims = [min(kxLims(:,1)), min(kxLims(:,2))];
%% 3 - Validity check
 % - If no entry is made, default to a small range around the mean
if isempty(data_entry) || length(data_entry) > 2 || size(data_entry, 1) > 1
    data_entry = [-0.1, 0.1]+mean(cutLims); 
 % - If a single entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1 && size(data_entry, 1) ==1
    if data_entry < cutLims(1); data_entry = cutLims(1) + 0.1;
    elseif data_entry > cutLims(2); data_entry = cutLims(2) - 0.1;
    end
    data_entry = [-0.1, 0.1]+data_entry; 
 % - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 2
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < cutLims(1); data_entry(1) = cutLims(1) + 0.1;
    elseif data_entry(1) > cutLims(2); data_entry(1) = cutLims(2) - 0.1;
    end
    if data_entry(2) < cutLims(1); data_entry(2) = cutLims(1) + 0.1;
    elseif data_entry(2) > cutLims(2); data_entry(2) = cutLims(2) - 0.1;
    end
    % -- For identical entries, make sure they are made different
    if data_entry(1) == data_entry(2); data_entry(1) = data_entry(1) - 0.1; end
end
handles.isocorr.bsub_args{1}  = round(sort(data_entry), 2); 
set(hObject,'String', string(handles.isocorr.bsub_args{1}(1) + ":" + handles.isocorr.bsub_args{1}(2))); 
fprintf("--> Back. Sub. - isoCut: " + string(handles.isocorr.bsub_args{1}(1) + ":" + handles.isocorr.bsub_args{1}(2)) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_isoCut_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_isoCut (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.isocorr.bsub_args{1} = [-0.65,-0.35]; 
set(hObject,'String', "-0.65:-0.35");
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExecuteBackSub.
function pushbutton_ExecuteBackSub_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExecuteBackSub (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Applying the background subtraction operation
handles.myData = background_subtraction(handles.myData, handles.isocorr);
%% 2 - View the figure update
fig = figure(); set(fig, 'Name', 'Iso-Slice', 'Position', [1,1,700,750]);
if isfield(handles, 'myBZ'); view_final(handles.myData, handles.myBZ.overlay, handles.final_fig_args);    
else; view_final(handles.myData, [], handles.final_fig_args);
end
% -- Plot a patch of where the background subtraction is taken
x = [handles.isocorr.bsub_args{1}(1), handles.isocorr.bsub_args{1}(1),...
    handles.isocorr.bsub_args{1}(2), handles.isocorr.bsub_args{1}(2),...
    handles.isocorr.bsub_args{1}(1)];
y = [-1e5, 1e5, 1e5, -1e5, -1e5];
patch(x, y, [0.2, 0.8, 0.2], 'facealpha', 0.5);
%% 4 - Ask the user if they want to keep the new filtered data
answer = questdlg('Would you like to store the background subtracted data?', ...
	'Background subtraction?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
% - Else save the new data
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ORIGIN CORRECTIONS  %%%%%%%%%%%
% --- Executes when changing the text
function edit_originX0_Callback(hObject, ~, handles)
% hObject    handle to edit_originX0 (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),',',' '))), 3);
%% 2 - Validity check on input
% - If no entry is made, default
if isempty(data_entry)
    data_entry = 0;
elseif length(data_entry) > 1
    data_entry = data_entry(1);
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1
    data_entry(1) = round(data_entry, 2);
end
%% 3 - Assigning output and printing change
handles.isocorr.origin_args{1}  = round(data_entry, 3);
set(hObject,'String', string(handles.isocorr.origin_args{1})); 
fprintf("--> Origin - x0: " + string(handles.isocorr.origin_args{1} + "\n"));
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_originX0_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_originX0 (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.isocorr.origin_args{1} = 0; 
set(hObject,'String', string(handles.isocorr.origin_args{1})); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_originY0_Callback(hObject, ~, handles)
% hObject    handle to edit_originY0 (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),',',' '))), 3);
%% 2 - Validity check on input
% - If no entry is made, default
if isempty(data_entry)
    data_entry = 0;
elseif length(data_entry) > 1
    data_entry = data_entry(1);
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1
    data_entry(1) = round(data_entry, 2);
end
%% 3 - Assigning output and printing change
handles.isocorr.origin_args{2}  = round(data_entry, 3);
set(hObject,'String', string(handles.isocorr.origin_args{2})); 
fprintf("--> Origin - y0: " + string(handles.isocorr.origin_args{2} + "\n"));
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_originY0_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_originY0 (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.isocorr.origin_args{2} = 0; 
set(hObject,'String', string(handles.isocorr.origin_args{2})); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExecuteOrigin.
function pushbutton_ExecuteOrigin_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExecuteOrigin (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Applying the origin shifting operation
handles.myData = origin_correction(handles.myData, handles.isocorr);
%% 2 - View the figure update
fig = figure(); set(fig, 'Name', 'Iso-Slice', 'Position', [1,1,700,750]);
if isfield(handles, 'myBZ'); view_final(handles.myData, handles.myBZ.overlay, handles.final_fig_args);    
else; view_final(handles.myData, [], handles.final_fig_args);
end
%% 3 - Ask the user if they want to keep the new filtered data
answer = questdlg('Would you like to store the origin-shifted data?', ...
	'Origin Correction?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
% - Else save the new data
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SHEAR CORRECTION  %%%%%%%%%
% --- Executes when changing the text
function edit_sxSlope_Callback(hObject, ~, handles)
% hObject    handle to edit_sxSlope (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),',',' '))), 3);
%% 2 - Validity check on input
% - If no entry is made, default
if isempty(data_entry)
    data_entry = 0;
elseif length(data_entry) > 1
    data_entry = data_entry(1);
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1
    data_entry(1) = round(data_entry, 2);
end
%% 3 - Assigning output and printing change
handles.isocorr.shear_args{1}  = round(data_entry, 3);
set(hObject,'String', string(handles.isocorr.shear_args{1})); 
fprintf("--> X-Shear - slope: " + string(handles.isocorr.shear_args{1} + "\n"));
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_sxSlope_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_sxSlope (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.isocorr.shear_args{1} = 0; 
set(hObject,'String', string(handles.isocorr.shear_args{1})); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_sxIntersept_Callback(hObject, ~, handles)
% hObject    handle to edit_sxIntersept (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),',',' '))), 3);
%% 2 - Validity check on input
% - If no entry is made, default
if isempty(data_entry)
    data_entry = 0;
elseif length(data_entry) > 1
    data_entry = data_entry(1);
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1
    data_entry(1) = round(data_entry, 2);
end
%% 3 - Assigning output and printing change
handles.isocorr.shear_args{2}  = round(data_entry, 3);
set(hObject,'String', string(handles.isocorr.shear_args{2})); 
fprintf("--> X-Shear - intersept: " + string(handles.isocorr.shear_args{2} + "\n"));
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_sxIntersept_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_sxIntersept (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.isocorr.shear_args{2} = 0; 
set(hObject,'String', string(handles.isocorr.shear_args{2})); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_sySlope_Callback(hObject, ~, handles)
% hObject    handle to edit_sySlope (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),',',' '))), 3);
%% 2 - Validity check on input
% - If no entry is made, default
if isempty(data_entry)
    data_entry = 0;
elseif length(data_entry) > 1
    data_entry = data_entry(1);
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1
    data_entry(1) = round(data_entry, 2);
end
%% 3 - Assigning output and printing change
handles.isocorr.shear_args{3}  = round(data_entry, 3);
set(hObject,'String', string(handles.isocorr.shear_args{3})); 
fprintf("--> Y-Shear - slope: " + string(handles.isocorr.shear_args{3} + "\n"));
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_sySlope_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_sySlope (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.isocorr.shear_args{3} = 0; 
set(hObject,'String', string(handles.isocorr.shear_args{3})); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_syIntersept_Callback(hObject, ~, handles)
% hObject    handle to edit_syIntersept (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),',',' '))), 3);
%% 2 - Validity check on input
% - If no entry is made, default
if isempty(data_entry)
    data_entry = 0;
elseif length(data_entry) > 1
    data_entry = data_entry(1);
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1
    data_entry(1) = round(data_entry, 2);
end
%% 3 - Assigning output and printing change
handles.isocorr.shear_args{4}  = round(data_entry, 3);
set(hObject,'String', string(handles.isocorr.shear_args{4})); 
fprintf("--> Y-Shear - intersept: " + string(handles.isocorr.shear_args{4} + "\n"));
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_syIntersept_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_syIntersept (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.isocorr.shear_args{4} = 0; 
set(hObject,'String', string(handles.isocorr.shear_args{4})); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExecuteShearCorr.
function pushbutton_ExecuteShearCorr_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExecuteShearCorr (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Applying the shearing correction operation
handles.myData = shear_correction(handles.myData, handles.isocorr);
%% 2 - View the figure update
fig = figure(); set(fig, 'Name', 'Iso-Slice', 'Position', [1,1,700,750]);
if isfield(handles, 'myBZ'); view_final(handles.myData, handles.myBZ.overlay, handles.final_fig_args);    
else; view_final(handles.myData, [], handles.final_fig_args);
end
hold on;
% -- Plot the line of the x-shearing line
y = linspace(-1e3, 1e3, 1e3); 
x = (y - handles.isocorr.shear_args{2})/ handles.isocorr.shear_args{1};
plot(x, y, '-', 'color', [0.2, 0.8, 0.2, 0.5], 'linewidth', 1);
% -- Plot the line of the y-shearing line
x = linspace(-1e3, 1e3, 1e3); 
y = handles.isocorr.shear_args{3}*x + handles.isocorr.shear_args{4};
plot(x, y, '-', 'color', [0.2, 0.2, 0.8, 0.5], 'linewidth', 1);
%% 3 - Ask the user if they want to keep the new filtered data
answer = questdlg('Would you like to store the shear corrected data?', ...
	'Shear Correction?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
% - Else save the new data
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SCALE CORRECTION  %%%%%%%%%
% --- Executes when changing the text
function edit_xscale_Callback(hObject, ~, handles)
% hObject    handle to edit_xscale (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),',',' '))), 3);
%% 2 - Validity check on input
% - If no entry is made, default
if isempty(data_entry)
    data_entry = 1;
elseif length(data_entry) > 1
    data_entry = data_entry(1);
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1
    data_entry(1) = round(data_entry, 3);
end
%% 3 - Assigning output and printing change
handles.isocorr.scale_args{1}  = round(data_entry, 3);
set(hObject,'String', string(handles.isocorr.scale_args{1})); 
fprintf("--> x scale-factor: " + string(handles.isocorr.scale_args{1} + "\n"));
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_xscale_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_xscale (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.isocorr.scale_args{1} = 1; 
set(hObject,'String', string(handles.isocorr.scale_args{1})); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_yscale_Callback(hObject, ~, handles)
% hObject    handle to edit_yscale (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),',',' '))), 3);
%% 2 - Validity check on input
% - If no entry is made, default
if isempty(data_entry)
    data_entry = 1;
elseif length(data_entry) > 1
    data_entry = data_entry(1);
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1
    data_entry(1) = round(data_entry, 3);
end
%% 3 - Assigning output and printing change
handles.isocorr.scale_args{2}  = round(data_entry, 3);
set(hObject,'String', string(handles.isocorr.scale_args{2})); 
fprintf("--> y scale-factor: " + string(handles.isocorr.scale_args{2} + "\n"));
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_yscale_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_yscale (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.isocorr.scale_args{2} = 1; 
set(hObject,'String', string(handles.isocorr.scale_args{2})); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExecuteScaleCorr.
function pushbutton_ExecuteScaleCorr_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExecuteScaleCorr (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Applying the scaling correction operation
handles.myData = scale_correction(handles.myData, handles.isocorr);
%% 2 - View the figure update
fig = figure(); set(fig, 'Name', 'Iso-Slice', 'Position', [1,1,700,750]);
if isfield(handles, 'myBZ'); view_final(handles.myData, handles.myBZ.overlay, handles.final_fig_args);    
else; view_final(handles.myData, [], handles.final_fig_args);
end
%% 3 - Ask the user if they want to keep the new scaled data
answer = questdlg('Would you like to store the scale-corrected data?', ...
	'Scale Correction?', ...
	'Yes','No','No');
% - If No or Cancel is pressed, then return nothing
if isempty(answer) || string(answer) == "No"; return; end
% - Else save the new data
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ISOE PLOTTING  %%%%%%%%%%%%
% --- Executes on selection change in popupmenu_cMap.
function popupmenu_cMap_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_cMap (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Extracting User Input
contents = cellstr(get(hObject,'String'));
handles.final_fig_args{1} = string(contents{get(hObject,'Value')});
%% Printing the change that has occured
fprintf("--> cMap (colormap): " + handles.final_fig_args{1} + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_cMap_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_cMap (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
contents = cellstr(get(hObject,'String'));
handles.final_fig_args{1} = string(contents{1});
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_cLims_Callback(hObject, ~, handles)
% hObject    handle to edit_cLims (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),',',' '))), 2);
%% 2 - Validity check on input
% - Finding the max/min limits of the colorbar
for i = 1:length(handles.myData); colLims(i,:) = handles.myData{i}.isoe.colLims; end
colLims = sort([min(colLims(:)), max(colLims(:))]); 
% - If no entry is made, default to the maximum range
if isempty(data_entry) ||  length(data_entry) == 1 || length(data_entry) > 2
    data_entry = [colLims(1), colLims(2)];
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 2
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < colLims(1)-1 || data_entry(1) > colLims(2)+1; data_entry(1) = colLims(1)-1; end
    if data_entry(2) < colLims(1)-1 || data_entry(2) > colLims(2)+1; data_entry(2) = colLims(2)+1; end
end
%% 3 - Assigning output and printing change
handles.final_fig_args{2}  = sort(round(data_entry, 2));
set(hObject,'String', string("["+handles.final_fig_args{2}(1) + "," + handles.final_fig_args{2}(2)+"]")); 
fprintf("--> cLims: " + string("["+handles.final_fig_args{2}(1) + "," + handles.final_fig_args{2}(2)) + "] \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_cLims_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_cLims (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.final_fig_args{2} = []; 
set(hObject,'String', "[]");
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_axCol_Callback(hObject, ~, handles)
% hObject    handle to edit_axCol (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),',',' '))), 2);
%% 2 - Validity check on input
% - If no entry is made, default to the maximum range
if isempty(data_entry) ||  length(data_entry) < 3 || length(data_entry) > 3
    data_entry = [1, 1, 1];
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 3
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < 0; data_entry(1) = 0; end
    if data_entry(1) > 1; data_entry(1) = 1; end
    if data_entry(2) < 0; data_entry(2) = 0; end
    if data_entry(2) > 1; data_entry(2) = 1; end
    if data_entry(3) < 0; data_entry(3) = 0; end
    if data_entry(3) > 1; data_entry(3) = 1; end
end
%% 3 - Assigning output and printing change
handles.final_fig_args{3}  = round(data_entry, 2);
set(hObject,'String', string("["+handles.final_fig_args{3}(1) + "," + handles.final_fig_args{3}(2)+ ","+handles.final_fig_args{3}(3)+"]")); 
fprintf("--> axCol: " + string("["+handles.final_fig_args{3}(1) + "," + handles.final_fig_args{3}(2)+ ","+handles.final_fig_args{3}(3)+"] \n"));
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_axCol_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_axCol (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.final_fig_args{3} = [1,1,1]; 
set(hObject,'String', "[1,1,1]");
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_axLims_Callback(hObject, ~, handles)
% hObject    handle to edit_axLims (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(strrep(get(hObject,'String'),',',' ')), 2);
%% 2 - Validity check on input
% - Finding the max/min limits of the x-axis
for i = 1:length(handles.myData); xLims(i,:) = handles.myData{i}.isoe.xLims; end
xLims = [min(xLims(:))-1, max(xLims(:))+1]; 
% - Finding the max/min limits of the y-axis
for i = 1:length(handles.myData); yLims(i,:) = handles.myData{i}.isoe.yLims; end
yLims = [min(yLims(:))-1, max(yLims(:))+1]; 
% - If no entry is made, default to the maximum range
if isempty(data_entry) ||  length(data_entry) < 4 || length(data_entry) > 4
    data_entry = [xLims(1), xLims(2), yLims(1), yLims(2)];
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 4
    data_entry(1:2) = sort(data_entry(1:2)); 
    data_entry(3:4) = sort(data_entry(3:4));
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < xLims(1) || data_entry(1) > xLims(2); data_entry(1) = xLims(1); end
    if data_entry(2) < xLims(1) || data_entry(2) > xLims(2); data_entry(2) = xLims(2); end
    if data_entry(3) < yLims(1) || data_entry(3) > yLims(2); data_entry(3) = yLims(1); end
    if data_entry(4) < yLims(1) || data_entry(4) > yLims(2); data_entry(4) = yLims(2); end
end
%% 3 - Assigning output and printing change
handles.final_fig_args{4}  = round(data_entry, 2);
set(hObject,'String', string("["+handles.final_fig_args{4}(1) + "," + handles.final_fig_args{4}(2) + "," + handles.final_fig_args{4}(3) + "," + handles.final_fig_args{4}(4)+"]")); 
fprintf("--> axLims: " + string("["+handles.final_fig_args{4}(1) + "," + handles.final_fig_args{4}(2) + "," + handles.final_fig_args{4}(3) + "," + handles.final_fig_args{4}(4)) + "] \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_axLims_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_axLims (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.final_fig_args{4} = []; 
set(hObject,'String', "[]");
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox_axOn.
function checkbox_axOn_Callback(hObject, ~, handles)
% hObject    handle to checkbox_axOn (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting user input
val = get(hObject,'Value');
handles.final_fig_args{5}  = val;
if val == 1; fprintf("--> Show axes-lines: True \n");
else; fprintf("-->Show axes-lines: False \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function checkbox_axOn_CreateFcn(hObject, ~, handles)
% hObject    handle to checkbox_axOn (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% 1 - Set the default parameters
set(hObject,'Value',0);
handles.final_fig_args{5} = get(hObject,'Value');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox_gridOn.
function checkbox_gridOn_Callback(hObject, ~, handles)
% hObject    handle to checkbox_gridOn (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting user input
val = get(hObject,'Value');
handles.final_fig_args{6}  = val;
if val == 1; fprintf("--> Show grid-lines: True \n");
else; fprintf("-->Show grid-lines: False \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function checkbox_gridOn_CreateFcn(hObject, ~, handles)
% hObject    handle to checkbox_gridOn (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% 1 - Set the default parameters
set(hObject,'Value',0);
handles.final_fig_args{6} = get(hObject,'Value');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox_scanaxisOn.
function checkbox_scanaxisOn_Callback(hObject, ~, handles)
% hObject    handle to checkbox_scanaxisOn (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting user input
val = get(hObject,'Value');
handles.final_fig_args{7}  = val;
if val == 1; fprintf("--> Show scan axis: True \n");
else; fprintf("--> Show scan axis: False \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function checkbox_scanaxisOn_CreateFcn(hObject, ~, handles)
% hObject    handle to checkbox_scanaxisOn (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% 1 - Set the default parameters
set(hObject,'Value',0);
handles.final_fig_args{7} = get(hObject,'Value');
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_backgrndCol_Callback(hObject, ~, handles)
% hObject    handle to edit_backgrndCol (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),',',' '))), 2);
%% 2 - Validity check on input
% - If no entry is made, default to the maximum range
if isempty(data_entry) ||  length(data_entry) < 3 || length(data_entry) > 3
    data_entry = [0, 0, 0];
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 3
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < 0; data_entry(1) = 0; end
    if data_entry(1) > 1; data_entry(1) = 1; end
    if data_entry(2) < 0; data_entry(2) = 0; end
    if data_entry(2) > 1; data_entry(2) = 1; end
    if data_entry(3) < 0; data_entry(3) = 0; end
    if data_entry(3) > 1; data_entry(3) = 1; end
end
%% 3 - Assigning output and printing change
handles.final_fig_args{8} = round(data_entry, 2);
set(hObject,'String', string("["+handles.final_fig_args{8}(1) + "," + handles.final_fig_args{8}(2)+ ","+handles.final_fig_args{8}(3)+"]")); 
fprintf("--> backgroundCol: " + string("["+handles.final_fig_args{8}(1) + "," + handles.final_fig_args{8}(2)+ ","+handles.final_fig_args{8}(3)+"] \n"));
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_backgrndCol_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_backgrndCol (see GCBO)
% ~  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.final_fig_args{8} = [0,0,0]; 
set(hObject,'String', "[0,0,0]");
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox_bzOn.
function handles = checkbox_bzOn_Callback(hObject, ~, handles)
% hObject    handle to checkbox_bzOn (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting user input
val = get(hObject,'Value');
handles.final_fig_args{9}  = val;
if val == 1
    set(handles.edit_bzCol, 'Enable', 'on');
    set(handles.edit_bzWidth, 'Enable', 'on');
    fprintf("--> BZ outline: True \n");
else
    set(handles.edit_bzCol, 'Enable', 'off');
    set(handles.edit_bzWidth, 'Enable', 'off');
    fprintf("--> BZ outline: False \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function handles = checkbox_bzOn_CreateFcn(hObject, ~, handles)
% hObject    handle to checkbox_bzOn (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% 1 - Set the default parameters
set(hObject,'Value',0);
handles.final_fig_args{9} = get(hObject,'Value');
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_bzCol_Callback(hObject, ~, handles)
% hObject    handle to edit_bzCol (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),',',' '))), 2);
%% 2 - Validity check on input
% - If no entry is made, default to the maximum range
if isempty(data_entry) ||  length(data_entry) < 3 || length(data_entry) > 3
    data_entry = [1, 1, 1];
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 3
    % -- Forcing the max / min limits on the entries
    if data_entry(1) < 0; data_entry(1) = 0; end
    if data_entry(1) > 1; data_entry(1) = 1; end
    if data_entry(2) < 0; data_entry(2) = 0; end
    if data_entry(2) > 1; data_entry(2) = 1; end
    if data_entry(3) < 0; data_entry(3) = 0; end
    if data_entry(3) > 1; data_entry(3) = 1; end
end
%% 3 - Assigning output and printing change
handles.final_fig_args{10} = round(data_entry, 2);
set(hObject,'String', string("["+handles.final_fig_args{10}(1) + "," + handles.final_fig_args{10}(2)+ ","+handles.final_fig_args{10}(3)+"]")); 
fprintf("--> BZ outline color: " + string("["+handles.final_fig_args{10}(1) + "," + handles.final_fig_args{10}(2)+ ","+handles.final_fig_args{10}(3)+"] \n"));
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_bzCol_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_bzCol (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.final_fig_args{10} = [1,1,1]; 
set(hObject,'String', "[1,1,1]");
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_bzWidth_Callback(hObject, ~, handles)
% hObject    handle to edit_bzWidth (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = abs(round(sort(str2num(strrep(get(hObject,'String'),',',' '))), 2));
%% 2 - Validity check on input
% - If no entry is made, default
if isempty(data_entry)
    data_entry = 1.5;
elseif length(data_entry) > 1
    data_entry = data_entry(1);
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1
    data_entry(1) = round(data_entry, 2);
end
%% 3 - Assigning output and printing change
handles.final_fig_args{11}  = round(data_entry, 2);
set(hObject,'String', string(handles.final_fig_args{11})); 
fprintf("--> BZ LineWidth: " + string(handles.final_fig_args{11} + "\n"));
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_bzWidth_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_bzWidth (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.final_fig_args{11} = 1.5; 
set(hObject,'String', "1.5");
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox_intOn.
function checkbox_intOn_Callback(hObject, ~, handles)
% hObject    handle to checkbox_intOn (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting user input
val = get(hObject,'Value');
handles.final_fig_args{12}  = val;
if val == 1; fprintf("--> Interpolate data: True \n");
else; fprintf("--> Interpolate data: False \n");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function checkbox_intOn_CreateFcn(hObject, ~, handles)
% hObject    handle to checkbox_intOn (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% 1 - Set the default parameters
set(hObject,'Value',0);
handles.final_fig_args{12} = get(hObject,'Value');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_Final2D.
function pushbutton_Final2D_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_Final2D (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Plotting the final IsoE figure
fig = figure(); set(fig, 'Name', 'Iso-Slice', 'Position', [1,1,700,750]);
if isfield(handles, 'myBZ'); view_final(handles.myData, handles.myBZ.overlay, handles.final_fig_args);    
else; view_final(handles.myData, [], handles.final_fig_args);
end
%% Update handles structure
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ISOE VIDEO PLOTTER  %%%%%%%%%%%%
% --- Executes when changing the text
function handles = edit_yLimsVideo_Callback(hObject, ~, handles)
% hObject    handle to edit_yLimsVideo (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 2);
%% 2 - Extracting the max/min values
for i = 1:length(handles.myData)
    if i ==1
        ebLims(1) = min(handles.myData{i}.eb(:));
        ebLims(2) = max(handles.myData{i}.eb(:));
    else
        if ebLims(1) > min(handles.myData{i}.eb(:)); ebLims(1) = min(handles.myData{i}.eb(:)); end
        if ebLims(2) < max(handles.myData{i}.eb(:)); ebLims(2) = max(handles.myData{i}.eb(:)); end
    end
end
%% 3 - Validity check
 % - If no entry is made, default to a small range around the mean
if isempty(data_entry) || length(data_entry) > 2 || size(data_entry, 1) > 1
    data_entry(1) = ebLims(1) + 0.1;
    data_entry(2) = ebLims(2) - 0.1;
 % - If a single entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1 && size(data_entry, 1) ==1
    if data_entry < ebLims(1); data_entry = ebLims(1) + 0.1;
    elseif data_entry > ebLims(2); data_entry = ebLims(2) - 0.1;
    end
    data_entry = [-0.1, 0.1]+data_entry; 
 % - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 2
    % -- Forcing the max / min limits on the entries
    if data_entry(1) <  ebLims(1); data_entry(1) =  ebLims(1) + 0.1;
    elseif data_entry(1) >  ebLims(2); data_entry(1) =  ebLims(2) - 0.1;
    end
    if data_entry(2) <  ebLims(1); data_entry(2) =  ebLims(1) + 0.1;
    elseif data_entry(2) >  ebLims(2); data_entry(2) =  ebLims(2) - 0.1;
    end
    % -- For identical entries, make sure they are made different
    if data_entry(1) == data_entry(2); data_entry(1) = data_entry(1) - 0.2; end
end
handles.arpesVideo_args{1} = round(sort(data_entry), 2); 
set(hObject,'String', string(handles.arpesVideo_args{1}(1) + ":" + handles.arpesVideo_args{1}(2))); 
fprintf("--> yLims (eb): " + string(handles.arpesVideo_args{1}(1) + ":" + handles.arpesVideo_args{1}(2)) + " \n");
%% 4 - Update slice number
if handles.arpesVideo_args{2} ~= 0
    nSlices = round(0.5*abs(diff(handles.arpesVideo_args{1})/handles.arpesVideo_args{2}), 0);
    set(handles.text_nSlices,'String', nSlices);
else
    set(handles.text_nSlices,'String', "n/a");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_yLimsVideo_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_yLimsVideo (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.arpesVideo_args{1} = []; 
set(hObject,'String', "[]");
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_sliceWin_Callback(hObject, ~, handles)
% hObject    handle to edit_sliceWin (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = abs(round(str2num(get(hObject,'String')), 4));
%% 2 - Extracting the max/min values
for i = 1:length(handles.myData)
    if i ==1
        dEb = abs(handles.myData{i}.eb(2,1,1) - handles.myData{i}.eb(1,1,1));
    else
        if dEb < abs(handles.myData{i}.eb(2,1,1) - handles.myData{i}.eb(1,1,1))
            dEb = abs(handles.myData{i}.eb(2,1,1) - handles.myData{i}.eb(1,1,1));
        end
    end
end
%% 3 - Validity check
% Initial validity check
if isempty(data_entry); data_entry = dEb;
else
    data_entry = data_entry(1); 
    if data_entry < dEb; data_entry = dEb;
    elseif data_entry > 1; data_entry = 1; 
    end
end
% Second validity check
if data_entry + 0.01 > abs(diff(handles.arpesVideo_args{1}))
    data_entry = 0.5*abs(diff(handles.arpesVideo_args{1}));
end
% Printing and storing output
handles.arpesVideo_args{2} = round((data_entry), 2); 
set(hObject,'String', string(handles.arpesVideo_args{2})); 
fprintf("--> sliceWin (eV): " + string(handles.arpesVideo_args{2}) + " \n");
%% 4 - Update slice number
if handles.arpesVideo_args{2} ~= 0
    nSlices = round(0.5*abs(diff(handles.arpesVideo_args{1})/handles.arpesVideo_args{2}), 0);
    set(handles.text_nSlices,'String', nSlices);
else
    set(handles.text_nSlices,'String', "n/a");
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_sliceWin_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_sliceWin (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
handles.arpesVideo_args{2} = 0; 
set(hObject,'String', "0");
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ViewARPESvideo.
function pushbutton_ViewARPESvideo_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ViewARPESvideo (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Plotting the ARPES video
view_slicevideo(handles.myData, handles.myBZ.overlay, handles.final_fig_args, handles.arpesVideo_args);    
%% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% SURFACE AREA CALCULATOR  %%%%%%%%%%%%%
% --- Executes when changing the text
function edit_minArea_Callback(hObject, ~, handles)
% hObject    handle to edit_minArea (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(get(hObject,'String')), 4);
%% 2 - Extracting the max/min values
minCol = 0;
maxCol = 1e2;
%% 3 - Validity check on input
% - If no entry is made, default
if isempty(data_entry)
    data_entry = minCol;
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) > 1
    if data_entry(1) < minCol; data_entry(1) = minCol; end
    if data_entry(1) > maxCol; data_entry(1) = maxCol; end
    data_entry = data_entry(1);
% - If a single entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1
    % -- Forcing the max / min limits on the entries
    if data_entry < minCol; data_entry = minCol; end
    if data_entry > maxCol; data_entry = maxCol; end
end
%% 3 - Assigning output and printing change
handles.sa_args{1} = round(data_entry, 4);
set(hObject,'String', string(handles.sa_args{1})); 
fprintf("--> minArea: " + string(handles.sa_args{1} + "\n"));
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_minArea_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_minArea (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.sa_args{1} = 0; 
set(hObject,'String', string(handles.sa_args{1})); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_maxThresh_Callback(hObject, ~, handles)
% hObject    handle to edit_maxThresh (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(get(hObject,'String')), 4);
%% 2 - Extracting the max/min values
for i = 1:length(handles.myData)
    if i ==1
        minCol = min(handles.myData{i}.isoe.DSlice(:));
        maxCol = max(handles.myData{i}.isoe.DSlice(:));
    else
        if minCol < min(handles.myData{i}.isoe.DSlice(:)); minCol = min(handles.myData{i}.isoe.DSlice(:)); end
        if maxCol < max(handles.myData{i}.isoe.DSlice(:)); maxCol = max(handles.myData{i}.isoe.DSlice(:)); end
    end
end
defaultCol = 0.5*abs((abs(maxCol) - abs(minCol)));
minCol = 0;
maxCol = 1;
%% 3 - Validity check on input
% - If no entry is made, default
if isempty(data_entry)
    data_entry = defaultCol;
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) > 1
    if data_entry(1) < minCol; data_entry(1) = minCol; end
    if data_entry(1) > maxCol; data_entry(1) = maxCol; end
    data_entry = data_entry(1);
% - If a single entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1
    % -- Forcing the max / min limits on the entries
    if data_entry < minCol; data_entry = minCol; end
    if data_entry > maxCol; data_entry = maxCol; end
end
%% 3 - Assigning output and printing change
handles.sa_args{2} = round(data_entry, 4);
set(hObject,'String', string(handles.sa_args{2})); 
fprintf("--> maxThresh: " + string(handles.sa_args{2} + "\n"));
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_maxThresh_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_maxThresh (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.sa_args{2} = 0; 
set(hObject,'String', string(handles.sa_args{2})); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_FindIsoCont.
function pushbutton_FindIsoCont_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_FindIsoCont (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Plotting the final ARPES figure
final_fig_args = handles.final_fig_args;
final_fig_args{7} = 0;
fig = figure(); set(fig, 'Name', 'Iso-Slice', 'Position', [1,1,700,750]);
if isfield(handles, 'myBZ'); view_final(handles.myData, handles.myBZ.overlay, final_fig_args);    
else; view_final(handles.myData, [], final_fig_args);
end
%% 2 - Determination of the Luttinger Area
handles.myData = surface_area_calc(handles.myData, handles.sa_args);
%% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LINE PROFILE EXTRACTION  %%%%%%%%%%%%%
% --- Executes on selection change in popupmenu_cutType.
function popupmenu_cutType_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_cutType (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Extracting User Input
contents = cellstr(get(hObject,'String'));
handles.lineprof_args{1} = string(contents{get(hObject,'Value')});
%% Updating input variables
set(handles.edit_cutVal, 'String', []);
handles = edit_cutVal_Callback(handles.edit_cutVal, [], handles);
handles = edit_cutWin_Callback(handles.edit_cutWin, [], handles);
%% Printing the change that has occured
fprintf("--> cutType: " + handles.lineprof_args{1} + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_cutType_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_cutType (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
contents = cellstr(get(hObject,'String'));
handles.lineprof_args{1} = string(contents{1});
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_cutVal_Callback(hObject, ~, handles)
% hObject    handle to edit_cutVal (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(get(hObject,'String')), 4);
%% 2 - Extracting the max/min values
for i = 1:length(handles.myData)
    % For a horizontal cut through the x-axis
    if handles.lineprof_args{1} == "horizontal"
        if i ==1
            axLim(1) = min(handles.myData{i}.isoe.YSlice(:));
            axLim(2) = max(handles.myData{i}.isoe.YSlice(:));
        else
            if axLim(1) > min(handles.myData{i}.isoe.YSlice(:)); axLim(1) = min(handles.myData{i}.isoe.YSlice(:)); end
            if axLim(2) < max(handles.myData{i}.isoe.YSlice(:)); axLim(2) = max(handles.myData{i}.isoe.YSlice(:)); end
        end
    % For a vertical cut through the scan-axis
    elseif handles.lineprof_args{1} == "vertical"
        if i ==1
            axLim(1) = min(handles.myData{i}.isoe.XSlice(:));
            axLim(2) = max(handles.myData{i}.isoe.XSlice(:));
        else
            if axLim(1) > min(handles.myData{i}.isoe.XSlice(:)); axLim(1) = min(handles.myData{i}.isoe.XSlice(:)); end
            if axLim(2) < max(handles.myData{i}.isoe.XSlice(:)); axLim(2) = max(handles.myData{i}.isoe.XSlice(:)); end
        end
    end
end
%% 3 - Validity check on input
% - If no entry is made, default
if isempty(data_entry)
    data_entry = mean(axLim);
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) > 1
    if data_entry(1) < axLim(1); data_entry(1) = axLim(1); end
    if data_entry(1) > axLim(2); data_entry(1) = axLim(2); end
    data_entry = data_entry(1);
% - If a single entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1
    % -- Forcing the max / min limits on the entries
    if data_entry < axLim(1); data_entry = axLim(1); end
    if data_entry > axLim(2); data_entry = axLim(2); end
end
handles.lineprof_args{2} = round((data_entry), 2); 
set(hObject,'String', string(handles.lineprof_args{2}));
fprintf("--> cutVal: " + string(handles.lineprof_args{2}) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_cutVal_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_cutVal (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.lineprof_args{2} = 0; 
set(hObject,'String', string(handles.lineprof_args{2})); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function handles = edit_cutWin_Callback(hObject, ~, handles)
% hObject    handle to edit_cutWin (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = abs(round(str2num(get(hObject,'String')), 4));
%% 2 - Validity check on input
% - If no entry is made, default
if isempty(data_entry)
    data_entry = 0.1;
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) > 1
    if data_entry(1) < 0.01; data_entry(1) = 0.01; end
    if data_entry(1) > 2; data_entry(1) = 2; end
    data_entry = data_entry(1);
% - If a single entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1
    % -- Forcing the max / min limits on the entries
    if data_entry < 0.01; data_entry = 0.01; end
    if data_entry > 2; data_entry = 2; end
end
handles.lineprof_args{3} = round((data_entry), 2); 
set(hObject,'String', string(handles.lineprof_args{3}));
fprintf("--> cutWin: " + string(handles.lineprof_args{3}) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_cutWin_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_cutWin (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.lineprof_args{3} = 0; 
set(hObject,'String', string(handles.lineprof_args{3})); 
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExtractLineProfile.
function pushbutton_ExtractLineProfile_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExtractLineProfile (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Plotting the ARPES IsoE slice (if required)
if isempty(findobj('type','figure','number',3327))
    fig = figure(3327); 
    set(fig, 'Name', 'Line Profile Determination', 'Position', [1,1,800,450]);
    subplot(121); hold on;
    if isfield(handles, 'myBZ'); view_final(handles.myData, handles.myBZ.overlay, handles.final_fig_args);    
    else; view_final(handles.myData, [], handles.final_fig_args);
    end
    % - Re-formatting the figure
    colorbar off;
    for i = 1:length(handles.myData)
        xTemp(i,:) = handles.myData{i}.isoe.xLims;
        yTemp(i,:) = handles.myData{i}.isoe.yLims;
    end
    xLims(1) = min(min(xTemp)); xLims(2) = max(max(xTemp));
    yLims(1) = min(min(yTemp)); yLims(2) = max(max(yTemp));
    axis([xLims, yLims]);
    title('IsoE slice');
end
%% 2 - Plotting the line profiles
fig = figure(3327); subplot(121);
view_lineprofile(handles.myData, handles.lineprof_args)
%% Update handles structure
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INTERNAL PROCESSING FUNCTIONS %%%%%%%%%%
% ---  Function to load in single or multiple ARPES data-files that have been processed
function dataStr = load_isoe_data(FileNames)
% dataStr = load_isoe_data(FileNames)
%   This function loads in already processed data in the form 
%   of a *.mat file that has been parsed through the 'arpes_processor'
%   UI. The data is then extracted as a MATLAB cell-array of data
%   structures. For a single loaded file, dataStr is just a MATLAB
%   data-structure, whereas for multiple files, dataStr is a cell-array of
%   MATLAB data-structures.
%
%   REQ. FUNCTIONS: none
%
%   IN:
%   -   FileNames:           string or cell-array of strings of the *.mat file-names to be loaded.
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

%% Displaying function and initialising wait-bar
disp('Loading processed ARPES data...')
wbar = waitbar(0, 'Loading *.mat data...', 'Name', 'load_isoe_data');
wbar.Children.Title.Interpreter = 'none';
%% 1 - Filing through each of the file-names to extract data
% - Converting the FileNames into a cell-array of strings
FileNames = cellstr(FileNames);
% - Iterating through all the FileNames to extract the ARPES data
for i = 1:length(FileNames)
    waitbar(i/length(FileNames), wbar, sprintf("Loading '%s'...", FileNames{i}), 'Name', 'load_isoe_data', 'interpreter', 'none');
    arpes_data = load(FileNames{i}); data{i} = arpes_data.dataStruc;
    % -- If no previous isoe analysis has been performed, follow this
    if iscell(data{i})
        for jj = 1:length(data{i})
            dataStr{jj} = data{i}{jj};
        end
    elseif ~isfield(data{i}, 'isoe')
        if data{i}.Type == "Eb(k)"; error('Only Eb(kx,ky) and/or Eb(kx,kz) ARPES data files can be loaded here...'); end
        dataStr{i} = data{i};
        dataStr{i}.isoe = [];
        dataStr{i}.isoe.matfile = string(FileNames{i});
        dataStr{i}.isoe.Type = dataStr{i}.Type;
    % -- If previous isoe analysis has been performed, load in all data
    else
        dataStr{i} = data{i};
    end
end
%% Close wait-bar
close(wbar);

% ---  Function to extract the Iso-surface given the slice range
function [XSlice, YSlice, DSlice] = extract_slice(dataStr, fig_args)
% [XSlice, YSlice, DSlice] = extract_slice(dataStr, fig_args)
%   This function extracts an isok or isoe slice through all files that
%   have been loaded into the dataStr{} cell-array data-structure. All
%   slices are taken and put in the form of cell-arrays that consist
%   of the x- and y-isoe domains and the data intensity.
%
%   REQ. FUNCTIONS:
%   -   [h=] ImData(X,Y,Z[,style])
%   -   [XR,YR,DataR] = Remap(XM,YM,Data)
%   -   [DSlice,XSlice]=Slice(ACorr,ECorr,Data,xMode,Win) 
%
%   IN:
%   dataStr - loaded MATLAB data structure.
%   -   dataStr{i}:       contains the i'th data for the i'th file loaded to be sliced.
%   -   fig_args:        1x4 cell of {scanIndex, isoSlice, isoType, remap}.
%
%   OUT:
%   -   XSlice{}:          cell-array of 2D arrays holding the x-domain of isoe slices for all files loaded.
%   -   YSlice{}:          cell-array of 2D arrays holding the y-domain of isoe slices for all files loaded.
%   -   DSlice{}:          cell-array of 2D arrays holding the data intensity of isoe slices for all files loaded.
%   -   figure output of the slice operation.

%% 1 - Extracting all of the iso-slices
for i = 1:length(dataStr)
    % - Extracting the fields to be used
    % Defining the x, y and d-fields
    xField = 'kx'; 
    yField = 'eb'; 
    dField = 'data';
    if dataStr{i}.Type == "Eb(kx,ky)"; zField = 'ky';
    elseif dataStr{i}.Type == "Eb(kx,kz)"; zField = 'kz';
    end
    % - Capping the window to the max/min of the ARPES data
    if isempty(fig_args{2}); WinLims = [-0.1, 0.1];
    else; WinLims = sort(fig_args{2});
    end
    step_size = 0.05;
    if fig_args{1} == "IsoE"
        if WinLims(1) < min(dataStr{i}.(yField)(:)); WinLims(1) = min(dataStr{i}.(yField)(:))+step_size; end
        if WinLims(2) > max(dataStr{i}.(yField)(:)); WinLims(2) = max(dataStr{i}.(yField)(:))-step_size; end
    elseif fig_args{1} == "IsoK"
        if WinLims(1) < min(dataStr{i}.(xField)(:)); WinLims(1) = min(dataStr{i}.(xField)(:))+step_size; end
        if WinLims(2) > max(dataStr{i}.(xField)(:)); WinLims(2) = max(dataStr{i}.(xField)(:))-step_size; end
    end
    %% 1.1 - Extracting the Iso slices
    if fig_args{1} == "IsoE"
        [DSlice{i}, XSlice{i}] = Slice(dataStr{i}.(xField), dataStr{i}.(yField), dataStr{i}.(dField), 'IsoE', WinLims);
        % - Extracting the scan parameter variables
        if isfield(dataStr{i}, 'kx'); init = ceil(0.5*size(dataStr{i}.(dField), 2)); YSlice{i} = squeeze(dataStr{i}.(zField)(init,:,:))';
        else; YSlice{i} = squeeze(dataStr{i}.(zField))';
        end
    elseif fig_args{1}== "IsoK"    
        [DSlice{i}, YSlice{i}] = Slice(dataStr{i}.(xField), dataStr{i}.(yField), dataStr{i}.(dField), 'IsoK', WinLims);
        % - Extracting the scan parameter variables
        if isfield(dataStr{i}, 'kx'); init = ceil(0.5*size(dataStr{i}.(dField), 2)); XSlice{i} = squeeze(dataStr{i}.(zField)(:,init,:));
        else; XSlice{i} = squeeze(dataStr{i}.(zField))';
        end
    end
    %% 1.2 - Re-mapping the Iso slices onto a square grid if required
    if fig_args{3} == 1
         [XSlice{i}, YSlice{i}, DSlice{i}] = Remap(XSlice{i}, YSlice{i}, DSlice{i});
         YSlice{i} = YSlice{i}';
         DSlice{i}(isnan(DSlice{i})) = 0;
    end
    %% 1.3 - Finding the min/max values of the data
    colLims(i,:) = [min(DSlice{i}(:)), max(DSlice{i}(:))];
    xLims(i,:) = [min(XSlice{i}(:)), max(XSlice{i}(:))];
    yLims(i,:) = [min(YSlice{i}(:)), max(YSlice{i}(:))];
end

%% Figure summary of the slices
fig = figure(); hold on;
if fig_args{1} == "IsoE"; set(fig, 'Name', 'Iso-Slice', 'Position', [1,1,600,600]); pbaspect([1,1,1]);
elseif fig_args{1} == "IsoK"; set(fig, 'Name', 'Iso-Slice', 'Position', [1,1,1000,500]);
end
% - Plotting the Iso slices
for i = 1:length(dataStr); ImData(XSlice{i}, YSlice{i}, DSlice{i}); end
% -- Formatting the axes
caxis([min(colLims(:)), max(colLims(:))]);
axis([min(xLims(:)), max(xLims(:)), min(yLims(:)), max(yLims(:))]);
line([0 0], [-1e5, 1e5], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
line([-1e5, 1e5], [0 0], 'Color', [1 1 1 0.5], 'LineWidth', 0.75, 'Linestyle', '--');
% -- Re-labelling the axes depending on what slice is taken
if fig_args{1}== "IsoE"
    if dataStr{i}.Type == "Eb(kx,ky)"; xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex'); ylabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex'); 
    elseif dataStr{i}.Type == "Eb(kx,kz)"; xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex'); ylabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex'); 
    end
elseif fig_args{1}== "IsoK"
    if dataStr{i}.Type == "Eb(kx,ky)"; xlabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex'); ylabel('$$ \bf  E_B (eV) $$', 'Interpreter', 'latex'); 
    elseif dataStr{i}.Type == "Eb(kx,kz)"; xlabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex');  ylabel('$$ \bf  E_B (eV) $$', 'Interpreter', 'latex'); 
    end
end
% -- Axes properties
ax = gca;
% --- Font properties
ax.FontName = 'Helvetica'; ax.FontWeight = 'normal'; ax.FontSize = 20;
% --- Tick properties
ax.TickLabelInterpreter = 'latex';
ax.XMinorTick = 'on'; ax.YMinorTick = 'on';
ax.TickDir = 'out';
ax.TickLength = [0.01 0.025];
ax.XColor = [0 0 0]; ax.YColor = [0 0 0];
% --- Ruler properties
ax.XAxisLocation = 'bottom';            % 'bottom' | 'top' | 'origin'
ax.YAxisLocation = 'left';                   % 'left' | 'right' | 'origin'
% --- Box Styling properties
ax.Color = [0, 0, 0];
ax.LineWidth = 1.5;
ax.Box = 'off'; ax.Layer = 'Top';
% -- Adding title to the figure
title(sprintf(string(dataStr{1}.H5file) + "; %s; [%.2f,%.2f]", fig_args{1}, fig_args{2}(1),fig_args{2}(2)), 'interpreter', 'none', 'fontsize', 12);
% -- Colorbar properties
colormap hot; cb = colorbar; 
% --- Colorbar font properties
cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 10;
% --- Colorbar tick properties
cb.Ticks = sort(round([cb.Limits(1), 0.5*(cb.Limits(2)-cb.Limits(1)), cb.Limits(2)], 2));
cb.TickLabelInterpreter = 'latex';
cb.TickLength = 0.04; cb.TickDirection = 'out';
% --- Colorbar position properties
pos = get(cb, 'Position'); cb.Position = [1.09*pos(1) 4.5*pos(2) 0.02 0.1];
% --- Colorbar box properties
cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;

% --- Function to filter the ARPES data
function dataStr = filter_data(dataStr, isocorr_args)
% dataStr = filter_data(dataStr, isocorr_args)
%   This function filters the ARPES isoe data given the filter arguments, 
%   which includes the filter type ("Gaco2", "GaussFlt2", "CurvatureFlt2" 
%   or "LaplaceFlt2") and filter parameters. The user defines this
%   within the 'isocorr_args.filter_args' variable as {filter_type,
%   filter_val}.
%
%   REQ. FUNCTIONS:
%   -   AA = Gaco2(A,hwX,hwY [,hsX] [,hsY])
%   -   AA = GaussFlt2(Img,hwX,hwY,hsX,hsY)
%   -   AA = CurvatureFlt2(Img [,order] [,CX] [,CY]) 
%   -   AA = LaplaceFlt2(Img [,y2xRatio] [,order])
%
%   IN:
%   dataStr - loaded MATLAB data structure.
%   -   dataStr{i}.isoe:        contains the i'th isoe data for the i'th file loaded.
%   isocorr_args - MATLAB data-structure containing all correction arguments.
%   -   .(scale_args):          {1x2} array of {xScale, yScale}
%	-   .(filter_args):           {1x2} array of {filter_type, filter_val}
%	-   .(shear_args):         {1x4} array of {xslope, xinter, yslope, yinter}
%	-   .(origin_args):         {1x2} array of {xShift, yShift}
%	-   .(bsub_args):          {1x2} array of {isoCut}
%	-   .(file):                       {1x1} array of {[fileIndex]}
%
%   OUT:
%   -   dataStr                       modified and filtered ARPES data structure.

disp('Data filtering...')
wbar = waitbar(0, 'Executing data filtering...', 'Name', 'filter_data');

%% 1 - Performing the filtering operation over chosen files
for i = isocorr_args.file
    waitbar(i/length(isocorr_args.file), wbar, 'Filtering ARPES data...', 'Name', 'filter_data');
    if isocorr_args.filter_args{1} == "Gaco2"
        filtered_data = Gaco2(dataStr{i}.isoe.DSlice, isocorr_args.filter_args{2}(1), isocorr_args.filter_args{2}(2)); 
    elseif isocorr_args.filter_args{1} == "GaussFlt2"
        filtered_data = GaussFlt2(dataStr{i}.isoe.DSlice, isocorr_args.filter_args{2}(1), isocorr_args.filter_args{2}(2),isocorr_args.filter_args{2}(1), isocorr_args.filter_args{2}(2)); 
    elseif isocorr_args.filter_args{1} == "LaplaceFlt2"
        filtered_data = GaussFlt2(dataStr{i}.isoe.DSlice, 5, 5, 40, 40);
        filtered_data = SetContrast(filtered_data, 0.4, 0.999, 1.5);
        filtered_data = LaplaceFlt2(filtered_data, isocorr_args.filter_args{2}(1));
    elseif isocorr_args.filter_args{1} == "CurvatureFlt2"
        filtered_data=GaussFlt2(dataStr{i}.isoe.DSlice, 100, 100, 500, 500);
        filtered_data = SetContrast(filtered_data, 0.4, 0.999, 1.5);
        filtered_data=CurvatureFlt2(filtered_data, '2D', isocorr_args.filter_args{2}(1), isocorr_args.filter_args{2}(2));
        filtered_data = GaussFlt2(filtered_data, 1, 1, 10, 10);
        filtered_data = SetContrast(filtered_data, 0.2, 0.999);
    end
    % -- Saving the filtered data slice
    dataStr{i}.isoe.DSlice = filtered_data;
    % -- Setting NaN values to zero
    dataStr{i}.isoe.DSlice(isnan(dataStr{i}.isoe.DSlice)) = 0;
end
%% Close wait-bar
close(wbar);

% --- Function for background subtraction
function dataStr = background_subtraction(dataStr, isocorr_args)
% dataStr = background_subtraction(dataStr, isocorr_args)
%   This function background subtracts isoe ARPES data, given a specific
%   window [minKx, maxKx] over which to cut the isoe surface. The entire
%   isoe surface is then divided by this region, to normalised the
%   background to be uniform across all isoe scans. The user defines this
%   within the 'isocorr_args.bsub_args' variable as {isoCut}.
%
%   REQ. FUNCTIONS:
%   -   AA = Gaco2(A,hwX,hwY [,hsX] [,hsY])
%   -   [XCut,DCut]=Cut(ACorr,ECorr,Data,xMode,Win)
%
%   IN:
%   dataStr - loaded MATLAB data structure.
%   -   dataStr{i}.isoe:        contains the i'th isoe data for the i'th file loaded.
%   isocorr_args - MATLAB data-structure containing all correction arguments.
%   -   .(scale_args):          {1x2} array of {xScale, yScale}
%	-   .(filter_args):           {1x2} array of {filter_type, filter_val}
%	-   .(shear_args):         {1x4} array of {xslope, xinter, yslope, yinter}
%	-   .(origin_args):         {1x2} array of {xShift, yShift}
%	-   .(bsub_args):          {1x2} array of {isoCut}
%	-   .(file):                       {1x1} array of {[fileIndex]}
%
%   OUT:
%   -   dataStr                       modified and background subtracted ARPES data structure.

disp('Background subtraction...')
wbar = waitbar(0, 'Executing background subtraction...', 'Name', 'background_subtraction');

%% 1 - Performing the background subtraction operation over chosen files
for i = isocorr_args.file
    waitbar(i/length(isocorr_args.file), wbar, 'Background subtracting ARPES data...', 'Name', 'background_subtraction');
    % - Extracting the line profile cut over the defined window
    [~, DCut] = Cut(dataStr{i}.isoe.XSlice, dataStr{i}.isoe.YSlice, dataStr{i}.isoe.DSlice,'edc', isocorr_args.bsub_args{1});
    DCut(isnan(DCut)) = 0;
    DCut = Gaco2(DCut, 5, 5);
    % - Dividing by the background
    for j = 1:size(dataStr{i}.isoe.DSlice, 2)
        dataStr{i}.isoe.DSlice(:,j) = dataStr{i}.isoe.DSlice(:,j) ./ DCut;
    end
    % - Subtracting to make the background zero
    dataStr{i}.isoe.DSlice = dataStr{i}.isoe.DSlice - min(dataStr{i}.isoe.DSlice(:));
end
%% 2 - Normalising maximum to unity
for i = 1:length(dataStr); norm_const(i) = max(dataStr{i}.isoe.DSlice(:)); end
norm_const = max(norm_const(:));
for i = 1:length(dataStr)
    dataStr{i}.isoe.DSlice = dataStr{i}.isoe.DSlice ./ norm_const;
end
%% Close wait-bar
close(wbar);

% --- Function to apply origin corrections
function dataStr = origin_correction(dataStr, isocorr_args)
% dataStr = origin_correction(dataStr, isocorr_args)
%   This function corrects the origin position of an isoe surface by
%   applying a shift in the x- and y-dimensions that is defined by the user
%   within the 'isocorr_args.origin_args' variable as {xShift, yshift};
%
%   REQ. FUNCTIONS: none
%
%   IN:
%   dataStr - loaded MATLAB data structure.
%   -   dataStr{i}.isoe:        contains the i'th isoe data for the i'th file loaded.
%   isocorr_args - MATLAB data-structure containing all correction arguments.
%   -   .(scale_args):          {1x2} array of {xScale, yScale}
%	-   .(filter_args):           {1x2} array of {filter_type, filter_val}
%	-   .(shear_args):         {1x4} array of {xslope, xinter, yslope, yinter}
%	-   .(origin_args):         {1x2} array of {xShift, yShift}
%	-   .(bsub_args):          {1x2} array of {isoCut}
%	-   .(file):                       {1x1} array of {[fileIndex]}
%
%   OUT:
%   -   dataStr                       modified and origin corrected ARPES data structure.

disp('Origin corrections...')
wbar = waitbar(0, 'Executing origin correction...', 'Name', 'origin_correction');

%% 1 - Performing the origin correction operation over chosen files
for i = isocorr_args.file
    waitbar(i/length(isocorr_args.file), wbar, 'Origin shifting ARPES data...', 'Name', 'origin_correction');
    dataStr{i}.isoe.XSlice = dataStr{i}.isoe.XSlice + isocorr_args.origin_args{1};
    dataStr{i}.isoe.YSlice = dataStr{i}.isoe.YSlice + isocorr_args.origin_args{2};
end
%% Close wait-bar
close(wbar);

% ---  Function to shear correct data
function dataStr = shear_correction(dataStr, isocorr_args)
% dataStr = shear_correction(dataStr, isocorr_args)
%   This function shear corrects the isoe surface in both the x- or
%   y-dimension. By defining the slope and intersept of a striaght line, x-
%   and y-shifts can be applied to shear the x- and y-variables of the
%   ARPES isoe surface. The user defines this within the 'isocorr_args.shear_args'
%   variable as {xslope, xinter, yslope, yinter}.
%
%   REQ. FUNCTIONS: none
%
%   IN:
%   dataStr - loaded MATLAB data structure.
%   -   dataStr{i}.isoe:        contains the i'th isoe data for the i'th file loaded.
%   isocorr_args - MATLAB data-structure containing all correction arguments.
%   -   .(scale_args):          {1x2} array of {xScale, yScale}
%	-   .(filter_args):           {1x2} array of {filter_type, filter_val}
%	-   .(shear_args):         {1x4} array of {xslope, xinter, yslope, yinter}
%	-   .(origin_args):         {1x2} array of {xShift, yShift}
%	-   .(bsub_args):          {1x2} array of {isoCut}
%	-   .(file):                       {1x1} array of {[fileIndex]}
%
%   OUT:
%   -   dataStr                       modified and shear corrected ARPES data structure.

disp('Shear corrections...')
wbar = waitbar(0, 'Executing shear correction...', 'Name', 'shear_correction');

%% Defining the shear function
shear_corr = @ (slope, intersept, y) (y - intersept)/slope;
%% 1 - Performing the shearing correction operation over chosen files
for i = isocorr_args.file
    waitbar(i/length(isocorr_args.file), wbar, 'Shear correcting ARPES data...', 'Name', 'shear_correction');
    % - Applying x-shear corrections
    if isocorr_args.shear_args{1} == 0; x_shifts = zeros(size(dataStr{i}.isoe.YSlice));
    else; x_shifts = shear_corr(isocorr_args.shear_args{1}, isocorr_args.shear_args{2}, dataStr{i}.isoe.YSlice);
    end
    dataStr{i}.isoe.XSlice = dataStr{i}.isoe.XSlice+ x_shifts;
    % - Applying y-shear corrections
    if isocorr_args.shear_args{3} == 0; y_shifts = zeros(size(dataStr{i}.isoe.YSlice));
    else; y_shifts = shear_corr(isocorr_args.shear_args{3}, isocorr_args.shear_args{4}, dataStr{i}.isoe.XSlice);
    end
    dataStr{i}.isoe.YSlice = dataStr{i}.isoe.YSlice + y_shifts;
end
%% Close wait-bar
close(wbar);

% ---  Function to shear correct data
function dataStr = scale_correction(dataStr, isocorr_args)
% dataStr = scale_correction(dataStr, isocorr_args)
%   This function scale corrects the isoe surface in both the x- or
%   y-dimension. A simple scaling factor multiples the x- and y-
%   dimensions. The user defines this within the 'isocorr_args.scale_args'
%   variable as {xScale, yScale}.
%
%   REQ. FUNCTIONS: none
%
%   IN:
%   dataStr - loaded MATLAB data structure.
%   -   dataStr{i}.isoe:        contains the i'th isoe data for the i'th file loaded.
%   isocorr_args - MATLAB data-structure containing all correction arguments.
%   -   .(scale_args):          {1x2} array of {xScale, yScale}
%	-   .(filter_args):           {1x2} array of {filter_type, filter_val}
%	-   .(shear_args):         {1x4} array of {xslope, xinter, yslope, yinter}
%	-   .(origin_args):         {1x2} array of {xShift, yShift}
%	-   .(bsub_args):          {1x2} array of {isoCut}
%	-   .(file):                       {1x1} array of {[fileIndex]}
%
%   OUT:
%   -   dataStr                       modified and shear corrected ARPES data structure.

disp('Scale corrections...')
wbar = waitbar(0, 'Executing scale correction...', 'Name', 'scale_correction');

%% 1 - Performing the scale correction operation over chosen files
for i = isocorr_args.file
    waitbar(i/length(isocorr_args.file), wbar, 'Scale correcting ARPES data...', 'Name', 'scale_correction');
    % - Applying x scaling
    dataStr{i}.isoe.XSlice = (dataStr{i}.isoe.XSlice-mean(dataStr{i}.isoe.XSlice(:)))*isocorr_args.scale_args{1} + mean(dataStr{i}.isoe.XSlice(:));
    % - Applying y scaling
    dataStr{i}.isoe.YSlice = (dataStr{i}.isoe.YSlice-mean(dataStr{i}.isoe.YSlice(:)))*isocorr_args.scale_args{2} + mean(dataStr{i}.isoe.YSlice(:));
end
%% Close wait-bar
close(wbar);

% ---  Function to extract all real- and reciprocal-space vectors based on crystallographic input
function [realStr, reciStr] = extract_lattice(crystal_args, plotFig)
% crystStr = extract_lattice(crystal_args)
%   This is a function that extracts the crystallographic vectors
%   of a general crystal structure in both real- and reciprocal-
%   space based on the inputs. All 14 Bravais lattices can be 
%   defined, including primitive-, base-, face- and body-centered
%   lattices. The outputs are two MATLAB structures that contain
%   all of the real- and reciprocal-space data.
%
%   IN:
%   -   crystal_args:     1x4 cell of {crystalType, (a, b, c), (alpha, beta, gamma)} described below;
%   crystalType;        string of the crystal type to be used, can only be the following;
%                               "CUB-Oh", "BCC-Oh", "FCC-Oh", "HEX-D6h", 
%                               "RHL-D3d", "TET-D4h", "BCT-D4h", "ORC-D2h", 
%                               "ORCC-D2h", "ORCI-D2h", "ORCF-D2h", "MCL-C2h", 
%                               "MCLC-C2h",  "TRI-Ci" .
%   (a, b, c);                                     1x3 row-vector of the side lengths of the crystal systems unit cell (Angstroms).
%   (alpha, beta, gamma);             1x3 row vector the opposite angles of the crystal systems unit cell (degrees).
%   -   plotFig:          if 1, will plot figure summary, otherwise it wont.
%
%   OUT:
%   realStr - MATLAB data structure containing all real-space information below.
%   -   .(crystal):     string of the crystal type.
%   -   .(T1):            a1 primitive translation vector.
%	-   .(T2):            a2 primitive translation vector.
%   -   .(T3):            a3 primitive translation vector.
%   -   .(Tb0):          atomic basis vectors.
%	-   .(Tvol):          volume of the real-space unit cell.
%	-   .(T):               atomic positions over multiple primitive-translations to show crystal structure.
%	-   .(Tlims):        axes limits in 3D for the lattice structure T.
%	-   .(Tnn):           linked lines between nearest neighbour atomsdisplayed in .(T).
%	-   .(Tws):           Wigner-Seitz cell in real-space.
%   reciStr                     MATLAB data structure containing all reciprocal-space information below.
%   -   .(crystal):     string of the crystal type.
%   -   .(G1):            b1 primitive reciprocal vector.
%	-   .(G2):            b2 primitive reciprocal vector.
%   -   .(G3):            b3 primitive reciprocal vector.
%   -   .(Gb0):          atomic basis vectors in reciprocal space.
%	-   .(Gvol):          volume of the reciprocal-space unit cell.
%	-   .(G):               reciprocal lattice over multiple translations.
%	-   .(Glims):        axes limits in 3D for the lattice structure G.
%	-   .(Gnn):           linked lines between nearest neighbour reciprocal-points displayed in .(G).
%	-   .(Gbz):           First Brilluoin zone in reciprocal-space.

%% Default parameters
if nargin < 2; plotFig = 0; end
if isempty(plotFig); plotFig = 0;  end
disp('-> Extracting 3D BZ...')
wbar = waitbar(0, 'Extracting crystallographic variables...', 'Name', 'extract_lattice');

%% Initialising the input variables
crystal = crystal_args{1};
a = crystal_args{2}(1);
b = crystal_args{2}(2);
c = crystal_args{2}(3);
alpha=crystal_args{3}(1)*pi/180;
beta=crystal_args{3}(2)*pi/180;
gamma=crystal_args{3}(3)*pi/180;

%% 1 - Defining the real-space unit cell from a general triclinic geometry
% -- Extracting the triclinic coefficients for real-space unit vectors
w1 = cos(alpha) - cos(beta) * cos(gamma)/(sin(beta) * sin(gamma));
w2 = sin(gamma)^2 - cos(beta)^2 - cos(alpha)^2 + 2*cos(alpha) *cos(beta) * cos(gamma);
w2 = sqrt(w2) / (sin(beta) * sin(gamma));
% -- Defining the real-space unit vectors
T1 = [a, 0, 0];
T2 = [b * cos(gamma), b	* sin(gamma), 0];
T3 = [c * cos(beta), c * w1*sin(beta), c*w2*sin(beta)];
% -- Extracting the volume of the real-space unit cell
Tvol = cross(T1, T2)*T3';
%% 2 - Defining the basis of the Bravais Lattice out of the 14 possible choices
% - 2.1 - The 7 Primitive (Simple) Bravais lattices
if crystal == "CUB-Oh" || crystal == "HEX-D6h" || crystal == "RHL-D3d" ||...
        crystal == "TET-D4h" || crystal == "ORC-D2h" || crystal == "MCL-C2h" ||...
        crystal == "TRI-Ci"
    Tb0 = [0, 0, 0];
% - 2.2 - The 2 Base-Centered Bravais Lattices
elseif crystal == "ORCC-D2h" || crystal == "MCLC-C2h"
    Tb0 = [0, 0, 0;...
        0.5*(T1+T2)];
% - 2.3 - The 3 Body-Centered Bravais Lattices
elseif crystal == "BCC-Oh" || crystal == "BCT-D4h" || crystal == "ORCI-D2h"
    Tb0 = [0, 0, 0;...
        0.5*(T1+T2+T3)];
% - 2.4 - The 2 Face-Centered Bravais Lattices
elseif crystal == "FCC-Oh" || crystal == "ORCF-D2h"
    Tb0 = [0, 0, 0;...
        0.5*(T1+T2);...
        0.5*(T1+T3);...
        0.5*(T2+T3)];
end
%% 3 - Extracting the real-space lattice over multiple translations of T
l=1;
for i=-1:1
    for j=0:2
        for k=-1:1
            for n = 1:size(Tb0,1)
                T(l,:)=i*T1+j*T2+k*T3+Tb0(n,:);
                l=l+1;
            end
        end
    end
end
% - 3.1 - Finding the axes limited for a 2x2 super structure as in T
if crystal == "CUB-Oh" || crystal == "HEX-D6h" || crystal == "RHL-D3d" ||...
        crystal == "TET-D4h" || crystal == "ORC-D2h" || crystal == "MCL-C2h" ||...
        crystal == "TRI-Ci"
    Tlims = 1.04*[min(T(:,1)), max(T(:,1)), min(T(:,2)), max(T(:,2)), min(T(:,3)), max(T(:,3))];
elseif crystal == "ORCC-D2h" || crystal == "MCLC-C2h" || crystal == "BCC-Oh" ||...
        crystal == "BCT-D4h" || crystal == "ORCI-D2h" || crystal == "FCC-Oh" ||...
        crystal == "ORCF-D2h" 
    Tlims = 1.04*[-1*norm(T1), norm(T1), 0, 2*norm(T2),-1*norm(T3), norm(T3)];
end
%% 4 - Finding all vector paths to link all nearest neighbour points
Tnn = [];
% - Filing through all possible points given in the T-matrix
for i = 1:length(T)-1
    waitbar(i/length(T)-1, wbar, 'Extracting real-space lattice...', 'Name', 'extract_lattice');
    for j = i+1:length(T)
        % -- Finding the Euclidean distance between the two lattice points
        dist  = sqrt((T(i,1)-T(j,1)).^2+(T(i,2)-T(j,2)).^2+(T(i,3)-T(j,3)).^2);
        %% 4.1 - Applying geometrical constraints for nearest neighbour points
        
        % --- For the 7 Primitive (Simple) Bravais lattices
        % Points are linked if their distance is identical to the
        % length of T1, T2 or T3.
        if crystal_args{1} == "CUB-Oh" || crystal_args{1} == "HEX-D6h" || crystal_args{1} == "RHL-D3d" ||...
                crystal_args{1} == "TET-D4h" || crystal_args{1} == "ORC-D2h" || crystal_args{1} == "MCL-C2h" ||...
                crystal_args{1} == "TRI-Ci"
            if (abs(dist-norm(T1))) <= 0.0001 || (abs(dist-norm(T2))) <= 0.0001 || (abs(dist-norm(T3))) <= 0.0001                
                Tnn = vertcat(Tnn, [[T(i,1);T(j,1)], [T(i,2);T(j,2)], [T(i,3);T(j,3)]]);
            end
            
        % --- For the 2 Base-Centered Bravais Lattices
        % Points are linked if their distance is equal to the length
        % of the BCC basis vector. Also, if their length is equal to 
        % T1, T2 or T3, with the condition that it is not divisible by
        % the BCC basis vector (as the base-centered points are only
        % joined within the horizontal plane of the vertices).
        elseif crystal_args{1} == "ORCC-D2h" || crystal_args{1} == "MCLC-C2h" 
            if abs(dist-norm(Tb0(2,:))) <= 0.0001
                Tnn = vertcat(Tnn, [[T(i,1);T(j,1)], [T(i,2);T(j,2)], [T(i,3);T(j,3)]]);
            elseif (mod(T(i,2), 2*Tb0(2,2)) == 0 ||  abs(T(i,2)) <= 0.0001 ) && ((abs(dist-norm(T1))) <= 0.0001 || (abs(dist-norm(T2))) <= 0.0001 || (abs(dist-norm(T3))) <= 0.0001)
                Tnn = vertcat(Tnn, [[T(i,1);T(j,1)], [T(i,2);T(j,2)], [T(i,3);T(j,3)]]);
            end
            
        % --- For the 3 Body-Centered Bravais Lattices
        % Points are linked if their distance is equal to the length
        % of the BCC basis vector. Also, if their length is equal to 
        % T1, T2 or T3, with the condition that it is not divisible by
        % the BCC basis vector (as the body-centered points are only
        % joined radially outwards to vertices of unit cell).
        elseif crystal_args{1} == "BCC-Oh" || crystal_args{1} == "BCT-D4h" || crystal_args{1} == "ORCI-D2h"
            if abs(dist-norm(Tb0(2,:))) <= 0.0001
                Tnn = vertcat(Tnn, [[T(i,1);T(j,1)], [T(i,2);T(j,2)], [T(i,3);T(j,3)]]);
            elseif mod(T(i,3), 2*Tb0(2,3)) == 0 && ((abs(dist-norm(T1))) <= 0.0001 || (abs(dist-norm(T2))) <= 0.0001 || (abs(dist-norm(T3))) <= 0.0001)
                Tnn = vertcat(Tnn, [[T(i,1);T(j,1)], [T(i,2);T(j,2)], [T(i,3);T(j,3)]]);
            end
            
        % --- For the 2 Face-Centered Bravais Lattices
        % Points are linked if their distance is equal to the length
        % of the FCC basis vector, with the proviso that the two points
        % are coplanar and not an FCC point. This is applied along each
        % dimension. Furthermore, if their length is equal to T1, T2 or T3, 
        % with the condition that it is not divisible by the FCC basis vector
        % (as the face-centered points are only joined radially outwards to
        % vertices of unit cell, not to other FCC points).
        elseif crystal_args{1} == "FCC-Oh" || crystal_args{1} == "ORCF-D2h"
            if abs(dist-norm(Tb0(2,:))) <= 0.001 && abs(T(i,1)-T(j,1)) <= 0.001 && (abs(T(i,1)) <= 0.001 || mod(T(i,1), 2*Tb0(2,1)) == 0)
                Tnn = vertcat(Tnn, [[T(i,1);T(j,1)], [T(i,2);T(j,2)], [T(i,3);T(j,3)]]);
            elseif abs(dist-norm(Tb0(2,:))) <= 0.001 && abs(T(i,2)-T(j,2)) <= 0.001 && (abs(T(i,2)) <= 0.001 || mod(T(i,2), 2*Tb0(2,2)) == 0)
                Tnn = vertcat(Tnn, [[T(i,1);T(j,1)], [T(i,2);T(j,2)], [T(i,3);T(j,3)]]);
            elseif abs(dist-norm(Tb0(3,:))) <= 0.001 && abs(T(i,3)-T(j,3)) <= 0.001 && (abs(T(i,3)) <= 0.001 || mod(T(i,3), 2*Tb0(3,3)) == 0)
                Tnn = vertcat(Tnn, [[T(i,1);T(j,1)], [T(i,2);T(j,2)], [T(i,3);T(j,3)]]);
            elseif (abs(dist-norm(T1))) <= 0.0001 && abs(T(i,1)-T(j,1)) <= 0.001 && (abs(T(i,1)) <= 0.001 || mod(T(i,1), 2*Tb0(2,1)) == 0) && (abs(T(i,3)) <= 0.001 || mod(T(i,3), 2*Tb0(3,3)) == 0)
                Tnn = vertcat(Tnn, [[T(i,1);T(j,1)], [T(i,2);T(j,2)], [T(i,3);T(j,3)]]);
            elseif (abs(dist-norm(T2))) <= 0.0001 && abs(T(i,2)-T(j,2)) <= 0.001 && (abs(T(i,2)) <= 0.001 || mod(T(i,2), 2*Tb0(2,2)) == 0) && (abs(T(i,3)) <= 0.001 || mod(T(i,3), 2*Tb0(3,3)) == 0)
                Tnn = vertcat(Tnn, [[T(i,1);T(j,1)], [T(i,2);T(j,2)], [T(i,3);T(j,3)]]);
            end
            
        end
    end
end
%% 5 - Computing the Voronoi diagram, which is identical to the Wigner-Seitz cell
% - Calculating Voronoi diagram
[T_c, T_v] = voronoin(T); 
T_nx = T_c(T_v{floor(l/2)},:);
T_cell = convhulln(T_nx);
% - Defining the T_ws variable and shifting Wigner-Seitz cell to +T2
for i = 1:size(T_cell,1)
    Tws{i,1} = T_nx(T_cell(i,:),1)-T(floor(l/2),1)+T2(1);
    Tws{i,2} = T_nx(T_cell(i,:),2)-T(floor(l/2),2)+T2(2);
    Tws{i,3} = T_nx(T_cell(i,:),3)-T(floor(l/2),3)+T2(3);
end


%% A - Defining the reciprocal-space unit cell
% - A.1 - For simple and base-centered lattices, use T-vectors only
if crystal_args{1} == "CUB-Oh" || crystal_args{1} == "HEX-D6h" || crystal_args{1} == "RHL-D3d" ||...
        crystal_args{1} == "TET-D4h" || crystal_args{1} == "ORC-D2h" || crystal_args{1} == "MCL-C2h" ||...
        crystal_args{1} == "TRI-Ci" || crystal_args{1} == "ORCC-D2h" || crystal_args{1} == "MCLC-C2h"
    G1 = 2*pi*cross(T2,T3)/Tvol;
    G2 = 2*pi*cross(T3,T1)/Tvol;
    G3 = 2*pi*cross(T1,T2)/Tvol;
% - A.2 - For body- and face-centered lattices, scale by a factor of 2
elseif crystal_args{1} == "BCC-Oh" || crystal_args{1} == "BCT-D4h" || crystal_args{1} == "ORCI-D2h" ||...
        crystal_args{1} == "FCC-Oh" || crystal_args{1} == "ORCF-D2h"
    G1 = 4*pi*cross(T2,T3)/Tvol;
    G2 = 4*pi*cross(T3,T1)/Tvol;
    G3 = 4*pi*cross(T1,T2)/Tvol;
end
% -- Extracting the volume of reciprocal unit cell
Gvol = cross(G1,G2)*G3';
%% B - Extracting the corresponding Brilluoin Zone in reciprocal-space
% - B.1 - The 7 Primitive (Simple) Bravais lattices yield no basis
if crystal_args{1} == "CUB-Oh" || crystal_args{1} == "HEX-D6h" || crystal_args{1} == "RHL-D3d" ||...
        crystal_args{1} == "TET-D4h" || crystal_args{1} == "ORC-D2h" || crystal_args{1} == "MCL-C2h" ||...
        crystal_args{1} == "TRI-Ci"
    Gb0 = [0, 0, 0];
% - B.2 - The 2 Base-Centered Bravais Lattices turn into base-centered in reciprocal space
elseif crystal_args{1} == "ORCC-D2h" || crystal_args{1} == "MCLC-C2h"
    Gb0 = [0, 0, 0;...
        0.5*(G1+G2)];
% - B.3 - The 3 Body-Centered Bravais Lattice turns to FCC in reciprocal space
elseif crystal_args{1} == "BCC-Oh" || crystal_args{1} == "BCT-D4h" || crystal_args{1} == "ORCI-D2h"
    Gb0 = [0, 0, 0;...
        0.5*(G1+G2);...
        0.5*(G1+G3);...
        0.5*(G2+G3)];
% - B.4 - The 2 Face-Centered Bravais Lattices turns to BCC in reciprocal space
elseif crystal_args{1} == "FCC-Oh" || crystal_args{1} == "ORCF-D2h"
    Gb0 = [0, 0, 0;...
        0.5*(G1+G2+G3)];
end
%% C - Extracting the reciprocal-space lattice over multiple translations of G
l=1;
for i=-1:1
    for j=0:2
        for k=-1:1
            for n = 1:size(Gb0,1)
                G(l,:)=i*G1+j*G2+k*G3+Gb0(n,:);
                l=l+1;
            end
        end
    end
end
% - C.1 - Finding the axes limited for a 2x2 super structure as in G
if crystal == "CUB-Oh" || crystal == "HEX-D6h" || crystal == "RHL-D3d" ||...
        crystal == "TET-D4h" || crystal == "ORC-D2h" || crystal == "MCL-C2h" ||...
        crystal == "TRI-Ci"
    Glims = 1.04*[min(G(:,1)), max(G(:,1)), min(G(:,2)), max(G(:,2)), min(G(:,3)), max(G(:,3))];
elseif crystal == "ORCC-D2h" || crystal == "MCLC-C2h" || crystal == "BCC-Oh" ||...
        crystal == "BCT-D4h" || crystal == "ORCI-D2h" || crystal == "FCC-Oh" ||...
        crystal == "ORCF-D2h"
    Glims = 1.04*[-1*norm(G1), norm(G1), 0, 2*norm(G2),-1*norm(G3), norm(G3)];
end

%% D - Finding all vector paths to link all nearest neighbour points
Gnn = [];
% - Filing through all possible points given in the G-matrix
for i = 1:length(G)-1
    waitbar(i/length(G)-1, wbar, 'Extracting reciprocal-space lattice...', 'Name', 'extract_lattice');
    for j = i+1:length(G)
        % -- Finding the Euclidean distance between the two lattice points
        dist  = sqrt((G(i,1)-G(j,1)).^2+(G(i,2)-G(j,2)).^2+(G(i,3)-G(j,3)).^2);
        %% 4.1 - Applying geometrical constraints for nearest neighbour points
        
        % --- For the 7 Primitive (Simple) Reciprocal lattices
        % Points are linked if their distance is identical to the
        % length of G1, G2 or G3.
        if crystal_args{1} == "CUB-Oh" || crystal_args{1} == "HEX-D6h" || crystal_args{1} == "RHL-D3d" ||...
                crystal_args{1} == "TET-D4h" || crystal_args{1} == "ORC-D2h" || crystal_args{1} == "MCL-C2h" ||...
                crystal_args{1} == "TRI-Ci"
            if (abs(dist-norm(G1))) <= 0.0001 || (abs(dist-norm(G2))) <= 0.0001 || (abs(dist-norm(G3))) <= 0.0001                
                Gnn = vertcat(Gnn, [[G(i,1);G(j,1)], [G(i,2);G(j,2)], [G(i,3);G(j,3)]]);
            end
            
        % --- For the 2 Base-Centered Reciprocal Lattices
        % Points are linked if their distance is equal to the length
        % of the BCC basis vector. Also, if their length is equal to 
        % G1, G2 or G3, with the condition that it is not divisible by
        % the BCC basis vector (as the base-centered points are only
        % joined within the horizontal plane of the vertices).
        elseif crystal_args{1} == "ORCC-D2h" || crystal_args{1} == "MCLC-C2h" 
            if abs(dist-norm(Gb0(2,:))) <= 0.0001
                Gnn = vertcat(Gnn, [[G(i,1);G(j,1)], [G(i,2);G(j,2)], [G(i,3);G(j,3)]]);
            elseif (mod(G(i,2), 2*Gb0(2,2)) == 0 ||  abs(G(i,2)) <= 0.0001 ) && ((abs(dist-norm(G1))) <= 0.0001 || (abs(dist-norm(G2))) <= 0.0001 || (abs(dist-norm(G3))) <= 0.0001)
                Gnn = vertcat(Gnn, [[G(i,1);G(j,1)], [G(i,2);G(j,2)], [G(i,3);G(j,3)]]);
            end
            
        % --- For the 2 Body-Centered Reciprocal Lattices
        % Points are linked if their distance is equal to the length
        % of the BCC basis vector. Also, if their length is equal to 
        % G1, G2 or G3, with the condition that it is not divisible by
        % the BCC basis vector (as the body-centered points are only
        % joined radially outwards to vertices of unit cell).
        elseif crystal_args{1} == "FCC-Oh" || crystal_args{1} == "ORCF-D2h"
            if abs(dist-norm(Gb0(2,:))) <= 0.0001
                Gnn = vertcat(Gnn, [[G(i,1);G(j,1)], [G(i,2);G(j,2)], [G(i,3);G(j,3)]]);
            elseif (mod(G(i,3), 2*Gb0(2,3)) == 0 || abs(G(i,3)) <= 0.001) && ((abs(dist-norm(G1))) <= 0.0001 || (abs(dist-norm(G2))) <= 0.0001 || (abs(dist-norm(G3))) <= 0.0001)
                Gnn = vertcat(Gnn, [[G(i,1);G(j,1)], [G(i,2);G(j,2)], [G(i,3);G(j,3)]]);
            elseif (mod(G(i,2), 2*Gb0(2,2)) == 0 || abs(G(i,2)) <= 0.001) && ((abs(dist-norm(G1))) <= 0.0001 || (abs(dist-norm(G2))) <= 0.0001 || (abs(dist-norm(G3))) <= 0.0001)
                Gnn = vertcat(Gnn, [[G(i,1);G(j,1)], [G(i,2);G(j,2)], [G(i,3);G(j,3)]]);
            end
            
        % --- For the 3 Face-Centered Reciprocal Lattices
        % Points are linked if their distance is equal to the length
        % of the FCC basis vector, with the proviso that the two points
        % are coplanar and not an FCC point. This is applied along each
        % dimension. Furthermore, if their length is equal to G1, G2 or G3, 
        % with the condition that it is not divisible by the FCC basis vector
        % (as the face-centered points are only joined radially outwards to
        % vertices of unit cell, not to other FCC points).
        elseif crystal_args{1} == "BCC-Oh" || crystal_args{1} == "BCT-D4h" || crystal_args{1} == "ORCI-D2h"
            if abs(dist-norm(Gb0(2,:))) <= 0.001 && abs(G(i,1)-G(j,1)) <= 0.001 && (abs(G(i,1)) <= 0.001 || mod(G(i,1), 2*Gb0(2,1)) == 0)
                Gnn = vertcat(Gnn, [[G(i,1);G(j,1)], [G(i,2);G(j,2)], [G(i,3);G(j,3)]]);
            elseif abs(dist-norm(Gb0(2,:))) <= 0.001 && abs(G(i,2)-G(j,2)) <= 0.001 && (abs(G(i,2)) <= 0.001 || mod(G(i,2), 2*Gb0(2,2)) == 0)
                Gnn = vertcat(Gnn, [[G(i,1);G(j,1)], [G(i,2);G(j,2)], [G(i,3);G(j,3)]]);
            elseif abs(dist-norm(Gb0(3,:))) <= 0.001 && abs(G(i,3)-G(j,3)) <= 0.001 && (abs(G(i,3)) <= 0.001 || mod(G(i,3), 2*Gb0(3,3)) == 0)
                Gnn = vertcat(Gnn, [[G(i,1);G(j,1)], [G(i,2);G(j,2)], [G(i,3);G(j,3)]]);
            elseif (abs(dist-norm(G1))) <= 0.0001 && abs(G(i,1)-G(j,1)) <= 0.001 && (abs(G(i,1)) <= 0.001 || mod(G(i,1), 2*Gb0(2,1)) == 0) && (abs(G(i,3)) <= 0.001 || mod(G(i,3), 2*Gb0(3,3)) == 0)
                Gnn = vertcat(Gnn, [[G(i,1);G(j,1)], [G(i,2);G(j,2)], [G(i,3);G(j,3)]]);
            elseif (abs(dist-norm(G2))) <= 0.0001 && abs(G(i,2)-G(j,2)) <= 0.001 && (abs(G(i,2)) <= 0.001 || mod(G(i,2), 2*Gb0(2,2)) == 0) && (abs(G(i,3)) <= 0.001 || mod(G(i,3), 2*Gb0(3,3)) == 0)
                Gnn = vertcat(Gnn, [[G(i,1);G(j,1)], [G(i,2);G(j,2)], [G(i,3);G(j,3)]]);
            end
        end
    end
end
%% E - Computing the Voronoi diagram, which is identical to the First Brilluoin Zone
% - Calculating Voronoi diagram
[G_c, G_v] = voronoin(G); 
G_nx = G_c(G_v{floor(l/2)},:);
G_cell = convhulln(G_nx);
% - Defining the G_bz variable and shifting Brilluoin zone to +G2
for i = 1:size(G_cell,1)
    Gbz{i,1} = G_nx(G_cell(i,:),1)-G(floor(l/2),1)+G2(1);
    Gbz{i,2} = G_nx(G_cell(i,:),2)-G(floor(l/2),2)+G2(2);
    Gbz{i,3} = G_nx(G_cell(i,:),3)-G(floor(l/2),3)+G2(3);
end

%% Assigning the real- and reciprocal-information to MATLAB data structure
waitbar(1, wbar, 'Assigning real- and reciprocal-variables...', 'Name', 'extract_lattice');
% - Real-space information
realStr.crystal = crystal;
realStr.T1 = T1;
realStr.T2 = T2;
realStr.T3 = T3;
realStr.Tb0 = Tb0;
realStr.Tvol = Tvol;
realStr.T = T;
realStr.Tlims = Tlims;
realStr.Tnn = Tnn;
realStr.Tws = Tws;
% - Reciprocal-space information
reciStr.crystal = crystal;
reciStr.G1 = G1;
reciStr.G2 = G2;
reciStr.G3 = G3;
reciStr.Gb0 = Gb0;
reciStr.Gvol = Gvol;
reciStr.G = G;
reciStr.Glims = Glims;
reciStr.Gnn = Gnn;
reciStr.Gbz = Gbz;
%% Close wait-bar
close(wbar);

%% Figure summary of the real- and reciprocal-space structures
if plotFig == 1
    fig = figure(); set(fig, 'position', [1,1,950,650]);

    % - REAL-SPACE FIGURE
    subplot(1,2,1); hold on;
    % -- Plotting the axes lines
    line([min(T(:,1)), max(T(:,1))], [0 0], [0,0],  'Color', [0 0 0], 'LineWidth', 0.75, 'Linestyle', '--');
    line([0 0], [min(T(:,2)), max(T(:,2))], [0, 0], 'Color', [0 0 0], 'LineWidth', 0.75, 'Linestyle', '--');
    line([0 0], [0, 0], [min(T(:,3)), max(T(:,3))], 'Color', [0 0 0], 'LineWidth', 0.75, 'Linestyle', '--');
    % -- Plotting the translational real-space lattice vectors
    plot3([0,T1(1)],[0,T1(2)],[0,T1(3)], '-', 'linewidth', 3, 'color', [0.8, 0.3, 0.3]);
    plot3([0,T2(1)],[0,T2(2)],[0,T2(3)], '-', 'linewidth', 3, 'color', [0.8, 0.3, 0.3]);
    plot3([0,T3(1)],[0,T3(2)],[0,T3(3)], '-', 'linewidth', 3, 'color', [0.8, 0.3, 0.3]);
    % -- Plotting the multiple translations of the real-space vectors
    plot3(T(:,1),T(:,2),T(:,3),'b.','markersize',20);
    % -- Plotting all the nearest neighbour points
    for i = 1:2:size(Tnn,1)
        plot3([Tnn(i,1), Tnn(i+1,1)], [Tnn(i,2), Tnn(i+1,2)], [Tnn(i,3), Tnn(i+1,3)], 'k-', 'linewidth', 1);
    end
    % -- Plotting the Wigner-Seitz cell
    for i = 1:size(Tws,1)
        patch(Tws{i,1}, Tws{i,2}, Tws{i,3},[0.8 0.3 0.3], 'FaceAlpha',0.75, 'EdgeColor', 'none');
    end
    % -- Defining the axes properties
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
    % Axis labels, limits and ticks
    xlabel('$$ \bf  x (\AA) $$', 'Interpreter', 'latex');
    ylabel('$$ \bf  y (\AA) $$', 'Interpreter', 'latex');
    zlabel('$$ \bf  z (\AA) $$', 'Interpreter', 'latex');
    xticks(round(-10*norm(T1):norm(T1):10*norm(T1),2));
    yticks(round(-10*norm(T2):norm(T2):10*norm(T2),2));
    zticks(round(-10*norm(T3):norm(T3):10*norm(T3),2));
    % -- Modify the view
    view(3); camlight(-30,24);
    title_txt1 = sprintf("%s; Real; Wigner-Seitz", crystal);
    title(title_txt1);
    axis tight equal vis3d; rotate3d on;
    pbaspect([1,1,1]);
    axis(Tlims);

    % - RECIPROCAL-SPACE FIGURE
    subplot(1,2,2); hold on;
    % -- Plotting the axes lines
    line([min(G(:,1)), max(G(:,1))], [0 0], [0,0],  'Color', [0 0 0], 'LineWidth', 0.75, 'Linestyle', '--');
    line([0 0], [min(G(:,2)), max(G(:,2))], [0, 0], 'Color', [0 0 0], 'LineWidth', 0.75, 'Linestyle', '--');
    line([0 0], [0, 0], [min(G(:,3)), max(G(:,3))], 'Color', [0 0 0], 'LineWidth', 0.75, 'Linestyle', '--');
    % -- Plotting the translational real-space lattice vectors
    plot3([0,G1(1)],[0,G1(2)],[0,G1(3)], '-', 'linewidth', 3, 'color', [0.3, 0.8, 0.3]);
    plot3([0,G2(1)],[0,G2(2)],[0,G2(3)], '-', 'linewidth', 3, 'color', [0.3, 0.8, 0.3]);
    plot3([0,G3(1)],[0,G3(2)],[0,G3(3)], '-', 'linewidth', 3, 'color', [0.3, 0.8, 0.3]);
    % -- Plotting the multiple translations of the real-space vectors
    plot3(G(:,1),G(:,2),G(:,3),'b.','markersize',20);
    % -- Plotting all the nearest neighbour points
    for i = 1:2:size(Gnn,1)
        plot3([Gnn(i,1), Gnn(i+1,1)], [Gnn(i,2), Gnn(i+1,2)], [Gnn(i,3), Gnn(i+1,3)], 'k-', 'linewidth', 1);
    end
    % -- Plotting the first Brilluoin Zone
    for i = 1:size(Gbz,1)
        patch(Gbz{i,1}, Gbz{i,2}, Gbz{i,3},[0.3 0.8 0.3], 'FaceAlpha',0.75, 'EdgeColor', 'none');
    end
    % -- Defining the axes properties
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
    % Axis labels, limits and ticks
    xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
    ylabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex');
    zlabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex');
    xticks(round(-10*norm(G1):norm(G1):10*norm(G1),2));
    yticks(round(-10*norm(G2):norm(G2):10*norm(G2),2));
    zticks(round(-10*norm(G3):norm(G3):10*norm(G3),2));
    % -- Modify the view
    view(3); camlight(-30,24);
    title_txt2 = sprintf("%s; Reciprocal; Brilluoin Zone", crystal);
    title(title_txt2);
    axis tight  equal vis3d; rotate3d on;
    pbaspect([1,1,1]);
    axis(Glims);
end

% ---  Function to extract the Brilluoin zone overlay of the given crystal plane slice
function planeStr = extract_plane(reciStr, crystal_plane, plotFig)
% planeStr = extract_plane(reciStr, crystal_plane, plotFig)
%   This is a function that extracts the planar Brilluoin zone 
%   along the defined crystal plane (h,k,l) in miller indices notation.
%   This Brilluoin zone plane then represents the planar slice that
%   that is probed through via ARPES by changing the scan parameter.
%
%   IN:
%   -  reciStr               MATLAB data structure containing all reciprocal-space information below;
%   .(crystal):     string of the crystal type.
%   .(G1):            b1 primitive reciprocal vector.
%	.(G2):            b2 primitive reciprocal vector.
%   .(G3):            b3 primitive reciprocal vector.
%   .(Gb0):          atomic basis vectors in reciprocal space.
%	.(Gvol):          volume of the reciprocal-space unit cell.
%	.(G):               reciprocal lattice over multiple translations.
%	.(Glims):        axes limits in 3D for the lattice structure G.
%	.(Gnn):           linked lines between nearest neighbour reciprocal-points displayed in .(G).
%	.(Gbz):           First Brilluoin zone in reciprocal-space.
%   -   crystal_plane:  string of the crystal plane to extract in "(hkl)" format.
%   -   plotFig:            if 1, will plot figure summary, otherwise it wont.
%
%   OUT:
%   - planeStr          MATLAB data structure containing all BZ plane information below;
%   .(crystal):                        string of the crystal type.
%   .(crystal_plane):            string of the (h,k,l) plane extracted.
%	.(area):                           area of the planar BZ unit cell.
%   .(X):                     cell array of the x vertices of the planar BZ cell slice.
%   .(Y):                     cell array of the y vertices of the planar BZ cell slice.
%	.(gX):                  double of the reciprocal-tesselation vector in x.
%	.(gY):                  double of the reciprocal-tesselation vector in y.

%% Default parameters
if nargin < 3; plotFig = 0; end
if isempty(plotFig); plotFig = 0;  end
disp('-> Extracting plane slice of BZ...')
wbar = waitbar(0, 'Extracting BZ overlay...', 'Name', 'extract_plane');

%% Initialising the input variables
crystal = reciStr.crystal;
G1 =  reciStr.G1;
G2 =  reciStr.G2;
G3 =  reciStr.G3;
Gbz = reciStr.Gbz;
%% 1 - Extracting the First Brilluoin Zone boundary
% - Extracting the point cloud for the First Brilluoin Zone
x_pts = cell2mat(Gbz(:,1));
y_pts = cell2mat(Gbz(:,2));
z_pts = cell2mat(Gbz(:,3));
cloud_pts = [x_pts, y_pts, z_pts];
% - Projecting the point cloud onto the desired planar slice
% --- For the (100) plane
if crystal_plane == "(100)"
    proj_vec = [0,1,1];
    proj_pts = cloud_pts .* proj_vec;
    xpts1 = proj_pts(:,2);
    ypts1 = proj_pts(:,3);
% --- For the (010) plane
elseif crystal_plane == "(010)"
    proj_vec = [1,0,1];
    proj_pts = cloud_pts .* proj_vec;
    xpts1 = proj_pts(:,1);
    ypts1 = proj_pts(:,3);
% --- For the (001) plane
elseif crystal_plane == "(001)"
    proj_vec = [1,1,0];
    proj_pts = cloud_pts .* proj_vec;
    xpts1 = proj_pts(:,1);
    ypts1 = proj_pts(:,2);
% --- For the (110) plane
elseif crystal_plane == "(110)"
    proj_vec = [1,0,1];
    R = [cosd(45) -sind(45) 0; sind(45) cosd(45) 0; 0 0 1];
    cloud_pts = cloud_pts * R;
    proj_pts = cloud_pts .* proj_vec;
    xpts1 = proj_pts(:,1);
    ypts1 = proj_pts(:,3);
end
% - Shifting the boundary points to the origin
xpts1 = xpts1 - (max(xpts1(:))+min(xpts1(:)))/2;
ypts1 = ypts1 - (max(ypts1(:))+min(ypts1(:)))/2;

%% 2 - Creating the boundary Brilluoin Zone polygon and finding the area of a single zone
[b_indx, area] = boundary(xpts1, ypts1, 0.1);
xpts1 = xpts1(b_indx);
ypts1 = ypts1(b_indx);

%% 3 - Tessalating the polygons to get the overlay
l=1;
% Iterating over all (or most of!) reciprocal space
for i = -20:20
    for j = -20:20
        % -- For the (100) plane
        if crystal_plane == "(100)"
            % -- Applying the tessalated shifts
            X{l} = xpts1 + i*G2(2) + j*G3(2);
            Y{l} = ypts1 + i*G2(3) + j*G3(3);
        % -- For the (010) plane
        elseif crystal_plane == "(010)"
            % -- Applying the tessalated shifts
            X{l} = xpts1 + i*G1(1) + j*G3(1);
            Y{l} = ypts1 + i*G1(3) + j*G3(3);
        % -- For the (001) plane
        elseif crystal_plane == "(001)"
            % -- Applying the tessalated shifts
            X{l} = xpts1 + i*G1(1) + j*G2(1);
            Y{l} = ypts1 + i*G1(2) + j*G2(2);
        % -- For the (110) plane
        elseif crystal_plane == "(110)"
            % --- Extracting the shift vectors
            xshift = norm(0.5*G1 + 0.5*G2);
            yshift = norm(0.5*G3);
            % -- Applying the tessalated shifts
            if mod(i,2) == 1
                X{l} = xpts1 + i*xshift;
                Y{l} = ypts1 + yshift +  j*2*max(yshift);
            else
                X{l} = xpts1 + i*xshift;
                Y{l} = ypts1 + j*2*max(yshift);
            end
        end
        l = l + 1;  
    end
end
%% Assigning the overlay structure to a MATLAB structure
waitbar(1, wbar, 'Assigning the BZ overlay variables...', 'Name', 'extract_lattice');
% - Real-space information
planeStr.crystal = crystal;
planeStr.crystal_plane = crystal_plane;
planeStr.area = area;
planeStr.X = X;
planeStr.Y = Y;
if crystal_plane == "(100)"
    planeStr.gX = norm(G2);
    planeStr.gY = norm(G3);
elseif crystal_plane == "(010)"
    planeStr.gX = norm(G1);
    planeStr.gY = norm(G3);
elseif crystal_plane == "(001)"
    planeStr.gX = norm(G1);
    planeStr.gY = norm(G2);
elseif crystal_plane == "(110)"
    planeStr.gX = norm(G1 + G2);
    planeStr.gY = norm(G3);
end
%% Close wait-bar
close(wbar);
%% Figure summary of the real- and reciprocal-space structures
if plotFig == 1
    
    fig = figure(); set(fig, 'position', [1,1,950,650]);
    
    %% - RECIPROCAL-SPACE FIGURE
    subplot(1,2,1); hold on;
    % -- Plotting the axes lines
    line([min(reciStr.G(:,1)), max(reciStr.G(:,1))], [0 0], [0,0],  'Color', [0 0 0], 'LineWidth', 0.75, 'Linestyle', '--');
    line([0 0], [min(reciStr.G(:,2)), max(reciStr.G(:,2))], [0, 0], 'Color', [0 0 0], 'LineWidth', 0.75, 'Linestyle', '--');
    line([0 0], [0, 0], [min(reciStr.G(:,3)), max(reciStr.G(:,3))], 'Color', [0 0 0], 'LineWidth', 0.75, 'Linestyle', '--');
    % -- Plotting the translational real-space lattice vectors
    plot3([0,reciStr.G1(1)],[0,reciStr.G1(2)],[0,reciStr.G1(3)], '-', 'linewidth', 3, 'color', [0.3, 0.8, 0.3]);
    plot3([0,reciStr.G2(1)],[0,reciStr.G2(2)],[0,reciStr.G2(3)], '-', 'linewidth', 3, 'color', [0.3, 0.8, 0.3]);
    plot3([0,reciStr.G3(1)],[0,reciStr.G3(2)],[0,reciStr.G3(3)], '-', 'linewidth', 3, 'color', [0.3, 0.8, 0.3]);
    % -- Plotting the multiple translations of the real-space vectors
    plot3(reciStr.G(:,1),reciStr.G(:,2),reciStr.G(:,3),'b.','markersize',20);
    % -- Plotting all the nearest neighbour points
    for i = 1:2:size(reciStr.Gnn,1)
        plot3([reciStr.Gnn(i,1), reciStr.Gnn(i+1,1)], [reciStr.Gnn(i,2), reciStr.Gnn(i+1,2)], [reciStr.Gnn(i,3), reciStr.Gnn(i+1,3)], 'k-', 'linewidth', 1);
    end
    % -- Plotting the first Brilluoin Zone
    for i = 1:size(reciStr.Gbz,1)
        patch(reciStr.Gbz{i,1}, reciStr.Gbz{i,2}, reciStr.Gbz{i,3},[0.3 0.8 0.3], 'FaceAlpha',0.75, 'EdgeColor', 'none');
    end
    % -- Plotting a path of the brilluoin zone slice
    xP = [-1e3, 1e3, 1e3, -1e3, -1e3];
    yP = [1e3, 1e3, -1e3, -1e3, 1e3];
    zP = [0, 0, 0, 0, 0];
    if crystal_plane == "(100)"
        patch(zP, xP, yP, [0.7, 0.7, 0.7], 'FaceAlpha',0.75, 'EdgeColor', 'none');
    elseif crystal_plane == "(010)"
        patch(xP, zP+reciStr.G2(2), yP, [0.7, 0.7, 0.7], 'FaceAlpha',0.75, 'EdgeColor', 'none');
    elseif crystal_plane == "(001)"
        patch(xP, yP, zP, [0.7, 0.7, 0.7], 'FaceAlpha',0.75, 'EdgeColor', 'none');
    elseif crystal_plane == "(110)"
        xP = [1e3, 1e3, -1e3, -1e3, 1e3];
        yP = [1e3, 1e3, -1e3, -1e3, 1e3]+reciStr.G2(2);
        zP = [-1e3, 1e3, 1e3, -1e3, -1e3];
        patch(xP, yP, zP, [0.7, 0.7, 0.7], 'FaceAlpha',0.75, 'EdgeColor', 'none');
    end
    % -- Defining the axes properties
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
    % Axis labels, limits and ticks
    xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
    ylabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex');
    zlabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex');
    xticks(round(-10*norm(G1):norm(G1):10*norm(G1),2));
    yticks(round(-10*norm(G2):norm(G2):10*norm(G2),2));
    zticks(round(-10*norm(G3):norm(G3):10*norm(G3),2));
    % -- Modify the view
    view(3); camlight(-30,24);
    title_txt2 = sprintf("%s; Reciprocal; Brilluoin Zone", crystal);
    title(title_txt2);
    axis tight equal; rotate3d on;
    pbaspect([1,1,1]);
    axis(reciStr.Glims);
    
    %% - BRILLUOIN ZONE PLANAR SLICE
    subplot(1,2,2); hold on;
    for i = 1:size(X, 2)
        plot(X{i}, Y{i}, 'k-','linewidth', 2);
    end
    % -- Defining the axes properties
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
    ax.YAxisLocation = 'right';                   % 'left' | 'right' | 'origin'
    % Box Styling properties
    ax.LineWidth = 1.5;
    ax.Box = 'off'; ax.Layer = 'Top';
    % Axis labels, limits and ticks
    title_txt = sprintf("BZ plane; %s", crystal_plane);
    title(title_txt);
    axis equal;
    if crystal_plane == "(100)"
        xlabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex');
        ylabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex');
    elseif crystal_plane == "(010)"
        xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
        ylabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex');
    elseif crystal_plane == "(001)"
        xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
        ylabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex');
    elseif crystal_plane == "(110)"
        xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
        ylabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex');
    end
    xticks(round(-10*planeStr.gX:0.5*planeStr.gX:10*planeStr.gX,2));
    yticks(round(-10*planeStr.gY:0.5*planeStr.gY:10*planeStr.gY,2));
    axis([-planeStr.gX, planeStr.gX, -planeStr.gY, planeStr.gY]*1.05);
end

% ---  Function to extract the Iso-surface given the slice range
function dataStr = surface_area_calc(dataStr, sa_args)
% dataStr = surface_area_calc(dataStr, sa_args)
%   This function determines the area over some threshold that is defined
%   by the user, which can be used to sub-sequentially determine the
%   Luttinger Area for number density calculations.
%
%   REQ. FUNCTIONS: none
%
%   IN:
%   dataStr - loaded MATLAB data structure.
%   -   dataStr{i}.isoe:        contains the i'th isoe data for the i'th file loaded.
%   -   sa_args:                    {1x2} cell-array of {minArea, maxThresh}
%
%   OUT:
%   dataStr{i} - expanded MATLAB data structure containing the new elements for the i'th file loaded.
%   .(isoe.x_bound):            column vectors of the x-domain of the bounded polygon of ARPES scan.
%   .(isoe.y_bound):            column vectors of the y-domain of the bounded polygon of ARPES scan.
%	.(isoe.areaScan):           the total area of the ARPES scan.
%   .(isoe.areaThresh):       the area over the defined data threshold.
%   .(isoe.rho_LV):               estimation of the number density based on the threshold.

disp('Luttinger Area determination...')

%% 1 - Determination of the maximum value of the intensity over all isoe scans
for i = 1:length(dataStr); max_d(i) = max(dataStr{i}.isoe.DSlice(:)); end
max_d = max(max_d(:));

%% 2 - Iterating through all the data structures
for i = 1:length(dataStr)
    %% Initialisation
    if isfield(dataStr{i}.isoe, 'xScan'); dataStr{i}.isoe = rmfield(dataStr{i}.isoe, 'xScan'); end
    if isfield(dataStr{i}.isoe, 'yScan'); dataStr{i}.isoe = rmfield(dataStr{i}.isoe, 'yScan'); end
    if isfield(dataStr{i}.isoe, 'areaScan'); dataStr{i}.isoe = rmfield(dataStr{i}.isoe, 'areaScan'); end
    if isfield(dataStr{i}.isoe, 'xCont'); dataStr{i}.isoe = rmfield(dataStr{i}.isoe, 'xCont'); end
    if isfield(dataStr{i}.isoe, 'yCont'); dataStr{i}.isoe = rmfield(dataStr{i}.isoe, 'yCont'); end
    if isfield(dataStr{i}.isoe, 'areaCont'); dataStr{i}.isoe = rmfield(dataStr{i}.isoe, 'areaCont'); end
    
    % -- Defining the x-, y- and z-matrices
    x = dataStr{i}.isoe.XSlice;
    y = dataStr{i}.isoe.YSlice;
    d = dataStr{i}.isoe.DSlice;
    
    %% 2.1 - Calculating the total area of the ARPES scan
    % -- Determination of the total area of the ARPES scan
    x_vect = x(:);
    y_vect = y(:);
    [k, area] = boundary(x_vect, y_vect, 0.5);
    plot(x_vect(k),y_vect(k), '-', 'color', [0,0.8,0.8,0.8], 'linewidth', 2);
    % -- Assigning the values to the data-structure
    dataStr{i}.isoe.xScan = x_vect(k);
    dataStr{i}.isoe.yScan = y_vect(k);
    dataStr{i}.isoe.areaScan = area;
    
    %% 2.2 - Calculating the contour threshold of the IsoE surface
    % - Extracting and plotting the filled contour plot
    [~, h] = contour(x, y, d, [1, 1]*sa_args{2}*max_d,...
        'edgecolor', 'none', 'linewidth', 2, 'linestyle', '-');
    % - Finding the areas contained within all contours
    n = 0; ii = 1;
    sz = size(h.ContourMatrix, 2);
    if ~isempty(h.ContourMatrix)
        nn(1) = h.ContourMatrix(2,1);
        xx{1} = h.ContourMatrix(1,2:nn(1)+1);
        yy{1} = h.ContourMatrix(2,2:nn(1)+1);
        areaThresh(1) = polyarea(xx{1},yy{1});
        while n+nn(ii)+ii < sz
            n = n + nn(ii);
            ii = ii + 1;
            nn(ii)=h.ContourMatrix(2,n+ii);
            xx{ii} = h.ContourMatrix(1,n+ii+1:n+nn(ii)+ii);
            yy{ii} = h.ContourMatrix(2,n+ii+1:n+nn(ii)+ii);
            areaThresh(ii) = polyarea(xx{ii}, yy{ii});
        end
    else
        areaThresh = 0;
    end
    
    %% 3 - Appling the limitations from the minimum area
    indx = find(areaThresh > sa_args{1});
    j = 1;
    for n = indx
        dataStr{i}.isoe.xCont{j} = xx{n};
        dataStr{i}.isoe.yCont{j} = yy{n};
        dataStr{i}.isoe.areaCont(j) = areaThresh(n);
        j = j + 1;
    end
    dataStr{i}.isoe.areaThresh = sum(dataStr{i}.isoe.areaCont(:));
    %% 4 - Plotting the contours that are used
    for n = 1:length(dataStr{i}.isoe.areaCont)
        plot(dataStr{i}.isoe.xCont{n}, dataStr{i}.isoe.yCont{n}, 'color', [0.1,0.7,0.1], 'linewidth', 2, 'linestyle', '-');
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INTERNAL PLOT FUNCTIONS %%%%%%%%%%%%%%%%
% ---  Function to plot the final 2D figure of the isoe data
function view_final(dataStr, bzStr, final_fig_args)
% view_final(dataStr, bzStr, final_fig_args)
%   This function plots the final ARPES isoe surface, with numerous
%   constraints placed on the figure and axes properties, so a paper
%   quality figure can be extracted.
%
%   REQ. FUNCTIONS:
%   -   [h=] ImData(X,Y,Z[,style])
%
%   IN:
%   -   isoeStr:         data structure of the isoe ARPES data.
%   -   bzStr:            data structure of the Brilluoin Zone.
%   -   final_fig_args:	1x8 cell of {cMap, cLims,axLims, axCol, backCol, BZoutline, BZwidth, BZon}.
%
%   OUT:
%   -   figure output

%% Initialising variables
cMap = final_fig_args{1};
cLims = final_fig_args{2};
axCol = final_fig_args{3};
axLims = final_fig_args{4};
axisOn = final_fig_args{5};
gridOn = final_fig_args{6};
scanOn = final_fig_args{7};
backCol = final_fig_args{8};
bzOn = final_fig_args{9};
bzCol = final_fig_args{10};
bzWidth = final_fig_args{11};
interpData = final_fig_args{12};

%% 1 - Opening a new figure object
hold on;
%% 2 - Plotting the IsoE slices taken
if interpData == 1
    for i = 1:length(dataStr); ImData(dataStr{i}.isoe.XSlice, dataStr{i}.isoe.YSlice, dataStr{i}.isoe.DSlice, 'interp'); end
else
    for i = 1:length(dataStr); ImData(dataStr{i}.isoe.XSlice, dataStr{i}.isoe.YSlice, dataStr{i}.isoe.DSlice); end
end
%% 4 - Plotting the Brilluoin Zone overlay
if bzOn == 1
    for i = 1:size(bzStr.X, 2)
        plot(bzStr.X{i}, bzStr.Y{i}, '-', 'color', bzCol, 'linewidth', bzWidth);
    end
    xticks(round(-20*bzStr.gX:bzStr.gX/2:20*bzStr.gX,2));
    yticks(round(-20*bzStr.gY:bzStr.gY/2:20*bzStr.gY,2));
end
%% 5 - Applying color and axes limits, grid- and axes-lines
axis equal;
colormap(cMap); caxis(cLims); axis(axLims);
if axisOn == 1 
    line([0 0], [-1e5, 1e5], 'Color', axCol, 'LineWidth', 1, 'Linestyle', '--');
    line([-1e5, 1e5], [0 0], 'Color', axCol, 'LineWidth', 1, 'Linestyle', '--');
end
if gridOn == 1; grid on; end
%% 6 - Other general formatting
% -- Defining the axes properties
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
ax.Color = backCol;
ax.LineWidth = 1.5;
ax.Box = 'off'; ax.Layer = 'Top';
% Labelling the axes depending on what scan parameter is is taken
xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
if dataStr{1}.isoe.Type == "Eb(kx,ky)";  ylabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex'); 
elseif dataStr{1}.isoe.Type == "Eb(kx,kz)"; ylabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex'); 
end
fig = gcf;
% Window properties
fig.Color = [1 1 1]; fig.InvertHardcopy = 'off';

%% 7 - Adding additional y-axis for the scan parameter
if scanOn == 1
    scanAxis = [];
    for i = 1:length(dataStr); scanAxis = horzcat(scanAxis, dataStr{i}.isoe.scanAxis); end
    scanAxis = [min(scanAxis(:)), max(scanAxis(:))];
    yyaxis right;
    ylim([scanAxis(1), scanAxis(2)]);
    if dataStr{1}.isoe.Type == "Eb(kx,ky)"
        ylabel('$$ \bf  \tau (^{\circ}) $$', 'Interpreter', 'latex'); 
        yticks(round(scanAxis(1),-1):1:2*scanAxis(2));
    elseif dataStr{1}.isoe.Type == "Eb(kx,kz)"
        ylabel('$$ \bf  hv (eV) $$', 'Interpreter', 'latex'); 
        yticks(round(scanAxis(1),-1):100:2*scanAxis(2));
    end
    ax = gca;
    ax.YColor = [0.2 0.2 0.7]; ax.XMinorTick = 'on'; ax.YMinorTick = 'on';
end
%% 8 - Colorbar properties
cb = colorbar; 
% --- Colorbar font properties
cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 12;
% --- Colorbar tick properties
cb.TickLabelInterpreter = 'latex';
cb.TickLength = 0.04; cb.TickDirection = 'out';
% --- Colorbar position properties
cb.Position = [0.93 0.83 0.02 0.07];
% --- Colorbar box properties
cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;

% ---  Function to plot the isoe video of the ARPES data
function view_slicevideo(dataStr, bzStr, final_fig_args, arpesVideo_args)
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

%% Initialising variables
% - Slice video variables
sliceLims = arpesVideo_args{1};
sliceWin = arpesVideo_args{2};
% - Final figure variables
cMap = final_fig_args{1};
cLims = final_fig_args{2};
axCol = final_fig_args{3};
axLims = final_fig_args{4};
axisOn = final_fig_args{5};
gridOn = final_fig_args{6};
scanOn = final_fig_args{7};
backCol = final_fig_args{8};
bzOn = final_fig_args{9};
bzCol = final_fig_args{10};
bzWidth = final_fig_args{11};
interpData = final_fig_args{12};

%% Initialisation to save the video as a .avi file
filter = {'*.avi'};
[save_filename, save_filepath] = uiputfile(filter);
fname = char(string(save_filepath) + string(save_filename));
% If Cancel is pressed, then return nothing
if isequal(save_filepath,0) || isequal(save_filename,0); return; end
% Else proceed with the video plotting
disp('-> Plotting IsoE video...')
 %% 1 - Initialising variables for slice video
 % - Initialising window parameters
WinLims = sort(sliceLims);
stepsize = sliceWin;
iWin = WinLims(2) + [-0.5, 0.5]*stepsize; 
% - Initialising video parameters
nFrames = round((WinLims(2) - WinLims(1))/(2*stepsize), 0)+1;
vidObj = VideoWriter(fname);
vidObj.FrameRate = 10;
open(vidObj);
% - Open and freeze the figure axes
fig = figure(); set(fig, 'Name', 'IsoSlice Video', 'Position', [1,1,700,750]);

%% 2 - Running the slice video frame by frame
for f = 1:nFrames 
    %% 2.1 INITIALISING FIGURE AND SLICE WINDOW
    % - Finding the next iteration of the slice window
    Win = iWin-(f-1)*2*stepsize;
    % - Reset the figure
    cla reset; clf reset; delete(findall(gcf,'type','annotation'))
    % - Extracting the mean slice range as a string
    scanVal =  sprintf('$$ \\bf E_B = %.2f eV $$', mean(Win));
    %% 2.2 EXTRACTING THE ISOE SLICES
    for i = 1:length(dataStr)
        % - Extracting the fields to be used
        % Defining the x, y and d-fields
        xField = 'kx';  yField = 'eb';  dField = 'data';
        if dataStr{i}.Type == "Eb(kx,ky)"; zField = 'ky';
        elseif dataStr{i}.Type == "Eb(kx,kz)"; zField = 'kz';
        end
        % - Extracting the IsoE slices
        [DSlice{i}, XSlice{i}] = Slice(dataStr{i}.(xField), dataStr{i}.(yField), dataStr{i}.(dField), 'IsoE', Win);
        % - Extracting the scan parameter variables
        if isfield(dataStr{i}, 'kx'); init = ceil(0.5*size(dataStr{i}.(dField), 2)); YSlice{i} = squeeze(dataStr{i}.(zField)(init,:,:))';
        else; YSlice{i} = squeeze(dataStr{i}.(zField))';
        end
    end
    %% 2.3 PLOTTING THE ISOE SLICES
    hold on;
    if interpData == 1
        for i = 1:length(dataStr); ImData(XSlice{i}, YSlice{i}, DSlice{i}, 'interp'); end
    else
        for i = 1:length(dataStr); ImData(XSlice{i}, YSlice{i}, DSlice{i}); end
    end
    %% 2.4 Plotting the Brilluoin Zone overlay
    if bzOn == 1
        for i = 1:size(bzStr.X, 2)
            plot(bzStr.X{i}, bzStr.Y{i}, '-', 'color', bzCol, 'linewidth', bzWidth);
        end
        xticks(round(-20*bzStr.gX:bzStr.gX/2:20*bzStr.gX,2));
        yticks(round(-20*bzStr.gY:bzStr.gY/2:20*bzStr.gY,2));
    end
    %% 2.5 Applying color and axes limits, grid- and axes-lines
    axis equal;
    colormap(cMap); caxis(cLims); axis(axLims);
    if axisOn == 1 
        line([0 0], [-1e5, 1e5], 'Color', axCol, 'LineWidth', 1, 'Linestyle', '--');
        line([-1e5, 1e5], [0 0], 'Color', axCol, 'LineWidth', 1, 'Linestyle', '--');
    end
    if gridOn == 1; grid on; end
    %% 2.6 Other general formatting
    % -- Defining the axes properties
    ax = gca;
    % Font properties
    ax.FontName = 'Helvetica'; ax.FontWeight = 'normal'; ax.FontSize = 20;
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
    ax.Color = backCol;
    ax.LineWidth = 1.5;
    ax.Box = 'off'; ax.Layer = 'Top';
    % Labelling the axes depending on what scan parameter is is taken
    xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
    if dataStr{1}.isoe.Type == "Eb(kx,ky)";  ylabel('$$ \bf  k_y (\AA^{-1}) $$', 'Interpreter', 'latex'); 
    elseif dataStr{1}.isoe.Type == "Eb(kx,kz)"; ylabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex'); 
    end
    fig = gcf;
    % Window properties
    fig.Color = [1 1 1]; fig.InvertHardcopy = 'off';
    % - Add annotation of the scan parameter
    text_pos = [0.15 0.15 0.22 0.06];
    annotation('textbox', text_pos, 'String',scanVal, 'FitBoxToText','on',...
        'color', [0 0 0], 'fontsize', 13, 'backgroundcolor', [1 1 1], 'facealpha', 0.8,...
        'linewidth', 2, 'horizontalalignment', 'center', 'verticalalignment', 'middle',...
        'interpreter', 'latex');
    %% 2.7 Adding additional y-axis for the scan parameter
    if scanOn == 1
        scanAxis = [];
        for i = 1:length(dataStr); scanAxis = horzcat(scanAxis, dataStr{i}.isoe.scanAxis); end
        scanAxis = [min(scanAxis(:)), max(scanAxis(:))];
        yyaxis right;
        ylim([scanAxis(1), scanAxis(2)]);
        if dataStr{1}.isoe.Type == "Eb(kx,ky)"
            ylabel('$$ \bf  \tau (^{\circ}) $$', 'Interpreter', 'latex'); 
            yticks(round(scanAxis(1),-1):1:2*scanAxis(2));
        elseif dataStr{1}.isoe.Type == "Eb(kx,kz)"
            ylabel('$$ \bf  hv (eV) $$', 'Interpreter', 'latex'); 
            yticks(round(scanAxis(1),-1):100:2*scanAxis(2));
        end
        ax = gca;
        ax.YColor = [0.2 0.2 0.7]; ax.XMinorTick = 'on'; ax.YMinorTick = 'on';
    end
    %% 2.8 Colorbar properties
    cb = colorbar; 
    % --- Colorbar font properties
    cb.FontName = 'Helvetica'; cb.FontWeight = 'normal'; cb.FontSize = 12;
    % --- Colorbar tick properties
    cb.TickLabelInterpreter = 'latex';
    cb.TickLength = 0.04; cb.TickDirection = 'out';
    % --- Colorbar position properties
    cb.Position = [0.93 0.83 0.02 0.07];
    % --- Colorbar box properties
    cb.Color = [0 0 0]; cb.Box = 'on'; cb.LineWidth = 1.2;
    %% Adding the current figure as a frame to the video dataObject
    mov = getframe(gcf);        %add current figure as frame
    writeVideo(vidObj,mov);     %write frame to vidObj
end
close(vidObj);
disp('-> Finished plotting IsoE video...')

% ---  Function to plot a line-profile
function view_lineprofile(dataStr, lineprof_args)


%% Initialising variables
% Set random color for the line profile
col = rand(1,3);
% Determine the x-axis limits for the type of profile to image
for i = 1:length(dataStr)
    xTemp(i,:) = dataStr{i}.isoe.xLims;
    yTemp(i,:) = dataStr{i}.isoe.yLims;
end
xLims(1) = min(min(xTemp)); xLims(2) = max(max(xTemp));
yLims(1) = min(min(yTemp));  yLims(2) = max(max(yTemp));
% Determine the window for the line profile integral
Win = lineprof_args{2} + [-lineprof_args{3}, +lineprof_args{3}];

%% 1 - Plotting the line profile over the ARPES IsoE slice
if lineprof_args{1} == "horizontal"
    % Finding the x- and y-values of the line profile
    x = [xLims(1), xLims(2), xLims(2), xLims(1)];
    y = [Win(1), Win(1), Win(2), Win(2)];
    hold on;
    % -- Plotting the line profile patch
    patch(x, y, col, 'edgecolor', 'none', 'facealpha', 0.2);
    plot(x, y, '-', 'linewidth', 2, 'color', col);
    % -- Adding text to identify the line
    text(mean(x(:)), mean(y(:)), sprintf("%.3f ± %.3f", lineprof_args{2}, lineprof_args{3}),...
        'color', col, 'Fontsize', 12, 'horizontalalignment', 'center');
elseif lineprof_args{1} == "vertical"
    % Finding the x- and y-values of the line profile
    x = [Win(1), Win(1), Win(2), Win(2)];
    y = [yLims(1), yLims(2), yLims(2), yLims(1)];
    hold on;
    % -- Plotting the line profile patch
    patch(x, y, col, 'edgecolor', 'none', 'facealpha', 0.2);
    plot(x, y, '-', 'linewidth', 1, 'color', col);
    % -- Adding text to identify the line
    text(mean(x(:)), mean(y(:)), sprintf("%.3f ± %.3f", lineprof_args{2}, lineprof_args{3}),...
        'color', col, 'Fontsize', 12, 'horizontalalignment', 'center');
end
%% 2 - Plotting the line profile to be appended
% - Extracting the line profiles
for i = 1:length(dataStr)
    if lineprof_args{1} == "horizontal"
        subplot(222); hold on;
        [XCut{i}, DCut{i}] = Cut(dataStr{i}.isoe.XSlice,dataStr{i}.isoe.YSlice,dataStr{i}.isoe.DSlice,'mdc',Win);
        xlim([xLims(1), xLims(2)]);
        title('horizontal cuts');
    elseif lineprof_args{1} == "vertical"
        subplot(224); hold on;
        [XCut{i}, DCut{i}] = Cut(dataStr{i}.isoe.XSlice,dataStr{i}.isoe.YSlice,dataStr{i}.isoe.DSlice,'edc',Win);
        xlim([yLims(1), yLims(2)]);
        title('vertical cuts');
    end
end
% - Plotting the line profiles
if lineprof_args{1} == "horizontal"
    for i = 1:length(dataStr)
        if ~isempty(XCut{i}); plot(XCut{i}, DCut{i}, '.-', 'color', col, 'linewidth', 1.5); end
    end
elseif lineprof_args{1} == "vertical"
    for i = 1:length(dataStr)
        if ~isempty(XCut{i}); plot(XCut{i}, DCut{i}, '.-', 'color', col, 'linewidth', 1.5); end
    end
end
% Figure formating
% -- Defining the axes properties
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
ax.Box = 'on'; ax.Layer = 'Top';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% The End %%%%%%%%%%%%%%%%%%%
