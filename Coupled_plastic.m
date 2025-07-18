function [T, X_all, TUX, TGX, Tv] = Coupled_plastic(config, pre, t_max, X0, dt_default, vmin, radial, option)
% Coupled_elastic   Relay calculation request under coupled plastic setting
% Invoking          Newmark_beta2; Newmark_beta3; vibration_bar_TGX; vibration_output
% Invoked           Processor_now
% INPUT
%   config          struct, representing basic configuratuion options of single claculation
%   pre             struct, obtained result from pre-processing
%   t_max           scalar, maximun sinmulation time
%   X0              vector of 6x1, with X0 = [R0n;V0n;fai0;omega0]
%   dt_default      scalar, default timestep
%   vmin            scalar, min velocity to continue simulation
%   radial          logic, whether to consider radial forces
%   option          string, option of vibration output
% OUTPUT
%   T               vector of nx1, recorded sinmulation time
%   X_all           matrix of nx6, with each column [X Y VX VY Fai Omega]
%   TUX             matrix of nxm, with n array of timestep and m column of elemental axial displacement
%   TGX             matrix of nxm, with n array of timestep and m column of elemental radial stain
%   Tv              matrix of nxm, with n array of timestep and m column of elemental designated variable
%%
if strcmp(config.projectile.bar,'MH')
    [TUX, TAX, Epsilon, Epsilon_p, TN, Sigma, EA_all_all, Ga_all_all, T, X_all] = Newmark_beta3(config, pre, radial, true, t_max, X0, dt_default, vmin);
else
    [TUX, TAX, Epsilon, Epsilon_p, TN, Sigma, EA_all_all, Ga_all_all, T, X_all] = Newmark_beta2(config, pre, true, t_max, X0, dt_default, vmin); 
end

[TGX, TUX] = vibration_bar_TGX(TUX, Ga_all_all, Epsilon, pre.Coord, config.projectile.bar);

Tv = vibration_output(TUX, [], TAX, TN, [], EA_all_all, Ga_all_all, Epsilon, Epsilon_p, Sigma, TGX, config.projectile, option);

end

