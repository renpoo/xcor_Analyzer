function plot_graph_( plotData, timeAxis, saveImageName, funcStr, strTitle, xLabel, yLabel, params, graphTitle, dateTime, tS0, tE0, tS, tE )

%pkg load io;

%saveImageName = strcat( saveImageName, '___', num2str(tS, '%5.2f'), '-', num2str(tE, '%5.2f') );

tStart = timeAxis( 1 );
tStop  = timeAxis( length(timeAxis) );

maxValue = max( plotData );

clf ();
figure(1);

plot( timeAxis, plotData, 'b');
xlabel('tau [ms]');
ylabel(funcStr);

Xline = line( [ tStart tStop ], [0 0] );
set(Xline, 'color', [ 0.6 0.6 0.6 ]);

Yline = line( [0 0], [-1 1] );
set(Yline, 'color', [ 0.6 0.6 0.6 ]);

grid on;
%axis( [ tStart, tStop, -maxValue, maxValue ], 'square' );
axis( [ tStart, tStop, -1.0, 1.0 ], 'square' );
%axis ('labelxy', 'tic');


lastI = floor(numel(params)/length(params));
if (lastI >= 1),
    for ( i = 1 : lastI ),
        xS = params( i, 1 );
        xE = params( i, 2 );
        yS = params( i, 3 );
        yE = params( i, 4 );
        colR = params( i, 5 );
        colG = params( i, 6 );
        colB = params( i, 7 );

        paramLine = line( [ xS xE ], [ yS yE ] );
        set(paramLine, 'color', [colR colG colB]);
    end;
end;

title( strTitle );


%pname = 'Output\ Images';
%pname = strcat( 'Output\ Images', '/', graphTitle, '_', funcStr , '_', dateTime );
pname = strcat( '_Output Images', '/', graphTitle, '_', funcStr , '_', dateTime, '_', 'tS0,', num2str(tS0, '%04.3f'), ',', 'tE0,', num2str(tE0, '%04.3f'), ',', 'T,', num2str(tStop/1000.0, '%04.3f') );
%pname = strcat( 'Output\ Images', '/', saveImageName, '_', funcStr , '_', dateTime );
if ( exist( pname, 'dir' ) == 0 ),
  mkdir( pname );
end;
fname = strcat( saveImageName, '.jpg');
outputDataFileName = strcat( pname, '/', fname );
saveas( 1, strcat( outputDataFileName ) );
