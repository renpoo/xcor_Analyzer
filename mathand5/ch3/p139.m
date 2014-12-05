n=1024;dt=0.01;
t=(1:n)*dt-dt;
omega=2*pi*1;% [Hz]
offset=0.5;
y=sign(sin(omega*t)+offset);
p1=plot(t,y);
xlabel('Time[sec]');
ylabel('Magnitude');
axis([0 t(end) -1.2 1.2]);
u1=uicontrol('style','slider','max',1,'min',-1,'value',0)
set(u1,'callback','set(p1,''ydata'',sign(sin(omega*t)+get(u1,''value'')))');
