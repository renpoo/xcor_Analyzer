% sample program gfilt.m
clear all;close all;n=4096;dt=0.005;
t=((1:n)-1)*dt;
f=t/dt/dt/n;n2=n/2;n2p1=n2+1;
s1=sin(2*pi*t*50); s2=sin(2*pi*t*5); s3=cos(2*pi*t*80);
s=s1+s2+s3;plot(t,s);axis tight
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calc correspoiding index number Lowpass= 70[Hz]
F_low=70;
index1=round(F_low*dt*n+1);index2=n+2-index1;lofil=ones(size(s));
lofil((index1+1):(index2-1))=zeros(size((index1+1):(index2-1)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calc correspoiding index number Highpass=10[Hz]
F_high=10;
index1=round(F_high*dt*n+1);index2=n+2-index1;hifil=zeros(size(s));
hifil(index1:index2)=ones(size(index1:index2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ffts=fft(s);
subplot(2,2,1)
plot(f,abs(ffts)/n2,'r');axis([0 f(n2p1) 0 1])
xlabel('Frequency (Hz)'), ylabel('Magnitude');
title('Original Signal in freq domain');
%% Now apply fft filter in freq domain
ffts = ffts.*lofil.*hifil;
subplot(2,2,3)
plot(f,abs(ffts)/n2,'r');axis([0 f(n2p1) 0 1])
xlabel('Frequency (Hz)'), ylabel('Magnitude');
title('filtered Signal in freq domain')
subplot(2,2,2)
plot(t,s,t,s1);axis([0 0.3 -2 2])
xlabel('Time [sec]');ylabel('Time waveform');title('Original Signal');
subplot(2,2,4)
plot(t,real(ifft(ffts)));axis([0 0.3 -2 2])
xlabel('Time [sec]');ylabel('Time waveform');
title('Filterd Signal byusing fft');
