function M_all = vibration_shell_M(Coord, m_all, k_all)
% vibration_shell_M  generate M matrix for beam models, Euler type
% Invoking           vibration_beam_node
% Invoked            Buckling_test_load; Buckling_test_modal
% INPUT
%   Coord            matrix of nx2, proectile's outline [X Y]
%   m_all            vector of nx1, mass distribution (shell type) 
%   k_all            vector of nx1, stiffness distribution (shell type) 
% OUTPUT
%   M_all            matrix of 2nx2n, mass matrix
%%
num_element = find(k_all==inf, 1, 'first') - 1;
[node_all, node_element] = vibration_beam_node(num_element);
    
M_all = zeros(2*num_element+2);

for i = 1 : num_element
   L = Coord(i+1,1) - Coord(i,1);
   M = m_all(i)*L/420*[156,   22*L,    54,  -13*L;
                  22*L,  4*L^2,  13*L, -3*L^2;
                  54,   13*L,   156,  -22*L;
                  -13*L, -3*L^2, -22*L,  4*L^2];

  M_all(node_element(i,:),node_element(i,:)) = M_all(node_element(i,:),node_element(i,:))+ M;

end

M_all(node_all([1 num_element+1]),:) = [];
M_all(:,node_all([1 num_element+1])) = [];

end