function S = generateWhiteNoise_( fs, d, Pow )
%function S = generateWhiteNoise_( fs, d, Pow, outputWavFileName )

n = round( fs * d );
if (mod( n, 2 ) == 1),
    n = n + 1;
end;

s = randn( 1, n );
s = s / max( abs(s) );

S = s';
S = S * Pow;

%audiowrite( outputWavFileName, S, fs );
%sound( S, fs );


