function K_all = vibration_bar_K(Coord, EA_all, GA_all, GI_all, bar_option)
% vibration_bar_K          generate K matrix for bar models
% Invoking                 none
% Invoked                  main_preparation2; vibration_prepare; Newmark_beta2; Newmark_beta3; vibration_seeker
% INPUT
%   Coord                  matrix of nx2, proectile's outline [X Y]
%   EA_all,GA_all,GI_all   vector of nx1, stiffness distribution
%   bar_option             string, can be 'Constant'; 'Variable'; 'Love'; 'MH'
% OUTPUT
%   K_all                  matrix of nxn, stiffness matrix   
%%
num_element = length(Coord) - 1;
if strcmp(bar_option, 'MH')
    node_all = linspace(1,2*num_element+2,2*num_element+2);
    node_element = [node_all(1:num_element)'   node_all(2:num_element+1)' ...
        node_all(num_element+2:end-1)' node_all(num_element+3:end)'];
    K_all = zeros(2*num_element+2);
else
    node_all = linspace(1,num_element+1,num_element+1);
    node_element=[node_all(1:end-1)'  node_all(2:end)'];
    K_all = zeros(num_element+1);
end

switch bar_option
    case 'Love'
        EA_all = ([EA_all(1); EA_all] + [EA_all; EA_all(end)])/2;
        for i = 1: num_element
            L = Coord(i+1,1) - Coord(i,1);
            K = (EA_all(i) + EA_all(i+1))/(2*L)*[1 -1;
                -1 1];
            K_all(node_element(i,:),node_element(i,:))=K_all(node_element(i,:),node_element(i,:))+ K;
        end
        
    case 'MH'
        EA_all = ([EA_all(1); EA_all] + [EA_all; EA_all(end)])/2;
        GA_all = ([GA_all(1); GA_all] + [GA_all; GA_all(end)])/2;
        GI_all = ([GI_all(1); GI_all] + [GI_all; GI_all(end)])/2;
        lambdaA_all = (EA_all - 2*GA_all)./(3*GA_all - EA_all).*GA_all;
        mulA_all = 2*GA_all + lambdaA_all; % 2mu + lambda
        mulA_all2 = 4*(GA_all + lambdaA_all); % 4*(mu + lambda)
        
        for i = 1: num_element
            L = Coord(i+1,1) - Coord(i,1);
            R =  (Coord(i+1,2) + Coord(i,2))/2;
            
            Kuu = (mulA_all(i) + mulA_all(i+1))/(2*L)*[1 -1;
                -1 1];
            Kvv = [3*mulA_all2(i)+mulA_all2(i+1) mulA_all2(i)+mulA_all2(i+1);
                mulA_all2(i)+mulA_all2(i+1) mulA_all2(i)+3*mulA_all2(i+1)]*L/12;
            Kvv = Kvv + (GI_all(i) + GI_all(i+1))/(2*L)*[1 -1;
                -1 1];
            Kvu = [-2*lambdaA_all(i) - lambdaA_all(i+1) 2*lambdaA_all(i) + lambdaA_all(i+1);
                -lambdaA_all(i) - 2*lambdaA_all(i+1) lambdaA_all(i) + 2*lambdaA_all(i+1)]/3;
            K = [Kuu Kvu'/R;
                Kvu/R Kvv/R^2];
            K_all(node_element(i,:),node_element(i,:))=K_all(node_element(i,:),node_element(i,:))+ K;
            
        end
        K_all(node_all([num_element+2 2*num_element+2]),:) = [];
        K_all(:,node_all([num_element+2 2*num_element+2])) = [];
        
    otherwise
        for i = 1: num_element
            L = Coord(i+1,1) - Coord(i,1);
            K = EA_all(i)/L*[1 -1;
                -1 1];
            K_all(node_element(i,:),node_element(i,:))=K_all(node_element(i,:),node_element(i,:))+ K;
        end
end

end