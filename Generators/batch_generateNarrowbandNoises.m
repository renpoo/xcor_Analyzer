clear;
close all;

fs = 44100;
duration = 3.0;
powerN = 2^4;


s01 = generatePinkNoise_w_Bandwidth_(  512, 1024, fs, duration, powerN, './_Sounds/narrowbandNoize_512Hz_1024Hz.wav');
plot2D_((1:length(s01)), s01, 'Amplitude', 'Sample Num', 1, './_Output Images', 'narrowbandNoize_512Hz_1024Hz.wav');
plot2D_((1:length(s01)), real(fft(s01)), 'Frequency (Hz)', 'Power', 2, './_Output Images', 'narrowbandNoize_512Hz_1024Hz.wav.Spect');
pause( 3.0 );


s02 = generatePinkNoise_w_Bandwidth_( 1024, 1152, fs, duration, powerN, './_Sounds/narrowbandNoize_1024Hz_1152Hz.wav');
plot2D_((1:length(s02)), s02, 'Amplitude', 'Sample Num', 3, './_Output Images', 'narrowbandNoize_1024Hz_1152Hz.wav');
plot2D_((1:length(s02)), real(fft(s02)), 'Frequency (Hz)', 'Power', 4, './_Output Images', 'narrowbandNoize_1024Hz_1152Hz.wav.Spect');
pause( 3.0 );


s03 = generatePinkNoise_w_Bandwidth_( 2048, 2176, fs, duration, powerN, './_Sounds/narrowbandNoize_2048Hz_2176Hz.wav');
plot2D_((1:length(s03)), s03, 'Amplitude', 'Sample Num', 5, './_Output Images', 'narrowbandNoize_2048Hz_2176Hz.wav');
plot2D_((1:length(s03)), real(fft(s03)), 'Frequency (Hz)', 'Power', 6, './_Output Images', 'narrowbandNoize_2048Hz_2176Hz.wav.Spect');
pause( 3.0 );



