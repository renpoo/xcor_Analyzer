clear;
close all;

A = 1;
%duration = 3.0;
%fs = 44100;
fs = 96000;
duration = 2^19/fs;
interval = duration;

N = 10;

%f = [ 512, 576, 640, 682.6, 768, 864, 960, 1023 ];

%fMax = [ 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192 16384 ];
fMax = [ 1024 ];

S = [];
Z = zeros( 2^19, 1 );


for j = 1 : length(fMax),
            
    %{%}
    f = zeros( N, 1 );
    for i = 1 : length(f),
        %f(i) = fMax - length(f) + i;
        f(i) = fMax(j) - length(f) + i;
    end;
    %{%}
    
    
    for i = length(f) : -1 : 1,
        disp( strcat( 'index# = ', num2str(i), '  :  ', num2str( f(i) ), 'Hz' ) );
        
        s = makeSineWave_( A, f(i), 0, fs, duration, interval );
        
        %s = generateCombinationalSounds( './_Sounds', strcat('sine', num2str(f(i)), 'Hz_0deg.wav'), strcat('sine', num2str(fMax), 'Hz_0deg.wav') );
        
        %A= 2^4;
        %s = makeNarrowbandNoise_( A, f(i), fMax, fs, duration, interval );
        %S = vertcat( S, s, Z ); 
    end;
    
    
end;