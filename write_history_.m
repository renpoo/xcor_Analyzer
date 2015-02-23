function write_history_( handlesFlagsdata, saveFileName, errMsg )

% Write Variable Data
pname = '_Command History';
if ( exist( pname, 'dir' ) == 0 ),
  mkdir( pname );
end;

outputDataFileName = strcat( pname, '/', saveFileName );


[fid, errMsg] = fopen(outputDataFileName, 'a+');
if ( fid == -1 ) disp( errMsg ); return; end;


%dlmwrite( outputDataFileName, handles, 'delimiter', ',', 'newline', 'pc' );
%save( outputDataFileName, handles, '-ascii', '-tabs' );
%xlswrite(outputDataFileName, handles );
save( outputDataFileName, 'handlesFlagsdata' );


fclose( fid );
