function plot_graph_( plotData, timeAxis, saveImageName, funcStr, strTitle, xLabel, yLabel, params, graphTitle, dateTime, tS, tE )

pkg load io;

#saveImageName = strcat( saveImageName, '___', num2str(tS, "%5.2f"), '-', num2str(tE, "%5.2f") );

tStart = timeAxis( 1 );
tStop  = timeAxis( length(timeAxis) );


clf ();
figure(1);

plot( timeAxis, plotData, 'b');
xlabel('tau [ms]'); ylabel(funcStr);

Xline = line( [ tStart tStop ], [0 0] );
set(Xline, 'color', [ 0.6 0.6 0.6 ]);

Yline = line( [0 0], [-1 1] );
set(Yline, 'color', [ 0.6 0.6 0.6 ]);

grid on;
axis( [ tStart, tStop, -1, 1 ], "square" );
axis ("labelxy", "tic");


for ( i = 1 : floor(numel(params)/length(params)) ),
  xS = params( i, 1 );
  xE = params( i, 2 );
  yS = params( i, 3 );
  yE = params( i, 4 );
  colR = params( i, 5 );
  colG = params( i, 6 );
  colB = params( i, 7 );

  paramLine = line( [ xS xE ], [ yS yE ] );
  set(paramLine, 'color', [colR colG colB]);
endfor;


title( strTitle );


#pname = "Output\ Images";
pname = strcat( "Output\ Images", '/', graphTitle, '_', funcStr , '_', dateTime );
#pname = strcat( "Output\ Images", '/', saveImageName, '_', funcStr , '_', dateTime );
mkdir( pname );
fname = strcat( saveImageName, '.jpg');
outputDataFileName = strcat( pname, '/', fname );
saveas( 1, strcat( outputDataFileName ) );
