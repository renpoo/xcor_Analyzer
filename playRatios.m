clear;
close all;


L = 0.00383; % = 1 / 261.6255653005986 : C


A = 1.0;
theta = 0.0;
%fs = 44100;
fs = 96000;
%duration = 3.0;
duration = 0.5;
%duration = 2^19/fs;
%interval = duration;
interval = 0.0;


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
    %fprintf( 'Scale: %s (%04.2f Hz) for ratio "%01.3f"\n', ConvertScaleToString_( ConvertHertzToScale_(f0) ), f0, 1.0 );
    fprintf( 'Scale: %s (%04.2f Hz) for ratio "%01.3f"\n', ConvertScaleToString_( ConvertHertzToScale_(f1) ), f1, r(k) );
    fprintf( 'Scale: %s (%04.2f Hz) for ratio "%01.3f"\n', ConvertScaleToString_( ConvertHertzToScale_(f2) ), f2, 1-r(k) );
    
    
    %s0 = generateSinWave_(A, f0, fs, duration, theta );
    s1 = generateSinWave_(A, f1, fs, duration, theta );
    s2 = generateSinWave_(A, f2, fs, duration, theta );
    
    if ( 1 ),
        w = HanningWindow_( length( s1 ) );
        s1 = s1 .* w';
        s2 = s2 .* w';
    end;
    
    S = s1 + s2; % + s0;
    
    %sound( s1, fs );
    %sound( s2, fs );
    sound( S, fs );
    pause( duration + interval );
    
    disp(' ');
    
end;



