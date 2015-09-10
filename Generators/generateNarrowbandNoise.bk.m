fs = 44100;
d = 3.0;
Pow = 2^3;


S = generateWhiteNoise_( fs, d, Pow );
sound( S, fs );
pause( d + 1.0 );

fMin = 1024;
fMax = 1152;
%fLen = 1;
%fLen = 16;
%fLen = 256;
fLen = 512;
%fLen = 1024;
%fLen = length(S) / fs;
%fLen = fs;

fM = 1024; % (Hz)


b = getBandpassFilter_( fMin, fMax, fs, fLen );
%b = getOctavebandFilter_( fM, fLen, fs );


s = conv( S, b );
sound( s, fs );
figure(); plot( s );
