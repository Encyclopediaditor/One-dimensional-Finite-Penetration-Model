function [Fai, Statuss] = fai0_judger(x, y, xi, fai, theta, alpha, dv)
% fai0_judger   determine the boundary of localized force and moment integration
% Invoking      sum_set
% Invoked       drag_calculator
% INPUT
%   x           scalar, element's axial location
%   y           scalar, element's radius     
%   xi          scalar, wall locaion in body frame
%   fai         scalar, inclination angle
%   theta       scalar, the angle between surface's tangential direction and rotational axis
%   alpha       scalar, the angle of attack
%   dv          scalar, vn/v
% OUTPUT
%   Fai         scalar or vector of 2x1, element's radial limit contact angle
%   Statuss     scalar, 1: forward; -1: backward; 0: empty set; []: full set  
%%
Fai_all = [];
Statuss_all = [];

xi1 = xi(1);
if x <= xi1 - abs(y*tan(fai))
    Fai = 0;
    Statuss = 0;
    return
elseif x <= xi1 + abs(y*tan(fai))
    fai1 = asin((x-xi1)/(y*abs(tan(fai))));
    if fai > 0
        Fai_all = [Fai_all; fai1];
        Statuss_all = [Statuss_all; -1];
    else
        Fai_all = [Fai_all; -fai1];
        Statuss_all = [Statuss_all; 1];
    end
end

sinfai0 = tan(theta)/tan(alpha) + dv/(sin(alpha)*cos(theta));
if alpha == 0 && theta <= 0 %&& dv <= 0
    Fai = 0;
    Statuss = 0;
    return
elseif alpha > 0 && sinfai0 < 1 && sinfai0 > -1
    Fai_all = [Fai_all; -asin(sinfai0)];
    Statuss_all = [Statuss_all; 1];
elseif alpha < 0 && sinfai0 < 1 && sinfai0 > -1
    Fai_all = [Fai_all; -asin(sinfai0)];
    Statuss_all = [Statuss_all; -1];
end

if length(xi) == 2
    xi2 = xi(2);
    if x >= xi2 + abs(y*tan(fai))
        Fai = 0;
        Statuss = 0;
        return
    elseif x >= xi2 - abs(y*tan(fai))
        fai1 = asin((x-xi2)/(y*abs(tan(fai))));
        if fai > 0
            Fai_all = [Fai_all; fai1];
            Statuss_all = [Statuss_all; 1];
        else
            Fai_all = [Fai_all; -fai1];
            Statuss_all = [Statuss_all; -1];
        end
    end
end 

[Fai, Statuss] = sum_set(Fai_all, Statuss_all);

end