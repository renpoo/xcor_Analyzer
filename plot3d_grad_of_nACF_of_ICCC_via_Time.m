%pkg load signal;
%pkg load io;

close all;
clear;


ICCCMat = [];
timeAxis = [];
timeVec = [];


[ fname, pname ] = uigetfile( '*.csv', 'CSV DATA (ICCCMat) FILE' );
dataFileName = strcat( pname, '/', fname );
ICCCMat = dlmread( dataFileName );


tokens = strsplit(fname, ',')';
disp(tokens);
%return;


if ( strcmp( tokens{1,1}, 'nACF' ) == 1 ),
  xLabel = tokens{2,1}; 
  yLabel = tokens{2,1}; 

  labelStr = xLabel;
  strTitleBase = strcat( '[', xLabel, ']' );

  graphTitle = tokens{10,1};
else
  xLabel = tokens{3,1}; 
  yLabel = tokens{2,1}

  labelStr = strcat( yLabel, ',', xLabel );
  strTitleBase = strcat( '[', yLabel, ' <-> ', xLabel, ']' );

  graphTitle = tokens{11,1};
end;


tS0 = tokens{4,1}; 
tE0 = tokens{5,1};

  
xLabelStr = ( strcat( labelStr, ': tau [ms]') );
yLabelStr = ( 'time [s]');
zLabelStr = ( tokens{1,1} );



%[ fname, pname ] = uigetfile( '*.csv', 'CSV DATA (timeAxis) FILE' );
timeAxisFileName = strcat( pname, '/', strrep(fname, 'ICCCMat', 'timeAxis' ) );
timeAxis = dlmread( timeAxisFileName );


%[ fname, pname ] = uigetfile( '*.csv', 'CSV DATA (timeVec) FILE' );
timeVecFileName = strcat( pname, '/', strrep(fname, 'ICCCMat', 'timeVec' ) );
timeVec = dlmread( timeVecFileName );


%[ fname, pname ] = uigetfile( '*.csv', 'CSV DATA (tauICCCMat) FILE' );
tauICCCMatFileName = strcat( pname, '/', strrep(fname, 'ICCCMat', 'tauICCCMat' ) );
tauICCCMat = dlmread( tauICCCMatFileName );


%XYZ = surf( timeAxis, timeVec, ICCCMat, 'LineWidth', 0.01, 'EdgeAlpha', 0.3 );
lw = 3;
ms = 4;
lc = '-og';
XY = plot3( tauICCCMat, timeVec, -gradient( nACF_( ICCCMat ) ), lc, 'LineWidth', lw, 'MarkerSize', ms );
grid on;
axis( [ tauICCCMat(1), tauICCCMat( length(tauICCCMat)),  timeVec( 1 ), timeVec( length(timeVec) ), 0.0, 1.0 ] );

hold on;

%{
if ( flags.iccfFlag ),
    lw = 3;
    ms = 4;
    %lc = '-or';
    lc = 'or';
    plot3( tauICCCMat, timeVec, ICCCMat, lc, 'LineWidth', lw, 'MarkerSize', ms );
end;
%}

%shading interp;
%shading faceted;


%set( XYZ, 'edgecolor', [0 0 0], 'edgealpha', 0.3 );
xlabel( xLabelStr );
ylabel( yLabelStr );
zlabel( zLabelStr );


strTitle = strcat( strTitleBase, ' (' ,  num2str(tS0, '%04.2f'), '-', num2str(tE0, '%04.2f'), '), ', graphTitle);
title( strTitle );


hold off;
