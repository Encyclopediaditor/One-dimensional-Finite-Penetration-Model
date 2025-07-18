function ratio = drag_calculator_edge(xi, x, y, fai, v0, vn, config, pre, is_cratered)
% drag_calculator_edge  adjustment based on free edge effect
% Invoking              none
% Invoked               drag_calculator
% INPUT
%   xi                  scalar, wall locaion in body frame
%   x                   scalar, element's axial location
%   y                   scalar, element's radius
%   fai                 scalar, inclination angle
%   v0                  scalar, the absolute peneration velocity
%   vn                  scalar, element's nomal velocity
%   config              struct, representing basic configuratuion options of single claculation
%   pre                 struct, obtained result from pre-processing
%   is_cratered         logical, wtether the target has been cratered
% OUTPUT
%   ratio               scalar, drag_new = drag*ratio
%%
    E = config.medium.E;
    fc = config.medium.f;    
    S = config.medium.A/fc;
    rho = config.projectile.rho;

    m0 = pre.m0;    
    d = pre.d;
    xmax = pre.l - pre.lc;
    N = pre.N(3);
    k = (0.707 + pre.lh/d)*cos(fai);

    if length(xi) == 1
        if is_cratered
            if x - xi < k*d
                ratio = 0;
            else
                ratio = 1;
            end
        else
            %For cratering
            lamb = 2/3;
            alpha = 6/(3+2*lamb);
            tao = (3-lamb)*fc/3;
            b = y*(2*E/3/tao)^(1/3);
            ds = (x - xi)/cos(fai);
    
            if ds < b
                ratio = 0;
            else
                sigma_nR = 2*rho*vn^2*(1/(alpha*lamb-4) - 1/(alpha*lamb-1)) - tao/lamb + (2*E/3/tao)^(alpha*lamb/3)*...
                    (2*tao/3*(1 - (b/ds)^3) + 2*rho*vn^2*(alpha*lamb/(alpha*lamb-1)*(3*tao/2/E)^(1/3)-...
                    alpha*lamb/(alpha*lamb-4)*(3*tao/2/E)^(4/3)/4 - y/ds + (y/ds)^4/4) + tao/lamb);
                sigma_n = 2*rho*vn^2*(1/(alpha*lamb-4) - 1/(alpha*lamb-1)) - tao/lamb + (2*E/3/tao)^(alpha*lamb/3)*...
                    (2*tao/3 + 2*rho*vn^2*(alpha*lamb/(alpha*lamb-1)*(3*tao/2/E)^(1/3)-...
                    alpha*lamb/(alpha*lamb-4)*(3*tao/2/E)^(4/3)/4) + tao/lamb);
                ratio = sigma_nR/sigma_n;
            end
        end
    else
        alpha0 = 66.1/180*pi;    
        Hs = d*(-1 + sqrt(1 + sqrt(3)*S*(N*rho*v0^2/S/fc + 1)/(1 + pi*k*d^3*N*rho/(4*m0)))*tan(alpha0)*cos(fai))/(2*tan(alpha0)); 

        if is_cratered
            if x - xi(1) < k*d
                ratio = 0;
            elseif x > xi(2) - Hs
                ratio = (xi(2) - xmax)/Hs;
            else
                ratio = 1;
            end
        else
            if x > xi(2) - Hs
                ratio = (xi(2) - xmax)/Hs;
            else
                %For cratering
                lamb = 2/3;
                alpha = 6/(3+2*lamb);
                tao = (3-lamb)*fc/3;
                b = y*(2*E/3/tao)^(1/3);
                ds = (x - xi(1))/cos(fai);
        
                if ds < b
                    ratio = 0;
                else
                    sigma_nR = 2*rho*vn^2*(1/(alpha*lamb-4) - 1/(alpha*lamb-1)) - tao/lamb + (2*E/3/tao)^(alpha*lamb/3)*...
                        (2*tao/3*(1 - (b/ds)^3) + 2*rho*vn^2*(alpha*lamb/(alpha*lamb-1)*(3*tao/2/E)^(1/3)-...
                        alpha*lamb/(alpha*lamb-4)*(3*tao/2/E)^(4/3)/4 - y/ds + (y/ds)^4/4) + tao/lamb);
                    sigma_n = 2*rho*vn^2*(1/(alpha*lamb-4) - 1/(alpha*lamb-1)) - tao/lamb + (2*E/3/tao)^(alpha*lamb/3)*...
                        (2*tao/3 + 2*rho*vn^2*(alpha*lamb/(alpha*lamb-1)*(3*tao/2/E)^(1/3)-...
                        alpha*lamb/(alpha*lamb-4)*(3*tao/2/E)^(4/3)/4) + tao/lamb);
                    ratio = sigma_nR/sigma_n;
                end
            end
        end    
    end

    ratio = max(min(ratio,1),0);
end