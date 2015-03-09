%function launcher_nACF_ICCF( handles )

%close all;
clear;


%pkg load signal;
%pkg load io;


%disp( handles );
%return;
%pause;


flags = struct(            ...
    'ccfFlag',            0,  ...  % arg 1
    'nacfFlag',          0,  ...  % arg 2
    'nacfAndoFlag',   0,  ...  % arg 3
    'nacfSingleFlag', 1,  ...  % arg 4
    'iccfFlag',          1,  ...  % arg 5
    'phiFlag',           1,  ...  % arg 6
    'dumpFlag',        0,  ...  % arg 7
    'debugFlag',       1,  ...  % arg 8
    'debugStepFlag', 0,  ...  % arg 9
    'plotFlag',          1,  ...  % arg 10
    'plot3dFlag',       1,  ...  % arg 11
    'fileDlgFlag',       0,  ...  % arg 12
    'castSignalFlag', 0,  ...  % arg 13
    'windowFlag',      0,  ...  % arg 14
    'cyclicFlag',       0, ...   % arg 15
    'exitFlag',          0  );    % arg 16

results = struct(            ...
    'resultData',   [],  ... % result 1
    'timeAxis',      [],  ... % result 2
    'maxValues',   [],  ... % result 3
    'maxIdxs',       [],  ... % result 4
    'maxTimes',    [],  ... % result 5
    'zeroIdxs',       [],  ... % result 6
    'ICCC',           0,  ... % result 7
    'tauICCC',      0,  ... % result 8
    'Wiccc',         0,  ... % result 9
    'PHI_ll_0',       0,  ... % result 10
    'PHI_rr_0',      0,  ... % result 11
    'PHI_lr',         [],  ... % result 12
    'phi_lr',          []  );     % result 13
   


handles = struct( 'flagsdata',   [] );

handles.flagsdata.funcFlag         = 2;
handles.flagsdata.nacfAndoFlag  = 0;
handles.flagsdata.phiFlag           = 1;
handles.flagsdata.dumpFlag        = 0;
handles.flagsdata.debugFlag       = 1;
handles.flagsdata.debugStepFlag = 0;
handles.flagsdata.plotFlag          = 1;
handles.flagsdata.plot3dFlag       = 1;
handles.flagsdata.exitFlag          = 0;

handles.flagsdata.numberOfHeaders = 4; % For CSV Definition File

handles.flagsdata.graphTitle = '';
handles.flagsdata.nStepIdx = 0;
handles.flagsdata.time_T = 1.0;
handles.flagsdata.tS0 = 0.0;
handles.flagsdata.tE0 = 1.0;
handles.flagsdata.tStart = -0.005;
handles.flagsdata.tStop = +0.005;

args = handles;  % input args for GUI_nACF_ICCF() for repeating calc.


tInter = 0.50; 


