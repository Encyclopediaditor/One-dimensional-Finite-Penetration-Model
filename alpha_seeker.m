function [v,alpha] = alpha_seeker(Vb)
% alpha_seeker   find the angle of attack in local coordinates
% Invoking       none
% Invoked        drag_calculator
% INPUT
%   Vb           vector of 2x1, the penetration velocity vector in body frame
% OUTPUT
%   v            scalar, the absolute peneration velocity
%   alpha        scalar, the angle of attack
%%
    v=norm(Vb);
    if Vb(1)<=0 && Vb(2)<=0
       alpha=acos(-Vb(1)/v);
    elseif Vb(1)<=0 && Vb(2)>0
       alpha=-acos(-Vb(1)/v);
    elseif Vb(1)>0 && Vb(2)<=0
       alpha=acos(Vb(1)/v);
    else
       alpha=-acos(Vb(1)/v);
    end
end