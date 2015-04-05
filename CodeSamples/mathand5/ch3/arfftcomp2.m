clear all;close all
n=1024;dt=0.01;t=(1:n)*dt-dt;f=t/dt/dt/n;
freqfft=[];freqar=[];
ff=logspace(-3,0,100);
for freq=ff
  omega = 2*pi*freq;y=sin(omega*t);
  ffty=fft(y)/(n/2);
  [maxval,maxind]=max(abs(ffty(1:end/2+1)));
  freqfft=[freqfft,f(maxind)];
  A=[];jisuu=2;
  for i=1:jisuu
    tA=y(((jisuu+1):end)-i);A = [A,tA(:)];
  end
  tB=y((jisuu+1):end);B=tB(:);
  AR=A\B;
  a11=log(roots([1;-AR(:)]))/dt;
  b11=abs(a11);
  freqar=[freqar,b11/2/pi];
  disp(['theta'])
  real(a11)./b11
end
semilogx(ff,freqfft,'.',ff,freqar,'-','linewidth',3);
axis tight
legend('fft','ar model');
