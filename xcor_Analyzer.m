%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
%%%%
%%%% xcor_Analyzer() : author : TAISO, Renpoo (170205)
%%%%

function results = xcor_Analyzer( handles )

graphTitle = handles.data.graphTitle;
x0 = handles.soundSignals.x0;
y0 = handles.soundSignals.y0;
fs = handles.data.fs;
timeS0 = handles.data.timeS0;
timeE0 = handles.data.timeE0;
tau = handles.data.timeT;
unitScale = handles.data.xUnitScale;
LRCflag = handles.data.LRCflag;


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
    'dateTime',      '',  ...
    'paramsMat',     [],  ...
    'tauE_Vec_R',          [], ...
    'env_tauE_Vec_R',      [], ...
    'grad_env_tauE_Vec_R', [], ...
    'tauE_Vec_L',          [], ...
    'env_tauE_Vec_L',      [], ...
    'grad_env_tauE_Vec_L', [], ...
    'timeS0',         0,  ...
    'timeE0',         0,  ...    
    'xLabelStr',     '',  ...
    'yLabelStr',     '',  ...
    'zLabelStr',     '',  ...
    'graphTitle',    '',  ...
    'rWavChLabel',   '',  ...
    'lWavChLabel',   '',  ...
    'rWavFileName',  '',  ...
    'lWavFileName',  ''  ...
    );


%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
%%%%
%%%% MAIN Procedure
%%%%

[ ~, dateTime ] = system('date +%y%m%d%H%M%S');
dateTime = dateTime( 1 : length( dateTime ) - 1 );


if (LRCflag == 'C')
    funcStr = 'ICCF';
else
    funcStr = 'ACF';
end


bufSize = 10;


timeS0_Idx = convTime2Index_( timeS0, fs );
timeE0_Idx = convTime2Index_( timeE0, fs ) - 1;
tau_Idx    = convTime2Index_( tau, fs );


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

paramsMat    = {};


if ( handles.data.applyWindowFuncFlag )
    if ( handles.data.windowFuncMode == 1 )
        windowFunc = hann( tau_Idx + 1 );
    elseif ( handles.data.windowFuncMode == 2 )
        windowFunc = hamming( tau_Idx + 1 );        
    elseif ( handles.data.windowFuncMode == 3 )
        windowFunc = blackman( tau_Idx + 1 );
    else
        windowFunc = rectwin( tau_Idx + 1 );
    end
end




k = 0;

for t_Idx = timeS0_Idx : tau_Idx : timeE0_Idx
    
    k = k + 1;
    
    timeS_Idx_now = t_Idx;
    timeE_Idx_now = timeS_Idx_now + tau_Idx;
    
    
    xSub = x0( timeS_Idx_now : timeE_Idx_now );
    ySub = y0( timeS_Idx_now : timeE_Idx_now );
    
    if ( handles.data.applyWindowFuncFlag )
        xSub = xSub .* windowFunc;
        ySub = ySub .* windowFunc;
    end

    
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
        
    phi_lr = PHI_lr / PHI_ll_0 / PHI_rr_0;


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
        zeroIdxs = zeroIdxs';
        
        
        ICCC = NaN;
        tauICCC = NaN;
        Wiccc = NaN;
        tauAlpha = NaN;
        tauBeta = NaN;
        
        params = zeros( 4, 7 );
        
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
        
        tauAlpha = tauAxis( max( tauAlphaIdx, 1 ) );
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
results.paramsMat    = paramsMat;
results.timeS0       = timeS0;
results.timeE0       = timeE0;
results.LRCflag      = LRCflag;
results.xLabelStr    = strcat( handles.data.xLabelStr, ' [', handles.data.xUnitStr, ']' );
results.yLabelStr    = strcat( handles.data.yLabelStr, ' [', handles.data.yUnitStr, ']' );
results.zLabelStr    = funcStr;
results.graphTitle   = graphTitle;
results.rWavChLabel  = handles.data.rWavChLabel;
results.lWavChLabel  = handles.data.lWavChLabel;
results.rWavFileName = handles.data.rWavFileName;
results.lWavFileName = handles.data.lWavFileName;

end
