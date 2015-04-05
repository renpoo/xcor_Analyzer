%pkg load signal;
%pkg load io;

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


%XYZ = surf( timeAxis, timeVec, ICCCMat, 'LineWidth', 0.01, 'EdgeAlpha', 0.3 );
lw = 3;
ms = 4;
lc = 'ob';
XY = plot3( tauICCCMat, timeVec, nACF_( ICCCMat ), lc, 'LineWidth', lw, 'MarkerSize', ms );
grid on;
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
