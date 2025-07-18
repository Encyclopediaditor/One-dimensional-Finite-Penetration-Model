function U = vibration_balance2(U, Coord, mL)
% vibration_balance2  adjust X directional internal force, so that the projectile¡¯s
%                     mass center don¡¯t move during structural response calculation
% Invoking            none
% Invoked             vibration_seeker
% INPUT
%   U                 matrix of nx2, history of displacement of each element
%   Coord             matrix of nx2, proectile's outline [X Y]
%   mL                vector of nx1, mass distribution of every element  
%%
X = (Coord(:,1));
mL = ([0; mL] + [mL; 0])/2;
m = sum(mL);
mx = sum(mL.*X);
mxx = sum(mL.*X.*X);
K = [mx m;
    mxx mx];

U_temp = U(1:length(mL),2);
U_temp_all = sum(mL.*U_temp);
U_temp_allX = sum(mL.*X.*U_temp);
AB = (K\[U_temp_all; U_temp_allX])';
U_temp = U_temp - AB(1)*X - AB(2);

U(1:length(mL),2) = U_temp;
end