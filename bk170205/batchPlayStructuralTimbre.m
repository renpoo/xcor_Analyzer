%function batchPlayStructuralTimbre( xlsxFilename )


clear;


pname = './_CSVs/';

%xlsxFilename = 'ST_Test__100Hz__var_nSpikes.xlsx';
%xlsxFilename = 'ST_Test__100Hz__var_fSigma.xlsx';
%xlsxFilename = 'ST_Test__100Hz__var_fSkew.xlsx';
%xlsxFilename = 'ST_Test__100Hz__var_fSkew_negative.xlsx';
%xlsxFilename = 'ST_Test__100Hz__var_fKurt.xlsx';
%xlsxFilename = 'ST_Test__200Hz__var_nSpikes.xlsx';
%xlsxFilename = 'ST_Test__200Hz__var_fSigma.xlsx';
%xlsxFilename = 'ST_Test__200Hz__var_fSkew.xlsx';
%xlsxFilename = 'ST_Test__200Hz__var_fSkew_negative.xlsx';
%xlsxFilename = 'ST_Test__200Hz__var_fKurt.xlsx';
%xlsxFilename = 'ST_Test__400Hz__var_nSpikes.xlsx';
%xlsxFilename = 'ST_Test__400Hz__var_fSigma.xlsx';
%xlsxFilename = 'ST_Test__400Hz__var_fSkew.xlsx';
%xlsxFilename = 'ST_Test__400Hz__var_fSkew_negative.xlsx';
%xlsxFilename = 'ST_Test__400Hz__var_fKurt.xlsx';
%xlsxFilename = 'ST_Test__800Hz__var_nSpikes.xlsx';
%xlsxFilename = 'ST_Test__800Hz__var_fSigma.xlsx';
%xlsxFilename = 'ST_Test__800Hz__var_fSkew.xlsx';
%xlsxFilename = 'ST_Test__800Hz__var_fSkew_negative.xlsx';
%xlsxFilename = 'ST_Test__800Hz__var_fKurt.xlsx';
xlsxFilename = 'ST_Test__1600Hz__var_nSpikes.xlsx';
%xlsxFilename = 'ST_Test__1600Hz__var_fSigma.xlsx';
%xlsxFilename = 'ST_Test__1600Hz__var_fSkew.xlsx';
%xlsxFilename = 'ST_Test__1600Hz__var_fSkew_negative.xlsx';
%xlsxFilename = 'ST_Test__1600Hz__var_fKurt.xlsx';


[ extension ] = getFileExtension_( strcat( pname, xlsxFilename ) );
if ( strcmp( extension, 'xlsx' ) || strcmp( extension, 'XLSX' ) ),
    [ dC ] = readtable( strcat( pname, xlsxFilename ) );
else
    disp('ERROR: batchPlayStructuralTimbre(): Cannot read the .xlsx definition file.');
    return;
end;


[ temp, dateTime ] = system('date +%y%m%d%H%M%S');
dateTime = dateTime( 1 : length(dateTime)-1 );


for i = 1 : height( dC ),
    
    %continue;
    
    fprintf( 'funcPlayStructuralTimbre( %4.0f, %4.2f, %4.2f, %4.0f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %d, %d, %d, %d );\n', ...
        dC.fs(i), dC.duration(i), dC.interval(i), dC.nSpikes(i), dC.AMean(i), dC.ASigma(i), dC.ASkew(i), dC.AKurt(i), dC.fMean(i), dC.fSigma(i), dC.fSkew(i), dC.fKurt(i), dC.thetaMean(i), dC.thetaSigma(i), dC.thetaSkew(i), dC.thetaKurt(i), dC.flagAmplitude(i), dC.flagFrequency(i), dC.flagPhase(i), dC.flagSortAfter(i) );
    
    [ A, f, theta, idx ] = funcPlayStructuralTimbre( dC.fs(i), dC.duration(i), dC.interval(i), dC.nSpikes(i), dC.AMean(i), dC.ASigma(i), dC.ASkew(i), dC.AKurt(i), dC.fMean(i), dC.fSigma(i), dC.fSkew(i), dC.fKurt(i), dC.thetaMean(i), dC.thetaSigma(i), dC.thetaSkew(i), dC.thetaKurt(i), dC.flagAmplitude(i), dC.flagFrequency(i), dC.flagPhase(i), dC.flagSortAfter(i) );
    
    ARec( i, : )     = vectorReshape_( A,     max( dC.nSpikes ) );
    fRec( i, : )     = vectorReshape_( f,     max( dC.nSpikes ) );
    thetaRec( i, : ) = vectorReshape_( theta, max( dC.nSpikes ) );
    
    
end;


figure( 1 );
surf( idx, [ 1 : length( dC.nSpikes ) ], ARec, 'FaceColor','interp','FaceLighting','phong', 'LineWidth', 0.5, 'EdgeAlpha', 0.5 );
colormap 'jet';
grid on;
hold on;
xlabel( '# of Spikes' );
ylabel( '# of Iterations' );
zlabel( 'Amplitudes' );
title( strcat( 'Surf View of Amplitudes_', xlsxFilename ) );
hold off;
saveImageName = strcat( 'Amplitudes_for_', xlsxFilename, '.wav' );
fname = strcat( saveImageName, '.fig');
pnameImg = strcat( './_Output Images', '/', xlsxFilename, '_', dateTime );
if ( exist( pnameImg, 'dir' ) == 0 ),
    mkdir( pnameImg );
end;
outputGraphFileName = strcat( pnameImg, '/', fname );
saveas( 1, outputGraphFileName );


figure( 2 );
surf( idx, [ 1 : length( dC.nSpikes ) ], fRec, 'FaceColor','interp','FaceLighting','phong', 'LineWidth', 0.5, 'EdgeAlpha', 0.5 );
colormap 'jet';
grid on;
hold on;
xlabel( '# of Spikes' );
ylabel( '# of Iterations' );
zlabel( 'Frequencies' );
title( strcat( 'Surf View of Frequencies_', xlsxFilename ) );
hold off;
saveImageName = strcat( 'Frequencies_for_', xlsxFilename, '.wav' );
fname = strcat( saveImageName, '.fig');
%pnameImg = strcat( './_Output Images', '/', xlsxFilename, '_', dateTime );
%if ( exist( pnameImg, 'dir' ) == 0 ),
%    mkdir( pnameImg );
%end;
outputGraphFileName = strcat( pnameImg, '/', fname );
saveas( 2, outputGraphFileName );


figure( 3 );
surf( idx, [ 1 : length( dC.nSpikes ) ], thetaRec, 'FaceColor','interp','FaceLighting','phong', 'LineWidth', 0.5, 'EdgeAlpha', 0.5 );
colormap 'jet';
grid on;
hold on;
xlabel( '# of Spikes' );
ylabel( '# of Iterations' );
zlabel( 'Phases' );
title( strcat( 'Surf View of Phases_', xlsxFilename ) );
hold off;
saveImageName = strcat( 'Phases_for_', xlsxFilename, '.wav' );
fname = strcat( saveImageName, '.fig');
%pnameImg = strcat( './_Output Images', '/', xlsxFilename, '_', dateTime );
%if ( exist( pnameImg, 'dir' ) == 0 ),
%    mkdir( pnameImg );
%end;
outputGraphFileName = strcat( pnameImg, '/', fname );
saveas( 3, outputGraphFileName );


