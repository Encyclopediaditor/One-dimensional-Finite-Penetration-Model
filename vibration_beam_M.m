function M_all = vibration_beam_M(Coord, mL, cut_edge, tip_fix, varargin)
% vibration_beam_M  generate M matrix for beam models, Euler type
% Invoking          vibration_beam_node
% Invoked           vibration_seeker; Buckling_test_load; Buckling_test_modal
% INPUT
%   Coord           matrix of nx2, proectile's outline [X Y]
%   mL              vector of nx1, mass distribution
%   cut_edge        logical, whether to restrain projectile's head
%   tip_fix         logical, whether to restrain tip's displacement
%   varargin        cell with scalar element, projectile's centroid in inertia frame
% OUTPUT
%   M_all           matrix of 2nx2n, stiffness matrix
%%
if cut_edge
    xc = varargin{1};
    num_element = max(find(Coord(:,1) + xc >= 0, 1, 'first')-1, floor(length(Coord)*2/3) - 1);
else
    num_element = length(Coord) - 1;
end

[node_all, node_element] = vibration_beam_node(num_element);
M_all = zeros(2*num_element+2);

for i = 1 : num_element
   L = Coord(i+1,1) - Coord(i,1);
   M = mL(i)/420*[156,   22*L,    54,  -13*L;
                  22*L,  4*L^2,  13*L, -3*L^2;
                  54,   13*L,   156,  -22*L;
                  -13*L, -3*L^2, -22*L,  4*L^2];

  M_all(node_element(i,:),node_element(i,:))=M_all(node_element(i,:),node_element(i,:))+ M;
end

if tip_fix
    M_all(node_all(num_element+1),:) = [];
    M_all(:,node_all(num_element+1)) = [];
end
end