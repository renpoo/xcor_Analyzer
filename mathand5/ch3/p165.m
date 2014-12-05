[magm,phase,w]=bode([1],[1 1]);
figure
subplot(2,1,1)
loglog(w/2/pi,magm);axis tight
ylabel('Magnitude[dB]');
title('Bode Diagrams')
subplot(2,1,2)
semilogx(w/2/pi,phase);axis tight
ylabel('Phase[deg]');
xlabel('Frequency [Hz]');
