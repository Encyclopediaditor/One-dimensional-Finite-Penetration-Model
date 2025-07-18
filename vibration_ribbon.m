function vibration_ribbon(X, T, Tv, width, num_ribbon, num_figure)
% vibration_ribbon  demonstration of structural response in mesh style
% Invoking          Medium_colormap
% Invoked           vibration_demo
% INPUT
%   X               vector of 1xm, axial location of elements
%   T               vector of nx1, timestep serise
%   width           scalar, relative width of ribbon, 0<width<=1
%   num_ribbon      scalar, number of ribbon
%   num_figure      scalar, the rank of figure
%%
    if num_ribbon < length(T)
        Tv = Tv(1:num_ribbon, :);
        T = T(1:num_ribbon);
    end
    Tv_max = max(max(Tv));
    Tv_min = min(min(Tv));
    dt = width*(T(2) - T(1))/2;
    C = Medium_colormap(length(X),0.1,false);
    
    figure(num_figure)
    H = ribbon(Tv'); shading flat
    hidden off
    colormap(C)
    for i = 1:length(H)
        H(i).XData = repmat([T(i)-dt, T(i)+dt],[length(X),1]);
        H(i).YData = repmat(X',[1,2]);
        H(i).CData = repmat((Tv(i,:)' - Tv_min)/(Tv_max - Tv_min),[1,2]);
    end
    
end