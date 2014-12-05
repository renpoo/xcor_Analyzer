#close all; 
clear;


pkg load signal;
pkg load io;


numberOfHeaders = 4;


bufSize = 30;


[ fname, pname ] = uigetfile( '*.csv', 'CSV DEFINITION FILE' );
defFileName = strcat( pname, "/", fname );
[ch, csvFileNames] = textread(defFileName, '%s %s','delimiter',',');


graphTitle = ch{1};                   # FORCE to get TITLE name to treat
tS0 = str2num( ch{2} );               # FORCE to get tS (Start) to cut the whole music signals
tE0 = str2num( csvFileNames{2} );     # FORCE to get tE (End)   to cut the whole music signals
tStart = str2num( ch{3} );            # FORCE to get tStart to calculate CCF
tStop  = str2num( csvFileNames{3} );  # FORCE to get tStop  to calculate CCF
nStepIdx = str2num( ch{4} );          # FORCE to get windowSize to calculate Realtime CCF


[temp dateTime] = system("date +%y%m%d%H%M%S");
dateTime = dateTime( 1 : length(dateTime)-1 );


xCsvFilename = csvFileNames{ numberOfHeaders + 1 };


[ x0, fsX, bitsX ] = wavread( xCsvFilename );


fs = fsX;
bits = bitsX;
lenX0 = length(x0);
    

tS = tS0;
tE = tE0;

tS_Idx = convTime2Index_( tS, x0, fs );
tE_Idx = convTime2Index_( tE, x0, fs );

x = x0( tS_Idx : tE_Idx );

     
sound( x, fs );
    
return;
