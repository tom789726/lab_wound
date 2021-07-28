function varargout = wound_v1(varargin)
% WOUND_V1 MATLAB code for wound_v1.fig
%      WOUND_V1, by itself, creates a new WOUND_V1 or raises the existing
%      singleton*.
%
%      H = WOUND_V1 returns the handle to a new WOUND_V1 or the handle to
%      the existing singleton*.
%
%      WOUND_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WOUND_V1.M with the given input arguments.
%
%      WOUND_V1('Property','Value',...) creates a new WOUND_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before wound_v1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to wound_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help wound_v1

% Last Modified by GUIDE v2.5 21-Jan-2021 08:00:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @wound_v1_OpeningFcn, ...
    'gui_OutputFcn',  @wound_v1_OutputFcn, ...
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


% --- Executes just before wound_v1 is made visible.
function wound_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to wound_v1 (see VARARGIN)

% Choose default command line output for wound_v1
handles.output = hObject;


% Initialise
set(handles.axes_img0,'XTick',[],'YTick',[]);
set(handles.axes_hist,'XTick',[],'YTick',[]);
set(handles.axes_img0,'visible','Off');
set(handles.axes_hist,'visible','Off');

set(handles.edit1,'String','Welcome');

% Window Size
% set(handles.figure1, 'units', 'normalized', 'position', [0.05 0.15 0.9 0.8]);
set(handles.figure1, 'units', 'normalized', 'position', [0.01 0.01 0.9 0.9]);

% Get Mouse Clicking
handles.btnDn = @(hObject,eventdata)wound_v1('axes_img0_ButtonDownFcn',hObject,eventdata,guidata(hObject));

% Hide action buttons
set(handles.Button_Fill,'Visible','Off');
set(handles.button_save,'Visible','Off');
set(handles.button_add,'Visible','Off');
set(handles.button_del,'Visible','Off');
set(handles.button_scale,'Visible','Off');
set(handles.button_scaleOK,'Visible','Off');
set(handles.edit2,'Visible','Off');
set(handles.slider1,'Visible','Off');
set(handles.edit3,'Visible','Off');

% Hide RGB scale
set(handles.axes_red,'Visible','Off');
set(handles.axes_green,'Visible','Off');
set(handles.axes_blue,'Visible','Off');



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes wound_v1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = wound_v1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit1, 'String', 'Manual Mode');



% Make OK Button & Save Button visible
set(handles.Button_Fill,'Visible','On');
set(handles.button_save,'Visible','On');

% ROI drawing tools
axes(handles.axes_img0);
h = drawfreehand('color','g');

% Pass handles
handles.h = h;
guidata(hObject, handles);




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1, 'String', 'Region Growing Tools');

% Enable buttons
set(handles.button_add,'Visible','On');
set(handles.button_del,'Visible','On');
set(handles.button_scale,'Visible','On');
set(handles.edit3,'Visible','On');
set(handles.edit2,'Visible','On');
set(handles.slider1,'Visible','On');


% Retreive image
img = handles.img;

% Catch Mouse Clicking on axes_img0
handles.img0.ButtonDownFcn = handles.btnDn;


set(handles.axes_hist,'visible','On');
axes(handles.axes_hist);
imshow(img);

% Pass handles
guidata(hObject, handles);

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_load.
function button_load_Callback(hObject, eventdata, handles)
% hObject    handle to button_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Open file dialogue
[filename path] = uigetfile({'*.*'});
path_f = fullfile(path,filename)
% handles.path = path_f;


% Read image & Display
set(handles.axes_img0,'visible','On');
img = imread(path_f);
img_d = im2double(img);

axes(handles.axes_img0);
% title(handles.axes_img0,'原始影像');
% set(get(gca, 'title'), 'string', '原始影像');
handles.img0 = imshow(img,[]); % img0 is a graphic object



% Message Display
set(handles.edit1,'String','Image Loaded');


% Pass Handles
handles.img = img;
handles.img_d = img_d;
guidata(hObject, handles);


% --- Executes on button press in button_ori.
function button_ori_Callback(hObject, eventdata, handles)
% hObject    handle to button_ori (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit1, 'String', 'Show original image');
set(handles.axes_hist,'visible','On');



img = handles.img;
axes(handles.axes_img0);
handles.img0 = imshow(img,[]);




% Histogram
axes(handles.axes_hist);
img_hist = handles.img;
imhist(img_hist);


% Show RGB value
set(handles.axes_red,'Visible','On');
set(handles.axes_green,'Visible','On');
set(handles.axes_blue,'Visible','On');

Red = img_hist(:,:,1);
Green = img_hist(:,:,2);
Blue = img_hist(:,:,3);
[yRed, x] = imhist(Red);
[yGreen, x] = imhist(Green);
[yBlue, x] = imhist(Blue);

axes(handles.axes_red);
area(yRed,'FaceColor','r');
axes(handles.axes_green);
area(yGreen,'FaceColor','g');
axes(handles.axes_blue);
area(yBlue,'FaceColor','b');


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end





