function varargout = bz_navigation(varargin)
% bz_navigation MATLAB code for bz_navigation.fig
%      BZ_NAVIGATION, by itself, creates a new BZ_NAVIGATION or raises the existing
%      singleton*.
%
%      H = BZ_NAVIGATION returns the handle to a new BZ_NAVIGATION or the handle to
%      the existing singleton*.
%
%      BZ_NAVIGATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BZ_NAVIGATION.M with the given input arguments.
%
%      BZ_NAVIGATION('Property','Value',...) creates a new BZ_NAVIGATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bz_navigation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bz_navigation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bz_navigation

% Last Modified by GUIDE v2.5 04-Dec-2018 13:29:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bz_navigation_OpeningFcn, ...
                   'gui_OutputFcn',  @bz_navigation_OutputFcn, ...
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
% --- Executes just before bz_navigation is made visible.
function bz_navigation_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bz_navigation (see VARARGIN)

%% 1 - Setting the native size of the whole GUI figure
screen_size = get(0,'ScreenSize');
screen_size(3) = 390;
screen_size(4) = 500;
set(handles.figure1,'Units','Pixels','Position',screen_size, 'name', 'bz_navigation');
%% 2 - Showing the ARPES geometry figure
% - Read in the image file
IS=imread('arpes_geometry.png');
% - Plot the image of the ARPES geometry
image(IS); axis image off;
%% 3 - Setting the IMFP and Kz broadening
eKE = handles.navi_args.hv - handles.navi_args.ePhi + handles.navi_args.eBref;
imfp = 10 .* (143 ./ eKE .^2 + 0.054.*sqrt(eKE));
dkz = 1 ./ imfp;
imfp_str = sprintf(round(imfp, 3) + "A");
dkz_str = sprintf(round(dkz, 3) + "A^-1");
set(handles.text_imfp,'String', imfp_str);
set(handles.text_dkz,'String', dkz_str);
%% Choose default command line output for bz_navigation
handles.output = hObject;
%% Save the handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = bz_navigation_OutputFcn(hObject, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)

%% Get default command line output from handles structure
varargout{1} = handles.output;

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
close(gcbf); run bz_navigation;

