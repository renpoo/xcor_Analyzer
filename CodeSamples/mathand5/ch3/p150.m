dt=0.01;t=(1:1024)*dt-dt;i=1;
peak1=[ ];close all;figure(1);
fdat=[1 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75];
for f=fdat
  omega=2*pi*f;
  data=sin(omega*t);
  fftdata=fft(data);
  [i1,j1]=max(abs(fftdata(1:end/2)))
  [i2,j2]=max(abs(fftdata((end/2+1):end)));
  j2=j2+ length(fftdata)/2;
  peak1=[peak1;j1 j2];
  subplot(4,4,i);plot(1:length(fftdata),abs(fftdata),j1,i1,'p',j2,i2,'p');
  text(length(fftdata)/3,800,['fontsize{20}',num2str(f)])
  axis([1 length(fftdata) 0 1000]);
  drawnow;pause(0.5);i=i+1;
end
figure
plot(fdat,peak1);legend('j1','j2');
