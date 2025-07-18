function M_all = vibration_beam_M_Timo(Coord, mL, GA_all, EI_all, rhoI_all, cut_edge, tip_fix, varargin)
% vibration_beam_M_Timo  generate M matrix for beam models, Timoshenko type
% Invoking               vibration_beam_node, vibration_beam_Key_Timo
% Invoked                vibration_seeker; Buckling_test_load; Buckling_test_modal
% INPUT
%   Coord                matrix of nx2, proectile's outline [X Y]
%   mL,rhoI_all          vector of nx1, mass distribution
%   EI_all,GA_all        vector of nx1, stiffness distribution
%   cut_edge             logical, whether to restrain projectile's head
%   tip_fix              logical, whether to restrain tip's displacement
%   varargin             cell with scalar element, projectile's centroid in inertia frame
% OUTPUT
%   M_all                matrix of 2nx2n, stiffness matrix 
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
   Phi = 12*EI_all(i)/(0.9*GA_all(i)*L^2);
   m = vibration_beam_Key_Timo(Phi, L, 'm');
   
   M = mL(i)/((1+Phi)^2)*[m(1) m(2) m(3) m(4);
                          m(2) m(5) -m(4) m(6);
                          m(3) -m(4) m(1) -m(2);
                          m(4) m(6) -m(2) m(5)];
   M = M + rhoI_all(i)/L/((1+Phi)^2)*[m(7) m(8) -m(7) m(8);
                                       m(8) m(9) -m(8) m(10);
                                       -m(7) -m(8) m(7) -m(8);
                                       m(8) m(10) -m(8) m(9)];
  M_all(node_element(i,:),node_element(i,:))=M_all(node_element(i,:),node_element(i,:))+ M;
end

if tip_fix
    M_all(node_all(num_element+1),:) = [];
    M_all(:,node_all(num_element+1)) = [];
end
end