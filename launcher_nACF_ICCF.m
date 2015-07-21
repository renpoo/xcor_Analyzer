%function launcher_nACF_ICCF( handles )

close all;
clear;


%pkg load signal;
%pkg load io;


results = struct(      ...
    'resultData', [],  ...
    'timeAxis',   [],  ...
    'maxValues',  [],  ...
    'maxIdxs',    [],  ...
    'maxTimes',   [],  ...
    'zeroIdxs',   [],  ...
    'ICCC',        0,  ...
    'tauICCC',     0,  ...
    'Wiccc',       0,  ...
    'PHI_ll_0',    0,  ...
    'PHI_rr_0',    0,  ...
    'PHI_lr',     [],  ...
    'phi_lr',     []  );  


handles = struct( 'data', [] );

handles.data = struct(   ...
    'funcFlag',         1,        ...
    'normalizeFlag',    1,        ...
    'nacfSingleFlag',   0,        ...
    'calcTauE_VecFlag', 0,        ...
    'cyclicFlag',       0,        ...
    'dumpFlag',         0,        ...
    'debugFlag',        1,        ...
    'debugStepFlag',    0,        ...
    'plotFlag',         1,        ...
    'plot3dFlag',       1,        ...
    'playSoundFlag',    0,        ...
    'windowFlag',       0,        ...
    'castSignalFlag',   0,        ...
    'exitFlag',         0,        ...
    'graphTitle',       'Graph Title',   ...
    'timeT',            1.0,      ...
    'timeS0',           0.0,      ...
    'timeE0',           1.0,      ...
    'tauMinus',         -0.005,   ...
    'tauPlus',          +0.005,   ...
    'clipVal',          0.2,      ...
    'Fs',               44100,    ...
    'xLabelStr',        'Tau',    ...
    'yLabelStr',        'Time',   ...
    'xUnitStr',         'ms',     ...
    'yUnitStr',         'sec',    ...
    'xUnitScale',       1000.0, ...
    'yUnitScale',       1.0,    ...
    'pname',            '',       ...
    'fname',            '',       ...
    'wavFileName',      '',       ...
    'defCsvFileName',   '',       ...
    'chDefs',           {},       ...
    'ch',               {},       ...
    'csvFileNames',     {},       ...
    'tmpText_chDefs',   {},       ...
    'nacfAndoFlag',     0,        ...
    'phiFlag',          1,        ...
    'numberOfHeaders',  6   );

%{
handles.data.funcFlag              = 1;
handles.data.normalizeFlag       = 1;
handles.data.nacfSingleFlag      = 0;
handles.data.calcTauE_VecFlag = 0;
handles.data.cyclicFlag            = 0;
handles.data.dumpFlag             = 0;
handles.data.debugFlag            = 1;
handles.data.debugStepFlag      = 0;
handles.data.plotFlag               = 1;
handles.data.plot3dFlag            = 1;
handles.data.playSoundFlag      = 0;
handles.data.windowFlag          = 0;
handles.data.castSignalFlag      = 0;
handles.data.exitFlag               = 0;

handles.data.graphTitle            = 'Graph Title';
handles.data.timeT                 = 1.0;
handles.data.timeS0                     = 0.0;
handles.data.timeE0                     = 1.0;
handles.data.tauMinus                 = -0.005;
handles.data.tauPlus                  = +0.005;
handles.data.clipVal                 = 0.2;
handles.data.Fs                       = 44100;

handles.data.xLabelStr             = 'Time';
handles.data.yLabelStr             = 'Time';
handles.data.xUnitStr              = 'sec';
handles.data.yUnitStr              = 'sec';

handles.data.pname                 = '';
handles.data.fname                  = '';
handles.data.wavFileName        = '';
handles.data.defCsvFileName    = '';

handles.data.chDefs                = {};
handles.data.ch                      = {};
handles.data.csvFileNames       = {};
handles.data.tmpText_chDefs   = {};

handles.data.nacfAndoFlag        = 0;
handles.data.phiFlag                 = 1;

handles.data.numberOfHeaders = 5;
%}

%args = handles;  % input args for GUI_nACF_ICCF() for repeating calc.


intervalTime = 0.0;
bufSize = 30;
    
windowScale = 1;

chDefs = {};
ch = {};
csvFileNames = {};


