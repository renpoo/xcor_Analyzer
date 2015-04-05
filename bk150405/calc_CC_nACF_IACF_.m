function calc_CC_nACF_IACF_(x, y, fs, bits, tS, tE, xLabel, yLabel, saveImageName, dumpFlag, debugFlag, plotFlag, ccfFlag, nacfFlag, nacfAndoFlag, iacfFlag, phiFlag, fileDlgFlag, castSignalFlag)

pkg load signal;
pkg load io;

tauEnd = 1.0 / 1000; # [s] : End of calcuration interval for nACF

if (castSignalFlag),
  x = x - mean(x);
  y = y - mean(y);
endif;

lenX = length(x);
#lenY = length(y);


duration = lenX / fs;  %duration (of input signal)


resultData = [];
params = [];

tic();
if (ccfFlag),
  funcStr = "nCCF";
  tStart  = 0.0;
  tStop   = 100.0 / 1000;
  limitSize = convTime2Index_( (tStop - tStart), x, fs );
  rxy = nCCF_( x( 1:limitSize ), y( 1:limitSize ) );
  resultData = rxy; # nCCF
  timeAxis = create_timeAxis_( tStart, tStop, length(resultData), duration );
endif;


if (nacfFlag),
  funcStr = "nACF";
  tStart  = 0.0;
  tauEnd = 5.0 / 1000; # [s] : OVERRIDE
  tStop   = +tauEnd;
  limitSize = convTime2Index_( (tStop - tStart), x, fs );
  if (nacfAndoFlag),
    phi_p = nACF_ANDO_( (tStop - tStart), duration, x, x );
  else 
    phi_p = nACF_( x( 1:limitSize ) );
  endif;
  resultData = phi_p; # nACF
  timeAxis = create_timeAxis_( tStart, tStop, length(resultData), duration );

  
  [ maxValues, maxIdxs, zeroIdxs ] = zero_cross_(resultData, 0);
  maxValues = maxValues( 2 : length(maxValues) );
  maxIdxs = maxIdxs( 2 : length(maxIdxs) );
  maxTimes = convIndex2Time_( maxIdxs, x, fs ) * 1000 ;


  params = zeros( length(maxValues), 7 );
  for ( i = 1 : length(maxValues) ),
    params( i, 1 ) = maxTimes( i );
    params( i, 2 ) = maxTimes( i );
    params( i, 3 ) = -1;
    params( i, 4 ) = 1;
    params( i, 5 ) = 1;
    params( i, 6 ) = 0.6;
    params( i, 7 ) = 0;
  endfor;


  if (0),
  disp(xLabel);
  disp(maxValues);
  disp(maxIdxs);
  disp(zeroIdxs);
  disp(maxTimes);
  disp( params );
  endif;
  
  
  strTitle = [ xLabel, ', ', funcStr ];
    
endif;


IACC = 0.0;
pointIACC = 0.0;
tauIACC = 0.0;
tauAlpha = 0.0;
tauBeta = 0.0;
Alpha = 0.0;
Beta = 0.0;
resultData2 = [];
Wiacc = 0.0;


if (iacfFlag),
  funcStr = "IACF";
  tauEnd = 5.0 / 1000; # [s] : OVERRIDE
  tStart  = -tauEnd;
  tStop   = +tauEnd;
  limitSize = convTime2Index_( (tStop - tStart), x, fs );
  if (phiFlag),
    PHI_ll_0 = PHI_xy_( 0, duration, x, x );
    PHI_rr_0 = PHI_xy_( 0, duration, y, y );
    PHI_lr   = PHI_xy_( tauEnd, duration, x, y );
    phi_lr   = PHI_lr / sqrt( PHI_ll_0 * PHI_rr_0 );
  else 
    phi_lr   = IACF_( tauEnd, duration, x, y );
  endif;
  resultData = phi_lr; # IACF
  timeAxis = create_timeAxis_( tStart, tStop, length(resultData), duration );

  [IACC, pointIACC] = max( resultData(:) );
  tauIACC = timeAxis( pointIACC );
  

  #resultData2 = abs( resultData(:) - 0.9*IACC );
  resultData2 = ( resultData(:) - 0.9*IACC );


  if (1),  
    [ maxValues, maxIdxs, zeroIdxs ] = zero_cross_(resultData2, 1);
    maxIdxs = maxIdxs( 1 : length(maxIdxs) );
    maxTimes = convIndex2Time_( maxIdxs, x, fs ) * 1000 ;
    
    tauAlphaIdx = zeroIdxs(1);
    tauBetaIdx  = zeroIdxs(2);
  
    #[tauAlphaIdx, Alpha] = min( resultData2( Alpha:pointIACC ) );
    #[tauBetaIdx,  Beta ] = min( resultData2( pointIACC:Beta ) );
    #Beta = Beta + pointIACC - 1;
    tauAlpha = timeAxis( tauAlphaIdx );
    tauBeta  = timeAxis( tauBetaIdx  );
  
    #WiaccIdx = Beta - Alpha;
    #Wiacc = duration * WiaccIdx / lenX;
    Wiacc = tauBeta - tauAlpha;

  
    params = zeros( 4, 7 );

    params( 1, 1 ) = tauIACC;
    params( 1, 2 ) = tauIACC;
    params( 1, 3 ) = 0;
    params( 1, 4 ) = IACC;
    params( 1, 5 ) = 1;
    params( 1, 6 ) = 0;
    params( 1, 7 ) = 0;

    params( 2, 1 ) = tauAlpha;
    params( 2, 2 ) = tauBeta;
    params( 2, 3 ) = 0.9*IACC;
    params( 2, 4 ) = 0.9*IACC;
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

    
    if (0),
    disp(xLabel);
    disp(yLabel);
    disp("maxValues");
    disp(maxValues);
    disp("maxIdxs");
    disp(maxIdxs);
    disp("zeroIdxs");
    disp(zeroIdxs);
    disp("maxTimes");
    disp(maxTimes);
    disp( params );
    endif;

    
    strTitle = [ yLabel, "/" xLabel, ', IACC= ', num2str(IACC), ', tauIACC= ', num2str(tauIACC), ', Wiacc= ', num2str(Wiacc) ];

    endif;
endif;
toc();


if (plotFlag),
  plot_graph_( resultData, timeAxis, saveImageName, funcStr, strTitle, xLabel, yLabel, params );
endif;


if (dumpFlag),
  dump_outputData_( outputData, funcStr );
endif;

