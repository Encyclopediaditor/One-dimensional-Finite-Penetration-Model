function Result = Processor_post(Info, Result)
% Processor_post  post process after penetration simulation
% Invoking        vibration_seeker; proploter; dashploter; info_analysis_varplot
% Invoked         main; main_execution
% INPUT
%   Info          struct, representing overall calculation requests
%   Result        struct, recording overall calculation results
%%
for j = 1:length(Result)
    info = Info(j);
    result = Result{j};
    
    post = struct();
    config = info.config;
    plt = info.plot;
    pre = result.pre;
    now = result.now;
    X = now.X;
    T = now.T;

    if plt.vibration_analysis || (plt.history_animation && strcmp(plt.animation.projectile.map, 'Vibration')) 
        if info.simulation.coupled
            post.viber.Tv = now.Tv;
            post.viber.TUX = now.TUX;
            post.viber.TGX = now.TGX;
            post.viber.Frequency = pre.Frequency;
            post.viber.Modal = pre.Modal;       
        else
            [post.viber.Tv, post.viber.TUX, post.viber.TGX, post.viber.Frequency, post.viber.Modal] ...
                = vibration_seeker(X, T, config, pre, plt);
        end
    end
    
    if plt.history_animation
        filename = [result.project_name ' history.gif'];
        if strcmp(plt.animation.projectile.map, 'Vibration')
            proploter(X, T, config, pre, post, plt, filename)
        else
            dashploter(X, T, config, pre, plt, filename);
        end
    end
    
    if plt.other_plot
        other = plt.other;
        Varname_x = split(other.x,',');
        Varname_y = split(other.y,',');
        Var_x = Varname_x;
        Var_y = Varname_y;

        for i = 1:length(Var_x)
            figure(i)
            if info.simulation.coupled
                dTop = result.now.TUX(:,end);
            else
                dTop = zeros(size(T));
            end
            lct = pre.l-pre.lc;
            [Var_x{i}, note_x] = info_analysis_varplot(Varname_x{i}, X, T, other.x_loc, lct, dTop);
            [Var_y{i}, note_y] = info_analysis_varplot(Varname_y{i}, X, T, other.x_loc, lct, dTop);
            p1 = plot(Var_x{i},Var_y{i},'displayname',result.project_name,'linewidth',1.5);
            xlabel(note_x)
            ylabel(note_y)
            ax = gca;
            ax.FontName = 'Times New Roman';
            ax.FontSize = 14;
            hold on
            Wall_loc_x = config.medium.config;
            lgd = legend();
            if strcmp(Varname_x{i},'x') && length(Wall_loc_x) > 1
                Wall_loc_y = interp1(Var_x{i},Var_y{i},Wall_loc_x);
                p2 = plot(Wall_loc_x,Wall_loc_y,'*');
                p2.Color = p1.Color;
                lgd.String = lgd.String(1:end-1);
            end            
        end
                       
        post.Varname_x = Varname_x;
        post.Var_x = Var_x;
        post.Varname_y = Varname_y;
        post.Var_y = Var_y;
        
    end
    result.post = post;
    Result{j} = result;
end

end