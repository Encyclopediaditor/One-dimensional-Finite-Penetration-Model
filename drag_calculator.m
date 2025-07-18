function [Fn, M, Fr] = drag_calculator(Vn, omega, fai, Xi, Coord, config, pre, is_combining, is_coupling)
% drag_calculator   obtain force and moment summarization
% Invoking          alpha_seeker; fai0_judger; drag_calculator_edge; 
%                   drag_calculator_edge2; interp_theta; drag_calculator_base
% Invoked           deformable; drag_calculator_review2; rigid
% INPUT
%   Vn              vector of 2x1, the penetration velocity vector in inertia frame
%   omega           scalar, angular velocity
%   fai             scalar, inclination angle
%   Xi              vector of nx1, wall locaion in body frame
%   Coord           matrix of nx2, proectile's outline [X Y]
%   config          struct, representing basic configuratuion options of single claculation
%   pre             struct, obtained result from pre-processing
%   is_combining    logical, whether to drive overall force and moment
%   is_coupling     logical, whether to couple rigid motion and vibration
% OUTPUT
%   Fn              matrix of mx2, force distribution of each element in
%                   inertia frame; or vector of 1x2, total force in inertia frame
%   M               vector of mx1, moment distribution of each element; or
%                   scalar, total moment
%   Fr              vector of mx1, radial force distribution of each element
%%
A = config.medium.A;
B = config.medium.B;
mu = config.medium.mu;
psi = config.medium.psi;

is_free_edge = config.medium.free_edge;

BN=[cos(fai) sin(fai); 
    -sin(fai) cos(fai)];
Vb=-BN*Vn;

if is_coupling
    dVx = pre.dVx;
    dVy = pre.dVy;
else
    [v,alpha] = alpha_seeker(Vb);
end

Wall_num_all = ceil(length(Xi)/2);

Fb = zeros(2,length(Coord)-1);
M = zeros(1,length(Coord)-1);
Fr = M;

for Wall_num = 1:Wall_num_all
    if 2*Wall_num > length(Xi)
        xi = Xi(2*Wall_num - 1);
        if Coord(end,1) <= xi            
            continue;
        end
    else
        xi = [Xi(2*Wall_num - 1); Xi(2*Wall_num)];
        if Coord(end,1) <= xi(1) || Coord(1,1) >= xi(2)           
            continue;
        end
    end

    if is_free_edge
        kd = (pre.d*0.707 + pre.lh)*cos(fai);
        if xi(1) + kd > Coord(end,1)*cos(fai)
            is_cratered = false;
        else
            is_cratered = true;        
        end
    end

    for i = 1:length(Coord)-1
        c1 = Coord(i,:);
        c2 = Coord(i+1,:);
        len = norm(c1-c2);
        theta = abs(atan(-(c2(2)-c1(2))/(c2(1)-c1(1))));
                
        x =  (c1(1) + c2(1))/2;
        y =  (c1(2) + c2(2))/2;
        if is_coupling
            Vb_local = Vb;
            Vb_local(1) = Vb_local(1) - (dVx(i) + dVx(i+1))/2;
            [v,alpha] = alpha_seeker(Vb_local);
            vn = (dVy(i) + dVy(i+1))/2*cos(theta);
        else
            vn = 0;
        end
        
        [Fai0, Statuss] = fai0_judger(x, y, xi, fai, theta, alpha, vn/v);
        if is_free_edge 
            ratio = drag_calculator_edge(xi, x, y, fai, v, vn+v*sin(theta+alpha), config, pre, is_cratered);
            ratio = ratio*interp_theta(theta,alpha,psi);
        else
            ratio = interp_theta(theta,alpha,psi);
        end
        
        if isempty(Fai0) % Full set
            type = 3;
            FM = ratio*drag_calculator_base(A, B, mu, theta, alpha, omega, v, x, y, Fai0, vn, type);            
        elseif Statuss == 0 % Empty set           
            FM = [0;0;0;0];
        elseif length(Fai0) == 1 % Sigle confinement
            if Statuss == 1
                Fai0 = -Fai0;
                type = 2;
                FM = ratio*drag_calculator_base(A, B, mu, theta, alpha, omega, v, x, y, Fai0, vn, type);
            else
                type = 1;
                FM = ratio*drag_calculator_base(A, B, mu, theta, alpha, omega, v, x, y, Fai0, vn, type);
            end
        else % Double confinements
            type = 1;
            FMi = drag_calculator_base(A, B, mu, theta, alpha, omega, v, x, y, Fai0(1), vn, type);
            FMj = drag_calculator_base(A, B, mu, theta, alpha, omega, v, x, y, Fai0(2), vn, type);
            FM = ratio*(FMj - FMi);
        end
    
        FM = FM*len;
        Fb(:,i) = Fb(:,i) + FM(1:2);
        M(i) = M(i) + FM(3);
        Fr(i) = Fr(i) + FM(4);
    end
end

if is_combining
    Fb = sum(Fb,2);
    Fn = BN'*Fb;
    M = sum(M);
else
    Fn = Fb;
end