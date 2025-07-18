function [I, rpr, rpm] = Shell_parameter_seeker(R, R0, gamma, tip_fix)
% Shell_parameter_seeker  preprocess of shell element
% Invoking                none
% Invoked                 Processor_pre
% INPUT
%   R                     vector of nx1, outter radius of the shell
%   R0                    vector of nx1, inner radius of the shell
%   gamma                 scalar, Poisson's ratio
%   tip_fix               logical, whether to enlarge the stiffness of projectile's 5% part to avoid sigularity 
% OUTPUT
%   I, rpr, rpm           vector of nx1, coefficents' distribution for shell element
%%
num = length(R);
if tip_fix
    R(ceil(0.95*num):end) = R(floor(0.95*num));
    R0(ceil(0.95*num):end) = R0(floor(0.95*num));
end
I = pi/18*(R- R0).^3.*(R.^2 + 4*R.*R0 +R0.^2)./(R0 +R);
I = (I(1:end-1) + I(2:end))/2;
rp = 2*(R.^3 -  R0.^3)/3./(R.^2 - R0.^2);
rpm = 2*pi*(R - R0).*rp;
rpm = (rpm(1:end-1) + rpm(2:end))/2;
%rpr = ((rp./R0).^gamma - (rp./R).^gamma)/gamma*2*pi;
rpr = (R - R0)./R;
rpr = (rpr(1:end-1) + rpr(2:end))/2;
for i = 1:length(rpr)
    if rpr(i) == 1
        rpr(i) = inf;
    else
        rpr(i) = rpr(i)*2*pi/(1-gamma^2);
    end
end
end