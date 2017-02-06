%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% 
%%%%
%%%% Laplace_Analyzer() : author : TAISO, Renpoo (170205)
%%%%

function results = Laplace_Analyzer( wavFilename, timeS0, timeE0, tau, unitScale, LRflag )


%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% 
%%%%
%%%% Temporary Starter
%%%%

%{
clear;

timeS0 = 1.0;
timeE0 = 2.0;

tau = 0.01;

unitScale = 1000;

wavFilename = 'Nippon.m4a';

%LRflag = 'L';
%LRflag = 'R';
LRflag = 'C';
%}

%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% 
%%%%
%%%% Define the results structure
%%%%

results = struct(      ...
    'PHI_ll_0Mat',   [],  ...
    'PHI_rr_0Mat',   [],  ...
    'PHI_lrMat',     [],  ...
    'phi_lrMat',     [],  ...
    'timeAxis',      [],  ...
    'tauAxis',       [],  ...
    'maxValuesMat',  [],  ...
    'maxIdxsMat',    [],  ...
    'maxTimesMat',   [],  ...
    'zeroIdxsMat',   [],  ...
    'ICCCMat',        0,  ...
    'tauICCCMat',     0,  ...
    'WicccMat',       0,  ...
    'tauAlphaMat',   [],  ...
    'tauBetaMat',    [],  ...
    'dateTime',       ''  ...
    );


%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% 
%%%%
%%%% MAIN Procedure
%%%%

[ temp, dateTime ] = system('date +%y%m%d%H%M%S');
dateTime = dateTime( 1 : length( dateTime ) - 1 );


if (LRflag == 'C')
    funcStr = 'ICCF';
else
    funcStr = 'ACF';
end


bufSize = 10;


[ s, fs ] = audioread( strcat( './_Sounds/', wavFilename ) );


x0 = s( :, 2 );  % L channel
y0 = s( :, 1 );  % R channel


%duration = length(x0) / fs;

timeS0_Idx = convTime2Index_( timeS0, fs );
timeE0_Idx = convTime2Index_( timeE0, fs ) + 1;
%timeE0_Idx = convTime2Index_( timeE0, fs ) - 1;
tau_Idx   = convTime2Index_( tau, fs );

xCut = x0( timeS0_Idx : timeE0_Idx )';
%yCut = y0( timeS0_Idx : timeE0_Idx )';


sound( xCut, fs );


%timeS_Idx_now = timeS0_Idx;
%timeE_Idx_now = timeS_Idx_now + tau_Idx;

%xSub = x0( timeS_Idx_now : timeE_Idx_now )';
%ySub = y0( timeS_Idx_now : timeE_Idx_now )';


k = 0;

timeAxis = ( timeS0_Idx : tau_Idx : timeE0_Idx ) / fs;


if (LRflag == 'L')
    tauAxis  = ( -tau_Idx : 0 );
    %tauAxis  = ( 0 : +tau_Idx );
elseif (LRflag == 'R')
    tauAxis  = ( 0 : +tau_Idx );
else
    tauAxis  = ( -tau_Idx : tau_Idx );
end
tauAxis = tauAxis / fs * unitScale;


lenTimeAxis = length( timeAxis );
lenTauAxis  = length( tauAxis );


%phi_lrMat = [];
phi_lrMat    = zeros( lenTimeAxis, lenTauAxis );
PHI_lrMat    = zeros( lenTimeAxis, lenTauAxis );
PHI_ll_0Mat  = zeros( lenTimeAxis, 1 );
PHI_rr_0Mat  = zeros( lenTimeAxis, 1 );

zeroIdxsMat  = zeros( lenTimeAxis, bufSize );
maxValuesMat = zeros( lenTimeAxis, bufSize );
maxIdxsMat   = zeros( lenTimeAxis, bufSize );
maxTimesMat  = zeros( lenTimeAxis, bufSize );

timeS_IdxMat = zeros( lenTimeAxis, 1 );
timeE_IdxMat = zeros( lenTimeAxis, 1 );

