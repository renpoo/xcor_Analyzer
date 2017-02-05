function [ A, f, theta, idx ] = funcPlayStructuralTimbre( fs, duration, interval, ...
    nSpikes, ...
    AMean, ASigma, ASkew, AKurt, ...
    fMean, fSigma, fSkew, fKurt, ...
    thetaMean, thetaSigma, thetaSkew, thetaKurt, ...
    flagAmplitude, flagFrequency, flagPhase, flagSortAfter )

N = nSpikes;

S = zeros( round( fs * duration ), 1 );

A = ones( N, 1 );
f = zeros( N, 1 );
theta = zeros( N, 1 );

idx = 1 : N;

if ( flagAmplitude ),
    [ A, ARndType ] = pearsrnd( AMean, ASigma, ASkew, AKurt, N, 1);
end;

if ( flagFrequency ),
    [ f, fRndType ] = pearsrnd( fMean, fSigma, fSkew, fKurt, N, 1);
end;

if ( flagPhase ),
    [ theta, tRndType ] = pearsrnd( thetaMean, thetaSigma, thetaSkew, thetaKurt, N, 1);
    theta = theta .* pi;
end;


parfor k = 1 : N,
    s = generateSinWave_( A(k), f(k), fs, duration, theta(k) );
    S = S + s;
end;


w = hann( length( S ) );
S = S / max( S );
S = S .* w;


Nmax = 100;
g = loud_weight( [ fMean, 12500 ], 65 ); % Equal Loudoness Contour
%S = S / g( 1 ) / 2; % Volume Adaption
S = S / g( 1 ) * N / Nmax; % Volume Adaption


sound( S, fs );
pause( duration + interval );
audiowrite( strcat('./_Sounds/ST__', num2str( N ), 'spikes__', num2str( fMean ), 'Hz_', num2str( fSigma ), '_', num2str( fSkew ), '_', num2str( fKurt ), '.wav'), S, fs );


%plotPeriodogram_( S, fs );


if ( flagSortAfter ),
    A = sort( A );
    f = sort( f );
    theta = sort( theta );
end;
