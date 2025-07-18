function dt = dt_estimator(dt_default, dX)
% dt_estimator  determine the boundary of localized force and moment integration
% Invoking      sum_set
% Invoked       drag_calculator
% INPUT
%   dt_default  scalar, default timestep 
%   dX          vector of 1x6, with [dx dy dvx dvy dfai domega] 
% OUTPUT
%   dt          scalar, revised timestep   
%%
% dX=[dRn;dVn;dfai;domega];

% v = sqrt(dX(1)^2 + dX(2)^2);
% a = sqrt(dX(3)^2 + dX(4)^2);

% if a == 0
%     dt = dt_default;
% else
%      dt = 10*dt_default/(1 + v/100)/(1 + a/(2*10^5));
%     %dt = 10*dt_default/(1 + v/100)^2/(1 + a/(2*10^5))^2;
% end
dt = dt_default;

end