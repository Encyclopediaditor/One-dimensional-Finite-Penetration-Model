function [U_new, dU_new, ddU_new] = Newmark_beta_iter(U, dU, ddU, delta_U, gamma, beta, dt)
% Newmark_beta_iter  engine core of plastic structural response for bars
% Invoking           none
% Invoked            Newmark_beta2, Newmark_beta3
% INPUT
%   U                matrix of mxn, history of displacement of each element
%   dU               matrix of mxn, history of velocity of each element
%   ddU              matrix of mxn, history of acceleration of each element
%   delta_U          matrix of mxn, history of displacement's increment of each element
%   gamma,beta       scalar, Newmark_beta's core coefficient
%   dt               scalar, time gap   
%%    
U_new = U + delta_U;
ddU_new = 1/(beta*dt^2)*delta_U - 1/(beta*dt)*dU - (1/(2*beta)-1)*ddU;
dU_new = gamma/(beta*dt)*delta_U + (1-gamma/beta)*dU + (1-gamma/(2*beta))*dt*ddU;
end