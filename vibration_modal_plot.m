function num_figure = vibration_modal_plot(X_real, Modal, Frequency, num_figure, project_name)
% vibration_modal_plot  curve plot of projectile¡¯s modal
% Invoking              none
% Invoked               vibration_demo
% INPUT
%   X_real             vector of nx1, elements' axial location
%   Modal              matrix of nxn
%   Frequency          vector of nx1
%   num_figure         scalar, the rank of figure
%   project_name       string     
%%
for i = 1:3
    fai = Modal(:,i)/max(abs(Modal(:,i)));
    dfai = fai(2:end) -  fai(1:end-1);
    dfai = dfai/max(abs(dfai));
    dfai = ([dfai(1); dfai] + [dfai; dfai(end)])/2;

    figure(num_figure)
    plot(X_real, fai,'displayname',[num2str(Frequency(i)/(2*pi),4) ' Hz'],'linewidth',1.5)
    hold on

    figure(num_figure+1)
    plot(X_real, dfai,'displayname',[num2str(Frequency(i)/(2*pi),4) ' Hz'],'linewidth',1.5)
    hold on    
end

figure(num_figure)
legend()
title(['\phi-' project_name])
xlabel('x / m')
hold off
figure(num_figure+1)
legend()
title(['d\phi-' project_name])
xlabel('x / m')
hold off
num_figure = num_figure+2;