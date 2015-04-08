%function launcher_nACF_ICCF( handles )

close all;
clear;


%pkg load signal;
%pkg load io;


flags = struct(            ...
    'ccfFlag',            0,  ...  % arg 1
    'nacfFlag',          0,  ...  % arg 2
    'nacfAndoFlag',   0,  ... 
    'normalizeFlag',   1,  ...  % arg 3
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
    'calcTauE_VecFlag', 0,  ...  % arg 16
    'playSoundFlag', 0,  ...  % arg 18
    'exitFlag',          0  );    % arg 19

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

handles.flagsdata.funcFlag         = 1;
handles.flagsdata.normalizeFlag  = 1;
handles.flagsdata.nacfAndoFlag  = 0;
handles.flagsdata.phiFlag           = 1;
handles.flagsdata.dumpFlag        = 0;
handles.flagsdata.debugFlag       = 1;
handles.flagsdata.debugStepFlag = 0;
handles.flagsdata.plotFlag          = 1;
handles.flagsdata.plot3dFlag       = 0;
handles.flagsdata.playSoundFlag  = 1;
handles.flagsdata.exitFlag          = 0;

handles.flagsdata.calcTauE_VecFlag  = 0;
%handles.flagsdata.calcTauE_VecFlag  = 0;
handles.flagsdata.nacfSingleFlag  = 0;

handles.flagsdata.numberOfHeaders = 4; % For CSV Definition File

handles.flagsdata.graphTitle = '';
%handles.flagsdata.nStepIdx = 0;
handles.flagsdata.time_T = 1.0;
handles.flagsdata.tS0 = 0.0;
handles.flagsdata.tE0 = 1.0;
handles.flagsdata.tStart = -0.005;
handles.flagsdata.tStop = +0.005;

handles.flagsdata.clipVal = 0.2;
handles.flagsdata.Fs       = 44100;

handles.flagsdata.xLabelStr = 'Time';
handles.flagsdata.yLabelStr = 'Time';
handles.flagsdata.xUnitStr = 'sec';
handles.flagsdata.yUnitStr = 'sec';
    
handles.flagsdata.pname = '';
handles.flagsdata.fname = '';
handles.flagsdata.wavFileName = '';

handles.flagsdata.chDefs = {};
handles.flagsdata.ch = {};
handles.flagsdata.csvFileNames = {};
handles.flagsdata.tmpText_chDefs = {};

args = handles;  % input args for GUI_nACF_ICCF() for repeating calc.


tInter = 0.50;
    
numberOfHeaders = 4;
windowScale = 1;

chDefs = {};
ch = {};
csvFileNames = {};

