function info_analysis_progress(num_all, num_now, affix)
% info_analysis_progress  show the progress of calculation
% Invoking                      none
% Invoked                       vibration_bar; vibration_seeker; Newmark_beta; Newmark_beta2; Newmark_beta3
% INPUT
%   num_all                     number of steps to finish the process
%   num_now                  number of steps now
%   affix                          affix in display
%%
if mod(num_now,num_all/10) < 1
    disp([affix  num2str(num_now/num_all*100, 3) '%'])
end
end