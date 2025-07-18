function [V_all, Epsilon, Beta, Beta1] = Medium_mode_seeker(fai, Y, E, f, rho0) 
% Medium_mode_seeker  determine stress distribution of one stress source
% Invoking            none
% Invoked             Medium_K_seeker; Medium_arranger
% INPUT
%   fai               scalar, Mohr-Coulomb's friction angle
%   Y                 scalar, Compression strength
%   E                 scalar, Young's modulus
%   f                 scalar, Tension strength
%   rho0              scalar, static density 
% OUTPUT
%   Beta1, Beta       vector of 1xn, dimensionless number for trying
%   Epsilon           vector of 1xn, strain for trying
%   V_all             vector of 1xn, expansion velocity for trying
%%
lambda = tan(fai);
tao = (3 - lambda)/3*Y;
c = sqrt(tao/rho0);

num_beta = 1000;
scale = -10;

Beta1_origin = linspace(0,scale,num_beta);
Beta1 = (exp(Beta1_origin)-1)/(exp(scale)-1)*(0.9999*sqrt(E/9/tao) - 0.01) + 0.01;
F = f/tao;
Beta = Beta1.^3*(tao /Y).*sqrt(2*F.*Beta1.^(-4)*(Y/tao).*(E + 9*tao*Beta1.^2)./(E - 9*tao*Beta1.^2) + (9*F/2*tao./(E - 9*tao*Beta1.^2)).^2)...
       - 9*Beta1.^3/2*(tao /Y)*F*tao./(E - 9*tao*Beta1.^2);
S3 = 2*F*(2*E/(3*tao) + 3*Beta1.^2)./(2*E/(3*tao) - 6*Beta1.^2);
Epsilon = (((Beta./Beta1).^2*Y/tao - S3)./((Beta./Beta1).*(1 - (Beta./Beta1)))./(2*Beta.^2)).^(1/3);
V_all = Epsilon.*Beta*c;

end