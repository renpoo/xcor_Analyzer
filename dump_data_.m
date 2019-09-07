function dump_data_( x, varName, handles )

% Write Variable Data
pname = strcat( '_Output Data', '/(', handles.data.graphTitle, '),', handles.results.zLabelStr , ',', handles.results.dateTime );

if ( exist( pname, 'dir' ) == 0 )
  mkdir( pname );
end
fname = strcat( '(', handles.data.graphTitle, '),', varName, '.csv');
outputDataFileName = strcat( pname, '/', fname );


[fid, msg] = fopen(outputDataFileName, 'at');
if ( fid == -1 ), disp( msg ); return; end


dlmwrite( outputDataFileName, x, 'delimiter', ',', 'newline', 'pc' );


fclose( fid );
