function Tv = vibration_output(TUX, TUY, TAX, TN, TM, EA_all_all, Ga_all_all, Epsilon, Epsilon_p, Sigma, TGX, p, option)
% vibration_output  determine which variable to output
% Invoking          none
% Invoked           Coupled_elastic; Coupled_plastic; vibration_seeker
% INPUT
%   TUX             matrix of nxm, with n array of timestep and m column of elemental axial displacement
%   TUY             matrix of nxm, with n array of timestep and m column of elemental lateral displacement
%   TAX             matrix of nxm, with n array of timestep and m column of elemental axial acceleration
%   TN              matrix of nx(m-1), with n array of timestep and m-1 column of elemental axial force
%   TM              matrix of nx(m-1), with n array of timestep and m-1 column of elemental moment
%   EA/GA_all_all   matrix of (m-1)xn, with m-1 array of elemental stiffness and n column of timestep
%   Epsilon         matrix of (m-1)xn, with m-1 array of elemental strain and n column of timestep
%   Epsilon_p       matrix of (m-1)xn, with m-1 array of elemental plastic strain and n column of timestep
%   Sigma           matrix of (m-1)xnxj, with m-1 array of elemental stress, n column of timestep, and j type of materials 
%   TGX             matrix of nxm, with n array of timestep and m column of elemental radial stain
%   config          struct, representing basic projectile's configuratuion options of single claculation
%   option          string, vibration analysis option
% OUTPUT
%   Tv              matrix of nxm, with n array of timestep and m column of elemental designated variable      
%%
Option = info_analysis_sigma(p.E, option);
Tv = cell(1,length(Option));

num_Sigma = 0;
num_PlasticEp = 0;
for i = 1:length(Option)
    switch Option{i}
        case 'X'
            Tv{i} = TUX;
        case 'Y'
            Tv{i} = TUY;
        case 'N'
            Tv{i} = TN;
        case 'M'
            Tv{i} = TM;
        case 'EA'
            Tv{i} = EA_all_all';
        case 'GA'
            Tv{i} = EA_all_all'./(2*(Ga_all_all'+1));
        case 'Epsilon'
            Tv{i} = Epsilon';
        case 'PlasticEp'
            num_PlasticEp = num_PlasticEp + 1;
            Tv{i} = (Epsilon_p(:,:,num_PlasticEp))';
        case 'Sigma'
            num_Sigma = num_Sigma + 1;
            Tv{i} = (Sigma(:,:,num_Sigma))';
        case 'Ac'        
            Tv{i} = TAX;
        case 'V'
            Tv{i} = TGX;
    end
end