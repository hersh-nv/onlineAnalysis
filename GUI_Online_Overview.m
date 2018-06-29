function varargout = GUI_Online_Overview(varargin)
% GUI_ONLINE_OVERVIEW MATLAB code for GUI_Online_Overview.fig
%      GUI_ONLINE_OVERVIEW, by itself, creates a new GUI_ONLINE_OVERVIEW or raises the existing
%      singleton*.
%
%      H = GUI_ONLINE_OVERVIEW returns the handle to a new GUI_ONLINE_OVERVIEW or the handle to
%      the existing singleton*.
%
%      GUI_ONLINE_OVERVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ONLINE_OVERVIEW.M with the given input arguments.
%
%      GUI_ONLINE_OVERVIEW('Property','Value',...) creates a new GUI_ONLINE_OVERVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Online_Overview_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Online_Overview_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Online_Overview

% Last Modified by GUIDE v2.5 29-Jun-2018 10:09:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Online_Overview_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Online_Overview_OutputFcn, ...
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


% --- Executes just before GUI_Online_Overview is made visible.
function GUI_Online_Overview_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Online_Overview (see VARARGIN)

% Choose default command line output for GUI_Online_Overview
handles.output = hObject;

% Store master handles
handles.figure_master = varargin{1};
h1 = guidata(handles.figure_master);

% set plotAll figure size
res = get(groot, 'Screensize');
TASKBAR_HEIGHT = 40; % there must be a smarter way to get this but i don't know how
TITLE_BAR_HEIGHT = 31; % likewise

handles.pos = floor(res.*[1,1,0.85,1]) + ... % right 85% of screen
    [h1.pos(3),TASKBAR_HEIGHT,0,-2*TASKBAR_HEIGHT-TITLE_BAR_HEIGHT]; % leaving room for Win10 elements

wwidth = handles.pos(3);
wheight= handles.pos(4);

% disable Overview settings until Overview is closed ?
h1.channelInput.Enable = 'Off';
h1.timeWinInput.Enable = 'Off';
h1.param1Select.Enable = 'Off';
h1.param2Select.Enable = 'Off';
h1.param2ValSelect.Enable = 'Off';

handles = startTuningAll(handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Online_Overview wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Online_Overview_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(hObject,'Units','Pixels','Position',handles.pos);
set(hObject,'Visible','On');

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% reenable Overview settings
try
    h1 = guidata(handles.figure_master);
    h1.channelInput.Enable = 'On';
    h1.timeWinInput.Enable = 'On';
    h1.param1Select.Enable = 'On';
    h1.param2Select.Enable = 'On';
    if h1.param2Select.Value>1
        h1.param2ValSelect.Enable = 'On';
    end
catch
end

% delete plot timer before closing figure
try
    stop(handles.drawAllTimer);
    delete(handles.drawAllTimer);
catch
end
delete(hObject);

