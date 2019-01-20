% INEL 5309 - Digital Signal Processing
% DFT N-Point Circular Convolution Property
% Dr. Domingo Rodríguez
% Sujeily P. Fonseca González, Joeshua Díaz González

%======================== Section Description ============================%
% This section provides tools and options to demonstrate the N-Point      %
% Circular Convolution of the Discrete Fourier Transform (DFT).           %
%=========================================================================%

function varargout = circular_convolution(varargin)
% CIRCULAR_CONVOLUTION MATLAB code for circular_convolution.fig
%      CIRCULAR_CONVOLUTION, by itself, creates a new CIRCULAR_CONVOLUTION or raises the existing
%      singleton*.
%
%      H = CIRCULAR_CONVOLUTION returns the handle to a new CIRCULAR_CONVOLUTION or the handle to
%      the existing singleton*.
%
%      CIRCULAR_CONVOLUTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CIRCULAR_CONVOLUTION.M with the given input arguments.
%
%      CIRCULAR_CONVOLUTION('Property','Value',...) creates a new CIRCULAR_CONVOLUTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before circular_convolution_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to circular_convolution_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help circular_convolution

% Last Modified by GUIDE v2.5 27-May-2018 06:19:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @circular_convolution_OpeningFcn, ...
                   'gui_OutputFcn',  @circular_convolution_OutputFcn, ...
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


% --- Executes just before circular_convolution is made visible.
function circular_convolution_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to circular_convolution (see VARARGIN)

% Choose default command line output for circular_convolution
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
matlabImage = imread('Images\circonvolution_image.png');
image(matlabImage)
axis off
axis image

fig = gcf;
set(fig, 'Name', 'DFT N-Point Circular Convolution Property');
set(fig, 'Resize', 'on');

% UIWAIT makes circular_convolution wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = circular_convolution_OutputFcn(hObject, eventdata, handles) 
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
[gcirconvolution] = uigetfile('*.txt');
if isequal(gcirconvolution, 0)
  disp('User selected Cancel');
else 
    g_circonvolution = fopen(gcirconvolution); % Open file
    C = textscan(g_circonvolution,'%f');       % Read data from an open text file
    gfunction = cell2mat(C);            % Convert the contents of a cell array 
                                        % into a single matrix
    fclose(g_circonvolution);           % Close file
    
    handles.g_function = gfunction;     % Save value of g[n] function
    guidata(hObject, handles);
end

% --- Executes on button press in load_function_h.
function load_function_h_Callback(hObject, eventdata, handles)
% hObject    handle to load_function_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[hcirconvolution] = uigetfile('*.txt');
if isequal(hcirconvolution, 0)
  disp('User selected Cancel');
else 
    h_circonvolution = fopen(hcirconvolution); % Open file
    C = textscan(h_circonvolution,'%f');       % Read data from an open text file
    hfunction = cell2mat(C);            % Convert the contents of a cell array 
                                        % into a single matrix
    fclose(h_circonvolution);           % Close file
    
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
        lhs_circonvolution = cconv(g,h,order);
        LHS_circonvolution = fft(lhs_circonvolution);
        real_lhs_circonvolution = real(LHS_circonvolution); % Real part of the signal
        imag_lhs_circonvolution = imag(LHS_circonvolution); % Imaginary part of the signal

        % Right hand side
        H=fft(h);
        G=fft(g);
        RHS_circonvolution = G.*H;
        real_rhs_circonvolution = real(RHS_circonvolution); % Real part of the signal
        imag_rhs_circonvolution=imag(RHS_circonvolution);   % Imaginary part of the signal

        % Plot both sides 
        axes(handles.lhs_plot1);
        stem(real_lhs_circonvolution);
        title('N-Point Circular Convolution Property - LHS Real Part');
        xlabel('Index');
        ylabel('Amplitude');

        axes(handles.lhs_plot2);
        stem(imag_lhs_circonvolution);
        title('N-Point Circular Convolution Property - LHS Imaginary Part');
        xlabel('Index');
        ylabel('Amplitude')

        axes(handles.rhs_plot1);
        stem(real_rhs_circonvolution)
        title('N-Point Circular Convolution Property - RHS Real Part');
        xlabel('Index');
        ylabel('Amplitude')

        axes(handles.rhs_plot2);
        stem(imag_rhs_circonvolution)
        title('N-Point Circular Convolution Property - RHS Imaginary Part');
        xlabel('Index');
        ylabel('Amplitude')
     else
        disp('ERROR: Signals have different order.');
     end
else
   disp('ERROR: Both functions were not provided.');
end

% Save output signals
save('Outputs\N-Point Circular Convolution\lhs_real_n-point_circonvolution.txt','real_lhs_circonvolution','-ascii');
save('Outputs\N-Point Circular Convolution\lhs_imag_n-point_circonvolution.txt','imag_lhs_circonvolution','-ascii');
save('Outputs\N-Point Circular Convolution\rhs_real_n-point_circonvolution.txt','real_rhs_circonvolution','-ascii');
save('Outputs\N-Point Circular Convolution\rhs_imag_n-point_circonvolution.txt','imag_rhs_circonvolution','-ascii');