function Tv_all = vibration_bar_TGX(Tv_all, Coord, bar_option)
% vibration_bar_TGX         generate radial movement after plastic calculation
% Invoking                  none
% Invoked                   Coupled_plastic; vibration_seeker
% INPUT
%   Tv_all.TUX              matrix of nxm, with n array of timestep and m column of elemental axial displacement
%   Tv_all.Ga_all_all       vector of mxn, with n array of timestep and m column of Roisson's ratio distribution
%   Tv_all.Epsilon          matrix of (m-1)xn, with m-1 array of elemental strain and n column of timestep
%   Coord                   matrix of nx2, proectile's outline [X Y]
%   bar_option              string, can be 'Constant'; 'Variable'; 'Love'; 'MH'
% OUTPUT
%   Tv_all.TGX              matrix of nxm, with n array of timestep and m column of elemental radial stain
%   Tv_all.TUX              matrix of nxm, with n array of timestep and m column of elemental axial displacement
%%
TUX = Tv_all.TUX;
Gamma = Tv_all.Ga_all_all;
Epsilon = Tv_all.Epsilon;

switch bar_option
    case 'MH'
        Coord(end,2) = 0;
        TGX = TUX(:,size(Coord,1)+1:end);
        TGX = [zeros(size(TGX,1),1) TGX zeros(size(TGX,1),1)]./(Coord(:,2))'; 
        Tv_all.TUX = TUX(:,1:size(Coord,1));
        Tv_all.TVX = Tv_all.TVX(:,1:size(Coord,1));
        Tv_all.TAX = Tv_all.TAX(:,1:size(Coord,1));
    case 'Love'
        Gamma = ([Gamma(1,:); Gamma] + [Gamma; Gamma(end,:)])/2;
        Epsilon = ([Epsilon(1,:); Epsilon] + [Epsilon; Epsilon(end,:)])/2;
        TGX = -(Gamma.* Epsilon)';
    otherwise
        TGX = zeros(size(TUX));
end

Tv_all.TGX = TGX;
end