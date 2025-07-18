function ratio = interp_theta(theta, alpha, psi)
% interp_theta  force adjustment during drag calculation
% Invoking      none
% Invoked       drag_calculator
% INPUT
%   theta       scalar, the angle between surface's tangential direction and rotational axis
%   alpha       scalar, the angle of attack
%   psi         scalar, reference angle, within which the adjustment takes effect
% OUTPUT
%   ratio       scalar, drag_new = drag*ratio
%%
a = abs(alpha) + abs(theta);
if a < psi
    ratio = a/psi;
else
    ratio = 1;
end

end