function [Sigma, Tau] = drag_calculator_element(varfai0, Statuss, A, B, mu, x, y, v, varfai, theta, omega, alpha, vn)
% drag_calculator_element  normal and shear stress restoration on the surface
% Invoking                 drag_calculator_element
% Invoked                  dashploter
% INPUT
%   varfai0                scalar, element's radial limit contact angle
%   A,B,mu                 scalar, Cavity Expansion Model's coefficient     
%   v                      scalar, the absolute peneration velocity
%   x                      scalar, element's axial location
%   y                      scalar, element's radius
%   varfai                 scalar, element's radial angle
%   theta                  scalar, the angle between surface's tangential direction and rotational axis
%   omega                  scalar, angular velocity
%   alpha                  scalar, the angle of attack
%   vn                     scalar, element's nomal velocity
% OUTPUT
%   Sigma                  vector of 3x1, normal stress
%   Tau                    vector of 3x1, tangential stress
%%
is_in = 1;
if ~isempty(varfai0)
    if length(varfai0) == 1
        if Statuss == 1
            if varfai <= varfai0
                is_in = 0;
            end
        else
            if varfai >= varfai0
                is_in = 0;
            end
        end
    else
        if varfai <= varfai0(1) || varfai >= varfai0(2)
            is_in = 0;
        end
    end
end

if is_in == 1
Sigma = [ -sin(theta)*(A + B*(vn + sin(theta)*(v*cos(alpha) - omega*y*sin(varfai)) + cos(theta)*sin(varfai)*(omega*x + v*sin(alpha)))^2);
        -cos(theta)*sin(varfai)*(A + B*(vn + sin(theta)*(v*cos(alpha) - omega*y*sin(varfai)) + cos(theta)*sin(varfai)*(omega*x + v*sin(alpha)))^2);
        -cos(varfai)*cos(theta)*(A + B*(vn + sin(theta)*(v*cos(alpha) - omega*y*sin(varfai)) + cos(theta)*sin(varfai)*(omega*x + v*sin(alpha)))^2)];

Tau = [ -(mu*abs(sin(varfai))*cos(theta)*(A + B*(vn + sin(theta)*(v*cos(alpha) - omega*y*sin(varfai)) + cos(theta)*sin(varfai)*(omega*x + v*sin(alpha)))^2))/(- cos(varfai)^2*cos(theta)^2 + 1)^(1/2);
    (mu*sign(sin(varfai))*sin(theta)*(A + B*(vn + sin(theta)*(v*cos(alpha) - omega*y*sin(varfai)) + cos(theta)*sin(varfai)*(omega*x + v*sin(alpha)))^2))/(- cos(varfai)^2*cos(theta)^2 + 1)^(1/2); 0];
else
Sigma = [0;0;0];

Tau = [0;0;0];
end
  