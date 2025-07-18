function num = info_analysis_var2num(varname, T)
% info_analysis_var2num  from context of request to order of request
% Invoking               none
% Invoked                info_analysis
% INPUT
%   T                    cell, containing all default selection information
%   varname              string, name of the variable
% OUTPUT
%   num                  scalar, rank of current selection 
%%
varname = split(varname,'.');

for i = 1:size(T,1)
    is_true = true;
    for j = 1:length(varname)
        if ~strcmp(varname{j}, T{i,j})
            is_true = false;
            break
        end
    end
    
    if is_true
        num = i;
        return
    end
end