ICCCMat      = zeros( lenTimeAxis, 1 );
tauICCCMat   = zeros( lenTimeAxis, 1 );
WicccMat     = zeros( lenTimeAxis, 1 );

tauAlphaMat  = zeros( lenTimeAxis, 1 );
tauBetaMat   = zeros( lenTimeAxis, 1 );


%detXY = initial_PHI_xy_( xSub, ySub );


for t_Idx = timeS0_Idx : tau_Idx : timeE0_Idx
    timeS_Idx_now = timeS0_Idx + t_Idx;
    timeE_Idx_now = timeS_Idx_now + tau_Idx;
    
    xSub = x0( timeS_Idx_now : timeE_Idx_now )';
    ySub = y0( timeS_Idx_now : timeE_Idx_now )';
    
    
    if (LRflag == 'L')
        PHI_ll_0 = init_PHI_( xSub );
        PHI_rr_0 = PHI_ll_0;
        PHI_lr   = PHI_xy_( xSub, xSub, LRflag );
    elseif (LRflag == 'R')
        PHI_ll_0 = init_PHI_( ySub );
        PHI_rr_0 = PHI_ll_0;
        PHI_lr   = PHI_xy_( ySub, ySub, LRflag );
    else
        PHI_ll_0 = init_PHI_( xSub );
        PHI_rr_0 = init_PHI_( ySub );
        PHI_lr   = PHI_xy_( xSub, ySub, LRflag );
    end
    
    
    phi_lr   = PHI_lr / PHI_ll_0 / PHI_rr_0;
    
    
    %figure; plot(phi_lr);
    
    %fprintf( 1, '(%d, %d) = %d [%d]\n', timeS_Idx_now, timeE_Idx_now, timeE_Idx_now - timeS_Idx_now, length(phi_lr) );
    
    
    
    [ICCC, pointICCC] = max( phi_lr );
    tauICCC = tauAxis( pointICCC );
    
    
    phi_lr_subtracted = phi_lr - 0.9 * ICCC;
    
        
    if (LRflag == 'L' || LRflag == 'R' )
        [ maxValues, maxIdxs, zeroIdxs ] = zero_cross_( phi_lr, 0, 1 );
        maxValues = maxValues( 2 : length( maxValues ) );
        maxIdxs = maxIdxs( 2 : length( maxIdxs ) );
        maxTimes = convIndex2Time_( maxIdxs, fs );
        if (LRflag == 'L')
            maxTimes = maxTimes - tau;
        end
        maxTimes = maxTimes * unitScale;
        
        
        ICCC = NaN;
        tauICCC = NaN;
        Wiccc = NaN;        
        tauAlpha = NaN;
        tauBeta = NaN;
        
        params = zeros( length( maxValues ), 7 );
        for i = 1 : length( maxValues )
            if ( i > 4 )
                continue;
            end

            params( i, 1 ) = maxTimes( i );
            params( i, 2 ) = maxTimes( i );
            params( i, 3 ) = 0;
            params( i, 4 ) = maxValues( i );
            params( i, 5 ) = 1;
            params( i, 6 ) = 0;
            params( i, 7 ) = 0;
        end
    else
        [ maxValues, maxIdxs, zeroIdxs ] = zero_cross_( phi_lr_subtracted, 1, 0 );
        maxIdxs = maxIdxs( 1 : length( maxIdxs ) );
        maxTimes = convIndex2Time_( maxIdxs, fs );
        
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
    end
    
    
    k = k + 1;
    phi_lrMat(    k, : ) = vectorReshape_( phi_lr, lenTauAxis );
    PHI_lrMat(    k, : ) = vectorReshape_( PHI_lr, lenTauAxis );
    PHI_ll_0Mat(  k, 1 ) = PHI_ll_0;
    PHI_rr_0Mat(  k, 1 ) = PHI_rr_0;
    
    zeroIdxsMat(  k, : ) = vectorReshape_( zeroIdxs,  bufSize );
    maxValuesMat( k, : ) = vectorReshape_( maxValues, bufSize );
    maxIdxsMat(   k, : ) = vectorReshape_( maxIdxs,   bufSize );
    maxTimesMat(  k, : ) = vectorReshape_( maxTimes,  bufSize );
    
    timeS_IdxMat( k, 1 ) = timeS_Idx_now;
    timeE_IdxMat( k, 1 ) = timeE_Idx_now;
    
    ICCCMat(      k, 1 ) = ICCC;
    tauICCCMat(   k, 1 ) = tauICCC;
    WicccMat(     k, 1 ) = Wiccc;
    
    tauAlphaMat(  k, 1 ) = tauAlpha;
    tauBetaMat(   k, 1 ) = tauBeta;
    
    paramsMat(    k, : ) = { params };
