% INEL 5309 - Digital Signal Processing
% DFT Modulation Property
% Dr. Domingo Rodríguez
% Sujeily P. Fonseca González, Joeshua Díaz González

%======================== Section Description ============================%
% This section provides tools and options to demonstrate the Modulation   %
% Property of the Discrete Fourier Transform (DFT).                       %
%=========================================================================%

function varargout = modulation(varargin)
% MODULATION MATLAB code for modulation.fig
%      MODULATION, by itself, creates a new MODULATION or raises the existing
%      singleton*.
%
%      H = MODULATION returns the handle to a new MODULATION or the handle to
%      the existing singleton*.
%
%      MODULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODULATION.M with the given input arguments.
%
%      MODULATION('Property','Value',...) creates a new MODULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before modulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to modulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help modulation

% Last Modified by GUIDE v2.5 27-May-2018 06:19:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modulation_OpeningFcn, ...
                   'gui_OutputFcn',  @modulation_OutputFcn, ...
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


% --- Executes just before modulation is made visible.
function modulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to modulation (see VARARGIN)

% Choose default command line output for modulation
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
matlabImage = imread('Images\modulation_image.png');
image(matlabImage)
axis off
axis image

fig = gcf;
set(fig, 'Name', 'DFT Modulation Property');
set(fig, 'Resize', 'on')

% UIWAIT makes modulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = modulation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_function_g.
function load_function_g_Callback(hObject, eventdata, handles)
% hObject    handle to load_function_g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[gmodulation] = uigetfile('*.txt');
if isequal(gmodulation, 0)
  disp('User selected Cancel');
else 
    g_modulation = fopen(gmodulation);    % Open file
    C = textscan(g_modulation,'%f');     % Read data from an open text file
    gfunction = cell2mat(C);            % Convert the contents of a cell array 
                                        % into a single matrix
    fclose(g_modulation);                % Close file
    
    handles.g_function = gfunction;     % Save value of g[n] function
    guidata(hObject, handles);
end 

% --- Executes on button press in load_function_h.
function load_function_h_Callback(hObject, eventdata, handles)
% hObject    handle to load_function_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[hmodulation] = uigetfile('*.txt');
if isequal(hmodulation, 0)
  disp('User selected Cancel');
else 
    h_modulation = fopen(hmodulation);    % Open file
    C = textscan(h_modulation,'%f');     % Read data from an open text file
    hfunction = cell2mat(C);            % Convert the contents of a cell array 
                                        % into a single matrix
    fclose(h_modulation);                % Close file
    
    handles.h_function = hfunction;     % Save value of g[n] function
    guidata(hObject, handles);
end 

% --- Executes on button press in done.
function done_Callback(hObject, eventdata, handles)
% hObject    handle to done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'g_function') && isfield(handles,'h_function') 
     if length(handles.g_function) == length(handles.h_function)       
        g = handles.g_function.';
        h = handles.h_function.';
        
        order = length(g);
        
        % Left hand side 
        lhs_modulation = g.*h;
        LHS_modulation = fft(lhs_modulation);
        real_lhs_modulation = real(LHS_modulation); % Real part of the signal
        imag_lhs_modulation = imag(LHS_modulation); % Imaginary part of the signal

        % Right hand side 
        H = fft(h);
        G = fft(g);
        RHS_modulation = (1/order)*cconv(G,H,order);
        real_rhs_modulation = real(RHS_modulation); % Real part of the signal
        imag_rhs_modulation = imag(RHS_modulation); % Imaginary part of the signal

        % Plot both sides 
        axes(handles.lhs_plot1);
        stem(real_lhs_modulation);
        title('Modulation Property - LHS Real Part');
        xlabel('Index');
        ylabel('Amplitude');

        axes(handles.lhs_plot2);
        stem(imag_lhs_modulation);
        title('Modulation Property - LHS Imaginary Part');
        xlabel('Index');
        ylabel('Amplitude')

        axes(handles.rhs_plot1);
        stem(real_rhs_modulation)
        title('Modulation Property - RHS Real Part');
        xlabel('Index');
        ylabel('Amplitude')

        axes(handles.rhs_plot2);
        stem(imag_rhs_modulation)
        title('Modulation Property - RHS Imaginary Part');
        xlabel('Index');
        ylabel('Amplitude')      
     else
        disp('ERROR: Signals have different order.');
     end
else
   disp('ERROR: Both functions were not provided.');
end

% Save output signals
save('Outputs\Modulation Property\lhs_real_modulation.txt','real_lhs_modulation','-ascii');
save('Outputs\Modulation Property\lhs_imag_modulation.txt','imag_lhs_modulation','-ascii');
save('Outputs\Modulation Property\rhs_real_modulation.txt','real_rhs_modulation','-ascii');
save('Outputs\Modulation Property\rhs_imag_modulation.txt','imag_rhs_modulation','-ascii');
