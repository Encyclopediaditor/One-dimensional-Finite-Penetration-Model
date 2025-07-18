function Key = vibration_beam_Key_Timo(Phi, L, expression)
% vibration_beam_Key_Timo  generate key terms of Timoshenko beam
% Invoking                 none
% Invoked                  vibration_beam_K_Timo; vibration_beam_M_Timo
% INPUT
%   Phi                    scalar, Timoshenko beam's key coefficient
%   L                      scalar, element's length
%   expression             string, can be 'n' or 'm'
% OUTPUT
%   Key                    vector, key derived coefficient
%%
if strcmp(expression, 'm')
    Key = [Phi^2/3 + (7*Phi)/10 + 13/35
           (Phi^2/24 + (11*Phi)/120 + 11/210)*L;
           Phi^2/6 + (3*Phi)/10 + 9/70;
           (- Phi^2/24 - (3*Phi)/40 - 13/420)*L;
           (Phi^2/120 + Phi/60 + 1/105)*L^2;
           (- Phi^2/120 - Phi/60 - 1/140)*L^2;
           6/5;
           (1/10 - Phi/2)*L;
           (Phi^2/3 + Phi/6 + 2/15)*L^2;
           (Phi^2/6 - Phi/6 - 1/30)*L^2];
elseif strcmp(expression, 'n')
    Key = [6/5;
           (1/10 - Phi/2)*L;
           (Phi^2/3 + Phi/6 + 2/15)*L^2;
           (Phi^2/6 - Phi/6 - 1/30)*L^2];
end
end