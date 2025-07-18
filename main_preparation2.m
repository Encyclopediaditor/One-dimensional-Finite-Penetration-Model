clear;clc;
%%  main_preparation2
%    Function: modal analysis
%    Requirement: none
%%
file_name = ['egg_test' date];
info = struct();
info.project_name = file_name;
%% 1 Basic configuratuion options
%% 1.1 Medium geometry
info.config.medium.config = 0;

%% 1.2 Medium mechanics
info.config.medium.fai = 0.1/180*pi; % Mohr-Coulomb's friction angle
info.config.medium.Y = 40*10^6; % Compression strength
info.config.medium.E = 40*10^9; % Young's modulus
info.config.medium.f = 40*10^5; % Tension strength
info.config.medium.rho0 = 2450; % static density

info.config.medium.A = 40*10^6*5;
info.config.medium.B = 1.5*2450;
info.config.medium.mu = 0.12;

info.config.medium.psi = 1.5/180*pi; 

info.config.medium.free_edge = false; % Can be true or false

%% 1.3 Projectile geometry
% info.config.projectile.config = [0.001 0.2 0 1 0 0];

% info.config.projectile.config = [0.0001 0.5 0 25.349 7.375 47.25 53.401 0 0 0 0 0 0 0 0 0 0 0;
%     19.691 0 0 0.56 0.9 1 13.98 3.27 31.5 39.52 0 0 0 1.33 0 5 0 0;
%     73.751 0 0 0 5.5 0 5 0 0 0 0 0 0 0 0 0 0 0];
% info.config.projectile.config_name = 'I-1';
info.config.projectile.config = [0.0001 0.5 0 25.349 7.375 47.25 53.401 0 0 0 0 0 0 0 0 0 0 0;
    33.11 0 0 0.17095 0.55917 1 7.83454 4.16583 9.45 32.6445 0 0 0 0.775 0 5 0 0;
    73.7501 0 0 0 5.5 0 5 0 0 0 0 0 0 0 0 0 0 0];
info.config.projectile.config_name = 'II-2';
% info.config.projectile.config = [0.01 0.5 0 25.35 7.38 47.25 53.4 0 0 0 0 0 0 0 0 0 0 0;
%     33.11 0 0 0.17 0.56 1 7.83 4.17 9.45 32.65 0 0 0 0.77 0 5 0 0;
%     73.751 0 0 0 5.5 0 5 0 0 0 0 0 0 0 0 0 0 0];
% [info.config.projectile.config, info.config.projectile.config_name] = Config_generator_oval();

info.config.projectile.beta = 7.5/1000; % Geometry ratio
% info.config.projectile.beta = 1; % Geometry ratio
info.config.projectile.num_mesh = 800; % Horizontal mesh distribution

%% 1.4 Projectile physics
info.config.projectile.bar = 'Constant'; % Now support: 'Constant'; 'Variable'; 'Love'; 'MH'
info.config.projectile.beam = 'Euler'; % Now support: 'Euler'; 'Timoshenko'
info.config.projectile.k_prime = 9/10; % Geo-para for Timoshenko
info.config.projectile.xi = 0; % Damping ratio
info.config.projectile.plastic = false;%{true, false}; % Can be true or false
% Type of constitution, now support: ''1.kinematic''; ''2.independent''; ''3.isotropic''
info.config.projectile.consti= [1,1,1];

info.config.projectile.rho = [7816.7, 2000, 2700]; % Material's static density
info.config.projectile.E = [209.5*10^9, 0*10^6, 70*10^9]; % Material's Elastic modulus
info.config.projectile.G = [209.5*10^9/2/(1+0.269), 0*10^6/2/(1+0.3), 70*10^9/2/(1+0.33)]; % Material's Shear modulus
info.config.projectile.Y = [400*10^6, 400*10^6, 400*10^6]; % Material's Yield Strength
info.config.projectile.D = [100*10^9, 5*10^5, 35*10^9]; % Material's Tagent modulus

% info.config.projectile.rho = 7890; % Material's static density
% info.config.projectile.E = 209*10^9; % Material's Elastic modulus
% info.config.projectile.G = 209*10^9/2/(1+0.269); % Material's Shear modulus
% info.config.projectile.Y = 400*10^6; % Material's Yield Strength
% info.config.projectile.D = 100*10^9; % Material's Plastic modulus

