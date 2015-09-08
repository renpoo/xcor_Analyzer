function S = generateNarrowbandNoise_( fMin, fMax, fs, d, Pow, outputWavFileName )

n = round( fs * d );  
if mod( n, 2 ) == 1, n = n + 1; end;

s = randn( 1, n );
s = s / max( abs(s) );

S = fft( s );

%{
FilPink = ( 1 : n/2 ) / (n/2);
FilPink = [ fliplr( FilPink ) FilPink ];

S = S .* FilPink;
%}

FilBand = zeros( 1, n/2 );
for ( i = fMin : fMax ), FilBand( i ) = 1.0; end;
FilBand = [ FilBand fliplr( FilBand ) ];

S = S .* FilBand;

S = ifft( S );
S = real( S )';

S = S * Pow;

audiowrite( outputWavFileName, S, fs );
sound( S, fs );
