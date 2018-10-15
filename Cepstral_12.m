function [c]= Cepstral_12(frameNo,mj,melNo)
c(1:frameNo,1:12)=0;  
for k=1:frameNo
    for i=1:12
        for j=1:melNo
            c(k,i)=mj(k,j)*cos(pi*i*(j-0.5)/melNo)+c(k,i);
        end
    end
end
c=sqrt(2/melNo)*c;




