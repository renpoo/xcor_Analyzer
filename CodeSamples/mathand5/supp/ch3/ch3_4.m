datanum=8192;dt=0.01;
t=((1:datanum)-1)*dt;
omega30t=2*pi*t*30;
omega5t=2*pi*t*5;
y=sin(omega30t)+cos(omega5t);
plot(t,y);xlabel('Time[sec]');
ylabel('Amplitude');
axis([0,1,-2.1,2.1]);

