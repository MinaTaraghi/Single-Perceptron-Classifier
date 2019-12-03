function varargout = P1_1(varargin)
% P1_1 MATLAB code for P1_1.fig
%      P1_1, by itself, creates a new P1_1 or raises the existing
%      singleton*.
%
%      H = P1_1 returns the handle to a new P1_1 or the handle to
%      the existing singleton*.
%
%      P1_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in P1_1.M with the given input arguments.
%
%      P1_1('Property','Value',...) creates a new P1_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before P1_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to P1_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help P1_1

% Last Modified by GUIDE v2.5 21-Oct-2015 12:16:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @P1_1_OpeningFcn, ...
                   'gui_OutputFcn',  @P1_1_OutputFcn, ...
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


% --- Executes just before P1_1 is made visible.
function P1_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to P1_1 (see VARARGIN)

% Choose default command line output for P1_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes P1_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% clear all;


% --- Outputs from this function are returned to the command line.
function varargout = P1_1_OutputFcn(hObject, eventdata, handles) 
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
data=importdata('Shuffled_Dataset1.data');
TotalNo=size(data,1);

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
    MaxEpochNo=handles.Max_Epoch_No;
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

W1=rand(3,1);
W2=rand(3,1);
W3=rand(3,1);
W4=rand(3,1);
W5=rand(3,1);


bias=1;


if(term_cond==0) %%%Termination Condition is Reaching Maximum Epoch No


	%%%%%%%%%%%%%%%%%%        Training the Network
	for i=1:MaxEpochNo
		
		for j=1:trainNo
		
		
			NetIn(1)=W1(1)*xtrain(j,1)+W2(1)*xtrain(j,2)+W3(1)*xtrain(j,3)+W4(1)*xtrain(j,4)+W5(1)*bias;
			NetIn(2)=W1(2)*xtrain(j,1)+W2(2)*xtrain(j,2)+W3(2)*xtrain(j,3)+W4(2)*xtrain(j,4)+W5(2)*bias;
			NetIn(3)=W1(3)*xtrain(j,1)+W2(3)*xtrain(j,2)+W3(3)*xtrain(j,3)+W4(3)*xtrain(j,4)+W5(3)*bias;
			y(1)=1/(1+exp(-NetIn(1)));
			y(2)=1/(1+exp(-NetIn(2)));
			y(3)=1/(1+exp(-NetIn(3)));
			
			switch ytrain(j)
				case 0
					t(1)=1;
					t(2)=0;
					t(3)=0;
				case 1
					t(1)=0;
					t(2)=1;
					t(3)=0;
				otherwise
					t(1)=0;
					t(2)=0;
					t(3)=1;
			end
			
			delta(1)=t(1)-y(1);
			delta(2)=t(2)-y(2);
			delta(3)=t(3)-y(3);
			
