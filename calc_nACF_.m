function [ results ] = calc_nACF_(graphTitle, x, y, fs, bits, tS, tE, tStart, tStop, timeSlice, windowSize, windowSizeIdx, xLabel, yLabel, saveImageName, dateTime, flags )

%pkg load signal;
%pkg load io;

tauEnd = 1.0 / 1000; % [s] : End of calcuration interval for nACF

if (flags.castSignalFlag),
  x = x - mean(x);
  y = y - mean(y);
end;

lenX = length(x);
%lenY = length(y);


duration = lenX / fs;  %duration (of input signal)


maxValues  = zeros( windowSizeIdx, 1 );
maxIdxs  = zeros( windowSizeIdx, 1 );


resultData  = zeros( windowSizeIdx, 1 );
resultData2 = zeros( windowSizeIdx, 1 );
tmpResultData = zeros( windowSizeIdx, 1 );
params = [];
strTitle = '';
strTitleBase = '';

%tic();

if (flags.nacfFlag),
  funcStr = 'nACF';
  tStart  = 0.0;  %%% CAUTION!!! %%%
  cropIdx = 1;
  limitSize = convTime2Index_( (tStop - tStart), x, fs ) - cropIdx;
  if (flags.nacfAndoFlag),
    phi_p = nACF_ANDO_( (tStop - tStart), duration, x, x );
    %phi_p = arraySubstitute_( nACF_ANDO_( (tStop - tStart), duration, x, x ), limitSize );
  else 
    phi_p = nACF_( x( 1:limitSize ) );
    %phi_p = arraySubstitute_( nACF_( x( 1:limitSize ) ), limitSize );
  end;
  resultData = phi_p; % nACF
  %tmpResultData = phi_p; % nACF
  timeAxis = create_timeAxis_( tStart, tStop, length(resultData), duration );
  %timeAxis = create_timeAxis_( tStart, tStop, windowSizeIdx, duration );

  
  %resultData = arraySubstitute_( tmpResultData, windowSizeIdx );

  
  [ maxValues, maxIdxs, zeroIdxs ] = zero_cross_(resultData, 0, flags.nacfFlag);
  maxValues = maxValues( 2 : length(maxValues) );
  maxIdxs = maxIdxs( 2 : length(maxIdxs) );
  maxTimes = convIndex2Time_( maxIdxs, x, fs ) * 1000 ;

  strTitleBase = [ '[', xLabel, '] (' ,  num2str(tS, '%5.2f'), '-', num2str(tE, '%5.2f'), '), [T : ', num2str(timeSlice, '%04.2f'), ' ], ' ];
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
    
    if ( i > 3 ) continue; end;
    strTmp =  [ ', max', num2str( i ), '= ', num2str( maxValues( i ) ),  ' (', num2str( maxTimes( i ) )  ' )' ];
    strTitle = strcat( strTitle, strTmp );
  end;


end;
%toc();


if (flags.plotFlag),
  plot_graph_( resultData, timeAxis, saveImageName, funcStr, strTitle, xLabel, yLabel, params, graphTitle, dateTime, tS, tE );
end;


results.resultData = resultData;
results.timeAxis   = timeAxis;
results.maxValues  = maxValues;
results.maxIdxs    = maxIdxs;
results.maxTimes   = maxTimes;
results.zeroIdxs   = zeroIdxs;

