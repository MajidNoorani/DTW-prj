clc
close all;
clear all;
learning_pattern1='america.wav';
learning_pattern2='singapore.wav';
learning_pattern3='russia.wav';
learning_pattern4='nigeria.wav';
test_pattern='america2.wav';

%% variables

[cl1]=MFCC(learning_pattern1);   %12 cepstral coefficients of learning pattern1
[cl2]=MFCC(learning_pattern2);  %12 cepstral coefficients of learning pattern2
[cl3]=MFCC(learning_pattern3);  %12 cepstral coefficients of learning pattern3
[cl4]=MFCC(learning_pattern4);  %12 cepstral coefficients of learning pattern4
[ctest]=MFCC(test_pattern);  %12 cepstral coefficients of test pattern

Tx=length(ctest);
Ty1=length(cl1);
Ty2=length(cl2);
Ty3=length(cl3);
Ty4=length(cl4);
Qmax=2;
ix=1;
iy=1;

D_Total=zeros(1,4);
for ref=1:4
    if ref==1
        Ty=Ty1;
        cl=cl1;
    elseif ref==2
        Ty=Ty2;
        cl=cl2;
    elseif ref==3
        Ty=Ty3;
        cl=cl3;
    elseif ref==4
        Ty=Ty4;
        cl=cl4;
    end
    
    %% local distance

Z=zeros(Tx,Ty);
for ix=1:Tx
    for iy=1:Ty
        [inside]= LegalRange(Tx,Ty,Qmax,ix,iy);
        if inside==1
            Z(ix,iy)= Zeta(ctest(ix,:),cl(iy,:));
        else
            Z(ix,iy)=inf;
        end
    end
end

%% calculating the overall cost
D=zeros(Tx,Ty);
D1=zeros(Tx,Ty);
D2=zeros(Tx,Ty);
D3=zeros(Tx,Ty);
D(1,1)=Z(1,1);
D(1,2:Tx)=inf;
D(2:Ty,1)=inf;
for ix=2:Tx
    for iy=2:Ty
  
        [inside]= LegalRange(Tx,Ty,Qmax,ix,iy);
        [inside1]= LegalRange(Tx,Ty,Qmax,ix-2,iy-1);
        [inside2]= LegalRange(Tx,Ty,Qmax,ix-1,iy-1);
        [inside3]= LegalRange(Tx,Ty,Qmax,ix-1,iy-2);
        if inside==1
            if inside1==1
                D1(ix,iy)=Z(ix,iy)+ D(ix-2,iy-1);
            else
                D1(ix,iy)=inf;
            end
            if inside2==1
                D2(ix,iy)=Z(ix,iy)+ D(ix-1,iy-1);
            else
                D2(ix,iy)=inf;
            end
            if inside3==1
                D3(ix,iy)=Z(ix,iy)+ D(ix-1,iy-2);
            else
                D3(ix,iy)=inf;
            end  
            D(ix,iy)=Z(ix,iy)+ min([D1(ix,iy) D2(ix,iy) D3(ix,iy)]);         %calculating the cost for each point
        else 
            D(ix,iy)=inf;
        end
    end
end
D=D/Tx;
D_Total(1,ref)=D(Tx,Ty);
%% finding the efficient path
px=Tx;
py=Ty;
path=zeros(1,Tx);
path(px)=py;
finalpoint=0;
while finalpoint==0 && py>=3 && px>=3
        A=[D(px-2,py-1) D(px-1,py-1) D(px-1,py-2)];
        [minD,p]=min(A(:));
        if p==1
            px=px-2;
            py=py-1;
        elseif p==2
            px=px-1;
            py=py-1;
        elseif p==3
            px=px-1;
            py=py-2;
        end
        path(px)=py;
        
        if px==3 && py==2
            finalpoint=1;
            path(1)=1;
        elseif px==2 && py==2
            finalpoint=1;
            path(1)=1;
        elseif px==2 && py==3
            finalpoint=1;
            path(1)=1;
        end
end


%% preparing for plotting
path1=zeros(2,Tx);
path1(1,:)=1:Tx;
path1(2,:)=path(1:Tx);
Tx1=0;
for i=1:Tx
    if path1(2,i)~=0
        Tx1=Tx1+1;
    end
end
for i=1:Tx1
    if path1(2,i)==0
        path1(:,i)=[];
    end
end

figure(ref)

Path_plot(Tx,Ty,Qmax,path1);
 
end     

sprintf('Total Cost(Test Pattern in America):\n  America: %1.3f \n  Singaore: %1.3f \n  Russia: %1.3f \n  Nigeria:%1.3f',D_Total(1),D_Total(2),D_Total(3),D_Total(4))