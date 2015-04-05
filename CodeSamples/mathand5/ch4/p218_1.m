lowpass=tf(1,[1 1])
ycm=lsim(lowpass,y,t)
plot(t,y,t,ycm);
xlabel('Time[sec]');
ylabel('Magnitude');
axis([0 t(end) -1.2 1.2]);
