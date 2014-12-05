plot3(1:length(data),real(fft(data)),imag(fft(data)));
grid;xlabel('data number');ylabel('real part');zlabel('imag part');
