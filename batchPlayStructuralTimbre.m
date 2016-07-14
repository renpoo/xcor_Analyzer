%function batchPlayStructuralTimbre( xlsxFilename )

clear;

%xlsxFilename = './_CSVs/ST_Test__100Hz__var_nSpikes.xlsx';
%xlsxFilename = './_CSVs/ST_Test__100Hz__var_fSigma.xlsx';
%xlsxFilename = './_CSVs/ST_Test__100Hz__var_fSkew.xlsx';
%xlsxFilename = './_CSVs/ST_Test__100Hz__var_fSkew_negative.xlsx';
%xlsxFilename = './_CSVs/ST_Test__100Hz__var_fKurt.xlsx';
%xlsxFilename = './_CSVs/ST_Test__200Hz__var_nSpikes.xlsx';
%xlsxFilename = './_CSVs/ST_Test__200Hz__var_fSigma.xlsx';
%xlsxFilename = './_CSVs/ST_Test__200Hz__var_fSkew.xlsx';
%xlsxFilename = './_CSVs/ST_Test__200Hz__var_fSkew_negative.xlsx';
%xlsxFilename = './_CSVs/ST_Test__200Hz__var_fKurt.xlsx';
%xlsxFilename = './_CSVs/ST_Test__400Hz__var_nSpikes.xlsx';
%xlsxFilename = './_CSVs/ST_Test__400Hz__var_fSigma.xlsx';
%xlsxFilename = './_CSVs/ST_Test__400Hz__var_fSkew.xlsx';
%xlsxFilename = './_CSVs/ST_Test__400Hz__var_fSkew_negative.xlsx';
%xlsxFilename = './_CSVs/ST_Test__400Hz__var_fKurt.xlsx';
%xlsxFilename = './_CSVs/ST_Test__800Hz__var_nSpikes.xlsx';
%xlsxFilename = './_CSVs/ST_Test__800Hz__var_fSigma.xlsx';
%xlsxFilename = './_CSVs/ST_Test__800Hz__var_fSkew.xlsx';
%xlsxFilename = './_CSVs/ST_Test__800Hz__var_fSkew_negative.xlsx';
%xlsxFilename = './_CSVs/ST_Test__800Hz__var_fKurt.xlsx';
%xlsxFilename = './_CSVs/ST_Test__1600Hz__var_nSpikes.xlsx';
%xlsxFilename = './_CSVs/ST_Test__1600Hz__var_fSigma.xlsx';
%xlsxFilename = './_CSVs/ST_Test__1600Hz__var_fSkew.xlsx';
%xlsxFilename = './_CSVs/ST_Test__1600Hz__var_fSkew_negative.xlsx';
xlsxFilename = './_CSVs/ST_Test__1600Hz__var_fKurt.xlsx';


[ extension ] = getFileExtension_( xlsxFilename );
if ( strcmp( extension, 'xlsx' ) || strcmp( extension, 'XLSX' ) ),
    [ dC ] = readtable( xlsxFilename );
else
    disp('ERROR: batchPlayStructuralTimbre(): Cannot read the .xlsx definition file.');
    return;
end;


idx = 1 : max( dC.nSpikes );


for i = 1 : height( dC ),
        
    fprintf( 'funcPlayStructuralTimbre( %4.0f, %4.2f, %4.2f, %4.0f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %d, %d, %d, %d );\n', ...
        dC.fs(i), dC.duration(i), dC.interval(i), dC.nSpikes(i), dC.AMean(i), dC.ASigma(i), dC.ASkew(i), dC.AKurt(i), dC.fMean(i), dC.fSigma(i), dC.fSkew(i), dC.fKurt(i), dC.thetaMean(i), dC.thetaSigma(i), dC.thetaSkew(i), dC.thetaKurt(i), dC.flagAmplitude(i), dC.flagFrequency(i), dC.flagPhase(i), dC.flagSortAfter(i) );
    
    [ A, f, theta, idx ] = funcPlayStructuralTimbre( dC.fs(i), dC.duration(i), dC.interval(i), dC.nSpikes(i), dC.AMean(i), dC.ASigma(i), dC.ASkew(i), dC.AKurt(i), dC.fMean(i), dC.fSigma(i), dC.fSkew(i), dC.fKurt(i), dC.thetaMean(i), dC.thetaSigma(i), dC.thetaSkew(i), dC.thetaKurt(i), dC.flagAmplitude(i), dC.flagFrequency(i), dC.flagPhase(i), dC.flagSortAfter(i) );    

    ARec( i, : )     = vectorReshape_( A,     max( dC.nSpikes ) );
    fRec( i, : )     = vectorReshape_( f,     max( dC.nSpikes ) );
    thetaRec( i, : ) = vectorReshape_( theta, max( dC.nSpikes ) );
end;

