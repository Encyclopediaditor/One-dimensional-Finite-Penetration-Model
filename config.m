function varargout = config(varargin)
% CONFIG MATLAB code for config.fig
%      CONFIG, by itself, creates a new CONFIG or raises the existing
%      singleton*.
%
%      H = CONFIG returns the handle to a new CONFIG or the handle to
%      the existing singleton*.
%
%      CONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONFIG.M with the given input arguments.
%
%      CONFIG('Property','Value',...) creates a new CONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before config_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to config_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help config

% Last Modified by GUIDE v2.5 16-Jul-2025 16:12:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @config_OpeningFcn, ...
                   'gui_OutputFcn',  @config_OutputFcn, ...
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

function config_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to config (see VARARGIN)

% Choose default command line output for config
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes config wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global page vara
vara = {'pushbutton_p','pushbutton_n',...
        'text1','edit1','text2','edit2','text3','edit3','text4','edit4','text5','edit5',...
        'text6','edit6','text7','edit7','text8','edit8','text9','edit9',...
        'pushbutton1','pushbutton2','pushbutton3','pushbutton4','pushbutton5',...
        'text_s','listbox1','text_e','listbox2','text_n','listbox3','listbox4','listbox5',...
        'listbox6','listbox7','listbox8','listbox9','axes1'};
page = 1;
Page_load(hObject, eventdata, handles)

function varargout = config_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function Page_load(hObject, eventdata, handles)
global page a A A_all color_all info Cel Cel_new

