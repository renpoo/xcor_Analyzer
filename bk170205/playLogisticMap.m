clear;

%[ s0, fs ] = audioread( 'drum.wav' );

fs = 44100;

N = 20;

MaxNum = 30;

sc = 0.1;

alphaStart = 0.01;
alphaEnd = 4.00;

A = 1 / N / 2;

duration = 3;
interval = 1;


fBase = 440;


for i = 1 : MaxNum+1,
    %disp( i );
    
    %alpha = i / MaxNum * (alphaEnd - alphaStart) + alphaStart;
    alpha = (i-1) / MaxNum * (alphaEnd - alphaStart) + alphaStart;
    disp( alpha );
    
    %duration = 0.3 * (alpha + 1);
    
    %Answer( i, : ) = sort( LogisticMap( alpha, N ) );
    Answer( i, : ) = LogisticMap( alpha, N );
    
    %continue;
    
    S = zeros( round( fs * duration ), 1 );
    
    for j = 1 : N,
        if ( 0 ),
            pause( Answer( i, j ) * sc );
            sound( s0, fs );
        end;
        
        if ( 1 ),
            S = S + generateSinWave_(A, Answer( i, j ) * fBase + fBase, fs, duration, 0 );
        end;
    end;
    
    if ( 1 ),
        w = HanningWindow_( length( S ) );
        sound( S .* w', fs );
        pause( duration + interval );
    end;
end;

