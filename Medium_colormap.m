function C = Medium_colormap(num, transparency, is_normal)
% Medium_colormap  determine the color in specific points
% Invoking         none
% Invoked          dashploter; proploter; vibration_modal_plot2; vibration_ribbon
% INPUT
%   num            scalar, number of color gradient
%   transparency   scalar, 0<value<1, 1 means totally transparent
%   is_normal      logical, two type of demo selection
% OUTPUT
%   C              matrix of nx3, color gradient setting      
%%
if is_normal
    c_max = [1 transparency transparency];
    c_min = [transparency transparency 1];
else
    c_max = [transparency transparency 1];
    c_min = [1 transparency transparency];
end
c_mid = [transparency 1 transparency];
num = min(20,floor(num));

C = zeros(num,3);

for i = 1:num
    if i <= num/2
        C(i,:) = c_min + (c_mid - c_min)*(i-1)/(num/2);
    else
        C(i,:) = c_mid + (c_max - c_mid)*(i - num/2)/(num/2);
    end
end
end