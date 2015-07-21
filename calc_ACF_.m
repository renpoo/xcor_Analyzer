function [ results ] = calc_ACF_(graphTitle, x, y, fs, bits, tS0, tE0, tS, tE, tStart, tStop, timeT, windowSize, windowSizeIdx, strTitleBase, xLabel, yLabel, saveImageName, dateTime, flags )

%pkg load signal;
%pkg load io;


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
timeAxis = [];
params = [];
strTitle = '';


if (flags.nacfFlag),
  funcStr = 'ACF';
  tStart  = 0.0;  %%% CAUTION!!! %%%
  cropIdx = 1;
  
  limitSize = convTime2Index_( (tStop - tStart), x, fs ) - cropIdx;
  if ( lenX < limitSize ), limitSize = lenX; end;
  
  if (flags.nacfAndoFlag),
    phi_p = nACF_ANDO_( (tStop - tStart), duration, x, x );
  else
      if (flags.cyclicFlag),
          if (flags.normalizeFlag),
              phi_p = cyclicNCCF_( x( 1:limitSize ), x( 1:limitSize ) );
          else
              phi_p = cyclicCCF_( x( 1:limitSize ), x( 1:limitSize ) );
          end
      else
          if (flags.normalizeFlag),
              phi_p = nACF_( x( 1:limitSize ) );
          else
              phi_p = ACF_( x( 1:limitSize ) );
          end
      end;
  end;
  resultData = phi_p; % nACF

  timeAxis = create_timeAxis_( tStart, tStop, length(resultData), duration ) * flags.xUnitScale;

  
  [ maxValues, maxIdxs, zeroIdxs ] = zero_cross_( resultData, 0, 1 );
  maxValues = maxValues( 2 : length(maxValues) );
  maxIdxs = maxIdxs( 2 : length(maxIdxs) );
  maxTimes = convIndex2Time_( maxIdxs, x, fs ) * flags.xUnitScale ;

  strTitleBase = [ strTitleBase, ' (' ,  num2str(tS, '%02.3f'), '-', num2str(tE, '%02.3f'), '), [T : ', num2str(timeT, '%02.3f'), ' ]' ];
  strTitle = strTitleBase;
      
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
    strTmp =  [ ', [max', num2str( i ), ']= ', num2str( maxValues( i ), '%02.3f' ),  ' (', num2str( maxTimes( i ), '%02.3f' )  ' )' ];
    strTitle = strcat( strTitle, strTmp );
  end;
  
end;



if (flags.plotFlag),
  plot_graph_( resultData, timeAxis, saveImageName, funcStr, strTitle, xLabel, yLabel, params, graphTitle, dateTime, tS0, tE0, tS, tE, timeT );
end;


results.resultData = resultData;
results.timeAxis   = timeAxis;
results.maxValues  = maxValues;
results.maxIdxs    = maxIdxs;
results.maxTimes   = maxTimes;
results.zeroIdxs   = zeroIdxs;

