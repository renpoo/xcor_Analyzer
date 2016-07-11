clear;
close all;


L = 1 / 261.6255653005986; % : C
%L = 1 / 440;

A = 1.0;

theta = 0.0;

%fs = 44100;
fs = 96000;

%duration = 3.0;
%duration = 0.5;
duration = 1.0;
%duration = 2^19/fs;

%interval = duration;
interval = 0.5;


r = [];
f0 = 1 / L;


Max = 30;


for l = 1 : Max,
    r( l ) = ( Max - l + 1 ) / Max;
end;


A = ( A - 0.01 ) / 3 ;


for k = 1 : length(r),
    fprintf( 'Iteration: %d times\n', k );
    
    f1 = f0 / r(k);
    f2 = f0 / (1 - r(k));

    if ( 1 ),
        fprintf( 'Scale: %s (%04.2f Hz) for ratio "%01.3f"\n', ConvertScaleToString_( ConvertHertzToScale_(f0) ), f0, 1.0 );
        s0 = generateSinWave_(A, f0, fs, duration, theta );
    end;
    
    fprintf( 'Scale: %s (%04.2f Hz) for ratio "%01.3f"\n', ConvertScaleToString_( ConvertHertzToScale_(f1) ), f1, r(k) );
    s1 = generateSinWave_(A, f1, fs, duration, theta );

    fprintf( 'Scale: %s (%04.2f Hz) for ratio "%01.3f"\n', ConvertScaleToString_( ConvertHertzToScale_(f2) ), f2, 1-r(k) );
    s2 = generateSinWave_(A, f2, fs, duration, theta );
    
    if ( 1 ),
        %w = HanningWindow_( length( s1 ) );
        w = hann( length( s1 ) )';
        
        if ( 1 ),
            s0 = s0 .* w';
        end;
        
        s1 = s1 .* w';
        s2 = s2 .* w';
    end;

    
    if ( 1 ),
        S = s1 + s2 + s0;
    else
        S = s1 + s2; % + s0;
    end;

    
    if ( 0 ),
        sound( s0, fs );
        pause( duration + interval );
        sound( s1, fs );
        pause( duration + interval );
        sound( s2, fs );
        pause( duration + interval );
    end;
    
    sound( S, fs );
    pause( duration + interval );
    
    disp(' ');
    
end;
