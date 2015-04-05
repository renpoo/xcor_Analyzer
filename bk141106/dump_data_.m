function dump_data_(x, varName, fnamePrefix)

pkg load io;

% Write Variable Data
pname = "/Users/renpoo/Projects/ITOKEN.proj.1/Output\ Data";
fname = strcat(fnamePrefix, '_', varName, '.csv');
outputDataFileName = strcat( pname, '/', fname );
disp(outputDataFileName);
#return;


[fid, msg] = fopen(outputDataFileName, "at");
if ( fid == -1 ) disp( msg ); return; endif;


#fprintf( fid, "%f, ", x );
#fprintf( fid, "%s", "\n" );
dlmwrite( outputDataFileName, x, "delimiter", ", ", "newline", "\n" )


fclose( fid );
