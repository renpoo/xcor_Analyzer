%function replaySoundsForTest( )

%clear;
%close all;


[ fname, pname ] = uigetfile( '_CSVs/*.csv', 'CSV Definition File' );
defCsvFileName = strcat( pname, fname );

fileID = fopen( defCsvFileName );
[ scanData ] = textscan( fileID, '%s', 'delimiter', ',' );
fclose(fileID);


readingWavFileNames1 = scanData{ 1, 1 }{ 1, 1 };
readingWavFileNames2 = scanData{ 1, 1 }{ 2, 1 };
readingWavFileNames3 = scanData{ 1, 1 }{ 3, 1 };
%readingWavFileNames4 = scanData{ 1, 1 }{ 4, 1 };
readingWavFileNames5 = scanData{ 1, 1 };

for i = 1 : 1,

    disp( strcat( '### index = ', num2str(i), ' ### ' ) );
    %disp( strcat( readingWavFileNames1, readingWavFileNames2, readingWavFileNames3, readingWavFileNames4 ) );
    
    [ s1, fs ] = audioread( readingWavFileNames1 );
    [ s2, fs ] = audioread( readingWavFileNames2 );
    [ s3, fs ] = audioread( readingWavFileNames3 );
    %[ s4, fs ] = audioread( readingWavFileNames4 );

    duration = length( s1 ) / fs;
    interval = duration;

    MAX_S = max( [max( abs(s1) ), max( abs(s1) ), max( abs(s1) )] );
    s1 = s1 / MAX_S;
    s2 = s2 / MAX_S;
    s3 = s3 / MAX_S;
    %s4 = s4 / max( abs(s4) );

    S = s1;
    S = S + s2;
    S = S + s3;
    %S = s1 + s2 + s3 + s4;
    %S = S / max( abs(S) );
    
    sound( S, fs );
    pause( duration + interval );
end;
