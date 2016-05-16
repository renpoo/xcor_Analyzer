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
interval = 0.5;


% Change "n" for number of iteration on fibonatch series
%n = 5;
n = 2; % Special Number for Skipping Fibonacci Generator 


a = 1;
b = 1;

Fibo( 1 ) = a;
Fibo( 2 ) = b;

for ( i = 2 : n ),
    tmp = a;
    a = b;
    b = tmp + b;
    Fibo = [ Fibo b ];
end;


r = [];
f0 = 1 / L;


for j = 1 : length(Fibo)-2,
    
    %r = [ Fibo(j+2), Fibo(j+1), Fibo(j) ] / ( Fibo(j) + Fibo(j+1) + Fibo(j+2) ) * 2;
    
    r = [ 8/8, 5/8, 3/8 ];
    %r = [ 16/16, 8/16, 5/16, 3/16 ];
    %r = [ 21/21, 13/21, 5/21, 3/21 ];
    %r = [ 8/21, 5/21, 5/21, 3/21 ];
    
    %r = [ 30/30, 24/30, 20/30, 15/30 ]; % C,E,G,C

    
    Max = 30;
    for l = 1 : Max,
        r( l ) = l / Max;
    end;
    
    
    
    A = ( A - 0.01 ) / length(r) ;
    
    S = zeros( round( fs * duration ), 1 );
    
    for k = 1 : length(r),
        
        f = f0 / r(k);
        disp(f);
        
        s = generateSinWave_(A, f, fs, duration, theta );
        S = S + s;
        
        sound( s, fs );
        pause( duration + interval );
        
        if ( k == 2 ),
            fTmp = f;
        end;
    end;
    
    sound( S, fs );
    pause( duration + interval );
    
    f0 = fTmp;
end;


