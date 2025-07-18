function [Tv, TUX, TGX, Frequency, Modal] = vibration_seeker(X, t, config, pre, plt)
% vibration_seeker  decoupled structural response calculation of projectile
% Invoking          drag_calculator_review2; vibration_balance; vibration_bar_K; 
%                   vibration_bar_M; vibration_frequency; vibration_bar; Newmark_beta; 
%                   Newmark_beta2; Newmark_beta3; vibration_bar_post; vibration_bar_TGX; 
%                   vibration_beam_KM; vibration_balance2; vibration_dX;
%                   vibration_output; info_analysis_progress
% Invoked           Processor_post
% INPUT
%   X               matrix of nx6, with each column [X Y VX VY Fai Omega]
%   t               vector of nx1, recorded sinmulation time   
%   config          struct, representing basic configuratuion options of single claculation
%   pre             struct, obtained result from pre-processing
%   plt             struct, representing basic configuratuion options of post-process
% OUTPUT
%   Tv              matrix of nxm, with n array of timestep and m column of elemental designated variable
%   TUX             matrix of nxm, with n array of timestep and m column of elemental axial displacement 
%   TGX             matrix of nxm, with n array of timestep and m column of elemental radial displacement
%   Frequency       vector of mx1
%   Modal           matrix of mxm   
%%
Coord = pre.Coord;
mL = pre.mL;
radial = plt.vibration.radial;
p = config.projectile;
xi = p.xi;
bar_option = p.bar;
beam_option = p.beam;

%% 1. Force analysis
[TFX, TFY, TM, TFr] = drag_calculator_review2(X, t, config, pre);

[TFX, TFY] = vibration_balance(TFX, TFY, TM, Coord, mL);

%% 2. Bar analysis
disp('Calculation of Axial Vibration Begins.')
K = vibration_bar_K(Coord, pre.EA_all, pre.GA_all, pre.GI_all, bar_option);
M = vibration_bar_M(Coord, mL, pre.rhoI_all, pre.gamma, bar_option);
[Frequency, Modal, a] = vibration_frequency(M, K, xi);
TFX = ([zeros(length(t),1) TFX] + [TFX zeros(length(t),1)])/2;

if strcmp(bar_option, 'MH')
    if radial
        TFr = (TFr(:,1:end-1) + TFr(:,2:end))/2;
        TFX = [TFX TFr];
    else
        TFX = [TFX zeros(size(TFX,1),size(TFX,2)-2)];
    end
end

if ~config.projectile.plastic    
    if plt.vibration.modal
        Mn = diag(Modal'*M*Modal);
        [TUX, TAX] = vibration_bar(Frequency, Modal, Mn, TFX, xi, t);
    else
        C = a(1)*M + a(2)*K;              
        U = zeros(size(K,1),length(t));
        dU = U;
        ddU = U;      
        [UXT, ~, AXT] = Newmark_beta(M, K, C, t, TFX', U, dU, ddU, 1/4);
        TUX = UXT';
        TAX = AXT';
    end
        
    [TUX, TAX, TN, EA_all_all, Ga_all_all, Epsilon, Sigma, TGX] = vibration_bar_post(TUX, TAX, TFX, t, p.E, pre, bar_option);
    Epsilon_p = zeros(size(Sigma));
else   
    if strcmp(config.projectile.bar,'MH')
        [TUX, TAX, Epsilon, Epsilon_p, TN, Sigma, EA_all_all, Ga_all_all, ~, ~] = Newmark_beta3(config, pre, radial, false, M, a, t, TFX');
    else
        [TUX, TAX, Epsilon, Epsilon_p, TN, Sigma, EA_all_all, Ga_all_all, ~, ~] = Newmark_beta2(config, pre, false, M, a, t, TFX');
    end
    [TGX, TUX] = vibration_bar_TGX(TUX, Ga_all_all, Epsilon, Coord, p.bar);
end

%% 3. Beam analysis
if contains(plt.vibration.option,'Y') || contains(plt.vibration.option,'M')
    disp('Calculation of Lateral Vibration Begins.')
    EI_all = pre.EI_all;
    GA_all = pre.GA_all;
    rhoI_all = pre.rhoI_all;
    UT = zeros(2*length(Coord),length(t));
    dUT = UT;
    len_t = length(t)-1;
    
    for i = 1:len_t
        N = (TN(i,:))';
        pL = (TFY(i,:))';
        if strcmp(beam_option, 'Euler')
            K = vibration_beam_K(Coord, EI_all, N, false, false);
            M = vibration_beam_M(Coord, mL, false, false);            
        else
            K = vibration_beam_K_Timo(Coord, GA_all, EI_all, N, false, false);
            M = vibration_beam_M_Timo(Coord, mL, GA_all, EI_all, rhoI_all, false, false);
        end

        P = vibration_beam_P(Coord, pL, false);
        
        if i == 1
            [~, ~, a] = vibration_frequency(M, K, xi);
            P_old = zeros(2*length(Coord),1);
            U = zeros(2*length(Coord),2);
            dU = U;
            ddU = U;
        end
        C = a(1)*M + a(2)*K;
        [U, dU, ddU] = Newmark_beta(M, K, C, t(i:i+1), [P_old P], U, dU, ddU, 1/4);
        U = vibration_balance2(U, Coord, mL);
        dU = vibration_balance2(dU, Coord, mL);
        
        UT(:,i+1) = U(:,2);
        dUT(:,i+1) = dU(:,2);
        P_old = P;
        
        info_analysis_progress(len_t, i, 'Lateral Vibration: ')
    end
    
    TUY = UT(1:length(Coord),:)';
    MT = -EI_all.*(vibration_dX(Coord, UT(length(Coord)+1:end,:)));
    TM = MT';
else
    TUY = [];
    TM = [];
end

%% 4. Output
Tv = vibration_output(TUX, TUY, TAX, TN, TM, EA_all_all, Ga_all_all, Epsilon, Epsilon_p, Sigma, TGX, p, plt.vibration.option);

end