function dX = rigid(X, config, pre)
% rigid     obtain force and moment summarization from rigid penetration
% Invoking  drag_calculator
% Invoked   Runge_kutta
% INPUT
%   X       vector of 1x6, with [x y vx vy fai omega]
%   config  struct, representing basic configuratuion options of single claculation
%   pre     struct, obtained result from pre-processing
% OUTPUT
%   dX      vector of 1x6, with [dx dy dvx dvy dfai domega]      
%%
Rn = X(1:2);
Vn = X(3:4);
fai = X(5);
omega = X(6);

m = pre.m0;
I = pre.I0;
Wall_loc = config.medium.config;

Xi = (Wall_loc-Rn(1))/cos(fai);
[Fn, M, ~] = drag_calculator(Vn, omega, fai, Xi, pre.Coord, config, pre, true, false);
domega = M/I;
dfai = omega;
dVn = Fn/m;
dRn = Vn;

dX=[dRn;dVn;dfai;domega];

end