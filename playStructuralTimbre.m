clear;
%close all;


%fs = 44100;
fs = 96000;

duration = 10.0;
%duration = 2^19/fs;

%interval = duration;
interval = 0.5;


%N = 1;
%N = 3;
%N = 30;
N = 100;
%N = 300;
%N = 3000;


A = ones( 1, N );
f = zeros( 1, N );
theta = zeros( 1, N );

AMin = 0.7;
AMax = 1.0;
Aavg = 1.0;
A = A .* AMax; 

%fMin = 1024 - (1024 - 992) / 2;
%fMax = 1024;
%fMin = 440 - (440 - 420) / 2;
%fMax = 440;
fAvg = 1024;

thetaAvg = 0.0;


flagAmplitude = false;
flagFrequency = true;
flagPhase = false;

flagSort = true;


if ( flagAmplitude ),
    %A = rand( 1, N ) * AMax;
    %A = ( randn( 1, N ) + 1.0 ) * ( AMax - AMin ) + AMin;
    A = pearsrnd( Aavg, 1, 0, 3, N, 1);
end;

if ( flagFrequency ),
    %f = rand( 1, N ) * ( fMax - fMin ) + fMin;
    %f = ( randn( 1, N ) + 1.0 ) * ( fMax - fMin ) + fMin;
    f = pearsrnd( fAvg, 10, 0, 3, N, 1);
end;

if ( flagPhase ),
    %theta = rand( 1, N ) * 2 * pi;
    %theta = randn( 1, N ) * 2 * pi;
    theta = pearsrnd( thetaAvg, 1, 0, 3, N, 1) * pi;
end;

%{
parfor i = 1 : N,
    s = generateSinWave_( A(i), f(i), fs, duration, theta(i) );
    S = S + s;
end;

S1 = S;
%}


if ( flagSort ),
    A = sort( A );
    f = sort( f );
    theta = sort( theta );
end;


S = zeros( round( fs * duration ), 1 );


parfor i = 1 : N,
    s = generateSinWave_( A(i), f(i), fs, duration, theta(i) );
    S = S + s;
end;


%{
S2 = S;
Sdiff = S1 - S2;
%}


w = hann( length( S ) );
S = S / max( S );
%w = hann( length( S ) );
S = S .* w;

sound( S, fs );
