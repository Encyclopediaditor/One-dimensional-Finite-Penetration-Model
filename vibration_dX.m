function dXT = vibration_dX(Coord, XT)
% vibration_dX  differentiate along the first axis of a matrix
% Invoking      none
% Invoked       Newmark_beta2; Newmark_beta3; vibration_seeker
% INPUT
%   Coord       matrix of nx2, proectile's outline [X Y]
%   XT          matrix of mxn, with m array of elemental designated variable and n column of timestep
% OUTPUT
%   dXT         matrix of mxn, with m array of differentiated elemental designated variable and n column of timestep
%%
dXT = zeros(size(XT,1)-1,size(XT,2));
X = Coord(:,1);
for i = 1:size(XT,1)-1
    dX = X(i+1) - X(i);
    dXT(i,:) = (XT(i+1,:) - XT(i,:))/dX;
end   
end