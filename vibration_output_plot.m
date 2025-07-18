function vibration_output_plot(X, Tv, T, AXIS, num_i, num_figure)
% vibration_output_plot  plot for thesis
% Invoking               none
% Invoked                test
% INPUT
%   X                    matrix of nx6, with each column [X Y VX VY Fai Omega]
%   Tv                   matrix of nxm, with n array of timestep and m column of elemental designated variable
%   T                    vector of nx1, recorded sinmulation time
%   AXIS                 vector of 1x4, [xmin xmax ymin ymax]
%   num_i                scalar, rank of timestep to be plotted
%   num_figure           scalar, rank of figure
%%
Style1 = {'b-','r-','k-','m-','c-'};
Style2 = {'bo','r+','k*','m^','cv'};
Style3 = {'b-o','r-+','k-*','m-^','c-v'};

figure(num_figure)
P = [];
tim = 1;
for i = num_i
    plot(X, Tv(i,:), Style1{tim},'linewidth',1.5);    
    hold on
    plot(X(1:10:end), Tv(i,1:10:end), Style2{tim},'linewidth',1.5)
    p = plot(X(1:2), Tv(i,1:2), Style3{tim}, 'DisplayName', ['t = ' num2str(T(i),'%.2e') ' s'],'linewidth',1.5);
    P = [P p];
    tim = tim + 1;
end

axis(AXIS);
xlabel('Location / m')
% ylabel('\sigma_v / Pa')
ylabel('\psi')
% ylabel('Displacement / m')
lgd = legend(P,'location','southwest');
lgd.NumColumns = 1;
ax = gca;
ax.FontName = 'Times New Roman';
ax.FontSize = 14;
% title('Tungsten', 'fontname','Times New Roman')
% title('30 Steel', 'fontname','Times New Roman')
% title('30 Steel', 'fontname','Times New Roman')
end