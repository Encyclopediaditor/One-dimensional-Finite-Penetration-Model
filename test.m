clear;clc;
%% bar
% syms x L
% 
% Fai = [1-x/L, x/L];
% dFai = diff(Fai,x);
% M = int(Fai'*Fai,x,[0,L]);
% K = int(dFai'*dFai,x,[0,L]);
% p = int(Fai',x,[0,L]);

%% beam
% syms x L
% 
% Fai = [1 - 3*(x/L)^2 + 2*(x/L)^3,...
%        L*(x/L) - 2*L*(x/L)^2 + L*(x/L)^3,...
%        3*(x/L)^2 - 2*(x/L)^3,...
%        -L*(x/L)^2 + L*(x/L)^3];
% dFai = diff(Fai,x);
% ddFai = diff(dFai,x);
% M = int(Fai'*Fai,x,[0,L]);
% J = int(dFai'*dFai,x,[0,L]);
% K = int(ddFai'*ddFai,x,[0,L]);
% p = int(Fai',x,[0,L]);

%% fill test

% plot([0 1],[1 0])
% hold on
% 
% a = 1;
% fill_test(a)
% 
% function fill_test(a)
% if a == 1
%    t = (1/16:1/8:1)'*2*pi;
%     x = cos(t);
%     y = sin(t); 
%     fill(x,y,'r')
% end
% end

%% legend test

% p1 = plot([0 1],[1 0],'DisplayName','p1');
% hold on
% p2 = plot([0 2],[1 0]);
% lgd = legend();

%% Input_check
% text = Input_check({1000,950,900}, 1);
% 
% function text = Input_check(cel, rat)
% if iscell(cel)    
%     if iscell(rat)
%         text = [];
%         for i = 1:length(cel)
%             text = [text Input_check(cel{i},rat)];
%         end
%     else
%         text = '';
%         for i = 1:length(cel)
%             text = [text ',' Input_check(cel{i},rat)];          
%         end
%         text = text(2:end);
%     end 
% else
%     if isempty(cel)
%         text = '';
%         if iscell(rat)
%             for i = 1:length(rat)
%                 if isempty(rat{i})
%                     text = i;
%                     break
%                 end
%             end
%         end
%     elseif islogical(cel)
%        if rat{1} && cel
%            text = 1;
%        elseif rat{1} && ~cel
%            text = 2;
%        elseif rat{2} && cel
%            text = 1;
%        else
%            text = 2;
%        end
%     elseif ischar(cel)
%         text = 1;
%         for i = 1:length(rat)
%            if strcmp(rat{i},cel)
%               text = i;
%               break
%            end
%         end
%     elseif length(cel) == 1
%         text = num2str(cel/rat);
%     else
%         text = '';
%         for i = 1:length(cel)
%             text = [text ',' Input_check(cel(i),rat)];
%         end
%         text = text(2:end);
%     end
% end
% end

%% Face the reality

% Name = {'I-1','II-1', 'II-2','II-3'};
% Color = [0    0.4470    0.7410;
%     0.8500    0.3250    0.0980;
%     0.9290    0.6940    0.1250;
%     0.4940    0.1840    0.5560];
% Style = {'-','-','-','-'};
% 
% % Acc t
% for i = 1:length(Name)
% %     load([Name{i} '07-Jul-2023_result'])
% %     load([Name{i} '07-Jul-2023_info'])
%     result = Result{i};
%     Tv = result.post.viber.Tv{1};
%     [TFX, ~, ~] = drag_calculator_review2(result.now.X, result.now.T, info.config, result.pre);
%     T = result.now.T;
%     Ac = Tv(:,1)+sum(TFX,2)/result.pre.m0;
% %     plot(T(1:100), Ac(1:100)-Ac(1), Style{i},'DisplayName', Name{i},'linewidth',1.5) 
%     plot(T, Ac-Ac(1), Style{i},'DisplayName', Name{i},'linewidth',1.5) 
%     hold on
% end
% 
% hold off
% legend('Location','Southeast')
% xlabel('t / s')
% ylabel('Acc / (m/s^2)')

% Acc max
% for i = 1:length(Name)
% %     load([Name{i} '19-Feb-2024_result'])
% %     load([Name{i} '19-Feb-2024_info'])
%     result = Result{i};
%     Tv = result.post.viber.Tv{1};
%     Tv = Tv(:,1:info.config.projectile.num_mesh+1);
%     [TFX, ~, ~] = drag_calculator_review2(result.now.X, result.now.T, info.config, result.pre);
%     X = result.pre.Coord(:,1);
%     p1 = plot(X-min(X), max(Tv+sum(TFX,2)/result.pre.m0),'Color',Color(i,:),'DisplayName',Name{i},'linewidth',1.5); 
%     hold on
%     plot(X-min(X), min(Tv+sum(TFX,2)/result.pre.m0),'Color',Color(i,:),'linewidth',1.5);
%     leg = legend('Location','east');
%     leg.String(end) = [];
% end
% hold off
% legend('Location','east')
% xlabel('Location / m')
% ylabel('Acc / (m/s^2)')

% Acc mean
% for i = 1:length(Name)
% %     load([Name{i} '19-Feb-2024_result'])
% %     load([Name{i} '19-Feb-2024_info'])
%     result = Result{i};
%     Tv = result.post.viber.Tv{1};
%     Tv = Tv(:,1:info.config.projectile.num_mesh+1);
%     [TFX, ~, ~] = drag_calculator_review2(result.now.X, result.now.T, info.config, result.pre);
%     X = result.pre.Coord(:,1);
%     p1 = plot(X-min(X), mean(sqrt((Tv+sum(TFX,2)/result.pre.m0).^2)),'Color',Color(i,:),'DisplayName',Name{i},'linewidth',1.5); 
%     hold on
% end
% hold off
% legend('Location','east')
% xlabel('Location / m')
% ylabel('Acc / (m/s^2)')

%% Face the reality2

% % Name = {'Bar Constant','Bar Love', 'Bar MH'};
% % Color = [0    0.4470    0.7410;
% %     0.8500    0.3250    0.0980;
% %     0.9290    0.6940    0.1250];
% % %    0.4940    0.1840    0.5560];
% % % Style = {'-','-','-','-'};
% % 
% % for i = 1:length(Name)
% %     load([Name{i} '07-Jul-2023_result'])
% %     load([Name{i} '07-Jul-2023_info'])
% %     result = Result{2};
% %     Tv = result.post.viber.Tv{1};
% %     [TFX, ~, ~] = drag_calculator_review2(result.now.X, result.now.T, info.config, result.pre);
% %     T = result.now.T;
% %     Ac = Tv(:,1)+sum(TFX,2)/result.pre.m0;
% %     plot(T(1:100), Ac(1:100), Style{i},'DisplayName', Name{i},'linewidth',1.5) 
% %     hold on
% % end
% % 
% % hold off
% % legend('Location','Southeast')
% % xlabel('t / s')
% % ylabel('Acc / (m/s^2)')
% 
% for i = 1:length(Name)
%     load('egg_test31-Jan-2024_result')
%     load('egg_test31-Jan-2024_info')
%     result = Result{i};
%     Tv = result.post.viber.Tv{1};
%     [TFX, ~, ~] = drag_calculator_review2(result.now.X, result.now.T, info.config, result.pre);
%     X = result.pre.Coord(:,1);
%     p1 = plot(X, max(Tv+sum(TFX,2)/result.pre.m0),'Color',Color(i,:),'DisplayName',Name{i},'linewidth',1.5); 
%     hold on
%     plot(X, min(Tv+sum(TFX,2)/result.pre.m0),'Color',Color(i,:),'linewidth',1.5);
%     leg = legend('Location','east');
%     leg.String(end) = [];
% end
% hold off
% legend('Location','east')
% xlabel('Location / m')
% ylabel('Acc / (m/s^2)')

%% Face the reality3

% X = [4783.7	4819	4805.9	4770
% 9667.3	9922.4	9814.5	9756.8
% 13848	14653	14336	14269
% 4731.2	4796.3	4783.1	4748.9
% 9915.7	10189	10077	10013
% 13314	14162	13869	13819
% 2405.9	2409.5	2407.8	2388.4
% 4934.4	4961.2	4947.6	4910
% 7251.4	7326.4	7285.7	7234.7
% 2390.2	2398.1	2396.5	2377.4
% 5063.7	5094.4	5080.2	5041.2
% 7001.1	7081.1	7043.6	6995.7];
% 
% Name = {'Constant', 'Love', 'MH'};
% Color = {'ro','gx','bs'};
% X_real = X(:,1);
% X = X(:,2:4);
% 
% for i = 1:3
%     plot(X_real,X(:,i),Color{i},'displayname',Name{i})
%     hold on
% end
% plot([1500*1.05 15000],[1500 15000/1.05],'--r','linewidth',1.5,'displayname','5% error band')
% plot([1500 15000],[1500 15000],'k','linewidth',1.5,'displayname','')
% plot([1500 15000/1.05],[1500*1.05 15000],'--r','linewidth',1.5,'displayname','')
% h = legend();
% axis([1500 15000 1500 15000])
% h.String = {'Constant'  'Love'  'MH'  '5% error band'};
% xlabel('real f /Hz')
% ylabel('predicted f /Hz')

%% Face the reality 4

% Name = {'I-1','II-1', 'II-2','II-3'};
% Color = [0    0.4470    0.7410;
%     0.8500    0.3250    0.0980;
%     0.9290    0.6940    0.1250;
%     0.4940    0.1840    0.5560];
% Style = {'-','-','-','-'};
% 
% for i = 1:length(Name)
% %     load([Name{i} '07-Jul-2023_result'])
% %     load([Name{i} '07-Jul-2023_info'])
%     result = Result{i};
%     mL = result.pre.mL;
%     X = result.pre.Coord(:,1);
%     X = (X(1:end-1) + X(2:end))/2;
%     plot(X-min(X), mL/(X(2)-X(1)), Style{i},'DisplayName', Name{i},'linewidth',1.5) 
%     hold on
% end
% 
% hold off
% legend('Location','Southeast')
% xlabel('Location / m')
% ylabel('{\rho}A / (kg / m)')

%% Area plot

% Name = {'I-1','II-1', 'II-2','II-3'};
% Color = [0    0.4470    0.7410;
%     0.8500    0.3250    0.0980;
%     0.9290    0.6940    0.1250;
%     0.4940    0.1840    0.5560];
% Style = {'-','-','-','-'};
% 
% A = [3.7661, 2.9039, 4.07;
%     3.8253, 2.8447, 4.07;
%     4.07, 2.6, 4.07;
%     3.335, 3.335, 4.07];
% R = result.pre.Coord(1,2);
% 
% for i = 1:length(Name)
%     result = Result{i};
%     X = result.pre.Coord(:,1);
%     X = X-min(X);
%     len = X(end);
%     Aera = X;
%     a = A(i,:)/sum(A(i,:))/A(i,3)*pi*R^2;
%     
%     for j = 1:length(X)
%        if  X(j) <= len/3
%            Aera(j) = a(3);
%        elseif X(j) <= len/3*2
%            Aera(j) = a(2);
%        else
%            Aera(j) = a(1);
%        end
%     end
%     p1 = plot(X, Aera, Style{i},'Color',Color(i,:),'DisplayName', Name{i},'linewidth',1.5); 
%     hold on
% end
% 
% hold off
% legend('Location','Southeast')
% xlabel('Location / m')
% ylabel('Aera / m^2')

%% Shape function plot

% Name = {'I-1','II-1', 'II-2','II-3'};
% Color = [0    0.4470    0.7410;
%     0.8500    0.3250    0.0980;
%     0.9290    0.6940    0.1250;
%     0.4940    0.1840    0.5560];
% 
% 
% A = [3.7661, 2.9039, 4.07;
%     3.8253, 2.8447, 4.07;
%     4.07, 2.6, 4.07;
%     3.335, 3.335, 4.07];
% Style = {'-','--'};
% Shape_name = {'1^{st} shape', '2^{nd} shape'};
% 
% for i = 1:length(Name)
%     result = Result{i};
%     X = result.pre.Coord(:,1);
%     a = A(i,:)/sum(A(i,:));
%     fai = acos(a(1)*a(3)/(a(1)*a(2)+a(1)*a(3)+a(2)*a(2)+a(2)*a(3)));
%     X = X-min(X);
%     len = X(end);
%     Shape = X;
%     Omega = [fai, pi-fai];
%     
%     
%     for k = 1:length(Omega)
%     for j = 1:length(X)
%        if  X(j) <= len/3
%            Shape(j) = -a(2)*(a(1)+a(2))*sin(Omega(k))*cos(Omega(k))*sin(Omega(k)*(len/3 - X(j))/(len/3))...
%                -a(3)*(a(1)*(sin(Omega(k)))^2 - a(2)*(cos(Omega(k)))^2)*cos(Omega(k)*(len/3 - X(j))/(len/3)) ;
%        elseif X(j) <= len/3*2
%            Shape(j) = -a(1)*a(3)*sin(Omega(k))*sin(Omega(k)*(len/3*2-X(j))/(len/3))...
%                + a(2)*a(3)*cos(Omega(k))*cos(Omega(k)*(len/3*2-X(j))/(len/3));
%        else
%            Shape(j) = a(2)*a(3)*cos(Omega(k)*(len-X(j))/(len/3));
%        end
%     end
%     plot(X, Shape, Style{k},'Color',Color(i,:),'DisplayName', [Name{i} ', ' Shape_name{k}],'linewidth',1.5); 
%     hold on
%     end
% end
% 
% hold off
% legend('Location','Southeast')
% xlabel('Location / m')
% ylabel('Shape')

%% Face the reality 5

% Name = {'I-1','II-1', 'II-2','II-3'};
% Color = [0    0.4470    0.7410;
%     0.8500    0.3250    0.0980;
%     0.9290    0.6940    0.1250;
%     0.4940    0.1840    0.5560];
% Style = {'-','-','-','-'};
% 
% A = [3.7661, 2.9039, 4.07;
%     3.8253, 2.8447, 4.07;
%     4.07, 2.6, 4.07;
%     3.335, 3.335, 4.07];
% 
% for i = 1:length(Name)
%     result = Result{i};
%     X = result.pre.Coord(:,1);
%     X = X-min(X);
%     len = X(end);
%     Acc = X;
%     a = A(i,:)/sum(A(i,:));
%     cosfai = a(1)*a(3)/(a(1)*a(2)+a(1)*a(3)+a(2)*a(2)+a(2)*a(3));
%     for j = 1:length(X)
%        if  X(j) <= len/3
%            Acc(j) = 2*a(2)*(a(1)+cosfai*a(2))/(a(1)+a(2))/(a(3))^2;
%        elseif X(j) <= len/3*2
%            Acc(j) = 2*a(2)/(a(1)+a(2))/a(3)*cosfai;
%        else
%            Acc(j) = 2*a(2)/(a(1)+a(2))/a(3);
%        end
%     end
%     p1 = plot(X, Acc-1, Style{i},'Color',Color(i,:),'DisplayName', Name{i},'linewidth',1.5); 
%     hold on
%     plot(X, -Acc-1, Style{i},'Color',Color(i,:),'DisplayName', Name{i},'linewidth',1.5); 
%     leg = legend('Location','East');
%     leg.String(end) = [];
% end
% 
% hold off
% % legend('Location','Southeast')
% xlabel('Location / m')
% ylabel('Acc / (b_0 / m)')

%% RPT plot

% RPT = zeros(length(Result{1}.now.T), length(Result));
% for i = 1:length(Result)
%     result = Result{i};
%     info = Info(i);
%     r = result.pre.d/2;
%     N1 = result.pre.N(1);
%     N2 = result.pre.N(2);
%     A0 = pi*r^2*info.config.medium.A*N1;
%     B0 = pi*r^2*info.config.medium.B*N2;
%     m0 = info.config.projectile.m0; 
%     V = result.now.X(:,3);
%     T = result.now.T;
%     RPT = T + m0/sqrt(A0*B0)*atan(V*sqrt(B0/A0));
%     plot(T, RPT, 'linewidth', 1.5, 'displayname', info.project_name)
%     hold on
% end
% hold off
% legend('location','northeast')
% xlabel('t /s')
% ylabel('RPT / s')

%% Acc contrast
% TUX = Result{1}.post.viber.TUX;
% TAX = Result{1}.post.viber.Tv{1};
% t = Result{1}.now.T;
% 
% loc = 395;
% TU = TUX(:,loc);
% TV = diff(TU)./diff(t);
% TV = ([TV(1); TV] + [TV; TV(end)])/2;
% TA2 = diff(TV,1)./diff(t,1);
% TA2 = ([TA2(1); TA2] + [TA2; TA2(end)])/2;
% plot(t,TAX(:,loc), 'linewidth', 1.5)
% hold on
% plot(t,TA2, 'linewidth', 1.5)
% xlabel('t / s')
% ylabel('Acc / m/s^2')
% legend('Newmark-\beta','Second difference','location', 'southeast')
% str = num2str(loc/(info.config.projectile.num_mesh + 1),3);
% title(['x = ' str])

%% Fr test

%  A = 40*10^6*5;B = 1.5*2450;mu = 0;
%  alpha=0;omega=0;v=1400;x=0;y=0.1;fai0=0;vn=0;type=3;
%  num = 100;
%  
%  Theta = linspace(0,pi/2,num);
%  Fr = Theta;
%  for i = 1:num
%      FM = drag_calculator_base(A, B, mu, Theta(i), alpha, omega, v, x, y, fai0, vn, type);
%      Fr(i) = FM(4);
%  end
%  
%  plot(Theta, Fr, 'linewidth',1.5)
%  xlabel('\theta')
%  ylabel('Fr / (N/m)')

%% Output plot

% load Acc_test2V_info.mat
% load Acc_test2V_result.mat
% 
% Coord = Result{1}.pre.Coord;
% X_real = (Coord(:,1))';
% Viber_option = info_analysis_sigma(info.config.projectile.E, info.plot.vibration.option);
% [X, ytext] = info_analysis_viber(X_real, Viber_option{1});
% X = X - min(X);
% x_max = max(X);
% TV = cell(1,length(Result));
% 
% T = Result{1}.now.T;
% Tv = Result{1}.post.viber.Tv;
% Tv = Tv{1};
% [T_a,Tv] = dashploter_frame(T,Tv,info.plot.frame_option,info.plot.num_frame);
% v_max = max(max(Tv));
% v_min = min(min(Tv));
% 
% AXIS = [0,x_max,v_min,v_max];
% 
% for num_figure = 1:4
% %     num_i = num_figure*14 - 13 + [1, 4, 7, 10, 13];
%     num_i = (num_figure*5 - 5 + [1, 2, 3, 4, 5])*2-1;
% %     num_i = num_figure*5 - 2 + [1, 2, 3, 4, 5];
%     vibration_output_plot(X, Tv, T_a, AXIS, num_i, num_figure)
% end

%% Heavy pound ep_max recongnization

% load Heavy_pound_result.mat
% load Heavy_pound_info.mat
% 
% Info = info_analysis(info, binding);
% [Info_normal, Info_parallel] = info_analysis_parallel(Info);
% Y_all = (900:100:1800)';
% D_all = [1 2 3 5 7 10 15 21 26 31 36 41 46]';
% Ep_min = zeros(10, 13);
% Ep_min(:,1) = [nan; -0.2869; -0.1077; -0.05401; -0.04099; -0.02235; -0.009875; -0.005285; -0.00007432; 0];
% 
% for i = 1:length(Result)
%    result = Result{i};
%    info = Info_parallel(i);
%    Y = info.config.projectile.Y(1)/10^6;
%    if Y == 890
%       Y = 900; 
%    end
%    D = info.config.projectile.D(1)/10^9;
%    
%    [~,loc_Y] = min(abs(Y_all - Y));
%    [~,loc_D] = min(abs(D_all - D));
%    
%    Tv = result.post.viber.Tv{1};
%    Ep_min(loc_Y,loc_D) = min(Tv(end,:));
% end
% 
% [Y_all_all, D_all_all] = meshgrid(Y_all, D_all);
% surf(D_all_all', Y_all_all', Ep_min)
% xlabel('D / GPa')
% ylabel('Y / MPa')
% zlabel('Min \epsilon_p')
% ax = gca;
% ax.FontName = 'Times New Roman';
% ax.FontSize = 18;
% axis([11 61 900 1800 -0.045 0])

%% Comparison of shear & normal stress

% E = 210*10^9;
% gamma = 0.269;
% G = E/2/(1+gamma);
% lambda = (E - 2*G)./(3*G - E).*G;
% 
% TUX = result.now.TUX;
% TGX = result.now.TGX;
% X = result.pre.Coord(:,1);
% R = result.pre.Coord(:,2);
% 
% dTUXdX = (vibration_dX(X, TUX'))';
% dTUXdX = ([dTUXdX(:,1) dTUXdX] + [dTUXdX dTUXdX(:,end)])/2;
% dTGXdX = (vibration_dX(X, TGX'))';
% dTGXdX = ([dTGXdX(:,1) dTGXdX] + [dTGXdX dTGXdX(:,end)])/2;
% 
% 
% TSigma_x = lambda*(dTUXdX + 2*TGX) + 2*G*dTUXdX;
% TSigma_r = lambda*(dTUXdX + 2*TGX) + 2*G*TGX;
% Ttao_xr = G*dTGXdX.*R';
% 
% num_T = 40;
% plot(X',TSigma_x(num_T,:),'linewidth',1.5)
% hold on
% plot(X',TSigma_r(num_T,:),'linewidth',1.5)
% plot(X',Ttao_xr(num_T,:),'linewidth',1.5)
% legend('\sigma_x','\sigma_r','\sigma_{xr}')

%% Thin walled Cone

% syms a f(x)
% dsolve(x*diff(f,x) + f == a*x)

%% Acc test
% load Acc_test2_info.mat
% load Acc_test2_result.mat
% Color = [0    0.4470    0.7410;
%     0.8500    0.3250    0.0980];
% Name = {'I', 'II'};
% for i = 1:2
%     result = Result{i};    
% %     len = find(result.pre.Coord_all(:,2,2) > 0);
% %     len = len(end);
% %     len = length(result.pre.Coord);
%     len = 525;
%     T = result.now.T;    
%     X = result.pre.Coord(1:len,1);
%     Tv = result.post.viber.Tv{1}(:,1:len);
%     [TFX, ~, ~] = drag_calculator_review2(result.now.X, T, info.config, result.pre);
%     Tv = Tv+sum(TFX,2)/result.pre.m0;
%     
%     Int_Tv = trapz(T, Tv.^2);
%     
%     figure(1)
%     plot(X-min(X), max(Tv),'Color',Color(i,:),'DisplayName',Name{i},'linewidth',1.5); 
%     hold on
%     plot(X-min(X), min(Tv),'Color',Color(i,:),'linewidth',1.5);
%     leg = legend('Location','east');
%     leg.String(end) = [];
%     
%     figure(2)
%     hold on
%     plot(X-min(X), Int_Tv,'Color',Color(i,:),'DisplayName',Name{i},'linewidth',1.5); 
%     
%     figure(3)
%     hold on
%     plot(T, Tv(:,floor(length(result.pre.Coord)*0.05)),'Color',Color(i,:),'DisplayName',Name{i},'linewidth',1.5); 
%     
%     figure(4)
%     hold on
%     plot(T, Tv(:,floor(length(result.pre.Coord)*0.45)),'Color',Color(i,:),'DisplayName',Name{i},'linewidth',1.5); 
% end
% 
% figure(1)
% hold off
% legend('Location','east')
% xlabel('Location / m')
% ylabel('Acc / (m/s^2)')
% ax = gca; ax.FontName = 'Times New Roman'; ax.FontSize = 14;
% 
% figure(2)
% hold off
% legend('Location','east')
% xlabel('Location / m')
% ylabel('Int Acc')
% ax = gca; ax.FontName = 'Times New Roman'; ax.FontSize = 14;
% 
% figure(3)
% hold off
% legend('Location','east')
% xlabel('Time / s')
% ylabel('Acc / (m/s^2)')
% title('Location = 0.05 \it{L}')
% ax = gca; ax.FontName = 'Times New Roman'; ax.FontSize = 14;
% 
% figure(4)
% hold off
% legend('Location','east')
% xlabel('Time / s')
% ylabel('Acc / (m/s^2)')
% title('Location = 0.45 \it{L}')
% ax = gca; ax.FontName = 'Times New Roman'; ax.FontSize = 14;

%% load FRF

% load Acc_test2_rigid_info.mat
% load Acc_test2_rigid_result.mat
% Color = [0    0.4470    0.7410;
%     0.8500    0.3250    0.0980;
%     0.9290    0.6940    0.1250;
%     0.4940    0.1840    0.5560];
% 
% for i = 1:length(Result)
% result = Result{i}; 
% T = result.now.T;  
% dt = T(2) - T(1);
% L = length(T);
% if mod(L,2) == 1
%    L = L-1; 
% end
% 
% [TFX, ~, ~] = drag_calculator_review2(result.now.X, T, info.config, result.pre);
% Ta = sum(TFX,2)/result.pre.m0;
% 
% Y = fft(Ta);
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = (0:L/2)/L/dt;
% 
% figure(1)
% plot(T, Ta,'linewidth',1.5,'displayname',result.project_name)
% hold on
% 
% figure(2)
% plot(f,P1,'linewidth',1.5,'displayname',result.project_name) 
% hold on
% end
% 
% figure(1)
% xlabel('Time / s')
% ylabel('Acc / (m/s^2)')
% ax = gca; ax.FontName = 'Times New Roman'; ax.FontSize = 14;
% hold off
% legend()
% 
% figure(2)
% title('Single-Sided Amplitude Spectrum of a(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
% ax = gca; ax.FontName = 'Times New Roman'; ax.FontSize = 14;
% legend()
% hold off

%% Acc FRF

% load Acc_test2_info.mat
% load Acc_test2_result.mat
% Color = [0    0.4470    0.7410;
%     0.8500    0.3250    0.0980;
%     0.9290    0.6940    0.1250;
%     0.4940    0.1840    0.5560];
% 
% for i = 1:length(Result)
% result = Result{i}; 
% T = result.now.T;  
% dt = T(2) - T(1);
% L = length(T);
% if mod(L,2) == 1
%    L = L-1; 
% end
% 
% T = result.now.T;    
% Tv = result.post.viber.Tv{1};
% [TFX, ~, ~] = drag_calculator_review2(result.now.X, T, info.config, result.pre);
% Tv = Tv+sum(TFX,2)/result.pre.m0;
% 
% Ta = Tv(:,floor(length(result.pre.Coord)*0.45));
% Y = fft(Ta);
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = (0:L/2)/L/dt;
% 
% figure(1)
% plot(T, Ta,'linewidth',1.5,'displayname',result.project_name)
% hold on
% 
% figure(2)
% plot(f,P1,'linewidth',1.5,'displayname',result.project_name) 
% hold on
% end
% 
% figure(1)
% xlabel('Time / s')
% ylabel('Acc / (m/s^2)')
% ax = gca; ax.FontName = 'Times New Roman'; ax.FontSize = 14;
% hold off
% legend()
% 
% figure(2)
% title('Single-Sided Amplitude Spectrum of a(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
% ax = gca; ax.FontName = 'Times New Roman'; ax.FontSize = 14;
% legend()
% hold off

%% find function

A = dir();

for i = 1:length(A)
   if ~A(i).isdir && strcmp(A(i).name(end-1:end),'.m')
      fid  = fopen(A(i).name);
      tline = fgetl(fid);
      while ~isnumeric(tline)
          if contains(tline, 'info_analysis_progress_bar')
               warning(['Found in ' A(i).name])
               break
          end
          tline = fgetl(fid);
      end
      fclose(fid);
   end
end