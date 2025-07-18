function str = info_analysis_var2str_num(var)
% info_analysis_var2str_num  from stored request term and its value to plain text
% Invoking                   none
% Invoked                    info_analysis_var2str
% INPUT
%   var                      multi-type, the info to be substituted  
% OUTPUT
%   str                      string, variable's value (text type)
%%
    if  var/(10^9) > 1
            str = [num2str(var/(10^9)) '*10^9'];
        elseif var/(10^6) > 1
            str = [num2str(var/(10^6)) '*10^6'];
        elseif abs(mod(var/pi*180,0.1)) < 10^(-6) && abs(var) > 10^(-6)
            str = [num2str(var/pi*180, '%.1f') '/180*pi'];
        else
            str = num2str(var);
    end 
end