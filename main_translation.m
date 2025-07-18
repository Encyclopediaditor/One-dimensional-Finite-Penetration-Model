clear;clc;
%%  main_translation
%    Function: translate xx_info.mat into main_preparation.m
%    Requirement: select xx_info.mat
%% Prepration
T = info_analysis_table();

%% Begin
[filename, pathname] = uigetfile('*.mat', 'Select input info file to translate') ;
load([pathname, filename],'info','binding');

fid = fopen([pathname,'main_preparation.m'],'w');
fprintf(fid,'clear;clc;\n \n');
fprintf(fid,'info = struct();\n');
fprintf(fid,['info.project_name = ''' info.project_name ''';\n %%%% 1 Basic configuratuion options \n %%%% 1.1 Medium geometry \n']);

for i = 1:size(T,1)
    t = T(i,:);
    if isempty(t{8})
        continue
    end
    
    for j = 1:length(t)-2
        if isempty(t{j})
           break 
        end
    end
    if j == 3
        var = info.(t{1}).(t{2});
        varname = ['info.', t{1}, '.', t{2}];
    elseif j == 4
        var = info.(t{1}).(t{2}).(t{3});
        varname = ['info.', t{1}, '.', t{2}, '.', t{3}];
    elseif j >= 5
        var = info.(t{1}).(t{2}).(t{3}).(t{4});
        varname = ['info.', t{1}, '.', t{2}, '.', t{3}, '.', t{4}];
    end

    if iscell(var)
        str = '{';
        for j = 1:length(var)
            if j < length(var)
                str = [str, info_analysis_var2str(var{j}) ', '];
            else
                str = [str, info_analysis_var2str(var{j}) '}'];
            end
        end
    else
        str = info_analysis_var2str(var);
    end
    fprintf(fid,[varname ' = ' str '; ' T{i,7}, '\n']);
end

if isempty(binding)
    fprintf(fid, 'binding = {};\n');
elseif isempty(binding{1})
    fprintf(fid, 'binding = {{}};\n');
else
    str = 'binding = {';
    for i = 1:length(binding)
        str = [str '{'];
        for j = 1:length(binding{i})
            if j < length(binding{i})
                str =  [str ''''  binding{i}{j} ''', '];
            else
                str =  [str ''''  binding{i}{j} '''} '];
            end
        end

        if i < length(binding)
            str = [str ',...\n '];
        else
            str = [str '}; \n'];
        end
    end
    fprintf(fid, str);
end

fprintf(fid,'\n');
fprintf(fid,'%%%% 5. Analysis & Save');
fprintf(fid,'\n');
fprintf(fid,'Info = info_analysis(info, binding);\n');
fprintf(fid,'Config_generator_demo(Info, 1);\n');
fprintf(fid,'save([info.project_name ''_info.mat''],''info'',''binding'')\n');

fclose(fid);