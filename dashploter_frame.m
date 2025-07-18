function [T,X] = dashploter_frame(T,X,frame_option,num_frame)
% dashploter_frame   determine which frame to be presented in animation
% Invoking           none
% Invoked            dashploter; proploter; vibration_demo_allocation
% INPUT
%   T                vector of nx1, recorded sinmulation time
%   X                matrix of nx6, with each column [X Y VX VY Fai Omega]
%   frame_option     string, can be 'Data' or 'Time'
%   num_frame        scalar, number of frame to be presented
%%
    if strcmp(frame_option,'Data')
        if length(T)>num_frame
            num=zeros(1,num_frame);
            for i=1:num_frame
              num(i)=floor(length(T)/num_frame*i);
            end

            T=T(num);
            X=X(num,:);
        end
    elseif strcmp(frame_option,'Time')
        if length(T)>num_frame
            num = zeros(1,num_frame); 
            for i = 0:num_frame-1     
              tim=T(end)/(num_frame-1)*i;
              t_temp = abs(T-tim);
              [~,n_temp] = min(t_temp);
              num(i+1) = n_temp;
            end

            T=T(num);
            X=X(num,:);
        end
    end
end