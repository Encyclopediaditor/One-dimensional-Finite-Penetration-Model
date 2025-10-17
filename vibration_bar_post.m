function Tv_all = vibration_bar_post(Tv_all, TFX, t, E, G, pre, bar_option)
% vibration_bar_post         generate side info after elastic calculation
% Invoking                   none
% Invoked                    Coupled_elastic; vibration_seeker
% INPUT
%   Tv_all.TUX               matrix of nxm, with n array of timestep and m column of elemental axial displacement 
%   Tv_all.TVX               matrix of nxm, with n array of timestep and m column of elemental axial velocity
%   Tv_all.TAX               matrix of nxm, with n array of timestep and m column of elemental axial acceleration
%   TFX                      matrix of nxm, with n array of timestep and m column of elemental axial loads
%   t                        vector of nx1, recorded sinmulation time
%   E                        vector of jx1, Young's Modulus of every material
%   G                        vector of jx1, Shear Modulus of every material
%   pre                      struct, obtained result from pre-processing
%   bar_option               string, can be 'Constant'; 'Variable'; 'Love'; 'MH'
% OUTPUT
%   Tv_all.TN                matrix of nx(m-1), with n array of timestep and m-1 column of elemental axial force
%   Tv_all.EA_all_all        matrix of nx(m-1), with n array of timestep and m-1 column of elemental stiffness
%   Tv_all.Ga_all_all        matrix of nx(m-1), with n array of timestep and m-1 column of Poisson's Ratio
%   Tv_all.Epsilon           matrix of (m-1)xn, with m-1 array of elemental strain and n column of timestep
%   Tv_all.Sigma             matrix of (m-1)xn, with m-1 array of elemental stress and n column of timestep
%   Tv_all.TGX               matrix of nxm, with n array of timestep and m column of elemental radial stain
%%
Coord = pre.Coord;
EA_all = pre.EA_all;
gamma = pre.gamma;
A_all_all = pre.A_all_all;
mL = pre.mL;

TN = zeros(length(t),length(Coord));
TAX = Tv_all.TAX;
for k = 2:length(Coord)
    TN(:,k) = TN(:,k-1) + mL(k-1)*(TAX(:,k-1) + TAX(:,k))/2 - (TFX(:,k-1) + TFX(:,k))/2;
end
Tv_all.TN = TN;

switch bar_option
    case 'MH'
        TGX = Tv_all.TUX(:,size(Coord,1)+1:end);
        Tv_all.TVX = Tv_all.TVX(:,1:size(Coord,1));
        Tv_all.TAX = TAX(:,1:size(Coord,1));
        Coord(end,2) = 0;
        TGX = [zeros(length(t),1) TGX zeros(length(t),1)]./(Coord(:,2))';
        Tv_all.TGX = TGX;
        Tv_all.TUX = Tv_all.TUX(:,1:size(Coord,1));
        Epsilon = vibration_dX(Coord, Tv_all.TUX');
    case 'Love'
        Epsilon = vibration_dX(Coord, Tv_all.TUX');
        gamma_new = ([gamma(1); gamma] + [gamma; 0])/2;
        Tv_all.TGX = -(gamma_new.* ([Epsilon(1,:); Epsilon] + [Epsilon; Epsilon(end,:)])/2)';
        Tv_all.Epsilon = Epsilon;
    otherwise
        Epsilon = vibration_dX(Coord, Tv_all.TUX');
        Tv_all.TGX = zeros(size(Tv_all.TUX));
end

Sigma = zeros(length(EA_all), length(t), length(E));
if strcmp(bar_option, 'MH')     
     Phi = TGX';
     for j = 1:length(E)
        for k = 1:length(EA_all)
            if A_all_all(k,j) > 0
                Sigma(k,:,j) = 2*(Epsilon(k,:)-Phi(k,:))*G(j);
            else
                Sigma(k,:,j) = 0;
            end
        end
    end   
else
    for j = 1:length(E)
        for k = 1:length(EA_all)
            if A_all_all(k,j) > 0
                Sigma(k,:,j) = Epsilon(k,:)*E(j);
            else
                Sigma(k,:,j) = 0;
            end
        end
    end
end
Tv_all.Sigma = Sigma;
Tv_all.Epsilon = Epsilon;
Tv_all.EA_all_all = repmat(EA_all,[1, length(t)]);
Tv_all.Ga_all_all = repmat(gamma,[1, length(t)]);
end