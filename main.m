clear;clc;

file_name = 'Bar_test';
info = struct();
info.project_name = file_name;
 %% 1 Basic configuratuion options 
 %% 1.1 Medium geometry 
info.config.medium.config = 0;%[0 0.2 1.5 1.7 3 3.2 4.5 4.7 6 6.2 7.5]'; 
 %% 1.2 Medium mechanics
info.config.medium.fai = 0.1/180*pi; % Mohr-Coulomb's friction angle
info.config.medium.Y = 40*10^6; % Compression strength
info.config.medium.E = 40*10^9; % Young's modulus
info.config.medium.f = 4*10^6; % Tension strength
info.config.medium.rho0 = 2450; % static density 

info.config.medium.A = 414.1395*10^6; 
info.config.medium.B = 2450*1.5;
info.config.medium.mu = 0;
info.config.medium.psi = 3/180*pi;

info.config.medium.free_edge = false; % Can be true or false 
 
 %% 1.3 Projectile geometry
[info.config.projectile.config, ~] = Config_generator_oval();
% info.config.projectile.config = [1e-7 7.875 0 78.75 0 0 ; 1e-7/7.875*4.3 4.3 0 78.75 0 0];
info.config.projectile.config_name = 'I'; % Syntax curve name
info.config.projectile.beta = 1/1000; % Geometry ratio
info.config.projectile.num_mesh = 500; % Horizontal mesh distribution 
 
 %% 1.4 Projectile physics
info.config.projectile.bar = 'Constant'; % Now support: 'Constant'; 'Variable'; 'Love'; 'MH'
info.config.projectile.beam = 'Euler'; % Now support: 'Euler'; 'Timoshenko'
info.config.projectile.xi = 0; % Damping ratio
info.config.projectile.plastic = false; % Can be true or false 
% Type of constitution, now support: '1.kinematic'; '2.independent'; '3.isotropic'
info.config.projectile.consti = [2 2]; 

info.config.projectile.rho = [7850 0]; % Material's static density
info.config.projectile.E = [210*10^9 0]; % Material's Young's modulus
info.config.projectile.G = [210*10^9/2/(1+0.269) 0]; % Material's Shear modulus
info.config.projectile.Y = [1*10^9 Inf*10^9]; % Material's Yield Strength
info.config.projectile.D = [21*10^9 0]; % Material's Tangent modulus 

info.config.projectile.v0 = 500; % Initial velocity
info.config.projectile.fai = 10/180*pi; % Initial angle of fall
info.config.projectile.alpha = 0; % Initial angle of attack
info.config.projectile.omega = 0; % Initial angular velocity 
 
%% 2. Simulation options
info.simulation.coupled = false; % Can be true or false
info.simulation.parallel = false; % Can be true or false
info.simulation.dt_default = 2e-07; % Standard time variation
info.simulation.t_max = 1; % Maximun simulation time
info.simulation.vmin = 300; % Minmum velocity 
 
%% 3. Plot options
info.plot.frame_option = 'Data'; % Now support: 'Time'; 'Data'
info.plot.num_frame = 200; % Number of frames
info.plot.saving = true; % Can be true or false 
 
% For vibration analysis only
info.plot.vibration_analysis = true; % Can be true or false
info.plot.vibration.option = 'N'; % Now support: 'X'; 'Y'; 'N'; 'M'; 'EA'; 'GA'; 'Sigma'; 'Epsilon'; 'PlasticEp'; 'Ac'; 'V' and their combination
info.plot.vibration.modal = true; % Can be true or false
info.plot.vibration.modal_plot = ''; % Now support:  ''; 'Curve'; 'Color'
info.plot.vibration.tip_fix = true; % Can be true or false
info.plot.vibration.buttom_fix = false; % Can be true or false
info.plot.vibration.radial = false; % Can be true or false
info.plot.vibration.expression = 'animation'; % Now support: 'animation'; 'bisect'; 'mesh'
info.plot.vibration.location =  ...
    [0.05;0.5;
    0.95]; % Can be decimal or decimal vertor  
 
% For history animation only
info.plot.history_animation = false; % Can be true or false
info.plot.animation.projectile.map = 'Normal'; % Now support:  ''; 'Normal'; 'Shear'; 'Overall'; 'Vibration'
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
% binding = {{'config.projectile.config', 'config.projectile.config_name'}};
% binding = {{'config.projectile.v0', 'simulation.t_max'}};
binding = {{}};

%% 5. Analysis & Save

save([info.project_name '_info.mat'],'info','binding')
Info = info_analysis(info, binding);

%% 6. Run

[Info_normal, Info_parallel] = info_analysis_parallel(Info);
result = struct();
Result = cell(1,length(Info));

if ~isempty(Info_parallel)
    parfor i = 1:length(Info_parallel)
        info = Info_parallel(i);
        result = struct();
        result.project_name = info.project_name;

        result = Processor_pre(info, result);
        result = Processor_now(info, result);
        Result{i} = result;
    end
end

if ~isempty(Info_normal)
    for i = length(Info_parallel)+1:length(Info)
        info = Info_normal(i-length(Info_parallel));
        result = struct();
        result.project_name = info.project_name;

        result = Processor_pre(info, result);
        result = Processor_now(info, result);
        Result{i} = result;
    end
end

Result = Processor_post(Info, Result);
vibration_demo(Info, Result);
filename = [file_name,'_result.mat'];
save(filename,'Result')