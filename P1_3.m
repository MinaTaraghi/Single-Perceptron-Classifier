function varargout = P1_3(varargin)
% P1_3 MATLAB code for P1_3.fig
%      P1_3, by itself, creates a new P1_3 or raises the existing
%      singleton*.
%
%      H = P1_3 returns the handle to a new P1_3 or the handle to
%      the existing singleton*.
%
%      P1_3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in P1_3.M with the given input arguments.
%
%      P1_3('Property','Value',...) creates a new P1_3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before P1_3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to P1_3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help P1_3

% Last Modified by GUIDE v2.5 21-Oct-2015 23:50:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @P1_3_OpeningFcn, ...
                   'gui_OutputFcn',  @P1_3_OutputFcn, ...
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


% --- Executes just before P1_3 is made visible.
function P1_3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to P1_3 (see VARARGIN)

% Choose default command line output for P1_3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes P1_3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = P1_3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Start_btn.
function Start_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Start_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear all;


data=importdata('Shuffled_Dataset3.data');
TotalNo=size(data,1);
for i=1:TotalNo
    temp=data(i,3);
    data(i,3)=data(i,1)*data(i,1);
    data(i,4)=data(i,2)*data(i,2);
    data(i,5)=temp;
end

try
    train_p=handles.Train_Ratio;
catch e
    train_p=0.7;
end

try
    val_p=handles.Valid_Ratio;
catch e
    val_p=0;
end

test_p=1-train_p-val_p;
trainNo=floor(TotalNo*train_p);
valNo=floor(TotalNo*val_p);
testNo=TotalNo-trainNo-valNo;

xtrain=data(1:trainNo,1:4);
ytrain=data(1:trainNo,5);

xval=data(trainNo+1:trainNo+valNo,1:4);
yval=data(trainNo+1:trainNo+valNo,5);

xtest=data(trainNo+valNo+1:end,1:4);
ytest=data(trainNo+valNo+1:end,5);

try
    term_cond=handles.term_cond;
catch e
    term_cond=0;
end

try
    MaxEpochNo=handles.Max_Epoch;
catch e
    MaxEpochNo=100;
end

try
    MinErrorRate=handles.Max_Error_Rate;
catch e
    MinErrorRate=0.1;
end

try
    eta=handles.Learning_Rate;
catch e
    eta=0.9;
end

try
    eta=str2double(get(handles.etha,'String'));
catch e
    eta=0.2;
end

W1=zeros(MaxEpochNo,1);
W2=zeros(MaxEpochNo,1);
W3=zeros(MaxEpochNo,1);
W4=zeros(MaxEpochNo,1);
W5=zeros(MaxEpochNo,1);
W1(1)=rand;
W2(1)=rand;
W3(1)=rand;
W4(1)=rand;
W5(1)=rand;


bias=1;


if(term_cond==0) %%%Termination Condition is Reaching Maximum Epoch No


	%%%%%%%%%%%%%%%%%%        Training the Network
	for i=1:MaxEpochNo
		
		for j=1:trainNo
            NetIn=W1(i)*xtrain(j,1)+W2(i)*xtrain(j,2)+W3(i)*xtrain(j,3)+W4(i)*xtrain(j,4)+W5(i)*bias;
            y=1/(1+exp(-NetIn));
            t=ytrain(j);
            delta=t-y;
            
            W1(i)=W1(i)+delta*eta*xtrain(j,1);
			W2(i)=W2(i)+delta*eta*xtrain(j,2);
			W3(i)=W3(i)+delta*eta*xtrain(j,3);
			W4(i)=W4(i)+delta*eta*xtrain(j,4);
			W5(i)=W5(i)+delta*eta*bias;
        end
        
        %%%%%%%%%%Coputing Trainig Error for this epoch
        err_sum=0;
        NetIn=W1(i)*xtrain(j,1)+W2(i)*xtrain(j,2)+W3(i)*xtrain(j,3)+W4(i)*xtrain(j,4)+W5(i)*bias;
        y=1/(1+exp(-NetIn));
        t=ytrain(j);
        
         if(abs(y-t)>0.001)
				err_sum=err_sum+1;
         end
    Train_Error(i)=err_sum/trainNo;
    
    %%%%%%%%%%%% Computing Testing Error for this Epoch
    err_sum=0;
    for j=1:testNo
        NetIn=W1(i)*xtest(j,1)+W2(i)*xtest(j,2)+W3(i)*xtest(j,3)+W4(i)*xtest(j,4)+W5(i)*bias;
        y=1/(1+exp(-NetIn));
        t=ytrain(j);
        
         if(abs(y-t)>0.001)
				err_sum=err_sum+1;
         end
    end
    Test_Error(i)=err_sum/testNo;
    end    
