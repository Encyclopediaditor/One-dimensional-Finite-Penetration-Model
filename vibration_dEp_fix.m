function delta_Epsilon_p_new = vibration_dEp_fix(delta_Epsilon_p)
% vibration_dEp_fix  fix the convex plastic strain in hollow area of MH bar model
% Invoking           none
% Invoked            Newmark_beta3
% INPUT
%   delta_Epsilon_p  vector of nx1, elemental plastic strain increment              
%%
delta_Epsilon_p_new = delta_Epsilon_p;
for i = 1:length(delta_Epsilon_p)
    if delta_Epsilon_p(i) > 0
        delta_Epsilon_p_new(i) = 0;
    end
end
end