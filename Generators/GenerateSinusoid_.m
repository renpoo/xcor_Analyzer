function s=GenerateSinusoid_(f, fs, d, theta, outputWavFileName)
#f  : frequency [Hz]
#fs : sampling rate [bit]
#d  : duration [s]
#theta : [rad]
N = round(fs*d);  % #samples
t = (1:N)'/fs;        % time vector
s = sin( 2*pi*f*t + theta );   % sinusoid
wavwrite(s, fs, outputWavFileName);



