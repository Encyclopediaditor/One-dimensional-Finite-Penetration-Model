function vibration_demo(Info, Result)
% vibration_demo  demonstration of structural response of projectile
% Invoking        info_analysis_sigma; info_analysis_viber;
%                 vibration_demo_allocation; dashploter_save; vibration_modal_plot;
%                 Config_generator_demo; vibration_modal_plot2; vibration_ribbon
% Invoked         main; main_execution
% INPUT
%   Info          struct, representing overall calculation requests
%   Result        struct, recording overall calculation results     
%% Delete irrelevant samples
loc = [];
for j = 1:length(Result)
    if ~Info(j).plot.vibration_analysis
        loc = [loc j];
    end
end
Info(loc) = [];
Result(loc) = [];

if ~isempty(Info)
    %% Preparation
    num_figure = 1; % num_figure is the key variable
    plt = Info(1).plot;
    Coord = Result{1}.pre.Coord;
    X_real = (Coord(:,1))';
    Viber_option = info_analysis_sigma(Info(1).config.projectile.E, plt.vibration.option);
    
    for k = 1:length(Viber_option)
        [X, ytext] = info_analysis_viber(X_real, Viber_option{k});
        
        switch plt.vibration.expression
          %% Three cases
            case 'animation'
                x_min = min(X);
                x_max = max(X);
                [T_a, TV, v_min, v_max] = vibration_demo_allocation(Result, k, plt);
                
                figure(num_figure)
                for i = 1: length(T_a)
                    for j = 1:length(Result)
                        plot(X, TV{j}(i,:), 'DisplayName', Info(j).project_name,'linewidth',1.5)
                        hold on
                    end
                    legend('Location','Southwest')
                    axis([x_min,x_max,v_min,v_max]);
                    set(gcf,'color','w')
                    xlabel('Location / m')
                    ylabel(ytext)
                    ax = gca;
                    ax.FontName = 'Times New Roman';
                    ax.FontSize = 14;
                    t = T_a(i);
                    text(x_min + (x_max-x_min)/30, (0.5*v_max+ 0.5*v_min), ['t = ' num2str(t) ' s'],'fontname','Times New Roman','fontsize',14);
                    hold off                 
                    dashploter_save(plt.saving, i, ['viber ' Viber_option{k} num2str(k) '.gif']) 
                end
                num_figure = num_figure+1;       
            case 'bisect'
                Loc = plt.vibration.location;
                for i = 1:length(Loc)                   
                    for j = 1:length(Result)
                        figure(num_figure)
                        loc = max(floor(Loc(i)*length(X)),1);
                        T = Result{j}.now.T;
                        Tv = Result{j}.post.viber.Tv;
                        if strcmp(Viber_option{1},'Epsilon') && strcmp(Viber_option{k},'Sigma')
                            plot(Tv{1}(:,loc), Tv{k}(:,loc), 'DisplayName', [Info(j).project_name num2str(k-1)],'linewidth',1.5)
                        else
                            plot(T, Tv{k}(:,loc), 'DisplayName', [Info(j).project_name num2str(k-1)],'linewidth',1.5)
                        end
                        hold on
                        
                        figure(num_figure+1)
                        temp = Tv{k}(:,loc);
                        dtemp = diff(temp)./diff(T);
                        dtemp = ([dtemp(1); dtemp] + [dtemp; dtemp(end)])/2;
                        plot(temp, dtemp, 'DisplayName', [Info(j).project_name num2str(k-1)],'linewidth',1.5)
                        hold on
                        text(temp(1),dtemp(1),'Start','fontname','Times New Roman','fontsize',14)
                        text(temp(end),dtemp(end),'End','fontname','Times New Roman','fontsize',14)                        
                    end
                    
                    figure(num_figure)
                    if strcmp(Viber_option{1},'Epsilon') && strcmp(Viber_option{k},'Sigma')
                        xlabel('\epsilon')
                        ylabel(ytext)
                    else
                        xlabel('t / s')
                        ylabel(ytext)
                    end
                    ax = gca;
                    ax.FontName = 'Times New Roman';
                    ax.FontSize = 14;
                    title(['Location = ' num2str(Loc(i))],'fontname','Times New Roman')
                    legend('location','southeast')
                    hold off
                    
                    figure(num_figure+1)
                    xlabel(ytext)
                    ylabel(['d ' ytext ' /s'])
                    ax = gca;
                    ax.FontName = 'Times New Roman';
                    ax.FontSize = 14;
                    title(['Location = ' num2str(Loc(i))],'fontname','Times New Roman')
                    legend('location','southeast')
                    hold off
                    num_figure = num_figure+2;
                end
            case 'mesh'
                x_min = min(X);
                x_max = max(X);
                [T_a, TV, v_min, v_max] = vibration_demo_allocation(Result, k, plt);
                for j = 1:length(Result)  
                    vibration_ribbon(X, T_a, TV{k}, 1, 300, num_figure)
                    title(Info(j).project_name,'fontname','Times New Roman')
                    view([26,47])
                    axis([min(T_a) max(T_a) x_min x_max v_min v_max])
                    xlabel('time / s')
                    ylabel('location / m')
                    zlabel(ytext)
                    ax = gca;
                    ax.FontName = 'Times New Roman';
                    ax.FontSize = 14;
                    num_figure = num_figure+1;
                end
        end
    end
    
    %% Modal related plot
    for j = 1:length(Result)
        if strcmp(Info(j).plot.vibration.modal_plot, 'Curve')
            if strcmp(Info(j).config.projectile.bar, 'MH')
                Modal = Result{j}.post.viber.Modal;
                project_name = [Info(j).project_name '-u'];
                num_figure = vibration_modal_plot(X_real, Modal(1:size(Modal,1)/2+1,:), Result{j}.post.viber.Frequency,...
                                                  num_figure, project_name);
                project_name = [Info(j).project_name '-v'];
                Modal = [zeros(1,size(Modal,2)); Modal(size(Modal,1)/2+2:end,:); zeros(1,size(Modal,2))];
                num_figure = vibration_modal_plot(X_real, Modal, Result{j}.post.viber.Frequency,...
                                                  num_figure, project_name);
            else
                num_figure = vibration_modal_plot(X_real, Result{j}.post.viber.Modal, Result{j}.post.viber.Frequency,...
                                                  num_figure, Info(j).project_name);
            end
        elseif strcmp(Info(j).plot.vibration.modal_plot, 'Color')
            Yo_real = (Result{j}.pre.Coord(:,2));
            Yi_real = (Result{j}.pre.Coord_all(:,2,end));
            Gamma = Result{j}.pre.gamma;
            
            for k = 1:3
                Modal = Result{j}.post.viber.Modal;
                fai = Modal(:,k)/max(abs(Modal(:,k)));
                Text = {[ Info(j).project_name ', ' num2str(k) ': ' num2str(Result{j}.post.viber.Frequency(k)/(2*pi),4) ' Hz']};
                num_figure = Config_generator_demo(Info(j), num_figure, Text);
                vibration_modal_plot2(X_real', Yo_real, Yi_real, fai, Gamma, Info(j).config.projectile.bar, num_figure-1);
            end
        end
    end
end
end