function [TFX, TFY] = vibration_balance(TFX, TFY, TM, Coord, mL)
% vibration_balance  adjust X and Y directional internal force, so that the projectile¡¯s 
%                    mass center don¡¯t move during structural response calculation
% Invoking           none
% Invoked            vibration_seeker
% INPUT
%   TFX              matrix of nxm, with n array of timestep and m column of elemental axial loads
%   TFY              matrix of nxm, with n array of timestep and m column of elemental lateral loads
%   TM               matrix of nxm, with n array of timestep and m column of elemental moment
%   Coord            matrix of nx2, proectile's outline [X Y]
%   mL               vector of nx1, mass distribution of every element    
%%
mL = mL';
X = (Coord(:,1))';
X = (X(1:end-1) + X(2:end))/2;

m = sum(mL);
mx = sum(mL.*X);
mxx = sum(mL.*X.*X);
K = [mx m;
    mxx mx];

TFX = TFX - sum(TFX,2)/m*mL;

Fy_all = (sum(TFY,2))';
Fyx_all = (sum(TM,2))';
AB = (K\[Fy_all; Fyx_all])';
TFY = TFY - AB(:,1).*X.*mL - AB(:,2).*mL;

end