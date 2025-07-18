function [dX, Fbx_all, M_all, Fr] = deformable(X, X_vib, Vx_vib, config, pre)
% deformable  Coupling response calculation for deformable system: reaction
%             surface and velocity adjustment of deformable projectile, to 
%             obtain force and moment summarization.
% Invoking    drag_calculator
% Invoked     Coupled_elastic; Newmark_beta2; Newmark_beta3
% INPUT
%   X         vector of 6x1, [x; y; vx; vy; fai; omega]
%   X_vib     vector of nx1, relative displacement of each element
%   Vx_vib    vector of nx1, relative velocity of each element
%   config    struct, representing basic configuratuion options of single claculation
%   pre       struct, obtained result from pre-processing
% OUTPUT
%   dX        vector of 6x1, [dx; dy; dvx; dvy; dfai; domega]
%   Fbx_all   vector of mx1, axial loads distribution of each element
%   M_all     vector of mx1, moment distribution of each element
%   Fr        vector of mx1, radial force distribution of each element
%% Unzip
m = pre.m0;
I = pre.I0;
Coord = pre.Coord;
Wall_loc = config.medium.config;

Rn = X(1:2);
Vn = X(3:4);
fai = X(5);
omega = X(6);
Xi = (Wall_loc-Rn(1))/cos(fai);

switch config.projectile.bar
    case 'Love'
        gamma = pre.gamma;
        gamma = ([gamma(1); gamma] + [gamma; 0])/2;
        Epsilon = vibration_dX(Coord, X_vib);
        dEpsilondt = vibration_dX(Coord, Vx_vib);
        Y_vib = -(gamma.*Coord(:,2).*([Epsilon(1); Epsilon] + [Epsilon; Epsilon(end)])/2);
        Vy_vib = -(gamma.*Coord(:,2).*([dEpsilondt(1); dEpsilondt] + [dEpsilondt; dEpsilondt(end)])/2);       
    case 'MH'
        num_mesh = config.projectile.num_mesh;
        Y_vib = [0; X_vib(num_mesh+2:2*num_mesh); 0];
        Vy_vib = [0; Vx_vib(num_mesh+2:2*num_mesh); 0];
        X_vib = X_vib(1:num_mesh+1);
        Vx_vib = Vx_vib(1:num_mesh+1);
    otherwise        
        Y_vib = zeros(size(X_vib));
        Vy_vib = Y_vib;
end

%% Coord fix
Coord(:,1) = Coord(:,1) + X_vib;
Coord(:,2) = Coord(:,2) + Y_vib;
pre.dVx = Vx_vib;
pre.dVy = Vy_vib;

%% Drag calculation
[Fb_all, M_all, Fr] = drag_calculator(Vn, omega, fai, Xi, Coord, config, pre, false, true);

Fb = sum(Fb_all,2);
Fn = [cos(fai) -sin(fai); 
    sin(fai) cos(fai)]*Fb;
Fbx_all = Fb_all(1,:)';
Fbx_all = Fbx_all - sum(Fbx_all)/m*pre.mL;
Fbx_all = ([0; Fbx_all] + [Fbx_all; 0])/2;

%% Zip
domega = sum(M_all)/I;
dfai = omega;
dVn = Fn/m;
dRn = Vn;
dX = [dRn;dVn;dfai;domega];

end