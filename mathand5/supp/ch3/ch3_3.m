close all
n=1024;dt=0.01;
t=(1:1024)*dt-dt;
omega=2*pi*1;
y=zeros(size(t));
for n=1:1000
    y=y+4/pi*sin((2*n-1)*omega*t)/(2*n-1);
end
plot(t,y);
xlabel('Time[sec]');
ylabel('Magnitude');
axis([0,t(end),-1.2,1.2]);