switch page
    case 1
        show = {'off','on',...
                'off','off','on','on','off','off','on','on','off','off',...
                'off','off','off','off','off','off','off','off',...
                'off','on','off','off','off',...
                'off','off','off','off','off','off','off','off',...
                'off','off','off','off','off'};
        name = {'��һ��','��һ��',...
                '','','������','','','','��ӭʹ��һά����Ԫ�ֳ�ģ���������������Ҫ�½����̣������빤���������������һ���������������Ҫ�޸ĵĹ����ļ�����������ء����ٽ�����һ����','�˴�����ʾ����˵��','','',...
                '','','','','','','','',...
                'pushbutton1','����','pushbutton3','pushbutton4','pushbutton5',...
                '','','','','','','','',...
                '','','','','axes1'};
        Clear_line()
        Page_truning(handles, show, name)
        if isfield(info, 'project_name')
            handles.edit2.String = info.project_name;
        end
    case 2
        a = 0;
        A = 0;
        Clear_line()
        show = {'on','on',...
                'on','on','on','on','on','on','off','on','on','on',...
                'off','off','off','off','off','off','on','on',...
                'on','off','off','on','off',...
                'off','off','off','off','off','off','off','off',...
                'off','off','off','off','on'};
        name = {'��һ��','��һ��',...
                'B/(kg/m^3)','2700','��','0.02','��','3','','�˴�����ʾ����˵��','������������/m','0'...
                '','','','','','','A/MPa','100',...
                '����','','','����','',...
                '','','','','','','','',...
                '','','','',''};
        Page_truning(handles, show, name)
        if isfield(info, 'config')
            if isfield(info.config, 'medium')
                if isfield(info.config.medium, 'A') && isfield(info.config.medium, 'B') && isfield(info.config.medium, 'mu') && isfield(info.config.medium, 'psi') && isfield(info.config.medium, 'config')
                    handles.edit9.String = Input_check(info.config.medium.A, 10^6);
                    handles.edit1.String = Input_check(info.config.medium.B, 1);
                    handles.edit2.String = Input_check(info.config.medium.mu, 1);
                    handles.edit3.String = Input_check(info.config.medium.psi, pi/180);
                    A = info.config.medium.config;
                    Medium_plot(handles)
                end                
            end
        end
    case 3
        show = {'on','on',...
                'on','on','off','off','off','off','off','on','off','off',...
                'on','on','on','on','on','on','on','on',...
                'off','off','off','off','off',...
                'off','off','on','on','on','off','off','off',...
                'off','off','off','off','off'};
        name = {'��һ��','��һ��',...
                'ԭʼ�ܶ�/(kg/m^3)','2400','','','','','','�˴�����ʾ����˵��','','',...
                '����Ħ����/��','5','��ѹǿ��/MPa','30','����ģ��/GPa','30','����ǿ��/MPa','3'...                
                '','','','','',...
                '','','���Ǳ�ԵЧӦ','��|��','�а����','','','',...
                '','','','',''};
        Clear_line()
        Page_truning(handles, show, name)
        if isfield(info, 'config')
            if isfield(info.config, 'medium')
                if  isfield(info.config.medium, 'free_edge') && isfield(info.config.medium, 'fai') && isfield(info.config.medium, 'Y')...
                        && isfield(info.config.medium, 'E') && isfield(info.config.medium, 'f') && isfield(info.config.medium, 'rho0')
                    handles.listbox2.Value = Input_check(info.config.medium.free_edge, {true; false});
                    handles.edit6.String = Input_check(info.config.medium.fai, pi/180);
                    handles.edit7.String = Input_check(info.config.medium.Y, 10^6);
                    handles.edit8.String = Input_check(info.config.medium.E, 10^9);
                    handles.edit9.String = Input_check(info.config.medium.f, 10^6);
                    handles.edit1.String = Input_check(info.config.medium.rho0, 1);
                    listbox2_Callback(hObject, eventdata, handles)
                end                
            end
        end
    case 4
        a = [0 0 0];
        A = [];
        A_all = {};
        Clear_line()
        color_all = {[0 0 0], [1 0 0], [0 1 0], [0 0 1], [0.5 0.5 0], [0.5 0 0.5], [0 0.5 0.5],[0.5 00], [0 0.5 0], [0 0 0.5]};
        
        show = {'on','on',...
                'on','on','on','on','on','on','off','on','off','off',...
                'off','off','off','off','off','off','on','on',...
                'on','on','on','on','off',...
                'off','off','off','off','off','off','off','off',...
                'off','off','off','off','on'};
        name = {'��һ��','��һ��',...
                '����λ��','1','����λ��','2','���ʰ뾶','0','','�˴�����ʾ����˵��','','',...
                '','','','','','','������','Oval',...
                '����','����','��һ����','���μ���','',...
                '','','','','','','','',...
                '','','','',''};
        Page_truning(handles, show, name)
        if isfield(info, 'config')
            if isfield(info.config, 'projectile')
                if isfield(info.config.projectile, 'config') && isfield(info.config.projectile, 'config_name')
                    Clear_line()
                    handles.edit9.String = info.config.projectile.config_name;
                    num = info.config.projectile.config;
                    for i = 1:size(num,1)
                        temp = num(i,:);
                        if length(temp)>3
                            while temp(end-2) == 0 && temp(end-1) == 0 && temp(end) == 0
                                 temp = temp(1:end-3);
                            end
                        end
                        A = temp;
                        pushbutton1_Callback(hObject, eventdata, handles, 1)
                        pushbutton3_Callback(hObject, eventdata, handles)
                    end                  
                end                
            end
        end
    case 5
        show = {'on','on',...
                'on','on','on','on','on','on','off','on','off','off',...
                'on','on','on','on','on','on','on','on',...
                'off','off','off','off','off',...
                'on','on','on','on','on','off','off','off',...
                'off','off','off','off','off'};
        name = {'��һ��','��һ��',...
                'Ӳ������','2','����ǿ��/MPa','1400','����ģ��/GPa','21','','�˴�����ʾ����˵��','','',...
                '�ܶ�/(kg/m^3)','7850','����ģ��/GPa','210','����ģ��/GPa','83','�����','0'...                
                '','','','','',...
                '������η���','��|��','�Ƿ�������','��|��','�䵯���ϲ���','','','',...
                '','','','',''};
        Clear_line()
        Page_truning(handles, show, name)
        if isfield(info, 'config')
            if isfield(info.config, 'projectile')
                if isfield(info.config.projectile, 'rho') && isfield(info.config.projectile, 'E') && isfield(info.config.projectile, 'consti') &&...
                    isfield(info.config.projectile, 'G') && isfield(info.config.projectile, 'D') && isfield(info.config.projectile, 'plastic')  &&...
                    isfield(info.config.projectile, 'Y') && isfield(info.config.projectile, 'xi') 
                    handles.listbox2.Value = Input_check(info.config.projectile.plastic, {true; false});
                    handles.edit1.String = Input_check(info.config.projectile.consti, 1);
                    handles.edit6.String = Input_check(info.config.projectile.rho, 1);
                    handles.edit7.String = Input_check(info.config.projectile.E, 10^9);
                    handles.edit8.String = Input_check(info.config.projectile.G, 10^9);
                    handles.edit2.String = Input_check(info.config.projectile.Y, 10^6);
                    handles.edit3.String = Input_check(info.config.projectile.D, 10^9);
                    handles.edit9.String = Input_check(info.config.projectile.xi, 1);
                    listbox2_Callback(hObject, eventdata, handles)
                end                
            end
        end
        if isfield(info, 'plot')
            if isfield(info.plot, 'vibration_analysis')
                handles.listbox1.Value = Input_check(info.plot.vibration_analysis, {true; false});
                listbox1_Callback(hObject, eventdata, handles)
            end
        end
    case 6
        deformed = is_deformed(info);
        show = {'on','on',...
                'on','on','on','on','off','off','off','on','off','off',...
                'on','on','on','on','on','on','on','on',...
                'off','off','off','off','off',...
                deformed,deformed,deformed,deformed,'on','off','off','off',...
                'off','off','off','off','off'};
        name = {'��һ��','��һ��',...
                '��ʼ����/��','0','��ʼ���ٶ�/(rad/s)','0','','','','�˴�����ʾ����˵��','','',...
                '��������','0.001','������','300','���ٶ�/(m/s)','600','��ʼ�Ž�/��','0',...
                '','','','','',...
                '��ģ��','Constant|Variable|Love|MH','��ģ��','Euler|Timoshenko','�䵯�������','listbox3','listbox4','listbox5',...
                'listbox6','listbox7','listbox8','listbox9','axes1'}; 
        Clear_line()      
        Page_truning(handles, show, name)
        if isfield(info, 'config')
            if isfield(info.config, 'projectile')
                if isfield(info.config.projectile, 'bar') && isfield(info.config.projectile, 'beam') && isfield(info.config.projectile, 'beta') && isfield(info.config.projectile, 'v0')...
                        && isfield(info.config.projectile, 'fai') && isfield(info.config.projectile, 'alpha') && isfield(info.config.projectile, 'omega') && isfield(info.config.projectile, 'num_mesh')
                    handles.listbox1.Value = Input_check(info.config.projectile.bar, {'Constant'; 'Variable';'Love';'MH'});
                    handles.listbox2.Value = Input_check(info.config.projectile.beam, {'Euler'; 'Timoshenko'});
                    handles.edit6.String = Input_check(info.config.projectile.beta, 1);
                    handles.edit7.String = Input_check(info.config.projectile.num_mesh, 1);
                    handles.edit8.String = Input_check(info.config.projectile.v0, 1);
                    handles.edit9.String = Input_check(info.config.projectile.fai, pi/180);
                    handles.edit1.String = Input_check(info.config.projectile.alpha, pi/180);
                    handles.edit2.String = Input_check(info.config.projectile.omega, 1);
                end                
            end
        end
    case 7
        show = {'on','on',...
                'on','on','on','off','off','off','off','on','off','off',...
                'on','on','on','on','on','on','on','off',...
                'off','off','off','off','off',...
                'on','on','on','on','on','off','off','off',...
                'off','off','on','on','off'};
        name = {'��һ��','��һ��',...
                '���֡��','200','������','','','','','�˴�����ʾ����˵��','','',...
                'Ĭ��ʱ��/s','1e-5','�ʱ��/s','1','��С�ٶ�/(m/s)','1','���Ʊ�׼',''...                
                '','','','','',...
                '�������','��|��','���м���','��|��','��������','','','',...
                '','','ʱ��|����','��|��',''};
        Clear_line()
        Page_truning(handles, show, name)
        handles.listbox1.Enable = 'on';
        if isfield(info, 'simulation') && isfield(info, 'plot')
            if isfield(info.simulation, 'coupled') && isfield(info.simulation, 'parallel') && isfield(info.simulation, 'dt_default') && isfield(info.simulation, 't_max')...
                    && isfield(info.simulation, 'vmin') && isfield(info.plot, 'frame_option') && isfield(info.plot, 'num_frame') && isfield(info.plot, 'saving')
                handles.listbox1.Value = Input_check(info.simulation.coupled, {true; false});
                handles.listbox2.Value = Input_check(info.simulation.parallel, {true; false});
                handles.edit6.String = Input_check(info.simulation.dt_default, 1);
                handles.edit7.String = Input_check(info.simulation.t_max, 1);
                handles.edit8.String = Input_check(info.simulation.vmin, 1);
                handles.listbox8.Value = Input_check(info.plot.frame_option, {'Time'; 'Data'});
                handles.edit1.String = Input_check(info.plot.num_frame, 1);
                handles.listbox9.Value = Input_check(info.plot.saving, {true; false});
            end                
        end
    case 8
        deformed = is_deformed(info);
        MH = is_MH(info);
        handles.listbox1.Enable = 'off';
        if strcmp(deformed, 'on')
            show = {'on','on',...
                    'on','on','on','off','on','on','off','on','off','off',...
                    'on','off','on','off','on','off',MH,'off',...
                    'off','off','off','off','off',...
                    'on','on','on','on','on','on','off','off',...
                    'on','on',MH,'on','off'};
            name0 = '�˴�����ʾ����˵��';
        else
            show = {'on','on',...
                    'off','off','off','off','off','off','off','on','off','off',...
                    'off','off','off','off','off','off','off','off',...
                    'off','off','off','off','off',...
                    'on','on','off','off','on','off','off','off',...
                    'off','off','off','off','off'};
            name0 = '������η����ѽ���';
        end
        name = {'��һ��','��һ��',...
                'չʾ����','Sigma','����չʾ��ʽ','','����λ��','0.3,0.5,0.7','',name0,'','',...
                'ģ̬չʾ��ʽ','','��������','','��β����','','���Ǿ�����',''...                
                '','','','','',...
                '�Ƿ����','��|��','ģ̬����','��|��','�����������','��|����|��ͼ','','',...
                '��|��','��|��','��|��','��|����|��������|�ٲ�ͼ',''};
        Clear_line()
        Page_truning(handles, show, name)
        if isfield(info, 'plot')
            handles.listbox1.Value = Input_check(info.plot.vibration_analysis, {true; false});
            if isfield(info.plot, 'vibration')
                if isfield(info.plot.vibration, 'option') && isfield(info.plot.vibration, 'modal') && isfield(info.plot.vibration, 'modal_plot')...
                    && isfield(info.plot.vibration, 'tip_fix') && isfield(info.plot.vibration, 'buttom_fix') && isfield(info.plot.vibration, 'radial')...
                    && isfield(info.plot.vibration, 'expression') && isfield(info.plot.vibration, 'location')
                    handles.listbox2.Value = Input_check(info.plot.vibration.modal, {true; false});
                    handles.listbox3.Value = Input_check(info.plot.vibration.modal_plot, {''; 'Curve'; 'Color'});
                    handles.listbox6.Value = Input_check(info.plot.vibration.tip_fix, {true; false});
                    handles.listbox7.Value = Input_check(info.plot.vibration.buttom_fix, {true; false});
                    handles.listbox8.Value = Input_check(info.plot.vibration.radial, {true; false});
                    handles.edit1.String = info.plot.vibration.option;
                    handles.listbox9.Value = Input_check(info.plot.vibration.expression, {'';'animation'; 'bisect'; 'mesh'});
                    temp = info.plot.vibration.location;
                    temp_str = num2str(temp(1));
                    if length(temp) > 1
                        for i = 2:length(temp)
                            temp_str = [temp_str ',' num2str(temp(i))];
                        end
                    end
                    handles.edit3.String = temp_str;
                    listbox2_Callback(hObject, eventdata, handles)
                end
            end
        end
    case 9
        handles.listbox1.Enable = 'on';
        show = {'on','on',...
                'off','off','off','off','off','off','off','on','off','off',...
                'on','on','on','on','off','off','off','off',...
                'off','off','off','off','off',...
                'on','on','on','on','on','off','off','off',...
                'off','off','off','off','off'};
        name = {'��һ��','��һ��',...
                '','','','','','','','�˴�����ʾ����˵��','','',...
                'x����','t,x,x','y����','alpha,y,fai','','','',''...                
                '','','','','',...
                '�Ƿ����','��|��','�ο���','����|����','������ͼ����','','','',...
                '','','','',''};
        Clear_line()
        Page_truning(handles, show, name)
        if isfield(info, 'plot')
            if isfield(info.plot, 'other_plot') && isfield(info.plot, 'other')
                handles.listbox1.Value = Input_check(info.plot.other_plot, {true; false});
                listbox1_Callback(hObject, eventdata, handles)
                if isfield(info.plot.other, 'x_loc') && isfield(info.plot.other, 'x') && isfield(info.plot.other, 'y')
                    handles.listbox2.Value = Input_check(info.plot.other.x_loc, {'center'; 'top'});
                    handles.edit6.String = info.plot.other.x;
                    handles.edit7.String = info.plot.other.y;
                end
            end
        end
    case 10
        show = {'on','on',...
                'on','on','off','off','off','off','off','on','off','off',...
                'on','off','on','on','on','on','on','on',...
                'off','off','off','off','off',...
                'on','on','on','on','on','on','off','off',...
                'off','off','off','off','off'};
        name = {'��һ��','��һ��',...
                '͸����','0.3','','','','','','�˴�����ʾ����˵��','','',...
                '�а���ɫ����','','�䵯����Ԫ��','18','�а���ݵ�Ԫ��','30','Ӧ��Դ��','5'...                
                '','','','','',...
                '�Ƿ����','��|��','�䵯��ɫ����','����ɫ|��Ӧ��|��Ӧ��|��Ӧ��|������','��������','����ɫ|Ӧ��|��������','','',...
                '','','','',''};
        Clear_line()
        Page_truning(handles, show, name)
        if isfield(info, 'plot')
            if isfield(info.plot, 'history_animation') && isfield(info.plot, 'animation')
                handles.listbox1.Value = Input_check(info.plot.history_animation, {true; false});
                listbox1_Callback(hObject, eventdata, handles)
                if isfield(info.plot.animation, 'num_source') && isfield(info.plot.animation, 'transparency')...
                    && isfield(info.plot.animation, 'medium') && isfield(info.plot.animation, 'projectile')
                    handles.edit9.String = Input_check(info.plot.animation.num_source, 1);
                    handles.edit1.String = Input_check(info.plot.animation.transparency, 1);
                    if isfield(info.plot.animation.medium, 'map') && isfield(info.plot.animation.projectile, 'map')...
                       && isfield(info.plot.animation.medium, 'num_mesh') && isfield(info.plot.animation.projectile, 'num_mesh')
                        handles.listbox2.Value = Input_check(info.plot.animation.projectile.map, {''; 'Normal'; 'Shear'; 'Overall'; 'Vibration'});
                        handles.listbox3.Value = Input_check(info.plot.animation.medium.map, {''; 'Stress'; 'Component'});
                        handles.edit7.String = Input_check(info.plot.animation.projectile.num_mesh, 1);
                        handles.edit8.String = Input_check(info.plot.animation.medium.num_mesh, 1);
                    end
                end
            end
        end
    case 11
        show = {'on','on',...
                'off','off','off','off','off','off','off','on','off','off',...
                'off','off','off','off','off','off','off','off',...
                'on','on','off','off','off',...
                'off','off','off','off','on','off','on','on',...
                'off','off','off','off','off'};
        name = {'��һ��','���',...
                '','','','','','','','�˴�����ʾ����˵��','','',...
                '','','','','','','','',...
                '��','����','','','',...
                '','','','','������','','�޿���Ӳ���','�ް󶨶�',...
                '','','','','axes1'};
        Clear_line() 
        Page_truning(handles, show, name)
        T = info_analysis_table();        
        num_cel = 0;
        
        for i = 1:size(T,1)
            is_contained = true;
            for j = 1:4
                if j == 1                   
                    if isfield(info, T{i,j})
                        varname = T{i,j};
                        temp = info.(T{i,j});
                    else
                        is_contained = false;
                        break
                    end
                else
                    if isempty(T{i,j})
                        break
                    else                     
                        if isfield(temp, T{i,j})
                            varname = [varname '.' T{i,j}];
                            temp = temp.(T{i,j});
                        else
                            is_contained = false;
                            break
                        end
                    end
                end
            end
            if is_contained
                if iscell(temp)
                    if num_cel == 0
                        Cel = {varname, temp, T{i,8}};
                    else
                        Cel = [Cel; {varname, temp, T{i,8}}];
                    end
                    num_cel = num_cel + 1;
                end
            end
        end
        
        if num_cel > 0
            str = '';
            for i = 1:num_cel
                str = [str '|' Cel{i,3}];
            end
            handles.listbox4.String = str(2:end);
        end
        Cel_new = {};
