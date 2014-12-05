n=1024;dt=0.01;
t=(1:n)*dt-dt;
omega=2*pi*1;% [Hz]
y=sign(sin(omega*t));
plot(t,y);
xlabel('Time[sec]');
ylabel('Magnitude');
axis([0 t(end) -1.2 1.2]);
