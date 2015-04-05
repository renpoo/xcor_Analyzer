close all
fftdata=fft(data);[i1,j1]=max(abs(fftdata(1:end/2)));
[i2,j2]=max(abs(fftdata((end/2+1):end)));
plot(1:length(data),abs(fftdata),j1,i1,'p',j2+length(fftdata)/2-1,i2,'p');
