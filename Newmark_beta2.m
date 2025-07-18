function [TUX, TAX, Epsilon, Epsilon_p, TN, Sigma, EA_all_all, Ga_all_all, T, X_all] = Newmark_beta2(config, pre, coupled, varargin)
% Newmark_beta2  engine of plastic structural response for constant and Love bar
% Invoking       tmax_estimator; deformable; vibration_bar_K; vibration_dX; constitution_sigma;
%                Newmark_beta_iter; info_analysis_progress; Newmark_beta_recover
% Invoked        Coupled_plastic; vibration_seeker
% INPUT
%   config       struct, representing basic configuratuion options of single claculation
%   pre          struct, obtained result from pre-processing
%   coupled      logical, whether the vibration and rigid motion is coupled
%   varargin     cell with multi-type elements, additional info
% OUTPUT
%   TUX          matrix of nxm, with n array of timestep and m column of elemental axial displacement 
%   TAX          matrix of nxm, with n array of timestep and m column of elemental axial acceleration
%   Epsilon      matrix of (m-1)xn, with m-1 array of elemental strain and n column of timestep
%   Epsilon_p    matrix of (m-1)xn, with m-1 array of elemental plastic strain and n column of timestep
%   TN           matrix of nx(m-1), with n array of timestep and m-1 column of elemental axial force
%   Sigma        matrix of (m-1)xnxj, with m-1 array of elemental stress, n column of timestep, and j type of materials
%   EA_all_all   matrix of (m-1)xn, with m-1 array of elemental axial stiffness and n column of timestep
%   GA_all_all   matrix of (m-1)xn, with m-1 array of elemental shear stiffness and n column of timestep
%   T            vector of nx1, recorded sinmulation time
%   X_all        matrix of nx6, with each column [X Y VX VY Fai Omega]
%% Preparation
gamma = 1/2;
beta = 1/4;
Coord = pre.Coord;
EA_all = pre.EA_all;        GA_all = pre.GA_all;        GI_all = pre.GI_all;    mL = pre.mL;
A_all_all = pre.A_all_all;  I_all_all = pre.I_all_all;
p = config.projectile;
E = p.E;    G = p.G;    D = p.D;    Y = p.Y;    consti = p.consti;  bar = p.bar;
Poisson = E./(2*G) - 1;

if coupled
    t_max = varargin{1};    X0 = varargin{2};   dt_default = varargin{3};   vmin = varargin{4};
    M = pre.M;
    a = pre.a;
    t_max = tmax_estimator(config, pre, t_max);
    length_t = ceil(t_max/dt_default);
    X_all = zeros(length(X0), length_t);
    X_all(:,1) = X0;
    T = zeros(length_t,1);
    P = zeros(size(M,1),length_t);
else
    M = varargin{1};        a = varargin{2};    T = varargin{3};            P = varargin{4};
    length_t = length(T);   
end

num_mesh = length(EA_all);                  num_mat = length(E);
U = zeros(size(M,1),length_t);              dU = U;                     ddU = U;

EA_all_all = zeros(num_mesh, length_t);     Ga_all_all = EA_all_all;    Epsilon = EA_all_all;
N = zeros(num_mesh+1, length_t);
Sigma = zeros(num_mesh, length_t, num_mat); Epsilon_p = Sigma;
EA_all_all(:,1) = EA_all;
Ga_all_all(:,1) = pre.gamma;

Epsilon_turning = zeros(num_mesh, num_mat);
for j = 1:num_mat
    Epsilon_turning(:,j) = Y(j)/E(j);
end
Epsilon_turning2 = -Epsilon_turning;