end  

function Page_truning(handles, show, name)
global vara 
for i = 1:length(vara) 
     key = handles.(vara{i});
     if contains(vara{i},'listbox')
         key.Value = 1;
     end
     key.Visible = show{i};
     if i < length(vara)
        key.String = name{i};
     end
end  

function [num, str] = Projectile_config(B)
num = [];
str = [];

if ~isempty(B)
    len = length(B{1});
    for i = 1:length(B)
        if length(B{i}) > len
            len = length(B{i});
        end
    end
    
    num = zeros(length(B),len);
    for j = 1:length(B)
        for i = 1:len
            if i == 1 && j == 1
                str = '[';                            
            end
            
            if i == 1
                str = [str num2str(B{j}(i))];
                num(j,i) = B{j}(i);
            elseif i <= length(B{j})
                str = [str ' ' num2str(B{j}(i))];
                num(j,i) = B{j}(i);
            else
                str = [str ' 0'];
            end
            
            if i == len
                if j == length(B)
                    str = [str ']'];
                else
                    str = [str ';'];
                end
            end
        end
    end    
    
end

function  Clear_line()
global line_all
legend('off')
if ~isempty(line_all)
    for i = 1:length(line_all)
       if ~isnumeric(line_all{i})
          delete(line_all{i}) 
       end
    end
    line_all = {};
