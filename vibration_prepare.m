function pre = vibration_prepare(config, pre)
% vibration_prepare  additional preprocess for coupling calculation of penetration simulation
% Invoking           vibration_bar_K; vibration_bar_M; vibration_frequency
% Invoked            Processor_now
% INPUT
%   config           struct, representing basic configuratuion options of single claculation
%   pre              struct, obtained result from pre-processing
%%
Coord = pre.Coord;
EA_all = pre.EA_all;
GA_all = pre.GA_all;
mL = pre.mL;
p = config.projectile;
xi = p.xi;
bar_option = p.bar;

K = vibration_bar_K(Coord, EA_all, GA_all, pre.GI_all, bar_option);
M = vibration_bar_M(Coord, mL, pre.rhoI_all, pre.gamma, bar_option);
[Frequency, Modal, a] = vibration_frequency(M, K, xi);

Mn = diag(Modal'*M*Modal);

pre.a = a;
pre.K = K;
pre.M = M;
pre.C = a(1)*M + a(2)*K;
pre.Mn = Mn;
pre.Frequency = Frequency;
pre.Modal = Modal;
end