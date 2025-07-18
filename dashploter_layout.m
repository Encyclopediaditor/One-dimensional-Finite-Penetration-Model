function [coo, AXIS] = dashploter_layout(Coord, X)
% dashploter_layout   determine which frame to be presented in animation
% Invoking            none
% Invoked             Config_generator_demo; dashploter
% INPUT
%   Coord             matrix of nx2, proectile's outline [X Y]   
%   X                 matrix of nx6, with each column [X Y VX VY Fai Omega]
% OUTPUT
%   coo               matrix of 2xm, proectile's symmetric outline for plot
%   AXIS              vector of 1x4, [xmin xmax ymin ymax]
%%
    Coord_inter = [0,0; Coord(end,1),Coord(end,2)];
    Coord_lower = [flip(Coord(:,1)) flip(-Coord(:,2))];
    Coord_all = [Coord; Coord_inter; Coord_lower; Coord(1,:)];
    coo = Coord_all';
    k=1.1;
    ymax=max(X(:,2))*k+0.1;
    ymin=min(X(:,2))*k-0.1;
    xmax=max(X(:,1))*k+0.1;
    xmin=min(X(:,1))*k-0.05;
    AXIS = [xmin,xmax,ymin,ymax];

end