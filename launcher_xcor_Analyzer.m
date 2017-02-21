

clear;

%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%%

timeS0 = 0.0;
%timeS0 = 100.0;
%timeS0 = 200.0;
%timeE0 = 2.0;
timeE0 = 10.0;
%timeE0 = 20.0;
%timeE0 = 30.0;
%timeE0 = 60.0;
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


eps = 1.0 * 10^-3;


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




rightHalf_phi_lrMat = results.phi_lrMat( : , floor ( 1 + size( results.phi_lrMat, 2 ) / 2 ) : size( results.phi_lrMat, 2 ) );
[ maxValVec_R, tauE_Vec_R, tauEidx_Vec_R ] = pickUp_peaks_( abs( rightHalf_phi_lrMat - clipVal ), eps, fs );
[ env_tauE_Vec_R, env_tauE_Idx_R ] = getEnvelope_( tauE_Vec_R );
grad_env_tauE_Vec_R = gradient( env_tauE_Vec_R );
% figure;plot( tauE_Vec_R );
% figure;plot( env_tauE_Vec_R );
% figure;plot( grad_env_tauE_Vec_R );

hold on;

clipValVec = ones( 1, length( results.timeAxis ) ) * clipVal;

lw = 2;
ms = 3;
lc = '-ow';
plot3( env_tauE_Vec_R * unitScale, results.timeAxis, clipValVec, lc, 'LineWidth', lw, 'MarkerSize', ms );

hold off;
