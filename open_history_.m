function handlesFlagsdata = open_history_( openFileName, errMsg )

% Open Variable Data
pname = '_Command History';
if ( exist( pname, 'dir' ) == 0 ),
  mkdir( pname );
end;

outputDataFileName = strcat( pname, '/', openFileName );


[fid, errMsg] = fopen(outputDataFileName, 'r');
if ( fid == -1 ) disp( errMsg ); return; end;


%handles = dlmread( outputDataFileName, 'delimiter', ',', 'newline', 'pc' );
load( outputDataFileName, 'handlesFlagsdata');


% disp( handlesFlagsdata );


fclose( fid );
