function judge = is_in_bullet(Coord, loc, mesh_size)
% is_in_bullet  determine if a point is in the projectile
% Invoking      none
% Invoked       Medium_arranger
% INPUT
%   Coord       matrix of nx2, proectile's outline [X Y]
%   loc         vector of 2x1, [loc-x; loc-y]
%   mesh_size   vector of 2x1, [mesh_size-x; mesh_size-y]
% OUTPUT
%   judge       scalar, result indicator: 0: out; 1: semi-in; 2: in
%%
if loc(1) <= min(Coord(:,1)) -  mesh_size(1)/2 || loc(1) >= max(Coord(:,1)) + mesh_size(1)/2
    judge = 0;
elseif loc(1) <= min(Coord(:,1))  || loc(1) >= max(Coord(:,1)) 
    y = interp1(Coord(:,1), Coord(:,2), loc(1));
    if abs(loc(2)) <= y + mesh_size(2)
        judge = 1;
    else
        judge = 0;
    end
else
    y = interp1(Coord(:,1), Coord(:,2), loc(1));
    if abs(loc(2)) <= y 
        judge = 2;
    elseif abs(loc(2)) <= y + mesh_size(2)
        judge = 1;
    else
        judge = 0;
    end
end
end