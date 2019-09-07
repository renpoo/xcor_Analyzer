function S = generateSinWave_(A, f, fs, d, theta )
N = round( fs * d ); % samples
%tVec = ( 1 : N )' / fs; % time vector
tVec = ( 0 : N ) / fs; % time vector
S = A * sin( 2 * pi * f * tVec + theta ); % sin wave
