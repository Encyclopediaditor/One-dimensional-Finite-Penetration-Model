function [X, ytext] = info_analysis_viber(X_real, option)
% info_analysis_viber  give the label text based on vibration plot request
% Invoking             none
% Invoked              proploter; vibration_demo
% INPUT
%   X_real             vector of nx1, elements' axial location
%   option             string, option of vibration output
% OUTPUT
%   X                  vector of nx1, elements' revised axial location
%   ytext              string, for legend
%%
switch option
    case 'X'
        X = X_real;
        ytext = 'u / m';
    case 'Y'
        X = X_real;
        ytext = 'w / m';
    case 'N'
        X = X_real;
        ytext = 'N / N';
    case 'M'
        X = (X_real(1:end-1) + X_real(2:end))/2;
        ytext = 'M / (Nm)';
    case 'EA'
        X = (X_real(1:end-1) + X_real(2:end))/2;
        ytext = 'EA / N';
    case 'GA'
        X = (X_real(1:end-1) + X_real(2:end))/2;
        ytext = 'GA / N';
    case 'Sigma'
        X = (X_real(1:end-1) + X_real(2:end))/2;
        ytext = '\sigma / Pa';
    case 'Epsilon'
        X = (X_real(1:end-1) + X_real(2:end))/2;
        ytext = '\epsilon';  
    case 'PlasticEp'
        X = (X_real(1:end-1) + X_real(2:end))/2;
        ytext = '\epsilon_p';
    case 'Ac'
        X = X_real;
        ytext = 'Acc / (m/s^2)';
    case 'V'
        X = X_real;
        ytext = '\psi';
end
end