function num_figure = Config_generator_demo(Info, num_figure, varargin)
%Config_generator_demo   demonstrate of projectile¡¯s simple outfit
% Invoking               turtle; dashploter_layout
% Invoked                main_preparation; main_preparation2; vibration_demo
% INPUT
%   Info                 cell with structure element, the Info of all condition
%   num_fig              scalar, the rank of figure
%   varargin             cell with string element, the title of the figures
% OUTPUT
%   num_fig              scalar, the rank of figure
%%
for j = 1:length(Info)
    info = Info(j);
    h = figure(num_figure);
    p = info.config.projectile;
    for i = 1:size(p.config, 1)
        Coord = p.beta*turtle(p.config(i,:), p.num_mesh);
        if i == 1
            AXIS = [-0.1 1.1 -1.2 1.2];
            Coord1 = Coord;
        end
        [coo, ~] = dashploter_layout(Coord,[Coord1(:,1) Coord1(:,1)]);
        if i == 1
            x_scale = max(coo(1,:));
            y_scale = max(coo(2,:));
        end
        plot(coo(1,:)/x_scale,coo(2,:)/y_scale)
        hold on
    end
    
    axis(AXIS);
    if ~isempty(varargin)
        title(varargin{1}{j},'fontname','Times New Roman','fontsize',18)
    end
    
    h.Position(3) = 560*2*(x_scale/y_scale)/10;
    h.Position(4) = 420/2;
    axis off
    set(gcf,'color','w')
    num_figure = num_figure + 1;
end

end