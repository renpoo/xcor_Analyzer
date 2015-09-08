function S = generatePinkNoise_( fs, d, Pow, outputWavFileName )

n = round( fs * d );
if mod( n, 2 ) == 1, n = n + 1; end;

s = randn( 1, n );
s = s / max( abs(s) );

Fil = ( 1 : n/2 ) / (n/2);
Fil = [ Fil fliplr( Fil ) ];

S = fft( s );
S = S .* Fil;
S = ifft( S );
S = real( S )';

S = S * Pow;

audiowrite( outputWavFileName, S, fs );
sound( S, fs );


