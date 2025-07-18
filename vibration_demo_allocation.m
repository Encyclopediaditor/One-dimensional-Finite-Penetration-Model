function [T_a, TV, v_min, v_max] = vibration_demo_allocation(Result, k, plt)
% vibration_demo_allocation  allocate the vibration info to be presented
% Invoking                   dashploter_frame
% Invoked                    vibration_demo
% INPUT
%   Result                   struct, recording overall calculation results 
%   k                        scalar, rank of variables to be presented
%   plt                      struct, representing basic configuratuion options of post-process
%%
TV = cell(1,length(Result));
frame_min_loc = 1;
for j = 1:length(Result)
    if length(Result{j}.now.T) < length(Result{frame_min_loc}.now.T)
        frame_min_loc = j;
    end
end
T = Result{frame_min_loc}.now.T;
for j = 1:length(Result)
    if j ~= frame_min_loc
        Result{j}.post.viber.Tv{k} = interp1(Result{j}.now.T, Result{j}.post.viber.Tv{k}, T);
    end
end

for j = 1:length(Result)
    Tv = Result{j}.post.viber.Tv;
    Tv = Tv{k};
    if j == length(Result)
        [T_a,Tv] = dashploter_frame(T,Tv,plt.frame_option,plt.num_frame);
    else
        [~,Tv] = dashploter_frame(T,Tv,plt.frame_option,plt.num_frame);
    end
    TV{j} = Tv;
    if j == 1
        v_max = max(max(Tv));
        v_min = min(min(Tv));
    else
        if max(max(Tv)) > v_max
            v_max = max(max(Tv));
        end
        if min(min(Tv)) < v_min
            v_min = min(min(Tv));
        end
    end
end

if v_min == v_max
    v_max = v_min + 1;
end
end