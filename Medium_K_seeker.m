function [Kx ,Ky, Vxy] = Medium_K_seeker(X, Ft, Coord, medium)
% Medium_K_seeker  find the stress source in stress plot of animation
% Invoking         Medium_mode_seeker; Medium_type_seeker; Medium_K_adjuster
% Invoked          dashploter
% INPUT
%   X              matrix of nx6, with each column [X Y VX VY Fai Omega]
%   Ft             matrix of nxm, stress in projectile's boundary
%   Coord                   matrix of nx2, proectile's outline [X Y]
%   medium         struct, representing basic configuratuion options of medium
% OUTPUT
%   Kx             matrix of jxk, source magnifier of X direction
%   Ky             matrix of jxk, source magnifier of Y direction
%   Vxy            matrix of jxk, normal expansion velocity of each source    
%%
    fai0 = medium.fai;
    Y = medium.Y;
    E = medium.E;
    f = medium.f;
    rho0 = medium.rho0;
    Wall_loc = medium.config;

    [V_all, Epsilon, Beta, Beta1] = Medium_mode_seeker(fai0, Y, E, f, rho0);
    
    Kx = zeros(size(X,1), (length(Coord) - 1)*2);
    Ky = Kx;
    Vxy = Kx;
        
    for i = 1: size(X,1)        
        Vn = X(i,3:4)';
        fai = X(i,5);
        omega = X(i,6);        

        BN = [cos(fai) sin(fai); 
        -sin(fai) cos(fai)];
        Vb = -BN*Vn;
        
        Info = zeros((length(Coord) - 1)*2, 5);
        for j = 1: (length(Coord) - 1)
            
            c1 = Coord(j,:);
            c2 = Coord(j+1,:);
            theta = atan(-(c2(2)-c1(2))/(c2(1)-c1(1)));
    
            x1 =  (2*c1(1) + c2(1))/3;
            y1 =  (2*c1(2) + c2(2))/3;
            x2 =  (c1(1) + 2*c2(1))/3;
            y2 =  -(c1(2) + 2*c2(2))/3;

            loc_b1 = [x1; y1];           
            loc_b2 = [x2; y2];
            loc_n1 = BN'*loc_b1;
            loc_n2 = BN'*loc_b2;
                       
            if loc_n1(1) > Wall_loc(1)                
                V = Vb - [-omega*y1; omega*x1];
                n = [sin(theta), cos(theta)];
                vn = - min(dot(V,n),0);
                Fx = Ft(i,j,1)*n(1);
                Fy = Ft(i,j,2)*n(2);
                Info(2*j - 1, :) = [x1, y1, Fx, Fy, vn];
            end
            if loc_n2(1) > Wall_loc(1)
                V = Vb - [-omega*y2; omega*x2];
                n = [sin(theta), -cos(theta)];
                vn = - min(dot(V,n),0);
                Fx = Ft(i,j,1)*n(1);
                Fy = Ft(i,j,2)*n(2);                
                Info(2*j, :) = [x2, y2, Fx, Fy, vn];
            end           
        end
        
        Vxy(i,:) = (Info(:,5))';
        
        loc_Info = find(Info(:,5)~=0);
        if ~isempty(loc_Info)
            
            Faix = zeros(length(loc_Info));
            Faiy = Faix;
            Fx = Info(loc_Info, 3);
            Fy = Info(loc_Info, 4);
            
            for j = 1:length(loc_Info)

                vn = Info(loc_Info(j), 5);
                xj = Info(loc_Info(j),1);
                yj = Info(loc_Info(j),2);
                               
                for k = 1:length(loc_Info)
                    xk = Info(loc_Info(k),1);
                    yk = Info(loc_Info(k),2);
                                        
                    theta = atan(yk/(xk - xj));
                    r = sqrt(yk^2 + (xk - xj)^2);
                    [~, S] = Medium_type_seeker(V_all, Epsilon, Beta, Beta1, vn, abs(yj), r, fai0, Y, E, f, rho0);
                    Faix(k,j) = S*cos(theta);
                    Faiy(k,j) = S*sin(theta);
                end
            end
            Kx(i,loc_Info) = (Faix\Fx)';
            Ky(i,loc_Info) = (Faiy\Fy)';

            Kx = Medium_K_adjuster(Kx,i);
            Ky = Medium_K_adjuster(Ky,i);
        end        
    end
end