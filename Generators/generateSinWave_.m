function S = generateSinWave_(A, f, fs, d, theta, outputWavFileName)

N = round( fs * d );  % samples
tVec = ( 1 : N )' / fs;  % time vector
s = A * sin( 2*pi * f * tVec + theta );  % sin wave

S = s;
audiowrite( outputWavFileName, S, fs );
sound( S, fs );
