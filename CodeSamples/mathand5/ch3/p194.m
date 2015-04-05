clear all;close all
n=1024;dt=0.01;t=(1:n)*dt-dt;f=t/dt/dt/n;
omega=2*pi*13; % 13Hz
data=sin(omega*t)+randn(size(t))*0.1;
% AR model
% Adata=[x[1 2 3 4 5 6 7 8];
%            1 2 3 4 5 6 7 8
%              1 2 3 4 5 6 7 8
%x(k)=-a1*x(k-1)-a2*x(k-2)-a3*x(k-3);
%x(k)=[x(k-1) x(k-2) x(k-3)]*[-a1;-a2;-a3];
%x(k+4)=[x(k+3) x(k+2) x(k+1)]*[-a1;-a2;-a3];
%Y=AX
A=[data(3:end-1);data(2:end-2);data(1:end-3)]';
B=[data(4:end)'];
a=A\B
