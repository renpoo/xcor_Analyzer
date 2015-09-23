function S = generateNarrowbandNoise_( fMin, fMax, fs, d, Pow )

%{
d = 3.0;
fMin = 1024;
fMax = 1152;
fs = 44100;
Pow = 2^2;
%}


n = round( fs * d );  
if mod( n, 2 ) == 1, n = n + 1; end;

%rng('shuffle');

%s = randn( 1, n );
s = rand( [ 1 n ] );
s = s / max( abs(s) );

fftS = fft( s );

FilBand = zeros( 1, n/2 );
for ( i = round(fMin * d) : round(fMax * d) ), FilBand( i ) = 1.0; end;
FilBand = [ FilBand fliplr( FilBand ) ];

bandfilFftS = fftS .* FilBand;

S = real( ifft( bandfilFftS ) )' * Pow;


%audiowrite( outputWavFileName, S, fs );
%sound( S, fs );
