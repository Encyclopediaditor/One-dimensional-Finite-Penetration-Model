function [T,X_all] = Runge_kutta(config, pre, t_max, X0, dt_default, vmin)
% Runge_kutta   engine of rigid body dynamics and kinematics
% Invoking      tmax_estimator; dt_estimator; rigid
% Invoked       Processor_now
% INPUT
%   config      struct, representing basic configuratuion options of single claculation
%   pre         struct, obtained result from pre-processing 
%   t_max       scalar, maximun sinmulation time
%   X0          vector of 1x6, with initial [x y vx vy fai omega]
%   dt_default  scalar, default timestep
%   vmin        scalar, min velocity to continue simulation
% OUTPUT
%   T           vector of nx1, recorded sinmulation time
%   X_all       matrix of nx6, with each column [X Y VX VY Fai Omega]    
%%
t_max = tmax_estimator(config, pre, t_max);
X_all = zeros(length(X0), ceil(t_max/dt_default));
X_all(:,1) = X0;
T = zeros(ceil(t_max/dt_default),1);

for i = 1:length(T)
    t = T(i);
    X = X_all(:,i);
    v = sqrt(X(3)^2+X(4)^2);
    if rem(v,20)<=1
        v
    end
    
    if X(3) <=0 || (v-vmin)<= 0 || (pi/2-X(5))<= 0 || (X(5)+pi/2)<= 0
        break;
    end
    
    dX1 = rigid(X, config, pre);
    dt = dt_estimator(dt_default, dX1);
    T(i+1) = t + dt;
    dX2 = rigid(X + dt*dX1/2, config, pre);
    dX3 = rigid(X + dt*dX2/2, config, pre);
    dX4 = rigid(X + dt*dX3, config, pre);
    X_all(:,i+1) = X + dt*(dX1 + 2*dX2 + 2*dX3 + dX4)/6;
end

T = T(1:i);
X_all = (X_all(:,1:i))';
end