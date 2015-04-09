function dump_data_(x, varName, funcStr, saveImageName, graphTitle, dateTime)

%pkg load io;

% Write Variable Data
pname = strcat( '_Output Data', '/', graphTitle, '_', funcStr , '_', dateTime );

if ( exist( pname, 'dir' ) == 0 ),
  mkdir( pname );
end;
fname = strcat( saveImageName, ',', varName, '.csv');
outputDataFileName = strcat( pname, '/', fname );


[fid, msg] = fopen(outputDataFileName, 'at');
if ( fid == -1 ) disp( msg ); return; end;


dlmwrite( outputDataFileName, x, 'delimiter', ',', 'newline', 'pc' );


fclose( fid );
