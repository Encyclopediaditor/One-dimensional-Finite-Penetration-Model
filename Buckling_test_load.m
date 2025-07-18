clear;clc;
%% Buckling_test_load
%    Function: determine whether the bar would buckle in beam or shell type
%    Requirement: info.mat & result.mat, and 
%                 info.plot.vibration_analysis = true;
%                 info.plot.vibration.buttom_fix = true;
%                 info.plot.vibration.option = 'N,EA,GA,V';
%    len_T: recorded vector length of T
%% 
load Zouhuihui_C40_Buckling_info.mat
load Zouhuihui_C40_Buckling_result.mat

Info = info_analysis(info, binding);

for i = 1:length(Info)
    result = Result{i}; 
    T = result.now.T;
    len_T = 120;%length(T);
    Buckling_index = cell(len_T,1);
    Buckling_index2 = Buckling_index;
    Buckling_indext = cell(len_T,1);
    Buckling_indext2 = Buckling_index;
    Buckling_indexs = Buckling_index;
    Buckling_index_all = zeros(len_T,5);
    
    % N,EA,GA,V
    N_all = result.post.viber.Tv{1};
    EA_all_all = result.post.viber.Tv{2};
    GA_all_all = result.post.viber.Tv{3};
    V_all = result.post.viber.Tv{4};
        
    N_all = (N_all(:,1:end-1) + N_all(:,2:end))/2; 
    Coord = result.pre.Coord;
    
    R = Coord(floor(length(Coord)/3),2);
    V_all = (V_all(:,1:end-1) + V_all(:,2:end))/2; 
    V_all = V_all/R;
    
    EA_all = result.pre.EA_all;
    EI_all = result.pre.EI_all/2;
    GA_all = result.pre.GA_all;
    rhoI_all = result.pre.rhoI_all/2;
    EI_all2 = result.pre.EI_all2;
    mL = result.pre.mL;
    mL(ceil(0.9*length(mL)):end) = mL(floor(0.9*length(mL)));
    k_all = result.pre.k_all;
    X = result.now.X(:,1);
    EI_all_all = EA_all_all./EA_all'.*EI_all';
    EI_all_all2 = EA_all_all./EA_all'.*EI_all2';
    EI_all_all2 = EI_all_all2.*(1 + V_all).^4;
    k_all_all = EA_all_all./EA_all'.*k_all';
    N0 = zeros(1, length(EI_all));
    
%     K0 = vibration_beam_K(Coord, EI_all, N0, false, true);
%     K02 = vibration_beam_K(Coord, EI_all, N0, true, true, X(1));
%     M = vibration_beam_M(Coord, mL, false, true);
%     M02 = vibration_beam_M(Coord, mL, true, true, X(1));

    Kt0 = vibration_beam_K_Timo(Coord, GA_all, EI_all, N0, false, true);
    Kt02 = vibration_beam_K_Timo(Coord, GA_all, EI_all, N0, true, true, X(1));
    Mt = vibration_beam_M_Timo(Coord, mL, GA_all, EI_all, rhoI_all, false, true);
    Mt02 = vibration_beam_M_Timo(Coord, mL, GA_all, EI_all, rhoI_all, true, true, X(1));
 
    K0s = vibration_shell_K(Coord, EI_all2', zeros(1, length(EI_all)), k_all');
    Ms = vibration_shell_M(Coord, result.pre.m_all, k_all);
    
    E0 = eig(K0/M);
    E02 = eig(K02/M02);
    Et0 = eig(Kt0/Mt);
    Et02 = eig(Kt02/Mt02);
    E0s = eig(K0s/Ms);

    [~, loc] = min(E0);
    E0(loc) = [];
    [~, loc] = min(E02);
    E02(loc) = [];
    [~, loc] = min(Et0);
    Et0(loc) = [];
    [~, loc] = min(Et02);
    Et02(loc) = [];
    
    E0_min = min(E0);
    E02_min = min(E02);
    Et0_min = min(Et0);
    Et02_min = min(Et02);
    E0s_min = min(E0s);
    
    parfor j = 1:len_T

        K = vibration_beam_K(Coord, EI_all_all(j,:), N_all(j,:), false, true);
        K2 = vibration_beam_K(Coord, EI_all_all(j,:), N_all(j,:), true, true, X(j));
        M2 = vibration_beam_M(Coord, mL, true, true, X(j));

        Kt = vibration_beam_K_Timo(Coord, GA_all_all(j,:), EI_all_all(j,:), N_all(j,:), false, true);
        Kt2 = vibration_beam_K_Timo(Coord, GA_all_all(j,:), EI_all_all(j,:), N_all(j,:), true, true, X(j));
        Mt2 = vibration_beam_M_Timo(Coord, mL, GA_all_all(j,:), EI_all_all(j,:), rhoI_all, true, true, X(j));

        Ks = vibration_shell_K(Coord, EI_all_all2(j,:), N_all(j,:), k_all_all(j,:));
        E = eig(K/M);
        E2 = eig(K2/M2);
        Et = eig(Kt/Mt);
        Et2 = eig(Kt2/Mt2);
        Es = eig(Ks/Ms);

        [~, loc] = min(E);
        E(loc) = [];
        [~, loc] = min(E2);
        E2(loc) = [];
        [~, loc] = min(Et);
        Et(loc) = [];
        [~, loc] = min(Et2);
        Et2(loc) = [];
        
        Buckling_index{j} = min(E);
        Buckling_index2{j} = min(E2);
        Buckling_indext{j} = min(Et);
        Buckling_indext2{j} = min(Et2);
        Buckling_indexs{j} = min(Es);
    end
    
    Buckling_index_all(:,1) = Buckling_index_calc(cell2mat(Buckling_index));
    Buckling_index_all(:,2) = Buckling_index_calc(cell2mat(Buckling_index2));
    Buckling_index_all(:,3) = Buckling_index_calc(cell2mat(Buckling_indext));
    Buckling_index_all(:,4) = Buckling_index_calc(cell2mat(Buckling_indext2));
    Buckling_index_all(:,5) = Buckling_index_calc(cell2mat(Buckling_indexs));
    
    project_name = strrep(Info(i).project_name, 'D', 'E_t');
    figure (i)
    hold on
    plot(T(1:len_T), Buckling_index_all(:,1), 'b', 'linewidth', 1.5, 'displayname', 'Eluer - All')    
    plot(T(1:len_T), Buckling_index_all(:,2), 'b--', 'linewidth', 1.5, 'displayname', 'Eluer - Shaft')
    plot(T(1:len_T), Buckling_index_all(:,3), 'b', 'linewidth', 1.5, 'displayname', 'Timo - All')    
    plot(T(1:len_T), Buckling_index_all(:,4), 'b--', 'linewidth', 1.5, 'displayname', 'Timo - Shaft')
    plot(T(1:len_T), Buckling_index_all(:,5), 'r', 'linewidth', 1.5, 'displayname', 'Shell')
    legend('location','southeast')
    xlabel('t / s')
    ylabel('Buckling index')
    title(project_name)
    ax = gca;
    ax.FontName = 'Times New Roman';
    ax.FontSize = 14;
    hold off
end
