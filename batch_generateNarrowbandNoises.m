%clear;
%close all;

fs = 44100;
duration = 3.0;
powerN = 2^4;


s01 = generateNarrowbandNoise_(  512, 1024, fs, duration, powerN, './_Sounds/narrowbandNoize_512Hz_1024Hz.wav');
plot2D_((1:length(s01)), s01, 'Amplitude', 'Sample Num', 1, './_Output Images', 'narrowbandNoize_512Hz_1024Hz.wav');
plot2D_((1:length(s01)), real(fft(s01)), 'Frequency (Hz)', 'Power', 2, './_Output Images', 'narrowbandNoize_512Hz_1024Hz.wav.Spect');
pause( 3.0 );
return;

s02 = generateNarrowbandNoise_( 1024, 1152, fs, duration, powerN, './_Sounds/narrowbandNoize_1024Hz_1152Hz.wav');
plot2D_((1:length(s02)), s02, 'Amplitude', 'Sample Num', 3, './_Output Images', 'narrowbandNoize_1024Hz_1152Hz.wav');
plot2D_((1:length(s02)), real(fft(s02)), 'Frequency (Hz)', 'Power', 4, './_Output Images', 'narrowbandNoize_1024Hz_1152Hz.wav.Spect');
pause( 3.0 );
return;

s03 = generateNarrowbandNoise_( 2048, 2176, fs, duration, powerN, './_Sounds/narrowbandNoize_2048Hz_2176Hz.wav');
plot2D_((1:length(s03)), s03, 'Amplitude', 'Sample Num', 5, './_Output Images', 'narrowbandNoize_2048Hz_2176Hz.wav');
plot2D_((1:length(s03)), real(fft(s03)), 'Frequency (Hz)', 'Power', 6, './_Output Images', 'narrowbandNoize_2048Hz_2176Hz.wav.Spect');
pause( 3.0 );

s04 = generateNarrowbandNoise_(  1024, 1024, fs, duration, powerN, './_Sounds/narrowbandNoize_1024Hz_1024Hz.wav');
plot2D_((1:length(s04)), s04, 'Amplitude', 'Sample Num', 7, './_Output Images', 'narrowbandNoize_1024Hz_1024Hz.wav');
plot2D_((1:length(s04)), real(fft(s04)), 'Frequency (Hz)', 'Power', 8, './_Output Images', 'narrowbandNoize_1024Hz_1024Hz.wav.Spect');
pause( 3.0 );

s05 = generateNarrowbandNoise_(  1024, 1025, fs, duration, powerN, './_Sounds/narrowbandNoize_1024Hz_1025Hz.wav');
plot2D_((1:length(s05)), s05, 'Amplitude', 'Sample Num', 9, './_Output Images', 'narrowbandNoize_1024Hz_1025Hz.wav');
plot2D_((1:length(s05)), real(fft(s05)), 'Frequency (Hz)', 'Power', 10, './_Output Images', 'narrowbandNoize_1024Hz_1025Hz.wav.Spect');
pause( 3.0 );

s06 = generateNarrowbandNoise_(  1024, 1026, fs, duration, powerN, './_Sounds/narrowbandNoize_1024Hz_1026Hz.wav');
plot2D_((1:length(s06)), s06, 'Amplitude', 'Sample Num', 11, './_Output Images', 'narrowbandNoize_1024Hz_1026Hz.wav');
plot2D_((1:length(s06)), real(fft(s06)), 'Frequency (Hz)', 'Power', 12, './_Output Images', 'narrowbandNoize_1024Hz_1026Hz.wav.Spect');
pause( 3.0 );


