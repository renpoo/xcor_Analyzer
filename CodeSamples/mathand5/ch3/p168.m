t=(1:1000)*0.001-0.001;
freq=25;T=1/freq;
u=sin(2*pi*freq*t)+sin(2*pi*300*t);
%%%%%
% Bandpass Filter
%            sT
% y(t)=--------------u(t)
%          (1+sT)^2
%%%%%%%
y=lsim(tf([T 0],conv([T 1],[T 1])),u,t);
subplot(2,1,1);plot(t,u,t,sin(2*pi*freq*t),'r');
axis([0 0.2 -1.5 1.5]);
subplot(2,1,2);plot(t,y);
axis([0 0.2 -1.5 1.5]);
