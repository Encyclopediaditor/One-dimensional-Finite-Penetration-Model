function K_all = vibration_shell_K(Coord, EI_all2, N, k_all)
% vibration_shell_K  generate K matrix for shell models
% Invoking           vibration_beam_node
% Invoked            Buckling_test_load; Buckling_test_modal
% INPUT
%   Coord            matrix of nx2, proectile's outline [X Y]
%   m_all            vector of nx1, mass distribution (shell type) 
%   N                vector of nx1, axial force distribution
%   EI_all2, k_all   vector of nx1, stiffness distribution (shell type) 
% OUTPUT
%   K_all            matrix of 2nx2n, stiffness matrix
%%
num_element = find(k_all==inf, 1, 'first') - 1;
[node_all, node_element] = vibration_beam_node(num_element);
    
K_all = zeros(2*num_element+2);

for i = 1 : num_element
   L = Coord(i+1,1) - Coord(i,1);
   K =  2*EI_all2(i)/L^3*[6,   3*L,   -6,   3*L;
                   3*L, 2*L^2, -3*L,   L^2;
                   -6,  -3*L,    6,  -3*L;
                   3*L,   L^2, -3*L, 2*L^2]...
       + N(i)/(30*L)*[36,   3*L,  -36,   3*L;
                   3*L, 4*L^2, -3*L,  -L^2;
                   -36,  -3*L,   36,  -3*L;
                   3*L,  -L^2, -3*L, 4*L^2]...
       + k_all(i)*L/420*[156,   22*L,    54,  -13*L;
                  22*L,  4*L^2,  13*L, -3*L^2;
                  54,   13*L,   156,  -22*L;
                  -13*L, -3*L^2, -22*L,  4*L^2];

  K_all(node_element(i,:),node_element(i,:))=K_all(node_element(i,:),node_element(i,:))+ K;

end

K_all(node_all([1 num_element+1]),:) = [];
K_all(:,node_all([1 num_element+1])) = [];
end