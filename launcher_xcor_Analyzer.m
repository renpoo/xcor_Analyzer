

clear;

%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%%

timeS0 = 0.0;
%timeS0 = 100.0;
%timeS0 = 200.0;
%timeE0 = 2.0;
%timeE0 = 10.0;
%timeE0 = 20.0;
%timeE0 = 30.0;
timeE0 = 60.0;
%timeE0 = 110.0;
%timeE0 = 240.0;

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

lenX0 = length(x0);
lenY0 = length(y0);

duration = lenX0 / fs;

x0 = vectorReshape_( x0, lenX0 * 2 );
y0 = vectorReshape_( y0, lenY0 * 2 );


timeE0 = min( timeE0, duration );


TMPtimeS0_Idx = convTime2Index_( timeS0, fs );
TMPtimeE0_Idx = convTime2Index_( timeE0, fs ) - 1;

x0cut = x0( TMPtimeS0_Idx : TMPtimeE0_Idx );
y0cut = y0( TMPtimeS0_Idx : TMPtimeE0_Idx );
% x0cut = x0( TMPtimeS0_Idx : length( x0 ) );
% y0cut = y0( TMPtimeS0_Idx : length( y0 ) );

sCut = s( TMPtimeS0_Idx : TMPtimeE0_Idx, : );

sound( sCut, fs );



%results = Laplace_Analyzer( wavFilename, timeS0, timeE0, tau, unitScale, LRCflag );

results = xcor_Analyzer( wavFilename, x0, y0, fs, timeS0, timeE0, tau, unitScale, LRCflag, clipVal );
