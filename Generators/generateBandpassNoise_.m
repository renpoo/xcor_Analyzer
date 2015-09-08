function b = generateBandpassFilter_( fMin, fMax, fs, d, Pow )

%fs=44100;
%d = 3.0;
%Pow = 1;

%s0 = generateWhiteNoise_( fs, d, Pow, './_Sounds/whiteNoise.wav' );
%sound( s0, fs );
%figure(); plot( s0 );
%pause( d + 0.5 );

flen = length( s0 );

%fm = 1000;
%Wn = [ fm/sqrt(2) fm*sqrt(2) ] / ( fs/2 );
Wn = [ fMin fMax ];
b = fir1(flen, Wn, 'bandpass');
%figure; freqz( b );

%s = conv(s0, Wn);
%sound( s, fs );
%figure(); plot( s );
%audiowrite( './_Sounds/bandpassNoise_0.495_0.505.wav', s, fs );
%audiowrite( './_Sounds/octbandpassNoise_fm_1000Hz.wav', s, fs );
