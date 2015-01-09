close all; 
clear;


pkg load signal;
pkg load io;


flags = struct(            ...
    'ccfFlag',        0,  ...  % arg 1
    'nacfFlag',       0,  ...  % arg 2
    'nacfAndoFlag',   0,  ...  % arg 3
    'nacfSingleFlag', 1,  ...  % arg 4
    'iccfFlag',       1,  ...  % arg 5
    'phiFlag',        1,  ...  % arg 6
    'dumpFlag',       0,  ...  % arg 7
    'debugFlag',      1,  ...  % arg 8
    'debugStepFlag',  1,  ...  % arg 9
    'plotFlag',       1,  ...  % arg 10
    'plot3dFlag',     1,  ...  % arg 11
    'fileDlgFlag',    0,  ...  % arg 12
    'castSignalFlag', 0,  ...  % arg 13
    'windowFlag',     0,  ...  % arg 14
    'cyclicFlag',     0);      % arg 15

if (0),
flags_fields = fieldnames(flags);
nargin = 15;
for i = 1:nargin,
  flags.( flags_fields{i} ) = eval( num2str( flags.( flags_fields{i} ) ) );
endfor;
endif;
        

results = struct(            ...
    'resultData', [],  ... % result 1
    'timeAxis',   [],  ... % result 2
    'maxValues',  [],  ... % result 3
    'maxIdxs',    [],  ... % result 4
    'maxTimes',   [],  ... % result 5
    'zeroIdxs',   [],  ... % result 6
    'ICCC',        0,  ... % result 7
    'tauICCC',     0,  ... % result 8
    'Wiccc',       0,  ... % result 9
    'PHI_ll_0',    0,  ... % result 10
    'PHI_rr_0',    0,  ... % result 11
    'PHI_lr',     [],  ... % result 12
    'phi_lr',     []);     % result 13

if (0),
results_fields = fieldnames(results);
nargin = 13;
for i = 1:nargin,
  if ( isnumeric( results.( results_fields{i} ) ) ),
    results.( results_fields{i} ) = eval( num2str( results.( results_fields{i} ) ) );
  else,
    results.( results_fields{i} ) = eval( results.( results_fields{i} ) );
  endif;
endfor;
endif;


numberOfHeaders = 4;
windowScale = 1;


bufSize = 30;


[ fname, pname ] = uigetfile( '*.csv', 'CSV DEFINITION FILE' );
defFileName = strcat( pname, "/", fname );
[ch, csvFileNames] = textread(defFileName, '%s %s','delimiter',',');


