function [TUX, TAX, TN, EA_all_all, Ga_all_all, Epsilon, Sigma, TGX] = vibration_bar_post(TUX, TAX, TFX, t, E, pre, bar_option)
% vibration_bar_post  generate side info after elastic calculation
% Invoking            none
% Invoked             Coupled_elastic; vibration_seeker
% INPUT
%   TUX               matrix of nxm, with n array of timestep and m column of elemental axial displacement 
%   TAX               matrix of nxm, with n array of timestep and m column of elemental axial acceleration
%   TFX               matrix of nxm, with n array of timestep and m column of elemental axial loads
%   t                 vector of nx1, recorded sinmulation time
%   E                 vector of jx1, Young's Modulus of every material
%   pre               struct, obtained result from pre-processing
%   bar_option        string, can be 'Constant'; 'Variable'; 'Love'; 'MH'
% OUTPUT
%   TN                matrix of nx(m-1), with n array of timestep and m-1 column of elemental axial force
%   EA/GA_all_all     matrix of nx(m-1), with n array of timestep and m-1 column of elemental stiffness
%   Epsilon           matrix of (m-1)xn, with m-1 array of elemental strain and n column of timestep
%   Sigma             matrix of (m-1)xn, with m-1 array of elemental stress and n column of timestep
%   TGX               matrix of nxm, with n array of timestep and m column of elemental radial stain
%%
Coord = pre.Coord;
EA_all = pre.EA_all;
gamma = pre.gamma;
A_all_all = pre.A_all_all;
mL = pre.mL;

TN = zeros(length(t),length(Coord));
for k = 2:length(Coord)
    TN(:,k) = TN(:,k-1) + mL(k-1)*(TAX(:,k-1) + TAX(:,k))/2 - (TFX(:,k-1) + TFX(:,k))/2;
end

switch bar_option
    case 'MH'
        TGX = TUX(:,size(Coord,1)+1:end);
        TAX = TAX(:,1:size(Coord,1));
        Coord(end,2) = 0;
        TGX = [zeros(length(t),1) TGX zeros(length(t),1)]./(Coord(:,2))';
        TUX = TUX(:,1:size(Coord,1));
        Epsilon = vibration_dX(Coord, TUX');
    case 'Love'
        Epsilon = vibration_dX(Coord, TUX');
        gamma = ([gamma(1); gamma] + [gamma; 0])/2;
        TGX = -(gamma.* ([Epsilon(1,:); Epsilon] + [Epsilon; Epsilon(end,:)])/2)';
    otherwise
        Epsilon = vibration_dX(Coord, TUX');
        TGX = zeros(size(TUX));
end
Sigma = zeros(length(EA_all), length(t), length(E));

for j = 1:length(E)
    for k = 1:length(EA_all)
        if A_all_all(k,j) > 0
            Sigma(k,:,j) = Epsilon(k,:)*E(j);
        else
            Sigma(k,:,j) = 0;
        end
    end
end
EA_all_all = repmat(EA_all,[1, length(t)]);
Ga_all_all = repmat(gamma,[1, length(t)]);
end