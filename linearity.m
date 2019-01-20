% INEL 5309 - Digital Signal Processing
% DFT Linearity Property
% Dr. Domingo Rodríguez
% Sujeily P. Fonseca González, Joeshua Díaz González

%======================== Section Description ============================%
% This section provides tools and options to demonstrate the Linearity    %
% Property of the Discrete Fourier Transform (DFT).                       %
%=========================================================================%

function varargout = linearity(varargin)
% LINEARITY MATLAB code for linearity.fig
%      LINEARITY, by itself, creates a new LINEARITY or raises the existing
%      singleton*.
%
%      H = LINEARITY returns the handle to a new LINEARITY or the handle to
%      the existing singleton*.
%
%      LINEARITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LINEARITY.M with the given input arguments.
%
%      LINEARITY('Property','Value',...) creates a new LINEARITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before linearity_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to linearity_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help linearity

% Last Modified by GUIDE v2.5 27-May-2018 03:33:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @linearity_OpeningFcn, ...
                   'gui_OutputFcn',  @linearity_OutputFcn, ...
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


% --- Executes just before linearity is made visible.
function linearity_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to linearity (see VARARGIN)

% Choose default command line output for linearity
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
matlabImage = imread('Images\linearity_image.png');
image(matlabImage)
axis off
axis image

fig = gcf;
set(fig, 'Name', 'DFT Linearity Property');
set(fig, 'Resize', 'on');

% UIWAIT makes linearity wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = linearity_OutputFcn(hObject, eventdata, handles) 
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
[glinearity] = uigetfile('*.txt');
if isequal(glinearity, 0)
  disp('User selected Cancel');
else 
    g_linearity = fopen(glinearity);    % Open file
    C = textscan(g_linearity,'%f');     % Read data from an open text file
    gfunction = cell2mat(C);            % Convert the contents of a cell array 
                                        % into a single matrix
    fclose(g_linearity);                % Close file
    
    handles.g_function = gfunction;     % Save value of g[n] function
    guidata(hObject, handles);
end 
   

% --- Executes on button press in load_function_h.
function load_function_h_Callback(hObject, eventdata, handles)
% hObject    handle to load_function_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[hlinearity] = uigetfile('*.txt');
if isequal(hlinearity, 0)
  disp('User selected Cancel');
else 
    h_linearity = fopen(hlinearity);    % Open file
    C = textscan(h_linearity,'%f');     % Read data from an open text file
    hfunction = cell2mat(C);            % Convert the contents of a cell array 
                                        % into a single matrix
    fclose(h_linearity);                % Close file
    
    handles.h_function = hfunction;     % Save value of g[n] function
    guidata(hObject, handles);
end 


% --- Executes on button press in done.
function done_Callback(hObject, eventdata, handles)
% hObject    handle to done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Parameters for the Linearity Property
alphalinearity = str2num(get(handles.alpha,'String'));
betalinearity = str2num(get(handles.beta,'String'));

if isfield(handles,'g_function') && isfield(handles,'h_function') 
     if length(handles.g_function) == length(handles.h_function)       
        g = handles.g_function';
        h = handles.h_function';
        
        % Left hand side 
        lhs_linearity = alphalinearity*g + betalinearity*h;
        LHS_linearity = fft(lhs_linearity);
        real_lhs_linearity = real(LHS_linearity); % Real part of the signal
        imag_lhs_linearity = imag(LHS_linearity); % Imaginary part of the signal

        % Right hand side
        RHS_linearity = alphalinearity*fft(g) + betalinearity*fft(h);
        real_rhs_linearity = real(RHS_linearity); % Real part of the signal
        imag_rhs_linearity=imag(RHS_linearity);   % Imaginary part of the signal

        % Plot both sides 
        axes(handles.lhs_plot1);
        stem(real_lhs_linearity);
        title('Linearity Property - LHS Real Part');
        xlabel('Index');
        ylabel('Amplitude');

        axes(handles.lhs_plot2);
        stem(imag_lhs_linearity);
        title('Linearity Property - LHS Imaginary Part');
        xlabel('Index');
        ylabel('Amplitude')

        axes(handles.rhs_plot1);
        stem(real_rhs_linearity)
        title('Linearity Property - RHS Real Part');
        xlabel('Index');
        ylabel('Amplitude')

        axes(handles.rhs_plot2);
        stem(imag_rhs_linearity)
        title('Linearity Property - RHS Imaginary Part');
        xlabel('Index');
        ylabel('Amplitude')
     else
        disp('ERROR: Signals have different order.');
     end
else
   disp('ERROR: Both functions were not provided.');
end

% Save output signals
save('Outputs\Linearity Property\lhs_real_linearity.txt','real_lhs_linearity','-ascii');
save('Outputs\Linearity Property\lhs_imag_linearity.txt','imag_lhs_linearity','-ascii');
save('Outputs\Linearity Property\rhs_real_linearity.txt','real_rhs_linearity','-ascii');
save('Outputs\Linearity Property\rhs_imag_linearity.txt','imag_rhs_linearity','-ascii');

 
function alpha_Callback(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha as text
%        str2double(get(hObject,'String')) returns contents of alpha as a double


% --- Executes during object creation, after setting all properties.
function alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function beta_Callback(hObject, eventdata, handles)
% hObject    handle to beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of beta as text
%        str2double(get(hObject,'String')) returns contents of beta as a double


% --- Executes during object creation, after setting all properties.
function beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
