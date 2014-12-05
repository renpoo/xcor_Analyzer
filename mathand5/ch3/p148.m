figure;
subplot(2,1,1);plot(1:length(data),abs(fft(data)));axis tight
subplot(2,1,2);plot(1:length(data),angle(fft(data))*180/pi);
axis tight
