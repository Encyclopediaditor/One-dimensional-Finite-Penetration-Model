function c = valve(F, F_min, F_max)
% valve     resize of large numbers
% Invoking  interp_define
% Invoked   dashploter_medium; dashploter_projectile
% INPUT
%   F       scalar, certain value
%   F_min   scalar, min value of colorbar
%   F_max   scalar, max value of colorbar      
% OUTPUT
%   c       scalar, revised certain value      
%%
c = (interp_define(F) - interp_define(F_min))/(interp_define(F_max) - interp_define(F_min));

if c > 1
 c = 1;
end
if  c < 0
 c = 0;
end

end

