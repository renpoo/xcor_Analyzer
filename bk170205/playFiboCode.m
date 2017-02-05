clear;
close all;


%L = 1 / 261.6255653005986; % : C
L = 1 / 440; % : A : 440 Hz


%A = 1.0;
A = 0.3;

theta = 0.0;

fs = 44100;
%fs = 96000;

duration1 = 0.3;
duration2 = 3.0;
%duration = 0.5;
%duration = 2^19/fs;

%interval = duration;
interval1 = 0.1;
interval2 = 0.5;


% Change "n" for number of iteration on fibonatch series
n = 10 + 2;
%n = 2; % Special Number for Skipping Fibonacci Generator

%{
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
%}


Fibo = [ lucas_Un( 1, -1, (1:n) ) ];
%Fibo = [ lucas_Vn( 3, 2, (1:n) ) ];


r = [];
f0 = 1 / L;


for j = 1 : length(Fibo)-2,
    fprintf( 'Iteration: %d times\n', j );
    
    
    r = [ Fibo(j+2), Fibo(j+1), Fibo(j) ] / ( Fibo(j) + Fibo(j+1) + Fibo(j+2) ) * 2;
    
    %r = [ 8/8, 5/8, 3/8 ];
    %r = [ 16/16, 8/16, 5/16, 3/16 ];
    %r = [ 21/21, 13/21, 5/21, 3/21 ];
    %r = [ 8/21, 5/21, 5/21, 3/21 ];
    
    %r = [ 30/30, 24/30, 20/30, 15/30 ]; % C,E,G,C
    
    
    %{
    Max = 30;
    for l = 1 : Max,
        r( l ) = l / Max;
    end;
    %}
    
    
    %A = ( A - 0.01 ) / length(r) ;
    
    S = zeros( round( fs * duration2 ), 1 );
    
    for k = 1 : length(r),
        
        f = f0 / r(k);
        fprintf( 'Scale: %s (%04.2f Hz) for ratio "%02.1f/%02.1f"\n', ConvertScaleToString_( ConvertHertzToScale_(f) ), f, Fibo( j+3-k ), Fibo( j+2 ) );
        
        s = generateSinWave_(A, f, fs, duration2, theta );
        
        
        
        S = S + s;
        
        s_tmp = generateSinWave_(A, f, fs, duration1, theta );
        
        if ( 1 ),
            %w1 = HanningWindow_( length( s ) );
            w1 = hann( length( s ) )';
            s = s .* w1';
            S = S .* w1';

            %w2 = HanningWindow_( length( s_tmp ) );
            w2 = hann( length( s_tmp ) )';
            s_tmp = s_tmp .* w2';
        end;
        
        if ( 0 ),
            sound( s_tmp, fs );
            pause( duration1 + interval1 );
        end;
        
        %{
        if ( k == 2 ),
            fTmp = f;
        end;
        %}
    end;
    
    sound( S, fs );
    pause( duration2 + interval2 );
    
    disp(' ');
    
    %f0 = fTmp;
end;
