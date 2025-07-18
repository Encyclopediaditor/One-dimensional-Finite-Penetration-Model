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
T = {'config','medium','config','','Wall loc',2, '\n %%%% 1.2 Medium mechanics','�а岼��';
    'config','medium','fai','','medium.\phi',3, '%% Mohr-Coulomb''s friction angle','�а����Ħ����';
    'config','medium','Y','','medium.Y',4, '%% Compression strength','�а���Ͽ�ѹǿ��';
    'config','medium','E','','medium.E',5, '%% Young''s modulus','�а��������ģ��';
    'config','medium','f','','medium.f',5, '%% Tension strength','�а���Ͽ���ǿ��';
    'config','medium','rho0','','medium.rho0',1, '%% static density \n','�а���Ͼ�̬�ܶ�';
    'config','medium','A','','A',4, '','��ǻ����ģ�Ͳ���A';
    'config','medium','B','','B',1, '','��ǻ����ģ�Ͳ���B';
    'config','medium','mu','','\mu',1, '\n','��ǻ����ģ�Ͳ�����';
    'config','medium','psi','','\psi',1, '\n','�Ӵ��Ǧ�';
    'config','medium','free_edge','','free edge',6, '%% Can be true or false \n \n %%%% 1.3 Projectile geometry','�Ƿ��Ǳ߼�ЧӦ';
    'config','projectile','config','','',7, '%% Syntax curve','�䵯������';
    'config','projectile','config_name','','',1, '%% Syntax curve name','�䵯����������';
    'config','projectile','beta','','\beta',1, '%% Geometry ratio','�䵯��������';
    'config','projectile','num_mesh','','num_{mesh}',1, '%% Horizontal mesh distribution \n \n %%%% 1.4 Projectile physics','�䵯��ֵ�Ԫ��';
    'config','projectile','bar','','bar',0, '%% Now support: ''Constant''; ''Variable''; ''Love''; ''MH''','�䵯�ṹ��Ӧ��ģ��'; 
    'config','projectile','beam','','beam',0, '%% Now support: ''Euler''; ''Timoshenko''','�䵯�ṹ��Ӧ��ģ��'; 
    'config','projectile','xi','','\xi',1, '%% Damping ratio','�䵯�ṹ��Ӧ����ϵ��';    
    'config','projectile','plastic','','plastic',6, '%% Can be true or false \n%% Type of constitution, now support: ''1.kinematic''; ''2.independent''; ''3.isotropic''','�Ƿ�������';
    'config','projectile','consti','','consti',1, '\n','�䵯���Ա�������';    
    'config','projectile','rho','','\rho',1, '%% Material''s static density','�䵯�����ܶ�';
    'config','projectile','E','','E',5, '%% Material''s Young''s modulus','�䵯���ϵ���ģ��';
    'config','projectile','G','','G',5, '%% Material''s Shear modulus','�䵯���ϼ���ģ��';
    'config','projectile','Y','','Y',5, '%% Material''s Yield Strength','�䵯��������ǿ��';
    'config','projectile','D','','D',5, '%% Material''s Tangent modulus \n','�䵯��������ģ��';
    'config','projectile','v0','','v_0',1, '%% Initial velocity','�䵯���ٶ�';
    'config','projectile','fai','','\phi',3, '%% Initial angle of fall','�䵯���Ž�';
    'config','projectile','alpha','','\alpha',3, '%% Initial angle of attack','�䵯������';
    'config','projectile','omega','','\omega',1, '%% Initial angular velocity \n \n%%%% 2. Simulation options','�䵯�����ٶ�';
    'simulation','coupled','','','coupled',6, '%% Can be true or false','�Ƿ���ϼ���';
    'simulation','parallel','','','parallel',6, '%% Can be true or false','�Ƿ��м���';
    'simulation','dt_default','','','dt_{default}',1, '%% Standard time variation','�ο�ʱ�䲽��';
    'simulation','t_max','','','t_{max}',1, '%% Maximun simulation time','������ʱ��';
    'simulation','vmin','','','vmin',1, '%% Minmum velocity \n \n%%%% 3. Plot options','��С�䵯�ٶ�';   
    'plot','frame_option','','','frame option',0, '%% Now support: ''Time''; ''Data''','���Ʊ�׼';
    'plot','num_frame','','','num_{frame}',1, '%% Number of frames','������֡��';
    'plot','saving','','','saving',6,'%% Can be true or false \n \n%% For vibration analysis only','�Ƿ񱣴���';
    'plot','vibration_analysis','','','vibration analysis',6, '%% Can be true or false','���нṹ��Ӧ����';
    'plot','vibration','option','','vibration.option',0, '%% Now support: ''X''; ''Y''; ''N''; ''M''; ''EA'';  ''GA''; ''Sigma''; ''Epsilon''; ''PlasticEp''; ''Ac''; ''V'' and their combination','�ṹ��Ӧ������';
    'plot','vibration','modal','','modal solver',6, '%% Can be true or false','�Ƿ�ʹ��ģ̬����';
    'plot','vibration','modal_plot','','modal',0, '%% Now support:  ''''; ''Curve''; ''Color''','ģ̬ʾ��ͼ���Ʒ���';
    'plot','vibration','tip_fix','','tip fix',6, '%% Can be true or false','�Ƿ�Ե����������';
    'plot','vibration','buttom_fix','','buttom fix',6, '%% Can be true or false','�Ƿ��β�ǽ�������';
    'plot','vibration','radial','','radial',6, '%% Can be true or false','�Ƿ���MHģ���п��Ǿ�������';
    'plot','vibration','expression','','animation',0, '%% Now support: ''animation''; ''bisect''; ''mesh''','�����﷽ʽ';
    'plot','vibration','location','','location',1, '%% Can be decimal or decimal vertor  \n \n%% For history animation only','��С����ʾ������Ϣλ��';
    'plot','history_animation','','','history animation',6, '%% Can be true or false','���ƹ��̶���';
    'plot','animation','projectile','map','map',0, '%% Now support:  ''''; ''Normal''; ''Shear''; ''Overall''; ''Vibration''','�����䵯��ɫ����';
    'plot','animation','projectile','num_mesh','num_{mesh}',1, '%% Projectile mesh distribution, for plot only','�����䵯����Ԫ��';
    'plot','animation','medium','map','medium.map',0, '%% Now support: ''''; ''Stress''; ''Component''','�����а���ɫ����';
    'plot','animation','medium','num_mesh','medium.num_{mesh}',1, '%% Medium mesh distribution, for plot only','�����䵯����Ԫ��';
    'plot','animation','num_source','','num_{source}',1, '%% Number of force sources','����Ӧ��Դ��';
    'plot','animation','transparency','','transparency',1, '%% Ranges from 0 to 1 \n \n%% For other plot only','����͸����';
    'plot','other_plot','','','other plot',6, '%% Can be true or false','���в�����ͼ';
    'plot','other','x_loc','','x_{loc}',0, '%% Can be ''center'' or ''top'' \n %% Can be ''x'',''t'',''y'',''vx'',''vy'',''v'',''a'',''alpha'',''fai'',''psi'',''omega'' and their combination','������ͼ�ο���';
    'plot','other','x','','plot_x',0, '\n %% Can be ''x'',''t'',''y'',''vx'',''vy'',''v'',''a'',''alpha'',''fai'',''psi'',''omega'' and their combination','������ͼx����';
    'plot','other','y','','plot_y',0, '\n \n %%%% 4. Options binding','������ͼy����';
    'oval','d','','','d',1,'','';
    'oval','l2d','','','l2d',1,'','';
    'oval','CRH','','','CRH',1,'','';
    'oval','dt','','','dt',1,'','';
    'oval','ls2l','','','l_s2l',1,'','';
    'oval','b2d','','','b2d',1,'','';
    'oval','CRH2','','','CRH2',1,'',''};
end