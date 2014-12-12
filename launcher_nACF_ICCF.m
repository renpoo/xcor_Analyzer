close all; 
clear;


pkg load signal;
pkg load io;


ccfFlag        = 0;
nacfFlag       = 1;
nacfAndoFlag   = 0;
nacfSingleFlag = 1;

iccfFlag       = !nacfFlag;
phiFlag        = 1;

dumpFlag       = 1;
debugFlag      = 1;
debugStepFlag  = 1;
plotFlag       = 1;
plot3dFlag     = 1;
fileDlgFlag    = 0;
castSignalFlag = 0;
windowFlag     = 0;
CyclicFlag     = 1;


numberOfHeaders = 4;
windowScale = 1;


bufSize = 30;


[ fname, pname ] = uigetfile( '*.csv', 'CSV DEFINITION FILE' );
defFileName = strcat( pname, "/", fname );
[ch, csvFileNames] = textread(defFileName, '%s %s','delimiter',',');


graphTitle = ch{1};                  # FORCE to get TITLE name to treat
tS0 = str2num( ch{2} );               # FORCE to get tS (Start) to cut the whole music signals
tE0 = str2num( csvFileNames{2} );     # FORCE to get tE (End)   to cut the whole music signals
tStart = str2num( ch{3} );           # FORCE to get tStart to calculate CCF
tStop  = str2num( csvFileNames{3} ); # FORCE to get tStop  to calculate CCF
#windowSize = str2num( ch{4} );       # FORCE to get windowSize to calculate Realtime CCF
nStepIdx = str2num( ch{4} );       # FORCE to get windowSize to calculate Realtime CCF


[temp dateTime] = system("date +%y%m%d%H%M%S");
dateTime = dateTime( 1 : length(dateTime)-1 );


PHI_ll_0 = 0.0;
PHI_rr_0 = 0.0;
PHI_lr   = 0.0;
phi_lr   = 0.0;
ICCC     = 0.0;
tauICCC  = 0.0;
Wiccc    = 0.0;


resultDataMat = [];
#timeAxisMat   = [];
maxValuesMat  = [];
maxIdxsMat    = [];
zeroIdxsMat   = [];
maxTimesMat   = [];
tSMat         = [];
tEMat         = [];
PHI_ll_0Mat   = [];
PHI_rr_0Mat   = [];
PHI_lrMat     = [];
phi_lrMat     = [];
ICCCMat       = [];
tauICCCMat    = [];
WicccMat      = [];
timeVec       = [];


w = [];


firstRdSize = 0;
firstTaSize = 0;