%             sss=2*MaxEpochNo;
			W1(1)=W1(1)+delta(1)*eta*xtrain(j,1);
			W2(1)=W2(1)+delta(1)*eta*xtrain(j,2);
			W3(1)=W3(1)+delta(1)*eta*xtrain(j,3);
			W4(1)=W4(1)+delta(1)*eta*xtrain(j,4);
			W5(1)=W5(1)+delta(1)*eta*bias;
			
			W1(2)=W1(2)+delta(2)*eta*xtrain(j,1);
			W2(2)=W2(2)+delta(2)*eta*xtrain(j,2);
			W3(2)=W3(2)+delta(2)*eta*xtrain(j,3);
			W4(2)=W4(2)+delta(2)*eta*xtrain(j,4);
			W5(2)=W5(2)+delta(2)*eta*bias;
			
			W1(3)=W1(3)+delta(3)*eta*xtrain(j,1);
			W2(3)=W2(3)+delta(3)*eta*xtrain(j,2);
			W3(3)=W3(3)+delta(3)*eta*xtrain(j,3);
			W4(3)=W4(3)+delta(3)*eta*xtrain(j,4);
			W5(3)=W5(3)+delta(3)*eta*bias;
			
		end
		
		%%%%%%%%%%% Computing Training Error in this Epoch
		err_sum=zeros(4,1);
		for j=1:trainNo
			
			NetIn(1)=W1(1)*xtrain(j,1)+W2(1)*xtrain(j,2)+W3(1)*xtrain(j,3)+W4(1)*xtrain(j,4)+W5(1)*bias;
			NetIn(2)=W1(2)*xtrain(j,1)+W2(2)*xtrain(j,2)+W3(2)*xtrain(j,3)+W4(2)*xtrain(j,4)+W5(2)*bias;
			NetIn(3)=W1(3)*xtrain(j,1)+W2(3)*xtrain(j,2)+W3(3)*xtrain(j,3)+W4(3)*xtrain(j,4)+W5(3)*bias;
			y(1)=1/(1+exp(-NetIn(1)));
			y(2)=1/(1+exp(-NetIn(2)));
			y(3)=1/(1+exp(-NetIn(3)));
            
            switch ytrain(j)
				case 0
					t(1)=1;
					t(2)=0;
					t(3)=0;
				case 1
					t(1)=0;
					t(2)=1;
					t(3)=0;
				otherwise
					t(1)=0;
					t(2)=0;
					t(3)=1;
            end
            
            if(abs(y(1)-t(1))>0.001)
				err_sum(1)=err_sum(1)+1;
            end
            
            if(abs(y(2)-t(2))>0.001)
				err_sum(2)=err_sum(2)+1;
            end
            
            if(abs(y(3)-t(3))>0.001)
				err_sum(3)=err_sum(3)+1;
            end
			
			[max_val,max_i]=max(y);
			if((max_i-1)~=ytrain(j))
				err_sum(4)=err_sum(4)+1;
			end
			
			
		end
		Train_Error(i,1)=err_sum(1)/trainNo;
        Train_Error(i,2)=err_sum(2)/trainNo;
        Train_Error(i,3)=err_sum(3)/trainNo;
        Train_Error(i,4)=err_sum(4)/trainNo;
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
		%%%%%%%%%%% Computing Testing Error in this Epoch
		err_sum=zeros(4,1);
		for j=1:testNo
			
			NetIn(1)=W1(1)*xtest(j,1)+W2(1)*xtest(j,2)+W3(1)*xtest(j,3)+W4(1)*xtest(j,4)+W5(1)*bias;
			NetIn(2)=W1(2)*xtest(j,1)+W2(2)*xtest(j,2)+W3(2)*xtest(j,3)+W4(2)*xtest(j,4)+W5(2)*bias;
			NetIn(3)=W1(3)*xtest(j,1)+W2(3)*xtest(j,2)+W3(3)*xtest(j,3)+W4(3)*xtest(j,4)+W5(3)*bias;
			y(1)=1/(1+exp(-NetIn(1)));
			y(2)=1/(1+exp(-NetIn(2)));
			y(3)=1/(1+exp(-NetIn(3)));
            
            switch ytest(j)
				case 0
					t(1)=1;
					t(2)=0;
					t(3)=0;
				case 1
					t(1)=0;
					t(2)=1;
					t(3)=0;
				otherwise
					t(1)=0;
					t(2)=0;
					t(3)=1;
            end
            
            if(abs(y(1)-t(1))>0.001)
				err_sum(1)=err_sum(1)+1;
            end
            
            if(abs(y(2)-t(2))>0.001)
				err_sum(2)=err_sum(2)+1;
            end
            
            if(abs(y(3)-t(3))>0.001)
				err_sum(3)=err_sum(3)+1;
            end
			
			[max_val,max_i]=max(y);
			if((max_i-1)~=ytest(j))
				err_sum(4)=err_sum(4)+1;
			end
			
		end
		Test_Error(i,1)=err_sum(1)/testNo;
        Test_Error(i,2)=err_sum(2)/testNo;
        Test_Error(i,3)=err_sum(3)/testNo;
        Test_Error(i,4)=err_sum(4)/testNo;
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
	end



	
