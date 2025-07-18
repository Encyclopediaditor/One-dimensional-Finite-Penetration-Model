function E = Buckling_test_modal_plot(Coord, K, num_rank, num_fig, style, type)
% Buckling_test_modal_plot  plot buckling modal
% Invoking                  none
% Invoked                   Buckling_test_modal
% INPUT
%   Coord                   matrix of nx2, proectile's outline [X Y]
%   K                       matrix of nxn, stiffness matrix [K]
%   num_rank                scalar, the rank of plotted modal
%   num_fig                 scalar, the rank of figure
%   style                   string, line style
%   type                    string, line legend
% OUTPUT
%   E                       vector of nx1, the eigen-vector of [K]
%%
    [Modal, E] = eig(K);
    [E, rank] = sort(diag(E));
    figure(num_fig)
    if mod(length(Modal),2) == 1 % beam
        num_element = (length(Modal) + 1)/2;
        modal = [Modal(1:num_element-1,rank(num_rank)); 0];
        plot(Coord(1:num_element,1), modal/max(abs(modal)),style, 'linewidth', 1.5, 'displayname', type)
    else %shell
        num_element = length(Modal)/2 + 1;
        modal = [0; Modal(1:num_element-2,rank(num_rank)); 0];
        plot(Coord(1:num_element,1), modal/max(abs(modal)),style,'linewidth', 1.5, 'displayname', type)
    end
    hold on 
end