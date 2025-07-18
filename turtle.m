function Coord = turtle(Info, num)
% turtle    from line code to line coordinates
% Invoking  none
% Invoked   Config_generator_demo; Processor_pre
% INPUT
%   Info    cell with struct element, representing unziped calculation request  
%   num     number of elements
% OUTPUT
%   Coord   matrix of nx2, proectile's line [X Y]        
%%
len = length(Info)/3;
Info = (reshape(Info,3,len))';
l = sum(Info(:,1));
len = l/num;
Coord = zeros(num+1,2);
c1 = [0, 0];
c_loc = 1;

for i = 1:num+1
    x = len*(i-1);
    c2 = c1 + Info(c_loc,1:2);
    
    while x > c2(1) + 10^(-13)
        c_loc = c_loc + 1;
        c1 = c2;
        c2 = c1 + Info(c_loc,1:2);
    end
    
    if Info(c_loc,3) == 0
        y = (x - c1(1))/(c2(1) - c1(1))*(c2(2) - c1(2)) + c1(2);
    else
        r = Info(c_loc,3);
        k1 = (c2(1)^2 - c1(1)^2 + c2(2)^2 - c1(2)^2)/(2*(c2(1) - c1(1)));
        k2 = (c2(2) - c1(2))/(c2(1) - c1(1));
        A = k2^2 + 1;
        B = 2*c1(1)*k2 - 2*k1*k2 - 2*c1(2);
        C = c1(1)^2 - 2*c1(1)*k1 + k1^2 + c1(2)^2 - r^2;
        
        if r > 0
            y0 = (-B - sqrt(B^2 - 4*A*C))/(2*A);
            x0 = k1 - k2*y0;
            y = y0 + sqrt(r^2 - (x - x0)^2);
        else
            y0 = (-B + sqrt(B^2 - 4*A*C))/(2*A);
            x0 = k1 - k2*y0;
            y = y0 - sqrt(r^2 - (x - x0)^2);
        end
        
    end
    Coord(num+2-i,:) = [l-x y];
end
end