else
    i=0;
    TestError=1;
    	%%%%%%%%%%%%%%%%%%        Training the Network
	while(TestError>MinErrorRate)
        i=i+1;
		
		for j=1:trainNo
            NetIn=W1(i)*xtrain(j,1)+W2(i)*xtrain(j,2)+W3(i)*xtrain(j,3)+W4(i)*xtrain(j,4)+W5(i)*bias;
            y=1/(1+exp(-NetIn));
            t=ytrain(j);
            delta=t-y;
            
            W1(i)=W1(i)+delta*eta*xtrain(j,1);
			W2(i)=W2(i)+delta*eta*xtrain(j,2);
			W3(i)=W3(i)+delta*eta*xtrain(j,3);
			W4(i)=W4(i)+delta*eta*xtrain(j,4);
			W5(i)=W5(i)+delta*eta*bias;
        end
        
        %%%%%%%%%%Coputing Trainig Error for this epoch
        err_sum=0;
        NetIn=W1(i)*xtrain(j,1)+W2(i)*xtrain(j,2)+W3(i)*xtrain(j,3)+W4(i)*xtrain(j,4)+W5(i)*bias;
        y=1/(1+exp(-NetIn));
        t=ytrain(j);
        
         if(abs(y-t)>0.001)
				err_sum=err_sum+1;
         end
    Train_Error(i)=err_sum/trainNo;
    
    %%%%%%%%%%%% Computing Testing Error for this Epoch
    err_sum=0;
    for j=1:testNo
        NetIn=W1(i)*xtest(j,1)+W2(i)*xtest(j,2)+W3(i)*xtest(j,3)+W4(i)*xtest(j,4)+W5(i)*bias;
        y=1/(1+exp(-NetIn));
        t=ytrain(j);
        
         if(abs(y-t)>0.001)
				err_sum=err_sum+1;
         end
    end
    Test_Error(i)=err_sum/testNo;
    end 
end

