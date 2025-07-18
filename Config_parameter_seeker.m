function [lb, N1, N2, Ns] = Config_parameter_seeker(Coord, mu)
% Config_parameter_seeker   calculate rigid penetration parameter
% Invoking                  none
% Invoked                   Processor_pre
% INPUT
%   Coord                   matrix of nx2, proectile's outline [X Y]
%   mu                      scalar, friction coefficient
% OUTPUT
%   lb                      scalar, length of projectle's body
%   N1, N2, Ns              scalar, Chen's dimensionless numbers
%%
num_all = length(Coord);
r = Coord(1,2);
xe = Coord(1,1);

for i = num_all:-1:2
    if abs(Coord(i,2) - Coord(i-1,2)) < eps
        break; 
    end
end

xo = Coord(i,1);
lb = xo - xe;

theta = zeros(num_all,1);
for j = i:num_all
    theta(j) = -atan((Coord(j-1,2) - Coord(j,2))/(Coord(j-1,1) - Coord(j,1)));
end

x = Coord(i:num_all,1);
y = Coord(i:num_all,2);
sintheta = sin(theta(i:num_all));
tantheta = tan(theta(i:num_all));

N1 = 1 + 2*mu/r^2*trapz(x, y);
Ns = 2/r^2*trapz(x, y.*sintheta.*sintheta.*tantheta);
N2 = Ns + 2*mu/r^2*trapz(x, y.*sintheta.*sintheta);
