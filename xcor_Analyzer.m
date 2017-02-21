%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
%%%%
%%%% xcor_Analyzer() : author : TAISO, Renpoo (170205)
%%%%

function results = xcor_Analyzer( wavFilename, x0, y0, fs, timeS0, timeE0, tau, unitScale, LRCflag, clipVal )


%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
%%%%
%%%% Temporary Starter
%%%%

%{
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
    'ICCCMat',       [],  ...
    'tauICCCMat',    [],  ...
    'WicccMat',      [],  ...
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


if (LRCflag == 'C')
    funcStr = 'ICCF';
else
    funcStr = 'ACF';
end


bufSize = 10;


%[ s, fs ] = audioread( strcat( './_Sounds/', wavFilename ) );


% x0 = s( :, 2 );  % L channel
% y0 = s( :, 1 );  % R channel


%duration = length(x0) / fs;

timeS0_Idx = convTime2Index_( timeS0, fs );
%timeE0_Idx = convTime2Index_( timeE0, fs ) + 1;
timeE0_Idx = convTime2Index_( timeE0, fs ) - 1;
tau_Idx   = convTime2Index_( tau, fs );

%xCut = x0cut( timeS0_Idx : timeE0_Idx )';
%yCut = y0cut( timeS0_Idx : timeE0_Idx )';


%sound( xCut, fs );


%timeS_Idx_now = timeS0_Idx;
%timeE_Idx_now = timeS_Idx_now + tau_Idx;

%xSub = x0cut( timeS_Idx_now : timeE_Idx_now )';
%ySub = y0cut( timeS_Idx_now : timeE_Idx_now )';


% lenX0cut = lenX0 / 2;
% lenY0cut = lenY0 / 2;


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

% tmp1 = floor( lenX0cut / lenTauAxis ) + 1;
% 
% disp( tmp1 ); 
% 
% tmp2 = lenTauAxis * tmp1;
% 
% disp( tmp2 );

%lenPackedX0cut = lenTauAxis * ( ceil( lenX0cut / lenTauAxis ) * 2 );
% x0filled = vectorReshape_( x0cut, lenPackedX0cut );
% y0filled = vectorReshape_( y0cut, lenPackedX0cut );
% x0filled = x0cut;
% y0filled = y0cut;


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


% xSub         = zeros( lenTauAxis, 1 );
% ySub         = zeros( lenTauAxis, 1 );


%detXY = initial_PHI_xy_( xSub, ySub );


cnt = 0;

k = 0;

for t_Idx = timeS0_Idx : tau_Idx : timeE0_Idx

    k = k + 1;
    
%    cnt = timeS0_Idx + k * lenTauAxis;

%    fprintf( 1, '%d (%d)\n', k, cnt );
    
%    disp( t_Idx );

    timeS_Idx_now = t_Idx;
    timeE_Idx_now = timeS_Idx_now + tau_Idx;
    %timeE_Idx_now = min( timeS_Idx_now + tau_Idx, timeE0_Idx );

    
%     xSub = zeros( lenTauAxis, 1 );
%     ySub = zeros( lenTauAxis, 1 );
%     xSub = vectorReshape_( x0filled( timeS_Idx_now : timeE_Idx_now ), lenTauAxis );
%     ySub = vectorReshape_( y0filled( timeS_Idx_now : timeE_Idx_now ), lenTauAxis );
%    xSub = x0cut( timeS_Idx_now : timeE_Idx_now );
%    ySub = y0cut( timeS_Idx_now : timeE_Idx_now );
    xSub = x0( timeS_Idx_now : timeE_Idx_now );
    ySub = y0( timeS_Idx_now : timeE_Idx_now );
%     xSub = x0filled( timeS_Idx_now : timeE_Idx_now );
%     ySub = y0filled( timeS_Idx_now : timeE_Idx_now );    

    
    if (LRCflag == 'L')
        PHI_ll_0 = init_PHI_( xSub );
        PHI_rr_0 = PHI_ll_0;
        PHI_lr   = PHI_xy_( xSub, xSub, LRCflag );
    elseif (LRCflag == 'R')
        PHI_ll_0 = init_PHI_( ySub );
        PHI_rr_0 = PHI_ll_0;
        PHI_lr   = PHI_xy_( ySub, ySub, LRCflag );
    else
        PHI_ll_0 = init_PHI_( xSub );
        PHI_rr_0 = init_PHI_( ySub );
        PHI_lr   = PHI_xy_( xSub, ySub, LRCflag );
    end
    
    
    %phi_lr = zeros( lenTauAxis, 1 );    
    
%    phi_lr   = vectorReshape_( PHI_lr / PHI_ll_0 / PHI_rr_0, lenTauAxis );
    phi_lr = PHI_lr / PHI_ll_0 / PHI_rr_0;
    
    
    %figure; plot(phi_lr);
    
%    fprintf( 1, '(%d, %d) = %d [%d]\n', timeS_Idx_now, timeE_Idx_now, timeE_Idx_now - timeS_Idx_now, length(phi_lr) );
    
    
    
    [ICCC, pointICCC] = max( phi_lr );
    tauICCC = tauAxis( min( pointICCC, lenTauAxis ) );
    
    
    phi_lr_subtracted = phi_lr - 0.9 * ICCC;
    
    
    if (LRCflag == 'L' || LRCflag == 'R' )
        [ maxValues, maxIdxs, zeroIdxs ] = zero_cross_( phi_lr, 0, 1 );
        maxValues = maxValues( 2 : length( maxValues ) );
        maxIdxs = maxIdxs( 2 : length( maxIdxs ) );
        maxTimes = convIndex2Time_( maxIdxs, fs );
        if (LRCflag == 'L')
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
        zeroIdxs = zeroIdxs';
        
        tauAlphaIdx = zeroIdxs(1);
        tauBetaIdx  = zeroIdxs(2);
        
        tauAlpha = tauAxis( min( tauAlphaIdx, 1 ) );
        tauBeta  = tauAxis( min( tauBetaIdx, lenTauAxis ) );
        
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
%%%% Calculate The Meta Information from the obtained resutls
%%%%


if ( LRCflag == 'R' || LRCflag == 'C' )
    rightHalf_phi_lrMat = phi_lrMat( : , floor ( 1 + size( phi_lrMat, 2 ) / 2 ) : size( phi_lrMat, 2 ) );
    
    [ maxValVec_R, tauE_Vec_R, tauEidx_Vec_R ] = pickUp_peaks_( abs( rightHalf_phi_lrMat - clipVal ), eps, fs );
    [ env_tauE_Vec_R, env_tauE_Idx_R ] = getEnvelope_( tauE_Vec_R );
    grad_env_tauE_Vec_R = gradient( env_tauE_Vec_R );
end

if ( LRCflag == 'L' || LRCflag == 'C' )
    leftHalf_phi_lrMat = phi_lrMat( : , 1 : floor ( 1 + size( phi_lrMat, 2 ) / 2 ) );
    reverseIdx = ( size( leftHalf_phi_lrMat, 2 ) : -1 : 1 );
    leftHalf_phi_lrMat = leftHalf_phi_lrMat( : , reverseIdx );
    
    [ maxValVec_L, tauE_Vec_L, tauEidx_Vec_L ] = pickUp_peaks_( abs( leftHalf_phi_lrMat - clipVal ), eps, fs );
    [ env_tauE_Vec_L, env_tauE_Idx_L ] = getEnvelope_( tauE_Vec_L );
    grad_env_tauE_Vec_L = gradient( env_tauE_Vec_L );
end;


%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
%%%%
%%%% For returning the results
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
%%%% Plot Each time dependent ACF or ICCF surface for entire results
%%%%

figure;

XYZ = surf( tauAxis, timeAxis, phi_lrMat, 'FaceColor','interp', 'LineStyle', 'none' );
colormap 'jet';


if (LRCflag == 'L')
    xmax = 0;
    xmin = -max( abs( tauAxis ) );
elseif (LRCflag == 'R')
    xmax = max( abs( tauAxis ) );
    xmin = 0;
else
    xmax = max( abs( tauAxis ) );
    xmin = -xmax;
end

xlim([xmin xmax]);


grid on;


hold on;


lc = 'ow';
lw = 2;
ms = 3;


if ( LRCflag == 'C' )
    plot3( tauICCCMat', timeAxis, ICCCMat', lc, 'LineWidth', lw, 'MarkerSize', ms );
end


xLabelStr = 'tau [ms]';
yLabelStr = 'time [s]';
zLabelStr = funcStr;

if ( strcmp( funcStr, 'ACF' ) )
    zLabelStr = strcat( zLabelStr, ' [', LRCflag, '] ' );
end

xlabel( xLabelStr );
ylabel( yLabelStr );
zlabel( zLabelStr );

strTitle = strcat( '(', wavFilename, '),', zLabelStr, ',', 't[', num2str(timeS0, '%04.2f'), ' - ', num2str(timeE0, '%04.2f'), ']' );

title( strTitle );


clipValVec = ones( 1, lenTimeAxis ) * clipVal;

% if ( 0 )
%     lc = '-ow';
%     
%     if ( LRCflag == 'R' || LRCflag == 'C' )
%         plot3(  tauE_Vec_R * unitScale, timeAxis, clipValVec, lc, 'LineWidth', lw, 'MarkerSize', ms );
%     end
%     
%     if ( LRCflag == 'L' || LRCflag == 'C' )
%         plot3( -tauE_Vec_L * unitScale, timeAxis, clipValVec, lc, 'LineWidth', lw, 'MarkerSize', ms );
%     end
% end
% 
% if ( 1 )
%     if ( LRCflag == 'R' || LRCflag == 'C' )
%         lc = '-or';
%         lc = '-ow';
%         plot3( env_tauE_Vec_R * unitScale, timeAxis, clipValVec, lc, 'LineWidth', lw, 'MarkerSize', ms );
%     end
%     
%     if ( LRCflag == 'L' || LRCflag == 'C' )
%         lc = '-ob';
%         lc = '-ow';
%         plot3( -env_tauE_Vec_L * unitScale, timeAxis, clipValVec, lc, 'LineWidth', lw, 'MarkerSize', ms );
%     end
% end
% 
% if ( 0 )
%     if ( LRCflag == 'R' || LRCflag == 'C' )
%         lc = '-oy';
%         lc = '-ow';
%         plot3( grad_env_tauE_Vec_R * unitScale, timeAxis, clipValVec, lc, 'LineWidth', lw, 'MarkerSize', ms );
%     end
%     
%     if ( LRCflag == 'L' || LRCflag == 'C' )
%         lc = '-og';
%         lc = '-ow';
%         plot3( -grad_env_tauE_Vec_L * unitScale, timeAxis, clipValVec, lc, 'LineWidth', lw, 'MarkerSize', ms );
%     end
% end


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


% if ( 0 )
%     for i = 1 : k
%         plot_graph_everyMoment_( phi_lrMat( i, : ), tauAxis, wavFilename, dateTime, xLabelStr, zLabelStr, timeS0, timeE0, tau, timeAxis( i ), paramsMat{ i } );
%     end
% end

%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%

%end
