function Info = info_analysis(info, binding)
% info_analysis  analyze calculation request
% Invoking       info_analysis_table; info_analysis_num2var; info_analysis_var2num
% Invoked        main; main_preparation; main_preparation2; main_execution;
%                Config_generator_oval; Buckling_test_load; Buckling_test_modal
% INPUT
%   info         struct, representing current calculation request
%   binding      cell with cell element, representing combination of calculation request
% OUTPUT
%   Info         cell with struct element, representing unziped calculation request
%%
T = info_analysis_table();
info_var = zeros(3,size(T,1));
info_copy = info;

loc_empty = [];
for i = 1:length(info_var)
    [var, ~, ~, ~] = info_analysis_num2var(i, T, info, []);
    if ~isempty(var)
        if iscell(var)
            info_var(1,i) = length(var);
        else
            info_var(1,i) = 1;
        end
        if info_var(1,i) > 1
            info_var(3,i) = 1;
        end
    else
        loc_empty = [loc_empty i];
    end
end
T(loc_empty,:) = [];
info_var(:,loc_empty) = [];

mod_num = 1;
for i = 1:length(binding)
    num = zeros(1,length(binding{i}));
    for j = 1:length(binding{i})
        num(j) = info_analysis_var2num(binding{i}{j}, T);
        if j >= 2
            info_var(2,num(j)) = num(1);
            info_var(3,num(j)) = 2;
            mod_num = mod_num*info_var(1,num(j));
        end
    end
end

Info = repmat(info,[1,prod(info_var(1,:))/mod_num]);
var_circle_loc = find(info_var(3,:) == 1);
var_circle_info = info_var(1,var_circle_loc);

for i = 1:prod(info_var(1,:))/mod_num
    info = info_copy;
    text = [];
    for j = 1:size(T,1)
        if info_var(3,j) > 0
            if info_var(3,j) == 1
                var_index = j;
            elseif info_var(3,j) == 2
                var_index = info_var(2,j);
            end
            circle_loc = find(var_circle_loc == var_index);
            if circle_loc == 1
                k = mod(i,var_circle_info(circle_loc));
            else
                k = mod(ceil(i/prod(var_circle_info(1:circle_loc-1))),var_circle_info(circle_loc));
            end
            if k == 0
                k = var_circle_info(circle_loc);
            end
            
            [var, ~, ~, ~] = info_analysis_num2var(j, T, info, []);
            [~, info, varname, addon] = info_analysis_num2var(j, T, info, var{k});
            text = [text varname ' ' addon ' '];
        end
    end
    
    if ~isempty(text)
        info.project_name = text;
    end
    Info(i) = info;
end

end