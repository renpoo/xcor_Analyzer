function S = makeNarrowbandNoise_( p, fMin, fMax, fs, d, interval )

%S = generateNarrowbandNoise_( fMin, fMax, fs, d, p );
S = generateNarrowbandNoise02_( fMin, fMax, fs, d ) * p;
%S = generateNarrowbandNoise03_( fMin, fMax, fs, d ) * p;
audiowrite( strcat( './_Sounds/nbNoise_', num2str(fMin), 'Hz_', num2str(fMax), 'Hz.wav'), S, fs);
sound( S, fs );
pause( d + interval );
