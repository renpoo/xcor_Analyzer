function [ sResult1, sResult2, sResult3 ] = generateCombinationalSounds( pname, fname1, fname2 )

audFileName1 = strcat( pname, '/', fname1 );
audFileName2 = strcat( pname, '/', fname2 );

[ s1, fs1 ] = audioread( audFileName1 );
[ s2, fs2 ] = audioread( audFileName2 );


sResult1 = s1 + s2;

%sResult2 = s1 .* s2;

%sResult3 = conv( s1, s2 );
%sResult3 = sResult3( 1:ceil( length(sResult3)/2 ) ); % Cut half of convoluted sound

sound( sResult1, 44100 ); pause( 3.0 + 3.0 );

fnameConj = strcat( fname1, '_', fname2 );

audiowrite( strcat( pname, '/', 'ADD_',   fnameConj ), sResult1, fs1 );
%audiowrite( strcat( pname, '/', 'MULTI_', fnameConj ), sResult2, fs1 );
%audiowrite( strcat( pname, '/', 'CONV_',  fnameConj ), sResult3, fs1 );

