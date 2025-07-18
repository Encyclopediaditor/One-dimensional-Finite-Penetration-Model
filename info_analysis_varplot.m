function [var, note] = info_analysis_varplot(var, X, T, x_loc, lct, dTop)
% info_analysis_varplot  analyze the request of variable plot
% Invoking               none
% Invoked                Processor_post
% INPUT
%   var                  string, the variable to be presented
%   X                    matrix of nx6, with each column [X Y VX VY Fai Omega]
%   T                    vector of nx1, recorded sinmulation time
%   x_loc                string, can be 'center' or 'top', the point to be studied
%   lct                  scalar, length between projectile's centriod and top
%   dTop                 vector of nx1, history of displacement of the top
% OUTPUT
%   var                  vector of nx1, recorded variable history
%   note                 string, for legend
%%
    switch var
        case 't'
            var = T;
            note = 't /s';
        case 'x'
            if strcmp(x_loc, 'top')
                var = X(:,1) + (lct+dTop).*cos(X(:,5));
            else
                var = X(:,1);
            end
            note = 'x /m';
        case 'y'
            if strcmp(x_loc, 'top')
                var = X(:,2) + lct*sin(X(:,5));
            else
                var = X(:,2);
            end
            note = 'y /m';
        case 'vx'
            dTopdt = diff(dTop)./diff(T);
            dTopdt = ([dTopdt(1); dTopdt] + [dTopdt; dTopdt(end)])/2;
            var = X(:,3) + dTopdt;
            note = 'v_x /(m/s)';
        case 'vy'
            var = X(:,4);
            note = 'v_y /(m/s)';
        case 'fai'
            var = X(:,5)/pi*180;
            note = '\phi /degree';
        case 'omega'
            var = X(:,6);
            note = '\omega /(rad/s)';
        case 'v'
            dTopdt = diff(dTop)./diff(T);
            dTopdt = ([dTopdt(1); dTopdt] + [dTopdt; dTopdt(end)])/2;
            var = sqrt((X(:,3)+dTopdt.*cos(X(:,5))).^2 + (X(:,4)+dTopdt.*sin(X(:,5))).^2);
            note = 'v /(m/s)';
        case 'a'
            dTopdt = diff(dTop)./diff(T);
            dTopdt = ([dTopdt(1); dTopdt] + [dTopdt; dTopdt(end)])/2;
            ax = diff(X(:,3)+dTopdt.*cos(X(:,5)))./diff(T);
            ay = diff(X(:,4)+dTopdt.*sin(X(:,5)))./diff(T);
            var = sign(ax).*sqrt(ax.^2 + ay.^2);
            var = ([var(1); var] + [var; var(end)])/2;
            note = 'a /(m/s^2)';
        case 'alpha'
            var = (atan(X(:,4)./X(:,3)) - X(:,5))/pi*180;
            note = '\alpha /degree';
        case 'psi'
            var = atan(X(:,4)./X(:,3))/pi*180;
            note = '\psi /degree';
    end
end