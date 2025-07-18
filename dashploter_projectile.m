function dashploter_projectile(Rn, BN, i, Coord, Varfai, F, F_min, F_max)
% dashploter_projectile   projectile color plot in animation
% Invoking                valve
% Invoked                 dashploter
% INPUT
%   Rn                    vector of 2x1, loaction of projectile's centroid
%   BN                    matrix of 2x2, directional cosine matrix
%   i                     scalar, rank of presented timestep
%   Coord                 matrix of nx2, proectile's outline [X Y]
%   Varfai                vector of length j, radial coordination of projectile's element
%   F                     matrix of  nxmxj, time-dependent stress distribution across projectile's element
%   F_min                 scalar, min value of colorbar
%   F_max                 scalar, max value of colorbar
%%     
    num_mesh = length(Varfai);
    mesh_sizex = (Coord(end,1) - Coord(1,1))/(num_mesh-1);
    X = zeros(num_mesh);
    Y = X;
    S = X;
    f_zero = true;
    x_all = Coord(:,1);
    x_all = (linspace(min(x_all),max(x_all),length(x_all)-1))';
    
    for j = 1:num_mesh
        x = Coord(1,1) + mesh_sizex*(j-1);
        r = interp1(Coord(:,1),Coord(:,2),x);
        for k = 1:num_mesh
            y = r*sin(Varfai(k));
            co = [x;y];
            co = BN'*co;
            co = co + Rn;
            X(j,k) = co(1);
            Y(j,k) = co(2);
            f = interp1(x_all,F(i,:,k),x);
            S(j,k) = valve(f, F_min, F_max);
            if S(j,k) ~= 0 && f_zero
                f_zero = false;
            end
        end
    end

if f_zero
   S(end,:) = 0.01; 
end
contour(X,Y,S,'ShowText','off','fill','on')

end