else %%%Termination Condition is Reaching Minimum Error Rate
	ii=0;
	ErrorRate=1;

	while(ErrorRate>MinErrorRate)
		
		ii=ii+1; %%%%%%%%%% incrementing epoch counter
		for j=1:trainNo
		
		
			NetIn(1)=W1(1)*xtrain(j,1)+W2(1)*xtrain(j,2)+W3(1)*xtrain(j,3)+W4(1)*xtrain(j,4)+W5(1)*bias;
			NetIn(2)=W1(2)*xtrain(j,1)+W2(2)*xtrain(j,2)+W3(2)*xtrain(j,3)+W4(2)*xtrain(j,4)+W5(2)*bias;
			NetIn(3)=W1(3)*xtrain(j,1)+W2(3)*xtrain(j,2)+W3(3)*xtrain(j,3)+W4(3)*xtrain(j,4)+W5(3)*bias;
			y(1)=1/(1+exp(-NetIn(1)));
			y(2)=1/(1+exp(-NetIn(2)));
			y(3)=1/(1+exp(-NetIn(3)));
			
			switch ytrain(j)
				case 0
					t(1)=1;
					t(2)=0;
					t(3)=0;
				case 1
					t(1)=0;
					t(2)=1;
					t(3)=0;
				otherwise
					t(1)=0;
					t(2)=0;
					t(3)=1;
			end
			
			delta(1)=t(1)-y(1);
			delta(2)=t(2)-y(2);
			delta(3)=t(3)-y(3);
			
			W1(1)=W1(1)+delta(1)*eta*xtrain(j,1);
			W2(1)=W2(1)+delta(1)*eta*xtrain(j,2);
			W3(1)=W3(1)+delta(1)*eta*xtrain(j,3);
			W4(1)=W4(1)+delta(1)*eta*xtrain(j,4);
			W5(1)=W5(1)+delta(1)*eta*bias;
			
			W1(2)=W1(2)+delta(2)*eta*xtrain(j,1);
			W2(2)=W2(2)+delta(2)*eta*xtrain(j,2);
			W3(2)=W3(2)+delta(2)*eta*xtrain(j,3);
			W4(2)=W4(2)+delta(2)*eta*xtrain(j,4);
			W5(2)=W5(2)+delta(2)*eta*bias;
			
			W1(3)=W1(3)+delta(3)*eta*xtrain(j,1);
			W2(3)=W2(3)+delta(3)*eta*xtrain(j,2);
			W3(3)=W3(3)+delta(3)*eta*xtrain(j,3);
			W4(3)=W4(3)+delta(3)*eta*xtrain(j,4);
			W5(3)=W5(3)+delta(3)*eta*bias;
			
		end
	
		%%%%%%%%%%% Computing Training Error in this Epoch
		err_sum=zeros(4,1);
		for j=1:trainNo
			
			NetIn(1)=W1(1)*xtrain(j,1)+W2(1)*xtrain(j,2)+W3(1)*xtrain(j,3)+W4(1)*xtrain(j,4)+W5(1)*bias;
			NetIn(2)=W1(2)*xtrain(j,1)+W2(2)*xtrain(j,2)+W3(2)*xtrain(j,3)+W4(2)*xtrain(j,4)+W5(2)*bias;
			NetIn(3)=W1(3)*xtrain(j,1)+W2(3)*xtrain(j,2)+W3(3)*xtrain(j,3)+W4(3)*xtrain(j,4)+W5(3)*bias;
			y(1)=1/(1+exp(-NetIn(1)));
			y(2)=1/(1+exp(-NetIn(2)));
			y(3)=1/(1+exp(-NetIn(3)));
            
            switch ytrain(j)
				case 0
					t(1)=1;
					t(2)=0;
					t(3)=0;
				case 1
					t(1)=0;
					t(2)=1;
					t(3)=0;
				otherwise
					t(1)=0;
					t(2)=0;
					t(3)=1;
            end
            
            if(abs(y(1)-t(1))>0.001)
				err_sum(1)=err_sum(1)+1;
            end
            
            if(abs(y(2)-t(2))>0.001)
				err_sum(2)=err_sum(2)+1;
            end
            
            if(abs(y(3)-t(3))>0.001)
				err_sum(3)=err_sum(3)+1;
            end
			
			[max_val,max_i]=max(y);
			if((max_i-1)~=ytrain(j))
				err_sum(4)=err_sum(4)+1;
			end
			
		end
		Train_Error(ii,1)=err_sum(1)/trainNo;
        Train_Error(ii,2)=err_sum(2)/trainNo;
        Train_Error(ii,3)=err_sum(3)/trainNo;
        Train_Error(ii,4)=err_sum(4)/trainNo;
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
		%%%%%%%%%%% Computing Testing Error in this Epoch
		err_sum=zeros(4,1);
		for j=1:testNo
			
			NetIn(1)=W1(1)*xtest(j,1)+W2(1)*xtest(j,2)+W3(1)*xtest(j,3)+W4(1)*xtest(j,4)+W5(1)*bias;
			NetIn(2)=W1(2)*xtest(j,1)+W2(2)*xtest(j,2)+W3(2)*xtest(j,3)+W4(2)*xtest(j,4)+W5(2)*bias;
			NetIn(3)=W1(3)*xtest(j,1)+W2(3)*xtest(j,2)+W3(3)*xtest(j,3)+W4(3)*xtest(j,4)+W5(3)*bias;
			y(1)=1/(1+exp(-NetIn(1)));
			y(2)=1/(1+exp(-NetIn(2)));
			y(3)=1/(1+exp(-NetIn(3)));
			
               switch ytest(j)
				case 0
					t(1)=1;
					t(2)=0;
					t(3)=0;
				case 1
					t(1)=0;
					t(2)=1;
					t(3)=0;
				otherwise
					t(1)=0;
					t(2)=0;
					t(3)=1;
               end
            
            if(abs(y(1)-t(1))>0.001)
				err_sum(1)=err_sum(1)+1;
            end
            
            if(abs(y(2)-t(2))>0.001)
				err_sum(2)=err_sum(2)+1;
            end
            
            if(abs(y(3)-t(3))>0.001)
				err_sum(3)=err_sum(3)+1;
            end
			
			[max_val,max_i]=max(y);
			if((max_i-1)~=ytest(j))
				err_sum(4)=err_sum(4)+1;
			end
			
		end
		Test_Error(ii,1)=err_sum(1)/testNo;
        Test_Error(ii,2)=err_sum(2)/testNo;
        Test_Error(ii,3)=err_sum(3)/testNo;
        Test_Error(ii,4)=err_sum(4)/testNo;
            
			
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	ErrorRate=Test_Error(ii,4);	
	
