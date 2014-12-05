close all;clear all
ch3_4
figure
f=t/dt/dt/length(y);
f=f(1:end/2+1);
fftdat=fft(y)/(length(y)/2);
fftdat = fftdat(1:end/2+1);
subplot(2,1,1);plot(f,abs(fftdat));axis tight;xlabel('Frequency[Hz]');
ylabel('Amplitude');
subplot(2,1,2);plot(f,180/pi*angle(fftdat));axis tight;xlabel('Frequency[Hz]');
ylabel('Phase[degree]');


