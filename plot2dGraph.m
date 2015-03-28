function [ outputGraphFileName ] = plot2dGraph( x, y, xLabelStr, yLabelStr, figNumber, pname, saveImageName)

figure( figNumber );
plot( x, arraySubstitute_( y, length( x ) ) );
xlabel( xLabelStr );
ylabel( yLabelStr );
title( saveImageName );
fname = strcat( yLabelStr, '_', saveImageName );
fname = strcat( fname, '.png');
outputGraphFileName = strcat( pname, '/', fname );
saveas( figNumber, strcat( outputGraphFileName ) );