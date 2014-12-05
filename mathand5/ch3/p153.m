dt=0.01;t=(1:1024)*dt-dt;i=1;
peak1=[ ];close all;figure(1);
fdat=[1 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75];
lendata=length(t);lendata2=lendata/2+1;
for f=fdat
  omega=2*pi*f;
  data=sin(omega*t);
  fftdata=fft(data);
  ff=t/dt/dt/lendata;
  [i1,j1]=max(abs(fftdata(1:lendata2)))
  subplot(4,4,i);
  plot(ff(1:lendata2),abs(fftdata(1:lendata2)),ff(j1),i1,'p');
  text(ff(round(lendata/4)),800,['fontsize{20}',num2str(f)])
  axis([0 1/(2*dt) 0 1000]);
  drawnow;pause(0.5);i=i+1;
end
