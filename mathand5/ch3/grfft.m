% sample program grfft.m
fs = 1000; % assumed sampling frequency
t=((1:1024)-1)/fs; % to make x-axis data for plot
s1=0.8*sin(2*pi*t*5); s2=0.9*sin(2*pi*t*250);
s3=0.5*sin(2*pi*t*450);
s=s1+s2+s3+rand(size(s1));
figure(1)
subplot(3,1,1);plot(t(1:100),s(1:100),'b') ;xlabel('Time[sec]') ;
ylabel('Amplitude');title('data with noise')
ffts = fft(s);
% The first component of ffts, ffts(1), is simply the sum of the data,
% and can be removed.
n=length(ffts);
ffts(1)=[];
n2=n/2;n2p1=n2+1;
power = abs(ffts(1:n2p1)/n2);
nyquist = fs/2;freq = (1:n2p1)/n2*nyquist;
subplot(3,1,2)
index=find(diff(power)>.4)+1;
plot(freq,power,'b',freq(index),power(index),'rp')
ylabel('Amplitude');xlabel('Frequency [Hz]');title('FFT result linear plot')
for i=index
text(freq(i)*1.1,power(i),[num2str(freq(i)),'Hz',num2str(power(i))]);
end
axis([freq(1),max(freq),0,1]);
subplot(3,1,3)
loglog(freq,20*log10(power),'b',freq(index),20*log10(power(index)),'rp')
ylabel('Amplitude [dB]');xlabel('Frequency [Hz]');title('FFT result log plot');
axis tight
for i=index
  text(freq(i)*1.1,20*log10(power(i)),...
  [num2str(freq(i)),'Hz ',num2str(power(i))]);
end
set(findobj('fontsize',12),'fontsize',5) % This is to make visible font size. Trick!
