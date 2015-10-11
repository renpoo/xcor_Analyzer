clear;
close all;

A = 1;
%duration = 3.0;
%fs = 44100;
fs = 96000;
duration = 2^19/fs;
%interval = duration;
interval = 0.5;

DIV = 1;
%DIV = duration;
ORDER = 32;
%ORDER = 64;
%ORDER = 128;
N = DIV * ORDER;

%f = [ 512, 576, 640, 682.6, 768, 864, 960, 1023 ];

%fMax = [ 32, 64, 128, 256, 512, 1024, 2048, 4096 ];
%fMax = [ 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384 ];
fMax = [ 1024 ];
%fMax = [ 8192 ];
%fMax = [ 16384 ];

%fMin = [ 1018 ];
fMin = fMax - ORDER;

Z = zeros( round(duration*fs), 1 );
S = zeros( 1, 1 );

for j = 1 : length(fMax),

    f = zeros( ceil(N + 1), 1 );    
    for i = 1 : length(f),
        f(i) = fMax(j) - N + i - 1;
        %f(i) = ( fMax( j ) - fMin( j ) ) * (i-1) / k + fMin( j );
    end;

    for i = length(f)-1 : -1 : 1,    
    %for i = length(f) : -1 : 1,
        disp( strcat( 'index# =  ', num2str(i), '  :  ', num2str( f(i) ), 'Hz ', '  ~  ', num2str( fMax(j) ), 'Hz' ) );
        
        %s = generateSinWave_( A, f(i), fs, duration, 0 );
        
        s = makeNarrowbandNoise_( A, f(i), fMax( j ), fs, duration, interval )';
        %s = makeNarrowbandNoise_( A, f(i), f(i+1), fs, duration, interval )';
        
        s = s / max( abs(s) );
        
        %plotPeriodogram_( s, fs );
        %audiowrite( strcat( './_Sounds/nbNoise_', num2str(f(i)), 'Hz_', num2str(fMax(j)), 'Hz.wav'), s, fs);
        
        S = vertcat( S, s, Z );
    end;
    
    
end;


sound( S, fs );