end

function Medium_plot(handles)
global A line_all
    if isempty(A)
        A = 0;
    end
    Clear_line()
    if mod(length(A),2) == 1
        if length(A) == 1
            axes(handles.axes1)
            line_all{1} = rectangle('Position',[0,-1.75,8,3.5],'FaceColor',[0 0 0.7],'EdgeColor','none');
            axis([-2 8 -1.75 1.75])
        else
            axes(handles.axes1)
            for i = 1:floor(length(A)/2)
                line_all{i} = rectangle('Position',[A(2*i-1),-A(end)/3,A(2*i)-A(2*i-1),A(end)*2/3],'FaceColor',[0 0 0.7],'EdgeColor','none');
            end
            line_all{i+1} = rectangle('Position',[A(end),-A(end)/3,A(end)/5*4,A(end)*2/3],'FaceColor',[0 0 0.7],'EdgeColor','none');
            axis([-A(end)/5 9*A(end)/5 -A(end)/3 A(end)/3])
        end
    else
        axes(handles.axes1)
        for i = 1:length(A)/2
            line_all{i} = rectangle('Position',[A(2*i-1),-A(end)/3,A(2*i)-A(2*i-1),A(end)*2/3],'FaceColor',[0 0 0.7],'EdgeColor','none');
        end
        axis([-A(end)/5 9*A(end)/5 -A(end)/3 A(end)/3])
    end

function Change_visibility(handles,change,state)
if ~isempty(change)
    for i = 1:length(change) 
         key = handles.(change{i});
         key.Visible = state;
    end
end

function Cel_visulization(handles)
global Cel Cel_new
if ~isempty(Cel)
    str = '';
    for i = 1:size(Cel,1)
        str = [str '|' Cel{i,3}];
    end
    handles.listbox4.String = str(2:end);
else
    handles.listbox4.String = '�޿���Ӳ���';
end

if ~isempty(Cel_new)
    str = '';
    for j = 1:length(Cel_new)
        temp = Cel_new{j};
        for i = 1:size(temp,1)              
            str = [str ',' temp{i,3}];
        end
        str = [str '|'];
    end
    handles.listbox5.String = str(2:end-1);
else
    handles.listbox5.String = '�ް󶨶�';
end

function text = Input_check(cel, rat)
if iscell(cel)    
    if iscell(rat)
        text = [];
        for i = 1:length(cel)
            text = [text Input_check(cel{i},rat)];
        end
    else
        text = '';
        for i = 1:length(cel)
            text = [text ',' Input_check(cel{i},rat)];          
        end
        text = text(2:end);
    end 
else
    if isempty(cel)
        text = '';
        if iscell(rat)
            for i = 1:length(rat)
                if isempty(rat{i})
                    text = i;
                    break
                end
            end
        end
    elseif islogical(cel)
       if rat{1} && cel
           text = 1;
       elseif rat{1} && ~cel
           text = 2;
       elseif rat{2} && cel
           text = 1;
       else
           text = 2;
       end
    elseif ischar(cel)
        text = 1;
        for i = 1:length(rat)
           if strcmp(rat{i},cel)
              text = i;
              break
           end
        end
    elseif length(cel) == 1
        text = num2str(cel/rat);
    else
        text = '';
        for i = 1:length(cel)
            text = [text ',' Input_check(cel(i),rat)];
        end
        text = text(2:end);
    end
end

function [cel, warning_type] = Output_check(text, rat, varargin)
warning_type = 0;

if isempty(varargin)
    if ~isnumeric(text)
        cel = split(text,',');
        if length(cel) == 1
            cel = rat*str2double(text);
            if isnan(cel)
                warning_type = 1;
                return
            end
        else
            for i = 1:length(cel)
               cel{i} = rat*str2double(cel{i});
               if isnan(cel{i})
                   warning_type = 1;
                   return
               end
            end
        end
    else
        cel = cell(1,length(text));
        for i = 1:length(text)
           cel{i} = rat{text(i)}; 
        end
        if length(cel) == 1
           cel = cel{1}; 
        end
    end
else
    if ~contains(text,',')
        text0 = text;
        for i = 1:varargin{1}-1
            text = [text ',' text0];
        end
    end
    cel_t = split(text,',');
    if varargin{1} == 0 || mod(length(cel_t), varargin{1}) ~= 0
        cel = {};
        warning_type = 2;
        return
    else
        cel = cell(1,length(cel_t)/varargin{1});
        for i = 1:length(cel_t)/varargin{1}
            temp = zeros(1,varargin{1});
            for j = 1:varargin{1}
                temp(j) = rat*str2double(cel_t{(i-1)*varargin{1}+j});
            end
            cel{i} = temp;
        end
        if length(cel) == 1
           cel = cel{1}; 
        end
    end
