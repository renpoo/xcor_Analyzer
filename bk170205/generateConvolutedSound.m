[ fname1, pname1 ] = uigetfile( '*.wav', 'Select 1st. Wav File' );
audFileName1 = strcat( pname1, '/', fname1 );
[ s1, fs1 ] = audioread( audFileName1 );

sound( s1, fs1 );
pause( length(s1)/fs1 + 1.0 );


[ fname2, pname2 ] = uigetfile( '*.wav', 'Select 2nd. Wav File' );
audFileName2 = strcat( pname2, '/', fname2 );
[ s2, fs2 ] = audioread( audFileName2 );

sound( s2, fs2 );
pause( length(s2)/fs2 + 1.0 );


s3 = conv(s1,s2);
s3 = s3( 1:ceil( length(s3)/2 ) ); % Cut half of convoluted sound
sound( s3, fs1 );

fnameSave = strcat( 'CONV_', fname1, '_', fname2 );
audFileNameSave = strcat( pname1, '/', fnameSave );
audiowrite( audFileNameSave, s3, fs1 );