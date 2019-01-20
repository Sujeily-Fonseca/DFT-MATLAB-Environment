% INEL 5309 - Digital Signal Processing
% Parseval's Theorem
% Dr. Domingo Rodríguez
% Sujeily P. Fonseca González, Joeshua Díaz González

%======================== Section Description ============================%
% This section provides tools and options to demonstrate the Parseval's   %
% Theorem related to the Discrete Fourier Transform (DFT).                %
%=========================================================================%

function varargout = parseval_theorem(varargin)
% PARSEVAL_THEOREM MATLAB code for parseval_theorem.fig
%      PARSEVAL_THEOREM, by itself, creates a new PARSEVAL_THEOREM or raises the existing
%      singleton*.
%
%      H = PARSEVAL_THEOREM returns the handle to a new PARSEVAL_THEOREM or the handle to
%      the existing singleton*.
%
%      PARSEVAL_THEOREM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARSEVAL_THEOREM.M with the given input arguments.
%
%      PARSEVAL_THEOREM('Property','Value',...) creates a new PARSEVAL_THEOREM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before parseval_theorem_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to parseval_theorem_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help parseval_theorem

% Last Modified by GUIDE v2.5 26-May-2018 21:42:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @parseval_theorem_OpeningFcn, ...
                   'gui_OutputFcn',  @parseval_theorem_OutputFcn, ...
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


% --- Executes just before parseval_theorem is made visible.
function parseval_theorem_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to parseval_theorem (see VARARGIN)

% Choose default command line output for parseval_theorem
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
set(hFig,'menubar','none');

% Hide the title 
set(hFig,'NumberTitle','off');

% Change background color
set(handles.axes1,'YColor','white');
grid off

%DFT Property
axes(handles.DFT_Property)
matlabImage = imread('Images\parseval_theorem_image.png');
image(matlabImage);
axis off
axis image

fig = gcf;
set(fig, 'Name', 'DFT Parseval''s Theorem');
set(fig, 'Resize', 'on');

% UIWAIT makes parseval_theorem wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = parseval_theorem_OutputFcn(hObject, eventdata, handles) 
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
[gparseval] = uigetfile('*.txt');
if isequal(gparseval,0)
  disp('User selected Cancel');
else 
    g_parseval = fopen(gparseval);    % Open file
    C = textscan(g_parseval,'%f');    % Read data from an open text file
    x = cell2mat(C);                  % Convert the contents of a cell array 
                                      % into a single matrix
    fclose(g_parseval);               % Close file
   
    g = x.';
    N = length(g);

    % Left hand side 
    lhs_parseval = sum((abs(g).^2));
    real_lhs_parseval = real(lhs_parseval); % Real part of the signal
    imag_lhs_parseval = imag(lhs_parseval); % Imaginary part of the signal
    
    % Right hand side
    G = fft(g);
    RHS_parseval = (1/N).*sum((abs(G).^2));
    real_rhs_parseval = real(RHS_parseval); % Real part of the signal
    imag_rhs_parseval=imag(RHS_parseval);   % Imaginary part of the signal
   
    % Plot both sides 
    axes(handles.lhs_plot1);
    stem(real_lhs_parseval);
    title('Parseval''s Theorem - LHS Real Part');
    xlabel('Index');
    ylabel('Amplitude');
   
    axes(handles.lhs_plot2);
    stem(imag_lhs_parseval);
    title('Parseval''s Theorem - LHS Imaginary Part');
    xlabel('Index');
    ylabel('Amplitude')
    
    axes(handles.rhs_plot1);
    stem(real_rhs_parseval)
    title('Parseval''s Theorem - RHS Real Part');
    xlabel('Index');
    ylabel('Amplitude')
    
    axes(handles.rhs_plot2);
    stem(imag_rhs_parseval)
    title('Parseval''s Theorem - RHS Imaginary Part');
    xlabel('Index');
    ylabel('Amplitude')
    
    % Save output signals
    save('Outputs\Parseval Theorem\lhs_real_parseval.txt','real_lhs_parseval','-ascii');
    save('Outputs\Parseval Theorem\lhs_imag_parseval.txt','imag_lhs_parseval','-ascii');
    save('Outputs\Parseval Theorem\rhs_real_parseval.txt','real_rhs_parseval','-ascii');
    save('Outputs\Parseval Theorem\rhs_imag_parseval.txt','imag_rhs_parseval','-ascii');   
end


function order_Callback(hObject, eventdata, handles)
% hObject    handle to order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of order as text
%        str2double(get(hObject,'String')) returns contents of order as a double


% --- Executes during object creation, after setting all properties.
function order_CreateFcn(hObject, eventdata, handles)
% hObject    handle to order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
