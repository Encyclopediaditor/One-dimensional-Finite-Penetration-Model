function [mL, A_all, I_all, lc, I0] = Config_generator(Coord, rho, tip_fix)
% Config_generator   generate basic geometry properties of projectile
% Invoking           none
% Invoked            Processor_pre
% INPUT
%   Coord            matrix of nx2, proectile's outline [X Y]
%   rho              scalar, density of the material
%   tip_fix          logical, whether to enlarge the stiffness of projectile's 10% part to avoid sigularity  
% OUTPUT
%   mL               vector of nx1, mass distribution of every element
%   A_all            vector of nx1, area distribution of every element
%   I_all            vector of nx1, axial moment of inertia distribution of every element
%   lc               scalar, distance between centroid and projectile's bottom
%   I0               scalar, total moment of inertia for deflection
%%
    mL = zeros(length(Coord)-1,1);
    A_all = mL;
    I_all = mL; 
    lc = 0;
    I0 = 0;
    num_mesh = length(Coord)-1;
    
    for i = 1:num_mesh
        L = Coord(i+1,1) - Coord(i,1);
        r = sqrt(((Coord(i+1,2))^2 + (Coord(i,2))^2 + Coord(i+1,2)*Coord(i,2))/3);
        V = pi*r^2*L;
        
        mL(i) = V*rho;
        lc = lc + mL(i)*(Coord(i+1,1) + Coord(i,1))/2;
        A_all(i) = pi*r^2;
        I_all(i) = pi*r^4/2; % Note that it's wrong in moment-beam calculation
        I0 = I0 + mL(i)*(r^2/2 + ((Coord(i+1,1) + Coord(i,1))/2)^2);
    end
    lc = lc/sum(mL);

    if tip_fix
        A_all(ceil(0.9*num_mesh):end) = A_all(floor(0.9*num_mesh));
        I_all(ceil(0.9*num_mesh):end) = I_all(floor(0.9*num_mesh));
    end
end