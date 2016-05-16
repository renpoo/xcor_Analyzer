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


Max = 100;


for l = 1 : Max,
    r( l ) = ( Max - l + 1 ) / Max;
end;


A = ( A - 0.01 ) / length(r) ;


for k = 1 : length(r),
    
    f = f0 / r(k);
    disp(f);
    
    s = generateSinWave_(A, f, fs, duration, theta );
    
    sound( s, fs );
    pause( duration + interval );
    
end;



