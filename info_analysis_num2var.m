function [var, info, varname, addon] = info_analysis_num2var(num, T, info, var_new)
% info_analysis_num2var  from order of request to context of request
% Invoking               none
% Invoked                info_analysis
% INPUT
%   num                  scalar, rank of current selection 
%   T                    cell, containing all default selection information
%   info                 struct, representing single calculation request
%   var_new              empty or multi-type, the info to be substituted
% OUTPUT
%   var                  multi-type, the info to be substituted
%   varname              string, name of the variable
%   addon                string, variable's value (text type)
%%
addon = T{num,6};
t = T(num,:);
varname = T{num,5};

for i = 1:5
    if isempty(t{i})
       break 
    end
end

if isempty(var_new)
    try
        switch i
            case 3
                var = info.(t{1}).(t{2});        
            case 4
                var = info.(t{1}).(t{2}).(t{3});
            case 5
                var = info.(t{1}).(t{2}).(t{3}).(t{4});
        end
    catch
        var = [];
        return
    end
else     
    switch i
        case 3
            info.(t{1}).(t{2}) = var_new;            
        case 4
            info.(t{1}).(t{2}).(t{3}) = var_new;
        case 5
            info.(t{1}).(t{2}).(t{3}).(t{4})  = var_new;
    end
    
    var = var_new;
    switch addon
        case 0
            addon = var;
        case 1
            addon = num2str(var);
        case 2
            addon = num2str(ceil(length(var)/2));
        case 3
            addon = num2str(var/pi*180);
        case 4
            addon = num2str(var/(10^6));
        case 5
            addon = num2str(var(1)/(10^9));
        case 6
            if var
                addon = 'true';
            else
                addon = 'false';
            end
        case 7
            addon = '';
    end
end

