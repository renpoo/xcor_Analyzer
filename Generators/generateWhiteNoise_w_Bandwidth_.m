function S = generateWhiteNoise_w_Bandwidth_( fMin, fMax, fs, d, outputWavFileName )

n = round( fs * d );
if mod( n, 2 ) == 1, n = n + 1; end;

s = randn( 1, n );
s = s / max( abs(s) );

Fil = zeros( 1, n/2 );
for ( i = fMin : fMax ), Fil( i ) = 1.0; end;
Fil = [ Fil fliplr( Fil ) ];

S = fft( s );
S = S .* Fil;
S = ifft( S );
S = real( S )';


audiowrite( outputWavFileName, S, fs );
sound( S, fs );


