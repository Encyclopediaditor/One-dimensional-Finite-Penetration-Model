function [node_all, node_element] = vibration_beam_node(num_element)
% vibration_beam_node  arrange node order for beam & shell FEM
% Invoking             none
% Invoked              vibration_beam_K; vibration_beam_M; vibration_beam_M_Timo; vibration_beam_P; vibration_shell_K; vibration_shell_M
% INPUT
%   num_element        scalar, number of element        
% OUTPUT
%   node_all           vector of 2n+2, order of node
%   node_element       matrix of nx4, function of node-element
%%
node_all = linspace(1,2*num_element+2,2*num_element+2);
node_element = [node_all(1:num_element)'  node_all(num_element+2:end-1)' ...
        node_all(2:num_element+1)' node_all(num_element+3:end)']; 
end