graphTitle = ch{1};                   # FORCE to get TITLE name to treat
tS0 = str2num( ch{2} );               # FORCE to get tS (Start) to cut the whole music signals
tE0 = str2num( csvFileNames{2} );     # FORCE to get tE (End)   to cut the whole music signals
tStart = str2num( ch{3} );            # FORCE to get tStart to calculate CCF
tStop  = str2num( csvFileNames{3} );  # FORCE to get tStop  to calculate CCF
#windowSize = str2num( ch{4} );       # FORCE to get windowSize to calculate Realtime CCF
nStepIdx = str2num( ch{4} );          # FORCE to get windowSize to calculate Realtime CCF


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

    if ( flags.nacfFlag && (j>i+1) ) break; endif; # FORCE to break the inner loop for when nACF
    if ( flags.nacfFlag && (i==1+numberOfHeaders) && flags.nacfSingleFlag ) break; endif; # FORCE to break the inner loop for when nACF
    if ( flags.iccfFlag && (j==length(ch)+1) ) break; endif; # FORCE to break the inner loop for when nACF


    if (flags.nacfFlag),
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

    if (flags.debugFlag) sound( x, fs ); endif;
    
    lenX = length(x);
    lenY = length(y);

    windowSize = (tE - tS) / nStepIdx;

    tE = tS + windowSize * windowScale;

    tS_Idx = convTime2Index_( tS, x0, fs );
    tE_Idx = convTime2Index_( tE, x0, fs );
    
    x = x0( tS_Idx : tE_Idx );
    y = y0( tS_Idx : tE_Idx );

    if (flags.debugStepFlag) sound( x, fs ); endif;
    
    windowSizeIdx = convTime2Index_( windowSize, x, fs );

    #w = HanningWindow_(     length( x ) );
    w = HammingWindow_(     length( x ) );
    #w = BlackmanWindow_(    length( x ) );
    #w = RectangularWindow_( length( x ) );

    if (flags.windowFlag),
      x = x .* w';
      y = y .* w';    
    endif;

    
    for (k = 1 : nStepIdx + 1 ),
      saveImageName = strcat( funcStr, ',', labelStr, ',' , num2str(tS0, "%04.2f"), ',', num2str(tE0, "%04.2f"), ',' , num2str(tS, "%04.2f"), ',', num2str(tE, "%04.2f"), ',', num2str(tStart, "%04.2f"), ',', num2str(tStop, "%04.2f"), ',', num2str(nStepIdx, "%d"), ',', graphTitle );    


      #if (flags.nacfFlag),
      #  [ results ] = calc_nACF_(graphTitle, x, y, fs, bits, tS, tE, tStart, tStop, windowSize, windowSizeIdx, xLabel, yLabel, saveImageName, dateTime, flags );
      #else
      #  [ results ] = calc_ICCF_(graphTitle, x, y, fs, bits, tS, tE, tStart, tStop, windowSize, windowSizeIdx, xLabel, yLabel, saveImageName, dateTime, flags );
      #endif;
      [ results ] = eval( strcat( "calc_", funcStr, "_(graphTitle, x, y, fs, bits, tS, tE, tStart, tStop, windowSize, windowSizeIdx, xLabel, yLabel, saveImageName, dateTime, flags )" ) );


      if ( k == 1 ),
        firstRdSize = size( results.resultData );
        firstTaSize = size( results.timeAxis );
      endif;
      resultDataMat( k, : ) = arraySubstitute_( results.resultData, firstRdSize( 1,2 ) );
      timeAxisMat( k, : )   = arraySubstitute_( results.timeAxis,   firstTaSize( 1,2 ) );


      maxValuesMat( k, : )  = arraySubstitute_( results.maxValues, bufSize );
      maxIdxsMat( k, : )    = arraySubstitute_( results.maxIdxs,   bufSize );
      zeroIdxsMat( k, : )   = arraySubstitute_( results.zeroIdxs,  bufSize );
      maxTimesMat( k, : )   = arraySubstitute_( results.maxTimes,  bufSize );
      tSMat( k, : )         = tS;
      tEMat( k, : )         = tE;
      if (flags.phiFlag),
        PHI_ll_0Mat( k, : ) = results.PHI_ll_0;
        PHI_rr_0Mat( k, : ) = results.PHI_rr_0;
        PHI_lrMat( k, : )   = arraySubstitute_( results.PHI_lr,   firstRdSize( 1,2 ) );
        phi_lrMat( k, : )   = arraySubstitute_( results.phi_lr,   firstRdSize( 1,2 ) );
      endif;
      ICCCMat( k, : )       = results.ICCC;
      tauICCCMat( k, : )    = results.tauICCC;
      WicccMat( k, : )      = results.Wiccc;

      
      tS = tS0 + windowSize * k;
      tE = tS + windowSize * windowScale;
      tS_Idx = convTime2Index_( tS, x0, fs );
      tE_Idx = convTime2Index_( tE, x0, fs );
      x = x0( tS_Idx : tE_Idx );
      y = y0( tS_Idx : tE_Idx );

      if (flags.debugStepFlag) sound( x, fs ); endif;

  
      #w = HanningWindow_(     length( x ) );
      w = HammingWindow_(     length( x ) );
      #w = BlackmanWindow_(    length( x ) );
      #w = RectangularWindow_( length( x ) );

      if (flags.windowFlag),
        x = x .* w';
        y = y .* w';    
      endif;
        
    endfor;


    
    if (flags.plot3dFlag),
      timeVec = (0:nStepIdx) * (tE0 - tS0) / nStepIdx + tS0;
      XYZ = surf( timeAxisMat( 1,: ), timeVec, resultDataMat );
      grid on;


      #shading interp;
      #shading faceted;


      xlabel( xLabelStr );
      ylabel( yLabelStr );
      zlabel( zLabelStr );

      strTitle = strcat( '[', yLabel, ' <-> ', xLabel, ']', ' (' ,  num2str(tS0, "%04.2f"), '-', num2str(tE0, "%04.2f"), '), ', graphTitle);
      title( strTitle );
    endif;

    
    if (flags.dumpFlag),
      dump_data_( resultDataMat, 'resultDataMat', funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( timeAxis,      'timeAxis',      funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( maxValuesMat,  'maxValuesMat',  funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( maxIdxsMat,    'maxIdxsMat',    funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( zeroIdxsMat,   'zeroIdxsMat',   funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( maxTimesMat,   'maxTimesMat',   funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( tSMat,         'tSMat',         funcStr, saveImageName, graphTitle, dateTime );
      dump_data_( tEMat,         'tEMat',         funcStr, saveImageName, graphTitle, dateTime );

      if (flags.phiFlag),
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