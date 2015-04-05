dt=0.01;
f=10;%[Hz]
t=(1:1024)*dt-dt;
omega=2*pi*f;
data=sin(omega*t);
plot(t,data);xlim([0 1]);
