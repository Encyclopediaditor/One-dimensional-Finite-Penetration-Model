clear;clc;
%% Buckling_test_modal
%    Function: determine the buckling modal of beam and shell at a certain time
%    Requirement: info.mat & result.mat, and 
%                 info.plot.vibration_analysis = true;
%                 info.plot.vibration.buttom_fix = true;
%                 info.plot.vibration.option = 'N,EA,GA,V';
%    t_now: refered real time
%% 
load Zouhuihui_C40_Buckling_info.mat
load Zouhuihui_C40_Buckling_result.mat

Info = info_analysis(info, binding);
t_now = 6.3e-5;

for i = 1%:length(Info)
    result = Result{i}; 
    T = result.now.T;
    [~, loc_now] = min(abs(T-t_now));
        
    % N,EA,GA,V
    N_all = result.post.viber.Tv{1};
    EA_all_all = result.post.viber.Tv{2};
    GA_all_all = result.post.viber.Tv{3};
    V_all = result.post.viber.Tv{4};
        
    N_now = (N_all(loc_now,1:end-1) + N_all(loc_now,2:end))/2; 
    Coord = result.pre.Coord;
    
    R = Coord(floor(length(Coord)/3),2);
    V_now = (V_all(loc_now,1:end-1) + V_all(loc_now,2:end))/2/R; 
    
    EA_all = result.pre.EA_all;
    EI_all = result.pre.EI_all/2;
    GA_all = result.pre.GA_all;
    rhoI_all = result.pre.rhoI_all/2;
    EI_all2 = result.pre.EI_all2;
    mL = result.pre.mL;
    mL(ceil(0.9*length(mL)):end) = mL(floor(0.9*length(mL)));
    k_all = result.pre.k_all;
    X_now = result.now.X(loc_now,1);
    
    EA_all_now = EA_all_all(loc_now,:);
    GA_all_now = GA_all_all(loc_now,:);
    EI_all_now = EA_all_now./EA_all'.*EI_all';
    EI_all_now2 = EA_all_now./EA_all'.*EI_all2';
    EI_all_now2 = EI_all_now2.*(1 + V_now).^4;
    k_all_now = EA_all_now./EA_all'.*k_all';
    
    Kt = vibration_beam_K_Timo(Coord, GA_all_now, EI_all_now, N_now, false, true);
    Kt2 = vibration_beam_K_Timo(Coord, GA_all_now, EI_all_now, N_now, true, true, X_now);
%     Mt = vibration_beam_M_Timo(Coord, mL, GA_all_now, EI_all_now, rhoI_all, false, true);
%     Mt2 = vibration_beam_M_Timo(Coord, mL, GA_all_now, EI_all_now, rhoI_all, true, true, X_now);
 
    Ks = vibration_shell_K(Coord, EI_all_now2, N_now, k_all_now);
%     Ms = vibration_shell_M(Coord, result.pre.m_all, k_all_now);
    
    Et = Buckling_test_modal_plot(Coord, Kt, 2, i, 'b', 'Beam - All');
    Et2 = Buckling_test_modal_plot(Coord, Kt2, 2, i, 'b--', 'Beam - Shaft');
    Es = Buckling_test_modal_plot(Coord, Ks, 1, i, 'r', 'Shell');
    
    figure (i)
    legend('location','southeast')
    xlabel('Longitudinal location / m')
    ylabel('\it{\delta w}\rm{_0}')
    title(strrep(Info(i).project_name, 'D', 'E_t'))
    ax = gca;
    ax.FontName = 'Times New Roman';
    ax.FontSize = 14;
    hold off
end
