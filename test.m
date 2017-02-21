clear;

%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%%
timeS0 = 200.0;
%timeE0 = 2.0;
%timeE0 = 10.0;
%timeE0 = 20.0;
timeE0 = 240.0;

%tau = 0.001;
tau = 0.01;
%tau = 0.1;
%tau = 1.0;

unitScale = 1000;


wavFilename = 'Nippon.m4a';


%LRCflag = 'L';
%LRCflag = 'R';
LRCflag = 'C';


clipVal = 0.2;


[ s, fs ] = audioread( strcat( './_Sounds/', wavFilename ) );

x0 = s( :, 2 );  % L channel
y0 = s( :, 1 );  % R channel

x0 = vectorReshape_( x0, length( x0 ) * 2 );
y0 = vectorReshape_( y0, length( y0 ) * 2 );


timeS0_Idx = convTime2Index_( timeS0, fs );
timeE0_Idx = convTime2Index_( timeE0, fs ) + 1;
tau_Idx   = convTime2Index_( tau, fs );

timeAxis = ( timeS0_Idx : tau_Idx : timeE0_Idx ) / fs;

if (LRCflag == 'L')
    tauAxis  = ( -tau_Idx : 0 );
    %tauAxis  = ( 0 : +tau_Idx );
elseif (LRCflag == 'R')
    tauAxis  = ( 0 : +tau_Idx );
else
    tauAxis  = ( -tau_Idx : tau_Idx );
end

tauAxis = tauAxis / fs * unitScale;


lenTimeAxis = length( timeAxis );
lenTauAxis  = length( tauAxis );


lenX0 = length( x0 );
maxTimeE0_Idx = min( lenX0, timeE0_Idx + lenTauAxis );

xCut = x0( timeS0_Idx : maxTimeE0_Idx );
yCut = y0( timeS0_Idx : maxTimeE0_Idx );
% xCut = vectorReshape_( x0( timeS0_Idx : maxTimeE0_Idx ), lenTauAxis * lenTimeAxis );
% yCut = vectorReshape_( y0( timeS0_Idx : maxTimeE0_Idx ), lenTauAxis * lenTimeAxis );


sCutTmp = s( timeS0_Idx : timeE0_Idx );

sound( sCutTmp, fs );


%results = Laplace_Analyzer( wavFilename, timeS0, timeE0, tau, unitScale, LRCflag );

results = xcor_Analyzer( wavFilename, xCut, yCut, fs, timeS0, timeE0, tau, unitScale, LRCflag, clipVal );
