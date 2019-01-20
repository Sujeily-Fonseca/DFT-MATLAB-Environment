% INEL 5309 - Digital Signal Processing
% DFT Circular Frequency-Shifting Property
% Dr. Domingo Rodríguez
% Sujeily P. Fonseca González, Joeshua Díaz González

%======================== Section Description ============================%
% This section provides tools and options to demonstrate the Circular     %
% Frequency-Shifting Property of the Discrete Fourier Transform (DFT).    % 
%=========================================================================%

function varargout = circular_frequency_shifting(varargin)
% CIRCULAR_FREQUENCY_SHIFTING MATLAB code for circular_frequency_shifting.fig
%      CIRCULAR_FREQUENCY_SHIFTING, by itself, creates a new CIRCULAR_FREQUENCY_SHIFTING or raises the existing
%      singleton*.
%
%      H = CIRCULAR_FREQUENCY_SHIFTING returns the handle to a new CIRCULAR_FREQUENCY_SHIFTING or the handle to
%      the existing singleton*.
%
%      CIRCULAR_FREQUENCY_SHIFTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CIRCULAR_FREQUENCY_SHIFTING.M with the given input arguments.
%
%      CIRCULAR_FREQUENCY_SHIFTING('Property','Value',...) creates a new CIRCULAR_FREQUENCY_SHIFTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before circular_frequency_shifting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to circular_frequency_shifting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help circular_frequency_shifting

% Last Modified by GUIDE v2.5 27-May-2018 02:05:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @circular_frequency_shifting_OpeningFcn, ...
                   'gui_OutputFcn',  @circular_frequency_shifting_OutputFcn, ...
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


% --- Executes just before circular_frequency_shifting is made visible.
function circular_frequency_shifting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to circular_frequency_shifting (see VARARGIN)

% Choose default command line output for circular_frequency_shifting
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
matlabImage = imread('Images\cfshifting_image.png');
image(matlabImage)
axis off
axis image

fig = gcf;
set(fig, 'Name', 'DFT Circular Frequency-Shifting Property');
set(fig, 'Resize', 'on')
% UIWAIT makes circular_frequency_shifting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = circular_frequency_shifting_OutputFcn(hObject, eventdata, handles) 
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
k0 = str2num(get(handles.frequency_delay,'String'));
[g_cfshifting] = uigetfile('*.txt');
if isequal(g_cfshifting, 0)
    disp('User selected Cancel');
else 
    g_cfshifting = fopen(g_cfshifting); % Open file
    C = textscan(g_cfshifting,'%f');    % Read data from an open text file
    x = cell2mat(C);                    % Convert the contents of a cell array 
                                        % into a single matrix
    fclose(g_cfshifting);               % Close file
    
    g = x.';
    N=length(g);
    
    % Left hand side
    n = 0:N-1;
    W = exp(-1j*2*pi/N);      
    lhs_cfshifting = (W.^(-k0*n)).*g;
    G_shifted = fft(lhs_cfshifting); 
    real_lhs_cfshifting = real(G_shifted); % Real part of the signal
    imag_lhs_cfshifting = imag(G_shifted); % Imaginary part of the signal 
    
    % Right hand side
    k = n;
    G=fft(g);
    RHS_ctshifting = G(mod(k-k0,N)+1);
    real_rhs_cfshifting = real(RHS_ctshifting); % Real part of the signal
    imag_rhs_cfshifting = imag(RHS_ctshifting); % Imaginary part of the signal

    % Plot both sides 
    axes(handles.lhs_plot1);
    stem(real_lhs_cfshifting);
    title('Circular Frequency-Shifting - LHS Real Part');
    xlabel('Index');
    ylabel('Amplitude');
   
    axes(handles.lhs_plot2);
    stem(imag_lhs_cfshifting);
    title('Circular Frequency-Shifting  - LHS Imaginary Part');
    xlabel('Index');
    ylabel('Amplitude')
    
    axes(handles.rhs_plot1);
    stem(real_rhs_cfshifting)
    title('Circular Frequency-Shifting  - RHS Real Part');
    xlabel('Index');
    ylabel('Amplitude')
    
    axes(handles.rhs_plot2);
    stem(imag_rhs_cfshifting)
    title('Circular Frequency-Shifting  - RHS Imaginary Part');
    xlabel('Index');
    ylabel('Amplitude')
    
% Save output signals
    save('Outputs\Circular Frequency-Shifting\lhs_real_circular_freq_shifting.txt','real_lhs_cfshifting','-ascii');
    save('Outputs\Circular Frequency-Shifting\lhs_imag_circular_freq_shifting.txt','imag_lhs_cfshifting','-ascii');
    save('Outputs\Circular Frequency-Shifting\rhs_real_circular_freq_shifting.txt','real_rhs_cfshifting','-ascii');
    save('Outputs\Circular Frequency-Shifting\rhs_imag_circular_freq_shifting.txt','imag_rhs_cfshifting','-ascii');
end 
    
function frequency_delay_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frequency_delay as text
%        str2double(get(hObject,'String')) returns contents of frequency_delay as a double


% --- Executes during object creation, after setting all properties.
function frequency_delay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequency_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text2.
function text2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