info.config.projectile.v0 = 1450; % Initial velocity
info.config.projectile.fai = 0/180*pi; % Initial angle of fall
info.config.projectile.alpha = 0/180*pi; % Initial angle of attack
info.config.projectile.omega = 0; % Initial angular velocity

%% 2. Simulation options
info.simulation.coupled = true; % Can be true or false
info.simulation.parallel = false; % Can be true or false
info.simulation.dt_default = 2e-3; % For 'Runge-kutta' only
info.simulation.t_max = 1; % Maximun simulation time
info.simulation.vmin = 1; % Minmum velocity

%% 3. Plot options
info.plot.frame_option = 'Data'; % Now support: 'Time'; 'Data'
info.plot.num_frame = 500; % Number of frames
info.plot.saving = true; % Can be true or false

% For vibration analysis only
info.plot.vibration_analysis = true; % Can be true or false
info.plot.vibration.option = 'N'; 
% Now support: 'X'; 'Y'; 'N'; 'M'; 'EA'; 'Sigma'; 'Epsilon'; 'Ac'; 'V' and their combination
info.plot.vibration.modal = true; % Can be true or false
info.plot.vibration.modal_plot = 'Curve'; % Now support: ''; 'Curve'; 'Color'
info.plot.vibration.tip_fix = false; % Can be true or false
info.plot.vibration.buttom_fix = false; % Can be true or false
info.plot.vibration.radial = false; % Can be true or false
info.plot.vibration.expression = 'bisect'; % Now support: 'animation'; 'bisect'; 'mesh'
info.plot.vibration.location = 0.1; % Can be decimal or decimal vertor
% [0.6856 0.689 0.6923 0.6957 0.699 0.7023]
% For history animation only
info.plot.history_animation = false; % Can be true or false
info.plot.animation.projectile.map = ''; % Now support:  ''; 'Normal'; 'Shear'; 'Overall'
info.plot.animation.projectile.num_mesh = 18; % Projectile mesh distribution, for plot only
info.plot.animation.medium.map = ''; % Now support: ''; 'Stress'; 'Component'
info.plot.animation.medium.num_mesh = 30; % Medium mesh distribution, for plot only
info.plot.animation.num_source = 5; % Number of medium sources
info.plot.animation.transparency = 0.3; % Ranges from 0 to 1

% For other plot only
info.plot.other_plot = false; % Can be true or false
info.plot.other.x_loc = 'center'; % Can be 'center' or 'top'
% Can be 'x','t','y','vx','vy','v','a','alpha','fai','psi','omega' and their combination
info.plot.other.x = 't,t,t';
% Can be 'x','t','y','vx','vy','v','a','alpha','fai','psi','omega' and their combination
info.plot.other.y = 'alpha,v,x';

%% 4. Options binding
binding = {{}};

%% 5. Analysis & Save
Info = info_analysis(info, binding);
save([info.project_name '_info.mat'],'info','binding')

%% Modal test

result = struct();
result = Processor_pre(info, result);
pre=result.pre;

K = vibration_bar_K(pre.Coord, pre.EA_all, pre.GA_all, pre.GI_all, info.config.projectile.bar);
M = vibration_bar_M(pre.Coord, pre.mL, pre.rhoI_all, pre.gamma, info.config.projectile.bar);

[Frequency, Modal, a] = vibration_frequency(M, K, info.config.projectile.xi);
F1 = Frequency(1)/2/pi;
F2 = Frequency(2)/2/pi;

X_real = pre.Coord(:,1);
Yo_real = pre.Coord(:,2);
Yi_real = pre.Coord_all(:,2,2);
Yi_real_temp = pre.Coord_all(:,2,end);
Yi_real(find(Yi_real_temp>0)) = 0;

Gamma = pre.EA_all./(2*pre.GA_all) - 1;
num_figure = 1;
num_mesh = info.config.projectile.num_mesh;

for k = 1:3
    fai = -sign(Modal(1,k))*Modal(:,k)/max(abs(Modal(:,k)));
    Text = {[Info(1).config.projectile.bar ', ' num2str(k)]};
    num_figure = Config_generator_demo(Info, num_figure, {''});
    vibration_modal_plot2(X_real, Yo_real, Yi_real, fai, Gamma, Info(1).config.projectile.bar, num_figure-1)
end