while ( 1 ),
    
    try
        handles = GUI_nACF_ICCF( handles );
    catch err
        return;
    end;

    
    %handles.data.numberOfHeaders = 0;

    
    if ( 1 ),
        if ( handles.data.exitFlag == 1 ) break; end; % Exit from infinite loop of this main procedure

        
        if ( handles.data.funcFlag == 1 ),
            handles.data.nacfFlag = 1 ;
            handles.data.iccfFlag = 0 ;
        elseif ( handles.data.funcFlag == 2 ),
            handles.data.nacfFlag = 0 ;
            handles.data.iccfFlag = 1 ;
        else
            handles.data.nacfFlag = 1 ;
            handles.data.iccfFlag = 0 ;
        end;

        
        graphTitle = ez_sanitize_( handles.data.graphTitle );    % FORCE to get TITLE name to treat
        timeS0   = castNum_( getVal_( handles.data.timeS0 ) );   % FORCE to get timeS0 (Start) to cut the whole music signals
        timeE0   = castNum_( getVal_( handles.data.timeE0 ) );   % FORCE to get timeE0 (End)   to cut the whole music signals
        tauMinus = castNum_( getVal_( handles.data.tauMinus ) ); % FORCE to get tauMinus to calculate CCF
        tauPlus  = castNum_( getVal_( handles.data.tauPlus ) );  % FORCE to get tauPlus  to calculate CCF
        timeT    = castNum_( getVal_( handles.data.timeT ) );    % FORCE to get windowSize to calculate Realtime CCF


        nStepIdx = 0;

        
        pname = handles.data.pname;

        
        if ( strcmp( handles.data.wavFileName, '' ) ),
            chDefs = handles.data.chDefs;
            ch = handles.data.ch;
            csvFileNames = handles.data.csvFileNames;
            handles.data.numberOfHeaders = 6;
        else
            ch{ 1 } = 'WAV';
            ch{ 2 } = 'WAV';
            handles.data.numberOfHeaders = 0;
        end;
        
        args = handles;
        
    end;
    
 
    [ temp, dateTime ] = system('date +%y%m%d%H%M%S');
    dateTime = dateTime( 1 : length(dateTime)-1 );
    
    
    PHI_ll_0    = 0.0;
    PHI_rr_0   = 0.0;
    PHI_lr      = 0.0;
    phi_lr       = 0.0;
    ICCC      = 0.0;
    tauICCC  = 0.0;
    Wiccc     = 0.0;
    
    
    clear resultDataMat;
    clear timeAxisMat;
    clear maxValuesMat;
    clear maxIdxsMat;
    clear zeroIdxsMat;
    clear maxTimesMat;
    clear timeSMat;
    clear timeEMat;
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
    
    
    for i = handles.data.numberOfHeaders + 1 : length(ch),
    %for i = 1 : length(ch),
        %for j = i+1 : length(ch)+1,
        for j = i+1 : length(ch),
            
            % ACF:
            % GUARDIAN: to cut the caluculation for the other combinations
            if ( handles.data.nacfFlag && (j>i+1) ) break; end;
            % ICCF:
            % GUARDIAN: to cut the caluculation for the mirror combinations
            if ( handles.data.iccfFlag && (j>i+1) ) break; end;
            %if ( handles.data.iccfFlag && (j>i) ) break; end;
            % ACF:
            % GUARDIAN: for single channel calculation on STEREO sound
            if ( handles.data.nacfFlag && (i==2) && handles.data.nacfSingleFlag ) break; end;
            
            
            if ( handles.data.nacfFlag == 1 ),
                if ( ~strcmp( handles.data.wavFileName, '' ) ), % For single WAV file
                    handles.data.numberOfHeaders = 0;
                    
                    R_Label = 'Right';
                    L_Label = 'Left';
                    R_CsvFilename = handles.data.wavFileName;
                else % For Multiple WAV file by setting .csv
                    %if ( handles.data.numberOfHeaders + 1 > i ) break; end;
                    R_Label = ch{i};
                    R_CsvFilename = strcat( pname, csvFileNames{i} );
                    L_Label = ch{i};
                    L_CsvFilename = strcat( pname, csvFileNames{i} );
                end;
                funcStr = 'ACF';
                labelStr = R_Label;
                strTitleBase = strcat( '[', R_Label, ']' );
                
            else
                if ( ~strcmp( handles.data.wavFileName, '' ) ), % For single WAV file
                    handles.data.numberOfHeaders = 0;

                    R_Label = 'Right';
                    L_Label = 'Left';
                    R_CsvFilename = handles.data.wavFileName;
                else % For Multiple WAV file by setting .csv
                    %if ( handles.data.numberOfHeaders + 1 > i ) break; end;
                    R_Label = ch{i};
                    R_CsvFilename = strcat( pname, csvFileNames{i} );
                    L_Label = ch{j};
                    L_CsvFilename = strcat( pname, csvFileNames{j} );
                end;
                funcStr = 'ICCF';
                labelStr = strcat( '[', L_Label, ' <-> ', R_Label, ']' );
                strTitleBase = strcat( '[', L_Label, ' <-> ', R_Label, ']' );
                
            end;
            
            %xLabelStr = ( [ labelStr ': Tau [' handles.data.xUnitStr ']' ] );
            xLabelStr = ( [ handles.data.xLabelStr ' [' handles.data.xUnitStr ']' ] );
            yLabelStr = ( [ handles.data.yLabelStr ' [' handles.data.yUnitStr ']' ] );
            zLabelStr = ( funcStr );
            
            
            if ( ~strcmp( handles.data.wavFileName, '' ) ), % When single WAV file provided
                [ s0, fsS ] = audioread( R_CsvFilename );
                
                
                if ( size( s0, 2) == 2 ),   % STEREO
                    x0 = s0( :, 2 );
                    y0 = s0( :, 1 );
                else   % MONO
                    x0 = s0;
                    y0 = s0;
                end;
                
                fsX = fsS;
                fsY = fsS;
                
            else % When setting CSV file provided
                
                [ xExtension ] = getFileExtension_( R_CsvFilename );
                if ( strcmp( xExtension, 'csv' ) || strcmp( xExtension, 'CSV' ) ),
                    [ x0cell ] = textread( R_CsvFilename, '%s', 'delimiter', ',' );
                    x0 = strread( cell2mat( x0cell' ) )';
                    fsX = castNum_( getVal_( handles.data.Fs ) );
                else
                    %if ( handles.data.numberOfHeaders + 1 > i ) break; end;
                    [ x0, fsX ] = audioread( R_CsvFilename );
                    if ( size( x0, 2) == 2 ),   % STEREO
                        x0 = x0( :, 2 );
                    else   % MONO
                        x0 = x0;
                    end;
                end;
                
                [ yExtension ] = getFileExtension_( L_CsvFilename );
                if ( strcmp( yExtension, 'csv' ) || strcmp( yExtension, 'CSV' ) ),
                    [ y0cell ] = textread( L_CsvFilename, '%s', 'delimiter', ',' );
                    y0 = strread( cell2mat( y0cell' ) )';
                    fsY = castNum_( getVal_( handles.data.Fs ) );
                else
                    %if ( handles.data.numberOfHeaders + 1 > i ) break; end;
                    [ y0, fsY ] = audioread( L_CsvFilename );
                    if ( size( y0, 2) == 2 ),   % STEREO
                        y0 = y0( :, 1 );
                    else   % MONO
                        y0 = y0;
                    end;
                end;
                
            end;
            
            
            fs = fsX;
            bits = 0;

            lenX0 = length(x0);
            lenY0 = length(y0);
            
            
            timeS = timeS0;
            timeE = timeE0;

            
            timeS_Idx = convTime2Index_( timeS, x0, fs );
            timeE_Idx = convTime2Index_( timeE, x0, fs ) - 1;
            %timeE_Idx = convTime2Index_( timeE, x0, fs );

            
            x = x0( timeS_Idx : timeE_Idx );
            y = y0( timeS_Idx : timeE_Idx );
                        
            
            if ( handles.data.playSoundFlag ),
                sound( x, fs );
                handles.data.playSoundFlag = 0;
                %continue;
                break;
            end;
            
            
            if ( handles.data.debugFlag ),
                sound( x, fs );
            end;
            
            
            lenX = length(x);
            lenY = length(y);

            
            % CAUTION!!
            timePeriod = timeE - timeS;
            nStepIdx = ceil( timePeriod / timeT );
            windowSize = timePeriod / nStepIdx;
            timeE = timeS + timeT;
            timeS_Idx = convTime2Index_( timeS, x0, fs );
            timeE_Idx = convTime2Index_( timeE, x0, fs );
            windowSizeIdx = timeE_Idx - timeS_Idx + 1;
            
            x = arraySubstitute_( x0( timeS_Idx : timeE_Idx ), windowSizeIdx );
            y = arraySubstitute_( y0( timeS_Idx : timeE_Idx ), windowSizeIdx );
            
            if ( handles.data.debugStepFlag ), sound( x, fs ); pause( intervalTime ); end;
                                    
            
            %w = HanningWindow_( length( x ) );
            w = HammingWindow_( length( x ) );
            %w = BlackmanWindow_( length( x ) );
            %w = RectangularWindow_( length( x ) );

            
            if (handles.data.windowFlag),
                x = x .* w';
                y = y .* w';
            end;
            
            
            for (k = 1 : nStepIdx ),
                saveImageName = strcat( funcStr, ',', labelStr, ',' , 'timeS,', num2str(timeS, '%04.3f'), ',', 'timeE,', num2str(timeE, '%04.3f'), ',', 'T,', num2str(timeT, '%04.3f'), ',', graphTitle );
                
                
                [ results ] = eval( strcat( 'calc_', funcStr, '_(graphTitle, x, y, fs, bits, timeS0, timeE0, timeS, timeE, tauMinus, tauPlus, timeT, windowSize, windowSizeIdx, strTitleBase, xLabelStr, yLabelStr, saveImageName, dateTime, handles.data )' ) );
                
                
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
                timeSMat( k, : )         = timeS;
                timeEMat( k, : )         = timeE;
                if (handles.data.iccfFlag && handles.data.phiFlag),
                    PHI_ll_0Mat( k, : ) = results.PHI_ll_0;
                    PHI_rr_0Mat( k, : ) = results.PHI_rr_0;
                    PHI_lrMat( k, : )   = arraySubstitute_( results.PHI_lr,   firstRdSize( 1,2 ) );
                    phi_lrMat( k, : )   = arraySubstitute_( results.phi_lr,   firstRdSize( 1,2 ) );
                end;
                if (handles.data.iccfFlag),
                    ICCCMat( k, : )       = results.ICCC;
                    tauICCCMat( k, : )    = results.tauICCC;
                    WicccMat( k, : )      = results.Wiccc;
                end;
                
                
                timeS = timeS0 + timeT * k;
                timeE = timeS + timeT;
                
                
                timeS_Idx = convTime2Index_( timeS, x0, fs );
                timeE_Idx = convTime2Index_( timeE, x0, fs );
                
                
                if ( length(x0) <= timeE_Idx ),
                    timeE_Idx = length(x0) - 1;
                end;

                
                x = arraySubstitute_( x0( timeS_Idx : timeE_Idx ), windowSizeIdx );
                y = arraySubstitute_( y0( timeS_Idx : timeE_Idx ), windowSizeIdx );

                
                if ( handles.data.debugStepFlag ), sound( x, fs ); pause( intervalTime ); end;
                

                if ( handles.data.windowFlag ),
                    x = x .* w';
                    y = y .* w';
                end;
                
            end;

            
            % CAUTION!!!
            timeVec = ( 0 : nStepIdx-1 ) * ( timeE0 - timeS0 + timeT ) / nStepIdx + timeS0;
            

            % Clipping Plane
            if ( ischar( handles.data.clipVal( 1 ) ) ),
                clipVal = str2double( handles.data.clipVal );
            else
                clipVal = handles.data.clipVal;                
            end;            
            a = ones( 1, nStepIdx ) .* clipVal;

            
            if ( handles.data.iccfFlag && handles.data.calcTauE_VecFlag ),
                subResultDataMat_R = resultDataMat( : , floor ( 1 + size( resultDataMat, 2 ) / 2 ) : size( resultDataMat, 2 ) );
                
                [ maxValVec_R, tauE_Vec_R, tauEidx_Vec_R ] = substitute_peaks_( clipVal, subResultDataMat_R, x0, fs, handles.data.xUnitScale );
                [ env_tauE_Vec_R, env_tauE_Idx_R ] = calc_env_tauE( tauE_Vec_R );
                grad_env_tauE_Vec_R = gradient( env_tauE_Vec_R );
                
                subResultDataMat_L = resultDataMat( : , 1 : floor ( 1 + size( resultDataMat, 2 ) / 2 ) );
                reverseIdx = ( size( subResultDataMat_L, 2 ) : -1 : 1 );
                subResultDataMat_L = subResultDataMat_L( : , reverseIdx );
                
                [ maxValVec_L, tauE_Vec_L, tauEidx_Vec_L ] = substitute_peaks_( clipVal, subResultDataMat_L, x0, fs, handles.data.xUnitScale );
                [ env_tauE_Vec_L, env_tauE_Idx_L ] = calc_env_tauE( tauE_Vec_L );
                grad_env_tauE_Vec_L = gradient( env_tauE_Vec_L );
            end;
            
            
            if ( handles.data.nacfFlag && handles.data.calcTauE_VecFlag  ),
                subResultDataMat_R = resultDataMat;
                
                [ maxValVec_R, tauE_Vec_R, tauEidx_Vec_R ] = substitute_peaks_( clipVal, subResultDataMat_R, x0, fs, handles.data.xUnitScale  );
                [ env_tauE_Vec_R, env_tauE_Idx_R ] = calc_env_tauE( tauE_Vec_R );
                grad_env_tauE_Vec_R = gradient( env_tauE_Vec_R );
            end;
            
            
            if (handles.data.plot3dFlag),
                figNumber = 1;
                figure( figNumber );
                XYZ = surf( timeAxisMat( 1,: ), timeVec, resultDataMat, 'FaceColor','interp','FaceLighting','phong', 'LineWidth', 0.01, 'EdgeAlpha', 0.01 );
                %XYZ = mesh( timeAxisMat( 1,: ), timeVec, resultDataMat );
                colormap 'jet';
                %colormap( autumn(5) )
                
                grid on;
                hold on;
                
                lw = 3;
                ms = 4;
                
                if ( handles.data.iccfFlag ),
                    lc = 'ow';
                    
                    plot3( tauICCCMat, timeVec, ICCCMat, lc, 'LineWidth', lw, 'MarkerSize', ms );
                    
                    if ( handles.data.calcTauE_VecFlag ),
                        lc = '-ow';
                        plot3( arraySubstitute_( tauE_Vec_R, length(timeVec) ), timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                        plot3( arraySubstitute_( -tauE_Vec_L, length(timeVec) ), timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                        

                        if ( 0 ),
                            lc = '-or';
                            plot3( env_tauE_Vec_R, timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                            
                            lc = '-oy';
                            plot3( grad_env_tauE_Vec_R, timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                            
                            lc = '-ob';
                            plot3( -env_tauE_Vec_L, timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                            
                            lc = '-og';
                            plot3( -gradient( env_tauE_Vec_L ), timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                        end;
                    end;
                    
                end;
                
                if ( handles.data.nacfFlag ),
                    if ( handles.data.calcTauE_VecFlag ),
                        lc = '-ow';
                        plot3( arraySubstitute_( tauE_Vec_R, length(timeVec) ), timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                        
                        if ( 0 ),
                            lc = '-or';
                            plot3( env_tauE_Vec_R, timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                            
                            lc = '-oy';
                            plot3( gradient( env_tauE_Vec_R ), timeVec, a, lc, 'LineWidth', lw, 'MarkerSize', ms );
                        end;
                    end;
                end;
                
                
                xlabel( xLabelStr );
                ylabel( yLabelStr );
                zlabel( zLabelStr );
                
                
                strTitle = strcat( strTitleBase, ' (' ,  num2str(timeS0, '%04.3f'), '-', num2str(timeE0, '%04.3f'), '), [T : ', num2str(timeT, '%04.3f'), ' ], ', graphTitle);
                title( strTitle );
                
                hold off;

                
                
                % Save the 3D surf graph
                saveImageName = strcat( funcStr, ',', labelStr, ',' , 'timeS0,', num2str(timeS0, '%04.3f'), ',', 'timeE0,', num2str(timeE0, '%04.3f'), ',', 'T,', num2str(timeT, '%04.3f'), ',', graphTitle );
                fname = strcat( saveImageName, '.fig');
                pnameImg = strcat( '_Output Images', '/', graphTitle, '_', funcStr , '_', dateTime, '_', 'timeS0,', num2str(timeS0, '%04.3f'), ',', 'timeE0,', num2str(timeE0, '%04.3f'), ',', 'T,', num2str(tauPlus, '%04.3f') );

                if ( exist( pnameImg, 'dir' ) == 0 ),
                    mkdir( pnameImg );
                end;

                outputGraphFileName = strcat( pnameImg, '/', fname );
                saveas( figNumber, strcat( outputGraphFileName ) );
                
                
                if ( handles.data.nacfFlag && handles.data.calcTauE_VecFlag ),
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, tauE_Vec_R, 'time [s]', 'tauE Vec R [ms]', figNumber, pnameImg, saveImageName);
                    
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, env_tauE_Vec_R, 'time [s]', 'env tauE Vec R [ms]', figNumber, pnameImg, saveImageName);
                    
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, grad_env_tauE_Vec_R, 'time [s]', 'grad env tauE Vec R [ms]', figNumber, pnameImg, saveImageName);
                end;
                
                if ( handles.data.iccfFlag && handles.data.calcTauE_VecFlag ),
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, tauE_Vec_R, 'time [s]', 'tauE Vec R [ms]', figNumber, pnameImg, saveImageName);
                    
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, env_tauE_Vec_R, 'time [s]', 'env tauE Vec R [ms]', figNumber, pnameImg, saveImageName);
                    
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, grad_env_tauE_Vec_R, 'time [s]', 'grad env tauE Vec R [ms]', figNumber, pnameImg, saveImageName);
                    
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, tauE_Vec_L, 'time [s]', 'tauE Vec L [ms]', figNumber, pnameImg, saveImageName);
                    
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, env_tauE_Vec_L, 'time [s]', 'env tauE Vec L [ms]', figNumber, pnameImg, saveImageName);
                    
                    figNumber = figNumber + 1;
                    [ outputGraphFileName ] = plot2dGraph( timeVec, grad_env_tauE_Vec_L, 'time [s]', 'grad env tauE Vec L [ms]', figNumber, pnameImg, saveImageName);
                end;
                
            end;
            
            
            if ( handles.data.dumpFlag ),
                dump_data_( resultDataMat, 'resultDataMat',  funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( timeAxisMat,    'timeAxis',         funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( maxValuesMat, 'maxValuesMat', funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( maxIdxsMat,     'maxIdxsMat',     funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( zeroIdxsMat,    'zeroIdxsMat',     funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( maxTimesMat,  'maxTimesMat',  funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( timeSMat,            'timeSMat',             funcStr, saveImageName, graphTitle, dateTime );
                dump_data_( timeEMat,            'timeEMat',              funcStr, saveImageName, graphTitle, dateTime );
                
                if ( handles.data.calcTauE_VecFlag ),
                    dump_data_( tauE_Vec_R,              'tauE_Vec_R',              funcStr, saveImageName, graphTitle, dateTime );
                    dump_data_( env_tauE_Vec_R,        'env_tauE_Vec_R',        funcStr, saveImageName, graphTitle, dateTime );
                    dump_data_( grad_env_tauE_Vec_R, 'grad_env_tauE_Vec_R', funcStr, saveImageName, graphTitle, dateTime );
                end;
                
                if ( handles.data.iccfFlag ),
                    if (handles.data.phiFlag),
                        dump_data_( PHI_ll_0Mat,   'PHI_ll_0Mat',     funcStr, saveImageName, graphTitle, dateTime );
                        dump_data_( PHI_rr_0Mat,  'PHI_rr_0Mat',    funcStr, saveImageName, graphTitle, dateTime );
                        dump_data_( PHI_lrMat,     'PHI_lrMat',       funcStr, saveImageName, graphTitle, dateTime );
                        dump_data_( phi_lrMat,      'phi_lrMat',       funcStr, saveImageName, graphTitle, dateTime );
                    end;
                    dump_data_( ICCCMat,       'ICCCMat',       funcStr, saveImageName, graphTitle, dateTime );
                    dump_data_( tauICCCMat,   'tauICCCMat',  funcStr, saveImageName, graphTitle, dateTime );
                    dump_data_( WicccMat,      'WicccMat',      funcStr, saveImageName, graphTitle, dateTime );
                    
                    if ( handles.data.calcTauE_VecFlag ),
                        dump_data_( tauE_Vec_L,              'tauE_Vec_L',              funcStr, saveImageName, graphTitle, dateTime );
                        dump_data_( env_tauE_Vec_L,        'env_tauE_Vec_L',        funcStr, saveImageName, graphTitle, dateTime );
                        dump_data_( grad_env_tauE_Vec_L, 'grad_env_tauE_Vec_L', funcStr, saveImageName, graphTitle, dateTime );
                    end;
                end;
                
                
                dump_data_( timeVec,        'timeVec',        funcStr, saveImageName, graphTitle, dateTime );
            end;
            
            
        end;

        handles.data.playSoundFlag = 0;                

    end;
    
    
    handles.data.playSoundFlag = 0;                
    %handles.data.exitFlag = 1;
    
end;

return;