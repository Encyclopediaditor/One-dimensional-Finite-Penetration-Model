clear;clc;
%%  main_execution
%    Function: execute stored request
%    Requirement: select xx_info.mat
%%
[filename, pathname] = uigetfile('*.mat', 'Select input info file to execute') ;
load([pathname, filename],'info','binding');
Info = info_analysis(info, binding);

[Info_normal, Info_parallel] = info_analysis_parallel(Info);
result = struct();
Result = cell(1,length(Info));

if ~isempty(Info_parallel)
    parfor i = 1:length(Info_parallel)
        info = Info_parallel(i);
        result = struct();
        result.project_name = info.project_name;

        result = Processor_pre(info, result);
        result = Processor_now(info, result);
        Result{i} = result;
    end
end

if ~isempty(Info_normal)
    for i = length(Info_parallel)+1:length(Info)
        info = Info_normal(i-length(Info_parallel));
        result = struct();
        result.project_name = info.project_name;

        result = Processor_pre(info, result);
        result = Processor_now(info, result);
        Result{i} = result;
    end
end

Result = Processor_post(Info, Result);
vibration_demo(Info, Result);
filename = strrep(filename,'_info','_result');
save([pathname, filename],'Result')