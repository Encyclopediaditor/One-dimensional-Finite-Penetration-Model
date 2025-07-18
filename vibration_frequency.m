function [Frequency, Modal, a] = vibration_frequency(M_all, K_all, xi)
% vibration_frequency  calculate frequency and modal of projectile
% Invoking             none
% Invoked              main_preparation2; vibration_prepare; vibration_seeker
% INPUT
%   M_all              matrix of nxn, mass matrix
%   K_all              matrix of nxn, stiffness matrix
%   xi                 scalar, damping ratio
% OUTPUT
%   Frequency          vector of nx1
%   Modal              matrix of nxn
%   a                  vector of 2x1, damping coefficient      
%%
[Modal, Frequency] = eig(K_all/M_all);
[Frequency, I] = sort(diag(Frequency));
Modal = Modal(:,I);
Modal = M_all\Modal;
Modal(:,1) = [];
Modal = Modal./max(abs(Modal));

Frequency = sqrt(Frequency(2:end));
a = 2*xi/(Frequency(end)+Frequency(1))*[Frequency(end)*Frequency(1) 1];
end