% --- Executes on button press in pushbutton_RESIZEGUI.
function pushbutton_RESIZEGUI_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_RESIZEGUI (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Resetting the native size of the whole GUI figure
screen_size = get(0, 'ScreenSize');
screen_pos = get(gcf, 'Position');
screen_size(1) = screen_pos(1);
screen_size(2) = screen_pos(2);
screen_size(3) = 390;
screen_size(4) = 500;
set(handles.figure1,'Units','Pixels','Position',screen_size, 'name', 'bz_navigation');
%% Update handles structure
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% BRILLUOIN ZONE EXTRACTION  %%%%%%%%%%%%

% --- Executes on selection change in popupmenu_crystal.
function popupmenu_crystal_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_crystal (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
contents = cellstr(get(hObject,'String'));
data_entry = contents{get(hObject,'Value')};
handles.crystal_args{1} = data_entry;
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
fprintf("--> Crystal: " + handles.crystal_args{1} + " \n");
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
handles.crystal_args{1} = string(contents{3});
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
if handles.crystal_args{1} == "CUB-Oh" || handles.crystal_args{1} == "BCC-Oh" || handles.crystal_args{1} == "FCC-Oh"
    % - Applying condition that a(nm) must be equal to b(nm) and c(nm)
    if data_entry ~= handles.crystal_args{2}(2); handles.crystal_args{2}(2) = data_entry; end
    if data_entry ~= handles.crystal_args{2}(3); handles.crystal_args{2}(3) = data_entry; end
% For 'HEX' crystal
elseif handles.crystal_args{1} == "HEX-D6h"
    % - Applying condition that a(nm) must be equal to b(nm)
    if data_entry ~= handles.crystal_args{2}(2); handles.crystal_args{2}(2) = data_entry; end
% For 'RHL' crystal
elseif handles.crystal_args{1} == "RHL-D3d"
    % - Applying condition that a(nm) must be equal to b(nm) and c(nm)
    if data_entry ~= handles.crystal_args{2}(2); handles.crystal_args{2}(2) = data_entry; end
    if data_entry ~= handles.crystal_args{2}(3); handles.crystal_args{2}(3) = data_entry; end
% For 'TET' and 'BCT' crystal
elseif handles.crystal_args{1} == "TET-D4h" || handles.crystal_args{1} == "BCT-D4h"
    % - Applying condition that a(nm) cannot equal c(nm), but must equal b(nm)
    if data_entry == handles.crystal_args{2}(3); data_entry = data_entry-0.001; end
    if data_entry ~= handles.crystal_args{2}(2); handles.crystal_args{2}(2) = data_entry; end
% For 'ORC', 'ORCC', 'ORCI' and 'ORCF' crystal
elseif handles.crystal_args{1} == "ORC-D2h" || handles.crystal_args{1} == "ORCC-D2h" || handles.crystal_args{1} == "ORCI-D2h" || handles.crystal_args{1} == "ORCF-D2h"
    % - Applying condition that a(nm) cannot equal b(nm) or c(nm)
    if data_entry == handles.crystal_args{2}(2); data_entry = data_entry-0.001; end
    if data_entry == handles.crystal_args{2}(3); data_entry = data_entry-0.001; end
% For 'MCL' and 'MCLC' crystal
elseif handles.crystal_args{1} == "MCL-C2h" || handles.crystal_args{1} == "MCLC-C2h"
    % - Applying condition that a(nm) cannot equal c(nm)
    if data_entry == handles.crystal_args{2}(3); data_entry = data_entry-0.001; end
% For 'TRI' crystal
elseif handles.crystal_args{1} == "TRI-Ci"
    % - No conditions for the 'TRI' crystal for a(nm)
end
%% 3 - Printing the change that has occured
handles.crystal_args{2}(1) = data_entry;
set(hObject,'String', string(handles.crystal_args{2}(1))); 
set(handles.edit_b,'String', string(handles.crystal_args{2}(2))); 
set(handles.edit_c, 'String', string(handles.crystal_args{2}(3))); 
fprintf("\n--> a (nm): " + handles.crystal_args{2}(1) + " \n");
fprintf("---> b (nm): " + handles.crystal_args{2}(2) + " \n");
fprintf("---> c (nm): " + handles.crystal_args{2}(3) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_a_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_a (see GCBO)
% ~  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.crystal_args{2}(1) = 5.431; 
set(hObject,'String', string(handles.crystal_args{2}(1)));
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
if handles.crystal_args{1} == "CUB-Oh" || handles.crystal_args{1} == "BCC-Oh" || handles.crystal_args{1} == "FCC-Oh"
    % - Applying condition that a(nm) must be equal to b(nm) and c(nm)
    if data_entry ~= handles.crystal_args{2}(1); handles.crystal_args{2}(1) = data_entry; end
    if data_entry ~= handles.crystal_args{2}(3); handles.crystal_args{2}(3) = data_entry; end
% For 'HEX' crystal
elseif handles.crystal_args{1} == "HEX-D6h"
    % - Applying condition that a(nm) must be equal to b(nm)
    if data_entry ~= handles.crystal_args{2}(1); handles.crystal_args{2}(1) = data_entry; end
% For 'RHL' crystal
elseif handles.crystal_args{1} == "RHL-D3d"
    % - Applying condition that a(nm) must be equal to b(nm) and c(nm)
    if data_entry ~= handles.crystal_args{2}(1); handles.crystal_args{2}(1) = data_entry; end
    if data_entry ~= handles.crystal_args{2}(3); handles.crystal_args{2}(3) = data_entry; end
% For 'TET' and 'BCT' crystal
elseif handles.crystal_args{1} == "TET-D4h" || handles.crystal_args{1} == "BCT-D4h"
    % - Applying condition that a(nm) cannot equal c(nm), but must equal b(nm)
    if data_entry == handles.crystal_args{2}(3); data_entry = data_entry-0.001; end
    if data_entry ~= handles.crystal_args{2}(1); handles.crystal_args{2}(1) = data_entry; end
% For 'ORC', 'ORCC', 'ORCI' and 'ORCF' crystal
elseif handles.crystal_args{1} == "ORC-D2h" || handles.crystal_args{1} == "ORCC-D2h" || handles.crystal_args{1} == "ORCI-D2h" || handles.crystal_args{1} == "ORCF-D2h"
    % - Applying condition that a(nm) cannot equal b(nm) or c(nm)
    if data_entry == handles.crystal_args{2}(1); data_entry = data_entry-0.001; end
    if data_entry == handles.crystal_args{2}(3); data_entry = data_entry-0.001; end
% For 'MCL' and 'MCLC' crystal
elseif handles.crystal_args{1} == "MCL-C2h" || handles.crystal_args{1} == "MCLC-C2h"
    % - No conditions for the 'MCL' or 'MCLC' crystal for b(nm)
% For 'TRI' crystal
elseif handles.crystal_args{1} == "TRI-Ci"
     % - No conditions for the 'TRI' crystal for a(nm)
end
%% 3 - Printing the change that has occured
handles.crystal_args{2}(2) = data_entry;
set(handles.edit_a,'String', string(handles.crystal_args{2}(1))); 
set(hObject,'String', string(handles.crystal_args{2}(2))); 
set(handles.edit_c, 'String', string(handles.crystal_args{2}(3))); 
fprintf("\n---> a (nm): " + handles.crystal_args{2}(1) + " \n");
fprintf("--> b (nm): " + handles.crystal_args{2}(2) + " \n");
fprintf("---> c (nm): " + handles.crystal_args{2}(3) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_b_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_b (see GCBO)
% ~  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.crystal_args{2}(2) = 5.431; 
set(hObject,'String', string(handles.crystal_args{2}(2)), 'enable', 'off');
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
if handles.crystal_args{1} == "CUB-Oh" || handles.crystal_args{1} == "BCC-Oh" || handles.crystal_args{1} == "FCC-Oh"
    % - Applying condition that a(nm) must be equal to b(nm) and c(nm)
    if data_entry ~= handles.crystal_args{2}(1); handles.crystal_args{2}(1) = data_entry; end
    if data_entry ~= handles.crystal_args{2}(2); handles.crystal_args{2}(2) = data_entry; end
% For 'HEX' crystal
elseif handles.crystal_args{1} == "HEX-D6h"
    % - No conditions for the 'HEX' crystal for c(nm)
% For 'RHL' crystal
elseif handles.crystal_args{1} == "RHL-D3d"
    % - Applying condition that a(nm) must be equal to b(nm) and c(nm)
    if data_entry ~= handles.crystal_args{2}(1); handles.crystal_args{2}(1) = data_entry; end
    if data_entry ~= handles.crystal_args{2}(2); handles.crystal_args{2}(2) = data_entry; end
% For 'TET' and 'BCT' crystal
elseif handles.crystal_args{1} == "TET-D4h" || handles.crystal_args{1} == "BCT-D4h"
    % - Applying condition that a(nm) cannot equal c(nm)
    if data_entry == handles.crystal_args{2}(1); data_entry = data_entry-0.001; end
% For 'ORC', 'ORCC', 'ORCI' and 'ORCF' crystal
elseif handles.crystal_args{1} == "ORC-D2h" || handles.crystal_args{1} == "ORCC-D2h" || handles.crystal_args{1} == "ORCI-D2h" || handles.crystal_args{1} == "ORCF-D2h"
    % - Applying condition that a(nm) cannot equal c(nm)
    if data_entry == handles.crystal_args{2}(1); data_entry = data_entry-0.001; end
% For 'MCL' and 'MCLC' crystal
elseif handles.crystal_args{1} == "MCL-C2h" || handles.crystal_args{1} == "MCLC-C2h"
    % - Applying condition that a(nm) cannot equal c(nm)
    if data_entry == handles.crystal_args{2}(1); data_entry = data_entry-0.001; end
% For 'TRI' crystal
elseif handles.crystal_args{1} == "TRI-Ci"
    % - No conditions for the 'TRI' crystal for c(nm)
end
%% 3 - Printing the change that has occured
handles.crystal_args{2}(3) = data_entry;
set(handles.edit_a,'String', string(handles.crystal_args{2}(1))); 
set(handles.edit_b,'String', string(handles.crystal_args{2}(2))); 
set(hObject,'String', string(handles.crystal_args{2}(3))); 
fprintf("\n---> a (nm): " + handles.crystal_args{2}(1) + " \n");
fprintf("---> b (nm): " + handles.crystal_args{2}(2) + " \n");
fprintf("--> c (nm): " + handles.crystal_args{2}(3) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_c_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_c (see GCBO)
% ~  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
handles.crystal_args{2}(3) = 5.431; 
set(hObject,'String', string(handles.crystal_args{2}(3)), 'enable', 'off');
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
if handles.crystal_args{1} == "CUB-Oh" || handles.crystal_args{1} == "BCC-Oh" || handles.crystal_args{1} == "FCC-Oh"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.crystal_args{3}(2); handles.crystal_args{3}(2) = data_entry; end
    if data_entry ~= handles.crystal_args{3}(3); handles.crystal_args{3}(3) = data_entry; end
% For 'HEX' crystal
elseif handles.crystal_args{1} == "HEX-D6h"
    % - Applying condition that alpha must be 90degrees and equal to beta
    data_entry = 90;
    if data_entry ~= handles.crystal_args{3}(2); handles.crystal_args{3}(2) = data_entry; end
% For 'RHL' crystal
elseif handles.crystal_args{1} == "RHL-D3d"
    % - Applying condition that alpha must not be 90degrees, but equal to beta and gamma
    if data_entry == 90; data_entry = data_entry - 1; end
    if data_entry ~= handles.crystal_args{3}(2); handles.crystal_args{3}(2) = data_entry; end
    if data_entry ~= handles.crystal_args{3}(3); handles.crystal_args{3}(3) = data_entry; end
% For 'TET' and 'BCT' crystal
elseif handles.crystal_args{1} == "TET-D4h" || handles.crystal_args{1} == "BCT-D4h"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.crystal_args{3}(2); handles.crystal_args{3}(2) = data_entry; end
    if data_entry ~= handles.crystal_args{3}(3); handles.crystal_args{3}(3) = data_entry; end
% For 'ORC', 'ORCC', 'ORCI' and 'ORCF' crystal
elseif handles.crystal_args{1} == "ORC-D2h" || handles.crystal_args{1} == "ORCC-D2h" || handles.crystal_args{1} == "ORCI-D2h" || handles.crystal_args{1} == "ORCF-D2h"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.crystal_args{3}(2); handles.crystal_args{3}(2) = data_entry; end
    if data_entry ~= handles.crystal_args{3}(3); handles.crystal_args{3}(3) = data_entry; end
% For 'MCL' and 'MCLC' crystal
elseif handles.crystal_args{1} == "MCL-C2h" || handles.crystal_args{1} == "MCLC-C2h"
    % - Applying condition that alpha must be 90degrees and equal to gamma
    data_entry = 90;
    if data_entry ~= handles.crystal_args{3}(3); handles.crystal_args{3}(3) = data_entry; end
% For 'TRI' crystal
elseif handles.crystal_args{1} == "TRI-Ci"
    % - No conditions for the 'TRI' crystal for alpha
end
%% 3 - Printing the change that has occured
handles.crystal_args{3}(1) = data_entry;
set(hObject,'String', string(handles.crystal_args{3}(1))); 
set(handles.edit_beta,'String', string(handles.crystal_args{3}(2))); 
set(handles.edit_gamma, 'String', string(handles.crystal_args{3}(3))); 
fprintf("\n--> alpha (deg): " + handles.crystal_args{3}(1) + " \n");
fprintf("---> beta (deg): " + handles.crystal_args{3}(2) + " \n");
fprintf("---> gamma (deg): " + handles.crystal_args{3}(3) + " \n");
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
handles.crystal_args{3}(1) = 90; 
set(hObject,'String', string(handles.crystal_args{3}(1)), 'enable', 'off');
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
if handles.crystal_args{1} == "CUB-Oh" || handles.crystal_args{1} == "BCC-Oh" || handles.crystal_args{1} == "FCC-Oh"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.crystal_args{3}(1); handles.crystal_args{3}(1) = data_entry; end
    if data_entry ~= handles.crystal_args{3}(3); handles.crystal_args{3}(3) = data_entry; end
% For 'HEX' crystal
elseif handles.crystal_args{1} == "HEX-D6h"
    % - Applying condition that alpha must be 90degrees and equal to beta
    data_entry = 90;
    if data_entry ~= handles.crystal_args{3}(1); handles.crystal_args{3}(1) = data_entry; end
% For 'RHL' crystal
elseif handles.crystal_args{1} == "RHL-D3d"
    % - Applying condition that alpha must not be 90degrees, but equal to beta and gamma
    if data_entry == 90; data_entry = data_entry - 1; end
    if data_entry ~= handles.crystal_args{3}(1); handles.crystal_args{3}(1) = data_entry; end
    if data_entry ~= handles.crystal_args{3}(3); handles.crystal_args{3}(3) = data_entry; end
% For 'TET' and 'BCT' crystal
elseif handles.crystal_args{1} == "TET-D4h" || handles.crystal_args{1} == "BCT-D4h"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.crystal_args{3}(1); handles.crystal_args{3}(1) = data_entry; end
    if data_entry ~= handles.crystal_args{3}(3); handles.crystal_args{3}(3) = data_entry; end
% For 'ORC', 'ORCC', 'ORCI' and 'ORCF' crystal
elseif handles.crystal_args{1} == "ORC-D2h" || handles.crystal_args{1} == "ORCC-D2h" || handles.crystal_args{1} == "ORCI-D2h" || handles.crystal_args{1} == "ORCF-D2h"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.crystal_args{3}(1); handles.crystal_args{3}(1) = data_entry; end
    if data_entry ~= handles.crystal_args{3}(3); handles.crystal_args{3}(3) = data_entry; end
% For 'MCL' and 'MCLC' crystal
elseif handles.crystal_args{1} == "MCL-C2h" || handles.crystal_args{1} == "MCLC-C2h"
    % - Applying condition that beta must not be 90 degrees
    if data_entry == 90; data_entry = data_entry - 1; end
% For 'TRI' crystal
elseif handles.crystal_args{1} == "TRI-Ci"
    % - No conditions for the 'TRI' crystal for beta
end
%% 3 - Printing the change that has occured
handles.crystal_args{3}(2) = data_entry;
set(handles.edit_alpha,'String', string(handles.crystal_args{3}(1))); 
set(hObject,'String', string(handles.crystal_args{3}(2)));
set(handles.edit_gamma, 'String', string(handles.crystal_args{3}(3))); 
fprintf("\n---> alpha (deg): " + handles.crystal_args{3}(1) + " \n");
fprintf("--> beta (deg): " + handles.crystal_args{3}(2) + " \n");
fprintf("---> gamma (deg): " + handles.crystal_args{3}(3) + " \n");
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
handles.crystal_args{3}(2) = 90; 
set(hObject,'String', string(handles.crystal_args{3}(2)), 'enable', 'off');
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
if handles.crystal_args{1} == "CUB-Oh" || handles.crystal_args{1} == "BCC-Oh" || handles.crystal_args{1} == "FCC-Oh"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.crystal_args{3}(1); handles.crystal_args{3}(1) = data_entry; end
    if data_entry ~= handles.crystal_args{3}(2); handles.crystal_args{3}(2) = data_entry; end
% For 'HEX' crystal
elseif handles.crystal_args{1} == "HEX-D6h"
    % - Applying condition that gamma must be equal to 120 degrees
    data_entry = 120;
% For 'RHL' crystal
elseif handles.crystal_args{1} == "RHL-D3d"
    % - Applying condition that alpha must not be 90degrees, but equal to beta and gamma
    if data_entry == 90; data_entry = data_entry - 1; end
    if data_entry ~= handles.crystal_args{3}(1); handles.crystal_args{3}(1) = data_entry; end
    if data_entry ~= handles.crystal_args{3}(2); handles.crystal_args{3}(2) = data_entry; end
% For 'TET' and 'BCT' crystal
elseif handles.crystal_args{1} == "TET-D4h" || handles.crystal_args{1} == "BCT-D4h"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.crystal_args{3}(1); handles.crystal_args{3}(1) = data_entry; end
    if data_entry ~= handles.crystal_args{3}(2); handles.crystal_args{3}(2) = data_entry; end
% For 'ORC', 'ORCC', 'ORCI' and 'ORCF' crystal
elseif handles.crystal_args{1} == "ORC-D2h" || handles.crystal_args{1} == "ORCC-D2h" || handles.crystal_args{1} == "ORCI-D2h" || handles.crystal_args{1} == "ORCF-D2h"
    % - Applying condition that alpha must be 90degrees and equal to beta and gamma
    data_entry = 90;
    if data_entry ~= handles.crystal_args{3}(1); handles.crystal_args{3}(1) = data_entry; end
    if data_entry ~= handles.crystal_args{3}(2); handles.crystal_args{3}(2) = data_entry; end
% For 'MCL' and 'MCLC' crystal
elseif handles.crystal_args{1} == "MCL-C2h" || handles.crystal_args{1} == "MCLC-C2h"
    % - Applying condition that alpha must be equal to gamma and 90 degrees
    data_entry = 90;
    if data_entry ~= handles.crystal_args{3}(1); handles.crystal_args{3}(1) = data_entry; end
% For 'TRI' crystal
elseif handles.crystal_args{1} == "TRI-Ci"
    % - No conditions for the 'TRI' crystal for beta
end
%% 3 - Printing the change that has occured
handles.crystal_args{3}(3) = data_entry;
set(handles.edit_alpha,'String', string(handles.crystal_args{3}(1))); 
set(handles.edit_beta, 'String', string(handles.crystal_args{3}(2))); 
set(hObject,'String', string(handles.crystal_args{3}(3)));
fprintf("\n---> alpha (deg): " + handles.crystal_args{3}(1) + " \n");
fprintf("---> beta (deg): " + handles.crystal_args{3}(2) + " \n");
fprintf("--> gamma (deg): " + handles.crystal_args{3}(3) + " \n");
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
handles.crystal_args{3}(3) = 90;
set(hObject,'String', string(handles.crystal_args{3}(3)), 'enable', 'off');
%% Update handles structure
guidata(hObject, handles);

% --- Executes on selection change in popupmenu_crystalplane.
function popupmenu_crystalplane_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_crystalplane (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
contents = cellstr(get(hObject,'String'));
data_entry = contents{get(hObject,'Value')};
handles.crystal_args{4} = data_entry;
fprintf("--> Crystal plane: " + handles.crystal_args{4} + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_crystalplane_CreateFcn(hObject, ~, handles)
% hObject    handle to popupmenu_crystalplane (see GCBO)
% ~  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Set default parameters
contents = cellstr(get(hObject,'String'));
handles.crystal_args{4} = string(contents{1});
set(hObject,'Value', 1);
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_Extract2DBZ.
function pushbutton_Extract2DBZ_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_Extract2DBZ (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the 3D Crystal and Brilluoin Zone
bzNavi.crystal_args = handles.crystal_args;
[bzNavi.realStr, bzNavi.reciStr] = extract_lattice(handles.crystal_args);
%% 2 - Extracting the 2D Brilluoin Zone planar slice
extract_plane(bzNavi.reciStr, handles.crystal_args{4}, 1);
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_Extract3DBZ.
function pushbutton_Extract3DBZ_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_Extract3DBZ (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% Extracting and viewing the 3D Crystal and Brilluoin Zone
extract_lattice(handles.crystal_args, 1);
%% Update handles structure
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% BRILLUOIN ZONE NAVIGATION  %%%%%%%%%%%%
% --- Executes when changing the text
function edit_ePhi_Callback(hObject, ~, handles)
% hObject    handle to edit_ePhi (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = abs(round(str2num(get(hObject,'String')), 4));
%% 2- Validity check
if isempty(data_entry) || length(data_entry) > 1 || length(data_entry) < 1; handles.navi_args.ePhi = 4.5;
else
    if data_entry(1) < 0; data_entry(1) = 0; end
    if data_entry(1) > 1e2; data_entry(1) = 1e2; end
    handles.navi_args.ePhi = data_entry(1);
end
set(hObject,'String',handles.navi_args.ePhi);  
fprintf("--> ePhi (eV): " + string(handles.navi_args.ePhi) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_ePhi_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_ePhi (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
set(hObject,'String', 4.5);
handles.navi_args.ePhi = round(str2double(get(hObject,'String')), 4);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_alpha2_Callback(hObject, ~, handles)
% hObject    handle to edit_alpha2 (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(get(hObject,'String')), 4);
%% 2- Validity check
if isempty(data_entry) || length(data_entry) > 1 || length(data_entry) < 1; handles.navi_args.alpha = 20;
else
    if data_entry(1) < -90; data_entry(1) = 90; end
    if data_entry(1) > 90; data_entry(1) = 90; end
    handles.navi_args.alpha = data_entry(1);
end
set(hObject,'String',handles.navi_args.alpha);  
fprintf("--> alpha (deg.): " + string(handles.navi_args.alpha) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_alpha2_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_alpha2 (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
set(hObject,'String', 20);
handles.navi_args.alpha = round(str2double(get(hObject,'String')), 4);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_thtM_Callback(hObject, ~, handles)
% hObject    handle to edit_thtM (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(get(hObject,'String')), 4);
%% 2- Validity check
if isempty(data_entry) || length(data_entry) > 1 || length(data_entry) < 1; handles.navi_args.thtM = 0;
else
    if data_entry(1) < -90; data_entry(1) = 90; end
    if data_entry(1) > 90; data_entry(1) = 90; end
    handles.navi_args.thtM = data_entry(1);
end
set(hObject,'String',handles.navi_args.thtM);  
fprintf("--> thtM (deg.): " + string(handles.navi_args.thtM) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_thtM_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_thtM (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
set(hObject,'String', 0);
handles.navi_args.thtM = round(str2double(get(hObject,'String')), 4);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_tltM_Callback(hObject, ~, handles)
% hObject    handle to edit_tltM (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(get(hObject,'String')), 4);
%% 2- Validity check
if isempty(data_entry) || length(data_entry) > 1 || length(data_entry) < 1; handles.navi_args.tltM = 0;
else
    if data_entry(1) < -90; data_entry(1) = 90; end
    if data_entry(1) > 90; data_entry(1) = 90; end
    handles.navi_args.tltM = data_entry(1);
end
set(hObject,'String',handles.navi_args.tltM);  
fprintf("--> tltM (deg.): " + string(handles.navi_args.tltM) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_tltM_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_tltM (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
set(hObject,'String', 0);
handles.navi_args.tltM = round(str2double(get(hObject,'String')), 4);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_eBref_Callback(hObject, ~, handles)
% hObject    handle to edit_eBref (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = abs(round(str2num(get(hObject,'String')), 4));
%% 2- Validity check
if isempty(data_entry) || length(data_entry) > 1 || length(data_entry) < 1; handles.navi_args.eBref = 0;
else
    if data_entry(1) < 0; data_entry(1) = 0; end
    if data_entry(1) > 1e2; data_entry(1) = 1e2; end
    handles.navi_args.eBref = data_entry(1);
end
set(hObject,'String',handles.navi_args.eBref);  
fprintf("--> eB ref (eV): " + string(handles.navi_args.eBref) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_eBref_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_eBref (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
set(hObject,'String', 0);
handles.navi_args.eBref = round(str2double(get(hObject,'String')), 4);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_thtARef_Callback(hObject, ~, handles)
% hObject    handle to edit_thtARef (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(get(hObject,'String')), 4);
%% 2- Validity check
if isempty(data_entry) || length(data_entry) > 1 || length(data_entry) < 1; handles.navi_args.thtAref = 0;
else
    if data_entry(1) < -90; data_entry(1) = 90; end
    if data_entry(1) > 90; data_entry(1) = 90; end
    handles.navi_args.thtAref = data_entry(1);
end
set(hObject,'String',handles.navi_args.thtAref);  
fprintf("--> thtA ref (deg.): " + string(handles.navi_args.thtAref) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_thtARef_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_thtARef (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
set(hObject,'String', 0);
handles.navi_args.thtAref = round(str2double(get(hObject,'String')), 4);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_kxRef_Callback(hObject, ~, handles)
% hObject    handle to edit_kxRef (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(str2num(get(hObject,'String')), 4);
%% 2- Validity check
if isempty(data_entry) || length(data_entry) > 1 || length(data_entry) < 1; handles.navi_args.kxref = 0;
else
    if data_entry(1) < -90; data_entry(1) = 90; end
    if data_entry(1) > 90; data_entry(1) = 90; end
    handles.navi_args.kxref = data_entry(1);
end
set(hObject,'String',handles.navi_args.kxref);  
fprintf("--> kx ref (A^-1): " + string(handles.navi_args.kxref) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_kxRef_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_kxRef (see GCBO)
% ~  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
set(hObject,'String', 0);
handles.navi_args.kxref = round(str2double(get(hObject,'String')), 4);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_hv_Callback(hObject, ~, handles)
% hObject    handle to edit_hv (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = round(sort(str2num(strrep(get(hObject,'String'),':',' '))), 4);
%% 2 - Validity check on input
% - If no entry is made, default to a single hv value
if isempty(data_entry) || length(data_entry) > 2
    data_entry = 400;
% - If a single entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 1
    if data_entry(1) < 10; data_entry(1) = 10; end
    if data_entry(1) > 10000; data_entry(1) = 10000; end
% - If a double entry is made, ensure it does not exceed the max / min limits
elseif length(data_entry) == 2
    if data_entry(1) < 10 ||  data_entry(1) > 10000; data_entry(1) = 10; end
    if data_entry(2) < 10 ||  data_entry(2) > 10000; data_entry(2) = 10000; end
end
%% 3 - Assigning and printing the output
handles.navi_args.hv = data_entry;
if length(handles.navi_args.hv) == 1
    set(hObject,'String',handles.navi_args.hv);  
    fprintf("--> hv (eV): " + string(handles.navi_args.hv) + " \n");
elseif length(handles.navi_args.hv) == 2
    set(hObject,'String', string(handles.navi_args.hv(1) + ":" + handles.navi_args.hv(2))); 
    fprintf("--> hv (eV): " + string(handles.navi_args.hv(1) + ":" + handles.navi_args.hv(2)) + " \n");
end
%% 4 - Setting the IMFP and Kz broadening
eKE = handles.navi_args.hv - handles.navi_args.ePhi + handles.navi_args.eBref;
imfp = 10 .* (143 ./ eKE .^2 + 0.054.*sqrt(eKE));
dkz = 1 ./ imfp;
if length(handles.navi_args.hv) == 1
    imfp_str = sprintf(round(imfp, 3) + "A");
    dkz_str = sprintf(round(dkz, 3) + "A^-1");
    set(handles.text_imfp,'String', imfp_str);
    set(handles.text_dkz,'String', dkz_str);
elseif length(handles.navi_args.hv) == 2
    imfp_str = sprintf(round(imfp(1), 3) + "A, " + round(imfp(2), 3) + "A");
    dkz_str = sprintf(round(dkz(1), 3) + "A^-1, " + round(dkz(2), 3) + "A^-1");
    set(handles.text_imfp,'String', imfp_str);
    set(handles.text_dkz,'String', dkz_str);
end
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_hv_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_hv (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
set(hObject,'String', 400);
handles.navi_args.hv = round(str2double(get(hObject,'String')), 4);
%% Update handles structure
guidata(hObject, handles);

% --- Executes when changing the text
function edit_V000_Callback(hObject, ~, handles)
% hObject    handle to edit_V000 (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the input defined by user
data_entry = abs(round(str2num(get(hObject,'String')), 4));
%% 2- Validity check
if isempty(data_entry) || length(data_entry) > 1 || length(data_entry) < 1; handles.navi_args.V000 = 12.5700;
else; handles.navi_args.V000 = data_entry;
end
set(hObject,'String',handles.navi_args.V000);  
fprintf("--> V000 (eV): " + string(handles.navi_args.V000) + " \n");
%% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_V000_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_V000 (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% 1 - Set the default parameters
set(hObject,'String', 12.5700);
handles.navi_args.V000 = round(str2double(get(hObject,'String')), 4);
%% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ExtractARPESLine.
function pushbutton_ExtractARPESLine_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_ExtractARPESLine (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

%% 1 - Extracting the 3D Crystal and Brilluoin Zone
bzNavi.crystal_args = handles.crystal_args;
[bzNavi.realStr, bzNavi.reciStr] = extract_lattice(handles.crystal_args, 0);
%% 2 - Extracting the 2D Brilluoin Zone planar slice
planeStr = extract_plane(bzNavi.reciStr, handles.crystal_args{4}, 0);
%% 3 - Extracting and viewing the ARPES cut that is taken
extract_kcut(planeStr, handles.navi_args);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INTERNAL PROCESSING FUNCTIONS %%%%%%%%%%

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

% ---  Function to extract the Brilluoin zone overlay of the given crystal plane slice
function extract_kcut(planeStr, navi_args)
% extract_kcut(planeStr, navi_args)
%   This is a function that extracts the crystallographic vectors
%   of a general crystal structure in both real- and reciprocal-
%   space based on the inputs. All 14 Bravais lattices can be 
%   defined, including primitive-, base-, face- and body-centered
%   lattices. The outputs are two MATLAB structures that contain
%   all of the real- and reciprocal-space data.
%
%   IN:
%   - planeStr          MATLAB data structure containing all BZ plane information below;
%   .(crystal):                        string of the crystal type.
%   .(crystal_plane):            string of the (h,k,l) plane extracted.
%	.(area):                           area of the planar BZ unit cell.
%   .(X):                     cell array of the x vertices of the planar BZ cell slice.
%   .(Y):                     cell array of the y vertices of the planar BZ cell slice.
%	.(gX):                  double of the reciprocal-tesselation vector in x.
%	.(gY):                  double of the reciprocal-tesselation vector in y.
%   -   navi_args:     MATLAB data structure containing all of the navigation arguments below;
%   .(ePhi):                        Work function of analyser
%   .(alpha):                      Angle between analyser and sample normal
%	.(eB):                           Binding energy reference
%   .(thtM):                       Primary manipulator rotation
%   .(thtA):                       Analyser angle to sample normal in geometry is at origin
%	.(kx):                          kx reference is at origin
%	.(tltM):                       Primary tilt rotation is set to origin
%	.(V000):                     user defined inner potential.
%	.(hv):                          user defined photon energy.

disp('-> Extracting k-space ARPES scan line...')

%% 1.1 - Extracting the wave-vector path in k-space for the ARPES scan
tht = linspace(-8, 8, 5e2);
if length(navi_args.hv) == 1
    surfNormX = SurfNormX(navi_args.hv, navi_args.eBref, navi_args.kxref, navi_args.thtM, navi_args.thtAref);
    kx = Kxx(navi_args.hv, navi_args.eBref, navi_args.thtM, tht, surfNormX);
    kz = Kzz(navi_args.hv, navi_args.eBref, navi_args.thtM, tht, navi_args.tltM, navi_args.V000, surfNormX);
elseif length(navi_args.hv) == 2
    surfNormX(1,:) = SurfNormX(navi_args.hv(1), navi_args.eBref, navi_args.kxref, navi_args.thtM, navi_args.thtAref);
    kx(1,:) = Kxx(navi_args.hv(1), navi_args.eBref, navi_args.thtM, tht, surfNormX(1,:));
    kz(1,:) = Kzz(navi_args.hv(1), navi_args.eBref, navi_args.thtM, tht, navi_args.tltM, navi_args.V000, surfNormX(1,:));
    surfNormX(2,:) = SurfNormX(navi_args.hv(2), navi_args.eBref, navi_args.kxref, navi_args.thtM, navi_args.thtAref);
    kx(2,:) = Kxx(navi_args.hv(2), navi_args.eBref, navi_args.thtM, tht, surfNormX(2,:));
    kz(2,:) = Kzz(navi_args.hv(2), navi_args.eBref, navi_args.thtM, tht, navi_args.tltM, navi_args.V000, surfNormX(2,:));
end
%% 1.2 - Extracting the kz-broadening
eKE = navi_args.hv - navi_args.ePhi + navi_args.eBref;
imfp = 10 .* (143 ./ eKE .^2 + 0.054.*sqrt(eKE));
dkz = 1 ./ imfp;

%% 2 - Updating the figure with the photon energy path
fig = figure(3633);
set(fig, 'position', [1,1,500,500], 'Name', 'BZ Navigation');
hold on;
%% 2.1 - Plotting the BZ planar slice
for i = 1:size(planeStr.X, 2)
    plot(planeStr.X{i}, planeStr.Y{i}, 'k-','linewidth', 2);
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
title_txt = sprintf("%s; BZ navigation through %s", planeStr.crystal, planeStr.crystal_plane);
title(title_txt);
xlabel('$$ \bf  k_x (\AA^{-1}) $$', 'Interpreter', 'latex');
ylabel('$$ \bf  k_z (\AA^{-1}) $$', 'Interpreter', 'latex');
xticks(round(-100*norm(planeStr.gX):0.5*norm(planeStr.gX):100*norm(planeStr.gX),2));
yticks(round(-100*norm(planeStr.gY):0.5*norm(planeStr.gY):100*norm(planeStr.gY),2));
axis(1.5*[-norm(planeStr.gX), norm(planeStr.gX), -norm(planeStr.gY),norm(planeStr.gY)]);
axis equal;
%% 2.2 - Plotting the k-space patches probed with ARPES
col = rand(1,3);
% - For a single photon energy
if length(navi_args.hv) == 1
    % -- Extract the planar limits of the ARPES scan
    kx_lower = (kx); kz_lower = (kz - dkz)';
    kx_upper = (kx); kz_upper = (kz + dkz)';
    % -- Plotting the ARPES scan plane which includes the Kz broadening
    patch([kx_upper, fliplr(kx_lower)], [kz_upper, fliplr(kz_lower)], col, 'edgecolor', 'none', 'facealpha', 0.5);
    % -- Plotting the ARPES scan line
    plot(kx, kz, '-', 'linewidth', 2, 'color', col);
    % -- Adding text
    text(mean(kx(:)), max(kz_lower(:))-0.05*norm(planeStr.gY), sprintf("%.2f eV", navi_args.hv),...
        'color', col, 'Fontsize', 12, 'horizontalalignment', 'center');
% - For a range of photon energies
elseif length(navi_args.hv) == 2
    % -- Extract the planar limits of the ARPES scan
    kx_lower = (kx(1,:)); kz_lower = (kz(1,:) - dkz(1));
    kx_upper = (kx(2,:)); kz_upper = (kz(2,:) + dkz(2));
    % -- Plotting the ARPES scan plane which includes the Kz broadening
    patch([kx_upper, fliplr(kx_lower)], [kz_upper, fliplr(kz_lower)], col, 'edgecolor', 'none', 'facealpha', 0.5);
    % -- Plotting the ARPES scan line
    plot(kx(1,:), kz(1,:), '-', 'linewidth', 2, 'color', col);
    plot(kx(2,:), kz(2,:), '-', 'linewidth', 2, 'color', col);
    % -- Adding text
    text(mean(kx(1,:)), min(kz_lower(:))-0.05*norm(planeStr.gY), sprintf("%.2f eV", navi_args.hv(1)),...
        'color', col, 'Fontsize', 12, 'horizontalalignment', 'center');
    text(mean(kx(2,:)), max(kz_upper(:))+0.05*norm(planeStr.gY), sprintf("%.2f eV", navi_args.hv(2)),...
        'color', col, 'Fontsize', 12, 'horizontalalignment', 'center');
end
% - Adding the axes limits
xlim([mean(kx(:))-1.5*norm(planeStr.gX), mean(kx(:))+1.5*norm(planeStr.gX)]);
ylim([mean(kz(:))-1.5*norm(planeStr.gY), mean(kz(:))+1.5*norm(planeStr.gY)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% The End %%%%%%%%%%%%%%%%%%%%
