function S = generateWhiteNoise_( fs, d, outputWavFileName )

n = round( fs * d );
if mod( n, 2 ) == 1, n = n + 1; end;

s = randn( 1, n );
s = s / max( abs(s) );

% Fil = ( 1 : n/2 ) / (n/2);
% Fil = [ fliplr( Fil ) Fil ];

% S = fft( s );
% S = S .* Fil;
% S = ifft( S );
% S = real( S )';

S = s';

audiowrite( outputWavFileName, S, fs );
sound( S, fs );


