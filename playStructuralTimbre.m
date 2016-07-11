clear;
%close all;


%fs = 44100;
fs = 96000;

duration = 10.0;
%duration = 2^19/fs;

%interval = duration;
interval = 1.0;


%N = 1;
%N = 3;
%N = 30;
N = 100;
%N = 300;
%N = 3000;

S = zeros( round( fs * duration ), 1 );

A = ones( N, 1 );
f = zeros( N, 1 );
theta = zeros( N, 1 );

AAvg = 1.0;


nTest = 5;
%nTest = 1;


fBase = 110;
%fBase = 110 * 2^6;

for i = 1 : nTest,
    fAvg( i ) = fBase * 2^i;
end;

thetaAvg = 0.0;


fCentre = 10^3 * (2 .^ [-6:4]);
fD = 2^(1/2);
fUpper = fCentre * fD;
fLower = fCentre / fD;


for i = 1 : length( fAvg ),
    
    for j = 1 : length( fCentre ),
        if ( fLower( j ) <= fAvg( i ) ) continue; end;
        if ( fAvg( i ) < fUpper( j ) ) j = j - 1; break; end;
    end;
    
    
    fScale( i ) = 2^( j-4 );
    fDelta( i ) = fUpper( j ) - fLower( j );
    fSigma( i ) = fAvg( i ) / fDelta( i ) * fScale( i );
    
    
    flagAmplitude = true;
    flagFrequency = true;
    flagPhase = false;
    
    flagSort = false;
    flagSortAfter = true;
    
    
    if ( flagAmplitude ),
        %A = rand( 1, N ) * AMax;
        %A = ( randn( 1, N ) + 1.0 ) * ( AMax - AMin ) + AMin;
        [ A, ARndType ] = pearsrnd( AAvg, 1, 0, 3, N, 1);
    end;
    
    if ( flagFrequency ),
        %f = rand( 1, N ) * ( fMax - fMin ) + fMin;
        %f = ( randn( 1, N ) + 1.0 ) * ( fMax - fMin ) + fMin;
        [ f, fRndType ] = pearsrnd( fAvg( i ), fSigma( i ), 0, 3, N, 1);
    end;
    
    if ( flagPhase ),
        %theta = rand( 1, N ) * 2 * pi;
        %theta = randn( 1, N ) * 2 * pi;
        [ theta, tRndType ] = pearsrnd( thetaAvg, 1, 0, 3, N, 1);
        theta = theta .* pi;
    end;
    
    
    if ( flagSort ),
        parfor i = 1 : N,
            s = generateSinWave_( A(i), f(i), fs, duration, theta(i) );
            S = S + s;
        end;
        S1 = S;
    end;
    
    
    if ( flagSort ),
        A = sort( A );
        f = sort( f );
        theta = sort( theta );
    end;
    
    
    parfor i = 1 : N,
        s = generateSinWave_( A(i), f(i), fs, duration, theta(i) );
        S = S + s;
    end;
    
    
    if ( flagSort ),
        S2 = S;
        Sdiff = S1 - S2;
    end;
    
    
    w = hann( length( S ) );
    S = S / max( S );
    %w = hann( length( S ) );
    S = S .* w;
    
    
    sound( S, fs );
    pause( duration + interval );
    
    
    if ( flagSortAfter ),
        A = sort( A );
        f = sort( f );
        theta = sort( theta );
    end;
    

    ARec( i, : ) = A; 
    fRec( i, : ) = f; 
    thetaRec( i, : ) = theta; 
    
end;