while ( 1 ),
    
    %disp( args );
    %pause;
    
    handles = GUI_nACF_ICCF( args );    
        
    
    if ( 1 ),
        if ( handles.flagsdata.exitFlag == 1 ) break; end; % Exit from infinite loop of this main procedure

        if ( handles.flagsdata.funcFlag == 2 ),
            flags.nacfFlag = 1 ;
            flags.iccfFlag = 0 ;
        elseif ( handles.flagsdata.funcFlag == 3 ),
            flags.nacfFlag = 0 ;
            flags.iccfFlag = 1 ;
        else
            continue;
        end;
        flags.nacfAndoFlag  = handles.flagsdata.nacfAndoFlag ;
        flags.phiFlag           = handles.flagsdata.phiFlag ;
        flags.dumpFlag        = handles.flagsdata.dumpFlag ;
        flags.debugFlag       = handles.flagsdata.debugFlag ;
        flags.debugStepFlag = handles.flagsdata.debugStepFlag ;
        flags.plotFlag          = handles.flagsdata.plotFlag ;
        flags.plot3dFlag      = handles.flagsdata.plot3dFlag ;
        
        
        graphTitle = handles.flagsdata.graphTitle;                        % FORCE to get TITLE name to treat
        tS0 = castNumeric_( handles.flagsdata.tS0 );                 % FORCE to get tS (Start) to cut the whole music signals
        tE0 = castNumeric_( handles.flagsdata.tE0 );  % FORCE to get tE (End)   to cut the whole music signals
        tStart = castNumeric_( handles.flagsdata.tStart );              % FORCE to get tStart to calculate CCF
        tStop  = castNumeric_( handles.flagsdata.tStop );  % FORCE to get tStop  to calculate CCF
        nStepIdx = castNumeric_( handles.flagsdata.nStepIdx );          % FORCE to get windowSize to calculate Realtime CCF
        time_T = castNumeric_( handles.flagsdata.time_T );          % FORCE to get windowSize to calculate Realtime CCF

        pname = handles.flagsdata.pname;
        
        if isfield(handles.flagsdata, 'ch'),
            ch = handles.flagsdata.ch;
            csvFileNames = handles.flagsdata.csvFileNames;
        else
           ch = zeros( 6, 1 );
        end;
        
        args = handles;

    end;
    
    
    %disp( flags );
    %return;
    
    numberOfHeaders = 4;
    windowScale = 1;
    
    
    bufSize = 30;
    
    
    if ( 0 ),
        [ fname, pname ] = uigetfile( '*.csv', 'CSV DEFINITION FILE' );
        wavFileName = strcat( pname, fname );
        [ ch, csvFileNames ] = textread( wavFileName, '%s %s', 'delimiter', ',' );
        
        
        graphTitle = ch{1};                        % FORCE to get TITLE name to treat
        tS0 = str2num( ch{2} );                 % FORCE to get tS (Start) to cut the whole music signals
        tE0 = str2num( csvFileNames{2} );  % FORCE to get tE (End)   to cut the whole music signals
        tStart = str2num( ch{3} );              % FORCE to get tStart to calculate CCF
        tStop  = str2num( csvFileNames{3} );  % FORCE to get tStop  to calculate CCF
        %windowSize = str2num( ch{4} );     % FORCE to get windowSize to calculate Realtime CCF
        nStepIdx = str2num( ch{4} );          % FORCE to get windowSize to calculate Realtime CCF
    end;
    
    
    [ temp, dateTime ] = system('date +%y%m%d%H%M%S');
    dateTime = dateTime( 1 : length(dateTime)-1 );
    
    
    PHI_ll_0 = 0.0;
    PHI_rr_0 = 0.0;
    PHI_lr   = 0.0;
    phi_lr   = 0.0;
    ICCC     = 0.0;
    tauICCC  = 0.0;
    Wiccc    = 0.0;
    
    %cropIdx = 1;
    
    clear resultDataMat;
    clear timeAxisMat;
    clear maxValuesMat;
    clear maxIdxsMat;
    clear zeroIdxsMat;
    clear maxTimesMat;
    clear tSMat;
    clear tEMat;
    clear PHI_ll_0Mat;
    clear PHI_rr_0Mat;
    clear PHI_lrMat;
    clear phi_lrMat;
    clear ICCCMat;
    clear tauICCCMat;
    clear WicccMat;
    clear timeVec;
    
    
    w = [];
    
    
    firstRdSize = 0;
    firstTaSize = 0;
    
    
    for i = 1+numberOfHeaders : length(ch),
        for j = i+1 : length(ch)+1,
            
            if ( flags.nacfFlag && (j>i+1) ) break; end; % FORCE to break the inner loop for when nACF
            if ( flags.nacfFlag && (i==1+numberOfHeaders) && flags.nacfSingleFlag ) break; end; % FORCE to break the inner loop for when nACF
            if ( flags.iccfFlag && (j==length(ch)+1) ) break; end; % FORCE to break the inner loop for when nACF
            
            
            if (flags.nacfFlag),
                if ( ~strcmp( handles.flagsdata.wavFileName, '' ) ),
                    
                    xLabel = 'Right';
                    if ( flags.nacfSingleFlag ),
                        yLabel = 'Right';
                    else,
                        yLabel = 'Left';
                    end;
                    xCsvFilename = handles.flagsdata.wavFileName;
                else
                    xLabel = ch{i};
                    xCsvFilename = strcat( pname, '/', csvFileNames{i} );
                    yLabel = ch{i};
                    yCsvFilename = strcat( pname, '/', csvFileNames{i} );
                end;                
                funcStr = 'nACF';
                labelStr = xLabel;
                strTitleBase = strcat( '[', xLabel, ']' );

            else
                
                if ( ~strcmp( handles.flagsdata.wavFileName, '' ) ),
                    xLabel = 'Right';
                    yLabel = 'Left';
                    xCsvFilename = handles.flagsdata.wavFileName;
                else
                    xLabel = ch{i};
                    xCsvFilename = strcat( pname, '/', csvFileNames{i} );
                    yLabel = ch{j};
                    yCsvFilename = strcat( pname, '/', csvFileNames{j} );
                end;                
                funcStr = 'ICCF';
                labelStr = strcat( yLabel, ',', xLabel );
                strTitleBase = strcat( '[', yLabel, ' <-> ', xLabel, ']' );

            end;
            
            xLabelStr = ( strcat( labelStr, ': tau [ms]' ) );
            yLabelStr = ( 'time [s]' );
            zLabelStr = ( funcStr );
            
            
            if ( ~strcmp( handles.flagsdata.wavFileName, '' ) ),
                [ s0, fsS ] = audioread( xCsvFilename );
                
                disp('####');
                
                if ( size( s0, 2) == 2 ),   % STEREO
                    x0 = s0( :, 2 );
                    y0 = s0( :, 1 );
                else   % MONO
                    x0 = s0;
                    y0 = s0;
                end;
                
                fsX = fsS;
                fsY = fsS;
            else
                %[ x0, fsX, bitsX ] = wavread( xCsvFilename );
                %[ y0, fsY, bitsY ] = wavread( yCsvFilename );
                [ x0, fsX ] = audioread( xCsvFilename );
                [ y0, fsY ] = audioread( yCsvFilename );
            end;
            
            fs = fsX;
            %bits = bitsX;
            bits = 0;
            lenX0 = length(x0);
            lenY0 = length(y0);
            
            
            tS = tS0;
            tE = tE0;
            
            tS_Idx = convTime2Index_( tS, x0, fs );
            tE_Idx = convTime2Index_( tE, x0, fs ) - 1;
            
            x = x0( tS_Idx : tE_Idx );
            y = y0( tS_Idx : tE_Idx );
            
            if ( flags.debugFlag ) sound( x, fs ); end;
            
            lenX = length(x);
            lenY = length(y);
            
            % CAUTION!!
            %nStepIdx = ceil( ( tE - tS ) / time_T ) - 1;
            nStepIdx = ceil( ( tE - tS ) / time_T );
            
            windowSize = (tE - tS) / nStepIdx;
            
            tE = tS + windowSize * windowScale;
            
            tS_Idx = convTime2Index_( tS, x0, fs );
            tE_Idx = convTime2Index_( tE, x0, fs );

            windowSizeIdx = tE_Idx - tS_Idx;
            
            %x = x0( tS_Idx : tE_Idx );
            %y = y0( tS_Idx : tE_Idx );
            x = arraySubstitute_( x0( tS_Idx : tE_Idx ), windowSizeIdx );
            y = arraySubstitute_( y0( tS_Idx : tE_Idx ), windowSizeIdx );
            
            if ( flags.debugStepFlag ) sound( x, fs ); pause( tInter ); end;
            
            %windowSizeIdx = convTime2Index_( windowSize, x, fs );

            
            % CAUTION !!!   Add ZERO vector to tail
            %x0 = vertcat( x0, zeros( windowSizeIdx * 2, 1 ) );
            %y0 = vertcat( y0, zeros( windowSizeIdx * 2, 1 ) );
            
            
            %w = HanningWindow_(     length( x ) );
            w = HammingWindow_(     length( x ) );
            %w = BlackmanWindow_(    length( x ) );
            %w = RectangularWindow_( length( x ) );
            
            if (flags.windowFlag),
                x = x .* w';
                y = y .* w';
            end;
            
            
            for (k = 1 : nStepIdx + 1 ),
                saveImageName = strcat( funcStr, ',', labelStr, ',' , num2str(tS0, '%04.2f'), ',', num2str(tE0, '%04.2f'), ',' , num2str(tS, '%04.2f'), ',', num2str(tE, '%04.2f'), ',', num2str(tStart, '%04.2f'), ',', num2str(tStop, '%04.2f'), ',', num2str(time_T, '%04.2f'), ',', graphTitle );
                
                
                [ results ] = eval( strcat( 'calc_', funcStr, '_(graphTitle, x, y, fs, bits, tS, tE, tStart, tStop, time_T, windowSize, windowSizeIdx, xLabel, yLabel, saveImageName, dateTime, flags )' ) );
                
                
                if ( k == 1 ),
                    firstRdSize = size( results.resultData );
                    firstTaSize = size( results.timeAxis );
                end;
                resultDataMat( k, : ) = arraySubstitute_( results.resultData, firstRdSize( 1,2 ) );
                timeAxisMat( k, : )   = arraySubstitute_( results.timeAxis,   firstTaSize( 1,2 ) );
                
                
                maxValuesMat( k, : )  = arraySubstitute_( results.maxValues, bufSize );
                maxIdxsMat( k, : )    = arraySubstitute_( results.maxIdxs,   bufSize );
                zeroIdxsMat( k, : )   = arraySubstitute_( results.zeroIdxs,  bufSize );
                maxTimesMat( k, : )   = arraySubstitute_( results.maxTimes,  bufSize );
                tSMat( k, : )         = tS;
                tEMat( k, : )         = tE;
                if (flags.iccfFlag && flags.phiFlag),
                    PHI_ll_0Mat( k, : ) = results.PHI_ll_0;
                    PHI_rr_0Mat( k, : ) = results.PHI_rr_0;
                    PHI_lrMat( k, : )   = arraySubstitute_( results.PHI_lr,   firstRdSize( 1,2 ) );
                    phi_lrMat( k, : )   = arraySubstitute_( results.phi_lr,   firstRdSize( 1,2 ) );
                end;
                if (flags.iccfFlag),
                    ICCCMat( k, : )       = results.ICCC;
                    tauICCCMat( k, : )    = results.tauICCC;
                    WicccMat( k, : )      = results.Wiccc;
                end;
                
                
                tS = tS0 + windowSize * k;
                tE = tS + windowSize * windowScale;

                
                tS_Idx = convTime2Index_( tS, x0, fs );
                tE_Idx = convTime2Index_( tE, x0, fs );

                
                if ( length(x0) <= tE_Idx ),
                    tE_Idx = length(x0) - 1;
                end;

                x = arraySubstitute_( x0( tS_Idx : tE_Idx ), windowSizeIdx );
                y = arraySubstitute_( y0( tS_Idx : tE_Idx ), windowSizeIdx );
                
                if ( flags.debugStepFlag ) sound( x, fs ); pause( tInter ); end;
                
                
                %w = HanningWindow_(     length( x ) );
                w = HammingWindow_(     length( x ) );
                %w = BlackmanWindow_(    length( x ) );
                %w = RectangularWindow_( length( x ) );
                
                if ( flags.windowFlag ),
                    x = x .* w';
                    y = y .* w';
                end;
                %end;
                
            end;
            
            
            
            if (flags.plot3dFlag),
                timeVec = (0:nStepIdx) * (tE0 - tS0) / nStepIdx + tS0;
                %XYZ = surf( timeAxisMat( 1,: ), timeVec, resultDataMat, 'FaceColor','interp','FaceLighting','phong', 'LineWidth', 0.01, 'EdgeAlpha', 0.3 );
                XYZ = surf( timeAxisMat( 1,: ), timeVec, resultDataMat, 'FaceColor','interp','FaceLighting','phong', 'LineWidth', 0.01, 'EdgeAlpha', 0.01 );
                grid on;
                hold on;
                
                if ( flags.iccfFlag ),
                    lw = 3;
                    ms = 4;
                    %lc = '-ow';
                    lc = 'ow';
                    plot3( tauICCCMat, timeVec, ICCCMat, lc, 'LineWidth', lw, 'MarkerSize', ms );
                end;
                
                if ( flags.nacfFlag ),
                    clipVal = 0.2;
                    eps = 0.15;
                    [ maxValVec, tauE_Vec ] = substitute_peaks_( clipVal, eps, resultDataMat, x0, fs );
                    a = ones( 1, nStepIdx + 1 ) .* clipVal;
                    lw = 3;
                    ms = 4;
                    lc = '-ow';
                    plot3( arraySubstitute_( tauE_Vec, length(timeVec) ), timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                end;
                    
                if ( flags.iccfFlag ),
                    clipVal = 0.2;
                    eps = 0.15;
                    [ maxValVec_R, tauE_Vec_R ] = substitute_peaks_( clipVal, eps, resultDataMat( : , floor ( 1 + size( resultDataMat, 2 ) / 2 ) : size( resultDataMat, 2 ) ), x0, fs );
                    a = ones( 1, nStepIdx + 1 ) .* clipVal;
                    lw = 3;
                    ms = 4;
                    lc = '-ow';
                    plot3( arraySubstitute_( tauE_Vec_R, length(timeVec) ), timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                    
                    [ maxValVec_L, tauE_Vec_L ] = substitute_peaks_( clipVal, eps, resultDataMat( : , 1 : floor ( 1 + size( resultDataMat, 2 ) / 2 ) ) , y0, fs );
                    plot3( arraySubstitute_( tauE_Vec_L - tStop * 10^3, length(timeVec) ), timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                end;
                                
                
                xlabel( xLabelStr );
                ylabel( yLabelStr );
                zlabel( zLabelStr );
                
                strTitle = strcat( '[', yLabel, ' <-> ', xLabel, ']', ' (' ,  num2str(tS0, '%04.2f'), '-', num2str(tE0, '%04.2f'), '), [T : ', num2str(time_T, '%04.2f'), ' ], ', graphTitle);
                title( strTitle );
                
                hold off;
            end;
            
            
            if ( flags.dumpFlag ),
                dump_data_( resultDataMat, 'resultDataMat',  funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( timeAxisMat,    'timeAxis',         funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( maxValuesMat, 'maxValuesMat', funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( maxIdxsMat,     'maxIdxsMat',     funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( zeroIdxsMat,    'zeroIdxsMat',     funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( maxTimesMat,  'maxTimesMat',  funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( tSMat,            'tSMat',             funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( tEMat,            'tEMat',              funcStr, saveImageName, graphTitle, dateTime );
                
                if ( flags.iccfFlag ),
                    if (flags.phiFlag),
                        dump_data_( PHI_ll_0Mat,   'PHI_ll_0Mat',     funcStr, saveImageName, graphTitle, dateTime );
                        dump_data_( PHI_rr_0Mat,  'PHI_rr_0Mat',    funcStr, saveImageName, graphTitle, dateTime );
                        dump_data_( PHI_lrMat,     'PHI_lrMat',       funcStr, saveImageName, graphTitle, dateTime );
                        dump_data_( phi_lrMat,      'phi_lrMat',       funcStr, saveImageName, graphTitle, dateTime );
                    end;
                    dump_data_( ICCCMat,       'ICCCMat',       funcStr, saveImageName, graphTitle, dateTime );
                    dump_data_( tauICCCMat,   'tauICCCMat',  funcStr, saveImageName, graphTitle, dateTime );
                    dump_data_( WicccMat,      'WicccMat',      funcStr, saveImageName, graphTitle, dateTime );
                end;
                
                
                dump_data_( timeVec,        'timeVec',        funcStr, saveImageName, graphTitle, dateTime );
            end;
            
            
        end;
    end;
    
    %handles.flagsdata.exitFlag = 1;
    
end;

return;