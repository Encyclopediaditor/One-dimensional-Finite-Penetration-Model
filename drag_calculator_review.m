function F = drag_calculator_review(X, Coord, Varfai, config, pre, map_option)
% drag_calculator_review  normal and shear stress restoration on the surface
% Invoking                drag_calculator_element
% Invoked                 dashploter
% INPUT
%   X                     matrix of nx6, with each column [X Y VX VY Fai Omega] 
%   Coord                 matrix of nx2, proectile's outline [X Y]
%   Varfai                vector of length j, radial coordination of projectile's element
%   config                struct, representing basic configuratuion options of single claculation
%   pre                   struct, obtained result from pre-processing
%   map_option            string, animation indicator, can be ''; 'Normal'; 'Shear'; 'Overall'
% OUTPUT
%   F                     matrix of  nxmxj, time-dependent stress distribution across projectile's element      
%%
A = config.medium.A;
B = config.medium.B;
mu = config.medium.mu;
Wall_loc = config.medium.config;

is_free_edge = config.medium.free_edge;
len = length(Coord) - 1;

F = zeros(size(X,1),len,length(Varfai));

for i = 1:length(X)
    Vn = X(i,3:4)';
    fai = X(i,5);
    omega = X(i,6);
    Xi = (Wall_loc-X(i,1))/cos(fai);

    BN=[cos(fai) sin(fai); 
    -sin(fai) cos(fai)];
    Vb=-BN*Vn;
    [v,alpha] = alpha_seeker(Vb);

    Wall_num_all = ceil(length(Xi)/2);

    for Wall_num = 1:Wall_num_all
        if 2*Wall_num > length(Xi)
            xi = Xi(2*Wall_num - 1);
            if Coord(end,1) <= xi            
                continue;
            end
        else
            xi = [Xi(2*Wall_num - 1); Xi(2*Wall_num)];
            if Coord(end,1) <= xi(1) || Coord(1,1) >= xi(2)           
                continue;
            end
        end

        if is_free_edge
            kd = (pre.d*0.707 + pre.lh)*cos(fai);
            if xi(1) + kd > Coord(end,1)*cos(fai)
                is_cratered = false;
            else
                is_cratered = true;        
            end
        end

        for j = 1:len
            c1 = Coord(j,:);
            c2 = Coord(j+1,:);
            theta = atan(-(c2(2)-c1(2))/(c2(1)-c1(1)));

            x =  (c1(1) + c2(1))/2;
            y =  (c1(2) + c2(2))/2;
         
            [Fai0, Statuss] = fai0_judger(x, y, xi, fai, theta, alpha, 0);
            if is_free_edge 
                ratio = drag_calculator_edge(xi, x, y, fai, v, v*sin(theta+alpha), config, pre, is_cratered);
            else
                ratio = 1;
            end
            if isempty(Statuss)
                Statuss = 1;
            end
    
            if  Statuss ~= 0
                for k = 1:length(Varfai)
                    if strcmp(map_option, 'Shear')
                        [~, Tau] = drag_calculator_element(Fai0, Statuss, A, B, mu, x, y, v, Varfai(k), theta, omega, alpha, 0);
                        F(i,j,k) = F(i,j,k)+ ratio*norm(Tau);
                    elseif strcmp(map_option, 'Normal')
                        [Sigma, ~] = drag_calculator_element(Fai0, Statuss, A, B, mu, x, y, v, Varfai(k), theta, omega, alpha, 0);
                        F(i,j,k) = F(i,j,k) + ratio*norm(Sigma);
                    elseif strcmp(map_option, 'Overall')
                        [Sigma, Tau] = drag_calculator_element(Fai0, Statuss, A, B, mu, x, y, v, Varfai(k), theta, omega, alpha, 0);
                        F(i,j,k) = F(i,j,k) + ratio*norm(Sigma+Tau);
                    end
                end
            end
    
        end
    end
end

end