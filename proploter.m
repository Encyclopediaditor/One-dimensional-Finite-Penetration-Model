function proploter(X, T, config, pre, post, plt, filename)
% proploter   Wholesome plot of projectile response
% Invoking    dashploter_frame; info_analysis_sigma; info_analysis_viber; Medium_colormap
% Invoked     Processor_post
% INPUT
%   X         matrix of nx6, with each column [X Y VX VY Fai Omega]
%   T         vector of nx1, recorded sinmulation time
%   config    struct, representing basic configuratuion options of single claculation
%   pre       struct, obtained result from pre-processing
%   pre       struct, obtained result from post-processing
%   plt       struct, representing basic configuratuion options of post-process
%   filename  string, file name to be saved    
%%
% Basic info unzip
info = struct('config',config);
[T0,X] = dashploter_frame(T,X,plt.frame_option,plt.num_frame);
[~,TUX] = dashploter_frame(T,post.viber.TUX,plt.frame_option,plt.num_frame);
[~,TGX] = dashploter_frame(T,post.viber.TGX,plt.frame_option,plt.num_frame);
Tv = post.viber.Tv;
for i = 1:length(Tv)
    [~,Tv{i}] = dashploter_frame(T,Tv{i},plt.frame_option,plt.num_frame);   
end

% Geometry
Coord = pre.Coord;
Wall_loc = config.medium.config;
X_real = Coord(:,1);
num_r = ceil(length(X_real)/5);
if mod(num_r,2) == 0
    num_r = num_r + 1;
end
R = max(Coord(:,2));
X_min = min(X_real);
L = max(X_real) - X_min;
E = config.projectile.E;

% Data pre-allocation
Fai = zeros(length(X_real), num_r);
Y_all = Fai;
range = 0.1*L/max(max(abs(TUX)));
if isinf(range)
    range = 0;
end
Viber_option = info_analysis_sigma(E, plt.vibration.option);
[~,loc_Sigma] = ismember('Sigma', Viber_option);
[~,loc_PlasticEp] = ismember('PlasticEp', Viber_option);

len_figure = length(Viber_option);
if loc_Sigma > 0
    len_figure = len_figure - length(E) + 1;
end
if loc_PlasticEp > 0
    len_figure = len_figure - length(E) + 1;
end

% Start
num_viber = 1;
for num_figure = 1:len_figure
    TVX = Tv{num_viber};
    [X_real2, ytext] = info_analysis_viber(X_real, Viber_option{num_viber});
    Fai_min = min(min(TVX));
    Fai_max = max(max(TVX));
    if strcmp(Viber_option{num_viber},'Sigma') || strcmp(Viber_option{num_viber},'PlasticEp')
        for i = 1:length(E)-1
            Fai_min = min(Fai_min, min(min(Tv{num_viber+i})));
            Fai_max = max(Fai_max, max(max(Tv{num_viber+i})));
        end
    end
    
    for i = 1:length(T0)
        X_now = X_real + range*(TUX(i,:))';
        X_all = repmat(X_now, [1, num_r]);
        for j = 1:length(X_real)
            Seg = pre.Coord_all(j,2,:);
            Y_now = linspace(0,Coord(j,2)*(1+2*range*TGX(i,j)), (num_r+1)/2);
            Y_old = linspace(0,Coord(j,2),(num_r+1)/2);
            if strcmp(Viber_option{num_viber},'Sigma') || strcmp(Viber_option{num_viber},'PlasticEp')
                for k = 1:length(Seg)
                   [~,loc] = min(abs(Seg(k)-Y_old));       
                   if Seg(k) > 0
                       Fai(j,(num_r+3)/2-loc:(num_r-1)/2+loc) = interp1(X_real2,Tv{num_viber+k-1}(i,:),X_real(j));
                   end 
                end
            else
                Fai(j,:) = interp1(X_real2,TVX(i,:),X_real(j));
            end
            Y_all(j,:) = [fliplr(-Y_now) Y_now(2:end)]; 
        end
        Fai(end,1) = Fai_max;
        Fai(end,end) = Fai_min;
        
        Text = {['t = ' num2str(T0(i),'%10.2e') 's']};
        figure(num_figure)        
        Config_generator_demo(info, num_figure, Text);  
        hold on
              
        fai = X(i,5);
        Xi = ((Wall_loc-X(i,1))/cos(fai)-X_min)/L;
        for j = 1:length(Xi)
            plot([Xi(j)-2*tan(fai), Xi(j)+2*tan(fai)],[-2,2],'k')
        end

        C = Medium_colormap(num_r,0.1,false);
        contour((X_all-X_min)/L,Y_all/R,Fai,'ShowText','off','fill','on')
        colormap(C)
        hc = colorbar('west','AxisLocation','out');
        hc.Label.String =  ytext;
        
        hold off
        ax = gca;
        ax.FontName = 'Times New Roman';
        ax.FontSize = 16;
        dashploter_save(plt.saving, i, [filename(1:end-4) ' ' Viber_option{num_viber} '.gif'])   
    end
    if num_viber == loc_Sigma || num_viber == loc_PlasticEp
        num_viber = num_viber + length(E);        
    else
        num_viber = num_viber + 1;
    end
end
    
end