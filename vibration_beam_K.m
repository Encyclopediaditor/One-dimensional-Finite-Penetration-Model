function K_all = vibration_beam_K(Coord, EI_all, N, cut_edge, tip_fix, varargin)
% vibration_beam_K  generate K matrix for beam models, Euler type
% Invoking          vibration_beam_node
% Invoked           vibration_seeker; Buckling_test_load; Buckling_test_modal
% INPUT
%   Coord           matrix of nx2, proectile's outline [X Y]
%   EI_all          vector of nx1, stiffness distribution
%   N               vector of nx1, axial force distribution
%   cut_edge        logical, whether to restrain projectile's head
%   tip_fix         logical, whether to restrain tip's displacement
%   varargin        cell with scalar element, projectile's centroid in inertia frame
% OUTPUT
%   K_all           matrix of 2nx2n, stiffness matrix  
%%
if cut_edge
    xc = varargin{1};
    num_element = max(find(Coord(:,1) + xc >= 0, 1, 'first')-1, floor(length(Coord)*2/3) - 1);
else
    num_element = length(Coord) - 1;
end

[node_all, node_element] = vibration_beam_node(num_element);
K_all = zeros(2*num_element+2);

for i = 1 : num_element
   L = Coord(i+1,1) - Coord(i,1);
   K =  2*EI_all(i)/L^3*[6,   3*L,   -6,   3*L;
                   3*L, 2*L^2, -3*L,   L^2;
                   -6,  -3*L,    6,  -3*L;
                   3*L,   L^2, -3*L, 2*L^2]...
       + N(i)/(30*L)*[36,   3*L,  -36,   3*L;
                   3*L, 4*L^2, -3*L,  -L^2;
                   -36,  -3*L,   36,  -3*L;
                   3*L,  -L^2, -3*L, 4*L^2];

  K_all(node_element(i,:),node_element(i,:))=K_all(node_element(i,:),node_element(i,:))+ K;
end

if tip_fix
    K_all(node_all(num_element+1),:) = [];
    K_all(:,node_all(num_element+1)) = [];
end
end