% --- Executes on button press in Button_Fill.
function Button_Fill_Callback(hObject, eventdata, handles)
% hObject    handle to Button_Fill (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% OK (fill) button
set(handles.axes_hist,'visible','On');



% Fill & disable ROI
h = handles.h;
% h.FaceAlpha = 1;
% h.FaceSelectable = false;
h.InteractionsAllowed = 'none';

% Create mask & masked image
mask = createMask(h);
img = im2double(handles.img);
if (isfield(handles,'mask')) % Addition check for multiple ROI
    mask = handles.mask + mask;
end
img_mask = img.*mask;


% Show result
axes(handles.axes_hist);
imshow(img_mask);

% Area Approximation
count = sum(mask(:));
percent = count/size(img(:),1);
message = sprintf("Total pixels: %d Percent: %0.2f\%",count,percent);

if (isfield(handles,'mm'))
    message = sprintf("Area of mask: %0.2f mm^2",handles.mm*count);   
end

set(handles.edit1,'String',message);


% Pass handles
handles.img_mask = img_mask;
handles.mask = mask;

% handles.h = h;
guidata(hObject, handles);


% --- Executes on button press in button_save.
function button_save_Callback(hObject, eventdata, handles)
% hObject    handle to button_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Save button actions

% File dialogue
[filename path] = uiputfile({'img_cut.jpg'});
path_f = fullfile(path,filename)
path_m = fullfile(path,'mask.jpg');

% Retrieve ROI & mask
img_mask = handles.img_mask;
mask = handles.mask;

% Write to file
imwrite(img_mask,path_f);
imwrite(mask,path_m);


% Message display
set(handles.edit1,'String','Image Saved !');


% --- Executes on button press in button_add.
function button_add_Callback(hObject, eventdata, handles)
% hObject    handle to button_add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Retreive Current Position
pos = handles.pos;
row = pos(1);
col = pos(2);

% Region growing with seed pos
% img = handles.img_d;
% output = zeros(size(img));
% neighb = [1 0; -1 0; 0 1; 0 -1] % check 4 neighbour points
%
% axes(handles.axes_hist);
%
% for i = 1:4
%     r = row + neighb(i,1);
%     c = col + neighb(i,2);
%     img(r,c) = 255;
%     imshow(img);
%     hold on;
%     pause(1);
% end

% Region Growing (google)
img = handles.img_d;
tolerance = get(handles.edit2,'String');
tolerance = str2double(tolerance);

mask = regiongrowing(img(:,:,1),row,col,tolerance);
img_mask = img.*mask;
axes(handles.axes_hist);
imshow(img_mask,[]);

% Display message
message = sprintf("Region Growing, Seed:[%d %d], Range:[%d]",row,col,tolerance);
set(handles.edit1,'String', message);

% Pass handles
handles.img_mask = img_mask;
handles.mask = mask;
guidata(hObject,handles);

% --- Executes on button press in button_del.
function button_del_Callback(hObject, eventdata, handles)
% hObject    handle to button_del (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Button Clear Actions

% Get image
img = handles.img_d;

% Refresh both graphs
axes(handles.axes_img0);
handles.img0 = imshow(img);
handles.img0.ButtonDownFcn = handles.btnDn;
axes(handles.axes_hist);
imshow(zeros(size(img)));

% Refresh mask & mask image
handles.img_mask = img;
handles.mask = zeros(size(img));

% Hide RGB scale
set(handles.axes_red,'Visible','Off');
set(handles.axes_green,'Visible','Off');
set(handles.axes_blue,'Visible','Off');

% pass handles
guidata(hObject,handles);


% --- Executes on button press in button_scale.
function button_scale_Callback(hObject, eventdata, handles)
% hObject    handle to button_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

img = handles.img_d;
set(handles.button_scaleOK,'visible','On');

% ROI drawing tools
axes(handles.axes_img0);
lineROI = drawline('color','b');


% Pass handles
handles.line = lineROI;
guidata(hObject, handles);


% --- Executes on mouse press over axes background.
function axes_img0_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes_img0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pt = get(gca,'currentpoint');
% disp(pt);
row = round(pt(1,2));
col = round(pt(1,1));

str = sprintf("Click Detected, Row:%d Col:%d",row,col);
set(handles.edit1,'String',str);

% Restore Mouse Clicking
% set(handles.axes_img0,'ButtonDownFcn',handles.btnDn);

% Pass Current Position Data
pos = [row col];
handles.pos = pos;

guidata(hObject,handles);


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(hObject,'Value');
set(handles.edit2,'String',val);






% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_scaleOK.
function button_scaleOK_Callback(hObject, eventdata, handles)
% hObject    handle to button_scaleOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% scale OK/confirm actions

% check line ROI
if (isfield(handles,'line'))
    scale = get(handles.edit3,'String');
    scale = str2double(scale);
    disp(scale);
    
    
%   Calculate No. of pixels drawn by line ROI
    A = get(handles.line);
    pos = A.Position
    distX = abs(pos(1,1) - pos(2,1));
    distY = abs(pos(1,2) - pos(2,2));
    dist = round(sqrt(distX^2+distY^2)); % no. of pixels
    disp(dist);
    
%   Map pixel value to real dimension
    mmPerPixel = scale/dist;    
end

% Message Display
message = sprintf("scale updated, %0.2f mm/pixel",mmPerPixel);
set(handles.edit1,'String',message);

% Leaving actions
pause(1);
axes(handles.axes_img0);
handles.img0 = imshow(handles.img);

set(handles.button_scaleOK,'visible','Off');
handles.mm = mmPerPixel;
guidata(hObject,handles);
