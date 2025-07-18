function [TUX, TAX] = vibration_bar(Frequency, Modal, Mn, TFX, xi, t)
% vibration_bar  X directional structural response calculation of projectile, based on modal method
% Invoking       Newmark_beta; info_analysis_progress
% Invoked        vibration_seeker
% INPUT
%   Frequency    vector of mx1
%   Modal        matrix of mxm
%   Mn           vector of mx1, each modal's mass
%   TFX          matrix of nxm, with n array of timestep and m column of elemental axial loads
%   xi           scalar, damping ratio
%   t            vector of nx1, recorded sinmulation time
% OUTPUT
%   TUX          matrix of nxm, with n array of timestep and m column of elemental axial displacement 
%   TAX          matrix of nxm, with n array of timestep and m column of elemental axial acceleration      
%%
num_modal = length(Frequency);
TQ = zeros(length(t), num_modal);
TddQ = TQ;
Modal = Modal(:,1:num_modal);

for j = 1:num_modal    
    w = Frequency(j);
    
    m = Mn(j);
    k = m*w^2;
    c = 2*xi*w*m;
            
    p = TFX*Modal(:,j);
    U = zeros(1,length(t));
    dU = U;
    ddU = U;

    [U, ~, ddU] = Newmark_beta(m, k, c, t, p', U, dU, ddU, 1/4);
    TQ(:,j) = U';
    TddQ(:,j) = ddU';
    
    info_analysis_progress(num_modal, j, 'Axial Vibration: ')
end

TUX = TQ*Modal';
TAX = TddQ*Modal';
end