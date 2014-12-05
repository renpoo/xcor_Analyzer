close all; 
clear;


pkg load signal;
pkg load io;


[ fname, pname ] = uigetfile( '*.csv', 'CSV DIFINITION FILE' );
defFileName = strcat( pname, "/", fname );
[ch, csvFileNames]=textread(defFileName, '%s %s','delimiter',',');


graphTitle = ch{1};                  # FORCE to get TITLE name to treat
tS0 = str2num( ch{2} );               # FORCE to get tS (Start) to cut the whole music signals
tE0 = str2num( csvFileNames{2} );     # FORCE to get tE (End)   to cut the whole music signals
tStart = str2num( ch{3} );           # FORCE to get tStart to calculate CCF
tStop  = str2num( csvFileNames{3} ); # FORCE to get tStop  to calculate CCF
#windowSize = str2num( ch{4} );       # FORCE to get windowSize to calculate Realtime CCF
nStepIdx = str2num( ch{4} );       # FORCE to get windowSize to calculate Realtime CCF


[temp dateTime] = system("date +%y%m%d%H%M%S");
dateTime = dateTime( 1 : length(dateTime)-1 );


resultDataMat = [];


if (1),
for i = 1+4:length(ch),
    xLabel = ch{i};
    yLabel = ch{i};
    saveImageName = strcat( "nACF_Graph", "_", xLabel, "___", graphTitle );
    funcStr = "nACF";
    
    [ x0, fsX, bitsX ] = wavread( csvFileNames{i} );
    [ y0, fsY, bitsY ] = wavread( csvFileNames{i} );

    fs = fsX;
    bits = bitsX;
    lenX0 = length(x0);
    lenY0 = length(y0);
    
    tS = tS0;
    tE = tE0;
    tS_Idx = convTime2Index_( tS0, x0, fs );
    tE_Idx = convTime2Index_( tE0, x0, fs );

    x = x0( tS_Idx : tE_Idx );
    y = y0( tS_Idx : tE_Idx );

    lenX = length(x);
    lenY = length(y);

    #windowSizeIdx = convTime2Index_( windowSize, x, fs );
    #nStepIdx = convTime2Index_( (tE - tS) * windowSize, x, fs );
    windowSize = (tE - tS) / nStepIdx;
    
    dumpFlag       = 1;
    debugFlag      = 1;
    plotFlag       = 1;
    plot3dFlag     = 1;
    ccfFlag        = 0;
    nacfFlag       = 1;
    nacfAndoFlag   = 0;
    iacfFlag       = 0;
    phiFlag        = 0;
    fileDlgFlag    = 0;
    castSignalFlag = 0;

    if (debugFlag) sound( x, fs ); endif;
    
    #calc_nACF_(graphTitle, x, y, fs, bits, tS, tE, tStart, tStop, xLabel, yLabel, saveImageName, dumpFlag, debugFlag, plotFlag, ccfFlag, nacfFlag, nacfAndoFlag, iacfFlag, phiFlag, fileDlgFlag, castSignalFlag, dateTime)

    for (k = 1 : nStepIdx ),
      [ resultData, timeAxis, maxValues, maxIdxs, zeroIdxs ] = calc_nACF_(graphTitle, x, y, fs, bits, tS, tE, tStart, tStop, xLabel, yLabel, saveImageName, dumpFlag, debugFlag, plotFlag, ccfFlag, nacfFlag, nacfAndoFlag, iacfFlag, phiFlag, fileDlgFlag, castSignalFlag, dateTime)

      resultDataMat( k, : ) = resultData;

      tS = tS0 + windowSize * k;
      tE = tE0 + windowSize * k;
      tS_Idx = convTime2Index_( tS, x0, fs );
      tE_Idx = convTime2Index_( tE, x0, fs );
      x = x0( tS_Idx : tE_Idx );
      y = y0( tS_Idx : tE_Idx );
    endfor;
    #for k = nStepIdx+1 : length(resultData),
    #  resultDataMat( k, : ) = zeros( length(resultData), 1 );
    #endfor;

    if (plot3dFlag),
      #timeVec = (tStop - tStart) * (1:length(timeAxis)) + tS0;
      timeVec = (1:nStepIdx) / (tE - tS) + tS0;
      XYZ = surf( timeAxis, timeVec, resultDataMat );
      axis tight;
      grid on;
      shading interp;
      #shading faceted;
      set( XYZ, 'edgecolor', [0 0 0], 'edgealpha', 0.3 );
      set( gca, 'drawmode', 'fast' );
      xlabel (strcat( xLabel, ': tau [ms]') ); ylabel ('time [s]'); zlabel ('nACF');
    endif;

  
    dump_data_( resultDataMat, 'resultDataMat', strcat( funcStr, '_', graphTitle, '_', dateTime ), graphTitle, dateTime );

    
    #clear resultDataMat;
    #return;

    
endfor;
endif;
