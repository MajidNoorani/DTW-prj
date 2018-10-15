function []=Path_plot(Tx,Ty,Qmax,path1)

x=1:Tx;
y=((x-1)/Qmax)+1;
plot(x,y)
hold on
y=Qmax*(x-1)+1;
plot(x,y)
y=Qmax*(x-Tx)+Ty;
plot(x,y)
y=(x-Tx)/Qmax+Ty;
plot(x,y)
axis([1 Tx 1 Ty]);
title('Legal Range and Efficient Path')
xlabel('Test Pattern')
ylabel('Refrence Patten')
grid on
plot(path1(1,:),path1(2,:),'b-*');

hold off
