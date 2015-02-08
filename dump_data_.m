function dump_data_(x, varName, funcStr, saveImageName, graphTitle, dateTime)

%pkg load io;

% Write Variable Data
%pname = '/Users/renpoo/Projects/ITOKEN.proj.1/Output\ Data';
%pname = 'Output\ Data';
%pname = strcat( 'Output\ Data', '/', graphTitle, '_', funcStr , '_', dateTime );
pname = strcat( 'Output Data', '/', graphTitle, '_', funcStr , '_', dateTime );
%pname = strcat( 'Output\ Data', '/', saveImageName, '_', funcStr , '_', dateTime );
if ( exist( pname, 'dir' ) == 0 ),
  mkdir( pname );
end;
fname = strcat( saveImageName, ',', varName, '.csv');
outputDataFileName = strcat( pname, '/', fname );


[fid, msg] = fopen(outputDataFileName, 'at');
if ( fid == -1 ) disp( msg ); return; end;


%fprintf( fid, '%s, ', varName );
%fprintf( fid, '%s', '\n' );
dlmwrite( outputDataFileName, x, 'delimiter', ',', 'newline', 'pc' );


fclose( fid );
