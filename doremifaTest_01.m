clear;
close all;

A = 1;
duration = 3.0;
fs = 44100;
interval = 3.0;


%f = [ 512, 576, 640, 682.6, 768, 864, 960, 1023 ];



%fMax = 32;
%fMax = 64;
%fMax = 128;
%fMax = 256;
%fMax = 512;
%fMax = 1024;
%fMax = 2048;
%fMax = 4096;

f = zeros( 24, 1 );
for i = 1 : length(f),
    f(i) = fMax - length(f) + i;
end;



for i = length(f) : -1 : 1,
    disp( strcat( 'index# = ', num2str(i), '  :  ', num2str( f(i) ), 'Hz' ) );
    
    %s = makeSineWave_( A, f(i), 0, fs, duration, interval );

    s = generateCombinationalSounds( './_Sounds', strcat('sine', num2str(f(i)), 'Hz_0deg.wav'), strcat('sine', num2str(fMax), 'Hz_0deg.wav') );

    %A= 2^4;
    %s = makeNarrowbandNoise_( A, f(i), fMax, fs, duration, interval );
end;
