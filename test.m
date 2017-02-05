clear;

%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 

timeS = 0.0;
timeE = 10.0;

tau = 0.01;
%tau = 0.1;
%tau = 1.0;


wavFilename = 'Nippon.m4a';


%LRflag = 'L';
%LRflag = 'R';
LRflag = 'C';

%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 


if (LRflag == 'C')
    funcStr = 'ICCF';
else
    funcStr = 'ACF';
end


[ s, fs ] = audioread( strcat( './_Sounds/', wavFilename ) );


x0 = s( :, 2 );  % L channel
y0 = s( :, 1 );  % R channel


duration = length(x0) / fs;

timeS_Idx = convTime2Index_( timeS, fs );
timeE_Idx = convTime2Index_( timeE, fs ) - 1;
tau_Idx   = convTime2Index_( tau, fs );

xCut = x0( timeS_Idx : timeE_Idx )';
yCut = y0( timeS_Idx : timeE_Idx )';

sound( xCut, fs );

timeS_Idx_now = timeS_Idx;
timeE_Idx_now = timeS_Idx_now + tau_Idx;

xSub = x0( timeS_Idx_now : timeE_Idx_now )';
ySub = y0( timeS_Idx_now : timeE_Idx_now )';


k = 0;

timeAxis = ( timeS_Idx : tau_Idx : timeE_Idx ) / fs;


if (LRflag == 'L')
    tauAxis  = ( -tau_Idx : 0 ) / fs;
elseif (LRflag == 'R')
    tauAxis  = ( 0 : +tau_Idx ) / fs;
else
    tauAxis  = ( -tau_Idx : tau_Idx ) / fs;
end


lenTimeAxis = length( timeAxis );
lenTauAxis  = length( tauAxis );


phi_lr_Mat = [];
%phi_lr_Mat = zeros( lenTimeAxis, lenTauAxis );


%detXY = initial_PHI_xy_( xSub, ySub );


for t_Idx = timeS_Idx : tau_Idx : timeE_Idx
    timeS_Idx_now = timeS_Idx + t_Idx;
    timeE_Idx_now = timeS_Idx_now + tau_Idx;
    
    xSub = x0( timeS_Idx_now : timeE_Idx_now )';
    ySub = y0( timeS_Idx_now : timeE_Idx_now )';
    
    
    if (LRflag == 'L')
        PHI_lr   = PHI_xy_( xSub, xSub, LRflag );
        detXY = init_PHI_( xSub )^2;
    elseif (LRflag == 'R')
        PHI_lr   = PHI_xy_( ySub, ySub, LRflag );
        detXY = init_PHI_( ySub )^2;
    else
        PHI_lr   = PHI_xy_( xSub, ySub, LRflag );
        detXY = init_PHI_( xSub ) * init_PHI_( ySub );
    end
    
    
    phi_lr   = PHI_lr / detXY;
    
    %figure; plot(phi_lr);
    
    %fprintf( 1, '(%d, %d) = %d [%d]\n', timeS_Idx_now, timeE_Idx_now, timeE_Idx_now - timeS_Idx_now, length(phi_lr) );
    
    
    
    [ICCC, pointICCC] = max( phi_lr );
    tauICCC = tauAxis( pointICCC );
    
    
    phi_lr_subtracted = phi_lr - 0.9 * ICCC;
    
    [ maxValues, maxIdxs, zeroIdxs ] = zero_cross_(phi_lr_subtracted, 1, (LRflag ~= 'C') );
    maxIdxs = maxIdxs( 1 : length(maxIdxs) );
    maxTimes = convIndex2Time_( maxIdxs, fs ) * tau ;
    
    tauAlphaIdx = zeroIdxs(1);
    tauBetaIdx  = zeroIdxs(2);
    
    tauAlpha = tauAxis( tauAlphaIdx );
    tauBeta  = tauAxis( tauBetaIdx  );
    
    Wiccc = tauBeta - tauAlpha;
    
    
    params = zeros( 4, 7 );
    
    params( 1, 1 ) = tauICCC;
    params( 1, 2 ) = tauICCC;
    params( 1, 3 ) = 0;
    params( 1, 4 ) = ICCC;
    params( 1, 5 ) = 1;
    params( 1, 6 ) = 0;
    params( 1, 7 ) = 0;
    
    params( 2, 1 ) = tauAlpha;
    params( 2, 2 ) = tauBeta;
    params( 2, 3 ) = 0.9*ICCC;
    params( 2, 4 ) = 0.9*ICCC;
    params( 2, 5 ) = 1;
    params( 2, 6 ) = 0.6;
    params( 2, 7 ) = 0;
    
    params( 3, 1 ) = tauAlpha;
    params( 3, 2 ) = tauAlpha;
    params( 3, 3 ) = -1;
    params( 3, 4 ) = 1;
    params( 3, 5 ) = 0;
    params( 3, 6 ) = 0.6;
    params( 3, 7 ) = 0;
    
    params( 4, 1 ) = tauBeta;
    params( 4, 2 ) = tauBeta;
    params( 4, 3 ) = -1;
    params( 4, 4 ) = 1;
    params( 4, 5 ) = 0;
    params( 4, 6 ) = 0.6;
    params( 4, 7 ) = 0;
    
    
    k = k + 1;
    phi_lr_Mat( k, : )    = phi_lr;
    PHI_ll_0Mat( k, : )   = init_PHI_( xSub );
    PHI_rr_0Mat( k, : )   = init_PHI_( ySub );
    PHI_lrMat( k, : )     = PHI_lr;
    
    maxValuesMat( k, : )  = maxValues;
    maxIdxsMat( k, : )    = maxIdxs;
    zeroIdxsMat( k, : )   = zeroIdxs;
    maxTimesMat( k, : )   = maxTimes;
    
    timeS_IdxMat( k, : )     = timeS_Idx;
    timeE_IdxMat( k, : )     = timeE_Idx;
    
    ICCCMat( k, : )       = ICCC;
    tauICCCMat( k, : )    = tauICCC;
    WicccMat( k, : )      = Wiccc;
end


figure;

XYZ = surf( tauAxis, timeAxis, phi_lr_Mat, 'FaceColor','interp', 'LineStyle', 'none' );
colormap 'jet';


if (LRflag == 'L')
    xmax = 0;
    xmin = -max( abs( tauAxis ) );
elseif (LRflag == 'R')
    xmax = max( abs( tauAxis ) );
    xmin = 0;
else
    xmax = max( abs( tauAxis ) );
    xmin = -xmax;
end

xlim([xmin xmax]);


grid on;


hold on;


if ( LRflag == 'C' )
    lc = 'ow';
    lw = 2;
    ms = 3;
    
    plot3( tauICCCMat', timeAxis, ICCCMat', lc, 'LineWidth', lw, 'MarkerSize', ms );
    
    
end


xLabelStr = 'tau';
yLabelStr = 'time';
zLabelStr = funcStr;

if ( strcmp( funcStr, 'ACF' ) )
    zLabelStr = strcat( zLabelStr, ' [', LRflag, '] ' );
end

xlabel( xLabelStr );
ylabel( yLabelStr );
zlabel( zLabelStr );

strTitle = strcat( zLabelStr, ' "', wavFilename, '" ' );
title( strTitle );

hold off;
