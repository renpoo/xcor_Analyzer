% sample program gfilt.m
close all;clear all;n=4096;dt=0.005;
t=((1:n)-1)*dt;
f=t/dt/dt/n;n2=n/2;n2p1=n2+1;
s1=sin(2*pi*t*50); s2=sin(2*pi*t*5); %s3=cos(2*pi*t*80);
s=s1+s2;%+s3;
plot(t,s);axis tight
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calc corresponding index number
F=50;
index=round(F*dt*n+1);index1=(index-1):(index+1);index2=n+2-index1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% band elminate filter
ffts=fft(s);
befil=ones(size(s));
befil(index1)=zeros(size(index1));
befil(index2)=zeros(size(index2));
subplot(2,2,1)
plot(f,abs(ffts)/n2,'r');axis([0 f(n2p1) 0 1])
xlabel('Frequency (Hz)'), ylabel('Magnitude');
title('Original Signal in freq domain');
%% Now apply fft filter in freq domain
ffts = ffts.*befil;
subplot(2,2,3)
plot(f,abs(ffts)/n2,'r');axis([0 f(n2p1) 0 1])
xlabel('Frequency (Hz)'), ylabel('Magnitude');
title('filtered Signal in freq domain')
subplot(2,2,2)
plot(t,s,t,s2);axis([0 0.3 -2 2])
xlabel('Time [sec]');ylabel('Time waveform');title('Original Signal');
subplot(2,2,4)
plot(t,real(ifft(ffts)));axis([0 0.3 -2 2])
xlabel('Time [sec]');ylabel('Time waveform');
title('Filterd Signal by using fft');