%% Iteration
for i = 1:length_t-1 
    for k = 2:num_mesh+1
        N(k,i) = N(k-1,i) + mL(k-1)*(ddU(k-1,i) + ddU(k,i))/2 - (P(k-1,i) + P(k,i))/2;
    end
    if coupled
        t = T(i);
        X = X_all(:,i);
        v = sqrt(X(3)^2+X(4)^2);
        if rem(v,20)<=1
            v
        end
        if X(3) <=0 || (v-vmin)<= 0 || (pi/2-X(5))<= 0 || (X(5)+pi/2)<= 0
            break;
        end

        [dX1, P_now1, ~, ~] = deformable(X, U(:,i), dU(:,i), config, pre);
        dt = dt_estimator(dt_default, dX1);
        T(i+1) = t + dt;
        [dX2, P_now2, ~, ~] = deformable(X + dt*dX1/2, U(:,i), dU(:,i), config, pre);
        [dX3, P_now3, ~, ~] = deformable(X + dt*dX2/2, U(:,i), dU(:,i), config, pre);
        [dX4, P_now4, ~, ~] = deformable(X + dt*dX3, U(:,i), dU(:,i), config, pre);
        X_all(:,i+1) = X + dt*(dX1 + 2*dX2 + 2*dX3 + dX4)/6;
        P(:,i+1) = (P_now1 + 2*P_now2 + 2*P_now3 + P_now4)/6;
    else
        dt = T(i+1) - T(i);
    end
    
    delta_P_e_try = zeros(size(M,1),1);      delta_P_e_try_old = delta_P_e_try;     delta_U = delta_P_e_try;   
    delta_Sigma = zeros(num_mesh, num_mat);  delta_Epsilon_p = delta_Sigma;         delta_Sigma_try = delta_Sigma;  delta_Epsilon_p_try = delta_Sigma;
    Epsilon_try = Epsilon(:,i);
    tim = 1;
    
    while true
        if tim == 1
            K = vibration_bar_K(Coord, EA_all, GA_all, GI_all, bar);
            C = a(1)*M + a(2)*K;
            K_e = K + 1/(beta*dt^2)*M + gamma/(beta*dt)*C;
        end
        delta_P_e = P(:,i+1)-P(:,i) + M*(1/(beta*dt)*dU(:,i) + 1/(2*beta)*ddU(:,i))+...
            C*(gamma/beta*dU(:,i) + dt/2*(gamma/beta-2)*ddU(:,i));
        delta_U_try = K_e\(delta_P_e-delta_P_e_try);
        
        delta_Epsilon_try = vibration_dX(Coord, delta_U_try);
        EA_all_try = zeros(num_mesh,1);     GA_all_try = EA_all_try;    GI_all_try = EA_all_try;
        
        for k = 1:num_mesh
            if delta_Epsilon_try(k) == 0
                EA_all_try(k) = EA_all(k);
                GA_all_try(k) = GA_all(k);
                GI_all_try(k) = GI_all(k);                 
            else
                for j = 1:num_mat     
                    if A_all_all(k,j) == 0
                        delta_Sigma_try(k,j) = 0;
                        poisson = Poisson(j);
                    else
                        [Epsilon_turning(k,j), Epsilon_turning2(k,j), delta_Sigma_try(k,j), delta_Epsilon_p_try(k,j)] = constitution_sigma(...
                         Epsilon_turning(k,j), Epsilon_turning2(k,j), Epsilon_try(k), delta_Epsilon_try(k), Sigma(k,i,j), ...
                         Y(j), E(j), D(j), consti(j));
                     
                        poisson = (delta_Epsilon_p_try(k,j)*0.49 + (delta_Epsilon_try(k) - delta_Epsilon_p_try(k,j))*Poisson(j))/delta_Epsilon_try(k);
                    end
                    E_try = delta_Sigma_try(k,j)/delta_Epsilon_try(k);
                    EA_all_try(k) = EA_all_try(k) + E_try*A_all_all(k,j);
                    GA_all_try(k) = GA_all_try(k) + E_try*A_all_all(k,j)/2/(1+poisson);
                    GI_all_try(k) = GI_all_try(k) + E_try*I_all_all(k,j)/2/(1+poisson);
                end
            end
        end
        
        K = vibration_bar_K(Coord, EA_all_try, GA_all_try, GI_all_try, bar);
        C = a(1)*M + a(2)*K;
        K_e = K + 1/(beta*dt^2)*M + gamma/(beta*dt)*C;
        delta_P_e_try = K_e*delta_U_try + delta_P_e_try_old;
        Epsilon_try = Epsilon_try + delta_Epsilon_try; 
        delta_U = delta_U + delta_U_try;
        delta_Sigma = delta_Sigma + delta_Sigma_try;
        delta_Epsilon_p = delta_Epsilon_p + delta_Epsilon_p_try;
        
%         norm(delta_P_e_try - delta_P_e)/norm(delta_P_e)
        if norm(delta_P_e_try - delta_P_e)/norm(delta_P_e) < 1e-6 || norm(delta_P_e_try - delta_P_e) == 0
            break
        else
            delta_P_e_try_old = delta_P_e_try;
            tim = tim+1;
        end
    end
    
    Epsilon(:,i+1) = Epsilon_try;
    for j = 1:num_mat
        Sigma(:,i+1,j) = Sigma(:,i,j) + delta_Sigma(:,j);
        Epsilon_p(:,i+1,j) = Epsilon_p(:,i,j) + delta_Epsilon_p(:,j);  
    end
    [EA_all_all(:,i+1), Ga_all_all(:,i+1)] = Newmark_beta_recover(delta_Epsilon_p, A_all_all, E, D, G);
    EA_all = EA_all_try;
    GA_all = GA_all_try;
    GI_all = GI_all_try;
    
    [U(:,i+1), dU(:,i+1), ddU(:,i+1)] = Newmark_beta_iter(U(:,i), dU(:,i), ddU(:,i), delta_U, gamma, beta, dt);  
    
    if ~coupled 
        info_analysis_progress(length_t, i, 'Axial Vibration: ')
    end
end

if coupled
    T = T(1:i);                         X_all = (X_all(:,1:i))';
    TUX = (U(:,1:i))';                  TAX = (ddU(:,1:i))';
    Epsilon = Epsilon(:,1:i);           Epsilon_p = Epsilon_p(:,1:i, :);
    TN = (N(:,1:i))';                   Sigma = Sigma(:, 1:i, :);
    EA_all_all = EA_all_all(:,1:i);     Ga_all_all = Ga_all_all(:,1:i);
else
    X_all = [];
    TUX = U';
    TAX = ddU';
    TN = N';
end

end