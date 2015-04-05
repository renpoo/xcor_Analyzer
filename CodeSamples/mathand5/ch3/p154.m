dt=0.01;t=(1:1024)*dt-dt;i=1;
close all;figure(1);
lendata=length(t);lendata2=lendata/2;
ampdat=[ ];
f=25;
for amp=1:16
omega=2*pi*f;
data=amp*sin(omega*t);
fftdata=fft(data);
ff=t/dt/dt/lendata;
[i1,j1]=max(abs(fftdata(1:lendata2)))
subplot(4,4,i);
ampdat=[ampdat i1];
plot(ff(1:lendata2),abs(fftdata(1:lendata2)),ff(j1),i1,'p');
text(ff(round(lendata/3)),8000,['Åèfontsize{20}',num2str(amp)])
axis([ff([1 lendata2]) 0 10000]);
drawnow;pause(0.5);i=i+1;
end
figure
plot(ampdat);
