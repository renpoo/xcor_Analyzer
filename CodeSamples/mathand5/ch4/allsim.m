n=1024;dt=0.01;
t=(1:1024)*dt-dt;
omega=2*pi*1;% [Hz]
y=sign(sin(omega*t));
%%%%%%MATLAB continuous model simulation%%%%%%%%%%%%%
lowpass=tf(1,[1 1])
ycm=lsim(lowpass,y,t);
%%%%%%MATLAB discrete model simulation %%%%%%%%%%%%%%%
[num,den]= c2dm(1,[1 1],dt);
ydm=filter(num,den,y)';
%%%%%%SIMULINK continuous model simulation%%%%%%%%%%%
sim('lowpasscont',t([1 end]));
ycs=simout.signals.values;
%%%%%%SIMULINK discrete model simulation %%%%%%%%%%%
sim('lowpassdisc',t([1 end]));
yds=simout.signals.values;
subplot(3,1,1);plot(t,ycm-ydm);title('MATLAB   cont-MATLAB   disc')
xlabel('Time[sec]');ylabel('error');axis tight
subplot(3,1,2);plot(t,ycm-ycs);title('MATLAB   cont-SIMULINK cont')
xlabel('Time[sec]');ylabel('error');axis tight
subplot(3,1,3);plot(t,yds-ydm);title('SIMULINK disc-Matlab disc')
xlabel('Time[sec]');ylabel('error');axis tight
