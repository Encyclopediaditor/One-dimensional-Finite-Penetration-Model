function [TFX, TFY, TM, TFr] = drag_calculator_review2(X, t, config, pre)
% drag_calculator_review2  restore localized force and moment
% Invoking                 drag_calculator 
% Invoked                  vibration_seeker
% INPUT
%   X                      matrix of nx6, with each column [X Y VX VY Fai Omega]   
%   T                      vector of nx1, recorded sinmulation time
%   config                 struct, representing basic configuratuion options of single claculation
%   pre                    struct, obtained result from pre-processing
% OUTPUT
%   TFX                    matrix of nxm, with n array of timestep and m column of elemental axial loads
%   TFY                    matrix of nxm, with n array of timestep and m column of elemental lateral loads
%   TM                     matrix of nxm, with n array of timestep and m column of elemental moment
%   TFr                    matrix of nxm, with n array of timestep and m column of elemental radial force
%%
Coord = pre.Coord;
Wall_loc = config.medium.config;
TFX = zeros(length(t), length(Coord)-1);
TFY = TFX;
TM = TFX;
TFr = TFX;

for i = 1:length(t)
    Rn = X(i,1:2);
    Vn = (X(i,3:4))';
    fai = X(i,5);
    omega = X(i,6);

    Xi = (Wall_loc-Rn(1))/cos(fai);
    [Fb, M, Fr] = drag_calculator(Vn, omega, fai, Xi, Coord, config, pre, false, false);
    TFX(i,:) = Fb(1,:);
    TFY(i,:) = Fb(2,:);
    TM(i,:) = M;
    TFr(i,:) = Fr;
end
end