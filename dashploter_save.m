function dashploter_save(saving, i, filename)
% dashploter_save   save the animation scene frame by frame
% Invoking          none
% Invoked           dashploter; vibration_demo
% INPUT
%   saving          logical, whether to save file
%   i               scalar, rank of presented timestep    
%   filename        string, file name to be saved  
% OUTPUT
%      
%%
    if saving
        [Body,map] = rgb2ind(frame2im(getframe(gcf)),256);
        if i == 1
            imwrite(Body,map,filename,'gif','LoopCount',Inf,'DelayTime',0);
        else
            imwrite(Body,map,filename,'gif','WriteMode','append','DelayTime',0);
        end
    else
        pause(0.01)
    end
end