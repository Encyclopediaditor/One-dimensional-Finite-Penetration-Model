function Kx = Medium_K_adjuster(Kx,i)
% Medium_K_adjuster  refine the stress source in stress plot of animation
% Invoking           none
% Invoked            Medium_K_seeker
% INPUT
%   Kx             matrix of jxk, source magnifier of X direction
%   i              scalar, rank of source near the sigularity
%%
    loc_mis = find(isinf(Kx(i,:)));
    loc_mis = [loc_mis find(isnan(Kx(i,:)))];
    if ~isempty(loc_mis)
        Kx(i,loc_mis) = Kx(i-1,loc_mis);
    end
end