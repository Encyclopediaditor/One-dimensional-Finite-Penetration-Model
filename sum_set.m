function [Fai, Statuss] = sum_set(Fai_all, Statuss_all)
% sum_set    determine total integration area during force calculation
% Invoking   none
% Invoked    fai0_judger
% INPUT
%   Fai         scalar or vector, element's radial limit contact angle of each set
%   Statuss     scalar or vector, indicator of each set       
% OUTPUT
%   Fai         scalar or vector of 2x1, element's radial limit contact angle
%   Statuss     scalar, 1: forward; -1: backward; 0: empty set; []: full set  
%%
len = length(Fai_all);
if len == 0 || len == 1
    Fai = Fai_all;
    Statuss = Statuss_all;
else
    [Fai_all, Inde] = sort(Fai_all);
    Statuss_all = Statuss_all(Inde);
    Fai_all = [-pi/2; Fai_all; pi/2];
    Statuss_all = [1; Statuss_all; -1];
    len = length(Fai_all);
    fai_min = nan;
    fai_max = nan;
    
    for i = 1:len-1
        fai_test = (Fai_all(i) + Fai_all(i+1))/2;
        
        is_broken = 0;
        for j = 1:len
            if Statuss_all(j) == 1
                if fai_test <= Fai_all(j)
                    is_broken = 1;
                    break;
                end
            else
                if fai_test >= Fai_all(j)
                    is_broken = 1;
                    break;
                end
            end
        end
        
        if is_broken == 0
            if isnan(fai_min)
                fai_min = Fai_all(i);
                fai_max = Fai_all(i+1);
            else
                fai_max = Fai_all(i+1);
            end
        end
    end
    
    if fai_min == -pi/2
        Fai = fai_max;
        Statuss = -1;
    elseif fai_max == pi/2
        Fai = fai_min;
        Statuss = 1;
    elseif isnan(fai_min)
        Fai = 0;
        Statuss = 0;
    else
        Fai = [fai_min; fai_max];
        Statuss = [];
    end
end
end