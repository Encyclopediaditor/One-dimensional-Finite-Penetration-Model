function str = info_analysis_var2str(var)
% info_analysis_var2str  from stored request term and its value to plain text
% Invoking               info_analysis_var2str_num
% Invoked                main_translation
% INPUT
%   var                  multi-type, the info to be substituted
% OUTPUT
%   str                  string, variable's value (text type) and join
%%
    if islogical(var)
        if var
            str = 'true';
        else
            str = 'false';
        end
    elseif isnumeric(var)
        if size(var,2) == 1 || size(var,1) == 1 % array
            if length(var) == 1
                str = info_analysis_var2str_num(var);
            elseif length(var) == 2
                str = ['[' info_analysis_var2str_num(var(1)) ' ' info_analysis_var2str_num(var(2)) ']'];
            else
                for i = 1:ceil(length(var)/2)
                    if i == 1
                        str = [' ...\n    [' num2str(var(2*i-1)) ';' num2str(var(2*i)) ';\n']; 
                    elseif i == ceil(length(var)/2)
                        if mod(length(var),2) == 1
                           str = [str '    ' num2str(var(2*i-1)) ']']; 
                        else
                           str = [str '    ' num2str(var(2*i-1)) ';' num2str(var(2*i)) ']']; 
                        end
                    else
                        str = [str '    ' num2str(var(2*i-1)) ';' num2str(var(2*i)) ';\n']; 
                    end
                end
            end
        else
            for i = 1:size(var,1)
                if i == 1
                    str = ' ...\n    [';
                else
                    str = [str '     '];
                end
                for j = 1:size(var,2)
                    if j == 1
                        str = [str num2str(var(i,j))];
                    else
                        if mod(j,3) == 1
                            str = [str '  ' num2str(var(i,j))];
                        else
                            str = [str ' ' num2str(var(i,j))];
                        end
                    end
                end
                if i == size(var,1)
                    str = [str  ']'];
                else
                    str = [str  ';\n'];
                end
            end
        end           
    else
        str = ['''' var ''''];
    end
end