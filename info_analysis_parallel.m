function [Info_normal, Info_parallel] = info_analysis_parallel(Info)
% info_analysis_parallel  divide requests into those which shall be dealt parallel, and those which shall not
% Invoking                none
% Invoked                 main; main_execution
% INPUT
%   Info                  cell with struct element, representing unziped calculation request 
% OUTPUT
%   Info_normal           cell with struct element, representing unziped calculation request without parallel calculation
%   Info_parallel         cell with struct element, representing unziped calculation request with parallel calculation
%%
    loc_normal = linspace(1,length(Info),length(Info));
    loc_parallel = linspace(1,length(Info),length(Info));
    
    for i = length(Info):-1:1
        is_parallel = Info(i).simulation.parallel;
        if is_parallel
            loc_normal(i) = [];
        else
            loc_parallel(i) = [];
        end
    end
    
    Info_normal = Info(loc_normal);
    Info_parallel = Info(loc_parallel);
end