while ( 1 ),
    
    try
        handles = GUI_nACF_ICCF( args );
    catch err
        return;
    end;
    
    if ( 1 ),
        %if ( handles.flagsdata.exitFlag == 1 ) break; end; % Exit from infinite loop of this main procedure
        
        if ( handles.flagsdata.funcFlag == 1 ),
            handles.flagsdata.nacfFlag = 1 ;
            handles.flagsdata.iccfFlag = 0 ;
        elseif ( handles.flagsdata.funcFlag == 2 ),
            handles.flagsdata.nacfFlag = 0 ;
            handles.flagsdata.iccfFlag = 1 ;
        else
            continue;
        end;
        
        %{
        handles.flagsdata.normalizeFlag  = handles.flagsdata.normalizeFlag ;
        handles.flagsdata.nacfAndoFlag  = handles.flagsdata.nacfAndoFlag ;
        handles.flagsdata.phiFlag           = handles.flagsdata.phiFlag ;
        handles.flagsdata.dumpFlag        = handles.flagsdata.dumpFlag ;
        handles.flagsdata.debugFlag       = handles.flagsdata.debugFlag ;
        handles.flagsdata.debugStepFlag = handles.flagsdata.debugStepFlag ;
        handles.flagsdata.plotFlag          = handles.flagsdata.plotFlag ;
        handles.flagsdata.plot3dFlag      = handles.flagsdata.plot3dFlag ;
        handles.flagsdata.playSoundFlag = handles.flagsdata.playSoundFlag ;
        
        handles.flagsdata.calcTauE_VecFlag  = handles.flagsdata.calcTauE_VecFlag ;
        handles.flagsdata.calcTauE_VecFlag  = handles.flagsdata.calcTauE_VecFlag ;
        %}
        
        graphTitle = handles.flagsdata.graphTitle;                        % FORCE to get TITLE name to treat
        tS0 = castNumeric_( handles.flagsdata.tS0 );                 % FORCE to get tS (Start) to cut the whole music signals
        tE0 = castNumeric_( handles.flagsdata.tE0 );  % FORCE to get tE (End)   to cut the whole music signals
        tStart = castNumeric_( handles.flagsdata.tStart );              % FORCE to get tStart to calculate CCF
        tStop  = castNumeric_( handles.flagsdata.tStop );  % FORCE to get tStop  to calculate CCF
        %nStepIdx = castNumeric_( handles.flagsdata.nStepIdx );          % FORCE to get windowSize to calculate Realtime CCF
        time_T = castNumeric_( handles.flagsdata.time_T );          % FORCE to get windowSize to calculate Realtime CCF

        %xLabelStr = handles.flagsdata.xLabelStr;
        %yLabelStr = handles.flagsdata.yLabelStr;
        %xUnitStr = handles.flagsdata.xUnitStr;
        %yUnitStr = handles.flagsdata.yUnitStr;
        
        nStepIdx = 0;

        pname = handles.flagsdata.pname;

        %{
        if isfield(handles.flagsdata, 'ch'),
            ch = handles.flagsdata.ch;
            csvFileNames = handles.flagsdata.csvFileNames;
        else
            ch = zeros( 6, 1 );
        end;
        %}
        if ( strcmp( handles.flagsdata.wavFileName, '' ) ),
            chDefs = handles.flagsdata.chDefs;
            %ch = handles.flagsdata.ch;
            %csvFileNames = handles.flagsdata.csvFileNames;
            ch = chDefs( :, 1 );
            csvFileNames = chDefs( :, 2 );
        else
            ch = zeros( 1, 1 );
        end;
        
        args = handles;
        
    end;
    

    
    bufSize = 30;
    
    
    [ temp, dateTime ] = system('date +%y%m%d%H%M%S');
    dateTime = dateTime( 1 : length(dateTime)-1 );
    
    
    PHI_ll_0 = 0.0;
    PHI_rr_0 = 0.0;
    PHI_lr   = 0.0;
    phi_lr   = 0.0;
    ICCC     = 0.0;
    tauICCC  = 0.0;
    Wiccc    = 0.0;
    
    
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
    
    
    %for i = 1+numberOfHeaders : length(ch),
    for i = 1 : length(ch),
        for j = i+1 : length(ch)+1,
            
            if ( handles.flagsdata.nacfFlag && (j>i+1) ) break; end;   % FORCE to break the inner loop for when nACF
            %if ( handles.flagsdata.nacfFlag && (i==1+numberOfHeaders) && handles.flagsdata.nacfSingleFlag ) break; end;   % FORCE to break the inner loop for when nACF
            if ( handles.flagsdata.nacfFlag && (i==2) && handles.flagsdata.nacfSingleFlag ) break; end;   % FORCE to break the inner loop for when nACF
            if ( handles.flagsdata.iccfFlag && (j==length(ch)+1) ) break; end;   % FORCE to break the inner loop for when ICCF
            
            
            if ( handles.flagsdata.nacfFlag ),
                if ( ~strcmp( handles.flagsdata.wavFileName, '' ) ),
                    
                    xLabel = 'Right';
                    if ( handles.flagsdata.nacfSingleFlag ),
                        yLabel = 'Right';
                    else,
                        yLabel = 'Left';
                    end;
                    xCsvFilename = handles.flagsdata.wavFileName;
                else
                    xLabel = ch{i};
                    xCsvFilename = strcat( pname, csvFileNames{i} );
                    yLabel = ch{i};
                    yCsvFilename = strcat( pname, csvFileNames{i} );
                end;
                funcStr = 'ACF';
                labelStr = xLabel;
                strTitleBase = strcat( '[', xLabel, ']' );
                
            else
                
                if ( ~strcmp( handles.flagsdata.wavFileName, '' ) ),
                    xLabel = 'Right';
                    yLabel = 'Left';
                    xCsvFilename = handles.flagsdata.wavFileName;
                else
                    xLabel = ch{i};
                    xCsvFilename = strcat( pname, csvFileNames{i} );
                    yLabel = ch{j};
                    yCsvFilename = strcat( pname, csvFileNames{j} );
                end;
                funcStr = 'ICCF';
                labelStr = strcat( yLabel, ',', xLabel );
                strTitleBase = strcat( '[', yLabel, ' <-> ', xLabel, ']' );
                
            end;
            
            xLabelStr = ( [ labelStr ': T [' handles.flagsdata.xUnitStr ']' ] );
            yLabelStr = ( [ handles.flagsdata.yLabelStr ' [' handles.flagsdata.yUnitStr ']' ] );
            zLabelStr = ( funcStr );
            
            
            if ( ~strcmp( handles.flagsdata.wavFileName, '' ) ),
                [ s0, fsS ] = audioread( xCsvFilename );
                
                
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
                
                %[ xFilename, xExtension ] = strread( xCsvFilename, '%s', 'delimiter', '.' );
                [ xExtension ] = getFileExtension_( xCsvFilename );
                if ( strcmp( xExtension, 'csv' ) || strcmp( xExtension, 'CSV' ) ),
                    [ x0cell ] = textread( xCsvFilename, '%s', 'delimiter', ',' );
                    x0 = strread( cell2mat( x0cell' ) )';
                    fsX = castNumeric_( handles.flagsdata.Fs );
                else
                    [ x0, fsX ] = audioread( xCsvFilename );
                end;
                
                [ yExtension ] = getFileExtension_( yCsvFilename );
                if ( strcmp( yExtension, 'csv' ) || strcmp( yExtension, 'CSV' ) ),
                    [ y0cell ] = textread( yCsvFilename, '%s', 'delimiter', ',' );
                    y0 = strread( cell2mat( y0cell' ) )';
                    fsY = castNumeric_( handles.flagsdata.Fs );
                else
                    [ y0, fsY ] = audioread( yCsvFilename );
                end;
                
                %[ x0, fsX ] = audioread( xCsvFilename );
                %[ y0, fsY ] = audioread( yCsvFilename );
            end;
            
            %x0 = tmp;
            %y0 = tmp;
            
            fs = fsX;
            
            %fs = 2;
            
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
            
            
            
            if ( handles.flagsdata.playSoundFlag ),
                sound( x, fs );
                break;
                %return;
            end;
            
            
            if ( handles.flagsdata.debugFlag ),
                sound( x, fs );
            end;
            
            
            lenX = length(x);
            lenY = length(y);
            
            % CAUTION!!
            %nStepIdx = ceil( ( tE - tS ) / time_T ) - 1;
            nStepIdx = ceil( ( tE - tS ) / time_T );
            
            windowSize = (tE - tS) / nStepIdx;
            
            tE = tS + windowSize * windowScale;
            
            tS_Idx = convTime2Index_( tS, x0, fs );
            tE_Idx = convTime2Index_( tE, x0, fs ) - 1;
            
            windowSizeIdx = tE_Idx - tS_Idx + 1;
            
            %x = x0( tS_Idx : tE_Idx );
            %y = y0( tS_Idx : tE_Idx );
            x = arraySubstitute_( x0( tS_Idx : tE_Idx ), windowSizeIdx );
            y = arraySubstitute_( y0( tS_Idx : tE_Idx ), windowSizeIdx );
            
            if ( handles.flagsdata.debugStepFlag ) sound( x, fs ); pause( tInter ); end;
            
            %windowSizeIdx = convTime2Index_( windowSize, x, fs );
            
            
            % CAUTION !!!   Add ZERO vector to tail
            %x0 = vertcat( x0, zeros( windowSizeIdx * 2, 1 ) );
            %y0 = vertcat( y0, zeros( windowSizeIdx * 2, 1 ) );
            
            
            %w = HanningWindow_(     length( x ) );
            w = HammingWindow_(     length( x ) );
            %w = BlackmanWindow_(    length( x ) );
            %w = RectangularWindow_( length( x ) );
            
            if (handles.flagsdata.windowFlag),
                x = x .* w';
                y = y .* w';
            end;
            
            
            for (k = 1 : nStepIdx ),
                saveImageName = strcat( funcStr, ',', labelStr, ',' , 'tS,', num2str(tS, '%04.3f'), ',', 'tE,', num2str(tE, '%04.3f'), ',', 'T,', num2str(time_T, '%04.3f'), ',', graphTitle );
                
                
                [ results ] = eval( strcat( 'calc_', funcStr, '_(graphTitle, x, y, fs, bits, tS0, tE0, tS, tE, tStart, tStop, time_T, windowSize, windowSizeIdx, xLabel, yLabel, saveImageName, dateTime, handles.flagsdata )' ) );
                
                
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
                if (handles.flagsdata.iccfFlag && handles.flagsdata.phiFlag),
                    PHI_ll_0Mat( k, : ) = results.PHI_ll_0;
                    PHI_rr_0Mat( k, : ) = results.PHI_rr_0;
                    PHI_lrMat( k, : )   = arraySubstitute_( results.PHI_lr,   firstRdSize( 1,2 ) );
                    phi_lrMat( k, : )   = arraySubstitute_( results.phi_lr,   firstRdSize( 1,2 ) );
                end;
                if (handles.flagsdata.iccfFlag),
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
                
                if ( handles.flagsdata.debugStepFlag ) sound( x, fs ); pause( tInter ); end;
                
                
                %w = HanningWindow_(     length( x ) );
                %w = HammingWindow_(     length( x ) );
                %w = BlackmanWindow_(    length( x ) );
                %w = RectangularWindow_( length( x ) );
                
                if ( handles.flagsdata.windowFlag ),
                    x = x .* w';
                    y = y .* w';
                end;
                %end;
                
            end;
            
            timeVec = (0:nStepIdx-1) * (tE0 - tS0) / nStepIdx-1 + tS0;   % CAUTION!!!
            
            %clipVal = 0.2;
            %clipVal = 0.4;
            %clipVal = 0.01;
            if ( ischar( handles.flagsdata.clipVal( 1 ) ) ),
                clipVal = str2num( handles.flagsdata.clipVal );
            else
                clipVal = handles.flagsdata.clipVal;                
            end;
            
            a = ones( 1, nStepIdx ) .* clipVal;
            
            if ( handles.flagsdata.iccfFlag && handles.flagsdata.calcTauE_VecFlag ),
                subResultDataMat_R = resultDataMat( : , floor ( 1 + size( resultDataMat, 2 ) / 2 ) : size( resultDataMat, 2 ) );
                
                [ maxValVec_R, tauE_Vec_R, tauEidx_Vec_R ] = substitute_peaks_( clipVal, subResultDataMat_R, x0, fs );
                [ env_tauE_Vec_R, env_tauE_Idx_R ] = calc_env_tauE( tauE_Vec_R );
                grad_env_tauE_Vec_R = gradient( env_tauE_Vec_R );
                
                subResultDataMat_L = resultDataMat( : , 1 : floor ( 1 + size( resultDataMat, 2 ) / 2 ) );
                reverseIdx = ( size( subResultDataMat_L, 2 ) : -1 : 1 );
                %reverseIdx = 1 : length(subResultDataMat_L) ;
                subResultDataMat_L = subResultDataMat_L( : , reverseIdx );
                
                [ maxValVec_L, tauE_Vec_L, tauEidx_Vec_L ] = substitute_peaks_( clipVal, subResultDataMat_L, x0, fs );
                [ env_tauE_Vec_L, env_tauE_Idx_L ] = calc_env_tauE( tauE_Vec_L );
                grad_env_tauE_Vec_L = gradient( env_tauE_Vec_L );
            end;
            
            
            if ( handles.flagsdata.nacfFlag && handles.flagsdata.calcTauE_VecFlag  ),
                subResultDataMat_R = resultDataMat;
                
                [ maxValVec_R, tauE_Vec_R, tauEidx_Vec_R ] = substitute_peaks_( clipVal, subResultDataMat_R, x0, fs );
                [ env_tauE_Vec_R, env_tauE_Idx_R ] = calc_env_tauE( tauE_Vec_R );
                grad_env_tauE_Vec_R = gradient( env_tauE_Vec_R );
            end;
            
            
            if (handles.flagsdata.plot3dFlag),
                figNumber = 1;
                figure( figNumber );
                %XYZ = surf( timeAxisMat( 1,: ), timeVec, resultDataMat, 'FaceColor','interp','FaceLighting','phong', 'LineWidth', 0.01, 'EdgeAlpha', 0.3 );
                XYZ = surf( timeAxisMat( 1,: ), timeVec, resultDataMat, 'FaceColor','interp','FaceLighting','phong', 'LineWidth', 0.01, 'EdgeAlpha', 0.01 );
                %XYZ = contour3( timeAxisMat( 1,: ), timeVec, resultDataMat );
                
                grid on;
                hold on;
                
                lw = 3;
                ms = 4;
                
                if ( handles.flagsdata.iccfFlag ),
                    %lc = '-ow';
                    lc = 'ow';
                    
                    plot3( tauICCCMat, timeVec, ICCCMat, lc, 'LineWidth', lw, 'MarkerSize', ms );
                    
                    if ( handles.flagsdata.calcTauE_VecFlag ),
                        lc = '-ow';
                        plot3( arraySubstitute_( tauE_Vec_R, length(timeVec) ), timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                        plot3( arraySubstitute_( -tauE_Vec_L, length(timeVec) ), timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                        
                        lc = '-or';
                        %plot3( env_tauE_Vec_R, timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                        
                        lc = '-oy';
                        %plot3( grad_env_tauE_Vec_R, timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                        
                        lc = '-ob';
                        %plot3( -env_tauE_Vec_L, timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                        
                        lc = '-og';
                        %plot3( -gradient( env_tauE_Vec_L ), timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                    end;
                    
                end;
                
                if ( handles.flagsdata.nacfFlag ),
                    if ( handles.flagsdata.calcTauE_VecFlag ),
                        lc = '-ow';
                        plot3( arraySubstitute_( tauE_Vec_R, length(timeVec) ), timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                        
                        lc = '-or';
                        %plot3( env_tauE_Vec_R, timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                        
                        lc = '-oy';
                        %plot3( gradient( env_tauE_Vec_R ), timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                        
                    end;
                end;
                
                
                xlabel( xLabelStr );
                ylabel( yLabelStr );
                zlabel( zLabelStr );
                
                
                strTitle = strcat( strTitleBase, ' (' ,  num2str(tS0, '%04.3f'), '-', num2str(tE0, '%04.3f'), '), [T : ', num2str(time_T, '%04.3f'), ' ], ', graphTitle);
                title( strTitle );
                
                hold off;
                
                % CAUTION!!!
                saveImageName = strcat( funcStr, ',', labelStr, ',' , 'tS0,', num2str(tS0, '%04.3f'), ',', 'tE0,', num2str(tE0, '%04.3f'), ',', 'T,', num2str(time_T, '%04.3f'), ',', graphTitle );
                fname = strcat( saveImageName, '.fig');
                %pnameImg = strcat( '_Output Images', '/', graphTitle, '_', funcStr , '_', dateTime );
                %pnameImg = strcat( '_Output Images', '/', graphTitle, '_', funcStr , '_', dateTime, '_', 'tS0,', num2str(tS0, '%04.3f'), ',', 'tE0,', num2str(tE0, '%04.3f') );
                pnameImg = strcat( '_Output Images', '/', graphTitle, '_', funcStr , '_', dateTime, '_', 'tS0,', num2str(tS0, '%04.3f'), ',', 'tE0,', num2str(tE0, '%04.3f'), ',', 'T,', num2str(tStop, '%04.3f') );
                if ( exist( pnameImg, 'dir' ) == 0 ),
                    mkdir( pnameImg );
                end;
                outputGraphFileName = strcat( pnameImg, '/', fname );
                saveas( figNumber, strcat( outputGraphFileName ) );
                
                
                if ( handles.flagsdata.nacfFlag && handles.flagsdata.calcTauE_VecFlag ),
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, tauE_Vec_R, 'time [s]', 'tauE Vec R', figNumber, pnameImg, saveImageName);
                    
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, env_tauE_Vec_R, 'time [s]', 'env tauE Vec R', figNumber, pnameImg, saveImageName);
                    
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, grad_env_tauE_Vec_R, 'time [s]', 'grad env tauE Vec R', figNumber, pnameImg, saveImageName);
                end;
                
                if ( handles.flagsdata.iccfFlag && handles.flagsdata.calcTauE_VecFlag ),
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, tauE_Vec_R, 'time [s]', 'tauE Vec R', figNumber, pnameImg, saveImageName);
                    
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, env_tauE_Vec_R, 'time [s]', 'env tauE Vec R', figNumber, pnameImg, saveImageName);
                    
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, grad_env_tauE_Vec_R, 'time [s]', 'grad env tauE Vec R', figNumber, pnameImg, saveImageName);
                    
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, tauE_Vec_L, 'time [s]', 'tauE Vec L', figNumber, pnameImg, saveImageName);
                    
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, env_tauE_Vec_L, 'time [s]', 'env tauE Vec L', figNumber, pnameImg, saveImageName);
                    
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, grad_env_tauE_Vec_L, 'time [s]', 'grad env tauE Vec L', figNumber, pnameImg, saveImageName);
                end;
                
            end;
            
            
            if ( handles.flagsdata.dumpFlag ),
                dump_data_( resultDataMat, 'resultDataMat',  funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( timeAxisMat,    'timeAxis',         funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( maxValuesMat, 'maxValuesMat', funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( maxIdxsMat,     'maxIdxsMat',     funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( zeroIdxsMat,    'zeroIdxsMat',     funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( maxTimesMat,  'maxTimesMat',  funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( tSMat,            'tSMat',             funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( tEMat,            'tEMat',              funcStr, saveImageName, graphTitle, dateTime );
                
                if ( handles.flagsdata.calcTauE_VecFlag ),
                    dump_data_( tauE_Vec_R,              'tauE_Vec_R',              funcStr, saveImageName, graphTitle, dateTime );
                    dump_data_( env_tauE_Vec_R,        'env_tauE_Vec_R',        funcStr, saveImageName, graphTitle, dateTime );
                    dump_data_( grad_env_tauE_Vec_R, 'grad_env_tauE_Vec_R', funcStr, saveImageName, graphTitle, dateTime );
                end;
                
                if ( handles.flagsdata.iccfFlag ),
                    if (handles.flagsdata.phiFlag),
                        dump_data_( PHI_ll_0Mat,   'PHI_ll_0Mat',     funcStr, saveImageName, graphTitle, dateTime );
                        dump_data_( PHI_rr_0Mat,  'PHI_rr_0Mat',    funcStr, saveImageName, graphTitle, dateTime );
                        dump_data_( PHI_lrMat,     'PHI_lrMat',       funcStr, saveImageName, graphTitle, dateTime );
                        dump_data_( phi_lrMat,      'phi_lrMat',       funcStr, saveImageName, graphTitle, dateTime );
                    end;
                    dump_data_( ICCCMat,       'ICCCMat',       funcStr, saveImageName, graphTitle, dateTime );
                    dump_data_( tauICCCMat,   'tauICCCMat',  funcStr, saveImageName, graphTitle, dateTime );
                    dump_data_( WicccMat,      'WicccMat',      funcStr, saveImageName, graphTitle, dateTime );
                    
                    if ( handles.flagsdata.calcTauE_VecFlag ),
                        dump_data_( tauE_Vec_L,              'tauE_Vec_L',              funcStr, saveImageName, graphTitle, dateTime );
                        dump_data_( env_tauE_Vec_L,        'env_tauE_Vec_L',        funcStr, saveImageName, graphTitle, dateTime );
                        dump_data_( grad_env_tauE_Vec_L, 'grad_env_tauE_Vec_L', funcStr, saveImageName, graphTitle, dateTime );
                    end;
                end;
                
                
                dump_data_( timeVec,        'timeVec',        funcStr, saveImageName, graphTitle, dateTime );
            end;
            
            
        end;
    end;
    
    %handles.flagsdata.exitFlag = 1;
    
end;

return;