for i = 1+numberOfHeaders:length(ch),
  for j = i+1:length(ch)+1,

    if ( nacfFlag && (j>i+1) ) break; endif; # FORCE to break the inner loop for when nACF
    if ( nacfFlag && (i==1+numberOfHeaders) && nacfSingleFlag ) break; endif; # FORCE to break the inner loop for when nACF
    if ( iccfFlag && (j==length(ch)+1) ) break; endif; # FORCE to break the inner loop for when nACF

    #[temp dateTime] = system("date +%y%m%d%H%M%S");
    #dateTime = dateTime( 1 : length(dateTime)-1 );


    if (nacfFlag),
      xLabel = ch{i};
      xCsvFilename = strcat( pname, '/', csvFileNames{i} );
      yLabel = ch{i};
      yCsvFilename = strcat( pname, '/', csvFileNames{i} );

      funcStr = 'nACF';
      labelStr = xLabel;
      strTitleBase = strcat( '[', xLabel, ']' );
    else
      xLabel = ch{i};
      xCsvFilename = strcat( pname, '/', csvFileNames{i} );
      yLabel = ch{j};
      yCsvFilename = strcat( pname, '/', csvFileNames{j} );

      funcStr = 'ICCF';
      labelStr = strcat( yLabel, ',', xLabel );
      strTitleBase = strcat( '[', yLabel, ' <-> ', xLabel, ']' );
    endif;
    
    xLabelStr = ( strcat( labelStr, ': tau [ms]') );
    yLabelStr = ( 'time [s]');
    zLabelStr = ( funcStr );


    [ x0, fsX, bitsX ] = wavread( xCsvFilename );
    [ y0, fsY, bitsY ] = wavread( yCsvFilename );


    fs = fsX;
    bits = bitsX;
    lenX0 = length(x0);
    lenY0 = length(y0);
    

    tS = tS0;
    tE = tE0;

    tS_Idx = convTime2Index_( tS, x0, fs );
    tE_Idx = convTime2Index_( tE, x0, fs );

    x = x0( tS_Idx : tE_Idx );
    y = y0( tS_Idx : tE_Idx );

    if (debugFlag) sound( x, fs ); endif;
    
    lenX = length(x);
    lenY = length(y);

    windowSize = (tE - tS) / nStepIdx;

    tE = tS + windowSize * windowScale;

    tS_Idx = convTime2Index_( tS, x0, fs );
    tE_Idx = convTime2Index_( tE, x0, fs );
    
    x = x0( tS_Idx : tE_Idx );
    y = y0( tS_Idx : tE_Idx );

    if (debugStepFlag) sound( x, fs ); endif;
    
    windowSizeIdx = convTime2Index_( windowSize, x, fs );

    #w = HanningWindow_( windowSizeIdx );
    #w = HammingWindow_( windowSizeIdx );
    #w = BlackmanWindow_( windowSizeIdx );
    #w = RectangularWindow_( windowSizeIdx );

    #w = HanningWindow_(     length( x ) );
    w = HammingWindow_(     length( x ) );
    #w = BlackmanWindow_(    length( x ) );
    #w = RectangularWindow_( length( x ) );

    #for n = 1 : windowSizeIdx,
    #  x(n) = x(n) * w(n);
    #  y(n) = y(n) * w(n);
    #endfor;
    
    if (windowFlag),
      x = x .* w';
      y = y .* w';    
    endif;

    
    #for (k = 1 : nStepIdx + 1 ),
    for (k = 1 : nStepIdx + 1 ),
      saveImageName = strcat( funcStr, ',', labelStr, ',' , num2str(tS0, "%04.2f"), ',', num2str(tE0, "%04.2f"), ',' , num2str(tS, "%04.2f"), ',', num2str(tE, "%04.2f"), ',', num2str(tStart, "%04.2f"), ',', num2str(tStop, "%04.2f"), ',', num2str(nStepIdx, "%d"), ',', graphTitle );    


      if (nacfFlag),
        [ resultData, timeAxis, maxValues, maxIdxs, maxTimes, zeroIdxs ] = calc_nACF_(graphTitle, x, y, fs, bits, tS, tE, tStart, tStop, windowSize, windowSizeIdx, xLabel, yLabel, saveImageName, dumpFlag, debugFlag, plotFlag, ccfFlag, nacfFlag, nacfAndoFlag, iccfFlag, phiFlag, fileDlgFlag, castSignalFlag, dateTime);
      else
        [ resultData, timeAxis, maxValues, maxIdxs, maxTimes, zeroIdxs, ICCC, tauICCC, Wiccc, PHI_ll_0, PHI_rr_0, PHI_lr, phi_lr ] = calc_ICCF_(graphTitle, x, y, fs, bits, tS, tE, tStart, tStop, windowSize, windowSizeIdx, xLabel, yLabel, saveImageName, dumpFlag, debugFlag, plotFlag, ccfFlag, nacfFlag, nacfAndoFlag, iccfFlag, phiFlag, fileDlgFlag, castSignalFlag, dateTime);
      endif;


      if ( k == 1 ),
        firstRdSize = size( resultData );
        firstTaSize = size( timeAxis );
      endif;
      resultDataMat( k, : ) = arraySubstitute_( resultData, firstRdSize( 1,2 ) );
      timeAxisMat( k, : )   = arraySubstitute_( timeAxis,   firstTaSize( 1,2 ) );


      maxValuesMat( k, : )  = arraySubstitute_( maxValues, bufSize );
      maxIdxsMat( k, : )    = arraySubstitute_( maxIdxs,   bufSize );
      zeroIdxsMat( k, : )   = arraySubstitute_( zeroIdxs,  bufSize );
      maxTimesMat( k, : )   = arraySubstitute_( maxTimes,  bufSize );
      tSMat( k, : )         = tS;
      tEMat( k, : )         = tE;
      if (phiFlag),
        PHI_ll_0Mat( k, : ) = PHI_ll_0;
        PHI_rr_0Mat( k, : ) = PHI_rr_0;
        PHI_lrMat( k, : )   = arraySubstitute_( PHI_lr,   firstRdSize( 1,2 ) );
        phi_lrMat( k, : )   = arraySubstitute_( phi_lr,   firstRdSize( 1,2 ) );
      endif;
      ICCCMat( k, : )       = ICCC;
      tauICCCMat( k, : )    = tauICCC;
      WicccMat( k, : )      = Wiccc;

      
      tS = tS0 + windowSize * k;
      #tE = tE0 + windowSize * k;
      tE = tS + windowSize * windowScale;
      tS_Idx = convTime2Index_( tS, x0, fs );
      tE_Idx = convTime2Index_( tE, x0, fs );
      x = x0( tS_Idx : tE_Idx );
      y = y0( tS_Idx : tE_Idx );

      if (debugStepFlag) sound( x, fs ); endif;

  
      #w = HanningWindow_(     length( x ) );
      w = HammingWindow_(     length( x ) );
      #w = BlackmanWindow_(    length( x ) );
      #w = RectangularWindow_( length( x ) );

      #for n = 1 : windowSizeIdx,
      #  x(n) = x(n) * w(n);
      #  y(n) = y(n) * w(n);
      #endfor;

      if (windowFlag),
        x = x .* w';
        y = y .* w';    
      endif;
        
    endfor;


    
    if (plot3dFlag),
      #for (k = 1 : nStepIdx + 1 ),
      #  resultDataMat( k, : ) = arraySubstitute_(resultDataMat( k, : ), length( timeAxis ));
      #endfor;
      #timeVec = (1:nStepIdx) / (tE - tS) + tS0;
      timeVec = (0:nStepIdx) * (tE0 - tS0) / nStepIdx + tS0;
      #timeVec = arraySubstitute_(timeVec, bufSize);
      XYZ = surf( timeAxisMat( 1,: ), timeVec, resultDataMat );
      #XYZ = surf( timeAxis, timeVec, resultDataMat );
      grid on;


      #shading interp;
      #shading faceted;


      #set( XYZ, 'edgecolor', [0 0 0], 'edgealpha', 0.3 );
      xlabel( xLabelStr );
      ylabel( yLabelStr );
      zlabel( zLabelStr );

      strTitle = strcat( '[', yLabel, ' <-> ', xLabel, ']', ' (' ,  num2str(tS0, "%04.2f"), '-', num2str(tE0, "%04.2f"), '), ', graphTitle);
      title( strTitle );
    endif;

    
    if (dumpFlag),
      dump_data_( resultDataMat, 'resultDataMat', funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( timeAxis,      'timeAxis',      funcStr, saveImageName, graphTitle, dateTime );
      #dump_data_( timeAxisMat,   'timeAxisMat',   funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( maxValuesMat,  'maxValuesMat',  funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( maxIdxsMat,    'maxIdxsMat',    funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( zeroIdxsMat,   'zeroIdxsMat',   funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( maxTimesMat,   'maxTimesMat',   funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( tSMat,         'tSMat',         funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( tEMat,         'tEMat',         funcStr, saveImageName, graphTitle, dateTime );

      if (phiFlag),
        dump_data_( PHI_ll_0Mat,   'PHI_ll_0Mat',   funcStr, saveImageName, graphTitle, dateTime );
        dump_data_( PHI_rr_0Mat,   'PHI_rr_0Mat',   funcStr, saveImageName, graphTitle, dateTime );
        dump_data_( PHI_lrMat,     'PHI_lrMat',     funcStr, saveImageName, graphTitle, dateTime );
        dump_data_( phi_lrMat,     'phi_lrMat',     funcStr, saveImageName, graphTitle, dateTime );
      endif;

      dump_data_( ICCCMat,       'ICCCMat',       funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( tauICCCMat,    'tauICCCMat',    funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( WicccMat,      'WicccMat',      funcStr, saveImageName, graphTitle, dateTime );

      dump_data_( timeVec,       'timeVec',       funcStr, saveImageName, graphTitle, dateTime );
  endif;

        
  endfor;
endfor;
