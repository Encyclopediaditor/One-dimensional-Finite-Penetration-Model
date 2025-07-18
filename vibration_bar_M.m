function M_all = vibration_bar_M(Coord, mL, rhoI_all, gamma, bar_option)
% vibration_bar_M  generate M matrix for bar models
% Invoking         none
% Invoked          main_preparation2; vibration_prepare; vibration_seeker
% INPUT
%   Coord          matrix of nx2, proectile's outline [X Y]
%   mL,rhoI_all    vector of nx1, mass distribution
%   gamma          vector of nx1, Poisson's ratio distribution
%   bar_option     string, can be 'Constant'; 'Variable'; 'Love'; 'MH'
% OUTPUT
%   M_all          matrix of nxn, mass matrix 
%%
num_element = length(Coord) - 1;
if strcmp(bar_option,'MH')
    node_all = linspace(1,2*num_element+2,2*num_element+2);
    node_element = [node_all(1:num_element)'   node_all(2:num_element+1)' ...
        node_all(num_element+2:end-1)' node_all(num_element+3:end)'];
    M_all = zeros(2*num_element+2);
else
    node_all = linspace(1,num_element+1,num_element+1);
    node_element=[node_all(1:end-1)'  node_all(2:end)'];
    M_all = zeros(num_element+1);
end

switch bar_option
    case 'Constant'
        for i = 1: num_element
            M = mL(i)*[1/3 1/6;
                1/6 1/3];
            M_all(node_element(i,:),node_element(i,:))=M_all(node_element(i,:),node_element(i,:))+ M;
        end
        
    case 'Variable'
        mL = ([mL(1); mL] + [mL; mL(end)])/2;
        for i = 1: num_element
            M = [3*mL(i)+mL(i+1) mL(i)+mL(i+1);
                mL(i)+mL(i+1) mL(i)+3*mL(i+1)]/12;
            M_all(node_element(i,:),node_element(i,:))=M_all(node_element(i,:),node_element(i,:))+ M;
        end
        
    case 'Love'
        mL = ([mL(1); mL] + [mL; mL(end)])/2;
        gamma = ([gamma(1); gamma] + [gamma; gamma(end)])/2;
        rhoI_all = ([rhoI_all(1); rhoI_all] + [rhoI_all; rhoI_all(end)])/2;
        
        for i = 1: num_element
            L = Coord(i+1,1) - Coord(i,1);
            M = [3*mL(i)+mL(i+1) mL(i)+mL(i+1);
                mL(i)+mL(i+1) mL(i)+3*mL(i+1)]/12;
            M = M + (gamma(i)^2*rhoI_all(i) + gamma(i+1)^2*rhoI_all(i+1))/(2*L)*[1 -1;
                -1 1];
            M_all(node_element(i,:),node_element(i,:))=M_all(node_element(i,:),node_element(i,:))+ M;
        end
        
    case 'MH'
        mL = ([mL(1); mL] + [mL; mL(end)])/2;
        rhoI_all = ([rhoI_all(1); rhoI_all] + [rhoI_all; rhoI_all(end)])/2;
        
        for i = 1: num_element
            L = Coord(i+1,1) - Coord(i,1);
            R =  (Coord(i+1,2) + Coord(i,2))/2;
            Mu = [3*mL(i)+mL(i+1) mL(i)+mL(i+1);
                mL(i)+mL(i+1) mL(i)+3*mL(i+1)]/12;
            Mv = [3*rhoI_all(i)+rhoI_all(i+1) rhoI_all(i)+rhoI_all(i+1);
                rhoI_all(i)+rhoI_all(i+1) rhoI_all(i)+3*rhoI_all(i+1)]*L/12;
            M = [Mu zeros(2);
                zeros(2) Mv/R^2];
            M_all(node_element(i,:),node_element(i,:))=M_all(node_element(i,:),node_element(i,:))+ M;
        end
        
        M_all(node_all([num_element+2 2*num_element+2]),:) = [];
        M_all(:,node_all([num_element+2 2*num_element+2])) = [];
end

end