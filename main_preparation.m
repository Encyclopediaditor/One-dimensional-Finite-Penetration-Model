clear;clc;
 
info = struct();
info.project_name = 'C40_Demo2';
 %% 1 Basic configuratuion options 
 %% 1.1 Medium geometry 
info.config.medium.config = [0 2]; 
 %% 1.2 Medium mechanics
info.config.medium.fai = 0.1/180*pi; % Mohr-Coulomb's friction angle
info.config.medium.Y = 40*10^6; % Compression strength
info.config.medium.E = 40*10^9; % Young's modulus
info.config.medium.f = 4*10^6; % Tension strength
info.config.medium.rho0 = 2450; % static density 

info.config.medium.A = 200*10^6; 
info.config.medium.B = 3675; 
info.config.medium.mu = 0.09; 

info.config.medium.psi = 0.01; 

info.config.medium.free_edge = false; % Can be true or false 
 
 %% 1.3 Projectile geometry
info.config.projectile.config =  ...
    [83.81 25 150  117.08 0 0  20 1 0  30 0 0  0 0 0  0 0 0;
     75.9 0 0  0.43 1.55 3  27.89 12.2 41.25  124.93 0 0  0 -13.75 0  21.75 0 0]; % Syntax curve
info.config.projectile.config_name = 'I-1'; % Syntax curve name
info.config.projectile.beta = 0.001; % Geometry ratio
info.config.projectile.num_mesh = 400; % Horizontal mesh distribution 
 
 %% 1.4 Projectile physics
info.config.projectile.bar = 'MH'; % Now support: 'Constant'; 'Variable'; 'Love'; 'MH'
info.config.projectile.beam = 'Euler'; % Now support: 'Euler'; 'Timoshenko'
info.config.projectile.xi = 0; % Damping ratio
info.config.projectile.plastic = true; % Can be true or false 
% Type of constitution, now support: '1.kinematic'; '2.independent'; '3.isotropic'
info.config.projectile.consti = [2 2]; 

info.config.projectile.rho = [7800 1900]; % Material's static density
info.config.projectile.E = [210*10^9 100*10^6]; % Material's Young's modulus
info.config.projectile.G = [82.7423*10^9 38.462*10^6]; % Material's Shear modulus
info.config.projectile.Y = [1.6*10^9 Inf*10^9]; % Material's Yield Strength
info.config.projectile.D = [2.1*10^9 1000*10^6]; % Material's Tangent modulus 

info.config.projectile.v0 = 1450; % Initial velocity
info.config.projectile.fai = 0; % Initial angle of fall
info.config.projectile.alpha = 0; % Initial angle of attack
info.config.projectile.omega = 0; % Initial angular velocity 
 
%% 2. Simulation options
info.simulation.coupled = true; % Can be true or false
info.simulation.parallel = false; % Can be true or false
info.simulation.dt_default = 3e-06; % Standard time variation
info.simulation.t_max = 1; % Maximun simulation time
info.simulation.vmin = 900; % Minmum velocity 
 
%% 3. Plot options
info.plot.frame_option = 'Time'; % Now support: 'Time'; 'Data'
info.plot.num_frame = 100; % Number of frames
info.plot.saving = true; % Can be true or false 
 
% For vibration analysis only
info.plot.vibration_analysis = false; % Can be true or false
info.plot.vibration.option = 'Sigma'; % Now support: 'X'; 'Y'; 'N'; 'M'; 'EA';  'GA'; 'Sigma'; 'Epsilon'; 'PlasticEp'; 'Ac'; 'V' and their combination
info.plot.vibration.modal = true; % Can be true or false
info.plot.vibration.modal_plot = ''; % Now support:  ''; 'Curve'; 'Color'
info.plot.vibration.tip_fix = true; % Can be true or false
info.plot.vibration.buttom_fix = true; % Can be true or false
info.plot.vibration.radial = true; % Can be true or false
info.plot.vibration.expression = ''; % Now support: 'animation'; 'bisect'; 'mesh'
info.plot.vibration.location = [0.05 0.5]; % Can be decimal or decimal vertor  
 
% For history animation only
info.plot.history_animation = true; % Can be true or false
info.plot.animation.projectile.map = 'Vibration'; % Now support:  ''; 'Normal'; 'Shear'; 'Overall'; 'Vibration'
info.plot.animation.projectile.num_mesh = 18; % Projectile mesh distribution, for plot only
info.plot.animation.medium.map = 'Stress'; % Now support: ''; 'Stress'; 'Component'
info.plot.animation.medium.num_mesh = 30; % Medium mesh distribution, for plot only
info.plot.animation.num_source = 3; % Number of force sources
info.plot.animation.transparency = 0.1; % Ranges from 0 to 1 
 
% For other plot only
info.plot.other_plot = false; % Can be true or false
info.plot.other.x_loc = 'top'; % Can be 'center' or 'top' 
 % Can be 'x','t','y','vx','vy','v','a','alpha','fai','psi','omega' and their combination
info.plot.other.x = 't,t,t'; 
 % Can be 'x','t','y','vx','vy','v','a','alpha','fai','psi','omega' and their combination
info.plot.other.y = 'a,v,x'; 
 
 %% 4. Options binding
binding = {};

%% 5. Analysis & Save
Info = info_analysis(info, binding);
Config_generator_demo(Info, 1);
save([info.project_name '_info.mat'],'info','binding')
