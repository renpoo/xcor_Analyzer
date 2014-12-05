function s=GenerateWhiteNoise_(f, fs, d, outputWavFileName)
#f = 100;              % frequency
#fs = 44100;        % sampling rate
#d = 0.2;              % duration 
N = round(fs*d);  % #samples

#N = 100000; # Force sampling points Number to be 100000

noise = randn(N, 1);

#t = (1:N)'/fs;        % time vector
#s = sin(2*pi*f*t);   % sinusoid
#wavwrite(s, fs, outputWavFileName);


wavwrite(noise, fs, outputWavFileName);
s = noise;