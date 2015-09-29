clear;
close all;

A = 1;
%duration = 3.0;
%fs = 44100;
fs = 96000;
duration = 2^19/fs;
%interval = duration;
interval = 0.5;

%DIV = 5.5;
DIV = duration;
%ORDER = 10;
%ORDER = 32;
%ORDER = 64;
ORDER = 128;
N = DIV * ORDER;

%f = [ 512, 576, 640, 682.6, 768, 864, 960, 1023 ];

%fMax = [ 32, 64, 128, 256, 512, 4096 ];
%fMax = [ 32, 64, 128, 256, 512, 1024, 2048, 4096 ];
%fMax = [ 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384 ];
%fMax = [ 32 ];
%fMax = [ 64 ];
%fMax = [ 128 ];
%fMax = [ 256 ];
%fMax = [ 512 ];
%fMax = [ 1024 ];
%fMax = [ 2048 ];
%fMax = [ 4096 ];
%fMax = [ 8192 ];
fMax = [ 16384 ];


%fMin = [ 1018 ];
%fMin = fMax - ORDER;

Z = zeros( 2^19, 1 );

for l = 1 : ORDER,
    N = DIV * l;
    fMin = fMax - l;
    
    for k = N : N,
        S = Z;
        
        for j = 1 : length(fMax),
            disp( strcat( '##### k =  ', num2str(k) ) );
            %{%}
            f = zeros( ceil(k + 1), 1 );
            for i = 1 : length(f),
                %f(i) = fMax - length(f) + i;
                %f(i) = fMax(j) - N + i;
                f(i) = ( fMax( j ) - fMin( j ) ) * (i-1) / k + fMin( j );
            end;
            %{%}
            
            %return;
            
            
            %for i = length(f) : -1 : 1,
            for i = length(f)-1 : -1 : 1,
                disp( strcat( 'index# =  ', num2str(i), '  :  ', num2str( f(i) ), 'Hz ', '  ~  ', num2str( f(i+1) ), 'Hz' ) );
                
                %s = makeSineWave_( A, f(i), 0, fs, duration, interval );
                
                %s = generateCombinationalSounds( './_Sounds', strcat('sine', num2str(f(i)), 'Hz_0deg.wav'), strcat('sine', num2str(fMax), 'Hz_0deg.wav') );
                
                %A= 2^4;
                %s = makeNarrowbandNoise_( A, f(i), fMax( j ), fs, duration, interval )';
                s = makeNarrowbandNoise_( A, f(i), f(i+1), fs, duration, interval )';
                s = s / max( abs(s) );
                
                S = S + s;
                %S = horzcat( S, s, Z );
                
            end;
            
            S = S / max( abs(S) );
            %plotPeriodogram_( S, fs );
            audiowrite( strcat( './_Sounds/pNoise_', num2str(fMin(j)), 'Hz_to_', num2str(fMax(j)), 'Hz.wav'), S, fs);
            %sound( S, fs ); pause( duration + interval );
            
        end;
        
        %S = S / max( abs(S) );
        %plotPeriodogram_( S, fs );
        %audiowrite( strcat( './_Sounds/pNoise_', num2str(fMin(j)), 'Hz_to_', num2str(fMax(j)), 'Hz.wav'), S, fs);
        %sound( S, fs ); pause( duration + interval );
    end;
    
end;