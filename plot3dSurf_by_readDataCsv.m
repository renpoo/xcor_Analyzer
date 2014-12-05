pkg load signal;
pkg load io;

resultDataMat = [];
timeAxis = [];
timeVec = [];


[ fname, pname ] = uigetfile( '*.csv', 'CSV DATA (resultDataMat) FILE' );
dataFileName = strcat( pname, "/", fname );
resultDataMat = dlmread( dataFileName );


tokens = strsplit(fname, ',')';
disp(tokens);
#return;


if ( strcmp( tokens{1,1}, 'nACF' ) == 1 ),
  xLabel = tokens{2,1}; 

  labelStr = xLabel;
  strTitleBase = strcat( '[', xLabel, ']' );
else
  xLabel = tokens{3,1}; 
  yLabel = tokens{2,1}

  labelStr = strcat( yLabel, ',', xLabel );
  strTitleBase = strcat( '[', yLabel, ' <-> ', xLabel, ']' );
endif;
    
xLabelStr = ( strcat( labelStr, ': tau [ms]') );
yLabelStr = ( 'time [s]');
zLabelStr = ( tokens{1,1} );



#[ fname, pname ] = uigetfile( '*.csv', 'CSV DATA (timeAxis) FILE' );
timeAxisFileName = strcat( pname, "/", strrep(fname, "resultDataMat", "timeAxis" ) );
timeAxis = dlmread( timeAxisFileName );


#[ fname, pname ] = uigetfile( '*.csv', 'CSV DATA (timeVec) FILE' );
timeVecFileName = strcat( pname, "/", strrep(fname, "resultDataMat", "timeVec" ) );
timeVec = dlmread( timeVecFileName );


XYZ = surf( timeAxis, timeVec, resultDataMat );
grid on;


#shading interp;
#shading faceted;


#set( XYZ, 'edgecolor', [0 0 0], 'edgealpha', 0.3 );
xlabel( xLabelStr );
ylabel( yLabelStr );
zlabel( zLabelStr );


strTitle = strcat( '[', yLabel, ' <-> ', xLabel, ']', ' (' ,  num2str(tS0, "%04.2f"), '-', num2str(tE0, "%04.2f"), '), ', graphTitle);
title( strTitle );
