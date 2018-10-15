function [d]= Zeta(ct,cl)
d=0;
for i=1:12
    d=(ct(i)-cl(i))^2+d;
end
d=sqrt(d);
