clear;figure(1);dt=0.01;t=(1:2048)*dt-dt;
y1=2*cos(2*pi*10*t+0.1);y2=0.4*sin(2*pi*20*t+0.3);y3=1*cos
(2*pi*30*t);
y=y1+y2+y3;
subplot(3,1,1);plot(t,y1,'b');xlim([0 1]);
subplot(3,1,2);plot(t,y2,'b');xlim([0 1]);
subplot(3,1,3);plot(t,y3,'b');xlim([0 1]);
figure(2);plot(t,y,'b');xlim([0 1]);
figure(3);ffty=abs(fft(y))/(length(y)/2);
maxfreq=1/2/dt;f=t/dt/dt/length(y);
plot(f,ffty,'b');xlim([0 maxfreq]);
