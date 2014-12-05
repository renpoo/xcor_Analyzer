function s=GenerateSinusoid_by_Cosine_(f, fs, d, outputWavFileName)
#f = 100;              % frequency
#fs = 44100;        % sampling rate
#d = 0.2;              % duration 
N = round(fs*d);  % #samples
t = (1:N)'/fs;        % time vector
s = cos(2*pi*f*t);   % sinusoid
wavwrite(s, fs, outputWavFileName);



