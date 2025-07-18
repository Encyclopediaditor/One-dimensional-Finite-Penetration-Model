function [Config, Config_name] = Config_generator_oval()
% Config_generator_oval   generate line code and corresponding name for oval-headed projectile
% Invoking                info_analysis
% Invoked                 main
% OUTPUT
%    Config               matrix (single condition) or cell with matrix element (multiple conditions), instruction of projectile's geometric config
%    Config_name          string (single condition) or cell with string element (multiple conditions), name of projectile
%% Input
info = struct();
info.project_name = 'oval';

info.oval.d = 15.75; % Diameter of projectile
info.oval.l2d = 5; % Ratio of length to diameter
info.oval.CRH = 3; % For Oval: Outer Inner ¦µ/2r

% I-1
info.oval.dt = 2*15.75/(15.75-8.34);%{1/0.1,1/0.15}; % Ratio of outer diameter to outer thickness
info.oval.ls2l = (78.75-59.06)/78.75;%{0.3237,0.1814}; % Ratio of inner and outer head's gap to outer length
info.oval.b2d = 0.3175; % Ratio of bottom's length to outer diameter
info.oval.CRH2 = 3.7770; % For Oval: Inner ¦µ/2r

% II-1
% info.oval.dt = 2*15.75/(15.75-8.34);%{1/0.1,1/0.15}; % Ratio of outer diameter to outer thickness
% info.oval.ls2l = (78.75-55.86)/78.75;%{0.3237,0.1814}; % Ratio of inner and outer head's gap to outer length
% info.oval.b2d = 0.3175; % Ratio of bottom's length to outer diameter
% info.oval.CRH2 = 1; % For Oval: Inner ¦µ/2r

% II-2
% info.oval.dt = 2*15.75/(15.75-9.45);%{1/0.1,1/0.15}; % Ratio of outer diameter to outer thickness
% info.oval.ls2l = (78.75-45.65)/78.75;%{0.3237,0.1814}; % Ratio of inner and outer head's gap to outer length
% info.oval.b2d = 0.3175; % Ratio of bottom's length to outer diameter
% info.oval.CRH2 = 1; % For Oval: Inner ¦µ/2r

% II-3
% info.oval.dt = 2*15.75/(15.75-7.88);%{1/0.1,1/0.15}; % Ratio of outer diameter to outer thickness
% info.oval.ls2l = (78.75-60.11)/78.75;%{0.3237,0.1814}; % Ratio of inner and outer head's gap to outer length
% info.oval.b2d = 0.3175; % Ratio of bottom's length to outer diameter
% info.oval.CRH2 = 0.5; % For Oval: Inner ¦µ/2r

% All
% info.oval.dt = {2*15.75/(15.75-8.34),2*15.75/(15.75-8.34),2*15.75/(15.75-9.45),2*15.75/(15.75-7.88)};%{1/0.1,1/0.15}; % Ratio of outer diameter to outer thickness
% info.oval.ls2l = {(78.75-59.06)/78.75,(78.75-55.86)/78.75,(78.75-45.65)/78.75,(78.75-60.11)/78.75};%{0.3237,0.1814}; % Ratio of inner and outer head's gap to outer length
% info.oval.b2d = 0.3175; % Ratio of bottom's length to outer diameter
% info.oval.CRH2 = {3.7770,1,1,0.5}; % For Oval: Inner ¦µ/2r

% I-1, II-2
% info.oval.dt = {2*15.75/(15.75-8.34),2*15.75/(15.75-9.45)};%{1/0.1,1/0.15}; % Ratio of outer diameter to outer thickness
% info.oval.ls2l = {(78.75-59.06)/78.75,(78.75-45.65)/78.75};%{0.3237,0.1814}; % Ratio of inner and outer head's gap to outer length
% info.oval.b2d = 0.3175; % Ratio of bottom's length to outer diameter
% info.oval.CRH2 = {3.7770,1}; % For Oval: Inner ¦µ/2r

binding = {{}};
% binding = {{'oval.dt','oval.ls2l'}};
% binding = {{'oval.dt','oval.ls2l','oval.CRH2'}};

%% Analysis
Info = info_analysis(info, binding);
if length(Info) > 1
    Config = cell(1,length(Info));
    Config_name = Config;
end
for i = 1:length(Info)
    o = Info(i).oval;
    R = o.CRH*o.d;
    lh = sqrt(R^2 - (R-o.d/2)^2);
    l = o.l2d*o.d;
    t1 = [lh,o.d/2,R,...
          l-lh,0,0,...
          0,0,0,...
          0,0,0,...
          0,0,0];
    
    ls = l*o.ls2l;
    b = o.d*o.b2d;
    d2 = o.d*(1 - 2/o.dt);
    R2 = o.CRH2*d2;
    lh2 = sqrt(R2^2 - (R2-d2/2)^2);
    t2 = [ls,0,0,...
          lh2,d2/2,R2,...
          l-ls-lh2-b,0,0,...
          0,-d2/2,0,...
          b,0,0];
      
  if length(Info) > 1
      Config{i} = [t1;t2];
      Config_name{i} = Info(i).project_name;
  else
      Config = [t1;t2];
      Config_name = Info(i).project_name;
  end
end
end