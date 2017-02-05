%function replaySoundsForTest( )

clear;
close all;


[ fname, pname ] = uigetfile( '_CSVs/*.csv', 'CSV Definition File' );
defCsvFileName = strcat( pname, fname );

fileID = fopen( defCsvFileName );
[ scanData ] = textscan( fileID, '%s', 'delimiter', ',' );
fclose(fileID);


readingWavFileNames = scanData{ 1, 1 };


for i = 1 : length(readingWavFileNames),

    disp( strcat( '### index = ', num2str(i), ' ### ' ) );
    disp( ( readingWavFileNames{ i } ) );
    
    [ s, fs ] = audioread( readingWavFileNames{ i } );
    duration = length( s ) / fs;
    interval = duration;
    sound( s, fs );
    pause( duration + interval );
end;