end




end

% axes(Current_Plot);
plot([Train_Error(:,4)';Test_Error(:,4)']');
ylim([0,1]);
legend('Training Error','Testing Error');

figure
plot([Train_Error(:,1)';Test_Error(:,1)']');
title('Perceptron #1 Error Rates');
ylim([0,1]);
legend('Training Error1','Testing Error1');

figure
plot([Train_Error(:,2)';Test_Error(:,2)']');
title('Perceptron #2 Error Rates');
ylim([0,1]);
legend('Training Error2','Testing Error2');

figure
plot([Train_Error(:,3)';Test_Error(:,3)']');
title('Perceptron #3 Error Rates');
ylim([0,1]);
legend('Training Error3','Testing Error3');


















% --- Executes on selection change in Stop_Cond_Select.
function Stop_Cond_Select_Callback(hObject, eventdata, handles)
% hObject    handle to Stop_Cond_Select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Stop_Cond_Select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Stop_Cond_Select
condition=get(hObject,'Value');
term_cond=condition-1;
handles.term_cond=term_cond;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Stop_Cond_Select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stop_Cond_Select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Max_Epoch_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Max_Epoch_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Max_Epoch_edit as text
%        str2double(get(hObject,'String')) returns contents of Max_Epoch_edit as a double
Number=str2double(get(hObject,'String'));
handles.Max_Epoch_No=Number;
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function Max_Epoch_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_Epoch_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Max_Error_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Max_Error_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Max_Error_Edit as text
%        str2double(get(hObject,'String')) returns contents of Max_Error_Edit as a double
Rate=str2double(get(hObject,'String'));
handles.Max_Error_Rate=Rate;
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function Max_Error_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_Error_Edit (see GCBO)
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

%%%% Open file with name handles.Load_name

function Load_Filename_Callback(hObject, eventdata, handles)
% hObject    handle to Load_Filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Load_Filename as text
%        str2double(get(hObject,'String')) returns contents of Load_Filename as a double
Load_name=get(hObject,'String');
handles.Load_name=Load_name;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Load_Filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Load_Filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function learning_rate_edit_Callback(hObject, eventdata, handles)
% hObject    handle to learning_rate_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of learning_rate_edit as text
%        str2double(get(hObject,'String')) returns contents of learning_rate_edit as a double
Learning_Rate=str2double(get(hObject,'String'));
handles.Learning_Rate=Learning_Rate;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function learning_rate_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to learning_rate_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Train_Ratio_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Train_Ratio_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Train_Ratio_edit as text
%        str2double(get(hObject,'String')) returns contents of Train_Ratio_edit as a double
Train_Ratio=str2double(get(hObject,'String'));
handles.Train_Ratio=Train_Ratio;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Train_Ratio_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Train_Ratio_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Valid_Ratio_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Valid_Ratio_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Valid_Ratio_edit as text
%        str2double(get(hObject,'String')) returns contents of Valid_Ratio_edit as a double
Valid_Ratio=str2double(get(hObject,'String'));
handles.Valid_Ratio=Valid_Ratio;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Valid_Ratio_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Valid_Ratio_edit (see GCBO)
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



function Save_Filename_Callback(hObject, eventdata, handles)
% hObject    handle to Save_Filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Save_Filename as text
%        str2double(get(hObject,'String')) returns contents of Save_Filename as a double
Save_Filename=get(hObject,'String');
handles.Save_Filename=Save_Filename;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Save_Filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Save_Filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% function Bias_edit_Callback(hObject, eventdata, handles)
% % hObject    handle to Bias_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of Bias_edit as text
% %        str2double(get(hObject,'String')) returns contents of Bias_edit as a double
% Bias=str2double(get(hObject,'String'));
% handles.Bias=Bias;
% guidata(hObject,handles);
% 
% % --- Executes during object creation, after setting all properties.
% function Bias_edit_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to Bias_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end


% --- Executes during object creation, after setting all properties.
function Loaded_Plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Loaded_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Loaded_Plot


% --- Executes during object creation, after setting all properties.
function Current_Plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Current_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Current_Plot




function etha_Callback(hObject, eventdata, handles)
% hObject    handle to etha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of etha as text
%        str2double(get(hObject,'String')) returns contents of etha as a double
etha=str2double(get(hObject,'String'));
handles.etha=etha;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function etha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
