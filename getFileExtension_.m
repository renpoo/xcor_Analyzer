function [ fileExt ] = getFileExtension_( filename )

[ fileStrs ] = strread( filename, '%s', 'delimiter', '.' );
fileExt = fileStrs( length( fileStrs ) );
