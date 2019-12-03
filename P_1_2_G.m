function varargout = P_1_2_G(varargin)
% P_1_2_G MATLAB code for P_1_2_G.fig
%      P_1_2_G, by itself, creates a new P_1_2_G or raises the existing
%      singleton*.
%
%      H = P_1_2_G returns the handle to a new P_1_2_G or the handle to
%      the existing singleton*.
%
%      P_1_2_G('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in P_1_2_G.M with the given input arguments.
%
%      P_1_2_G('Property','Value',...) creates a new P_1_2_G or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before P_1_2_G_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to P_1_2_G_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help P_1_2_G

% Last Modified by GUIDE v2.5 21-Oct-2015 15:52:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @P_1_2_G_OpeningFcn, ...
                   'gui_OutputFcn',  @P_1_2_G_OutputFcn, ...
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


% --- Executes just before P_1_2_G is made visible.
function P_1_2_G_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to P_1_2_G (see VARARGIN)

% Choose default command line output for P_1_2_G
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes P_1_2_G wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = P_1_2_G_OutputFcn(hObject, eventdata, handles) 
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




%clear all;

data=importdata('Shuffled_Dataset2.data');
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

xtrain=data(1:trainNo,1:2);
ytrain=data(1:trainNo,3);

xval=data(trainNo+1:trainNo+valNo,1:2);
yval=data(trainNo+1:trainNo+valNo,3);

xtest=data(trainNo+valNo+1:end,1:2);
ytest=data(trainNo+valNo+1:end,3);

try
    term_cond=handles.Term_Cond;
catch e
    term_cond=0;
end

try
    MaxEpochNo=handles.Max_Epoch;
catch e
    MaxEpochNo=100;
end

try
    MinErrorRate=handles.Max_Error;
catch e
    MinErrorRate=0.1;
end

% try
%     etha=handles.Learning_Rate;
% catch e
%     etha=0.9;
% end

try
    etha=str2double(get(handles.etha,'String'));
catch e
    etha=0.2;
end

W1=rand(3,1);
W1=rand(3,1);
W2=rand(3,1);
W3=rand(3,1);

bias=1;










if(term_cond==0) %%%Termination Condition is Reaching Maximum Epoch No


	%%%%%%%%%%%%%%%%%%        Training the Network
	for i=1:MaxEpochNo
		
		for j=1:trainNo
		
		
			NetIn(1)=W1(1)*xtrain(j,1)+W2(1)*xtrain(j,2)+W3(1)*bias;
			NetIn(2)=W1(2)*xtrain(j,1)+W2(2)*xtrain(j,2)+W3(2)*bias;
			NetIn(3)=W1(3)*xtrain(j,1)+W2(3)*xtrain(j,2)+W3(3)*bias;
			y(1)=1/(1+exp(-NetIn(1)));
			y(2)=1/(1+exp(-NetIn(2)));
			y(3)=1/(1+exp(-NetIn(3)));
			
			t=ytrain(j);
			
			delta(1)=t-y(1);
			delta(2)=t-y(2);
			delta(3)=t-y(3);
			
			W1(1)=W1(1)+delta(1)*etha*xtrain(j,1);
			W2(1)=W2(1)+delta(1)*etha*xtrain(j,2);
			W3(1)=W3(1)+delta(1)*etha*bias;
			
			W1(2)=W1(2)+delta(2)*etha*xtrain(j,1);
			W2(2)=W2(2)+delta(2)*etha*xtrain(j,2);
			W3(2)=W3(2)+delta(2)*etha*bias;
			
			W1(3)=W1(3)+delta(3)*etha*xtrain(j,1);
			W2(3)=W2(3)+delta(3)*etha*xtrain(j,2);
			W3(3)=W3(3)+delta(3)*etha*bias;
			
		end
		
		%%%%%%%%%%% Computing Training Error in this Epoch
		err_sum=zeros(3,1);
		for j=1:trainNo
			
			NetIn(1)=W1(1)*xtrain(j,1)+W2(1)*xtrain(j,2)+W3(1)*bias;
			NetIn(2)=W1(2)*xtrain(j,1)+W2(2)*xtrain(j,2)+W3(2)*bias;
			NetIn(3)=W1(3)*xtrain(j,1)+W2(3)*xtrain(j,2)+W3(3)*bias;
			y(1)=1/(1+exp(-NetIn(1)));
			y(2)=1/(1+exp(-NetIn(2)));
			y(3)=1/(1+exp(-NetIn(3)));
            
            t=ytrain(j);
			
			if(abs(y(1)-t)>0.001)
				err_sum(1)=err_sum(1)+1;
            end
            
            if(abs(y(2)-t)>0.001)
				err_sum(2)=err_sum(2)+1;
            end
            
            if(abs(y(3)-t)>0.001)
				err_sum(3)=err_sum(3)+1;
            end
			
		end
		Train_Error(i,1)=err_sum(1)/trainNo;
        Train_Error(i,2)=err_sum(2)/trainNo;
        Train_Error(i,3)=err_sum(3)/trainNo;
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
		%%%%%%%%%%% Computing Testing Error in this Epoch
		err_sum=zeros(3,1);
		for j=1:testNo
			
			NetIn(1)=W1(1)*xtest(j,1)+W2(1)*xtest(j,2)+W3(1)*bias;
			NetIn(2)=W1(2)*xtest(j,1)+W2(2)*xtest(j,2)+W3(2)*bias;
			NetIn(3)=W1(3)*xtest(j,1)+W2(3)*xtest(j,2)+W3(3)*bias;
			y(1)=1/(1+exp(-NetIn(1)));
			y(2)=1/(1+exp(-NetIn(2)));
			y(3)=1/(1+exp(-NetIn(3)));
			
            t=ytest(j);
            
			if(abs(y(1)-t)>0.001)
				err_sum(1)=err_sum(1)+1;
            end
            
            if(abs(y(2)-t)>0.001)
				err_sum(2)=err_sum(2)+1;
            end
            
            if(abs(y(3)-t)>0.001)
				err_sum(3)=err_sum(3)+1;
            end
            
			
		end
		Test_Error(i,1)=err_sum(1)/testNo;
        Test_Error(i,2)=err_sum(2)/testNo;
        Test_Error(i,3)=err_sum(3)/testNo;
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
	end



	
else %%%Termination Condition is Reaching Minimum Error Rate
    i=0;
	
	ErrorRate=1;

	while(ErrorRate>MinErrorRate)
		
		i=i+1; %%%%%%%%%% incrementing epoch counter
		for j=1:trainNo
		
		
			NetIn(1)=W1(1)*xtrain(j,1)+W2(1)*xtrain(j,2)+W3(1)*bias;
			NetIn(2)=W1(2)*xtrain(j,1)+W2(2)*xtrain(j,2)+W3(2)*bias;
			NetIn(3)=W1(3)*xtrain(j,1)+W2(3)*xtrain(j,2)+W3(3)*bias;
			y(1)=1/(1+exp(-NetIn(1)));
			y(2)=1/(1+exp(-NetIn(2)));
			y(3)=1/(1+exp(-NetIn(3)));
			
			t=ytrain(j);
			
			delta(1)=t-y(1);
			delta(2)=t-y(2);
			delta(3)=t-y(3);
			
			W1(1)=W1(1)+delta(1)*etha*xtrain(j,1);
			W2(1)=W2(1)+delta(1)*etha*xtrain(j,2);
			W3(1)=W3(1)+delta(1)*etha*bias;
			
			W1(2)=W1(2)+delta(2)*etha*xtrain(j,1);
			W2(2)=W2(2)+delta(2)*etha*xtrain(j,2);
			W3(2)=W3(2)+delta(2)*etha*bias;
			
			W1(3)=W1(3)+delta(3)*etha*xtrain(j,1);
			W2(3)=W2(3)+delta(3)*etha*xtrain(j,2);
			W3(3)=W3(3)+delta(3)*etha*bias;
			
		end
	
		%%%%%%%%%%% Computing Training Error in this Epoch
		err_sum=zeros(3,1);
		for j=1:trainNo
			
			NetIn(1)=W1(1)*xtrain(j,1)+W2(1)*xtrain(j,2)+W3(1)*bias;
			NetIn(2)=W1(2)*xtrain(j,1)+W2(2)*xtrain(j,2)+W3(2)*bias;
			NetIn(3)=W1(3)*xtrain(j,1)+W2(3)*xtrain(j,2)+W3(3)*bias;
			y(1)=1/(1+exp(-NetIn(1)));
			y(2)=1/(1+exp(-NetIn(2)));
			y(3)=1/(1+exp(-NetIn(3)));
			
            t=ytrain(j);
            
			if(abs(y(1)-t)>0.001)
				err_sum(1)=err_sum(1)+1;
            end
            
            if(abs(y(2)-t)>0.001)
				err_sum(2)=err_sum(2)+1;
            end
            
            if(abs(y(3)-t)>0.001)
				err_sum(3)=err_sum(3)+1;
			end
			
		end
		Train_Error(i,1)=err_sum(1)/trainNo;
        Train_Error(i,2)=err_sum(2)/trainNo;
        Train_Error(i,3)=err_sum(3)/trainNo;
        
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
		%%%%%%%%%%% Computing Testing Error in this Epoch
		err_sum=zeros(3,1);
		for j=1:testNo
			
			NetIn(1)=W1(1)*xtest(j,1)+W2(1)*xtest(j,2)+W3(1)*bias;
			NetIn(2)=W1(2)*xtest(j,1)+W2(2)*xtest(j,2)+W3(2)*bias;
			NetIn(3)=W1(3)*xtest(j,1)+W2(3)*xtest(j,2)+W3(3)*bias;
			y(1)=1/(1+exp(-NetIn(1)));
			y(2)=1/(1+exp(-NetIn(2)));
			y(3)=1/(1+exp(-NetIn(3)));
			
			t=ytest(j);
            
            if(abs(y(1)-t)>0.001)
				err_sum(1)=err_sum(1)+1;
            end
            
            if(abs(y(2)-t)>0.001)
				err_sum(2)=err_sum(2)+1;
            end
            
            if(abs(y(3)-t)>0.001)
				err_sum(3)=err_sum(3)+1;
			end
			
		end
		Test_Error(i,1)=err_sum(1)/testNo;
        Test_Error(i,2)=err_sum(2)/testNo;
        Test_Error(i,3)=err_sum(3)/testNo;
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
	
end




end

handles.TrainError=Train_Error;
guidata(hObject,handles);

handles.TestError=Test_Error;
guidata(hObject,handles);

handles.W1=W1;
guidata(hObject,handles);

handles.W2=W2;
guidata(hObject,handles);

handles.W3=W3;
guidata(hObject,handles);

figure
plot([Train_Error(:,1)';Test_Error(:,1)']');
title('Perceptron #1 Error Rates');
% plot([Train_Error(:,1)';Test_Error(:,1)';Train_Error(:,2)';Test_Error(:,2)';Train_Error(:,3)';Test_Error(:,3)']');
ylim([0,1]);
legend('Training Error1','Testing Error1');
%legend('Training Error1','Testing Error1','Training Error2','Testing Error2','Training Error3','Testing Error3');
figure
plot([Train_Error(:,2)';Test_Error(:,2)']');
title('Perceptron #2 Error Rates');
ylim([0,1]);
legend('Training Error2','Testing Error2');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot([Train_Error(:,3)';Test_Error(:,3)']');
title('Perceptron #3 Error Rates');
ylim([0,1]);
legend('Training Error3','Testing Error3');


d2=importdata('Dataset2.data');
figure
b0=W3(1)/W2(1);
 b1=W1(1)/W2(1);
x=2:5;
 f=-b0-b1*x;
 plot(x,f);
title('Perceptron #1 Classification');
 hold
scatter(d2(1:50,1),d2(1:50,2));
 scatter(d2(51:150,1),d2(51:150,2));
 hold
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 figure
b0=W3(2)/W2(2);
 b1=W1(2)/W2(2);
x=2:5;
 f=-b0-b1*x;
 plot(x,f);
 title('Perceptron #2 Classification');
 hold
scatter(d2(1:50,1),d2(1:50,2));
 scatter(d2(51:150,1),d2(51:150,2));
 hold
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 figure
b0=W3(3)/W2(3);
 b1=W1(3)/W2(3);
x=2:5;
 f=-b0-b1*x;
 plot(x,f);
 title('Perceptron #3 Classification');
 hold
scatter(d2(1:50,1),d2(1:50,2));
 scatter(d2(51:150,1),d2(51:150,2));
%  hold
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 axes(handles.Current_Plot);
plot(handles.Current_Plot,[Train_Error(:,1)';Test_Error(:,1)';Train_Error(:,2)';Test_Error(:,2)';Train_Error(:,3)';Test_Error(:,3)']');
handles.Current_Plot.Title.String='All Error Rates';
ylim([0,1]);
legend(handles.Current_Plot,'Training Error1','Testing Error1','Training Error2','Testing Error2','Training Error3','Testing Error3');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 axes(handles.Loaded_Plot);
 x=2:5;
b0=W3(1)/W2(1);
 b1=W1(1)/W2(1);
 f=-b0-b1*x;
 plot(handles.Loaded_Plot,x,f);
 handles.Loaded_Plot.Title.String='All Classification';
 hold
 b0=W3(2)/W2(2);
 b1=W1(2)/W2(2);
 f=-b0-b1*x;
 plot(handles.Loaded_Plot,x,f);
 b0=W3(3)/W2(3);
 b1=W1(3)/W2(3);
 f=-b0-b1*x;
 plot(handles.Loaded_Plot,x,f);
 legend(handles.Loaded_Plot,'Line P1','Line P2','Line P3');
scatter(d2(1:50,1),d2(1:50,2));
 scatter(d2(51:150,1),d2(51:150,2));
 
















% --- Executes on selection change in Term_Cond_Slct.
function Term_Cond_Slct_Callback(hObject, eventdata, handles)
% hObject    handle to Term_Cond_Slct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Term_Cond_Slct contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Term_Cond_Slct
Term_Cond=get(hObject,'Value');
handles.Term_Cond=Term_Cond;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Term_Cond_Slct_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Term_Cond_Slct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Max_Epoch_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Max_Epoch_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Max_Epoch_Edit as text
%        str2double(get(hObject,'String')) returns contents of Max_Epoch_Edit as a double
Max_Epoch=str2double(get(hObject,'String'));
handles.Max_Epoch=Max_Epoch;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Max_Epoch_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_Epoch_Edit (see GCBO)
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
Max_Error=str2double(get(hObject,'String'));
handles.Max_Error=Max_Error;
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


% --- Executes on button press in Laod_btn.
function Laod_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Laod_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    Name=handles.Load_FileName;
catch e
    Name='Untitled';
end
Ws=importdata(strcat(Name,'.Weights'));
W1=Ws(1,:);
W2=Ws(2,:);
W3=Ws(3,:);

Errors=importdata(strcat(Name,'.Errors'));
N=size(Errors,1);
Train_Error=Errors(1:N/2,:);
Test_Error=Errors((N/2)+1:end,:);


figure
plot([Train_Error(:,1)';Test_Error(:,1)']');
title('Perceptron #1 Error Rates');
% plot([Train_Error(:,1)';Test_Error(:,1)';Train_Error(:,2)';Test_Error(:,2)';Train_Error(:,3)';Test_Error(:,3)']');
ylim([0,1]);
legend('Training Error1','Testing Error1');
%legend('Training Error1','Testing Error1','Training Error2','Testing Error2','Training Error3','Testing Error3');
figure
plot([Train_Error(:,2)';Test_Error(:,2)']');
title('Perceptron #2 Error Rates');
ylim([0,1]);
legend('Training Error2','Testing Error2');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot([Train_Error(:,3)';Test_Error(:,3)']');
title('Perceptron #3 Error Rates');
ylim([0,1]);
legend('Training Error3','Testing Error3');



d2=importdata('Dataset2.data');
figure
b0=W3(1)/W2(1);
 b1=W1(1)/W2(1);
x=2:5;
 f=-b0-b1*x;
 plot(x,f);
title('Perceptron #1 Classification');
 hold
scatter(d2(1:50,1),d2(1:50,2));
 scatter(d2(51:150,1),d2(51:150,2));
 hold
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 figure
b0=W3(2)/W2(2);
 b1=W1(2)/W2(2);
x=2:5;
 f=-b0-b1*x;
 plot(x,f);
 title('Perceptron #2 Classification');
 hold
scatter(d2(1:50,1),d2(1:50,2));
 scatter(d2(51:150,1),d2(51:150,2));
 hold
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 figure
b0=W3(3)/W2(3);
 b1=W1(3)/W2(3);
x=2:5;
 f=-b0-b1*x;
 plot(x,f);
 title('Perceptron #3 Classification');
 hold
scatter(d2(1:50,1),d2(1:50,2));
 scatter(d2(51:150,1),d2(51:150,2));
%  hold



figure
plot([Train_Error(:,1)';Test_Error(:,1)';Train_Error(:,2)';Test_Error(:,2)';Train_Error(:,3)';Test_Error(:,3)']');
title('All Error Rates');
ylim([0,1]);
legend('Training Error1','Testing Error1','Training Error2','Testing Error2','Training Error3','Testing Error3');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 x=2:5;
b0=W3(1)/W2(1);
 b1=W1(1)/W2(1);
 f=-b0-b1*x;
 plot(x,f);
 title('All Classification');
 hold
 b0=W3(2)/W2(2);
 b1=W1(2)/W2(2);
 f=-b0-b1*x;
 plot(x,f);
 b0=W3(3)/W2(3);
 b1=W1(3)/W2(3);
 f=-b0-b1*x;
 plot(x,f);
 legend('Line P1','Line P2','Line P3');
scatter(d2(1:50,1),d2(1:50,2));
 scatter(d2(51:150,1),d2(51:150,2));
 





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



function Train_Ratio_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Train_Ratio_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Train_Ratio_Edit as text
%        str2double(get(hObject,'String')) returns contents of Train_Ratio_Edit as a double
Train_Ratio=str2double(get(hObject,'String'));
handles.Train_Ratio=Train_Ratio;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Train_Ratio_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Train_Ratio_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Valid_Ratio_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Valid_Ratio_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Valid_Ratio_Edit as text
%        str2double(get(hObject,'String')) returns contents of Valid_Ratio_Edit as a double
Valid_Ratio=str2double(get(hObject,'String'));
handles.Valid_Ratio=Valid_Ratio;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Valid_Ratio_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Valid_Ratio_Edit (see GCBO)
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



function Learning_Rate_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Learning_Rate_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Learning_Rate_Edit as text
%        str2double(get(hObject,'String')) returns contents of Learning_Rate_Edit as a double
Learning_Rate=str2double(get(hObject,'String'));
handles.Learning_Rate=Learning_Rate;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Learning_Rate_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Learning_Rate_Edit (see GCBO)
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
