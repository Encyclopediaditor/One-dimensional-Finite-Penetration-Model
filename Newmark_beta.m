function [U, dU, ddU] = Newmark_beta(M, K, C, t, P, U, dU, ddU, beta)
% Newmark_beta  engine of elastic structural response
% Invoking      info_analysis_progress
% Invoked       Coupled_elastic; vibration_bar; vibration_seeker
% INPUT
%   M           matrix of nxn, mass matrix
%   K           matrix of nxn, stiffness matrix
%   C           matrix of nxn, damping matrix
%   t           vector of mx1, time series
%   P           vector of nx1, loads
%   U           matrix of mxn, history of displacement of each element
%   dU          matrix of mxn, history of velocity of each element
%   ddU         matrix of mxn, history of acceleration of each element
%   beta        scalar, Newmark_beta's core coefficient
%% Preparation
gamma=1/2;
U(:,2) = U(:,1);
dU(:,2) = dU(:,1);
ddU(:,2) = ddU(:,1);

%% Iteration
len_M = size(M,1);
len_t = length(t)-1;
for i=1:len_t
    dt = t(i+1) - t(i);
    a = [1/(beta*dt^2);
         gamma/(beta*dt);
         1/(beta*dt);
         1/(2*beta)-1;
         gamma/beta-1;
         dt/2*(gamma/beta-2);
         dt*(1-gamma);
         gamma*dt];
    K_e = K + a(1)*M+a(2)*C;
    
    P_e = P(:,i+1)+M*(a(1)*U(:,i)+a(3)*dU(:,i)+a(4)*ddU(:,i))+...
        C*(a(2)*U(:,i)+a(5)*dU(:,i)+a(6)*ddU(:,i));
    U(:,i+1) = K_e\P_e;
    ddU(:,i+1) = a(1)*(U(:,i+1)-U(:,i))-a(3)*dU(:,i)-a(4)*ddU(:,i);
    dU(:,i+1) = dU(:,i)+a(7)*ddU(:,i)+a(8)*ddU(:,i+1);
    if len_t > 2 && len_M > 2
        info_analysis_progress(len_t, i, 'Axial Vibration: ')
    end
end
end