function [Tv, TUX, TGX] = vibration_output(Tv_all, p, option)
% vibration_output  determine which variable to output
% Invoking          none
% Invoked           Coupled_elastic; Coupled_plastic; vibration_seeker
% INPUT
%   Tv_all.TUX             matrix of nxm, with n array of timestep and m column of elemental axial displacement
%   Tv_all.TUY             matrix of nxm, with n array of timestep and m column of elemental lateral displacement
%   Tv_all.TVY             matrix of nxm, with n array of timestep and m column of elemental lateral velocity
%   Tv_all.TAX             matrix of nxm, with n array of timestep and m column of elemental axial acceleration
%   Tv_all.TVX             matrix of nxm, with n array of timestep and m column of elemental axial velicity
%   Tv_all.TN              matrix of nx(m-1), with n array of timestep and m-1 column of elemental axial force
%   Tv_all.TM              matrix of nx(m-1), with n array of timestep and m-1 column of elemental moment
%   EA/GA_all_all          matrix of (m-1)xn, with m-1 array of elemental stiffness and n column of timestep
%   Epsilon                matrix of (m-1)xn, with m-1 array of elemental strain and n column of timestep
%   Epsilon_p              matrix of (m-1)xn, with m-1 array of elemental plastic strain and n column of timestep
%   Sigma                  matrix of (m-1)xnxj, with m-1 array of elemental stress, n column of timestep, and j type of materials 
%   TGX                    matrix of nxm, with n array of timestep and m column of elemental radial stain
%   config                 struct, representing basic projectile's configuratuion options of single claculation
%   option                 string, vibration analysis option
% OUTPUT
%   Tv                     matrix of nxm, with n array of timestep and m column of elemental designated variable
%   TUX/TGX                matrix of nxm, with n array of timestep and m column of elemental axial/radial displacement
%%
Option = info_analysis_sigma(p.E, option);
Tv = cell(1,length(Option));
TUX = Tv_all.TUX;
TGX = Tv_all.TGX;

num_Sigma = 0;
num_PlasticEp = 0;
for i = 1:length(Option)
    switch Option{i}
        case 'X'
            Tv{i} = Tv_all.TUX;
        case 'Y'
            Tv{i} = Tv_all.TUY;
        case 'N'
            Tv{i} = Tv_all.TN;
        case 'M'
            Tv{i} = Tv_all.TM;
        case 'EA'
            Tv{i} = Tv_all.EA_all_all';
        case 'GA'
            Tv{i} = Tv_all.EA_all_all'./(2*(Tv_all.Ga_all_all'+1));
        case 'Epsilon'
            Tv{i} = Tv_all.Epsilon';
        case 'PlasticEp'
            num_PlasticEp = num_PlasticEp + 1;
            Tv{i} = (Tv_all.Epsilon_p(:,:,num_PlasticEp))';
        case 'Sigma'
            num_Sigma = num_Sigma + 1;
            Tv{i} = (Tv_all.Sigma(:,:,num_Sigma))';
        case 'Ac'        
            Tv{i} = Tv_all.TAX;
        case 'Ve'        
            Tv{i} = Tv_all.TVX;
        case 'Radi'
            Tv{i} = Tv_all.TGX;
    end
end