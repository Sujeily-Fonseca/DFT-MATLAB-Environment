% INEL 5309 - Digital Signal Processing
% Project 02 - Properties of the Discrete Fourier Transform (DFT)
% Dr. Domingo Rodríguez
% Sujeily P. Fonseca González, Joeshua Díaz González

%======================== General Description ============================%
% This program presents a user interphase or MATLAB environment able to   %
% demonstrate the principal properties of the Discrete Fourier Transform. %
%=========================================================================%

function varargout = DFT_Properties_Environment(varargin)
% DFT_PROPERTIES_ENVIRONMENT MATLAB code for DFT_Properties_Environment.fig
%      DFT_PROPERTIES_ENVIRONMENT, by itself, creates a new DFT_PROPERTIES_ENVIRONMENT or raises the existing
%      singleton*.
%
%      H = DFT_PROPERTIES_ENVIRONMENT returns the handle to a new DFT_PROPERTIES_ENVIRONMENT or the handle to
%      the existing singleton*.
%
%      DFT_PROPERTIES_ENVIRONMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DFT_PROPERTIES_ENVIRONMENT.M with the given input arguments.
%
%      DFT_PROPERTIES_ENVIRONMENT('Property','Value',...) creates a new DFT_PROPERTIES_ENVIRONMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DFT_Properties_Environment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DFT_Properties_Environment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DFT_Properties_Environment

% Last Modified by GUIDE v2.5 26-May-2018 23:15:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DFT_Properties_Environment_OpeningFcn, ...
                   'gui_OutputFcn',  @DFT_Properties_Environment_OutputFcn, ...
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


% --- Executes just before DFT_Properties_Environment is made visible.
function DFT_Properties_Environment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DFT_Properties_Environment (see VARARGIN)

% Choose default command line output for DFT_Properties_Environment
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Set the figure and axes handles
hFig = gcf;
hAx  = gca;

% Set the figure to full screen
set(hFig,'units','normalized','outerposition',[0 0 1 1]);

% Set the axes to full screen
set(hAx,'Unit','normalized','Position',[0 0 1 1]);

% Hide the toolbar
set(hFig,'menubar','none')

% Hide the title 
set(hFig,'NumberTitle','off');

% Change background color
set(handles.axes1,'YColor','white');
grid off

% Table of Properties
axes(handles.properties)
matlabImage = imread('Images\properties.png');
image(matlabImage);
axis off
axis image

% UPRM Logo
axes(handles.uprm_logo)
matlabImage = imread('Images\UPRM_Logo.png');
image(matlabImage);
axis off
axis image

fig = gcf;
set(fig, 'Name', 'DFT Properties Environment');
set(fig, 'Resize', 'on')
 
% UIWAIT makes DFT_Properties_Environment wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DFT_Properties_Environment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function properties_CreateFcn(hObject, eventdata, handles)
% hObject    handle to properties (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function uprm_logo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uprm_logo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


%=========================== DFT Properties ==============================%

% --- Executes on button press in linearity.
function linearity_Callback(hObject, eventdata, handles)
% hObject    handle to linearity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
linearity;

% --- Executes on button press in circular_time_shifting.
function circular_time_shifting_Callback(hObject, eventdata, handles)
% hObject    handle to circular_time_shifting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
circular_time_shifting;

% --- Executes on button press in circular_freq_shifting.
function circular_freq_shifting_Callback(hObject, eventdata, handles)
% hObject    handle to circular_freq_shifting (see GCBO)9
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
circular_frequency_shifting;

% --- Executes on button press in duality.
function duality_Callback(hObject, eventdata, handles)
% hObject    handle to duality (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
duality;

% --- Executes on button press in circular_convolution.
function circular_convolution_Callback(hObject, eventdata, handles)
% hObject    handle to circular_convolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
circular_convolution;

% --- Executes on button press in modulation.
function modulation_Callback(hObject, eventdata, handles)
% hObject    handle to modulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
modulation;


%========================= Parseval's Theorem ============================%

% --- Executes on button press in parseval.
function parseval_Callback(hObject, eventdata, handles)
% hObject    handle to parseval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
parseval_theorem;