end


%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% 
%%%%
%%%% Plot Each time dependent ACF or ICCF surface for entire resutls
%%%%

results.PHI_ll_0Mat  = PHI_ll_0Mat;
results.PHI_rr_0Mat  = PHI_rr_0Mat;
results.PHI_lrMat    = PHI_lrMat;
results.phi_lrMat    = phi_lrMat;
results.tauAxis      = tauAxis;
results.timeAxis     = timeAxis;
results.maxValuesMat = maxValuesMat;
results.maxIdxsMat   = maxIdxsMat;
results.maxTimesMat  = maxTimesMat;
results.zeroIdxsMat  = zeroIdxsMat;
results.ICCCMat      = ICCCMat;
results.tauICCCMat   = tauICCCMat;
results.WicccMat     = WicccMat;
results.tauAlphaMat  = tauAlphaMat;
results.tauBetaMat   = tauBetaMat;
results.dateTime     = dateTime;


%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% 
%%%%
%%%% Plot Each time dependent ACF or ICCF surface for entire resutls
%%%%

figure;

XYZ = surf( tauAxis, timeAxis, phi_lrMat, 'FaceColor','interp', 'LineStyle', 'none' );
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


xLabelStr = 'tau [ms]';
yLabelStr = 'time [s]';
zLabelStr = funcStr;

if ( strcmp( funcStr, 'ACF' ) )
    zLabelStr = strcat( zLabelStr, ' [', LRflag, '] ' );
end

xlabel( xLabelStr );
ylabel( yLabelStr );
zlabel( zLabelStr );

strTitle = strcat( '(', wavFilename, '),', zLabelStr, ',', 't[', num2str(timeS0, '%04.2f'), ' - ', num2str(timeE0, '%04.2f'), ']' );

title( strTitle );

hold off;


pnameImg = strcat( '_Output Images', '/', '(', wavFilename, '),', zLabelStr, ',', dateTime, ',', 'timeS0,', num2str(timeS0, '%04.2f'), ',', 'timeE0,', num2str(timeE0, '%04.2f'), ',', 'tau,', num2str(tau, '%04.3f') );
if ( exist( pnameImg, 'dir' ) == 0 )
    mkdir( pnameImg );
end

saveImageName = strcat( '(', wavFilename, '),', zLabelStr, ',timeS0,', num2str(timeS0, '%04.2f'), ',', 'timeE0,', num2str(timeE0, '%04.2f'), ',', 'tau,', num2str(tau, '%04.3f') );

fname = strcat( saveImageName, '.fig');
outputDataFileName = strcat( pnameImg, '/', fname );
saveas( 1, strcat( outputDataFileName ) );


%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% 
%%%%
%%%% Plot Each ACF or ICCF graph at every moments
%%%%


if ( 0 )
    for i = 1 : k
        plot_graph_everyMoment_( phi_lrMat( i, : ), tauAxis, wavFilename, dateTime, xLabelStr, zLabelStr, timeS0, timeE0, tau, timeAxis( i ), paramsMat{ i } );
    end
end

%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% 

end
