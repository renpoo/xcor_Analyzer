function [ results ] = calc_ICCF_(graphTitle, x, y, fs, bits, tS0, tE0, tS, tE, tStart, tStop, time_T, windowSize, windowSizeIdx, xLabel, yLabel, saveImageName, dateTime, flags )

%pkg load signal;
%pkg load io;

%tauEnd = 1.0 / 1000; % [s] : End of calcuration interval for nACF

if (flags.castSignalFlag),
  x = x - mean(x);
  y = y - mean(y);
end;

lenX = length(x);
lenY = length(y);


duration = lenX / fs;  %duration (of input signal)


resultData  = zeros( windowSizeIdx, 1 );
resultData2 = zeros( windowSizeIdx, 1 );
tmpResultData = zeros( windowSizeIdx, 1 );
params = [];

%tic();

ICCC = 0.0;
pointiccc = 0.0;
tauICCC = 0.0;
tauAlpha = 0.0;
tauBeta = 0.0;
Alpha = 0.0;
Beta = 0.0;
resultData2 = [];
Wiccc = 0.0;


if (flags.iccfFlag),
  funcStr = 'ICCF';
  
  limitSize = convTime2Index_( (tStop - tStart), x, fs );
  if ( lenX < limitSize ), limitSize = lenX; end;
  
  if (flags.phiFlag),
    PHI_ll_0 = PHI_xy_( 0, duration, x, x );
    PHI_rr_0 = PHI_xy_( 0, duration, y, y );
    PHI_lr   = PHI_xy_( tStop, duration, x, y );
    phi_lr   = PHI_lr / sqrt( PHI_ll_0 * PHI_rr_0 );
  else 
    phi_lr   = IACF_( tStop, duration, x, y );
  end;

  resultData = phi_lr; % iccf
  timeAxis = create_timeAxis_( tStart, tStop, length(resultData), duration );

  [ICCC, pointiccc] = max( resultData(:) );
  tauICCC = timeAxis( pointiccc );

  
  resultData2 = resultData(:) - 0.9*ICCC;


  if (1),  
    [ maxValues, maxIdxs, zeroIdxs ] = zero_cross_(resultData2, 1, ~flags.iccfFlag);
    maxIdxs = maxIdxs( 1 : length(maxIdxs) );
    maxTimes = convIndex2Time_( maxIdxs, x, fs ) * 1000 ;
    
    tauAlphaIdx = zeroIdxs(1);
    tauBetaIdx  = zeroIdxs(2);
  
    tauAlpha = timeAxis( tauAlphaIdx );
    tauBeta  = timeAxis( tauBetaIdx  );
  
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

                   
    strTitleBase = strcat( '[', yLabel, ' <-> ', xLabel, ']', ' (' ,  num2str(tS, '%04.3f'), '-', num2str(tE, '%04.3f'), '), [T : ', num2str(time_T, '%04.2f'), ' ]' );
    strTitle = strcat( strTitleBase, ', ICCC= ', num2str(ICCC), ', tauICCC= ', num2str(tauICCC), ', Wiccc= ', num2str(Wiccc) );

    end;
end;
%toc();


if (flags.plotFlag),
  plot_graph_( resultData, timeAxis, saveImageName, funcStr, strTitle, xLabel, yLabel, params, graphTitle, dateTime, tS0, tE0, tS, tE );
end;


results.resultData = resultData;
results.timeAxis   = timeAxis;
results.maxValues  = maxValues;
results.maxIdxs    = maxIdxs;
results.maxTimes   = maxTimes;
results.zeroIdxs   = zeroIdxs;
results.ICCC       = ICCC;
results.tauICCC    = tauICCC;
results.Wiccc      = Wiccc;
results.PHI_ll_0   = PHI_ll_0;
results.PHI_rr_0   = PHI_rr_0;
results.PHI_lr     = PHI_lr;
results.phi_lr     = phi_lr;
