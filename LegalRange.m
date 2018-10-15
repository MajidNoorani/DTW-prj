function [inside]= LegalRange(Tx,Ty,Qmax,ix,iy)

if iy>=((ix-1)/Qmax)+1
   if iy<=Qmax*(ix-1)+1
       if iy>=Qmax*(ix-Tx)+Ty
           if iy<=(ix-Tx)/Qmax+Ty
               inside=1;
           else
               inside=0;
           end
       else
           inside=0;
       end
   else
       inside=0;
   end
else
    inside=0;
end


