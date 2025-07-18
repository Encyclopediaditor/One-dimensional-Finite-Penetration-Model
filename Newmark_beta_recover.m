function [EA_all, Poisson] = Newmark_beta_recover(delta_Epsilon_p, A_all_all, E, D, G)
% Newmark_beta_recover  recover stiffness distribution after one step of iteration
% Invoking              none
% Invoked               Newmark_beta2, Newmark_beta3
% INPUT
%   delta_Epsilon_p     matrix of mxj, plastic strain's increment of every element, every material
%   A_all_all           matrix of mxj, area distribution of every element, every material  
%   E                   vector of jx1, Young's Modulus of every material 
%   D                   vector of jx1, Tangent Modulus of every material
%   G                   vector of jx1, Shear Modulus of every material 
% OUTPUT
%   EA_all              vector of mx1, stiffness distribution
%   Poisson             vector of mx1, Poisson's ratio distribution
%%
[num_mesh, num_mat] = size(delta_Epsilon_p);
EA_all = zeros(num_mesh, 1);        GA_all = EA_all;
for j = 1:num_mat
    for k = 1:num_mesh
        if delta_Epsilon_p(k,j) ~= 0
            EA_all(k) = EA_all(k) + A_all_all(k,j)*D(j);
            GA_all(k) = GA_all(k) + A_all_all(k,j)*D(j)/E(j)*G(j);
        else
            EA_all(k) = EA_all(k) + A_all_all(k,j)*E(j);
            GA_all(k) = GA_all(k) + A_all_all(k,j)*G(j);
        end
    end
end
Poisson = EA_all./GA_all/2 - 1;
end