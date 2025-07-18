function Index_new = Buckling_index_calc(Index)
% Buckling_index_calc  calculate buckling index
% Invoking             none
% Invoked              Buckling_test_load
% INPUT
%   Index              vector of nx1, the eigen-value of [K]\[M]
% OUTPUT
%   Index_new          vector of nx1, the real buckling index
%%
    Index_new = Index;
    for i = 1:length(Index)
        if abs(Index(i)) < 1
            Index_new(i) = nan;
        else
            if real(Index(i)) < 0
                Index_new(i) = -log(-real(Index(i)));
            else
                Index_new(i) = log(real(Index(i)));
            end
        end
    end
end