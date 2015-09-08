fs = 44100;
d = 3.0;
Pow = 2^3;


S = generateWhiteNoise_( fs, d, Pow );
sound( S, fs );
pause( d + 1.0 );

fMin = 0.5;
fMax = 0.51;
fLen = 256;
%fLen = 512;
%fLen = 1024;
%fLen = length(S) / fs;
%fLen = fs;

fM = 1000; % (Hz)


%fil = getBandpassFilter_( fMin, fMax, fLen );
fil = getOctavebandFilter_( fM, fLen, fs );


s = conv(S, fil);
sound( s, fs );
figure(); plot( s );
