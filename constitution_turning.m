function [ept, ept2] = constitution_turning(ept, ept2, ep, sigma, Y, E, D, consti, type)
% constitution_turning   determine new boundaries of elasticity
%                        Invoking none
%                        Invoked constitution_sigma
% INPUT
%   ept                  scalar, tensile maximun elastic strain  
%   ept2                 scalar, compressive maximun elastic strain
%   ep                   scalar, strain of last step
%   sigma                scalar, stress of last step
%   Y                    scalar, yield strength
%   E                    scalar, Young's Modulus
%   D                    scalar, tangent Modulus
%   consti               scalar, Bauschinger' effect indicator: 1:kinematic, 2:independent, 3:isotropic
%   type                 string, 'normal': tensile plasticity, 'reverse': compressive plasticity
%%
if strcmp(type, 'normal')
    switch consti
        case 1
            ept = ep;
            ept2 = ept - 2*Y/E;
        case 2
            ept2 = ept2 + (ep - ept)*(1 - D/E);
            ept = ep;
        case 3
            ept = ep;
            ept2 = ept - 2*sigma/E;
    end
elseif strcmp(type, 'reverse')
    switch consti
        case 1
            ept2 = ep;
            ept = ept2 + 2*Y/E;
        case 2
            ept = ept + (ep - ept2)*(1 - D/E);
            ept2 = ep;
        case 3
            ept2 = ep;
            ept = ept2 - 2*sigma/E;
    end
else
    ept = [];
    ept2 = [];
end

end