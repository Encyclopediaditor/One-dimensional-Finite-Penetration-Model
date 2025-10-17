function [T, X_all, TUX, TGX, Tv] = Coupled_elastic(config, pre, t_max, X0, dt_default, vmin, radial, option)
% Coupled_elastic   Relay calculation request under coupled elastic setting
% Invoking          tmax_estimator; deformable; Newmark_beta; vibration_bar_post; vibration_output
% Invoked           Processor_now
% INPUT
%   config          struct, representing basic configuratuion options of single claculation
%   pre             struct, obtained result from pre-processing
%   t_max           scalar, maximun sinmulation time
%   X0              vector of 6x1, with X0 = [R0n;V0n;fai0;omega0]
%   dt_default      scalar, default timestep
%   vmin            scalar, min velocity to continue simulation
%   radial          logic, whether to consider radial forces
%   option          string, option of vibration output
% OUTPUT
%   T               vector of nx1, recorded sinmulation time
%   X_all           matrix of nx6, with each column [X Y VX VY Fai Omega]
%   TUX             matrix of nxm, with n array of timestep and m column of elemental axial displacement
%   TGX             matrix of nxm, with n array of timestep and m column of elemental radial stain
%   Tv              matrix of nxm, with n array of timestep and m column of elemental designated variable
%%
    p = config.projectile;
    bar = p.bar;
    num_mesh = length(pre.EA_all);
    t_max = tmax_estimator(config, pre, t_max);
    X_all = zeros(length(X0), ceil(t_max/dt_default));
    X_all(:,1) = X0;
    T = zeros(ceil(t_max/dt_default),1);
    if strcmp(bar, 'MH')
        UTX = zeros(2*num_mesh,length(T));
    else
        UTX = zeros(num_mesh+1,length(T));
    end
    VTX = UTX;
    ATX = UTX;
    FTX = UTX;
    M = pre.M;
    K = pre.K;
    C = pre.C;
    
for i = 1:length(T)-1
    t = T(i);
    X = X_all(:,i);
    v = sqrt(X(3)^2+X(4)^2);
    if rem(v,20)<=1
        v
    end
    
    if X(3) <=0 || (v-vmin)<= 0 || (pi/2-X(5))<= 0 || (X(5)+pi/2)<= 0
        break;
    end
    
    [dX1, P_now1, ~, Fr1] = deformable(X, UTX(:,i), VTX(:,i), config, pre);
    dt = dt_estimator(dt_default, dX1);
    T(i+1) = t + dt;
    [dX2, P_now2, ~, Fr2] = deformable(X + dt*dX1/2, UTX(:,i), VTX(:,i), config, pre);
    [dX3, P_now3, ~, Fr3] = deformable(X + dt*dX2/2, UTX(:,i), VTX(:,i), config, pre);
    [dX4, P_now4, ~, Fr4] = deformable(X + dt*dX3, UTX(:,i), VTX(:,i), config, pre);
    X_all(:,i+1) = X + dt*(dX1 + 2*dX2 + 2*dX3 + dX4)/6;
    P_now = (P_now1 + 2*P_now2 + 2*P_now3 + P_now4)/6;
    
    if strcmp(bar, 'MH')
        if radial
            Fr = (Fr1 + 2*Fr2 + 2*Fr3 + Fr4)/6;
%             plot(Fr)
            Fr = (Fr(1:end-1) + Fr(2:end))/2;
            Fbx_all = [P_now; Fr'];
        else
            Fbx_all = [P_now; zeros(num_mesh-1,1)];
        end
    else
        Fbx_all = P_now;
    end
    FTX(:,i+1) = Fbx_all;
    [UTX(:,i:i+1), VTX(:,i:i+1), ATX(:,i:i+1)] = Newmark_beta(M, K, C, T(i:i+1), FTX(:,i:i+1), UTX(:,i), VTX(:,i), ATX(:,i), 1/4); 
end

Tv_all = struct();
T = T(1:i);
X_all = (X_all(:,1:i))';
Tv_all.TUX = (UTX(:,1:i))';
Tv_all.TVX = (VTX(:,1:i))';
Tv_all.TAX = (ATX(:,1:i))';
TFX = (FTX(:,1:i))';

Tv_all = vibration_bar_post(Tv_all, TFX, T, p.E, p.G, pre, bar);
Tv_all.Epsilon_p = zeros(size(Tv_all.Sigma));
TUX = Tv_all.TUX;
TGX = Tv_all.TGX;
Tv = vibration_output(Tv_all, p, option);

end