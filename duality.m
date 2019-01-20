% INEL 5309 - Digital Signal Processing
% DFT Duality Property
% Dr. Domingo Rodríguez
% Sujeily P. Fonseca González, Joeshua Díaz González

%======================== Section Description ============================%
% This section provides tools and options to demonstrate the Duality      %  
% Property of the Discrete Fourier Transform (DFT).                       %
%=========================================================================%

function varargout = duality(varargin)
% DUALITY MATLAB code for duality.fig
%      DUALITY, by itself, creates a new DUALITY or raises the existing
%      singleton*.
%
%      H = DUALITY returns the handle to a new DUALITY or the handle to
%      the existing singleton*.
%
%      DUALITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DUALITY.M with the given input arguments.
%
%      DUALITY('Property','Value',...) creates a new DUALITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before duality_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to duality_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help duality

% Last Modified by GUIDE v2.5 27-May-2018 02:00:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @duality_OpeningFcn, ...
                   'gui_OutputFcn',  @duality_OutputFcn, ...
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


% --- Executes just before duality is made visible.
function duality_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to duality (see VARARGIN)

% Choose default command line output for duality
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

%DFT Property
axes(handles.DFT_Property)
matlabImage = imread('Images\duality_image.png');
image(matlabImage)
axis off
axis image

fig = gcf;
set(fig, 'Name', 'DFT Duality Property');
set(fig, 'Resize', 'on')

% UIWAIT makes duality wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = duality_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_function.
function load_function_Callback(hObject, eventdata, handles)
% hObject    handle to load_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Read input file
[g_duality] = uigetfile('*.txt');
if isequal(g_duality,0)
  disp('User selected Cancel');
else 
    g_duality = fopen(g_duality);    % Open file
    C = textscan(g_duality,'%f');    % Read data from an open text file
    x = cell2mat(C);                 % Convert the contents of a cell array 
                                     % into a single matrix
    fclose(g_duality);               % Close file
    
    g = x.';
    N=length(g);
  
    % Left hand side 
    LHS_duality = fft(g);
    real_lhs_duality = real(LHS_duality); % Real part of the signal
    imag_lhs_duality = imag(LHS_duality); % Imaginary part of the signal
    
    % Right hand side 
    k = 0:N-1; 
    rhs_duality = N*g(mod(-k,N)+1);
    RHS_duality = fft(rhs_duality);
    real_rhs_duality = real(RHS_duality); % Real part of the signal
    imag_rhs_duality = imag(RHS_duality); % Imaginary part of the signal
    
   
    % Plot both sides 
    axes(handles.lhs_plot1);
    stem(real_lhs_duality);
    title('Duality Property - LHS Real Part');
    xlabel('Index');
    ylabel('Amplitude');
   
    axes(handles.lhs_plot2);
    stem(imag_lhs_duality);
    title('Duality Property - LHS Imaginary Part');
    xlabel('Index');
    ylabel('Amplitude')
    
    axes(handles.rhs_plot1);
    stem(real_rhs_duality)
    title('Duality Property - RHS Real Part');
    xlabel('Index');
    ylabel('Amplitude')
    
    axes(handles.rhs_plot2);
    stem(imag_rhs_duality)
    title('Duality Property - RHS Imaginary Part');
    xlabel('Index');
    ylabel('Amplitude')
    
    % Save output signals
    save('Outputs\Duality Property\lhs_real_duality.txt','real_lhs_duality','-ascii');
    save('Outputs\Duality Property\lhs_imag_duality.txt','imag_lhs_duality','-ascii');
    save('Outputs\Duality Property\rhs_real_duality.txt','real_rhs_duality','-ascii');
    save('Outputs\Duality Property\rhs_imag_duality.txt','imag_rhs_duality','-ascii');
end
