%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
%%%%
%%%% launcher_xcor_Analyzer() : author : TAISO, Renpoo (170221)
%%%%

clear;

%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%%


unitScale = 1000;
duration = 234.2400;

timeS0 = 0.0;
%timeS0 = 100.0;
%timeS0 = 200.0;

%timeE0 = 6.0;
timeE0 = 11.5;
%timeE0 = 20.0;
%timeE0 = 30.0;
%timeE0 = 60.0;
%timeE0 = 110.0;
%timeE0 = 240.0;

%tau = 0.001;

%LRCflag = 'L';
LRCflag = 'R';
tau = 0.01;
eps = tau * 0.1;
cutOffFreq = 10.0 / tau; % Hz
LPFflag = 0;
minPeakDist = 8;
pickUpScale = duration * tau;


% LRCflag = 'C';
% tau = 0.01;
% eps = tau * 0.1;
% cutOffFreq = 10.0 / tau; % Hz
% LPFflag = 0;
% minPeakDist = 8;
% pickUpScale = 1.0;


% %LRCflag = 'L';
% LRCflag = 'R';
% tau = 0.1;
% eps = tau * 0.01;
% cutOffFreq = 100.0 / tau; % Hz
% LPFflag = 1;
% minPeakDist = 1;

% tau = 1.0;
% eps = tau * 0.1;
% cutOffFreq = 10000.0 / tau; % Hz





wavFilename = 'Nippon.m4a';


clipVal = 0.2;


%eps = 1.0 * 10^-4;
%eps = 5.0 * 10^-4;
%eps = 1.0 * 10^-3;
%eps = 1.0 * 10^-2;
%eps = 5.0 * 10^-2;
%eps = 1.0 * 10^-1;

%eps = tau * 0.1;
%eps = tau * 10;
%eps = tau;


%cutOffFreq = 1; % Hz
%cutOffFreq = 2; % Hz
%cutOffFreq = 3; % Hz
%cutOffFreq = 10; % Hz
%cutOffFreq = 50; % Hz
%cutOffFreq = 100; % Hz
%cutOffFreq = 200; % Hz
%cutOffFreq = 250; % Hz
%cutOffFreq = 500; % Hz
%cutOffFreq = 1000; % Hz
%cutOffFreq = 5000; % Hz
%cutOffFreq = 10000; % Hz
%cutOffFreq = 22000; % Hz

%cutOffFreq = 100.0 / tau; % Hz
%cutOffFreq = 50.0 / tau; % Hz
%cutOffFreq = 40.0 / tau; % Hz
%cutOffFreq = 30.0 / tau; % Hz
%cutOffFreq = 20.0 / tau; % Hz
%cutOffFreq = 10.0 / tau; % Hz
%cutOffFreq = 5.0 / tau; % Hz
%cutOffFreq = 1.0 / tau; % Hz
%cutOffFreq = 0.5 / tau; % Hz
%cutOffFreq = 0.1 / tau; % Hz




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

% x0cut = x0( TMPtimeS0_Idx : TMPtimeE0_Idx );
% y0cut = y0( TMPtimeS0_Idx : TMPtimeE0_Idx );
% x0cut = x0( TMPtimeS0_Idx : length( x0 ) );
% y0cut = y0( TMPtimeS0_Idx : length( y0 ) );

sCut = s( TMPtimeS0_Idx : TMPtimeE0_Idx, : );

sound( sCut, fs );



%results = Laplace_Analyzer( wavFilename, timeS0, timeE0, tau, unitScale, LRCflag );

%results = xcor_Analyzer( wavFilename, x0, y0, fs, timeS0, timeE0, tau, unitScale, LRCflag, clipVal );
results = xcor_Analyzer( wavFilename, x0, y0, fs, timeS0, timeE0, tau, unitScale, LRCflag );



%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
%%%%
%%%%
%%%%

if ( LPFflag == 1 )
    fNorm = cutOffFreq / ( fs / 2 );
    df = designfilt('lowpassfir','FilterOrder',70,'CutoffFrequency',fNorm);
    %grpdelay( df, 2048, fs );
    D = mean( grpdelay( df ) );
end

