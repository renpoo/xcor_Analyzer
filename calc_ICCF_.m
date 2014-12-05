function [ resultData, timeAxis, maxValues, maxIdxs, maxTimes, zeroIdxs, ICCC, tauICCC, Wiccc, PHI_ll_0, PHI_rr_0, PHI_lr, phi_lr ] = calc_ICCF_(graphTitle, x, y, fs, bits, tS, tE, tStart, tStop, windowSize, windowSizeIdx, xLabel, yLabel, saveImageName, dumpFlag, debugFlag, plotFlag, ccfFlag, nacfFlag, nacfAndoFlag, iccfFlag, phiFlag, fileDlgFlag, castSignalFlag, dateTime)

pkg load signal;
pkg load io;

#tauEnd = 1.0 / 1000; # [s] : End of calcuration interval for nACF

if (castSignalFlag),
  x = x - mean(x);
  y = y - mean(y);
endif;

lenX = length(x);
lenY = length(y);


duration = lenX / fs;  %duration (of input signal)


resultData  = zeros( windowSizeIdx, 1 );
resultData2 = zeros( windowSizeIdx, 1 );
tmpResultData = zeros( windowSizeIdx, 1 );
params = [];

tic();

ICCC = 0.0;
pointiccc = 0.0;
tauICCC = 0.0;
tauAlpha = 0.0;
tauBeta = 0.0;
Alpha = 0.0;
Beta = 0.0;
resultData2 = [];
Wiccc = 0.0;


if (iccfFlag),
  funcStr = "ICCF";
  limitSize = convTime2Index_( (tStop - tStart), x, fs );
  if (phiFlag),
    PHI_ll_0 = PHI_xy_( 0, duration, x, x );
    PHI_rr_0 = PHI_xy_( 0, duration, y, y );
    #PHI_lr   = arraySubstitute_( PHI_xy_( tauEnd, duration, x, y ), limitSize );
    PHI_lr   = PHI_xy_( tStop, duration, x, y );
    phi_lr   = PHI_lr / sqrt( PHI_ll_0 * PHI_rr_0 );
    #PHI_lr   = arraySubstitute_( PHI_xy_( tStop, duration, x, y ), limitSize );
    #phi_lr   = arraySubstitute_( PHI_lr / sqrt( PHI_ll_0 * PHI_rr_0 ), limitSize );
  else 
    phi_lr   = aIACF_( tStop, duration, x, y );
    #phi_lr   = arraySubstitute_( IACF_( tStop, duration, x, y ), limitSize );
  endif;
  #tmpResultData = phi_lr; # iccf
  resultData = phi_lr; # iccf
  #timeAxis = create_timeAxis_( tStart, tStop, length(tmpResultData), duration );
  timeAxis = create_timeAxis_( tStart, tStop, length(resultData), duration );
  #timeAxis = create_timeAxis_( tStart, tStop, windowSizeIdx, duration );

  [ICCC, pointiccc] = max( resultData(:) );
  tauICCC = timeAxis( pointiccc );

  
  #resultData = arraySubstitute_( tmpResultData, windowSizeIdx );


  #resultData2 = abs( resultData(:) - 0.9*ICCC );
  resultData2 = resultData(:) - 0.9*ICCC;
  #for n = 1 : windowSizeIdx,
  #for n = 1 : length(resultData),
  #  resultData2(n) = resultData(n) - (0.9*ICCC);
  #endfor;


  if (1),  
    [ maxValues, maxIdxs, zeroIdxs ] = zero_cross_(resultData2, 1, !iccfFlag);
    maxIdxs = maxIdxs( 1 : length(maxIdxs) );
    maxTimes = convIndex2Time_( maxIdxs, x, fs ) * 1000 ;
    
    tauAlphaIdx = zeroIdxs(1);
    tauBetaIdx  = zeroIdxs(2);
  
    #[tauAlphaIdx, Alpha] = min( resultData2( Alpha:pointiccc ) );
    #[tauBetaIdx,  Beta ] = min( resultData2( pointiccc:Beta ) );
    #Beta = Beta + pointiccc - 1;
    tauAlpha = timeAxis( tauAlphaIdx );
    tauBeta  = timeAxis( tauBetaIdx  );
  
    #WicccIdx = Beta - Alpha;
    #Wiccc = duration * WicccIdx / lenX;
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

                   
    strTitleBase = strcat( '[', yLabel, ' <-> ', xLabel, ']', ' (' ,  num2str(tS, "%5.2f"), '-', num2str(tE, "%5.2f"), ')' );
    strTitle = strcat( strTitleBase, ', ICCC= ', num2str(ICCC), ', tauICCC= ', num2str(tauICCC), ', Wiccc= ', num2str(Wiccc) );

    endif;
endif;
toc();


if (plotFlag),
  plot_graph_( resultData, timeAxis, saveImageName, funcStr, strTitle, xLabel, yLabel, params, graphTitle, dateTime, tS, tE );
endif;


#if (dumpFlag),
if (0),
  dump_data_( resultData, 'resultData', funcStr, saveImageName, graphTitle, dateTime );
  dump_data_( timeAxis,   'timeAxis',   funcStr, saveImageName, graphTitle, dateTime );
  dump_data_( maxValues,  'maxValues',  funcStr, saveImageName, graphTitle, dateTime );
  dump_data_( maxIdxs,    'maxIdxs',    funcStr, saveImageName, graphTitle, dateTime );
  dump_data_( zeroIdxs,   'zeroIdxs',   funcStr, saveImageName, graphTitle, dateTime );
  dump_data_( maxTimes,   'maxTimes',   funcStr, saveImageName, graphTitle, dateTime );
  dump_data_( tS,         'tS',         funcStr, saveImageName, graphTitle, dateTime );
  dump_data_( tE,         'tE',         funcStr, saveImageName, graphTitle, dateTime );

  if (phiFlag),
    dump_data_( PHI_ll_0,   'PHI_ll_0',   funcStr, saveImageName, graphTitle, dateTime );
    dump_data_( PHI_rr_0,   'PHI_rr_0',   funcStr, saveImageName, graphTitle, dateTime );
    dump_data_( PHI_lr,     'PHI_lr',     funcStr, saveImageName, graphTitle, dateTime );
    dump_data_( phi_lr,     'phi_lr',     funcStr, saveImageName, graphTitle, dateTime );
  endif;
  dump_data_( ICCC,       'ICCC',       funcStr, saveImageName, graphTitle, dateTime );
  dump_data_( tauICCC,    'tauICCC',    funcStr, saveImageName, graphTitle, dateTime );
  dump_data_( Wiccc,      'Wiccc',      funcStr, saveImageName, graphTitle, dateTime );

  #dump_outputData_( resultData, funcStr );
endif;

