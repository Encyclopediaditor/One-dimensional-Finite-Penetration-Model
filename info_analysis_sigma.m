function Option = info_analysis_sigma(E, option)
% info_analysis_sigma  analyze the request of vibration plot
% Invoking             none
% Invoked              proploter; vibration_demo
% INPUT
%   E                  vector, materials's Young's modulus
%   option             string, ziped vibration analysis option
% OUTPUT
%   Option             cell with string element, unziped vibration analysis options       
%%
str_Sigma = repmat('Sigma,',[1 length(E)]);
str_PlasticEp = repmat('PlasticEp,',[1 length(E)]);

option = strrep(option, ' ', '');
option = strrep(option, 'Sigma',str_Sigma(1:end-1));
option = strrep(option, 'PlasticEp',str_PlasticEp(1:end-1));
Option = split(option,',');

end