function [ resultData, timeAxis, maxValues, maxIdxs, maxTimes, zeroIdxs ] = calc_nACF_(graphTitle, x, y, fs, bits, tS, tE, tStart, tStop, windowSize, windowSizeIdx, xLabel, yLabel, saveImageName, dateTime, flags )

#pkg load signal;
#pkg load io;

tauEnd = 1.0 / 1000; # [s] : End of calcuration interval for nACF

if (flags.castSignalFlag),
  x = x - mean(x);
  y = y - mean(y);
endif;

lenX = length(x);
#lenY = length(y);


duration = lenX / fs;  %duration (of input signal)


resultData  = zeros( windowSizeIdx, 1 );
resultData2 = zeros( windowSizeIdx, 1 );
tmpResultData = zeros( windowSizeIdx, 1 );
params = [];
strTitle = "";
strTitleBase = "";

tic();
if (flags.nacfFlag),
  funcStr = "nACF";
  tStart  = 0.0;  ### CAUTION!!! ###
  limitSize = convTime2Index_( (tStop - tStart), x, fs );
  if (flags.nacfAndoFlag),
    phi_p = nACF_ANDO_( (tStop - tStart), duration, x, x );
    #phi_p = arraySubstitute_( nACF_ANDO_( (tStop - tStart), duration, x, x ), limitSize );
  else 
    phi_p = nACF_( x( 1:limitSize ) );
    #phi_p = arraySubstitute_( nACF_( x( 1:limitSize ) ), limitSize );
  endif;
  resultData = phi_p; # nACF
  #tmpResultData = phi_p; # nACF
  timeAxis = create_timeAxis_( tStart, tStop, length(resultData), duration );
  #timeAxis = create_timeAxis_( tStart, tStop, windowSizeIdx, duration );

  
  #resultData = arraySubstitute_( tmpResultData, windowSizeIdx );

  
  [ maxValues, maxIdxs, zeroIdxs ] = zero_cross_(resultData, 0, flags.nacfFlag);
  maxValues = maxValues( 2 : length(maxValues) );
  maxIdxs = maxIdxs( 2 : length(maxIdxs) );
  maxTimes = convIndex2Time_( maxIdxs, x, fs ) * 1000 ;

  strTitleBase = [ '[', xLabel, '] (' ,  num2str(tS, "%5.2f"), '-', num2str(tE, "%5.2f"), ')' ];
  strTitle = strTitleBase;
      
  params = zeros( length(maxValues), 7 );
  params = zeros( length(maxValues), 7 );
  for ( i = 1 : length(maxValues) ),
    params( i, 1 ) = maxTimes( i );
    params( i, 2 ) = maxTimes( i );
    params( i, 3 ) = 0;
    params( i, 4 ) = maxValues( i );
    params( i, 5 ) = 1;
    params( i, 6 ) = 0;
    params( i, 7 ) = 0;
    
    if ( i > 3 ) continue; endif;
    strTmp =  [ ", max", num2str( i ), "= ", num2str( maxValues( i ) ),  " (", num2str( maxTimes( i ) )  " )" ];
    strTitle = strcat( strTitle, strTmp );
  endfor;


endif;
toc();


if (flags.plotFlag),
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

                 
  #dump_outputData_( resultData, funcStr );
endif;

