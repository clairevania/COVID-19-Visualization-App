% Calculate Daily Data
function [a, b]=dail(s,v)
a = zeros(1,375);
b = zeros(1,375);            
a(1)=s(1);
b(1)=v(1);
for i = 2:length(s)
    a(i)=s(i)-s(i-1);
    b(i)=v(i)-v(i-1);
    if a(i)<0
        a(i) = 0;
    elseif b(i)<0
        b(i)=0;
    end
                    
end