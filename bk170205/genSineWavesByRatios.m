function S = genSineWavesByRatios( r, L, A, theta, fs, duration, interval )

S = zeros( round( fs * duration ), 1 );
f0 = 1 / L;

for k = 1 : length(r),

    f = f0 / r(k);
    disp(f);
    
    s = generateSinWave_(A, f, fs, duration, theta );
    S = S + s;

    sound( s, fs );
    pause( duration + interval );
end;
