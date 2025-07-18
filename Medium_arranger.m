function [Cavity, Info] = Medium_arranger(X, T, AXIS, Coord, Kx, Ky, Vxy, Cavity, Info, medium, plt, frame)
% Medium_arranger  determine the location and info of cavity in stress/fracture plot of animation
% Invoking         Medium_mode_seeker; is_in_bullet; Medium_type_seeker
% Invoked          dashploter
% INPUT
%   X              matrix of nx6, with each column [X Y VX VY Fai Omega]
%   T              vector of nx1, recorded sinmulation time
%   AXIS           vector of 1x4, [xmin xmax ymin ymax]
%   Coord          matrix of nx2, proectile's outline [X Y]
%   Kx             matrix of jxk, source magnifier of X direction
%   Ky             matrix of jxk, source magnifier of Y direction
%   Vxy            matrix of jxk, normal expansion velocity of each source
%   Cavity         matrix of mxm, indicator of whether the element belongs to cavity
%   Info           matrix of 3xmxm, indicator of elements' properties
%   medium         struct, representing basic configuratuion options of medium
%   plt            struct, representing basic configuratuion options of post-process
%   frame          scalar, rank of frame to be calculated
%%
fai0 = medium.fai;
Y = medium.Y;
E = medium.E;
f = medium.f;
rho0 = medium.rho0;
Wall_loc = medium.config;
info_type = plt.animation.medium.map;
num_mesh = plt.animation.medium.num_mesh;

[V_all, Epsilon, Beta, Beta1] = Medium_mode_seeker(fai0, Y, E, f, rho0);

Cavity_now = Cavity;

mesh_size = [(AXIS(2) - AXIS(1))/num_mesh, (AXIS(4) - AXIS(3))/num_mesh];

fai = X(frame,5);
BN = [cos(fai) sin(fai);
    -sin(fai) cos(fai)];

for j = 1: num_mesh+1
    x_N = AXIS(1) + (j-1)*mesh_size(1);
    if x_N > Wall_loc
        for k = 1: num_mesh+1
            y_N = AXIS(4) - (k-1)*mesh_size(2);
            loc_b = BN*([x_N; y_N] - [X(frame,1);X(frame,2)]);
            in_bullet = is_in_bullet(Coord, loc_b, mesh_size);
            Cavity(k,j) = Cavity(k,j) + in_bullet;
            Cavity_now(k,j) = Cavity(k,j) + in_bullet;

            if  in_bullet == 1
                Cavity_now(k,j) = 0;
            end
        end
    else
        Cavity(:,j) = 1;
        Cavity_now(:,j) = 1;
    end
end

Cavity_now = logical(Cavity_now);

if frame == 1
    dt = T(frame);
else
    dt = (T(frame) - T(max(frame - 1, 1)))/2;
end

for j = 1: num_mesh+1
    x_N = AXIS(1) + (j-1)*mesh_size(1);
    for k = 1: num_mesh+1
        y_N = AXIS(4) - (k-1)*mesh_size(2);
        loc_b = BN*([x_N; y_N] - [X(frame,1);X(frame,2)]);
        if Cavity_now(k,j)
            Info(:,j,k) = [0; 0; 0];
        else

                info = [0; 0; 0];
                contained = 0;
                for source = 1:size(Kx, 2)
                    x0 = Coord(ceil(source/2),1);
                    y0 = Coord(ceil(source/2),2);
                    r = sqrt((loc_b(1) - x0)^2 + (loc_b(2))^2);
                    theta = atan(loc_b(2)/(loc_b(1) - x0));

                    V = Vxy(frame, source);
                    kx = Kx(frame, source);
                    ky = Ky(frame, source);
                    r0 = y0;

                    [type, S] = Medium_type_seeker(V_all, Epsilon, Beta, Beta1, V, r0, r, fai0, Y, E, f, rho0);
                    if strcmp(info_type, 'Stress')
                        if  type < 4 && type > 0                       
                            contained = contained + 1;
                        end
                        Sx = S*kx*cos(theta);
                        Sy = S*ky*sin(theta);
                        info = info + [Sx; Sy; 1];

                    elseif strcmp(info_type, 'Component')
                        switch type
                            case 1
                                info = info + [1; 0; 0];
                            case 2
                                info = info + [0; 1; 0];
                            otherwise
                                info = info + [0; 0; 1];
                        end
                    end
                end
                
                if T(frame) > 0
                    old = (T(frame) - dt)/T(frame)*(source-contained)/source;
                    new =  dt/T(frame) + (1-dt/T(frame))*contained/source;
                else
                    old = 0;
                    new = 1;
                end
                Info(:,j,k) = Info(:,j,k)*old + info*new;
        end
    end
end
