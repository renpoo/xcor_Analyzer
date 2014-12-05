close all;clear all;
dt=0.01;t=(1:1024)*dt-dt;
omega=2*pi*1;% [Hz]
y=sign(sin(omega*t));
plot(t,y);	
xlabel('Time[sec]');
ylabel('Magnitude');
axis([0 t(end) -1.2 1.2]);
