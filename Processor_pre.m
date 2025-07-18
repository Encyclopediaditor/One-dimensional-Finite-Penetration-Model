function result = Processor_pre(info, result)
% Preprocess  before penetration simulation
% Invoking    turtle; Config_generator; Config_parameter_seeker; Shell_parameter_seeker
% Invoked     main; main_preparation2; main_execution
% INPUT
%   info      struct, representing single calculation request
%   result    struct, recording single calculation result   
%%
pre = struct();
p = info.config.projectile;
tip_fix = info.plot.vibration.tip_fix;
bottom_fix = info.plot.vibration.buttom_fix;

Coord = zeros(p.num_mesh+1,2);
Coord_all = zeros(p.num_mesh+1,2,size(p.config,1));
mL_all = zeros(p.num_mesh,size(p.config,1));
rpr_all = mL_all;
rpm_all = mL_all;
A_all_all = mL_all;
I_all_all = mL_all;
A_all_all2 = mL_all; % Beam, original
I_all_all2 = mL_all; % Beam, with bottom fixed
I_all_all3 = mL_all; % Shell
lc_all = zeros(1,size(p.config,1));
I0_all = lc_all;
EA_all = zeros(p.num_mesh,1);
GA_all = EA_all;
EI_all = EA_all; % Beam
EI_all2 = EA_all; % Shell
rhoI_all = EA_all;
GI_all = EA_all;

if bottom_fix
    loc = [];
    for i = 1:size(p.config,1)
        if p.config(i,end-4) < 0
            loc = i;
            break;
        end
    end
else
    loc = nan;
end

for i = 1:size(p.config,1)
    if i == 1
        Coord = p.beta*turtle(p.config(i,:), p.num_mesh);
        Coord_all(:,:,i) = Coord;
        [mL_all(:,i), A_all_all(:,i), I_all_all(:,i), lc_all(i), I0_all(i)] = Config_generator(Coord, p.rho(i), tip_fix);
        A_all_all2(:,i) =  A_all_all(:,i);
        I_all_all2(:,i) = I_all_all(:,i);
    else
        Coord_all(:,:,i) = p.beta*turtle(p.config(i,:), p.num_mesh);
        [mL_all(:,i), A_all_all(:,i), I_all_all(:,i), lc_all(i), I0_all(i)] = Config_generator(Coord_all(:,:,i), p.rho(i) - p.rho(i-1), tip_fix);
        A_all_all2(:,i) =  A_all_all(:,i);
        I_all_all2(:,i) = I_all_all(:,i);
        if  bottom_fix && ~isempty(loc)
            if i == loc
                temp = p.config(i,1:end-6);
                temp(end-2) = temp(end-2) + p.config(i,end-2);
                Coord_temp = p.beta*turtle(temp, p.num_mesh);
                [~, A_all_all2(:,i), I_all_all2(:,i), ~, ~] = Config_generator(Coord_temp, p.rho(i) - p.rho(i-1), tip_fix);
            end
        end
    end
end

l = max(Coord(:,1));
d = max(Coord(:,2))*2;
if isfield(p,'lc2l')
    lc = l*p.lc2l;
else
    lc = dot(sum(mL_all,1),lc_all)/(sum(sum(mL_all,1)));
end

Coord(:,1) = Coord(:,1) - lc;
Coord_all(:,1,:) = Coord_all(:,1,:) - lc;
mL = sum(mL_all,2);
mL(end) = mL(end-1);
if isfield(p, 'm0')
    mL = mL*p.m0/sum(mL);
end
if isfield(p,'I0')
    I0 = p.I0;
else
    I0 = sum(I0_all) - sum(mL)*lc^2;
end
I_all = sum(I_all_all,2);

if size(A_all_all,2) > 1
    for j = 1:size(A_all_all,2)-1
        if j+1 == loc
            A_all_all(:,j) = A_all_all2(:,j) - A_all_all2(:,j+1);
            I_all_all(:,j) = I_all_all2(:,j) - I_all_all2(:,j+1);
            [I_all_all3(:,j),rpr_all(:,j),rpm_all(:,j)] = ...
                Shell_parameter_seeker(Coord_all(:,2,j), Coord_temp(:,2), p.E(j)/2/p.G(j) - 1, tip_fix);
            
        else
            A_all_all(:,j) = A_all_all(:,j) - A_all_all(:,j+1);
            I_all_all(:,j) = I_all_all(:,j) - I_all_all(:,j+1);
            [I_all_all3(:,j),rpr_all(:,j),rpm_all(:,j)] =...
                Shell_parameter_seeker(Coord_all(:,2,j), Coord_all(:,2,j+1), p.E(j)/2/p.G(j) - 1, tip_fix);
        end
    end
end

for i = 1:size(p.config,1)
    EA_all = EA_all + p.E(i)*A_all_all(:,i);
    EI_all = EI_all + p.E(i)*I_all_all(:,i);
    GA_all = GA_all + p.G(i)*A_all_all(:,i);
    GI_all = GI_all + p.G(i)*I_all_all(:,i);
    rhoI_all = rhoI_all + p.rho(i)*I_all_all(:,i);
    EI_all2 = EI_all2 + p.E(i)*I_all_all3(:,i);
end

[lb, N1, N2, Ns] = Config_parameter_seeker(Coord, info.config.medium.mu);
gamma = EA_all./(2*GA_all) - 1;

pre.Coord = Coord;
pre.Coord_all = Coord_all;
pre.d = d;
pre.l = l;
pre.lc = lc;
pre.lh = l - lb;
pre.ls = p.beta*p.config(end,1);
pre.mL = mL;
pre.m0 = sum(mL);
pre.I0 = I0;
pre.I_all = I_all;
pre.EA_all = EA_all;
pre.EI_all = EI_all;
pre.EI_all2 = EI_all2;
pre.GA_all = GA_all;
pre.rhoI_all = rhoI_all;
pre.GI_all = GI_all;
pre.N = [N1 N2 Ns];
pre.A_all_all = A_all_all;
pre.I_all_all = I_all_all;
pre.gamma = gamma;
pre.k_all = rpr_all(:,1)*p.E(1);
pre.m_all = rpm_all(:,1)*p.rho(1);
result.pre = pre;
end