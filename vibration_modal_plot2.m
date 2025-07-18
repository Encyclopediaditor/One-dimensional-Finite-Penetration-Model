function vibration_modal_plot2(X_real, Yo_real, Yi_real, fai, Gamma, bar_option, num_figure)
% vibration_modal_plot2  contour plot of projectile¡¯s modal
% Invoking               Medium_colormap
% Invoked                main_preparation2; vibration_demo
% INPUT
%   X_real             vector of nx1, elements' axial location
%   Yo_real            vector of nx1, elements' outter radius
%   Yi_real            vector of nx1, elements' inner radius
%   fai                vector of nx1 or 2nx1, specific modal
%   Gamma              vector of nx1, Piosson's ratio distribution
%   bar_option         string, can be 'Constant'; 'Variable'; 'Love'; 'MH'
%   num_figure         scalar, the rank of figure  
%%
num_r = ceil(length(X_real)/5);
Fai = zeros(length(X_real), num_r);
X_all = Fai;
Y_all = Fai;
range_x = 0.06;
range_y = 0.06;

R = max(Yo_real);
X_min = min(X_real);
L = max(X_real) - X_min;

switch bar_option    
    case 'Love'
        dfaidx = diff(fai)./diff(X_real);
        dfaidx = ([dfaidx(1); dfaidx] + [dfaidx; dfaidx(end)])/2;       
        Gamma = ([Gamma(1); Gamma] + [Gamma; Gamma(end)])/2;
        psi2 = -Gamma.*dfaidx;
    case 'MH'
        psi = fai(length(X_real)+1:end);
        psi = [0; psi; 0];    
        psi2 = psi./Yo_real;
        fai = fai(1:length(X_real));   
    otherwise
        psi2 = zeros(length(X_real), 1);
end
fai2 =  fai/(max(abs(fai)));

for i = 1:length(X_real)
    Y = linspace(Yi_real(i)*(1+range_y*psi2(i)), Yo_real(i)*(1+range_y*psi2(i)), num_r);
    Y_all(i,:) = Y;
    X_all(i,:) = X_real(i) + fai2(i)*range_x*L;
    for j = 1:num_r
        if Y(j) <= Yi_real(i)
            r = Yi_real(i);
        else
            r = Y(j);
        end
        
        switch bar_option    
            case 'Love'
               Fai(i,j) = sqrt((fai(i))^2 + (Gamma(i)*r*dfaidx(i))^2);
            case 'MH'
               Fai(i,j) = sqrt((fai(i))^2 + (psi(i)*r/Yo_real(i))^2);
            otherwise
               Fai(i,j) = abs(fai(i));
        end
    end
end  

C = Medium_colormap(num_r,0,true);
figure(num_figure)
contour((X_all-X_min)/L,Y_all/R,Fai,'ShowText','off','fill','on')
hold on
contour((X_all-X_min)/L,-Y_all/R,Fai,'ShowText','off','fill','on')
colormap(C)
colorbar('east');
ax = gca;
ax.FontName = 'Times New Roman';
end