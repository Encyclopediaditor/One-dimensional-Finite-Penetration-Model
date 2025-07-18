function result = Processor_now(info, result)
% Processor_now  simulation of penetration process
% Invoking       vibration_prepare; Coupled_elastic; Coupled_plastic; Runge_kutta
% Invoked        main; main_execution
% INPUT
%   info         struct, representing single calculation request
%   result       struct, recording single calculation result      
%%
    disp('Calculation of Penetration Process Begins.')
    now = struct();

    config = info.config;
    p = config.projectile;    
    pre = result.pre;
    lc = pre.lc;
    l = pre.l;
    psi = p.fai+p.alpha;
    V0n = p.v0*[cos(psi);sin(psi)];
    R0n = -(l-lc)*[cos(p.fai);sin(p.fai)];
    
    sim = info.simulation;
    dt_default = sim.dt_default;
    vmin = sim.vmin;
    t_max = sim.t_max;
    
    X0 = [R0n;V0n;p.fai;p.omega];
    
    if sim.coupled
        pre = vibration_prepare(config, pre);
        result.pre = pre;
        option = info.plot.vibration.option;
        radial = info.plot.vibration.radial;
        if ~p.plastic
            [t, X, TUX, TGX, Tv] = Coupled_elastic(config, pre, t_max, X0, dt_default, vmin, radial, option);
        else            
            [t, X, TUX, TGX, Tv] = Coupled_plastic(config, pre, t_max, X0, dt_default, vmin, radial, option);
        end
        now.Tv = Tv;
        now.TUX = TUX;
        now.TGX = TGX;
    else  
         [t,X] = Runge_kutta(config, pre, t_max, X0, dt_default, vmin);
    end
    
    now.T = t;
    now.X = X;
    result.now = now;
end