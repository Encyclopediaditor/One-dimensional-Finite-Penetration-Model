function dashploter_colorbar(F_min, F_max, C, plt)
% dashploter_colorbar   colorbar setting of animation plot
% Invoking              interp_inv
% Invoked               dashploter
% INPUT
%   F_min               scalar, min value of colorbar
%   F_max               scalar, max value of colorbar
%   C                   matrix of nx3, color gradient setting
%   plt                 struct, representing basic configuratuion options of post-process
%%
    projectile_map_option = plt.animation.projectile.map;
    medium_map_option = plt.animation.medium.map;

    % Color paint: colorbar, type I
    if ~isempty(projectile_map_option) || (~isempty(medium_map_option) && strcmp(medium_map_option, 'Stress'))      
        hc = colorbar('westoutside');       
        hc_tick = linspace(0,1,11);
        hc_tickF = interp_inv(hc_tick*interp_define(F_max)+(1-hc_tick)*interp_define(F_min));    
        set(hc,'YTick',hc_tick)
        set(hc,'YTickLabel',hc_tickF)
        if ~isempty(medium_map_option)
            hc.Label.String = [projectile_map_option ' Stress / Pa'];
        else
            hc.Label.String =  'Stress / Pa';
        end

        colormap(C)
    end
    
    % Color paint: colorbar, type II
    if ~isempty(medium_map_option) && strcmp(medium_map_option, 'Component')        
        hc = colorbar('westoutside');       
        hc_tick = [1/6 1/2 5/6];
        hc_tickF = {'Elastic','Plastic','Fractural'};    
        set(hc,'YTick',hc_tick)
        set(hc,'YTickLabel',hc_tickF)

        colormap(C)
    end
end