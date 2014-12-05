n=1024;dt=0.01;
t=(1:n)*dt-dt;
omega = 2*pi*1; % [Hz]
y=sin(omega*t);
ffty=fft(y)/(n/2);
f=t/dt/dt/n;
subplot(2,1,1);plot(f(1:(n/2+1)),abs(ffty(1:(n/2+1))));
axis([f([1 end]) 0 max(abs(ffty))]);
xlabel('Frequency[Hz]');
ylabel('Magnitude');
subplot(2,1,2);plot(f(1:(n/2+1)),angle(ffty(1:(n/2+1))));
axis([f([1 end]) -pi pi]);
xlabel('Frequency[Hz]');
ylabel('Phase [rad]');