% axes(handles.Current_Plot);
% plot(handles.Current_Plot,[Train_Error;Test_Error]');
plot([Train_Error;Test_Error]');
% handles.Current_Plot.Title.String='Error Rate';
ylim([0,1]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% axes(handles.Loaded_Plot);

figure
N=size(W3,1);
syms x y
 ezplot(W1(N)*x+W2(N)*y+W3(N)*x^2+W4(N)*y^2+W5(N)==0);
 %f=-b0-b1*x;
%  plot(handles.Loaded_Plot,x,f);
%plot(x,f);
%  handles.Loaded_Plot.Title.String='All Classification';
 %%%%%%%%%%%%%%%%%%%%%%%%%
 hold
 d3=importdata('Dataset3_Sorted.data');
scatter(d3(1:53,1),d3(1:53,2));
 scatter(d3(54:150,1),d3(54:150,2));
hold

figure
plot(W1);
hold
plot(W2);
plot(W3);
plot(W4);
plot(W5);
legend('W1','W2','W3','W4','W5');


% --- Executes on selection change in Term_Cnd.
function Term_Cnd_Callback(hObject, eventdata, handles)
% hObject    handle to Term_Cnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Term_Cnd contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Term_Cnd
Term_Cond=get(hObject,'Value');
handles.Term_Cond=Term_Cond;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Term_Cnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Term_Cnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Max_Epoch_Callback(hObject, eventdata, handles)
% hObject    handle to Max_Epoch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Max_Epoch as text
%        str2double(get(hObject,'String')) returns contents of Max_Epoch as a double
Max_Epoch=str2double(get(hObject,'String'));
handles.Max_Epoch=Max_Epoch;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Max_Epoch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_Epoch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Max_Error_Callback(hObject, eventdata, handles)
% hObject    handle to Max_Error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Max_Error as text
%        str2double(get(hObject,'String')) returns contents of Max_Error as a double
Max_Error=str2double(get(hObject,'String'));
handles.Max_Error=Max_Error;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Max_Error_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_Error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Load_btn.
function Load_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Load_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Load_FileName_Callback(hObject, eventdata, handles)
% hObject    handle to Load_FileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Load_FileName as text
%        str2double(get(hObject,'String')) returns contents of Load_FileName as a double
Load_FileName=get(hObject,'String');
handles.Load_FileName=Load_FileName;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Load_FileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Load_FileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Train_Ratio_Callback(hObject, eventdata, handles)
% hObject    handle to Train_Ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Train_Ratio as text
%        str2double(get(hObject,'String')) returns contents of Train_Ratio as a double
Train_Ratio=str2double(get(hObject,'String'));
handles.Train_Ratio=Train_Ratio;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Train_Ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Train_Ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Valid_Ratio_Callback(hObject, eventdata, handles)
% hObject    handle to Valid_Ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Valid_Ratio as text
%        str2double(get(hObject,'String')) returns contents of Valid_Ratio as a double
Valid_Ratio=str2double(get(hObject,'String'));
handles.Valid_Ratio=Valid_Ratio;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Valid_Ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Valid_Ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SaveAs_btn.
function SaveAs_btn_Callback(hObject, eventdata, handles)
% hObject    handle to SaveAs_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



try
    Name=handles.SaveAs_FileName;
catch e
    Name='Untitled';
end

try
    W1=handles.W1;
catch e
    W1=zeros(3,1);
end
try
    W2=handles.W2;
catch e
    W2=zeros(3,1);
end
try
    W3=handles.W3;
catch e
    W3=zeros(3,1);
end
fID=fopen(strcat(Name,'.weights'),'w');
fprintf(fID,'%d %d %d\n',[W1(1),W1(2),W1(3)]);
fprintf(fID,'%d %d %d\n',[W2(1),W2(2),W2(3)]);
fprintf(fID,'%d %d %d\n',[W3(1),W3(2),W3(3)]);
fclose(fID);
 
fID=fopen(strcat(Name,'.Errors'),'w');
TrainError=handles.TrainError;
TestError=handles.TestError;

N=size(TrainError,1);

for i=1:N
    fprintf(fID,'%d %d %d\n',[TrainError(i,1),TrainError(i,2),TrainError(i,3)]);
end
for i=1:N
    fprintf(fID,'%d %d %d\n',[TestError(i,1),TestError(i,2),TestError(i,3)]);
end
fclose(fID);




function SaveAs_FileName_Callback(hObject, eventdata, handles)
% hObject    handle to SaveAs_FileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SaveAs_FileName as text
%        str2double(get(hObject,'String')) returns contents of SaveAs_FileName as a double
SaveAs_FileName=get(hObject,'String');
handles.SaveAs_FileName=SaveAs_FileName;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function SaveAs_FileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SaveAs_FileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Learning_Rate_Callback(hObject, eventdata, handles)
% hObject    handle to Learning_Rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Learning_Rate as text
%        str2double(get(hObject,'String')) returns contents of Learning_Rate as a double
Learning_Rate=str2double(get(hObject,'String'));
handles.Learning_Rate=Learning_Rate;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Learning_Rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Learning_Rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Current_Plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Current_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Current_Plot


% --- Executes during object creation, after setting all properties.
function Loaded_Plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Loaded_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Loaded_Plot
