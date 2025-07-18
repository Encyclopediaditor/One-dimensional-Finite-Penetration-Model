function [type, S] = Medium_type_seeker(V_all, Epsilon, Beta, Beta1, V, r0, r, fai, Y, E, f, rho0)
% Medium_type_seeker determine the type of medium point
% Invoking           none
% Invoked            Medium_K_seeker; Medium_arranger
% INPUT
%   V_all             vector of 1xn, expansion velocity for trying
%   Epsilon           vector of 1xn, strain for trying
%   Beta1, Beta       vector of 1xn, dimensionless number for trying
%   V                 scalar, local expasion velocity for interpretion
%   r0                scalar, cavity's radius
%   r                 scalar, interpretion's radius
%   fai               scalar, Mohr-Coulomb's friction angle
%   Y                 scalar, Compression strength
%   E                 scalar, Young's modulus
%   f                 scalar, Tension strength
%   rho0              scalar, static density 
% OUTPUT
%   type              scalar, type indicator: 0: cavity; 1: plastic; 2: fracture; 3: elastic; 4: not relevant
%   S                 scalar, interpreted stress
%%
if r < r0
    type = 0;
    S = 0;    
else    
    lambda = tan(fai);
    tao = (3 - lambda)/3*Y;
    alpha = 6/(3 + 2*lambda);
    F = f/tao;
    
    epsilon = interp1(V_all, Epsilon, V);
    beta = interp1(V_all, Beta, V);
    beta1 = interp1(V_all, Beta1, V);
    dc2 = epsilon* sqrt(E/rho0)/ V;
    xi = epsilon* r / r0;
    dbeta = beta/beta1;
    c = V/epsilon;
    
    if xi < min(1, 1/dbeta)
        type = 1;
        S = (3 + 2*lambda)/lambda/(3 - lambda)*xi^(- alpha*lambda) - 1/lambda...
            - 2*rho0*c^2/tao*(epsilon^3/(alpha*lambda - 1)/xi - epsilon^6/(alpha*lambda - 4)/xi^4)...
            + 2*rho0*c^2/tao*(epsilon^3/(alpha*lambda - 1) - epsilon^6/(alpha*lambda - 4))*xi^(- alpha*lambda);
        S = S*tao;
    elseif xi < max(1, 1/dbeta)
        type = 2;
        S3 = 2*F*(2*E/(3*tao) + 3*beta1^2)/(2*E/(3*tao) - 6*beta1^2);
        S = (S3 - dbeta^2*Y/tao)/dbeta/(1 - dbeta)/ xi + (dbeta*Y/tao - S3)/dbeta/(1 - dbeta)/ xi^2;
        S = S*tao;
    elseif xi < dc2
        type = 3;
        D = F/dbeta/(2*E*dbeta^2/(3*tao) - 6*beta^2);
        S = 4*D*E/(3*tao*xi^3) + 6*D*beta^2/xi;
        S = S*tao;
    else
        type = 4;
        S = 0;
    end

end