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
        name = {'上一步','下一步',...
                '','','工程名','','','','欢迎使用一维有限元侵彻模型引导！如果您想要新建工程，请输入工程名，并点击“下一步”；如果您有想要修改的工程文件，点击“加载”后再进入下一步。','此处将显示各项说明','','',...
                '','','','','','','','',...
                'pushbutton1','加载','pushbutton3','pushbutton4','pushbutton5',...
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
        name = {'上一步','下一步',...
                'B/(kg/m^3)','2700','μ','0.02','ψ','3','','此处将显示各项说明','靶沿坐标增量/m','0'...
                '','','','','','','A/MPa','100',...
                '生成','','','撤回','',...
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
        name = {'上一步','下一步',...
                '原始密度/(kg/m^3)','2400','','','','','','此处将显示各项说明','','',...
                '库伦摩擦角/°','5','抗压强度/MPa','30','杨氏模量/GPa','30','抗拉强度/MPa','3'...                
                '','','','','',...
                '','','考虑边缘效应','是|否','靶板参数','','','',...
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
        name = {'上一步','下一步',...
                '轴向位移','1','周向位移','2','曲率半径','0','','此处将显示各项说明','','',...
                '','','','','','','弹体名','Oval',...
                '生成','撤回','下一曲线','卵形计算','',...
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
        name = {'上一步','下一步',...
                '硬化类型','2','屈服强度/MPa','1400','切线模量/GPa','21','','此处将显示各项说明','','',...
                '密度/(kg/m^3)','7850','杨氏模量/GPa','210','剪切模量/GPa','83','阻尼比','0'...                
                '','','','','',...
                '弹体变形分析','是|否','是否考虑塑性','是|否','射弹材料参数','','','',...
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
        name = {'上一步','下一步',...
                '初始攻角/°','0','初始角速度/(rad/s)','0','','','','此处将显示各项说明','','',...
                '几何缩比','0.001','网格数','300','初速度/(m/s)','600','初始着角/°','0',...
                '','','','','',...
                '杆模型','Constant|Variable|Love|MH','梁模型','Euler|Timoshenko','射弹物理参数','listbox3','listbox4','listbox5',...
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
        name = {'上一步','下一步',...
                '输出帧数','200','保存结果','','','','','此处将显示各项说明','','',...
                '默认时步/s','1e-5','最长时间/s','1','最小速度/(m/s)','1','绘制标准',''...                
                '','','','','',...
                '弹靶耦合','是|否','并行计算','是|否','仿真设置','','','',...
                '','','时间|数据','是|否',''};
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
            name0 = '此处将显示各项说明';
        else
            show = {'on','on',...
                    'off','off','off','off','off','off','off','on','off','off',...
                    'off','off','off','off','off','off','off','off',...
                    'off','off','off','off','off',...
                    'on','on','off','off','on','off','off','off',...
                    'off','off','off','off','off'};
            name0 = '弹体变形分析已禁用';
        end
        name = {'上一步','下一步',...
                '展示变量','Sigma','变量展示方式','','截面位置','0.3,0.5,0.7','',name0,'','',...
                '模态展示方式','','弹尖修正','','弹尾修正','','考虑径向力',''...                
                '','','','','',...
                '是否进行','是|否','模态方法','是|否','弹体变形设置','无|曲线|云图','','',...
                '是|否','是|否','是|否','无|动画|截面曲线|瀑布图',''};
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
        name = {'上一步','下一步',...
                '','','','','','','','此处将显示各项说明','','',...
                'x变量','t,x,x','y变量','alpha,y,fai','','','',''...                
                '','','','','',...
                '是否进行','是|否','参考点','质心|弹尖','参数绘图设置','','','',...
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
        name = {'上一步','下一步',...
                '透明度','0.3','','','','','','此处将显示各项说明','','',...
                '靶板颜色含义','','射弹纵向单元数','18','靶板横纵单元数','30','应力源数','5'...                
                '','','','','',...
                '是否进行','是|否','射弹颜色含义','无颜色|正应力|剪应力|总应力|弹体振动','动画设置','无颜色|应力|弹塑裂区','','',...
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
        name = {'上一步','完成',...
                '','','','','','','','此处将显示各项说明','','',...
                '','','','','','','','',...
                '绑定','撤回','','','',...
                '','','','','参数绑定','','无可添加参数','无绑定对',...
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
    handles.listbox4.String = '无可添加参数';
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
    handles.listbox5.String = '无绑定对';
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
          temp = questdlg('是否已完成所有设置？','退出','是','否','是'); 
          if strcmp(temp, '是')
              save([info.project_name '_info.mat'],'info','binding')
              msgbox(['设置文件已保存至同文件夹下的' info.project_name '_info.mat，可通过main_execution.m载入运行'],'保存成功')
          end
       end
       
    case 1
        errordlg('数值型参数输入错误。若需输入多组工况，请用英文逗号'',''隔开不同条件','error')
    case 2
        errordlg('材料参数数量应为材料数量的整数倍。请用英文逗号'',''隔开不同条件','error')
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
        handles.edit4.String = ['剖面线矩阵：' str];
        
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
            handles.edit4.String = '从列表里选择要绑定的参数对（至少两个），点击“确定”以绑定';
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
        handles.edit4.String = ['剖面线矩阵：' str];
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
            handles.edit4.String = '需要有已生成绑定对才能撤回';
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
        title = '卵形计算';
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
        handles.edit4.String = '空腔膨胀模型：σ = A + Bv^2，注意单位';
    case 3
        handles.edit4.String = '靶板静态密度，仅在靶板动画中使用';
    case 4
        handles.edit4.String = '剖面线从弹尖向弹尾的水平方向位移，无量纲（后续通过几何缩比设置）';
    case 5
        handles.edit4.String = '可选：1,2,3，分别代表动态、独立、各向同性塑性硬化。若有多段剖面线，一个值对应一段剖面线下的材料，中间用逗号隔开';
    case 6
        handles.edit4.String = '射弹轴线与质心速度的初始夹角';
    case 7
        handles.edit4.String = '动画总帧数——仅对需要画动画的仿真结果适用';
    case 8
        handles.edit4.String = ['可为''X''; ''Y''; ''N''; ''M''; ''EA''; ''GA''; ''Sigma''; ''Epsilon''; ''PlasticEp''; ''Ac''; ''V''中的一个或组合，多选时选项用英文逗号隔开。'...
            '它们分别表示：轴向位移X、纵向位移Y（由弯矩引起）、压力N、弯矩M、实时拉压刚度EA、实时剪切刚度GA、轴向应力Sigma、轴向应变Epsilon、等效塑性应变PlasticEp、轴向加速度Ac、径向应变V（内陷与外凸，由轴力引起）'];
    case 10
        handles.edit4.String = '射弹和靶板的着色透明度';
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
        handles.edit4.String = '工程名是所有生成文件名的默认前缀';
    case 2
        handles.edit4.String = '空腔膨胀模型：τ = μ(A + Bv^2)，μ无量纲';
    case 4
        handles.edit4.String = '剖面线从弹尖向周的竖直方向位移，无量纲（后续通过几何缩比设置）';
    case 5
        handles.edit4.String = '弹体材料屈服强度。若有多段剖面线，一个值对应一段剖面线下的材料，中间用逗号隔开';
    case 6
        handles.edit4.String = '射弹垂直于侵彻平面的初始角速度';
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
        handles.edit4.String = '接触角ψ，°，弹体表面切向与侵彻方向夹角小于ψ时受力衰减';
    case 4
        handles.edit4.String = '此段位移的曲率半径。当输入0时，认为该段位移为直线。若为CRH格式，可通过“卵形计算”来转换';
    case 5
        handles.edit4.String = '弹体材料切线模量。若有多段剖面线，一个值对应一段剖面线下的材料，中间用逗号隔开';
    case 8
        handles.edit4.String = '结构响应变量的时程图所对应的截面位置。0到1之间的数或组合向量。0代表弹尾，1代表弹头';    
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
        handles.edit4.String = '靶板竖直放置，靶沿包括前沿和后沿。初始前沿坐标为0。输入坐标增量，点击“生成”来设置新沿坐标';
    case 5
        handles.edit4.String = '结构响应分析中梁和杆模型通用的阻尼系数';
    case 6
        handles.edit4.String = '射弹轴向差分单元数。计算复杂度O(n)';
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
        handles.edit4.String = '摩尔-库伦模型中的应力边界参数，仅在靶板动画中使用';
    case 5
        handles.edit4.String = '弹体材料密度。若有多段剖面线，一个值对应一段剖面线下的材料，中间用逗号隔开';
    case 6
        handles.edit4.String = '将弹体尺寸由无量纲转化为m的单位';
    case 7
        handles.edit4.String = '解算器的参考标准时间步长';
    case 9
        handles.edit4.String = '支持x, t, y, vx, vy, v, a, alpha（攻角）, fai（着角）, psi（倾斜角）, omega（角速度）之一或组合，组合用逗号隔开';
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
        handles.edit4.String = '单轴抗压强度，仅在靶板动画中使用';
    case 5
        handles.edit4.String = '弹体材料杨氏模量。若有多段剖面线，一个值对应一段剖面线下的材料，中间用逗号隔开';
    case 6
        handles.edit4.String = '射弹的轴向网格划分数量，影响整体计算精度';
    case 7
        handles.edit4.String = '若仿真时间超过最大时间，仿真停止';
    case 9
        handles.edit4.String = '支持x, t, y, vx, vy, v, a, alpha（攻角）, fai（着角）, psi（倾斜角）, omega（角速度）之一或组合，组合用逗号隔开';
    case 10
        handles.edit4.String = '仅影响着色精度';
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
        handles.edit4.String = '单轴抗压杨氏模量，仅在靶板动画中使用';
    case 5
        handles.edit4.String = '弹体材料剪切模量。若有多段剖面线，一个值对应一段剖面线下的材料，中间用逗号隔开';
    case 6
        handles.edit4.String = '射弹质心初速度';
    case 7
        handles.edit4.String = '若射弹质心速度小于停止速度，仿真停止';
    case 10
        handles.edit4.String = '仅影响着色精度';
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
        handles.edit4.String = '单轴抗拉强度，仅在靶板动画中使用';
    case 4
        handles.edit4.String = '给弹体起名，方便绘图时打标签';
    case 5
        handles.edit4.String = '结构响应分析中梁和杆模型通用的阻尼系数';
    case 6
        handles.edit4.String = '射弹轴线与靶板法线的初始夹角';
    case 10
        handles.edit4.String = '影响靶板应力计算精度，过多会出现奇异问题';
end

function listbox1_Callback(hObject, eventdata, handles)
global page

switch page 
    case 5
        handles.edit4.String = '关键选项';
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
        handles.edit4.String = '射弹结构响应分析中的杆模型，可为Constant, Variable, Love, MH中的一个';
    case 7        
        handles.edit4.String = '是否对射弹侵彻和结构响应耦合计算';
    case 9
        handles.edit4.String = '参数绘图将不同参数在侵彻过程中的变化通过绘图表示';
        change = {'listbox2','text_e','text6','edit6','text7','edit7'};
        if handles.listbox1.Value == 2
            Change_visibility(handles,change,'off')
        else
            Change_visibility(handles,change,'on')
        end
    case 10
        handles.edit4.String = '动画可完整反映侵彻全过程';
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
        handles.edit4.String = '已在第5页设置，若需修改请回退';
end

function listbox2_Callback(hObject, eventdata, handles)
global page info

switch page
    case 3
        handles.edit4.String = '边缘效应包括前沿的开坑和后沿的冲塞，目前只适用于混凝土';
    case 5
        handles.edit4.String = '关键选项';
        change = {'text1','edit1','text2','edit2','text3','edit3'};
        if handles.listbox2.Value == 2
            Change_visibility(handles,change,'off')
        else
            Change_visibility(handles,change,'on')
        end
    case 6
        handles.edit4.String = '射弹结构响应分析中的梁模型，可为Euler或Timoshenko';
    case 7
        handles.edit4.String = '并行计算对多工况大规模仿真适用。一般不需要';
    case 8
        handles.edit4.String = '是否使用模态方法进行变形计算';
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
        handles.edit4.String = '数据点的来源（质心或弹尖）';
    case 10
        handles.edit4.String = '射弹表面可着色，颜色可表达多种含义。若选择“弹体振动”，则需在第8页设置展示变量';
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
        handles.edit4.String = '如何展示模态分析的初步结果';
    case 10
        handles.edit4.String = '靶板表面可着色，颜色可表达三种含义';
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
            handles.edit4.String = '所有参数均已绑定';
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
        handles.edit4.String = '已生成的绑定参数对';
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
        handles.edit4.String = '是否对弹尖进行奇异修正';
end

function listbox6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox7_Callback(hObject, eventdata, handles)
global page
switch page
    case 7
        handles.edit4.String = '"时间"规定两帧动画之间的仿真时间相同；“数据”规定两帧动画之间的计算节点数相同';
    case 8
        handles.edit4.String = '是否对弹尾（尾盖）进行刚度修正';
end

function listbox7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox8_Callback(hObject, eventdata, handles)
global page
switch page
    case 7
        handles.edit4.String = '"时间"规定两帧动画之间的仿真时间相同；“数据”规定两帧动画之间的计算节点数相同';
    case 8
        handles.edit4.String = '是否考虑弹体径向受力';
end

function listbox8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox9_Callback(hObject, eventdata, handles)
global page
switch page
    case 7
        handles.edit4.String = '若保存结果，则文件会出现在程序所在文件夹内';
    case 9
        handles.edit4.String = '如何展示结构响应的结果';
end
function listbox9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
