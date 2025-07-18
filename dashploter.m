function dashploter(X, T, config, pre, plt, filename)
%dashploter   animation plot of penetration simulation
% Invoking    dashploter_frame; drag_calculator_review; Medium_K_seeker; 
%             dashploter_layout; Medium_colormap; Medium_arranger; dashploter_medium; 
%             dashploter_projectile; dashploter_colorbar; dashploter_save
% Invoked     Processor_post
% INPUT
%   X         matrix of nx6, with each column [X Y VX VY Fai Omega]
%   T         vector of nx1, recorded sinmulation time
%   config    struct, representing basic configuratuion options of single claculation
%   pre       struct, obtained result from pre-processing
%   plt       struct, representing basic configuratuion options of post-process
%   filename  string, file name to be saved       
%% Key variables unzip
Wall_loc = config.medium.config;
Coord = pre.Coord;

%% Selection of frame
[T,X] = dashploter_frame(T,X,plt.frame_option,plt.num_frame);

%% Color data
F = [];
F_min = 0;
F_max = 0;

if ~isempty(plt.animation.medium.map)    
    Varfai = [85, -85]/180*pi;
    loc = floor(linspace(1,length(Coord)-1,plt.animation.num_source-1));
    loc = [loc(1:end-1), loc(end)-2, loc(end)];
    F = drag_calculator_review(X, Coord(loc,:), Varfai, config, pre, 'Normal');   
    [Kx ,Ky, Vxy] = Medium_K_seeker(X, F, Coord(loc,:), config.medium);
    F_min = min(F_min, min(min(min(F))));
    F_max = max(F_max, max(max(max(F))));
end
if ~isempty(plt.animation.projectile.map)
    Varfai = linspace(85,-85,plt.animation.projectile.num_mesh)/180*pi;
    F = drag_calculator_review(X, Coord, Varfai, config, pre, plt.animation.projectile.map);
    F_min = min(F_min, min(min(min(F))));
    F_max = max(F_max, max(max(max(F))));
end 

%% projectile layout
[coo, AXIS] = dashploter_layout(Coord,X);
medium_num_mesh = plt.animation.medium.num_mesh;
medium_map = plt.animation.medium.map;
projectile_map = plt.animation.projectile.map;
C = Medium_colormap(medium_num_mesh,plt.animation.transparency,true);

%% Animation
for i=1:length(T) 
    
    fai = X(i,5);
    BN = [cos(fai) sin(fai);
    -sin(fai) cos(fai)];
    Rn = [X(i,1);X(i,2)];
    plot([Wall_loc(1),Wall_loc(1)],[AXIS(3),AXIS(4)],'k')      
    hold on
    
    set(gca,'position',[0.085,0.05,0.885,0.9] );
    set(gcf,'color','w')
    set(gcf,'unit','normalized','position',[0.1,0.1,0.8,0.8*(AXIS(4)-AXIS(3))/(AXIS(2)-AXIS(1))]);
    set(gca,'XAxisLocation','origin');    
    set(gca,'YAxisLocation','origin');   
    set(gca, 'layer', 'top');
    axis(AXIS);
    ax = gca;
    ax.FontName = 'Times New Roman';
    % Color paint: medium
    if ~isempty(medium_map)
        if i == 1
            Cavity = zeros(medium_num_mesh+1);
            Info = zeros(3,medium_num_mesh+1,medium_num_mesh+1);
        end
        [Cavity, Info] = Medium_arranger(X, T, AXIS, Coord, Kx, Ky, Vxy,...
                                         Cavity, Info, config.medium, plt, i);        
        dashploter_medium(Info, AXIS, Wall_loc, F_min, F_max, plt)    
    end
    
    % Color paint: projectile
    if ~isempty(projectile_map)
        dashploter_projectile(Rn, BN, i, Coord, Varfai, F, F_min, F_max)
    end

    % Color paint: colorbar
    if ~isempty(medium_map) || ~isempty(projectile_map)
        dashploter_colorbar(F_min, F_max, C, plt)
    end
    
    % Others
    co = BN'*coo;
    co = co + Rn;
    plot(co(1,:),co(2,:),'k'); 
    if i>1
        plot(X(1:i,1),X(1:i,2),'k')
    end
    text(-0.08*(AXIS(2)-AXIS(1)),0.5*AXIS(4),['t=' num2str(T(i)) 's']);
    text(-0.08*(AXIS(2)-AXIS(1)),0.6*AXIS(4),['v=' num2str(sqrt(X(i,3)^2+X(i,4)^2)) 'm/s']);
    text(AXIS(1)+0.1*(AXIS(2)-AXIS(1)),AXIS(4)-0.1*(AXIS(4)-AXIS(3)),'Displacement/m');
    text(AXIS(2)-0.3*(AXIS(2)-AXIS(1)),AXIS(3)+0.15*(AXIS(4)-AXIS(3)),'Penetration depth/m');

    if length(Wall_loc) > 1
        for j=2:length(Wall_loc)
            plot([Wall_loc(j),Wall_loc(j)],[AXIS(3),AXIS(4)],'k')
        end
    end    
    hold off
       
    % Record
    dashploter_save(plt.saving, i, filename)
end

end