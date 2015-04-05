%% Sample program for MATLAB filter command testwav.m
fs = 1000; % assumed sampling frequency
H = [0 0 1 1 0 0]; % normalized gain
fhz = [0 150 150 300 300 500]; % actual frequency for freq plot
f= fhz/(fs/2); % normalized freq
n = 1024; % number of data
N = 2; % order of filter
passband = [150 300]/(fs/2);ripple = .1;
ff = ((1:n)-1)/n*(fs/2); % to make x-axis data for freq plot
figure(1)
[Bb,Ab] = butter(N, passband);
[Bc,Ac] = cheby1(N, ripple, passband);
subplot(4,2,1)
plot(ff,abs(freqz(Bb,Ab,n)),fhz,H,':')
title('Butterworth filter');xlabel('Frequency (Hz)'),ylabel('Magnitude')
subplot(4,2,3);plot(ff,180/pi*angle(freqz(Bb,Ab,n)))
title('Butterworth filter');xlabel('Frequency (Hz)'),ylabel(' Angle(degree)')
subplot(4,2,5);plot(ff,abs(freqz(Bc,Ac,n)),fhz,H,':')
title('Chebyshev filter');xlabel('Frequency (Hz)'),ylabel('Magnitude')
subplot(4,2,7);plot(ff,180/pi*angle(freqz(Bb,Ab,n)))
title('Chebyshev filter');xlabel('Frequency (Hz)'),ylabel(' Angle(degree)')
t=(1:100)/fs; % to make x-axis data for plot
s1=sin(2*pi*t*5); s2=sin(2*pi*t*250); s3=sin(2*pi*t*450);
s=s1+s2+s3;
Butt=filter(Bb,Ab,s);
Cheb=filter(Bc,Ac,s);
subplot(2,2,2);plot(t,s,':',t,Butt);xlabel('Time [sec]');
ylabel('Time waveform');
subplot(2,2,4);plot(t,s,':',t,Cheb);xlabel('Time [sec]');
ylabel('Time waveform');
set(0,'ShowHiddenHandles','on');
set(findobj('type','text'),'fontsize',5);
set(findobj('type','axes'),'fontsize',5);
set(0,'ShowHiddenHandles','off');
