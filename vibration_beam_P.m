function P_all = vibration_beam_P(Coord, pL, tip_fix)
% vibration_beam_P  generate P vector matrix for beam models
% Invoking          vibration_beam_node
% Invoked           vibration_seeker
% INPUT
%   Coord           matrix of nx2, proectile's outline [X Y]
%   pL              vector of nx1, loads distribution
%   tip_fix         logical, whether to restrain tip's displacement
% OUTPUT
%         
%%
num_element = length(Coord) - 1;
[node_all, node_element] = vibration_beam_node(num_element);
    
P_all = zeros(2*num_element+2,1);

for i = 1 : num_element
   L = Coord(i+1,1) - Coord(i,1);
   P = pL(i)/12*[6; L; 6; -L];
   P_all(node_element(i,:))=P_all(node_element(i,:)) + P; 
end

if tip_fix
    P_all(node_all(num_element+1)) = [];
end
end