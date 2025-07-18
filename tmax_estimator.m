function t_max = tmax_estimator(config, pre, t_max)
% tmax_estimator  estimate maximum rigid penetration time
% Invoking        none
% Invoked         Coupled_elastic; Newmark_beta2; Newmark_beta3; Runge_kutta
% INPUT
%   config        struct, representing basic configuratuion options of single claculation
%   pre           struct, obtained result from pre-processing
%   t_max         scalar, maximun sinmulation time    
%%
    if length(config.medium.config)<=2        
        A = config.medium.A;
        B = config.medium.B;
        r = pre.d/2;
        N1 = pre.N(1);
        N2 = pre.N(2);
        t_max0 = 1.5*pre.m0/(pi*r^2*sqrt(A*B*N1*N2))*atan(sqrt(B*N2/A/N1)*config.projectile.v0);
        t_max = min(t_max, t_max0);
    end

end