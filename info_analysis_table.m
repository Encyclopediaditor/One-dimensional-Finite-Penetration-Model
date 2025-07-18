function T = info_analysis_table()
% info_analysis_table  storage of standard calculation request format
% Invoking             none
% Invoked              info_analysis; main_translation
% OUTPUT
%   T                  cell, with each coloums' different meaning
%                      1-4: structure of struct(); 5: name in legend; 6: value variation in
%                      plot; 6-0: string, 6-1: no variation, 6-2: Wall_loc type, 6-3: angle,
%                      6-4: strength, 6-5: modulus, 6-6: logical value; 6-7: projectile config name
%                      7: annotation for restoration; 8: help reading                
%%
T = {'config','medium','config','','Wall loc',2, '\n %%%% 1.2 Medium mechanics','靶板布局';
    'config','medium','fai','','medium.\phi',3, '%% Mohr-Coulomb''s friction angle','靶板材料摩擦角';
    'config','medium','Y','','medium.Y',4, '%% Compression strength','靶板材料抗压强度';
    'config','medium','E','','medium.E',5, '%% Young''s modulus','靶板材料杨氏模量';
    'config','medium','f','','medium.f',5, '%% Tension strength','靶板材料抗拉强度';
    'config','medium','rho0','','medium.rho0',1, '%% static density \n','靶板材料静态密度';
    'config','medium','A','','A',4, '','空腔膨胀模型参数A';
    'config','medium','B','','B',1, '','空腔膨胀模型参数B';
    'config','medium','mu','','\mu',1, '\n','空腔膨胀模型参数μ';
    'config','medium','psi','','\psi',1, '\n','接触角ψ';
    'config','medium','free_edge','','free edge',6, '%% Can be true or false \n \n %%%% 1.3 Projectile geometry','是否考虑边际效应';
    'config','projectile','config','','',7, '%% Syntax curve','射弹剖面线';
    'config','projectile','config_name','','',1, '%% Syntax curve name','射弹剖面线名称';
    'config','projectile','beta','','\beta',1, '%% Geometry ratio','射弹几何缩比';
    'config','projectile','num_mesh','','num_{mesh}',1, '%% Horizontal mesh distribution \n \n %%%% 1.4 Projectile physics','射弹差分单元数';
    'config','projectile','bar','','bar',0, '%% Now support: ''Constant''; ''Variable''; ''Love''; ''MH''','射弹结构响应杆模型'; 
    'config','projectile','beam','','beam',0, '%% Now support: ''Euler''; ''Timoshenko''','射弹结构响应梁模型'; 
    'config','projectile','xi','','\xi',1, '%% Damping ratio','射弹结构响应阻尼系数';    
    'config','projectile','plastic','','plastic',6, '%% Can be true or false \n%% Type of constitution, now support: ''1.kinematic''; ''2.independent''; ''3.isotropic''','是否考虑塑性';
    'config','projectile','consti','','consti',1, '\n','射弹塑性本构设置';    
    'config','projectile','rho','','\rho',1, '%% Material''s static density','射弹材料密度';
    'config','projectile','E','','E',5, '%% Material''s Young''s modulus','射弹材料弹性模量';
    'config','projectile','G','','G',5, '%% Material''s Shear modulus','射弹材料剪切模量';
    'config','projectile','Y','','Y',5, '%% Material''s Yield Strength','射弹材料屈服强度';
    'config','projectile','D','','D',5, '%% Material''s Tangent modulus \n','射弹材料切线模量';
    'config','projectile','v0','','v_0',1, '%% Initial velocity','射弹初速度';
    'config','projectile','fai','','\phi',3, '%% Initial angle of fall','射弹初着角';
    'config','projectile','alpha','','\alpha',3, '%% Initial angle of attack','射弹初攻角';
    'config','projectile','omega','','\omega',1, '%% Initial angular velocity \n \n%%%% 2. Simulation options','射弹初角速度';
    'simulation','coupled','','','coupled',6, '%% Can be true or false','是否耦合计算';
    'simulation','parallel','','','parallel',6, '%% Can be true or false','是否并行计算';
    'simulation','dt_default','','','dt_{default}',1, '%% Standard time variation','参考时间步长';
    'simulation','t_max','','','t_{max}',1, '%% Maximun simulation time','最大仿真时间';
    'simulation','vmin','','','vmin',1, '%% Minmum velocity \n \n%%%% 3. Plot options','最小射弹速度';   
    'plot','frame_option','','','frame option',0, '%% Now support: ''Time''; ''Data''','绘制标准';
    'plot','num_frame','','','num_{frame}',1, '%% Number of frames','绘制总帧数';
    'plot','saving','','','saving',6,'%% Can be true or false \n \n%% For vibration analysis only','是否保存结果';
    'plot','vibration_analysis','','','vibration analysis',6, '%% Can be true or false','进行结构响应分析';
    'plot','vibration','option','','vibration.option',0, '%% Now support: ''X''; ''Y''; ''N''; ''M''; ''EA'';  ''GA''; ''Sigma''; ''Epsilon''; ''PlasticEp''; ''Ac''; ''V'' and their combination','结构响应分析项';
    'plot','vibration','modal','','modal solver',6, '%% Can be true or false','是否使用模态方法';
    'plot','vibration','modal_plot','','modal',0, '%% Now support:  ''''; ''Curve''; ''Color''','模态示意图绘制方法';
    'plot','vibration','tip_fix','','tip fix',6, '%% Can be true or false','是否对弹尖进行修正';
    'plot','vibration','buttom_fix','','buttom fix',6, '%% Can be true or false','是否对尾盖进行修正';
    'plot','vibration','radial','','radial',6, '%% Can be true or false','是否在MH模型中考虑径向修正';
    'plot','vibration','expression','','animation',0, '%% Now support: ''animation''; ''bisect''; ''mesh''','结果表达方式';
    'plot','vibration','location','','location',1, '%% Can be decimal or decimal vertor  \n \n%% For history animation only','用小数表示的振动信息位置';
    'plot','history_animation','','','history animation',6, '%% Can be true or false','绘制过程动画';
    'plot','animation','projectile','map','map',0, '%% Now support:  ''''; ''Normal''; ''Shear''; ''Overall''; ''Vibration''','动画射弹颜色含义';
    'plot','animation','projectile','num_mesh','num_{mesh}',1, '%% Projectile mesh distribution, for plot only','动画射弹纵向单元数';
    'plot','animation','medium','map','medium.map',0, '%% Now support: ''''; ''Stress''; ''Component''','动画靶板颜色含义';
    'plot','animation','medium','num_mesh','medium.num_{mesh}',1, '%% Medium mesh distribution, for plot only','动画射弹纵向单元数';
    'plot','animation','num_source','','num_{source}',1, '%% Number of force sources','动画应力源数';
    'plot','animation','transparency','','transparency',1, '%% Ranges from 0 to 1 \n \n%% For other plot only','动画透明度';
    'plot','other_plot','','','other plot',6, '%% Can be true or false','进行参数绘图';
    'plot','other','x_loc','','x_{loc}',0, '%% Can be ''center'' or ''top'' \n %% Can be ''x'',''t'',''y'',''vx'',''vy'',''v'',''a'',''alpha'',''fai'',''psi'',''omega'' and their combination','参数绘图参考点';
    'plot','other','x','','plot_x',0, '\n %% Can be ''x'',''t'',''y'',''vx'',''vy'',''v'',''a'',''alpha'',''fai'',''psi'',''omega'' and their combination','参数绘图x变量';
    'plot','other','y','','plot_y',0, '\n \n %%%% 4. Options binding','参数绘图y变量';
    'oval','d','','','d',1,'','';
    'oval','l2d','','','l2d',1,'','';
    'oval','CRH','','','CRH',1,'','';
    'oval','dt','','','dt',1,'','';
    'oval','ls2l','','','l_s2l',1,'','';
    'oval','b2d','','','b2d',1,'','';
    'oval','CRH2','','','CRH2',1,'',''};
end