end
    
function deformed = is_deformed(info)
deformed = 'off';
if isfield(info, 'plot')
    if isfield(info.plot, 'vibration_analysis')
        if iscell(info.plot.vibration_analysis)
            deformed = 'on';
        elseif info.plot.vibration_analysis
            deformed = 'on';
        end
    end
end

function MH = is_MH(info)
MH = 'off';
if isfield(info, 'config')
    if isfield(info.config, 'projectile')
        if isfield(info.config.projectile, 'bar')
            bar = info.config.projectile.bar;
            if iscell(info.config.projectile.bar)
                for i = 1:length(bar)
                    if strcmp(bar{i}, 'MH')
                        MH = 'on';
                        break
                    end
                end
            elseif strcmp(bar, 'MH')
                MH = 'on';
            end
        end
    end
end

function pushbutton_n_Callback(hObject, eventdata, handles)
global page info A A_all Cel_new
switch page
    case 1
        warning_type = 0;
        if isempty(info)
            info = struct();
        end            
        info.project_name = handles.edit2.String;
    case 2
        warning_type = zeros(1,4);
        [info.config.medium.A, warning_type(1)] = Output_check(handles.edit9.String, 10^6);
        [info.config.medium.B, warning_type(2)] = Output_check(handles.edit1.String, 1);
        [info.config.medium.mu, warning_type(3)] = Output_check(handles.edit2.String, 1);
        [info.config.medium.psi, warning_type(4)] = Output_check(handles.edit3.String, pi/180);
        info.config.medium.config = A;
    case 3
        warning_type = zeros(1,6);
        [info.config.medium.free_edge, warning_type(1)] = Output_check(handles.listbox2.Value, {true; false});
        [info.config.medium.fai, warning_type(2)] = Output_check(handles.edit6.String, pi/180);
        [info.config.medium.Y, warning_type(3)] = Output_check(handles.edit7.String, 10^6);
        [info.config.medium.E, warning_type(4)] = Output_check(handles.edit8.String, 10^9);
        [info.config.medium.f, warning_type(5)] = Output_check(handles.edit9.String, 10^6);
        [info.config.medium.rho0, warning_type(6)] = Output_check(handles.edit1.String, 1);
    case 4
        warning_type = 0;
        info.config.projectile.config_name = handles.edit9.String;
        [num, ~] = Projectile_config([A_all A]);
        if isempty(num)
            warning_type = 3;
        end
        info.config.projectile.config = num;
    case 5
        warning_type = zeros(1,9);
        len = length([A_all A]);
        [info.plot.vibration_analysis, warning_type(1)] = Output_check(handles.listbox1.Value, {true; false});
        [info.config.projectile.plastic, warning_type(2)] = Output_check(handles.listbox2.Value, {true; false});
        [info.config.projectile.consti, warning_type(3)] = Output_check(handles.edit1.String, 1, len);
        [info.config.projectile.rho, warning_type(5)] = Output_check(handles.edit6.String, 1, len);
        [info.config.projectile.E, warning_type(6)] = Output_check(handles.edit7.String, 10^9, len);
        [info.config.projectile.G, warning_type(7)] = Output_check(handles.edit8.String, 10^9, len);
        [info.config.projectile.Y, warning_type(8)] = Output_check(handles.edit2.String, 10^6, len);
        [info.config.projectile.D, warning_type(9)] = Output_check(handles.edit3.String, 10^9, len);
        [info.config.projectile.xi, warning_type(10)] = Output_check(handles.edit9.String, 1);
    case 6
        warning_type = zeros(1,8);
        [info.config.projectile.bar, warning_type(1)] = Output_check(handles.listbox1.Value, {'Constant'; 'Variable';'Love';'MH'});
        [info.config.projectile.beam, warning_type(2)] = Output_check(handles.listbox2.Value, {'Euler'; 'Timoshenko'});
        [info.config.projectile.beta, warning_type(3)] = Output_check(handles.edit6.String, 1);
        [info.config.projectile.num_mesh, warning_type(4)] = Output_check(handles.edit7.String, 1);
        [info.config.projectile.v0, warning_type(5)] = Output_check(handles.edit8.String, 1);
        [info.config.projectile.fai, warning_type(6)] = Output_check(handles.edit9.String, pi/180);
        [info.config.projectile.alpha, warning_type(7)] = Output_check(handles.edit1.String, pi/180);
        [info.config.projectile.omega, warning_type(8)] = Output_check(handles.edit2.String, 1);
    case 7
        warning_type = zeros(1,8);
        [info.simulation.coupled, warning_type(1)] = Output_check(handles.listbox1.Value, {true; false});
        [info.simulation.parallel, warning_type(2)] = Output_check(handles.listbox2.Value, {true; false});
        [info.simulation.dt_default, warning_type(3)] = Output_check(handles.edit6.String, 1);
        [info.simulation.t_max, warning_type(4)] = Output_check(handles.edit7.String, 1);
        [info.simulation.vmin, warning_type(5)] = Output_check(handles.edit8.String, 1);
        [info.plot.frame_option, warning_type(6)] = Output_check(handles.listbox8.Value, {'Time'; 'Data'});
        [info.plot.num_frame, warning_type(7)] = Output_check(handles.edit1.String, 1);
        [info.plot.saving, warning_type(8)] = Output_check(handles.listbox9.Value, {true; false});
    case 8
        warning_type = zeros(1,6);
        [info.plot.vibration.modal, warning_type(1)] = Output_check(handles.listbox2.Value, {true; false});
        [info.plot.vibration.modal_plot, warning_type(2)] = Output_check(handles.listbox3.Value, {''; 'Curve'; 'Color'});
        [info.plot.vibration.tip_fix, warning_type(3)] = Output_check(handles.listbox6.Value, {true; false});
        [info.plot.vibration.buttom_fix, warning_type(4)] = Output_check(handles.listbox7.Value, {true; false});
        [info.plot.vibration.radial, warning_type(5)] = Output_check(handles.listbox8.Value, {true; false});
        info.plot.vibration.option = handles.edit1.String;
        [info.plot.vibration.expression, warning_type(6)] = Output_check(handles.listbox9.Value, {''; 'animation'; 'bisect'; 'mesh'});
        temp_str = split(strrep(handles.edit3.String, ' ', ''),',');
        temp = double(size(temp_str));
        for i = 1:length(temp)
            temp(i) = str2double(temp_str{i});
        end
        info.plot.vibration.location = temp;
    case 9
        warning_type = zeros(1,2);
        [info.plot.other_plot, warning_type(1)] = Output_check(handles.listbox1.Value, {true; false});
        [info.plot.other.x_loc, warning_type(2)] = Output_check(handles.listbox2.Value, {'center'; 'top'});
        info.plot.other.x = handles.edit6.String;
        info.plot.other.y = handles.edit7.String;
    case 10
        warning_type = zeros(1,7);
        [info.plot.history_animation, warning_type(1)] = Output_check(handles.listbox1.Value, {true; false});
        [info.plot.animation.projectile.map, warning_type(2)] = Output_check(handles.listbox2.Value, {''; 'Normal'; 'Shear'; 'Overall'; 'Vibration'});
        [info.plot.animation.medium.map, warning_type(3)] = Output_check(handles.listbox3.Value, {''; 'Stress'; 'Component'});
        [info.plot.animation.projectile.num_mesh, warning_type(4)] = Output_check(handles.edit7.String, 1);
        [info.plot.animation.medium.num_mesh, warning_type(5)] = Output_check(handles.edit8.String, 1);
        [info.plot.animation.num_source, warning_type(6)] = Output_check(handles.edit9.String, 1);
        [info.plot.animation.transparency, warning_type(7)] = Output_check(handles.edit1.String, 1);
    case 11
        warning_type = 0;
        binding = {};
        if ~isempty(Cel_new)
            for i = 1:length(Cel_new)
                temp = Cel_new{i};
                binding = [binding {temp(:,1)'}];
            end
        end
end

for i = 1:length(warning_type)
    if warning_type(i) > 0
        warning_type = warning_type(i);
        break;
    end
end

warning_type = warning_type(1);
switch warning_type
    case 0
       if page < 11
          page = page + 1;
          handles.text_extra.String = [num2str(page) '/11'];
          Page_load(hObject, eventdata, handles)
       else
          temp = questdlg('�Ƿ�������������ã�','�˳�','��','��','��'); 
          if strcmp(temp, '��')
              save([info.project_name '_info.mat'],'info','binding')
              msgbox(['�����ļ��ѱ�����ͬ�ļ����µ�' info.project_name '_info.mat����ͨ��main_execution.m��������'],'����ɹ�')
          end
       end
       
    case 1
        errordlg('��ֵ�Ͳ��������������������鹤��������Ӣ�Ķ���'',''������ͬ����','error')
    case 2
        errordlg('���ϲ�������ӦΪ����������������������Ӣ�Ķ���'',''������ͬ����','error')
end

function pushbutton_p_Callback(hObject, eventdata, handles)
global page
if page > 1
    page = page - 1;
    handles.text_extra.String = [num2str(page) '/11'];
end
Page_load(hObject, eventdata, handles)

function pushbutton1_Callback(hObject, eventdata, handles, varargin)
global page A_all line_all color_all A a x_max y_max Cel Cel_new

switch page
    case 2
        a = str2double(handles.edit5.String);
        if a > 0
            A = [A A(end)+a];
        end
        Medium_plot(handles)
    case 4
        if isempty(varargin)
            a = [str2double(handles.edit1.String), str2double(handles.edit2.String), str2double(handles.edit3.String)];
            A  = [A a];
        end
        Coord = turtle(A,500);
        axes(handles.axes1)
        if isempty(line_all)
        line_all{1} = line(max(Coord(:,1))-Coord(:,1),Coord(:,2),'displayname',['line' num2str(1+length(A_all))],'color',color_all{1});
        x_max = max(Coord(:,1));
        y_max = max(max(Coord(:,2)),max(Coord(:,1))/13*6);
        hold on
        else
        if length(A) > 3
            if ~isnumeric(line_all{end})
                delete(line_all{end})   
            end
        end
        line_all{end} = line(max(Coord(:,1))-Coord(:,1),Coord(:,2),'displayname',['line' num2str(1+length(A_all))],'color',color_all{length(line_all)});
        if x_max < max(Coord(:,1))
            x_max = max(Coord(:,1));
        end
        if y_max < max(max(Coord(:,2)),max(Coord(:,1))/5)
            y_max = max(max(Coord(:,2)),max(Coord(:,1))/5);
        end
        end
        axis([0 x_max 0 y_max])
        [~,str] = Projectile_config([A_all A]);
        handles.edit4.String = ['�����߾���' str];
        
    case 11
        if length(handles.listbox4.Value) > 1
            if isempty(Cel_new)
                Cel_new = {Cel(handles.listbox4.Value,:)};
            else
                Cel_new = [Cel_new, Cel(handles.listbox4.Value,:)];
            end
            Cel(handles.listbox4.Value,:) = [];
            handles.listbox4.Value = 1;
            Cel_visulization(handles)
        else
            handles.edit4.String = '���б���ѡ��Ҫ�󶨵Ĳ����ԣ������������������ȷ�����԰�';
        end
end

function pushbutton2_Callback(hObject, eventdata, handles)
global page A A_all line_all color_all info Cel Cel_new

switch page
    case 1
        file = uigetfile('*.mat');
        temp = load(file,'info');
        info = temp.info;
        Page_load(hObject, eventdata, handles)      
    case 4
        if length(A) > 3
            A  = A(1:end-3);
            Coord = turtle(A,500);
            axes(handles.axes1)
            delete(line_all{end})
            line_all{end} = line(max(Coord(:,1))-Coord(:,1),Coord(:,2),'displayname',['line' num2str(1+length(A_all))],'color',color_all{length(line_all)});
        else
            A = [];
            if ~isempty(line_all)
                if ~isnumeric(line_all{end})
                    delete(line_all{end})            
                    if length(line_all)>1
                        line_all{end} = 1;
                        A_all = A_all(1:end-1);
                    else
                        line_all = {};
                        A_all = {};
                    end
                else
                    if length(line_all)>1
                        line_all = line_all(1:end-1);
                        delete(line_all{end})
                        line_all{end} = 1;
                        A_all = A_all(1:end-1);
                    else
                        line_all = {};
                        A_all = {};
                    end
                end
            end       
        end
        [~,str] = Projectile_config([A_all A]);
        handles.edit4.String = ['�����߾���' str];
    case 11
        if ~isempty(Cel_new)
            Value = handles.listbox5.Value;
            for value = Value
                temp = Cel_new{value};
                for i = 1:size(temp,1)
                    Cel = [Cel ;temp(i,:)];
                end
            end
            Cel_new(Value) = [];
            handles.listbox5.Value = 1;
            Cel_visulization(handles)
        else
            handles.edit4.String = '��Ҫ�������ɰ󶨶Բ��ܳ���';
        end
end

function pushbutton3_Callback(hObject, eventdata, handles)
global page A_all A line_all;

switch page
    case 4
    if ~isnumeric(line_all{end})
        legend('location','northwest')
        A_all = [A_all, A];
        A = [];
        line_all = [line_all 1];
    end
end

function pushbutton4_Callback(hObject, eventdata, handles)
global page A

switch page
    case 2
        if length(A) > 1
            A = A(1:end-1);
        end
        Medium_plot(handles)
    case 4
        prompt = {'CRH','a (radius)'};
        title = '���μ���';
        lines = [1 1]';
        def = {'2','1'};
        answer = inputdlg(prompt,title,lines,def);
        if ~isempty(answer)
            r = str2double(answer{2});
            phi = 2*r*str2double(answer{1});
            dx = sqrt(-r^2+2*phi*r);
            handles.edit1.String = num2str(dx);
            handles.edit2.String = num2str(r);
            handles.edit3.String = num2str(phi);
        end
end

function pushbutton5_Callback(hObject, eventdata, handles)
global page A
switch page
    
end
    
function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit1_KeyPressFcn(hObject, eventdata, handles)
global page

switch page
    case 2
        handles.edit4.String = '��ǻ����ģ�ͣ��� = A + Bv^2��ע�ⵥλ';
    case 3
        handles.edit4.String = '�а徲̬�ܶȣ����ڰа嶯����ʹ��';
    case 4
        handles.edit4.String = '�����ߴӵ�����β��ˮƽ����λ�ƣ������٣�����ͨ�������������ã�';
    case 5
        handles.edit4.String = '��ѡ��1,2,3���ֱ����̬������������ͬ������Ӳ�������ж�������ߣ�һ��ֵ��Ӧһ���������µĲ��ϣ��м��ö��Ÿ���';
    case 6
        handles.edit4.String = '�䵯�����������ٶȵĳ�ʼ�н�';
    case 7
        handles.edit4.String = '������֡������������Ҫ�������ķ���������';
    case 8
        handles.edit4.String = ['��Ϊ''X''; ''Y''; ''N''; ''M''; ''EA''; ''GA''; ''Sigma''; ''Epsilon''; ''PlasticEp''; ''Ac''; ''V''�е�һ������ϣ���ѡʱѡ����Ӣ�Ķ��Ÿ�����'...
            '���Ƿֱ��ʾ������λ��X������λ��Y����������𣩡�ѹ��N�����M��ʵʱ��ѹ�ն�EA��ʵʱ���иն�GA������Ӧ��Sigma������Ӧ��Epsilon����Ч����Ӧ��PlasticEp��������ٶ�Ac������Ӧ��V����������͹������������'];
    case 10
        handles.edit4.String = '�䵯�Ͱа����ɫ͸����';
end

function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_KeyPressFcn(hObject, eventdata, handles)
global page

switch page
    case 1
        handles.edit4.String = '�����������������ļ�����Ĭ��ǰ׺';
    case 2
        handles.edit4.String = '��ǻ����ģ�ͣ��� = ��(A + Bv^2)����������';
    case 4
        handles.edit4.String = '�����ߴӵ������ܵ���ֱ����λ�ƣ������٣�����ͨ�������������ã�';
    case 5
        handles.edit4.String = '�����������ǿ�ȡ����ж�������ߣ�һ��ֵ��Ӧһ���������µĲ��ϣ��м��ö��Ÿ���';
    case 6
        handles.edit4.String = '�䵯��ֱ���ֳ�ƽ��ĳ�ʼ���ٶ�';
end

function edit3_Callback(hObject, eventdata, handles)

function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_KeyPressFcn(hObject, eventdata, handles)
global page

switch page
    case 2
        handles.edit4.String = '�Ӵ��Ǧף��㣬��������������ֳ�����н�С�ڦ�ʱ����˥��';
    case 4
        handles.edit4.String = '�˶�λ�Ƶ����ʰ뾶��������0ʱ����Ϊ�ö�λ��Ϊֱ�ߡ���ΪCRH��ʽ����ͨ�������μ��㡱��ת��';
    case 5
        handles.edit4.String = '�����������ģ�������ж�������ߣ�һ��ֵ��Ӧһ���������µĲ��ϣ��м��ö��Ÿ���';
    case 8
        handles.edit4.String = '�ṹ��Ӧ������ʱ��ͼ����Ӧ�Ľ���λ�á�0��1֮����������������0����β��1����ͷ';    
end

function edit4_Callback(hObject, eventdata, handles)

function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit5_Callback(hObject, eventdata, handles)

function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit5_KeyPressFcn(hObject, eventdata, handles)
global page

switch page
    case 2
        handles.edit4.String = '�а���ֱ���ã����ذ���ǰ�غͺ��ء���ʼǰ������Ϊ0������������������������ɡ���������������';
    case 5
        handles.edit4.String = '�ṹ��Ӧ���������͸�ģ��ͨ�õ�����ϵ��';
    case 6
        handles.edit4.String = '�䵯�����ֵ�Ԫ�������㸴�Ӷ�O(n)';
end

function edit6_Callback(hObject, eventdata, handles)

function edit6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit6_KeyPressFcn(hObject, eventdata, handles)
global page

switch page
    case 3
        handles.edit4.String = 'Ħ��-����ģ���е�Ӧ���߽���������ڰа嶯����ʹ��';
    case 5
        handles.edit4.String = '��������ܶȡ����ж�������ߣ�һ��ֵ��Ӧһ���������µĲ��ϣ��м��ö��Ÿ���';
    case 6
        handles.edit4.String = '������ߴ���������ת��Ϊm�ĵ�λ';
    case 7
        handles.edit4.String = '�������Ĳο���׼ʱ�䲽��';
    case 9
        handles.edit4.String = '֧��x, t, y, vx, vy, v, a, alpha�����ǣ�, fai���Žǣ�, psi����б�ǣ�, omega�����ٶȣ�֮һ����ϣ�����ö��Ÿ���';
end

function edit7_Callback(hObject, eventdata, handles)

function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit7_KeyPressFcn(hObject, eventdata, handles)
global page

switch page
    case 3
        handles.edit4.String = '���Όѹǿ�ȣ����ڰа嶯����ʹ��';
    case 5
        handles.edit4.String = '�����������ģ�������ж�������ߣ�һ��ֵ��Ӧһ���������µĲ��ϣ��м��ö��Ÿ���';
    case 6
        handles.edit4.String = '�䵯���������񻮷�������Ӱ��������㾫��';
    case 7
        handles.edit4.String = '������ʱ�䳬�����ʱ�䣬����ֹͣ';
    case 9
        handles.edit4.String = '֧��x, t, y, vx, vy, v, a, alpha�����ǣ�, fai���Žǣ�, psi����б�ǣ�, omega�����ٶȣ�֮һ����ϣ�����ö��Ÿ���';
    case 10
        handles.edit4.String = '��Ӱ����ɫ����';
end

function edit8_Callback(hObject, eventdata, handles)

function edit8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit8_KeyPressFcn(hObject, eventdata, handles)
global page

switch page
    case 3
        handles.edit4.String = '���Όѹ����ģ�������ڰа嶯����ʹ��';
    case 5
        handles.edit4.String = '������ϼ���ģ�������ж�������ߣ�һ��ֵ��Ӧһ���������µĲ��ϣ��м��ö��Ÿ���';
    case 6
        handles.edit4.String = '�䵯���ĳ��ٶ�';
    case 7
        handles.edit4.String = '���䵯�����ٶ�С��ֹͣ�ٶȣ�����ֹͣ';
    case 10
        handles.edit4.String = '��Ӱ����ɫ����';
end

function edit9_Callback(hObject, eventdata, handles)

function edit9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit9_KeyPressFcn(hObject, eventdata, handles)
global page

switch page
    case 3
        handles.edit4.String = '���Ό��ǿ�ȣ����ڰа嶯����ʹ��';
    case 4
        handles.edit4.String = '�����������������ͼʱ���ǩ';
    case 5
        handles.edit4.String = '�ṹ��Ӧ���������͸�ģ��ͨ�õ�����ϵ��';
    case 6
        handles.edit4.String = '�䵯������а巨�ߵĳ�ʼ�н�';
    case 10
        handles.edit4.String = 'Ӱ��а�Ӧ�����㾫�ȣ�����������������';
end

function listbox1_Callback(hObject, eventdata, handles)
global page

switch page 
    case 5
        handles.edit4.String = '�ؼ�ѡ��';
        change = {'listbox2','text_e','text1','edit1','text2','edit2','text3','edit3','text7','edit7','text8','edit8','text9','edit9'};
        if handles.listbox1.Value == 2
            Change_visibility(handles,change,'off')
        else
            Change_visibility(handles,change,'on')
            if handles.listbox2.Value == 2
                change = {'text1','edit1','text2','edit2','text3','edit3'};
                Change_visibility(handles,change,'off')
            end
        end
    case 6
        handles.edit4.String = '�䵯�ṹ��Ӧ�����еĸ�ģ�ͣ���ΪConstant, Variable, Love, MH�е�һ��';
    case 7        
        handles.edit4.String = '�Ƿ���䵯�ֳ��ͽṹ��Ӧ��ϼ���';
    case 9
        handles.edit4.String = '������ͼ����ͬ�������ֳ������еı仯ͨ����ͼ��ʾ';
        change = {'listbox2','text_e','text6','edit6','text7','edit7'};
        if handles.listbox1.Value == 2
            Change_visibility(handles,change,'off')
        else
            Change_visibility(handles,change,'on')
        end
    case 10
        handles.edit4.String = '������������ӳ�ֳ�ȫ����';
        change = {'listbox2','text_e','text6','listbox3','text7','edit7','text8','edit8','text9','edit9','text1','edit1'};
        if handles.listbox1.Value == 2
            Change_visibility(handles,change,'off')
        else
            Change_visibility(handles,change,'on')
        end
end

function listbox1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox1_KeyPressFcn(hObject, eventdata, handles)

function listbox1_ButtonDownFcn(hObject, eventdata, handles)
global page

switch page
    case 8
        handles.edit4.String = '���ڵ�5ҳ���ã������޸������';
end

function listbox2_Callback(hObject, eventdata, handles)
global page info

switch page
    case 3
        handles.edit4.String = '��ԵЧӦ����ǰ�صĿ��Ӻͺ��صĳ�����Ŀǰֻ�����ڻ�����';
    case 5
        handles.edit4.String = '�ؼ�ѡ��';
        change = {'text1','edit1','text2','edit2','text3','edit3'};
        if handles.listbox2.Value == 2
            Change_visibility(handles,change,'off')
        else
            Change_visibility(handles,change,'on')
        end
    case 6
        handles.edit4.String = '�䵯�ṹ��Ӧ�����е���ģ�ͣ���ΪEuler��Timoshenko';
    case 7
        handles.edit4.String = '���м���Զ๤�����ģ�������á�һ�㲻��Ҫ';
    case 8
        handles.edit4.String = '�Ƿ�ʹ��ģ̬�������б��μ���';
        change = {'listbox3','text6'};
        deformed = is_deformed(info);
        if strcmp(deformed, 'on')
            if handles.listbox2.Value == 2
                Change_visibility(handles,change,'off')
            else
                Change_visibility(handles,change,'on')
            end
        end
    case 9
        handles.edit4.String = '���ݵ����Դ�����Ļ򵯼⣩';
    case 10
        handles.edit4.String = '�䵯�������ɫ����ɫ�ɱ����ֺ��塣��ѡ�񡰵����񶯡��������ڵ�8ҳ����չʾ����';
end

function listbox2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox2_KeyPressFcn(hObject, eventdata, handles)

function listbox3_Callback(hObject, eventdata, handles)
global page

switch page
    case 8
        handles.edit4.String = '���չʾģ̬�����ĳ������';
    case 10
        handles.edit4.String = '�а�������ɫ����ɫ�ɱ�����ֺ���';
end

function listbox3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox3_KeyPressFcn(hObject, eventdata, handles)

function listbox4_Callback(hObject, eventdata, handles)
global page Cel

switch page
    case 11
        if ~isempty(Cel)
            if (length(handles.listbox4.Value)) == 1
                cel = Cel{handles.listbox4.Value, 2};
                str = [];
                for i = 1:length(cel)
                    if isempty(cel{i})
                        temp = '''';
                    elseif islogical(cel{i})
                        if cel{i}
                            temp = 'true';
                        else
                            temp = 'false';
                        end
                    elseif ischar(cel{i})
                        temp = ['' cel{i} ''];
                    else
                        temp = num2str(cel{i});
                    end
                    str = [str ',' temp];
                end
                handles.edit4.String = str(2:end);
            end
        else
            handles.edit4.String = '���в������Ѱ�';
        end
end

function listbox4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox4_KeyPressFcn(hObject, eventdata, handles)

function listbox5_Callback(hObject, eventdata, handles)
global page
switch page
     case 11
        handles.edit4.String = '�����ɵİ󶨲�����';
end

function listbox5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox5_KeyPressFcn(hObject, eventdata, handles)

function listbox6_Callback(hObject, eventdata, handles)
global page
switch page
    case 8
        handles.edit4.String = '�Ƿ�Ե��������������';
end

function listbox6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox7_Callback(hObject, eventdata, handles)
global page
switch page
    case 7
        handles.edit4.String = '"ʱ��"�涨��֡����֮��ķ���ʱ����ͬ�������ݡ��涨��֡����֮��ļ���ڵ�����ͬ';
    case 8
        handles.edit4.String = '�Ƿ�Ե�β��β�ǣ����иն�����';
end

function listbox7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox8_Callback(hObject, eventdata, handles)
global page
switch page
    case 7
        handles.edit4.String = '"ʱ��"�涨��֡����֮��ķ���ʱ����ͬ�������ݡ��涨��֡����֮��ļ���ڵ�����ͬ';
    case 8
        handles.edit4.String = '�Ƿ��ǵ��徶������';
end

function listbox8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox9_Callback(hObject, eventdata, handles)
global page
switch page
    case 7
        handles.edit4.String = '�������������ļ�������ڳ��������ļ�����';
    case 9
        handles.edit4.String = '���չʾ�ṹ��Ӧ�Ľ��';
end
function listbox9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
