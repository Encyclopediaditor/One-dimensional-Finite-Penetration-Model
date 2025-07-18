function [TGX, TUX] = vibration_bar_TGX(TUX, Gamma, Epsilon, Coord, bar_option)
% vibration_bar_TGX  generate radial movement after plastic calculation
% Invoking           none
% Invoked            Coupled_plastic; vibration_seeker
% INPUT
%   TUX              matrix of nxm, with n array of timestep and m column of elemental axial displacement
%   Gamma            vector of mx1, Roisson's ratio distribution
%   Epsilon          matrix of (m-1)xn, with m-1 array of elemental strain and n column of timestep
%   Coord            matrix of nx2, proectile's outline [X Y]
%   bar_option       string, can be 'Constant'; 'Variable'; 'Love'; 'MH'
% OUTPUT
%   TGX              matrix of nxm, with n array of timestep and m column of elemental radial stain
%   TUX              matrix of nxm, with n array of timestep and m column of elemental axial displacement
%%
switch bar_option
    case 'MH'
        Coord(end,2) = 0;
        TGX = TUX(:,size(Coord,1)+1:end);
        TGX = [zeros(size(TGX,1),1) TGX zeros(size(TGX,1),1)]./(Coord(:,2))'; 
        TUX = TUX(:,1:size(Coord,1));
    case 'Love'
        Gamma = ([Gamma(1,:); Gamma] + [Gamma; Gamma(end,:)])/2;
        Epsilon = ([Epsilon(1,:); Epsilon] + [Epsilon; Epsilon(end,:)])/2;
        TGX = -(Gamma.* Coord(:,2).*Epsilon)';
    otherwise
        TGX = zeros(size(TUX));
end

end