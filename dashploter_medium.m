function dashploter_medium(Info, AXIS, Wall_loc, F_min, F_max, plt)
%dashploter_medium   medium color plot in animation
% Invoking           valve
% Invoked            dashploter
% INPUT
%   Info           matrix of 3xmxm, indicator of elements' properties
%   AXIS           vector of 1x4, [xmin xmax ymin ymax]
%   Wall_loc       vector, indicator of wall's location
%   F_min          scalar, min value of colorbar
%   F_max          scalar, max value of colorbar  
%   plt            struct, representing basic configuratuion options of post-process
%%
    medium_map_option = plt.animation.medium.map;
    num_mesh = plt.animation.medium.num_mesh;
    mesh_size = [(AXIS(2) - AXIS(1))/num_mesh, (AXIS(4) - AXIS(3))/num_mesh];

    x = linspace(AXIS(1), AXIS(2), num_mesh+1);
    for j = 1:length(Wall_loc)
        for k = 1:num_mesh+1
            if x(k)-Wall_loc(j) > 0
               break 
            end
        end
        x(k) = Wall_loc(j);
    end
    x = [x AXIS(2)+mesh_size(1)*5];
    X = repmat(x, [num_mesh+1 1]);
    Y = repmat((linspace(AXIS(4),AXIS(3),num_mesh+1))', [1 num_mesh+2]);
    S = zeros(num_mesh+1,num_mesh+2);
    for j = 1: num_mesh+1
        for k = 1: num_mesh+1
            info = (Info(:,k,j))';
            if strcmp(medium_map_option, 'Stress')
                if info(3) ~= 0
                    S(j,k) = valve(sqrt((info(1))^2 + (info(2))^2), F_min, F_max);
                else
                    S(j,k) = NaN;
                end
            elseif strcmp(medium_map_option, 'Component')
                if info(3) > 0          
                    p = sqrt(info(1)/sum(info));
                    f = sqrt(info(2)/sum(info));                    
                    s = f + 2*p;
                    if s > 1
                       s = 1; 
                    end
                    S(j,k) = s;
                else
                    S(j,k) = NaN;
                end
            end
        end
    end

S(:,end) = 1;
S(:,end) = 0.99;
contour(X,Y,S,'ShowText','off','fill','on')

end