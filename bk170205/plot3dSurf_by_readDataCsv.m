%pkg load signal;
%pkg load io;

resultDataMat = [];
timeAxis = [];
timeVec = [];


[ fname, pname ] = uigetfile( '*.csv', 'CSV DATA (resultDataMat) FILE' );
dataFileName = strcat( pname, '/', fname );
resultDataMat = dlmread( dataFileName );


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
  yLabel = tokens{2,1};

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
timeAxisFileName = strcat( pname, '/', strrep(fname, 'resultDataMat', 'timeAxis' ) );
timeAxis = dlmread( timeAxisFileName );


%[ fname, pname ] = uigetfile( '*.csv', 'CSV DATA (timeVec) FILE' );
timeVecFileName = strcat( pname, '/', strrep(fname, 'resultDataMat', 'timeVec' ) );
timeVec = dlmread( timeVecFileName );


XYZ = surf( timeAxis, timeVec, resultDataMat, 'FaceColor', 'interp', 'LineWidth', 0.01, 'EdgeAlpha', 0.03 );
grid on;
hold on;

if ( flags.iccfFlag ),
    ICCCMatFileName = strcat( pname, '/', strrep(fname, 'resultDataMat', 'ICCCMat' ) );
    ICCCMat = dlmread( ICCCMatFileName );

    lw = 3;
    ms = 4;
    %lc = '-ow';
    lc = 'ow';
    plot3( tauICCCMat, timeVec, ICCCMat, lc, 'LineWidth', lw, 'MarkerSize', ms );
end;

%shading interp;
%shading faceted;


%set( XYZ, 'edgecolor', [0 0 0], 'edgealpha', 0.3 );
xlabel( xLabelStr );
ylabel( yLabelStr );
zlabel( zLabelStr );


%strTitle = strcat( strTitleBase, ' (' ,  num2str(tS0, '%04.2f'), '-', num2str(tE0, '%04.2f'), '), ', graphTitle);
strTitle = strcat( '[', yLabel, ' <-> ', xLabel, ']', ' (' ,  num2str(tS0, '%04.2f'), '-', num2str(tE0, '%04.2f'), '), [T : ', num2str(time_T, '%04.2f'), ' ], ', graphTitle);
title( strTitle );


hold off;