if ( LRCflag == 'R' || LRCflag == 'C' )
    rightHalf_phi_lrMat = results.phi_lrMat( : , floor ( 1 + size( results.phi_lrMat, 2 ) / 2 ) : size( results.phi_lrMat, 2 ) );
    clipped_rightHalf_phi_lrMat = ( rightHalf_phi_lrMat );
    
    m = size( clipped_rightHalf_phi_lrMat, 1 );
    n = size( clipped_rightHalf_phi_lrMat, 2 );
    
    for i = 1 : m
        for j = n : -1 : 1
            if ( clipped_rightHalf_phi_lrMat( i, j ) <= eps + clipVal )
                clipped_rightHalf_phi_lrMat( i, j ) = 0.0;
            end
        end
    end
    
    %[ maxValVec_R, tauE_Vec_R, tauEidx_Vec_R ] = pickUp_peaks_( abs( rightHalf_phi_lrMat - clipVal ), eps, fs );
    [ maxValVec_R, tauE_Vec_R, tauEidx_Vec_R ] = pickUp_peaks_( clipped_rightHalf_phi_lrMat, eps, fs, pickUpScale );
    
    if ( LPFflag == 1 )
        env_tauE_Vec_R = filter( df, [ tauE_Vec_R'; zeros(D,1) ] );
        env_tauE_Vec_R = env_tauE_Vec_R( D+1 : end );
    else
        [ env_tauE_Vec_R, env_tauE_Idx_R ] = getEnvelope_( tauE_Vec_R, minPeakDist );
    end
    
    grad_env_tauE_Vec_R = gradient( env_tauE_Vec_R );
    
    
    %figure; plot( env_tauE_Vec_R );
end

if ( LRCflag == 'L' || LRCflag == 'C' )
    leftHalf_phi_lrMat = results.phi_lrMat( : , 1 : floor ( 1 + size( results.phi_lrMat, 2 ) / 2 ) );
    reverseIdx = ( size( leftHalf_phi_lrMat, 2 ) : -1 : 1 );
    leftHalf_phi_lrMat = leftHalf_phi_lrMat( : , reverseIdx );
    clipped_leftHalf_phi_lrMat = ( leftHalf_phi_lrMat - clipVal );

    m = size( clipped_leftHalf_phi_lrMat, 1 );
    n = size( clipped_leftHalf_phi_lrMat, 2 );
    
    for i = 1 : m
        for j = n : -1 : 1
            if ( clipped_leftHalf_phi_lrMat( i, j ) <= eps + clipVal )
                clipped_leftHalf_phi_lrMat( i, j ) = 0.0;
            end
        end
    end
    
    
    %[ maxValVec_L, tauE_Vec_L, tauEidx_Vec_L ] = pickUp_peaks_( abs( leftHalf_phi_lrMat - clipVal ), eps, fs );
    [ maxValVec_L, tauE_Vec_L, tauEidx_Vec_L ] = pickUp_peaks_( clipped_leftHalf_phi_lrMat, eps, fs, pickUpScale );
    
    if ( LPFflag == 1 )
        env_tauE_Vec_L = filter( df, [ tauE_Vec_L'; zeros(D,1) ] );
        env_tauE_Vec_L = env_tauE_Vec_L( D+1 : end );
    else
        [ env_tauE_Vec_L, env_tauE_Idx_L ] = getEnvelope_( tauE_Vec_L, minPeakDist );
    end
    
    grad_env_tauE_Vec_L = gradient( env_tauE_Vec_L );
    
    
    %figure; plot( env_tauE_Vec_L );
end;







% figure;plot( tauE_Vec_R );
% figure;plot( env_tauE_Vec_R );
% figure;plot( grad_env_tauE_Vec_R );

hold on;

clipValVec = ones( 1, length( results.timeAxis ) ) * clipVal;

lw = 2;
ms = 3;
lc = '-ow';

if ( LRCflag == 'R' || LRCflag == 'C' )
    lc = '-w';
    plot3(  tauE_Vec_R * unitScale, results.timeAxis, clipValVec, lc, 'LineWidth', lw, 'MarkerSize', ms );
    
    lc = '-r';
    plot3(  env_tauE_Vec_R * unitScale, results.timeAxis, clipValVec + 0.1, lc, 'LineWidth', lw, 'MarkerSize', ms );
end

if ( LRCflag == 'L' || LRCflag == 'C' )
    lc = '-w';
    plot3( -tauE_Vec_L * unitScale, results.timeAxis, clipValVec, lc, 'LineWidth', lw, 'MarkerSize', ms );
    
    lc = '-b';
    plot3( -env_tauE_Vec_L * unitScale, results.timeAxis, clipValVec + 0.1, lc, 'LineWidth', lw, 'MarkerSize', ms );
end

hold off;
