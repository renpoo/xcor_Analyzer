%clear;
%close all;

fs = 44100;
d = 3.0;
p = 2^4;
interval = 1.0;

%{
S = generateNarrowbandNoise_(  1020, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1020Hz_1024Hz.wav', S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(  1000, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1000Hz_1024Hz.wav', S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   960, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_960Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   896, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_896Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   832, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_832Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   768, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_768Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   704, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_704Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   640, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_640Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   576, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_576Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   512, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_512Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(     1, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
%}


S = generateNarrowbandNoise_( 682.6, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_682.6Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   864, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_864Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );

