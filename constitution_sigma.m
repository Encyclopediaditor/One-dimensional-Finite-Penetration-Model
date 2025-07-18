function [epsilon_turning, epsilon_turning2, delta_sigma, delta_epsilon_p] = constitution_sigma(epsilon_turning, epsilon_turning2, epsilon, delta_epsilon, sigma, Y, E, D, consti)
% constitution_sigma   from strain change to stress change
% Invoking             constitution_turning
% Invoked              Newmark_beta2; Newmark_beta3
% INPUT
%   epsilon_turning    scalar, tensile maximun elastic strain  
%   epsilon_turning2   scalar, compressive maximun elastic strain
%   epsilon            scalar, strain of last step
%   delta_epsilon      scalar, strain increment of the step
%   sigma              scalar, stress of last step
%   Y                  scalar, yield strength
%   E                  scalar, Young's Modulus
%   D                  scalar, tangent Modulus
%   consti             scalar, Bauschinger' effect indicator: 1:kinematic, 2:independent, 3:isotropic
% OUTPUT
%   delta_sigma        scalar, stress increment of the step    
%   delta_epsilon_p    scalar, plastic strain increment of the step 
if  epsilon < epsilon_turning2
    %% reverse plasticity
    if delta_epsilon <= 0
        % remain reverse plasticity
        delta_epsilon_p = delta_epsilon;
        delta_sigma =  D*delta_epsilon_p;      
    else
        [epsilon_turning, epsilon_turning2] = constitution_turning(epsilon_turning, epsilon_turning2, epsilon, sigma, Y, E, D, consti, 'reverse');
        
        if delta_epsilon + epsilon > epsilon_turning
            % from reverse plasticity to plasticity
            delta_epsilon_p = delta_epsilon + epsilon - epsilon_turning;
            delta_sigma = (E*(epsilon_turning - epsilon_turning2) + D*delta_epsilon_p);
        else
            % from reverse plasticity to elasticity
            delta_epsilon_p = 0;
            delta_sigma = E*delta_epsilon;
        end
    end
elseif epsilon <= epsilon_turning
    %% elasticity
    if delta_epsilon + epsilon < epsilon_turning2
        % from elasticity to reverse plasticity
        delta_epsilon_p = delta_epsilon + epsilon - epsilon_turning2;
        delta_sigma = (E*(epsilon_turning2 - epsilon) + D*delta_epsilon_p);
    elseif delta_epsilon + epsilon <= epsilon_turning
        % remain elasticity
        delta_epsilon_p = 0;
        delta_sigma = E*delta_epsilon;
    else
        % from elasticity to plasticity
        delta_epsilon_p = delta_epsilon + epsilon - epsilon_turning;
        delta_sigma = (E*(epsilon_turning - epsilon) + D*delta_epsilon_p);
    end
else
    %% plasticity
    if delta_epsilon < 0
        [epsilon_turning, epsilon_turning2] = constitution_turning(epsilon_turning, epsilon_turning2, epsilon, sigma, Y, E, D, consti, 'normal');
        
        if delta_epsilon + epsilon < epsilon_turning2
            % from plasticity to reverse plasticity
            delta_epsilon_p = delta_epsilon + epsilon - epsilon_turning2;
            delta_sigma = (E*(epsilon_turning2 - epsilon_turning) + D*delta_epsilon_p);
        else
            % from plasticity to elasticity
            delta_epsilon_p = 0;
            delta_sigma = E*delta_epsilon;
        end
    else
        % remain plasticity
        delta_epsilon_p = delta_epsilon;
        delta_sigma =  D*delta_epsilon_p;
    end
end
end